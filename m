Return-Path: <netdev+bounces-239106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87DAC63EF1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 12:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A973A4E5B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A4F328B68;
	Mon, 17 Nov 2025 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ua7EF2UV"
X-Original-To: netdev@vger.kernel.org
Received: from sonic305-20.consmr.mail.ne1.yahoo.com (sonic305-20.consmr.mail.ne1.yahoo.com [66.163.185.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADB24169F
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380286; cv=none; b=YAzcUEeRYJMe5grV9eyf0X/ZrFbdFdjVW2QY21oA1ksWFdYNMaYe9RJNC16Hia+IEvxsqQ/0ugbDqOSvxochdkdca+BeaptK0JsoWauktztjaKqX5P/ho5G+s2VU2Kcx1XCvClSiidUQB1h1xDzoPEukmy78kloZ7Tt7HagWmuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380286; c=relaxed/simple;
	bh=/WUHdRQodpj86CCo0OeYs2AhSUdEyxyMr5neyZ0MmL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuUmxXSV1ny+hWCQbaJKtjVmCetOj86jztKcw2IdrdmZ3fbJbrsw4tvmzOsb+ZbhRTg+wpnQdPwSuwJq5ojFmhYfEQNlQtKy+5z6RwikR1sxZn2P2/CcQIK5ecGsBBHwttynJdw4A9h0OVNGVpNGC/M2h31tq9k5l/wWthDFVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ua7EF2UV; arc=none smtp.client-ip=66.163.185.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763380284; bh=GELvACo1tkiW+N4Xdx8cldnc6GFh0Mi59dIg9K0Mzk4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ua7EF2UVqj6GYDfyPQ2a3kYAaCtMzwlFMiP4ZPNyks6Xn1Gi/N3bTyuOxjYyzu9cIZ3ueX7HF/Wyv5UQnQ9wKSuMwru5hnpTZNhDoCICXnA7tpHEJCrPNHDY+p029XILOcOO+0ju93LkndWX79UKauazKdQNpLPllY99/YvpTkyd5NLV53P3hsy3ZvUG6L9EQdOiW7f3fB/SmezHW+FhJoAv+yF9sj7P+n0s/LprhWJMpU/0mYhhVXYrM+Vq2Docyh7uP1UMgRgnPOj3U4maVunnQ8+LPTKPlrMplk21XnqLv5jf2Ustsovfc2YR0v13IlRd+jaCrB4Y4t6lLAxd6g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763380284; bh=BHAoW772i33wGlzqGr4EZUTClljn3PwzJl1cXnUIqj8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=llUyDCrYzRj7O0DPUql/lI+FQS++SmKB8psm6M4153QNoohphTjabGAvFq2NuCnaebuBqBGsa64842JzG25VHqTulpmxLCtAuaRGqKa0fJTbeOAelyP5mSOgBy0loeYES3324JykyBppEezECi9SZKiUnNUVqKHH4zVyg7Ozip3b5zIqNhziFD9NvqmwLfnK3mCAweYHHMmitkb78f3Ktl6tnl2V3y2r3L4sQwsBltismF0WKRZoRvPYrMKvT54F9VFeEbMZJhNmumf8uZ7jT9oI3ZYMB/hG6L5oDI1mIj9FCGzFyWscL1fyq91d4mKg8oEu7ayGkfTnTGxrjx6fog==
X-YMail-OSG: p6rDLEIVM1nDdjMwC6pK0hfb0eSppDBPzfYEh_s_oOgUrj18Ewz6V0IIZRjp5M5
 DZ9Eg1FD1O7d1fAPmhw1s7fsNmuXGff95ZHmXUbavE40tk_FrRb_LP8u2R8wsQ.pb02Osn.5S8yh
 8BvLnS2Lt7je9r49HcC5HzTRzNlEaKwUazZtx8pL7c4.OB5ScsHswY9RlfVAmQb7UVqNW0Dox1dv
 LAD7Og_e66UE22y8in1ZOKcR6BRI5Qn3QRHEm.hupgDWTgY8vwW8DAMDJMxmLROs5cI5KWZFgeoD
 MN.xuyTJtQQi_UmQda7HDLqRyowyj0VEvlrtZBqQlkQbqMMGm_Dhct24h5cjnsvXbLFTz5oYnFuY
 DsTzA4b82lVFX5f.r2h_cwaw1Od.LxCv6uleuuRCXl1clFQ3jwMrYRK_3XWrYplM5JZ27pKDwVa.
 qYfWkpyifv_bcOo6HOy0UcFsAU6FJwh.VU6Y1DLtxxWkUTnIzYPqyFX4.X6N1CvL3EIsNvZdM83v
 KVk6TcVY6gZTFrv6s5p0yskl1e8KDMTRpEWWvbExq5TCi53hInxKwRtCH.hkRcj0Ag2iIRehZyT3
 mmWH01BW2.6SDcjajOFCrbI2U6s2S53lo9TPcFFunjXsx7kktM6jus9hZFqad3Mgg4P.IfV8TkSq
 BEkgyGYjIwFV3z443G9mpacOMUXzTwuyDO8fHIs4IkPvv1M6W.DgWCfnQ_eIvvWLGkrcUMflxtu.
 tvutEVeu9gL7GjlTOgxSAeBS3VQeRIgpV9OKEOj2ZkoNY0v_1Em0gg0yiA0e3v.PqDUlXuiGr8wg
 YLqhgffQSvnjIVkVF8SO2zER.tF2OuTTvbSk69t57yjfKRs_g1hq2OpjB_Q5_GgVu_DdNOmakOTW
 S.t7ifDp8NELd6XDeIR7AqBm4LzhhiOBnkYzjYYP0jCNBkhb19hR.UXNHCvWLBbgvFBAik6Bg9Fu
 Uv90PP3cNmFc1UOFSAnpT8oRkO27JzUkhrKOdv0MM8saFTfzsuguujHlLwz.Uy2QBiyX6doAqwub
 AOHpU0_ZpAGjK7auHamiRwLvoKiMftpX7N5D1xecmcJyNFW48FTXI.OB2q7B91NMPA.Wr9Ei8tFp
 Tq0CQ0W6wawv.waDIo2DUZ5q2v.CL3muAmcoyGUCuAQ65GZyD0Z4XXWYsaYt5AjaTkjOxAz7htdK
 Mlo0clxs.eUcwNV0W7x3TTDoW0QElcj9lp7zL2OvYywnYU39lfjHtv_uut5Cg60QE2Qgz_tmkljP
 eTleLncvJiWG0r034J8ZaRf2J7eguq7HaqObWvTM989CLkxLO0K6wNwUn.gq_JosZ5hv0WAqYmkR
 oFT2cF_MdtBsvRnvQyQKKROfngp6PYIWHEqx6PwKXSdD3WMHf5815D4.DvEzJ_rUy.KVOB9qf23s
 tzC8kQFKyuvKzaQcGQNML9N7lT5J0rZQlJOxCmie1o3ejP1SAK.mjOuMuJL5pbN7PsWlqSHRPxZz
 AzbZZVDD8e1ekGnLyMGw25MSM7Buj6Qg1yZDKMb8fmYT77NxAHkYgwbkGkLkmi.an7yatH0Mmrm_
 QpZi7qykRQRijjlz.Bh6sDNbSyk6N5THOHQehwtctWaPW7_c3Dfh0sORtwuiJ3kbBNAChVIQLJEk
 .6vEeq1xqeVqvLq3r6acRNHM55MtoHB7B.MC5zAEYuEkHPOp8YDMGozC0_YxGe.fM5eG0AYQnocS
 6gMOHi3QqaOsoVb2Ym50YLIZtxRM8Nl8VW4rshdwxzZmHOOS70mlsbA85ZUDxh_Kx5esa2koRVDn
 DIaC0HPV_f3CpbX1lySS9pOaaElqeX.Fx8_SudHiUcLAg4NIltM6WQsQjGXXtkNcnm3hP7zCKYmx
 sRlaioqsRrG28ku6RZEXnIWxtSggzD.YVERPp.4Z6APzzRknNJvSvVM93RyjO28hKM_2c7msvHxV
 mva5ZI9mBbo1Ri6Y83.c7VUZzdAt7bl9QaunpjotSI8Yp5u9grpMR581iBn02g9Mui0zYoSf3ZLo
 7DkoFq_RETSR0jfXLm5azhhQVUEcBq2smwsTbQCmzYDaf2oX4SidGu3USwBV6.rfhyyUIWfs9ITW
 gQIWH1gHwVvri7FeBjkQF1u3iQ_YKTvCIJakNgLkyyvqtd3seWsmiEwaGnxDmvAP.Wc6p28Cz0mT
 FnNkrdqj5omRMB.05fCaXXcvWv8Q-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 997ffb10-dd23-4c38-b603-418e2e199767
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 17 Nov 2025 11:51:24 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-zwzps (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ad4d1dd8edd9dcc9f081b91f969eda15;
          Mon, 17 Nov 2025 11:31:08 +0000 (UTC)
Message-ID: <39fbfcb8-20a4-4693-af24-ea59a726bbec@yahoo.com>
Date: Mon, 17 Nov 2025 12:31:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/14] net: skb: use dstref for storing dst
 entry
To: Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
References: <20251112072720.5076-1-mmietus97@yahoo.com>
 <20251112072720.5076-3-mmietus97@yahoo.com> <aRS_SEUbglrR_MeX@krikkit>
 <5af3e1bd-6b20-432b-8223-9302a8f9fe44@yahoo.com>
 <CANn89i+qce6WJYUpjH93SMRKA8cQ6Wt-b81O6gu9V5GGnDeo_A@mail.gmail.com>
 <aRYgtN-nToS4MQ3r@krikkit>
Content-Language: en-US
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <aRYgtN-nToS4MQ3r@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Dear Eric and Sabrina, I'm replying to both of you here.

W dniu 11/13/25 o 19:17, Sabrina Dubroca pisze:
> Eric, it seems your email didn't make it to netdev, quoting:
> 
> 2025-11-13, 02:38:02 -0800, Eric Dumazet wrote:
>> On Thu, Nov 13, 2025 at 1:37 AM Marek Mietus <mmietus97@yahoo.com> wrote:
>>
>>> W dniu 11/12/25 o 18:09, Sabrina Dubroca pisze:
>>>> 2025-11-12, 08:27:08 +0100, Marek Mietus wrote:
>>>>> Use the newly introduced dstref object for storing the dst entry
>>>>> in skb instead of using _skb_refdst, and remove code related
>>>>> to _skb_refdst.
>>>>
>>>> This is an important change to a very core part of networking. You
>>>> need to CC all the networking maintainers/reviewers for this series
>>>> (ask scripts/get_maintainer.pl).
>>>
>>> Noted for next time.
>>>
>>>>
>>>>> This is mostly a cosmetic improvement. It improves readability
>>>>
>>>> That rename, and the rest of the changes in this series. is causing
>>>> some non-negligible churn and will take a while to review, to ensure
>>>> all the conversions are correct.
>>>>
>>>> @Maintainers can I get some time to look at this in detail?
>>>>
>>>
>>> I figured it would require a thorough review.
>>> Thank you for taking the time to look at it!
>>>
>>>>
>>>> Also, I'm not sure how we ended up from the previous proposal ("some
>>>> tunnels are under RCU so they don't need a reference" [1]) to this.
>>>>
>>>> [1]
>>> https://lore.kernel.org/netdev/20250922110622.10368-1-mmietus97@yahoo.com/
>>>>
>>>
>>> As previously discussed with Jakub [2], tunnels that use
>>> udp_tunnel_dst_lookup
>>> add notable complexity because the returned dst could either be from
>>> ip_route_output_key (referenced) or from the dst_cache (which I'm changing
>>> to
>>> be noref). There are also other tunnels that follow a similar pattern.
> 
> But IMO Jakub's comment about technical debt is not addressed by
> pushing dstref all over the tunnel code.
> 
> 

I understood it differently. I thought the aforementioned debt referred
to maintaining two different APIs that accomplish the same result, which
is why I took the time to replace all callers in all of the tunnels to use
the new API, and removed the old API. Maybe Jakub can clarify.

>>> The cleanest way to keep track of which dst is referenced and which isn't
>>> is to borrow existing refdst concepts. This allows us to more easily track
>>> the ref state of dst_entries in later flows to avoid unnecessarily taking
>>> a reference. I played around with a couple implementations and this turned
>>> out to be the most elegant. It's a big change, but it's mostly semantic.
>>>
>>> [2] https://lore.kernel.org/netdev/20250923184856.6cce6530@kernel.org/
>>
>>
>> I have not seen the series, so I had to go to the archives.
>>
>> Too much code churn for my taste, and a true nightmare for future backports
>> to stable kernels.
>>
>> Unless I am mistaken, this is your first submission to the linux kernel,
>> please start with more manageable patches.
> 

You are correct. This is my first submission. Initially, this series was much
smaller, but that changed due to the generous feedback from Sabrina, Jakub and
Paolo. I tried to make this series smaller, but that ended up in code duplication
between tunnels and some spaghetti code. I did spend quite some time on this new
version, so I'd love to hear your suggestions / feedback if you have any, as I'd
like to continue working on this feature.

