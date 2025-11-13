Return-Path: <netdev+bounces-238268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E1C56C36
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2E8435239B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7E2D73B5;
	Thu, 13 Nov 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZwcePGS5"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-56.consmr.mail.ne1.yahoo.com (sonic307-56.consmr.mail.ne1.yahoo.com [66.163.190.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6B29BDB0
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028461; cv=none; b=WGOYu9TXBY1inWdIXFbZBz7OzloM1Q2a3I/ii7AMrXJB8cWdfgHinh+Utv3d+sKI3+4UkRAZYu0SnUfH+HQPfPy3+vt2Xs2twRkwFT4UG4kQhkOQZ9wwesXHcG3sNTHJSMgAaUGoN4bUlaI3vpLKdYkZ3LSCwpdMZAEpsSRzFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028461; c=relaxed/simple;
	bh=yfBHkXtYZkMnrC2241QVykXVZoThQqOY+KvmC0bm+9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoV2hYRZfZ6u+MPXMTAaBLGfAWy3XXmWWX/yh+tHt3vNB8zmLBOpQoqoKoqdd0HhzvIQgNCreL4NUeRLnhsJ7pc3q3Ng3f8PrAl7MGv0hruYr3lB6USJE4IrZfhh4urNdfSpBQyGCZqZV36b8eW2KhUAf5isZ/K+B2dzyCd1oss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZwcePGS5; arc=none smtp.client-ip=66.163.190.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763028458; bh=MY75YRxq0WOxOFYKIbvygfAxaaUgS8HMYCOtfJwLLjA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZwcePGS50Il99sx7ze6t9sf7nvC9ZXM9i6D06xC5haRvjv3eSyYKP3NiAStu5tOa6ikOVUZWhPT0qdMRXZVh12Dp8WRS8FH2Y5i2WttxiP/s40JVQBLB2YWnJs9oqccsnSlrdQ0sB3nrepmatRUY9U1l5SSv9iKxehb1CfN3VQqSKmIZTK9ThDjCSm0Vp4fwgMy27wwHFbMEcC7wgdEiNRaAmIMWihv9W8+DuXtssaRO3aCBOZlhsi6znEsZk08+xcnsjAlR9p+gC+ZWS34vzwQPtWnLM8H4l2Z4BOBaAuLnwTuzfdQocub/YS/HgXtV+nInDA9qlqqM2PvW+ueb4Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763028458; bh=J1bScWPUF2K1qxto9E66zHOtraPbeuu/a0iXMvHzCOI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OwRk6QpyQnOdS/ExL7HPBHicpzQIE0jwLrKnylBmqQtpdwempq9ywqcfCoP3q/TuXSHSUAv05vbHpEVbLt02Wd5eIuoFndz/3y33JAEYxFAq8zJJeMSEVCF8FixthaMqbD38P3SVxoP9E8d5jz1mLUgbkDqczb8omVoejqQ6nXur1uIi6PAalJJZ3NlCfP47op9c2QiBuuBt2cvkpL7XsHIDlK/yPlxkwDxBueN8DmABAr/WXguQeWlHrz58DyfvQEUH+IEL/qt4MQ6FQ62PNf0CcyXZwjkNH8dGJa50PyfcyRl1SxV0D+326lg894nsTIeL0L0cNQB0zpt41B+ggA==
