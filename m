Return-Path: <netdev+bounces-268135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFf5KiLxt2mfXQEAu9opvQ
	(envelope-from <netdev+bounces-268135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:01:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B278929911B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1C12300A5A4
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95619392829;
	Mon, 16 Mar 2026 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qk8Umm9x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="skSuBlZ4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E482472A2
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662491; cv=pass; b=Vp8AguyXgnF6rii/wyssKRsX3Z/EMdAMJHgEvwNyjbU6Y7Y49PFYaxvCa2jchLbVjdfcEgT/KyQNnQKFgb8A8yqXoPIzu6W5yH5DHjloFGVHWRdKlVA8Tic9RrisRVCUMyec7qLolg3UuGET6DJqqAt3OWsgMDTAYEr1CAiycFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662491; c=relaxed/simple;
	bh=FZvR5hZ2zWuF2LslvM6jFgVwAOQB4XOYPuqVvRo/zZ4=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ey4vZO0f8Q22Axgd8vOLjWt5Dd2pZioWv66aah/tOCXdkK9qyRyuOjl+GHK1WLkkukcG307WgD0szgQmh6p2RVK4DkuFR074k1yBVHP5D7egm1zSFCkmVSy8ue8bgnPYdcHIigRphQcusv9fb4cNfsWx7xF0sZKPhfqIJNhNbzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qk8Umm9x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=skSuBlZ4; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773662489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TT/A4sDi/W+bpm49ONhMZiSIn6upCuJuZueaN6zO+ZQ=;
	b=Qk8Umm9xjKtqSNL3vGuOPJHCHLKROMB+9l0Mm4ssT4DSGsyqO/cqiUMDXO1Vqd+QbFXeEp
	LBt/ixY+zVcMXwhwVDQO9+SnpuPJ4/vWFkt7ZCGRnIs0f5VNu3A3alJO2lmFNgcOTkC5fA
	VM7omd8j0X4JCFVa41myO1/OtViD04M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-h4kYK5cuMEiyoxOZwQkl9g-1; Mon, 16 Mar 2026 08:01:27 -0400
X-MC-Unique: h4kYK5cuMEiyoxOZwQkl9g-1
X-Mimecast-MFC-AGG-ID: h4kYK5cuMEiyoxOZwQkl9g_1773662486
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b97a381912eso82338166b.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 05:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773662486; cv=none;
        d=google.com; s=arc-20240605;
        b=VjxT5iv4ZgW2ThktMfCCMOdqAyAIgL5VCl4zJuPjdi/rpHEMPekCyzbsF3lM5Oh01X
         RCBl2Km6bFP3Mfb6GkTqYkwEtOQj4HCAAO+E00p1fr5K3mQBS7M8Dg4QAu5ZPNuH7BdJ
         JR7srjnh9aATaaySvAfyFBoV7odezVRm4nwgCTIbaHSTFTnHf3O7A7GgwsrLdz4iF9D/
         Wwl6uaRUfOB+K1V7fTLu9H2qr6p77wmOhevL2nvHieI9+Xb9fWU7ppQvVyCmLQdKggY4
         dB7RiQO1OZOztcZp1lsF/SScncTRnAI9YvQOpa+7M1cefkjtVh0kHVMpWdJ6JTsGIrVj
         DjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=TT/A4sDi/W+bpm49ONhMZiSIn6upCuJuZueaN6zO+ZQ=;
        fh=/N+QYm39qOI4zBrjE2F/+58Gc6BUU6d9GkdVCpi62xU=;
        b=dA7E5qP2qA4PjK2PkI56YCr1dczNSHObvJUK5wWlasERe0NkKbXgwbs3WwoT00wDJC
         g7N5llRUjadr+Q0K9rk40pFh0ceonNQeMbhip2Fva4xehQxhRXcz9kuN8Sqga9Y56/po
         MSskxARxMKeQUN9O6SEfdXLWxpRwvq9R352dX5ID7W/auawcfJL5v7GK9NL02aFTbbgU
         3LRZpBjliwwrgtI9jMB6OSTbL5ptyv/ssnfHNaEg9GzINREMJmX5kClJapJgQ4zn4LZa
         q7SyqeYchfG/6CTh8/SStDWHJjzxLzUZ4EYrurlpiEmwYkwzGARtwx7cJYht/CzjTPkr
         OcHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773662486; x=1774267286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT/A4sDi/W+bpm49ONhMZiSIn6upCuJuZueaN6zO+ZQ=;
        b=skSuBlZ4/FBIhetcvrBgjR/UowPazz5mE5p78KsQ+roXvsanT4wIOnuDLvnhNcM42d
         SCNPBi7pq7HO3XXZ2NZQcwKJsElq/PYizaqV8LPugfqQbRMmkgp4ChOnFQANw1beLxHZ
         lGlTdWAMsXzU7tWMjfS8j+qjheaY7VK53dQLqpV56yupWOOvOvuonELvyLFiPykeGS1c
         WxDE8Pq0ekN1OUphe0jSBzhr1/SFmO3eI0Uua5RP9QIwy533E4b6Y0AEygrCaBqweU9Y
         dQ3z0FuPXnqmJ+YXI31/l75RoPsPRUUd9JADXLzzYnnhTirt/rvXwN4gy+LjffH8xZL4
         eI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773662486; x=1774267286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT/A4sDi/W+bpm49ONhMZiSIn6upCuJuZueaN6zO+ZQ=;
        b=bKMfwM/HG1W9AFimKuWdVXFD7DworlMUoaMDMtomMSwIR25FdeHsbEQ3pR/FRmrK2j
         Rl1xwJo/uHQPLJeFivNe0ihyISUYIO/OvhN2uIYj/WVrlVyQM3S1Xt2WtpQcKLQ8zBqh
         Em3DwX+z2B3Ny0v7MIclGql/mUMT3Y1xLfmJp07S/zeVGA/DHmCRYT2RcXm9oAweIifn
         0mcjLrcpqaotmy3Pi126Fut71iX97FXrpwobCZK5w9ABCRiuVgoOWnsBKadKboJqQqe5
         IqZD5yhQkgKmnq8hCN5yoBuxq1SYMiqENBo8SQ7VLN0z8eG9pGgxUoPCGeFIniLC6jcN
         QP6g==
X-Gm-Message-State: AOJu0YxP10zyMvEcwrKNZ3z9Pw55MoGzi0MDGEVLQbs5Fo9u/vRIjOa3
	yVmd40EJIm54jY9WWxNSBP/XPRMALweNvA4lZItseJAOHpazT4odVIO/iOmeZ05nF6sVXdCAzYE
	RVkIEtmu5dFQvIgqZW3vTNJNBhOtW652fMKq4kVfgOgFnHAwjQk+nYevLWDdtWMRtoAtlpy4xSI
	5tqSVC50FM8tcQDhI85uN618nIC+RJnPqE
X-Gm-Gg: ATEYQzxgAq+M7oN0ZGFQBrjKvY7nVPzkn2k+EWBqjHunOHnoydzitj6/9Rmre/MwLTh
	ESJ1Q5HNboMFHdL07f5jkG5pbUOPeBkzUxar3RbqpIkBB2QMa4xWzjTvNJJN4Q/RmQdgmtttsXf
	tRbx9jMZxlS7X6rVSNhlE32ojV4GsC78+jdI8pEaJaIxR2Bg1Kd9gA/GIhI4maUOokI5o5EGF0u
	APm3i+j
X-Received: by 2002:a17:907:3e25:b0:b93:338f:c537 with SMTP id a640c23a62f3a-b976532d70fmr763532466b.51.1773662485185;
        Mon, 16 Mar 2026 05:01:25 -0700 (PDT)
X-Received: by 2002:a17:907:3e25:b0:b93:338f:c537 with SMTP id
 a640c23a62f3a-b976532d70fmr763506966b.51.1773662482957; Mon, 16 Mar 2026
 05:01:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 05:01:21 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 05:01:21 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260313173114.1220551-1-amorenoz@redhat.com> <20260313123535.4b2741b8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260313123535.4b2741b8@kernel.org>
Date: Mon, 16 Mar 2026 05:01:21 -0700
X-Gm-Features: AaiRm51MxPYqe9h8yWD-FuaimNfPWNt2ba22_2gMQd_b_3sps61FcHAWakzlAnQ
Message-ID: <CAG=2xmPhQKzGKAiqejuwZH+ZziH3pnvUtuiBd+RAmLj4jZLS6A@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: openvswitch: decouple flow_table from ovs_mutex
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, dev@openvswitch.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268135-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B278929911B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:35:35PM -0700, Jakub Kicinski wrote:
> On Fri, 13 Mar 2026 18:31:12 +0100 Adrian Moreno wrote:
> > Currently the entire ovs module is write-protected using the global
> > ovs_mutex. While this simple approach works fine for control-plane
> > operations (such as vport configurations), requiring the global mutex
> > for flow modifications can be problematic.
>
> YNL selftest for ovs seems to trigger this:
>
> [   88.995118][   T50] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   88.995287][   T50] WARNING: suspicious RCU usage
> [   88.995448][   T50] 7.0.0-rc3-virtme #1 Not tainted
> [   88.995630][   T50] -----------------------------
> [   88.995788][   T50] net/openvswitch/datapath.c:2666 RCU-list traversed=
 in non-reader section!!
