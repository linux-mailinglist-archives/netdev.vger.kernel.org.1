Return-Path: <netdev+bounces-305584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7BiAAG9ZTWrwygEAu9opvQ
	(envelope-from <netdev+bounces-305584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:54:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D5A71F6F4
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:54:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=Jabqqxyt;
	dmarc=pass (policy=reject) header.from=meta.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305584-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305584-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726633021E99
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAAB3B994A;
	Tue,  7 Jul 2026 19:50:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B573B1018
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:50:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453841; cv=fail; b=Y/Tyh/yzsJ4Id99qbaQuLffPNldFe8m9bfN3coJSnesx+HxOUGfr/XVGEG5/SOi5pKiqrscX8WwsEfSdsbutvCfKGt2tSkpHSc8YSup6+2B/sOgypcoARcSMUteKv/ZQK6ocE5JPfOAfnO0Np0ctcm7KYa8ApfCHaY3fTa11C7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453841; c=relaxed/simple;
	bh=eejHsGQ4kToYpTiCjGtw5al8n6OpLfVWosC4GNMZl9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkNnKn+Sbasg2P/YTI9sxMcugsNDR/zvzzDXadZV7wGljyZJJOv17PPHjYQy43OXpWnIn72IPlf3n+0xUyRl24bOidtvk6Y5yiAQ9yHw79RvF37+HoM0U1jBk315K0cbR8PkPxf/eGWgUCPcA0eLmu/p3C8q0j0IfStc1oxvDvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Jabqqxyt; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667JAeth1655142
	for <netdev@vger.kernel.org>; Tue, 7 Jul 2026 12:50:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=SMg1JfX1x0GiYKUVxV8pdyAUk8083v+/3KGMx+hHnl4=; b=Jabqqxyt2JHf
	V4ikRubmVm9t+36ZgEzDfS1jj3BL+/cMWiReuVM3JHBI6Mxnlpi6wfKpb/e+tRS4
	tScINQMjx45h4JO3iCZ9/LWp7whw2VB/xBZDiEdjDXgUKrx96Bi1w3qbmT35IrQR
	3NDfcGQaRLFLrUT/ZkBMjGtyqERBUmnCvqYVleywj+EDN/uUskox8Q4VLbbZdhEC
	Y3VopAEhuWrzlw7D6Uj7sE12WpTYcvkGyUwHrNLy5VYNIjtnSN2lUWWbDKETnelT
	ns4fjlsEHvJoNzJQmq1DtHXbFHUOo/qjN8NI3lEIdq//r/ts6sV6LyHOg5fU2k1O
	fLSiT6DXSQ==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f91htkarc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:50:37 -0700 (PDT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c12690ff1fbso96959266b.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783453836; cv=none;
        d=google.com; s=arc-20260327;
        b=mUlQPAnIQbOWPYq35agz7p4e9xI2dg8lcGMiQjt11fBp7Nxz2vWzziUOZ7f6sXWhSV
         7W+rvpzFHELNKvbmDM7wM+VBsDm3F7CLjcF5kdGqU9RajAtl+Oce0zvc3193V1CJIDrD
         wjYqx5FK6QayHUHVDQJ5+CR2W1OHQIq6uRknkce/pUP+IQ6q7ZNLvQMzJI8itUOj0eJG
         jpsbKC6+xvp3awNq7Us++vhu3XWjQF1kSiCHH8TfOg9dzlxj3c+JBXVuEb2+hFQK2hGQ
         WggUDE+jC4Ag6vZY45nGLSbP1IYfiN/dEC0ZdvhyOIvm2N+Hp5sDR8oak/9NI0p7Qy7M
         XNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=f4eXAkVka2YgJHtTwE28vtnGnBCuHWzeyZEWOQGZiHs=;
        fh=klgQZZL8E+euP4vowlgP+omtMVPOnocT5ow5vMC8AJI=;
        b=NBbAJhsacCAxZ0QTik0lK8g+FxcL3SjLdDPh8bFrG/e+sTtTY/q1rng4WrP/tA9SKo
         RCviztdkT6AQ0zMI13Liwm3qbx7GB6jASen1m27HgPCRrAIeqdC6UOFmtu76q02Tv3JE
         FLMQD3L+X1MoWdchVZvnfgi92vnzqmNldC2oVGat3yhkoIzQ7nkEtf92R8n3PJGz9aob
         FHo+HLc6aYLMOtdHd23Q99JV2LPnIOFBOPTcq/df3GblTXIsQq9cJ43Xn31PbQSxd6TJ
         kT/COf7SH+CyUyAygUvSXVfSQDyor1fWUN2ACEi0R7pxQ+Ky9h9bf2KYSkHkj1eoNT+T
         NogA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453836; x=1784058636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4eXAkVka2YgJHtTwE28vtnGnBCuHWzeyZEWOQGZiHs=;
        b=s/1In436//89/hVqdSald8IyUZSrqeEYHjZa117nmc/7j3WCMpetaDpzamdxgqqa2u
         92W9M2y3xhPAhd1x78lNqaeBW6+bjxnE9UlVeBqrKPJFUq19nIzkhXlfG1wa+lWLd9XV
         gFNGCO8QJeDJrprzyQe54P4eyRsY6kpdz+Fz9RE1qS6EVqHIsfm74oyVukm89Z3WnieJ
         bofg6TYC8QTgNhCc2lAZuBa7YDbtLzXi43iPmOggyv8N/tnRqpxKJ67kIyu/6hWsJbxK
         d5H7dPtPV6URZtGNg/aGLsZhAv9uaMO2OI0OE+pCLg9DQeIHM9VAdfmUi9MuTRhniqQj
         rkbw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3IaxbqDxl4iaJgcAhDHs9+lcY1G3p+1VVTwQL81tmQRAsPDWkFsQ2FM0pBH0eNCMTC7aqP9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54RlVZn3j99pneuuCptyTcTpSBvA/Ee/wo1KZFChrMysDCZGP
	1qIJ4Fn7P7xCWgajcvV6KPa/3ipJLhm9TKOCqsqPU/H585LlWuytjBqE+/cLdvpdgDRWLImILJJ
	nSId8t1JPmMIO0v6TtrXV9xrscqmo0S/R5FZHoONRg7EEqs9v8QR4nXobIxDTKixP90cIOVVB4m
	VtSjBpz0t4tC7wSfTgvtp0NyBTtSIfmg==
X-Gm-Gg: AfdE7cloCVd/N4oqJ/VSyc1+bz+K6e+9GHzXNSr6rDKpU1orG/gfL2YzgCPISToM3zt
	BrsKMIxqUQ7LH6cyjPYMK6945vLYepPo6U0/LKcQ6CoZwzuGXA49C7Ag1oD9CPvnfVzamUrG1sk
	cqmoRzhX65wQLPV09050nUuTDrE6xO0AACEqT/XccLewmaJk34ZZ40s8aA7n4d2t+1lk2S+V6wv
	wA3lRnRUA==
X-Received: by 2002:a17:907:c785:b0:c12:2acc:c9d7 with SMTP id a640c23a62f3a-c15a67f7e94mr371802266b.15.1783453836325;
        Tue, 07 Jul 2026 12:50:36 -0700 (PDT)
X-Received: by 2002:a17:907:c785:b0:c12:2acc:c9d7 with SMTP id
 a640c23a62f3a-c15a67f7e94mr371800366b.15.1783453835901; Tue, 07 Jul 2026
 12:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707185937.3177211-1-kiran.kella@broadcom.com>
In-Reply-To: <20260707185937.3177211-1-kiran.kella@broadcom.com>
From: Wei Wang <weibunny@meta.com>
Date: Tue, 7 Jul 2026 12:50:24 -0700
X-Gm-Features: AVVi8CdpqpoL16dZjsNqJd8efukTlUqfhYwmPndNk85J8QInNS86VZK8WqEf9WM
Message-ID: <CADe0Y=tfcRxc6+4ooCbuth+zSGyzcnR93t4CnZQK1d9UFmSNQw@mail.gmail.com>
Subject: Re: [PATCH net v2] psp: fix NULL genl_sock deref race with concurrent
 netns teardown
To: Kiran Kella <kiran.kella@broadcom.com>
Cc: daniel.zahka@gmail.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, weibunny@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
        ajit.khaparde@broadcom.com, akhilesh.samineni@broadcom.com,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
        Daniel Zahka <daniel.zahka@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: WD8_b81PM_J22PdtigmPNTI6KcHT7h8J
X-Authority-Analysis: v=2.4 cv=UupT8ewB c=1 sm=1 tr=0 ts=6a4d588d cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=FOH2dFAWAAAA:8 a=4AnRKqnlLLXkZ1k2-BwA:9
 a=QEXdDO2ut3YA:10 a=PsfoTyiJ_72bb7xyA04f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE5NCBTYWx0ZWRfXx1lkXfCJAkaw
 lu4/TO/MqqMYpNCzerGpmf21CkylDMvOtr98OA4C96Rr0LALxw1uLxq7UOGVhiHAjNHeSQSqQGm
 lgVWTWGiUO4QCa9IYwxsyP7EB4EsaxyWLMjB34GK1J0WYWftygEWQcTuX8yLMTT7rg63H/EN1Ag
 dxWmqNMDLu/mihs3A4VWgAfqThdyJxKK9DOag8xAIqw7wUegtmRfoB37QI616E7wHd019GKmJVG
 2bvKOUdRdU7WUD3j/MTGFRh6sdc5YUwmCUdcmdspnRWh1zVFfQU1bfJ6zXlNZ1qKsgYq0FYLhw6
 4OQvxU8BXSmSkWI3Mg/G4JsKxpEtrnGL1A70cuvFB8EhExlr7P4MdWIkyojQ8e72t6DaT9CTTbX
 +HfnDHz8BCgv3yJ1v2J6TcOX6fdqb/I3+NKj+Sqt9YczHvE98tPEFk5xAaNS6IUHYpinoqPXHtE
 gEhnBcB/YZqp8KtK1zQ==
X-Proofpoint-GUID: WD8_b81PM_J22PdtigmPNTI6KcHT7h8J
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE5NCBTYWx0ZWRfX6cUKPHQMho8b
 rUVxzF2ClUQjb6gcOyE126fK/pdcY2oDuLXQUFz8b8uled4D9rQsro9eA5MNsYMEp6TxVYoVZFe
 BwyaCwtBxprFE/DdiHtjzEg3v0BWmK0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305584-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[weibunny@meta.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kiran.kella@broadcom.com,m:daniel.zahka@gmail.com,m:kuba@kernel.org,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jayakrishnan.udayavarma@broadcom.com,m:ajit.khaparde@broadcom.com,m:akhilesh.samineni@broadcom.com,m:vikas.gupta@broadcom.com,m:bhargava.marreddy@broadcom.com,m:daniel.zahka@broadcom.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@meta.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,fb.com,vger.kernel.org,broadcom.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,fb.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55D5A71F6F4

On Tue, Jul 7, 2026 at 12:00=E2=80=AFPM Kiran Kella <kiran.kella@broadcom.c=
om> wrote:
>
> >
> The race occurs between network namespace removal and PSP device
> unregistration.  When a netns is deleted while a PSP device associated
> with that netns is concurrently being removed, psp_dev_unregister()
> triggers psp_nl_notify_dev() to send a device change notification.
> Concurrently, cleanup_net() running in the netns workqueue calls
> genl_pernet_exit(), which sets net->genl_sock to NULL. If
> genl_pernet_exit() wins the race, two sites in psp_nl_multicast_per_ns()
> then dereference the NULL socket and crash:
>
> CPU 0 (netns teardown)       CPU 1 (PSP device unregister)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> cleanup_net [workqueue]
>   genl_pernet_exit()         psp_dev_unregister()
>     net->genl_sock =3D NULL      psp_nl_notify_dev()
>                                  psp_nl_multicast_per_ns()
>                                    build_ntf()
>                                      -> netlink_has_listeners(NULL)
>                                      /* crash */
>                                    genlmsg_multicast_netns()
>                                      -> nlmsg_multicast_filtered(NULL)
>                                      /* crash */
>
> Both the main_net path (derived from psd->main_netdev) and each
> assoc_net entry in psd->assoc_dev_list are affected.
>
> Fix by replacing the bare dev_net() calls with maybe_get_net().
> maybe_get_net() returns NULL if the namespace is already dying.
> Holding the reference ensures genl_sock remains valid across both the
> build_ntf() and genlmsg_multicast_netns() calls.
>
> Fixes: 00c94ca2b99e ("psp: base PSP device support")
> Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disa=
ssoc")
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> Reviewed-by: Daniel Zahka <daniel.zahka@broadcom.com>
> Tested-by: Daniel Zahka <daniel.zahka@broadcom.com>
> Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
> ---
> v2:
>  - get rid of the extra struct net *net, by doing
> (!maybe_get_net(assoc_net)) directly (as suggested by Daniel Zahka)
>
> v1: https://lore.kernel.org/all/20260703112431.2860506-1-kiran.kella@broa=
dcom.com/
>

LGTM! Thanks for the fix!
Reviewed-by: Wei Wang <weibunny@fb.com>

>  net/psp/psp_nl.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> index 9610d8c456ff..1438dbb07949 100644
> --- a/net/psp/psp_nl.c
> +++ b/net/psp/psp_nl.c
> @@ -62,7 +62,10 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned =
int group,
>         struct net *main_net;
>         struct sk_buff *ntf;
>
> -       main_net =3D dev_net(psd->main_netdev);
> +       main_net =3D maybe_get_net(dev_net(psd->main_netdev));
> +       if (!main_net)
> +               return;
> +
>         xa_init(&sent_nets);
>
>         list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
> @@ -77,21 +80,23 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned=
 int group,
>                 if (ret =3D=3D -EBUSY)
>                         continue;
>
> -               ntf =3D build_ntf(psd, assoc_net, ctx);
> -               if (!ntf)
> +               if (!maybe_get_net(assoc_net))
>                         continue;
>
> -               genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf, 0,
> -                                       group, GFP_KERNEL);
> +               ntf =3D build_ntf(psd, assoc_net, ctx);
> +               if (ntf)
> +                       genlmsg_multicast_netns(&psp_nl_family, assoc_net=
, ntf,
> +                                               0, group, GFP_KERNEL);
> +               put_net(assoc_net);
>         }
>         xa_destroy(&sent_nets);
>
>         /* Send to main device netns */
>         ntf =3D build_ntf(psd, main_net, ctx);
> -       if (!ntf)
> -               return;
> -       genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
> -                               GFP_KERNEL);
> +       if (ntf)
> +               genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0,=
 group,
> +                                       GFP_KERNEL);
> +       put_net(main_net);
>  }
>
>  static struct sk_buff *psp_nl_clone_ntf(struct psp_dev *psd, struct net =
*net,
> --
> 2.54.0
>

