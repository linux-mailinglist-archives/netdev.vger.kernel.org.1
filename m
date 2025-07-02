Return-Path: <netdev+bounces-203210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6BDAF0C37
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B318A1C01FC8
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF10223337;
	Wed,  2 Jul 2025 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUT2rnxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE001DFDAB
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440095; cv=none; b=JbiSmLNym+DQlbnwef07xewUQ62sEm3vedm67VvPHm8FemP3d/IUATn3Li+scxFlkgGbwyEobNc4CKwhyEAPbxM9HtABUoFPivqL1SQtnSg9mhj8Niq83PtdcKSOHest4SoMpPZvYXX6/uz2otZvoZobgskbwNKrNq/eWEe8ZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440095; c=relaxed/simple;
	bh=vEfc23gWxmgkLBOZDVzmENwTJDV/WQatXo81v97y4Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0rGvwULm/CBlGsRP+zs8Ty5GhruKIdZNkkR3o9H962ThguglPqTooVai/Z/KJF9VNhbL2OXu0OJopUANsOWG8XCj+uJomonxPn+fNeXrATF75/OCffEbg+ZEG/+/Q9VFYXOOKC58tgtfo9hkAVEOfrMo+xinn+VlHOT52TCr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wUT2rnxW; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a52d82adcaso54834181cf.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751440093; x=1752044893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOYXIgIBjv6MB4UJEdcjwBwxB8dHNloBIY8hBNzIzP4=;
        b=wUT2rnxWo0RU4HNaE80Cssu3Q5WFPD53IItNE9SI4L58pWfTKBYLtFd5SiLwonfI3b
         tQ92YdQk52rI7gCq35t8RD0Q3C/oZauxwe77IQAPy86ml3eW+ur8nbEiWIB7HiL4cYPe
         WrawB0SM/IXUKIwI1PFwwJsNjbDrhd+1jYDYVRBznsVA82Fj3Py4+4ENa0BoNrrSvs8l
         Be3y9zBCPNqKKo9Kk7V1QGeAu4xFNzP2FklrRF7c9w6Ksf8hN52CsizQwLPkvDbaiyiv
         7TdSLrlDrh/rvAbEine8b0Yg9vx1BBdmBKSWlJtPithgaIvq/MQ9w80bcPJMuFQDxZv9
         3PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440093; x=1752044893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOYXIgIBjv6MB4UJEdcjwBwxB8dHNloBIY8hBNzIzP4=;
        b=bWj700623gPhLNdwXfkDHugvgRJJysNJZBEble1pyrzgtte60F9tQYIBIp6x9nkKYS
         qeJvhcechvJq3/tzX5BxGL9/6zD0Fme4Mz2lnjS+uSxeJwAqIq618D9cZ2RlX8Z59+xd
         S7fY6DrN9791BJxiYQI75UIlvzQaMCCx1tLf3Smf7V90hDIMF+QoPnKhvHTCbTrzepcC
         iM4RuLB+xlN0fgD/oxsncMiPrvgYWvz+27WxPE76bMNDNArawClMkYJBfZQmai/nXIRK
         lekUrZ+HkQmbnhRv2z1WzieGUexu/vAukalMef6B4IMUMWwBv9CmjkhqClOH7ymMx5Jp
         yHWg==
X-Forwarded-Encrypted: i=1; AJvYcCUJw419ME7tROyWw0IQnF6kKSAlCektol5ztTHYgtLh7nVFp064zrWWXVYm+FdpRRrhkjra5Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxA3iG17CLbfRPlBJkJcwL9NDZoiB9saOFtWW0vIoSJ9u83Qf
	bH/5ZqUzdcDvDFXmppApuiCXWTQR/MzJTDTdmnd9uFTQnZyXeY2VfQ/eIguhbqiog0Yc+XSsVKq
	elz7tCmL+XxSGLFCdThq2tqhPo5egXRRFAWV+Miq2
X-Gm-Gg: ASbGncuSrkrDfOwAqAjU6Fp5sYm/kvuE6YXVPtf92bNgvVqJNqxiKibLOCq365pqeaL
	CkRyvtwwXPWoZVcne0Jz55tYsqD9v9W9O8ADDeSNMzeHMKCQf44W0VMppHrbimXpOmT0yzJoWIc
	2hkH+T0Ux3kqnnj/+sSvkkm+k1+mbYgvFoUU3HDXCkhsk=
