Return-Path: <netdev+bounces-305145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DoPwCAPeS2rQbgEAu9opvQ
	(envelope-from <netdev+bounces-305145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:55:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28C7138ED
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:55:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="UF1ei/d5";
	dmarc=pass (policy=reject) header.from=meta.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305145-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305145-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F5383091EAC
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890CE3BE644;
	Mon,  6 Jul 2026 16:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44073AE1A2
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:32:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355560; cv=fail; b=nfvdQ/ZuYx5yYrfQT+N3KvGd/Fa1ZRLGqO773jwXj7UPFghLa3sKaJKuE128iaqvm3nkgOYLScKNHTxWCu8oysr+NkK3YTrYS51N+E2YtxpiN+4WOgaYljgKsIZX8p6DkDfdiPWYG+9G+rtXSU2h/yadMf3xEIbt95la6PTGNBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355560; c=relaxed/simple;
	bh=mx5uHltUsYhLsqOWutvshPPHLEmekZ74cMuJoihq6Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3wIJS2oBEynSE3yQSY3RKf2QU4LdpcowXmDSMzC6KxW8lfKS0fKMwQC0K9zXfiijshWglMaCOH3NJu2srRwZsh3PNvxNvz/a3cIjO/6hrHsoQG+6ZKNsyE0acalFsUHNCZw2MRNSK8ElR4j6jTYDIIR+0askq3Cxel0fAQYM+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UF1ei/d5; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIOs32267092
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 09:32:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=HrrgiS/Iwzmva1t6y7T/dPTBmDKM6tt/EjjvI+7SCB8=; b=UF1ei/d5zJrC
	/my7dJTSu7IMTd5nLKpLDnKBkuq86wxUZl/Hs3z+hGeIOtrORNGLp9tlfz7lQ/mY
	D7cmi2+uqvh1N6H/h1l5O9UB+FLTikvYOBgVJvp5eXj5Sdu9ZdBFgn+r8SdfFJGN
	Uh5p6IoMCl24MMKyoP3il2xM1hQiESs/YCF+kwGKlWStO32+QJKqhLzo/Ls2IGTl
	BT+cxdBKg0PwzO+BnV4IUIvPIhpLJ+0SPXZn3Xv46/1VsyGvH3Yl8J1z+MFwiWbF
	zJikz67lfL7QwN3UWrARhE5D+twMv4Y8yPDy9vh6wCFkcyRjRPnnIsnOzSgFQPRe
	gWmaxD5Hqw==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f7ktef5w6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:32:37 -0700 (PDT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c12823d7822so284170166b.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355556; cv=none;
        d=google.com; s=arc-20260327;
        b=N73zNuqBTlG93QzQsiKahgEADhD1H9LuFPWemN1SJWO2pAELbLZF7RDsqco7gBkPnb
         jUejvIVM+oKRKF66OzirUEUwMsdLzfJA3LHIkLwBGoe1KBfd25MDOPXPOB7R/wzKM1Xu
         NCGImUAPVOvAKqYaDDMMWdzGqVVhUjNL1qCG6YNYLTeN8LrmDGhx/KxFi4w7YirfhWFJ
         rGRIoJcupfiesKBay9ec8TpWh/TZFm/BV/l4VO4L+saFC+EsxhRZC71ah+cL34cg+h0T
         GoNb9lw3ppZPftspMQde3XM1zy+ZRaxmcU0g6bwaQDbSehF3ZFEAJTboz3xGe957EwLZ
         cG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=bxaOyXTy6hvg43xYt7od4VQd2vhEtCKi28zKpX6o0fU=;
        fh=7hCpBLDrNUMNAz7dOXxtr+VbJBHrmv6oJr4ewbPJGxU=;
        b=Z2QiC7Eykjkd42UJFcjPLlPuLTqnTf6F9OQZfLJfNmPujF8PbT4GIsvaYvZRQkaDQk
         5WBO1U2q+SrUTDmC+bocnvJ24HOTnmOFqz4+lFhh31FbJdmpCvpP01syWbnyXD4GddZS
         WoM516SutS4tu5pmGo9Dkkj4FfH+XtMERDU/RioqJ0xHnjbdxC6iliCPNVn3INs737Fg
         67OsQaIhwzmh6FQrv0XCX/KCSv67s3nvoreR4DCWdv2Xpwi1A1eDLo9Ps01DV2S0cvVK
         n5Td60gauEIwpYJf6VAHUKDNdTcEyr07Y2tzigt6z5Vzm0TdbqtoWUh6yU88Rn78gZbA
         s3jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355556; x=1783960356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bxaOyXTy6hvg43xYt7od4VQd2vhEtCKi28zKpX6o0fU=;
        b=a8kadkXibT8m3v3HTmqBd9CMWXo5YTIIu7uDDDvw6cwyZiwfzKl/pmorqvbD4BK4BW
         FfAFJvW9LboriKp04N1s3YzdLEHE4sv3eZG7DXg296y5ZcxbLXewqrPf/X5+69qkjGUx
         gO99qJYnm8so6NRqg04MScezVUn8jarQaS71Cia0/KlndrZVMZ2pCvJqkJZTWBEji7Zk
         ZU1IhST/GHg3NW83XYkNI9pXVNLsRjNNujQpnLUlr9Fnd/4V9aqSJ7tQCtPc8G4FEQ+C
         g2yiT8fPnEifbdvNHgwIG0pZ8yfWmBHMkvHHztqI6xKVtqSTvkSP4XC+ZjgCllrP7EBW
         5UiA==
X-Forwarded-Encrypted: i=1; AHgh+RqdApvG3Pvbpo3ilaspXwSenWiRKExnSJWiIBJfjGqwWXyHpC0b976dEjVZoGsLML15MJu5z+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFWBa2xfJnhs2f4YYEydULxnhgwSvPbXUhwP3yb31jzkqw2Ly
	8/2yUUQ+C2poSE8eVpPB5TT7Lbxy5FiyjZZqfMMOKmCjp5r8id0b3YDBuoRsx7Vrs9s7oGdB8GI
	O5WZ4g5kzfyjII+BNpYEncBTOqqBKALVtdCecOpIhCt9T0k4MC9SarUsQk+gfXN7urYr2f9xXw4
	NNqaVS5ZBlVtIlDNOD4UlsnoVT7u152A==
X-Gm-Gg: AfdE7cl9EwtFqR6/b9IvbFpJqHw8rNTRLSPq1HVrKgO+57tQGbDwtomZXul3C7p6KnK
	4JsDCCOZgbJkacwrQ3Lx/W9FkTrWYjUkqRaOgi2dAHWf+OCsZi5JDfGBSHGLCYRZeUYYGk+/gD4
	l0c+AQTJnvgDWMpPLPu3J0KV5QODOJXdFLnHmtxGskMlPkJsOSwkqeAnVz0tDspvO4jIK6wbgs6
	yWCChY=
X-Received: by 2002:a17:906:9c90:b0:c12:5c08:279 with SMTP id a640c23a62f3a-c15a67dd064mr67175366b.1.1783355556231;
        Mon, 06 Jul 2026 09:32:36 -0700 (PDT)
X-Received: by 2002:a17:906:9c90:b0:c12:5c08:279 with SMTP id
 a640c23a62f3a-c15a67dd064mr67172466b.1.1783355555766; Mon, 06 Jul 2026
 09:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703112431.2860506-1-kiran.kella@broadcom.com> <c2f1e433-99bf-4712-a31b-6b2360f8fb6e@gmail.com>
In-Reply-To: <c2f1e433-99bf-4712-a31b-6b2360f8fb6e@gmail.com>
From: Wei Wang <weibunny@meta.com>
Date: Mon, 6 Jul 2026 09:32:24 -0700
X-Gm-Features: AVVi8CctXqCTaMq07-RhsB0smUl7VLvs-J78KWdZTmzMN6obyG7Vm7tlo9JgPzM
Message-ID: <CADe0Y=uumdvc_mq1JWfUK6yVc_WBQrRH_m33W7YuyBQws-QbKA@mail.gmail.com>
Subject: Re: [PATCH net] psp: fix NULL genl_sock deref race with concurrent
 netns teardown
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Kiran Kella <kiran.kella@broadcom.com>, kuba@kernel.org,
        willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        weibunny@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
        akhilesh.samineni@broadcom.com, Vikas Gupta <vikas.gupta@broadcom.com>,
        Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=UdJhjqSN c=1 sm=1 tr=0 ts=6a4bd8a5 cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=FOH2dFAWAAAA:8 a=HMZOYdunbeZyl6sIA9IA:9
 a=QEXdDO2ut3YA:10 a=PsfoTyiJ_72bb7xyA04f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2OCBTYWx0ZWRfX4kpF68o/xsMn
 SNJX5C26EO+2SueVEWBjVK83zdYLYBDHuLwSZamfkw9VxdIYzXQvSg4+7HWPp0C8UALN0FWDjM7
 k8JMu15cQiaT82DMaI10hPFuQaAQCwhbwE5GdghgMArubnh/12Urw0PZBkXfcZ9i12xWfC4Y5LX
 PThCpdc7fj29jwW/F8aNBLikMJMUwicH0lT8/JmuSHBQ1bmWsNNyvKGDM/pENssKfIt+ODl7Jwm
 n98cIG2z0KwcmCuqmzMAGYzgsdTsGaPdstEb060g6ktVTS9Ta3fcxk+nJCp5z6dLirhtqq7Fs64
 YNf07MKevkSh1lscZ4FufL4lZ0tuVmOiY8rMfgE1+zrajmzCg4jF2JIF6WLYpBexyupgaBg5YKO
 WFWZw48+P4/4evdVuz0gh34gFPJ06+r2tAqHCXzXcZ2qBclQ19y/BDdplEDHrNXBlTN9mVHi79Q
 XThbi6cR3TTFcR0ydrA==
X-Proofpoint-GUID: 4KzNcf5RPKrgYXePAo8ypUUYKcCyFzro
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2OCBTYWx0ZWRfX3Py+A4h1427Z
 yrD5hlSMem3I/beOZ+r64MWTATz4/116RT3ZaiIpbqnNukyrBup8UzzMOircMLtJe1nafSr+530
 E8eLT/Vz/GK5pdKT0hwX9GvcjYy2BPM=
X-Proofpoint-ORIG-GUID: 4KzNcf5RPKrgYXePAo8ypUUYKcCyFzro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:daniel.zahka@gmail.com,m:kiran.kella@broadcom.com,m:kuba@kernel.org,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jayakrishnan.udayavarma@broadcom.com,m:ajit.khaparde@broadcom.com,m:akhilesh.samineni@broadcom.com,m:vikas.gupta@broadcom.com,m:bhargava.marreddy@broadcom.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305145-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[weibunny@meta.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@meta.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,fb.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,fb.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D28C7138ED

On Mon, Jul 6, 2026 at 6:46=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
> >
>
> On 7/3/26 7:24 AM, Kiran Kella wrote:
> > The race occurs between network namespace removal and PSP device
> > unregistration.  When a netns is deleted while a PSP device associated
> > with that netns is concurrently being removed, psp_dev_unregister()
> > triggers psp_nl_notify_dev() to send a device change notification.
> > Concurrently, cleanup_net() running in the netns workqueue calls
> > genl_pernet_exit(), which sets net->genl_sock to NULL. If
> > genl_pernet_exit() wins the race, two sites in psp_nl_multicast_per_ns()
> > then dereference the NULL socket and crash:
> >
> > CPU 0 (netns teardown)       CPU 1 (PSP device unregister)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > cleanup_net [workqueue]
> >    genl_pernet_exit()         psp_dev_unregister()
> >      net->genl_sock =3D NULL      psp_nl_notify_dev()
> >                                   psp_nl_multicast_per_ns()
> >                                     build_ntf()
> >                                       -> netlink_has_listeners(NULL)
> >                                       /* crash */
> >                                     genlmsg_multicast_netns()
> >                                       -> nlmsg_multicast_filtered(NULL)
> >                                       /* crash */
> >
> > Both the main_net path (derived from psd->main_netdev) and each
> > assoc_net entry in psd->assoc_dev_list are affected.
> >
> > Fix by replacing the bare dev_net() calls with maybe_get_net().
> > maybe_get_net() returns NULL if the namespace is already dying.
> > Holding the reference ensures genl_sock remains valid across both the
> > build_ntf() and genlmsg_multicast_netns() calls.
> >
> > Fixes: 00c94ca2b99e ("psp: base PSP device support")
> > Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-di=
sassoc")
> > Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
> > Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
>
>
> Thanks. I was able to repro myself by inserting a delay after the old:
>
> main_net =3D dev_net(psd->main_netdev);
>
> and then executing nsim_psp_rereg_write() in parallel with destroying
> the netns that I placed a netdevsim dev into.
>
> Tested-by: Daniel Zahka <daniel.zahka@gmail.com>
>
> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
>
Thanks for the fix!

Reviewed-by: Wei Wang <weibunny@fb.com>
> > ---
> >   net/psp/psp_nl.c | 33 +++++++++++++++++++++------------
> >   1 file changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> > index 9610d8c456ff..24ab626a9e8a 100644
> > --- a/net/psp/psp_nl.c
> > +++ b/net/psp/psp_nl.c
> > @@ -62,36 +62,45 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsign=
ed int group,
> >       struct net *main_net;
> >       struct sk_buff *ntf;
> >
> > -     main_net =3D dev_net(psd->main_netdev);
> > +     main_net =3D maybe_get_net(dev_net(psd->main_netdev));
> > +     if (!main_net)
> > +             return;
> > +
> >       xa_init(&sent_nets);
> >
> >       list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
> >               struct net *assoc_net =3D dev_net(entry->assoc_dev);
> > +             struct net *net;
> >               int ret;
> >
> >               if (net_eq(assoc_net, main_net))
> >                       continue;
> >
> > -             ret =3D xa_insert(&sent_nets, (unsigned long)assoc_net, a=
ssoc_net,
> > -                             GFP_KERNEL);
> > -             if (ret =3D=3D -EBUSY)
> > +             net =3D maybe_get_net(assoc_net);
> > +             if (!net)
> >                       continue;
> >
> > -             ntf =3D build_ntf(psd, assoc_net, ctx);
> > -             if (!ntf)
> > +             ret =3D xa_insert(&sent_nets, (unsigned long)assoc_net, a=
ssoc_net,
> > +                             GFP_KERNEL);
> > +             if (ret =3D=3D -EBUSY) {
> > +                     put_net(net);
> >                       continue;
> > +             }
> >
> > -             genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf, 0,
> > -                                     group, GFP_KERNEL);
> > +             ntf =3D build_ntf(psd, net, ctx);
> > +             if (ntf)
> > +                     genlmsg_multicast_netns(&psp_nl_family, net, ntf,=
 0,
> > +                                             group, GFP_KERNEL);
> > +             put_net(net);
> >       }
>
> some optional nits if you wanted to respin:
>
> You could eliminate the extra struct net *net, by just doing something
> like if (!maybe_get_net(assoc_net)) directly.
>
> You could get away with a single put_net(net); call site, if you reorder
> the ops that could fail so that maybe_get_net(assoc_net) happens last
> before the build_ntf(psd, net, ctx)
>
> >       xa_destroy(&sent_nets);
> >
> >       /* Send to main device netns */
> >       ntf =3D build_ntf(psd, main_net, ctx);
> > -     if (!ntf)
> > -             return;
> > -     genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
> > -                             GFP_KERNEL);
> > +     if (ntf)
> > +             genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0,=
 group,
> > +                                     GFP_KERNEL);
> > +     put_net(main_net);
> >   }
> >
> >   static struct sk_buff *psp_nl_clone_ntf(struct psp_dev *psd, struct n=
et *net,

