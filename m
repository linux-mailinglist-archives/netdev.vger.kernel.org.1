Return-Path: <netdev+bounces-102333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC35902771
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC5DB2C935
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697E152179;
	Mon, 10 Jun 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Stmc5snH"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B694152170
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038414; cv=none; b=SMGaIYB4XgHUVL+BVk5NQ73xJUkYn4+eHXGkFTkEI89pitGwKJdnRbiEWrieW/DBgOmembynAW8lcHQskiPGs6ImrJHuXkLbZ+9HHX0OPemQqIihrUygqwqNV1IsPKiwzKxkDjcH0xpzN8uwTzFr/RnIQQINSwTe01QAJ6KPtf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038414; c=relaxed/simple;
	bh=2sDljUqx7BMZwRr2HPtgbGcAMzqMw0fbMhCG9tbc+SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMrkEpOmkAvCzbU4Qr4Oo4vJQFUJEE1oSrqXT3cT1nBNlBR3SM7LJQdngcUdUTgkV8Ptz0x9wgmUbxIrBd4clHNdtWG7h8/s/zSQ8SR2enVMQy5pK53fmoEUZQzgFbZEVCpVvqLEB5XsoPMeeefiScTY8MwfFaKPa9af4abj7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Stmc5snH; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718038406; bh=2sDljUqx7BMZwRr2HPtgbGcAMzqMw0fbMhCG9tbc+SM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Stmc5snH+oHwbddgBke4uJRdUf0sO0S9a0VgoBA+AJ1qyQ1junjlxJuK0+sWSjTv3uwXcS5iU370dVNoK8R99zNqpgvjPYYk4DybW6t7yBIzchPA91UBnLCNa+bz48ykD1LbJ3J1/zVZj/loUG7TawcJ2g8Wp8b5KrlkKomiKf/7SZKnnfGpsazOyUIDW2BAgUQo7qJCxMPdP0qb9HNIWatcJjztnjCWrtY8a9ytxFwmkoXl183vbL/Ex6PpTXWF5NxCbicyUal3sWkFrTG0JITn62GtlcrG8gaeq+Lbv/n+eWPv6oKIBoSuTEVaWvx0HMMNiB8bOBHcpDKVLmHIbQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718038406; bh=Dqc07a4wf2jcqjCoappO+ZnSGu9JxpryTnaW8SaEUEM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=q83veGDWyWDkNLHiS4t9zhTXObZJ3Hj2GtnaSWi79AWZcApU18ruC99oiGT1oia9QqZd7+8NTZO0t6bRQYXBYoxDTKQ2XLakEzZAhBoVqKrdPkV5FBs5zq8Gx8+54htb6aTz8eV5Avm0i6VKvAyGgyxHhE1pXTTQ0gWujfKXOG5Ou++Hy/CdWAZr1OQhVcDLn+UVf47SbFXIcpmf/lJE+1Z8iaMEQBajgc7cbKe3aTOGMiZpJ5PEnbuB696K2UC6dWI9xVoPdnyvIOmqL12HcYuXK1DsV4jeoijf+fnjpzS5oUf5glF06fgmPiwGUYUSQtpRrMQxAs84Ff+BjEEutg==