X-Google-Smtp-Source: AGHT+IGoTZjXu7qWcsI/t98GobF0wGfWody9rNcAnaBEU7lY1rhebw/zVTd37AvnAsXCcglTAT1qXqXGBKuQgsuTl0g=
X-Received: by 2002:ac8:57d3:0:b0:4a8:225c:99b0 with SMTP id
 d75a77b69052e-4a97689ed35mr31074771cf.3.1751440092564; Wed, 02 Jul 2025
 00:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701133006.812702-1-edumazet@google.com> <aGSa3bgijdi+KqcK@pop-os.localdomain>
In-Reply-To: <aGSa3bgijdi+KqcK@pop-os.localdomain>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Jul 2025 00:08:01 -0700
X-Gm-Features: Ac12FXx2mGccVr9O7uJ3QJJjWiOjNYEYgvytuRA8uiC5FdV0HF_AljoNrgPaqmg
Message-ID: <CANn89iKA23zDtt3+3K46QrFx-3iUP-Ef4+n87xWdQJhTWA_zcA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: acp_api: no longer acquire RTNL in tc_action_net_exit()
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Vlad Buslov <vladbu@nvidia.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 7:35=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Tue, Jul 01, 2025 at 01:30:06PM +0000, Eric Dumazet wrote:
> > tc_action_net_exit() got an rtnl exclusion in commit
> > a159d3c4b829 ("net_sched: acquire RTNL in tc_action_net_exit()")
> >
> > Since then, commit 16af6067392c ("net: sched: implement reference
> > counted action release") made this RTNL exclusion obsolete.
>
> I am not sure removing RTNL is safe even we have action refcnt.
>
> For example, are you sure tcf_action_offload_del() is safe to call
> without RTNL?

My thinking was that at the time of these calls, devices were already
gone from the dismantling netns, but this might be wrong.

We can conditionally acquire rtnl from tcf_idrinfo_destroy() when
there is at least one offloaded action in the idr.

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 057e20cef3754f33357c4c1e30034f6b9b872d91..9e468e46346710c85c3a85b905d=
27dfe3972916a
100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -933,18 +933,25 @@ void tcf_idrinfo_destroy(const struct tc_action_ops *=
ops,
                         struct tcf_idrinfo *idrinfo)
 {
        struct idr *idr =3D &idrinfo->action_idr;
+       bool mutex_taken =3D false;
        struct tc_action *p;
-       int ret;
        unsigned long id =3D 1;
        unsigned long tmp;
+       int ret;

        idr_for_each_entry_ul(idr, p, tmp, id) {
+               if (tc_act_in_hw(p) && !mutex_taken) {
+                       rtnl_lock();
+                       mutex_taken =3D true;
+               }
                ret =3D __tcf_idr_release(p, false, true);
                if (ret =3D=3D ACT_P_DELETED)
                        module_put(ops->owner);
                else if (ret < 0)
                        return;
        }
+       if (mutex_taken)
+               rtnl_unlock();
        idr_destroy(&idrinfo->action_idr);
 }
 EXPORT_SYMBOL(tcf_idrinfo_destroy);


>
> What are you trying to improve here?

Yeah, some of us are spending months of work to improve the RTNL
situation, and we do not copy/paste why on every single patch :)

I will capture the following in V2, thanks !

Most netns do not have actions, yet deleting them is adding a lot of
pressure on RTNL, which is for us the most contended mutex in the
kernel.

We are moving to a per-netns 'rtnl', so tc_action_net_exit() will not
be able to grab 'rtnl' a single time for a batch of netns.


Before the patch:

perf probe -a rtnl_lock  # Note: This does not capture all calls, some
of them might be inlined in net/core/rtnetlink.c

perf record -e probe:rtnl_lock -a /bin/bash -c 'unshare -n "/bin/true"; sle=
ep 1'
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.305 MB perf.data (25 samples) ]

After the patch:

perf record -e probe:rtnl_lock -a /bin/bash -c 'unshare -n "/bin/true"; sle=
ep 1'
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.304 MB perf.data (9 samples) ]