X-YMail-OSG: Mr_vfU8VM1mVpk_GNdCfJTpHO7u5QQQZgv5W6zxkrK4F41U.BRZsGysH1lsmGzz
 IbUEmJ3ACvUd5FCXwE_L_hOWdHJfk119XJVn6AUTe_hQbrrwbCspWDy9GiUDlx7QBifTuJMW0DCv
 ZckmvOp90pmTotb5UbH5hEsNNtORV.Kit0gifV8Rpll3VpOinQsXDmjRbbvANxi03Ka.IzlrfjGN
 RxkNTXTqgU_jd.v71sWkYf4LzqCqIgbhj9KoGT.lUqxyg989v6hW2Gfjycz3QxTIp5rnDC69WvZJ
 3MD78_gaOzHYhiOGrKVUhx1ypz35lZfbt792nA_ju1ny_QBghWySqJJ8U9N9.mXncZyJtYeNmYec
 v.JhlhO78d3VFveZO7TjmsbPZl5BrAbLhwlfzvOmY9FGDfMLDebW.r0yZkAE4FBLahQisi3taj1K
 YHzp6JumozqtJYxZPGS5XSkxkyUjRwHUmsrqnXz173QtiC2R6m.Gua3tkmYjQSu5FIc_N7.huk7j
 Jn5veLhQDSkaDQi7MMchVUONwKh710ZzZukw.PyEUwmYV0EL_wJ.reVHaLJrsU1z306oXTBjonPV
 oPyhOVH3JlBHz8ilJW3xGTQrXkd_vjQNd5a0wwQ_Fpk2IefmDZ56CFcV.uQljsbvquGEM8slTIPa
 deedBR9Mrux500iDhexwMw40DJCgBW7oJ9yMH9u5588Bv1tzChXRgRHcnZenQtBegD4F3AjqeEJm
 fHX5dvgruW6itC5qcEQifkgrmIEtP9mwjsxPZyhXnnU5RvZMCsSnTDJ9Fz9mk_sMVlBHCespOMWZ
 tQuHl.lft9mrkt1SM97_Z9rgat4QIoFwIXUoHUoHEGyuKGS.d1ngUO9xviEy7NRIjY4OuEb_Gpdn
 uyx3BtiyjtpVmmCdWDESRZiVGSQXIBdqMeOV.Ar0mPgWT8DnewIoy602Tk6k8tPBXtjWyzS553.D
 uNl5dS2h.9UdWBFFuQxTvIM.wTQFVHCObpZtOHIgIA1BMK6Zqfwm1_my6x6zz0sdVODsMpU5MF4T
 9lHWgpfxilDWYCWu_4W9GClikXSpqx7ei.UXr8Hnr5pDLzAlffldf8GKAQbOkYNoXj1IWd3r3Ch.
 ka9PjbJFTZXKgLAXASFCEdwjOUsl6vTP_8uwb.bBXlb_x3_cS6O_LjCVOk70mK0HZ4HLEzmqhaTZ
 wJk5BtnC.CBzjd5p7wbp.TiSsNTYgDzPkz3hIlv7tsyhV6mQ7ZXvqIgjOwkuDW1oGnu.0VlTLK2G
 2WusiiPsR9RHyah5TTkd5IfAU6kNzjEgl09LqF8DEdVqGSRJDoT1cTvT3QjS60tcle2Dwn0Hnz7a
 cLSI8WLn5vradstXvKSTyBisTq6z9ytvYqND.ja57EQlQvde2FPqz2U78MRyZnPa0SYO3dKnFZXe
 cinqasgbGpwdz_XZ0wpKp0STdFwoXj4usQ6S_Qtazj8gK7QnUpv4S5y9nlt2Zhf4SNnlTi3yVdoO
 r6zTJHM.PWGZ2.apfmhQGFCQuKSmWQA34OVcfiggjfkkCR4QDIWoH9v37h_FyGku_FWy5LAEIIb0
 a7cE_rf7vjggISj7HwfAIw0bZ.XbTr9YQoK1lxWp_0Hm.ZLsMIilbL13aNMsp8b4VPVIu4G44.GX
 3HykR2ktCTNHhD_2YryfyyOfiwYIfq5MdYo42RzeuhHCx26eBQ8HSbA0eeyDYK3CxDaU6xT1yHYE
 2921T.xvgBfbaF2bIFBmX0sfFou_Lle7qP._OopuzlXUCkBPV.uGSe7OABhXwYplo524nLOqARxL
 Wt7jtE9VqDG0_5sdC__CCa6IOksEY4dDcQOpd4KmwQFknkNur4W4L4Yqx_VD_SF3932r1ozWA6F5
 oPCGCQgvFCcIbMdhQWnIqPEGF0Iz761qdp5TEUvaDdLmsErhkOfcC3wfLZMuzaTuyJ6vOQdtyWun
 zpFdjY_JFDTfhu0Nb8s13mWUwQ9hSJWRwcZGGS6UZUlKoQXZP_GF0KPiXjfMGzdIZWBzU2ttgpdL
 gWOr10pip88ot5TEahkDX4zdVux9Hh844ViJPgEqm6NDmme5XpY63RDiJ0UIBwct.Z.hna4IrvA6
 zYNJ.ck3ZOzKQUMld0wAxa1GI5Q2.PbewxBlYndvZXhMMgsvcGSCP4AYLhWL_5Wj0o0DRZcyEtaE
 uH.Kpf.VEyfhxkazuQ8UxNcU4EwuOXw.YEVs-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: ee51cfc4-c65b-4680-96fe-584e72dec4fd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Nov 2025 10:07:38 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-xjb4h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c4610d66785fb1449b69e944a1a3bc0c;
          Thu, 13 Nov 2025 09:37:09 +0000 (UTC)
Message-ID: <5af3e1bd-6b20-432b-8223-9302a8f9fe44@yahoo.com>
Date: Thu, 13 Nov 2025 10:36:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/14] net: skb: use dstref for storing dst
 entry
To: Sabrina Dubroca <sd@queasysnail.net>, edumazet@google.com,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org
References: <20251112072720.5076-1-mmietus97@yahoo.com>
 <20251112072720.5076-3-mmietus97@yahoo.com> <aRS_SEUbglrR_MeX@krikkit>
Content-Language: en-US
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <aRS_SEUbglrR_MeX@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

W dniu 11/12/25 o 18:09, Sabrina Dubroca pisze:
> 2025-11-12, 08:27:08 +0100, Marek Mietus wrote:
>> Use the newly introduced dstref object for storing the dst entry
>> in skb instead of using _skb_refdst, and remove code related
>> to _skb_refdst.
> 
> This is an important change to a very core part of networking. You
> need to CC all the networking maintainers/reviewers for this series
> (ask scripts/get_maintainer.pl).

Noted for next time.

> 
>> This is mostly a cosmetic improvement. It improves readability
> 
> That rename, and the rest of the changes in this series. is causing
> some non-negligible churn and will take a while to review, to ensure
> all the conversions are correct.
> 
> @Maintainers can I get some time to look at this in detail?
> 

I figured it would require a thorough review.
Thank you for taking the time to look at it!

> 
> Also, I'm not sure how we ended up from the previous proposal ("some
> tunnels are under RCU so they don't need a reference" [1]) to this.
> 
> [1] https://lore.kernel.org/netdev/20250922110622.10368-1-mmietus97@yahoo.com/
> 

As previously discussed with Jakub [2], tunnels that use udp_tunnel_dst_lookup
add notable complexity because the returned dst could either be from
ip_route_output_key (referenced) or from the dst_cache (which I'm changing to
be noref). There are also other tunnels that follow a similar pattern.

The cleanest way to keep track of which dst is referenced and which isn't
is to borrow existing refdst concepts. This allows us to more easily track
the ref state of dst_entries in later flows to avoid unnecessarily taking
a reference. I played around with a couple implementations and this turned
out to be the most elegant. It's a big change, but it's mostly semantic.

[2] https://lore.kernel.org/netdev/20250923184856.6cce6530@kernel.org/