X-YMail-OSG: GN3C3lMVM1kJOS2WQy1t1sYapc4g6hP7COlcDfQEeH5LB0z8.HBrmhAxXihZEhz
 eMUiMlyFlqCp4hoQK1X04Tz4czzznkwnWZif6evTgOY6hRInp7rqpcMLVltAEryqsy31cC0T0IvF
 kfG86YXxLy8bLOFcSiT9oHinnvAwihzvtjVr9VL7WCa344aCsj_MDuGBhLWZzLXrxPQ3MS_SIgo3
 4kQNMoWRDBdHEfVfBqa1QWidL_VG_NcAuhIINHiaVfz0MdSD4KagUyKDuu7ogT.XC0bM98YO6eX3
 GdL1n0s9PpACtl8jQCu6YMpVP.WI90dsp6dXnKCGeC3i4YidtxAUta0xLSOhXPPSnanZIlEfUhCy
 JXEApgloC_jLeVUe47pCenFKS0CTlZ1aswSJxA5etx5i259qf81H.qy14O5QtkT9TvlWryvDIoqz
 YmeNXq.z5fc0jRkKxRrCFt1vSwYqmDqhqugS6CMercn7jFXO0RBzNgmyeM4l5z1H_yOy8.NgfOJS
 9AXxPSsIyBybgGLikJ2O_R0SGVE_A3_vuIBL22QQQU2xtOww2DVurp8HEOtjVnDIvpkHdD1is44h
 FTtE8Swb22Bt60z59nO7T.3.cC7_mvvsyfAXB9VT3t8uIRAHM0Ki7BOSDFPWveximXslhN2sJrDT
 9BGycWU8SClpKMzHzewuLgX.2NHekOM47j_yp6MCq0WC6aqXMz3lNppjoI4Q7I.rvYaLZicZFxOE
 k5Ao7h_ADfHKqBz0a9P1s2WhdK1BHuqX_8jIkBqoiSm.TjKa1iYx20TJchvkYraMCo7ePJYgVWrd
 zj1Vf.fFThiJXtDZ5DVFtPtD278V3533doSb0NsP8R1Wb2s14rh7bTCwxOo65xsuT7NsrI5DhQZa
 t0QsfhG3.XCLfgvmwW4iui2S.jqZMJgkT0L_pQzhI0eHyWOucjmpq.X558Isq.hQK5ItGG_DENdl
 EHcGiwRTo5b5NyTb1sS3cQN0hBvYMn9L7Qn0PttJJ644UyIPBPGoMEvjG353kJ2gzoWzHYcAxOt.
 PJ9IiOFf0sMgL09YkBBo5Ew2trbkUzU9z8b0kxpJPlsd8rG3j.Iou3_68McSdm2K91oODvYqQXVm
 JwXRVL7OOL7.W.l8e9kGQBvryOp6Dupvx6r1VQPqDo6QQfr4SKz3koN9NYaFmv9bnulMM3b4P9lx
 5BSKPgYXCe03rq2wZaPxg0ZnY7i0mfa0W8M4jV7amGvc4c67nTVXodCMjGt2LobsKHGq1v6S.Ygj
 2yBuawhuKtGf90dzZQwVhmzsjWA44KohT0pfbrPNc2nj7.dtFy9FTgPOxwhrCRr5LhnGdDLBbtyU
 ox7VjoLOcUE2OgC9CBIlLVvx11ZUJ6b8lH.vVt3CdG1BN5lfM.aksfUIasiLWiEKEXL2raoCXilx
 3y5ahKV9yum20YiMMNXJjw_IIR.2Okv7igo9xZTqaHjP3H4wRm2sNpq.7c_cszayUPzCmR3Hx5AO
 ToVUuYj.Yf751Inji3fK7IzYF8pVsnotNE.01oX7g6WIr03Szb01F3AbfW4O2xvWPAFl1mWvqGBb
 rldEbw21xAQAsjvP54ICMqZHOSTaWHzVq3dLlSuWxXYEQy8bEm7GBtw0TxfuW4IOy9uMUcZxzAU5
 UA0agkIOTLOerYUmfzlh78G7wqnOLSWyx7y8dQuXApq9BS2Q5s2eR9B69zbZUs_m27svjLS_ckV4
 6cN7CSoBc.0_As_jjexZmHfQbvcdC.EZgr_FPGvW618jKU2o7fFel15QdKaMpL3P6dXvrMcXF9z.
 iRu8yTfy5ZKWokxJAmNBGUDTQvRTQU2EaFx9grsgI2pActEKTV3hVmsd7_yiA7E6pf_ColZaWc7b
 MParv1pz.oYlmOFXBVWtfG4PZyNPYjew5UNyMIotz8ULi3YHR85MAPhgyZEhTZnMyoWMOFuB.9SB
 vg7EeMnl9666ApqHYolvPLyxRtY1o4aDIwaEbhzq0eCdIZ6Dnjvlv0e0Rq9AxF8BlKfBJuG4AJK7
 qb6c_adOL2DKehFReUh9uIQegDm3hRPnb_RXAGvIH_GKaOiIrw7yBsXrwS.yIDwvuSYUm4F1qdJB
 X18tVwKuRLT7HGii9bbQXkT8V5sAhwg0igxVv_3CPJ.UdZ8.UOOhGPL1cwULE6cOk7UOKJLPPUL2
 yOWlF_d4Oe4Ol37AkGGLneeMw5CbxrDTMA0RgL3UAn_iPKdc1xqhWDmKLDH27l7YwpUbn6UQttlD
 3zyUWyYbpm7VW2czyP4SK.eCMYCwd5wcoVLKsiLYHV6PO5u6pd8orc5ACuOt0IHCreykWjzkW
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ab3ff22a-9973-4a29-9e73-a9250002a8b8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 10 Jun 2024 16:53:26 +0000
Received: by hermes--production-gq1-59c575df44-n6ttj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0b7865191f3c2f3a0ddea3bbdd342cfe;
          Mon, 10 Jun 2024 16:53:22 +0000 (UTC)
Message-ID: <2812aeed-ab49-492b-8c93-c553c2a02775@schaufler-ca.com>
Date: Mon, 10 Jun 2024 09:53:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240607160753.1787105-1-omosnace@redhat.com>
 <b764863b-6111-45ee-8364-66a4ca7e5d59@schaufler-ca.com>
 <CAFqZXNumv+NNZjR4KSD-U7pDXszn1YwZoKwfYO2GxvHpaUnQHA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAFqZXNumv+NNZjR4KSD-U7pDXszn1YwZoKwfYO2GxvHpaUnQHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/10/2024 8:14 AM, Ondrej Mosnacek wrote:
> On Fri, Jun 7, 2024 at 8:50 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 6/7/2024 9:07 AM, Ondrej Mosnacek wrote:
>>> This series aims to improve cipso_v4_skbuff_delattr() to fully
>>> remove the CIPSO options instead of just clearing them with NOPs.
>>> That is implemented in the second patch, while the first patch is
>>> a bugfix for cipso_v4_delopt() that the second patch depends on.
>>>
>>> Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
>>> https://src.fedoraproject.org/tests/selinux/pull-request/488
>> Smack also uses CIPSO. The Smack testsuite is:
>> https://github.com/smack-team/smack-testsuite.git
> I tried to run it now, but 6 out of 114 tests fail for me already on
> the baseline kernel (I tried with the v6.9 tag from mainline). The
> output is not very verbose, so I'm not sure what is actually failing
> and if it's caused by something on my side... With my patches applied,
> the number of failed tests was the same, though, so there is no
> evidence of a regression, at least.

I assume you didn't select CONFIG_SECURITY_SMACK_NETFILTER, which
impacts some of the IPv6 test case. Thank you for running the tests.

>

