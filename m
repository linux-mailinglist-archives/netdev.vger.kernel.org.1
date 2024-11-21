Return-Path: <netdev+bounces-146629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEBD9D4A4E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7101F22392
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B81C7299;
	Thu, 21 Nov 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fOnWadkt"
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-15.consmr.mail.bf2.yahoo.com (sonic314-15.consmr.mail.bf2.yahoo.com [74.6.132.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E34169AE4
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183116; cv=none; b=XXrFgu8w8KKQh0aFNW3kbXmxfv+9mF3iZhBZ+byPga51pN47P/hXnwdY91KYKn3DOBhgbJI7MkBbjxhm5RpwEz5bBVOrGFMAzbeTC9ljAbTMTX9s6qJkiFo/Rn5CS6kLzm0IN/XOaleMJvJtPBh1YgqRTHG51o0cG9D+5q/QxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183116; c=relaxed/simple;
	bh=b7l7nKCpCrPbDN4Bg22KitjSZ1D0QZ/vUZEVYOvXBmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1ZZkbLFNGhIfRWVRhIsdIayuJfMHssoclVmM7PAYiNg7n9DHkzMmtM85NFeTM1MZ8NvigwSbAkyk+/JfkmcYC5+I9kQPu5Eck97aM0MpmaEy2jKS1zF7X3m6RJi9b8w0fOEZWDmAvRHO9G+9CfYYNA9n75miQuhuBg31gUN+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fOnWadkt; arc=none smtp.client-ip=74.6.132.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732183113; bh=b7l7nKCpCrPbDN4Bg22KitjSZ1D0QZ/vUZEVYOvXBmI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fOnWadktS01YnbB1BelV5kOO9fbclRB9rkWBwD80rnA9hJFn16S1Sa3293AigK4ipxK/00ZBndkGfWMyZfy+aMQ8GCCUAQ+AGo4CUHoH5wMOvJPrD8S+YcPxRMNsPME//wqczGKeBE7WPvBNYPUjMSSRXnQ/Yy6yo/fw68rohX8tbDjwZ6rGbBFtH6ndFd19SjxX7SF0uSj5jo5+HZoBIM23quwplNswqC+qt4vxOYsj6tm1lofylmTyWRKVLzTURUHxYbTXdJ0EtYG48JIbzY4WolfcReVTUNEIrRwrUzwmYaPIhmkomAlvYdNrCifFNasR5udtKbI8bKE7v0bHsQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732183113; bh=CZLDJzxm+m2227bpHAOgIBmNHvziQ/23jfiTUrkcVwC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WzZghrN2+21hNtQ56OFbX4zwO09YggEjGKeu6EjU+lTE2V+DSHKRQR6RzvubLxMQy4NfU198Bd4IXsD8ykZR8iKDLCqQJnKbX2EAyikU1LThh6DSkO00dZUVX5kQFAbJBGA1oAUozCmQFJDnM0Jdkc5cwX74+T4WjBP7J8F1jsBUCCdHDkyz8LLEnomZHgDovbLbGICN7wisA/92EAj1wqscOalQCGqhAIu2WOCORqahrnAbkLSh93tjOXjlYKUx26lHvsbMvF0w/eZ60ahoPasqliKYlNxG34m1zbrVNxmzR0YOamfNmq+VSmgt1mZu+Lny2c82kWfnX03IR+uFDQ==
X-YMail-OSG: J3WK2qUVM1nk20hld4X.0.7gsuEnXoeE.w.a_Ly4_pDZBXZhYUjRFsYAcSPsNOI
 cTN7kcBdF79iSdLX9.EjhyPDVBap59yVgrnm4cwiv6L6ikNBc_2VvjOgdc3JE9nML0ZJ_IdXB_Dw
 H.CKV_Gm6WKS4p0b7JgcggUNXzY7IvoGVPWWLk7Ln.WED1dY3fnus61ftvPvXxy1q92R7.ghNBmG
 dU8ldGTWN57v45_gHrPhQzufecVOc5ExxwngmtZY0IXMUo9lez_mjnGutRNXTN63qsE3qjIDXDec
 5o8OEiyBVo0yTC6ToQLP6YYpt_1r4ZVI5onv_qV11z9JXgBjxp1VnIcxaH7oI2eQyDYyQX82uE5W
 o62rwEupgcPQEZ7hrg87DGNStuk1BNwaUlrf8SZu2E77v6Suoxy8bPUM820610I3sncym1vVCLhk
 JD_rpDwypLOt15zjhHZBJv.tX4WVj1v5hut8aMgogi6wHLBB3pPOC2cIktg8PGGZe16pcPZqGh_I
 S.2A_RRw7A_pT_tm1ZXGBkOQ2Z0wQIZYhzbxGb.n.BA9DhaiWXNXk1ktEPqUfi_A5fsFiFAWwdlW
 fE3F8VxfEd4bVyLuXADbo1OkNlNEMgR.HJWNLdRt5pTYiT43xcls6ViRYyR5b9F9ruuNtTLOv1FJ
 llmS9ibp7xxNJKQJ1X5uI8o13y2agkEHSqEH_wjqzxwwBM.mOM3oSkGhJz0Htz72d_fCTrvctY3X
 AWopbbAAj1YdYAIocTc3MZi0b4U2dT8YwQtkwCH69GJY84SBQFpJUMnubfPx8Ir3u1gbYhhR5zB3
 sz8FDNUUcn_vEZCIZJiBAcO1Yj7q3vJwZ0BvxwUD4aLiZvPsrNo33YqrLGWbxEl5PMoVOUvUnrSJ
 nNcRtlQk8wK21AUxEOoOWmTq8NqHKaHboe0fb8ZLaIRKtqJlZokVKotulW36JI1vlZGwztnS1sK_
 kXElLfVCoxjWmKKoldId2zUwrHHdLEj80LdA.wQnQQMU3J8q6T7g433ZHAE0l5mRN35lVM8KJDvz
 4evLsAQZjIvhdlCK.lPDLFRUjuqw2Ws7RAJMKfe7HIWV5wseSHoE_NEzlIVElNOxlujQE7cbxy.x
 kNumxvefooOGj2iRtv4VLjx4wyKgYeMhdPonwY5fl3do2gFDGRJe3GVMuH0J2K_iTj4xoXdqwdkl
 N4rq938ZFzsRSMp5wNBX3prsJpsWR_gPYIi5mI0yyWCFeMwm8pqKNlSx4sXyGX7yd6PeoJDcWEFt
 9Inv..aAETIWdgHtUBaAQsdZokYZgxBLT8QJF95lZLqoSSFrtEIyNpPmAnuq1KtqHxrh41OI5eTc
 sY6VNAxslQFpnal8oVNkzgZ60.mVWdMaqbV7wq9GwvrEd.iw2sE8CPpCoahPNc7sSHqrm07SDpmj
 B9mNH2uaREcqdZpV9DfR2w7bmQcLyE.04Mex2XTo3yqA7Yx5_w5feB3HzOOHOMe0V3mHagBwYYTv
 brsTOsjTxnaEZutILv49TAfZDDLK7Z1Ci6SkzdoMQYoV5rZM3VhiKAex7GIJckynG9BATGC.PzAh
 pW2AQ.mlOygTtbGmh75QB7NbYw6VVcbo2HQpJEHAvJp5GHE.QXC0oA17MuVGFS3YLGNNt4S1gbJ6
 x90oVl9UGd52h4RXcI83nQ5VAAh2W_KcTCUHhtgtHXCiPCy19Uebh7b_8KM9fIvsWNjGYos3REEN
 EUvkQjLBcbomF58n2zLyxCvI.ZTjPMmyJ_CINCNUYExiQnHEMSWTHQFgh5qUWwOOzvtMkp8xciSw
 ivTDz0UOq6wvj1UhMJQY.IAKLcmFODKj_UVNJIfw6cqGZMySqXgkZCANBHepckL8wd2x8L2A.aTc
 TkebaUNuFoCl.rF_fpDBSrPut2ZBjBWTb7G3IJRrPY9cDnCOZb.H7psYA9u1OSDv0Cn3heEwA5gW
 TPh6a6fKUNcrT_NAWwYHB4gG33V418BBxdNRBXsNvSLHOXmf.KHbUyZVIaR._AqltP9uXuOfWtRB
 cmY35d0zKOmTk0kuazKqpG7Z76klEAMewMj0p1D2hyMBQhYpDKVycjU3_FzwIedN4qj9rAKV20VO
 le36M3T8QhAcrGOM2glTpQnJOZRSmxXDIujRck4UQi4NxEQQ6aiteo18oSsH2.SioCFP2Wu50reo
 1qvYSD1AaWj4BlHK0tdUkBDe7KWhzu63pJXZof8pKFnExXdDauTimf7m5YVIJwMl6wGfMVzObl40
 7CqXYAeM4lTCb8ltsyawgdi290NuMfI7WUWJUYgEHdectGgJM_4S9UNl9X7OD53r.k9m9
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 73451423-cba5-4e20-884e-d11de9cbabc9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Thu, 21 Nov 2024 09:58:33 +0000
Received: by hermes--production-ne1-bfc75c9cd-qll9j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5d2e0c7db9337a20336fd9e7830c1670;
          Thu, 21 Nov 2024 09:38:14 +0000 (UTC)
Message-ID: <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
Date: Thu, 21 Nov 2024 03:22:57 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Marc Zyngier <maz@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
 <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 11/21/24 02:55, Paolo Abeni wrote:
>
> On 11/18/24 00:48, dullfire@yahoo.com wrote:
>> From: Jonathan Currier <dullfire@yahoo.com>
>>
>> Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
>> introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
>> ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
>> chips, the niu module, will cause an error and/or fatal trap if any MSIX
>> table entry is read before the corresponding ENTRY_DATA field is written
>> to. This patch adds an optional early writel() in msix_prepare_msi_desc().
> Why the issue can't be addressed into the relevant device driver? It
> looks like an H/W bug, a driver specific fix looks IMHO more fitting.
I considered this approach, and thus asked about it in the mailing lists here:
https://lore.kernel.org/sparclinux/7de14cca-e2fa-49f7-b83e-5f8322cc9e56@yahoo.com/T/
It sounds like you are suggesting approach 1 (add the MSIX register writes to niu).
I did do a quick and dirty test of that. However it ended up requiring
msix_map_region(), and pci_msix_desc_addr(), both of are internal to the
msi code, and not exported or in pubic headers. The msix_table_size()
macro was also needed. I could either export those functions, or reproduce
their code in the niu driver. However, as Thomas' suggestion seemed very
simple and elegant to me, I decided to got with it.

If it is actually preferable to either copy those msix functions into niu,
they are not very large, or export them (GPL I would assume?) let me know
and I can make that change.
>
> A cross subsystem series, like this one, gives some extra complication
> to maintainers.
>
> Thanks,
>
> Paolo

Sincerely,
Jonathan Currier

