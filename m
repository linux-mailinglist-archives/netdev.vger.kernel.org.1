Return-Path: <netdev+bounces-295143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nzyVBldGIWp2CQEAu9opvQ
	(envelope-from <netdev+bounces-295143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:33:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AB963E90A
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HEBKvVmb;
	dkim=pass header.d=redhat.com header.s=google header.b=MrGwsVwB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295143-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295143-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EF6B30028BF
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B613C09EE;
	Thu,  4 Jun 2026 09:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDDE3FDC08
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:29:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565380; cv=none; b=BR7b+EA3jgG0grvKvC8rL3puyxszsk+/9jUX/IVFkRRpt2SOcZvPonQN3vIII0VUdU6vnZqk6n43GQ6CiDe0UYFv11txPljS3Uu1aK3rYyrNG3Yqqu400wZYoorFQ5wB71raDdA+vbF0xhQcCle9V+baW8W/67qayfaO5d7nXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565380; c=relaxed/simple;
	bh=LSYx6S/5jyu9KfVp/5iYPsZKG9eGFj04YvZKjTai2Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXYMMTaAqPYUAVxJNMF22NhcnNmZbhy6KWtskro5SIPsgjCeuF7Djla3Dv4pzuZXABLGm6G/wNWSTcdnw7kSgx2qs+uwEc5tif4t9K2QQ6mnD2sCFjrJec7YjrxpPhR6SnQbY6Jj0YiTbhkoQRpSqfR+/fdvVyDEwnFVOqdTg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEBKvVmb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrGwsVwB; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780565377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+huBJ1nPsqC9QTJtR1rRZxAcoh6LRj4ywJbAKenhqm4=;
	b=HEBKvVmbafbigtjQIpDRJTOo5jtaHv+jDwL5nXG+fbYJ/huRvHi0/P+OF4OUkejY3W506l
	ncTdj0E33z8os+6qDf8gacOHfNdYMmdxhUFT9nVYyKOeuY0Noo6LSZXkarlyGxACi7K0Uu
	nZuw3EBboF5MNjscWRnsqF+SI9VEmrM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-UyPI1s6jN7et_szLiWPVFg-1; Thu, 04 Jun 2026 05:29:35 -0400
X-MC-Unique: UyPI1s6jN7et_szLiWPVFg-1
X-Mimecast-MFC-AGG-ID: UyPI1s6jN7et_szLiWPVFg_1780565375
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so4014485e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780565374; x=1781170174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+huBJ1nPsqC9QTJtR1rRZxAcoh6LRj4ywJbAKenhqm4=;
        b=MrGwsVwBVmKBHV3LNcnxKwkeYZBZz4/9S/ZG93qcrPWEBjxvCQ/Mvet4v7imvKTi+P
         c3JPtQuD/YYxlw8rOLdGIDqsG36yrPhLxHAlenO4jOTeoYCJt7GDlujr+Q7EbmlBT9xF
         MBcEhrpr27Ao7SnmG/yRQ3Io39ZpGwaOx0He1itSGPDxPlKDZB9R5JFhXgghsW8R7imW
         ceopw6yzmM8ieQ9rqLdjOWZx5hXWTg4UU7ViEsLahOgKfLytUoKu360dJEwqO/+ALC/r
         QTzl7/RR61WMnhRPaRdMTCJCYNjtVc1dGAfSp7tU9nqJIfPGpLLo4Zqk74eH+ibMx2XI
         uAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780565374; x=1781170174;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+huBJ1nPsqC9QTJtR1rRZxAcoh6LRj4ywJbAKenhqm4=;
        b=CJUdlip+FW5FZ2TrgLYmyAm5EG98zFJkNqlKKQzTvZZjbJHLOucG8qbCnYy5WNGGNO
         Fhh4OdePQpXjsZqv006S9syce34yVzEhXPv4l6bCKqXtJhhhQLvabiC/IoqJXYvxUt7V
         h4Cf6pUmKezBomyNDJddptyBY8EbiuOt3kDhoHp1UqOpW3X5exObJ1NPpYlIlsNTjjxF
         8F5t5Yhd7MwG0dz3z/QpDQDnWYwsPr58pZrmHsuSszNWI8IyrpGWJN2wCqNK8VQDLYxa
         b6StHgb6rJuXnoignTSMDT2y5y/H2DtKKrNqNMxttefi+PZtxddQKgi546gHSsxZPQ8i
         lqog==
X-Forwarded-Encrypted: i=1; AFNElJ9+zFbVlxkNS8tkI1bsiVWbiit87vtF7O7Kp8zpKfLWrucvJ+3sZpmB1rbszDTKjorABesNV7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1p6h0Q0RTpKLA38p1OtEf2aV5TGK1nSVXXDSOUb6eXZCtPAq
	35GRu4iQ00vmhSz9JkKMPtb84psVmVzMEII291YvMLkUTrIipV3R+5c3YyyMdwnwLB1Hvdj9xXb
	taYmxPCbUbeLiUweqlN+lzzjoiudY4bTt8LRvZjXgowtYPQ9M/9bBDdpX3hXQ3uP87w==
X-Gm-Gg: Acq92OH4DKAVJ5HNJsH12dP5n8fk69oZztKlGXym18cGyIh2PW5bcnuuEKU90RH7EdP
	UQycSloRqSyh7txWzZeHfRhzNOpALgpwBOBp1Fr3gPbPUB5d8BEIiy0zKWrsfxxdwBPWRVQJ+O3
	IyN0DfXHO4CPmVIw9iR+I5SVYFH7XoOT9X0JE21ONhMRgovUAKvQw7lQFNeLAYXAvJpuLNMFhIs
	qxR1VDm4c4x2uYStfw7oGr8ArA26fPZVGtzqtOCVe50R9CLjAvwQ6yP20xliocj1kiJ5CSQlvmv
	qrjMVPgMQpzhPmLxWsIHpNCDBPjpR6xGmXbJ9DZldTeSJU/huetTgkKBxvdMrCeZ8QHQtwx7qAK
	/VFeSpqtGKhLf5CRwGCDrgK8YaNHJz/2hV/9i/iu3Pok4YKIrFlPaL6ACF6vSHbqmxq0=
X-Received: by 2002:a05:600c:4fc6:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490b5e950admr112769595e9.10.1780565374424;
        Thu, 04 Jun 2026 02:29:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc6:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490b5e950admr112769175e9.10.1780565373963;
        Thu, 04 Jun 2026 02:29:33 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bd670c2esm45301645e9.0.2026.06.04.02.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 02:29:33 -0700 (PDT)
Message-ID: <c1fcc5f6-8a61-4774-9063-44fc5f458b97@redhat.com>
Date: Thu, 4 Jun 2026 11:29:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wwan: t7xx: fix race between TX thread and system PM
 suspend
To: Tim JH Chen <tim770802@gmail.com>, netdev@vger.kernel.org
Cc: haijun.liu@mediatek.com, chandrashekar.devegowda@intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, tim.jh.chen@wnc.com.tw,
 Chih.Hung.Huang@wnc.com.tw
References: <2f9c5f6b-1d8d-4c8b-815d-77a40aa76e23@redhat.com>
 <20260601015231.3211764-1-tim.jh.chen@wnc.com.tw>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601015231.3211764-1-tim.jh.chen@wnc.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295143-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tim770802@gmail.com,m:netdev@vger.kernel.org,m:haijun.liu@mediatek.com,m:chandrashekar.devegowda@intel.com,m:ricardo.martinez@linux.intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:tim.jh.chen@wnc.com.tw,m:Chih.Hung.Huang@wnc.com.tw,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[mediatek.com,intel.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,wnc.com.tw];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2AB963E90A

On 6/1/26 3:52 AM, Tim JH Chen wrote:
> When system suspend is triggered while the DPMAIF TX kthread
> (t7xx_dpmaif_tx_hw_push_thread) is running, a deadlock can occur
> leading to a CPU soft lockup.
> 
> The root cause is two-fold:
> 
> 1. t7xx_dpmaif_suspend() calls t7xx_dpmaif_tx_stop() which only stops
>    the TX work-queue items (by clearing txq->que_started and waiting on
>    txq->tx_processing). It does NOT signal the kthread and does NOT
>    update dpmaif_ctrl->state, which stays DPMAIF_STATE_PWRON.
> 
> 2. The kthread's state guard is only checked at the top of each loop
>    iteration. If the thread already passed this guard, it proceeds
>    unconditionally to call pm_runtime_resume_and_get() — which tries to
>    acquire dev->power.lock also contended by the system PM suspend path.
> 
> The result is a spinlock deadlock observed as:
> 
>   watchdog: BUG: soft lockup - CPU#N stuck for 26s! [dpmaif_tx_hw_pu]
>   RIP: _raw_spin_unlock_irqrestore
>   Call Trace:
>     __pm_runtime_resume+0x5b/0x80
>     t7xx_dpmaif_tx_hw_push_thread+0xc4 [mtk_t7xx]
> 
> The condition requires ASPM L1 enabled on the endpoint (which extends
> the time pm_runtime_resume_and_get() holds dev->power.lock during L1.2
> link retraining) and hundreds of repeated suspend/resume cycles to
> trigger reliably.
> 
> Fix by introducing tx_pm_lock (struct mutex) and several coordinated
> changes:
> 
> t7xx_dpmaif_suspend():
>   After t7xx_dpmaif_tx_stop(), acquire tx_pm_lock. Under the lock,
>   snapshot dpmaif_ctrl->state into pre_suspend_state (capturing the
>   modem state atomically with respect to the kthread's PM section),
>   then set DPMAIF_STATE_PWROFF via WRITE_ONCE(). Release the lock
>   and call wake_up() so any sleeping kthread re-evaluates the
>   wait_event condition and exits.
> 
>   t7xx_dpmaif_suspend() acquires tx_pm_lock without holding any PM
>   lock. While it waits, the kthread may call pm_runtime_resume_and_get()
>   which briefly takes and releases dev->power.lock independently.
>   Because the suspend callback does not compete for dev->power.lock at
>   this point, the original spinlock deadlock cannot occur. Suspend
>   latency increases by at most one TX burst drain time, which is
>   bounded by the DRB ring depth.
> 
> t7xx_dpmaif_resume():
>   When pre_suspend_state is DPMAIF_STATE_PWRON, re-arm the HW fully
>   (start_txrx_qs, enable_irq, unmask_dlq_intr, start_hw) before
>   publishing the new state. This ensures the kthread cannot issue
>   ul_update_hw_drb_cnt() MMIO writes before UL_ALL_Q_EN is set by
>   t7xx_dpmaif_start_hw(). Publish the restored state under tx_pm_lock
>   to serialise with the kthread's under-lock state check. Wake up the
>   kthread only after HW and state are both consistent.
> 
>   When pre_suspend_state is DPMAIF_STATE_PWROFF (modem was already
>   stopped or in exception before suspend), skip HW re-arming entirely
>   to avoid leaving DMA engines running while the MD state machine
>   considers the modem inactive.
> 
> t7xx_dpmaif_tx_hw_push_thread():
>   Hold tx_pm_lock across the [state check -> pm_runtime_resume_and_get
>   -> pm_runtime_put_autosuspend] sequence. A second READ_ONCE() state
>   check under the lock closes the TOCTOU window between the wait_event
>   guard at the loop top and the pm_runtime call. READ_ONCE() is used
>   in all unguarded state reads in this function.
> 
> t7xx_dpmaif_start() / t7xx_dpmaif_stop():
>   Use WRITE_ONCE() for state writes to match the READ_ONCE() reads
>   used throughout the driver and prevent compiler optimisations from
>   obscuring concurrent access.
> 
> t7xx_do_tx_hw_push():
>   Use READ_ONCE() in the do/while termination condition to match the
>   WRITE_ONCE() annotations on the write side.
> 
> t7xx_dpmaif_tx_thread_init():
>   Initialise tx_pm_lock with mutex_init().
> 
> Note: t7xx_dpmaif_start() and t7xx_dpmaif_stop() (called from the
> MD-FSM kthread via t7xx_dpmaif_md_state_callback()) do not hold
> tx_pm_lock. A race where the FSM transitions the modem to
> DPMAIF_STATE_PWROFF concurrently with the TX kthread's last burst is
> pre-existing and not introduced by this patch; the do/while condition
> in t7xx_do_tx_hw_push() now re-checks state with READ_ONCE() at each
> iteration boundary, limiting exposure to at most one burst.
> 
> Tested: no soft lockup observed over 500+ suspend/resume cycles with
> SIM registered and ASPM L1 enabled (previously triggered in < 300).
> 
> Fixes: 46e8f49ed7b3 ("net: wwan: t7xx: Introduce power management")
> Signed-off-by: Tim JH Chen <tim.jh.chen@wnc.com.tw>

The above is way too verbose and hints that this patch should likely 
be split in a series.

Note that process wise there are still several problems:
- missing revision number in the suby prefix
- mismatch between from email message and SoB
- new revision MUST NOT be in reply-to of older ones.

Please try to be accurate with your next resubmission, or we will
have to delay processing this patch for an additional while.

Sashiko has still quite a bit of concerns:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260601015231.3211764-1-tim.jh.chen%40wnc.com.tw

/P