> [   88.996122][   T50]
> [   88.996122][   T50] other info that might help us debug this:
> [   88.996122][   T50]
> [   88.996388][   T50]
> [   88.996388][   T50] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [   88.996640][   T50] 3 locks held by kworker/2:1/50:
> [   88.996800][   T50]  #0: ff11000001139b48 ((wq_completion)events){+.+.=
}-{0:0}, at: process_one_work+0xcb4/0x1390
> [   88.997092][   T50]  #1: ffa000000036fd10 ((work_completion)(&(&ovs_ne=
t->masks_rebalance)->work)){+.+.}-{0:0}, at: process_one_work+0xd16/0x1390
> [   88.997420][   T50]  #2: ffffffffc08038e8 (ovs_mutex){+.+.}-{4:4}, at:=
 ovs_dp_masks_rebalance+0x29/0x270 [openvswitch]
> [   88.997707][   T50]
> [   88.997707][   T50] stack backtrace:
> [   88.997898][   T50] CPU: 2 UID: 0 PID: 50 Comm: kworker/2:1 Not tainte=
d 7.0.0-rc3-virtme #1 PREEMPT(full)
> [   88.997903][   T50] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [   88.997904][   T50] Workqueue: events ovs_dp_masks_rebalance [openvswi=
tch]
> [   88.997911][   T50] Call Trace:
> [   88.997914][   T50]  <TASK>
> [   88.997916][   T50]  dump_stack_lvl+0x6f/0xa0
> [   88.997921][   T50]  lockdep_rcu_suspicious.cold+0x4f/0xad
> [   88.997928][   T50]  ovs_dp_masks_rebalance+0x226/0x270 [openvswitch]
> [   88.997933][   T50]  process_one_work+0xd57/0x1390
> [   88.997940][   T50]  ? pwq_dec_nr_in_flight+0x700/0x700
> [   88.997942][   T50]  ? lock_acquire.part.0+0xbc/0x260
> [   88.997950][   T50]  worker_thread+0x4d6/0xd40
> [   88.997954][   T50]  ? rescuer_thread+0x1330/0x1330
> [   88.997956][   T50]  ? __kthread_parkme+0xb3/0x200
> [   88.997960][   T50]  ? rescuer_thread+0x1330/0x1330
> [   88.997962][   T50]  kthread+0x30f/0x3f0
> [   88.997964][   T50]  ? trace_irq_enable.constprop.0+0x13c/0x190
> [   88.997967][   T50]  ? kthread_affine_node+0x150/0x150
> [   88.997970][   T50]  ret_from_fork+0x472/0x6b0
> [   88.997974][   T50]  ? arch_exit_to_user_mode_prepare.isra.0+0x140/0x1=
40
> [   88.997977][   T50]  ? __switch_to+0x538/0xcf0
> [   88.997980][   T50]  ? kthread_affine_node+0x150/0x150
> [   88.997983][   T50]  ret_from_fork_asm+0x11/0x20
> [   88.997991][   T50]  </TASK>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/=
tools/net/ynl/tests/ovs.c
>

Thanks!

I wonder why this did not come up in my tests. Jakub, would you mind
sharing the config used for this test?

For mask rebalancing I initially thought of doing the same thing as for
the other flow commands (rcu + refcount + flow_table mutex).

But given it's not that critical and it's not run in the context of
handler threads, I rolled back to locking in this case. That
"list_for_each_entry_rcu" is a leftover of my initial attempt and should
be replaced with normal "list_for_each_entry".

Thanks.
Adri=C3=A1n


