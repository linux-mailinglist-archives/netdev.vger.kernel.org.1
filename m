Return-Path: <netdev+bounces-294355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y5ftMx0nH2rTiAAAu9opvQ
	(envelope-from <netdev+bounces-294355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:55:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA776313E4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:55:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SahL2LMQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294355-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294355-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D4663029D14
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4551B39A070;
	Tue,  2 Jun 2026 18:53:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A539A7E0
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:53:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426420; cv=none; b=lEZ+u75hYZ90N9+4ARix6VdGbOuAXiU4I5RlexAwejbeW2Ev64Dkk8jLiRTsAScmFgOfeFhwNH6LWPvNzINMfKma8ppsxAgELAztcuBP5p4OAXUxFek3XH1+wVfvpzGoRccdEpy0zbGDBpOBsRRHXnRFCRUntEdff02OZqFXYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426420; c=relaxed/simple;
	bh=dHCFaHHiVTLyys9qS9xRrvo0GDTkWtoUDeopNjjVVuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaaBo3JV97V70KMfuU5ZNnV+++I4SRh3k0FrGZgMG3Zcr+V53Wj0G0rjY0CWX9nrfUaGxNRxtWUvFryzwJcXBMmSurrPHLOmAbRbMnWN0z+ZyNruPH54SjXGYjfWNGT1IhL/ubVZ2rNnoUWiPiJ3Rot/iCfHOIipm6I1eHS46w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SahL2LMQ; arc=none smtp.client-ip=209.85.216.67
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so1975467a91.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780426418; x=1781031218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtXDmS2jK1tRfXSemQiff3PJIcryZ2r2uBSPCnvnIts=;
        b=SahL2LMQRvJm0gdKS87bc5ixiYF7/TDJJzJuesyKo874vJPeDRkNtL62miKaWJQSG6
         lluALIInsMx7B5yfG4CIVyQJXlKVDl0dgemy+gWK99+QHfB0b4dgLcD/Vv103m25E7Rz
         5mH+b+dgGwhFGWGtJRaveif2Apvnnj1u4900MOXv5S4YckFeV44EsbUBmLDM3Il54rq7
         585858IYZiJjUFAt/Cb1Pi0mp5eTlC5INWUaHnYBhsmydMwrNrhEnYChJn7L3OUJ2V8J
         dAVMcuBhkmpb8kuATiiToM+LCI1uX+uf9Y3bOKuZoonE83M9HOHe2FzQo7/uY9IbYOai
         pcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780426418; x=1781031218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtXDmS2jK1tRfXSemQiff3PJIcryZ2r2uBSPCnvnIts=;
        b=R13CHnuYMWGKzE6KBGiqeYAf6lwf+xOx460cG2ZpPf0Jm481QcPIv+JKK41lzo2KLz
         WZudFsR+J44edc+17r3T4YAwrP7WlCoIsesznWJSc4rJXBzR82w3ew2oHD7vNJ+3Fd9s
         XrlqjVS/VRYWvVcHMML3JE73mX7X4/JXGXdsqb0/hQl31/9Luz9dW6r1wmyystcYRDS+
         G+fCvLg+1PvSVSnmr6m3rhQp1HpV+Hpw5KmNFn91sw2FjUrKBp8S0TFy7iwZDCu1KuFz
         tRpO7t3NJKbcGKYYwfKJp3aEapzr2Z0wATZ8NfW/Y0oSOdBWZWOvXlkK4+Wqw6Vi3xs1
         wL4A==
X-Forwarded-Encrypted: i=1; AFNElJ+RvLyYrFVlSeTRRrkVHL639nLVmLjWDpMRRz1brmBs8tnv12W//+VuSgMFRrawcenFhfHHV7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VwEj8NDbYqabJ9W3mwva3k7s4qcYGPwkZJ9go8S0Kx2AzZ5A
	10SPZF7jyjQjiFeuwkj+93ce7k6bO14mwHuBoBVMxxggSEAsTJPq+2nW
X-Gm-Gg: Acq92OH2bOBsQChLIKEO7pXBPr7mpOSwOgmf+MTBLR03//V5hFMBBXGd1rLP2a0CnX9
	QmG6+OQ2h9WJ4GP8DkNUmJ0lyZ8RQ4VIZ4MUAW13+x+pGIqeDVGInE5ui6iS+nJq/aw+4mvrrSx
	wWoMummSTaA3TNCA63z1DJ71S6L27ik/kqxog2ToZn2u3nlfNGElpOtfVI9agGueEKPJfnwUe/x
	kTucWjtdziHv0HEUR1QY8e3SfL+YiIMRgB4mY4bVkufCV6ewPbEd8kBo118vk4OF6yTrxd29xv6
	+CJeMRsjUNlJaAQTeO0eTA4NhAOlYODim1k7cwR4hnsLd+Ihfus10rQvmWLiA+xTCG8C4Q093Vx
	heTVGxlLTqgN9mxN7Z0o4jFUB+2t3XSv4wk9bUjs0DCE8u/IQkk1Hfr8I35YV8Y0cxu9fvkCk9W
	0La+ZETRVsbrHbtbcX1/GYiSnZ0N8=
X-Received: by 2002:a17:90a:c2c5:b0:36a:c4b:76cf with SMTP id 98e67ed59e1d1-36e3310568dmr85110a91.23.1780426418066;
        Tue, 02 Jun 2026 11:53:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e09f58238sm584615a91.0.2026.06.02.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:53:37 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:53:30 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	stfomichev@gmail.com, kuba@kernel.org, kernel-team@meta.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: bnxt_en: suspicious RCU usage in bnxt_fw_reset_task() qdisc path
 in 7.1-rc6
Message-ID: <ah8mmctx1TDUIjGn@devvm7509.cco0.facebook.com>
References: <ah726OtFX-Qw3U-R@gmail.com>
 <ah8XMZs42IWAJEwU@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ah8XMZs42IWAJEwU@devvm7509.cco0.facebook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294355-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,meta.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:kernel-team@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AA776313E4

On 06/02, Stanislav Fomichev wrote:
> On 06/02, Breno Leitao wrote:
> > I am hitting a "suspicious RCU usage" lockdep splat from bnxt_en
> > during a firmware reset on v7.1-rc6 (e43ffb69e043) with PROVE_RCU
> > and PROVE_LOCKING enabled.
> > 
> > The firmware reset path re-opens the device from bnxt_fw_reset_task()
> > holding only the netdev instance lock (&dev->lock).  bnxt_open() ->
> > __bnxt_open_nic() -> bnxt_set_real_num_queues() ->
> > netif_set_real_num_tx_queues() then walks the qdisc tree in
> > dev_qdisc_change_real_num_tx(), which still dereferences dev->qdisc
> > with rtnl_dereference() and therefore expects rtnl_lock to be held:
> > 
> >   void dev_qdisc_change_real_num_tx(struct net_device *dev,
> >                                     unsigned int new_real_tx)
> >   {
> >         struct Qdisc *qdisc = rtnl_dereference(dev->qdisc);
> >         ...
> >   }
> > 
> > Since only the instance lock is held in this path, lockdep complains.
> > 
> > Splat
> > -----
> > 
> >   =============================
> >   WARNING: suspicious RCU usage
> >   7.1.0 #1 Tainted: G            E
> >   -----------------------------
> >   net/sched/sch_generic.c:1416 suspicious rcu_dereference_protected() usage!
> > 
> >   other info that might help us debug this:
> > 
> >   rcu_scheduler_active = 2, debug_locks = 1
> >   3 locks held by kworker/u208:1/13:
> >    #0: ((wq_completion)bnxt_pf_wq){+.+.}-{0:0}, at: process_scheduled_works+0x8f7/0x13b0
> >    #1: ((work_completion)(&(&bp->fw_reset_task)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x917/0x13b0
> >    #2: (&dev->lock){+.+.}-{4:4}, at: bnxt_fw_reset_task+0x7ed/0x1e80
> >   stack backtrace:
> >   CPU: 38 UID: 0 PID: 13 Comm: kworker/u208:1 Tainted: G            E
> >   Hardware name: Wiwynn Delta Lake MP/Delta Lake-Class1, BIOS Y3DL405 11/21/2025
> >   Workqueue: bnxt_pf_wq bnxt_fw_reset_task
> >    <TASK>
> >    dump_stack_lvl+0x69/0xa0
> >    lockdep_rcu_suspicious+0x13f/0x1d0
> >    dev_qdisc_change_real_num_tx+0x54/0xe0
> >    netif_set_real_num_tx_queues+0x4ed/0xa80
> >    __bnxt_open_nic+0x9cb/0x3490
> >    ? bnxt_hwrm_if_change+0x4fd/0x620
> >    bnxt_open+0x1cb/0x370
> >    bnxt_fw_reset_task+0x80d/0x1e80
> >    process_scheduled_works+0x9c1/0x13b0
> >    worker_thread+0x90d/0xd20
> >    kthread+0x320/0x3f0
> >    ret_from_fork+0x2b6/0xb00
> >    ret_from_fork_asm+0x11/0x20
> >    </TASK>
> > 
> > Bisect / analysis
> > -----------------
> > 
> > This looks like a regression from:
> > 
> >   850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the
> >                   bnxt_open() path"")
> > 
> > That revert dropped rtnl_lock() from the bnxt_open() paths and left
> > bnxt_fw_reset_task() holding only the instance lock around bnxt_open().
> > 
> > I can send a patch restoring rtnl_lock() around the bnxt_open() call in
> > bnxt_fw_reset_task() (re-taking rtnl before the instance lock, matching the
> > pre-revert code), but I wanted to report it first to make sure I am in the
> > right direction.
> >
> > Please let me know how you would like to proceed.
> 
> I hope (but need to verify) that at this point most of the paths that assign
> qdisc are under ops lock as well. So the alternative might be to use
> netdev_ops_lock_dereference from Jakub's recent
> https://lore.kernel.org/netdev/20260528231637.251822-1-kuba@kernel.org/t/#m3de56e1d53f86b2c1b12ca29d1617dd6635e78cb

Agree with Jakub, this is more than just the assignment :-(

