Return-Path: <netdev+bounces-290344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L3LIwnjDmrACwYAu9opvQ
	(envelope-from <netdev+bounces-290344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:48:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C59E5A393C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79B303077A53
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314A3A1CEC;
	Thu, 21 May 2026 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="islqC7+k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWIxcFiw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105A387362
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359640; cv=none; b=jixkeGTNgzyBUZGGeL9bBl1UFUuuj4j6b/AVExzSSAo7XuaM1eqPRIuIzRoEMk8zE1rgzznkYbMFFxmEsxhFhGwrr9KW99Vs+/GVpe3K2X8E7zKnxl4LI5R+4ejqAvu4GU34oaxdkTb7SCgavpUs1rzTHAYvc7Zgp2XsxI5aMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359640; c=relaxed/simple;
	bh=2pyB0b66d9OooIjO1bbEJelR7lkLdpgM45Rqj1axoIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCmRjJSiDZU1rVGS0fyCIATQT+2b2hKCVAWDrJvZ6IQ8uUCz5vkzaHmwT41I+f+KSfQ4CpCdxWBhNcp56BpsBbY/vx5gPLq0pcT27Xsk6aJMua5STKMbuvA46dknBucp6XP4xdLzRUhkjDBBDpBddiKUQBZiTZIjjx6wotepqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=islqC7+k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWIxcFiw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779359637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxkfxQ3xSUPn6AB8xQpyVDZX4pCwkMu4r553AvWxGR4=;
	b=islqC7+kdzT72CZOl9l74uxo/AsJjzb7DKdMwkpV2PYkulX54PNQU/IH79rY+dXUgZ3AND
	pfL9GZJndOR9IPjMS29WaXQHJJOOJFGG79Trhk/DzhnyiCNXZT4/N+oR14gfIXWikNhxCD
	ltM4u1n4g52TJVpyafz3FVgjpzG6n24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-PIsdjY0KMlusu37wuRfOQA-1; Thu, 21 May 2026 06:33:56 -0400
X-MC-Unique: PIsdjY0KMlusu37wuRfOQA-1
X-Mimecast-MFC-AGG-ID: PIsdjY0KMlusu37wuRfOQA_1779359635
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48feb0298d7so46335445e9.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779359635; x=1779964435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxkfxQ3xSUPn6AB8xQpyVDZX4pCwkMu4r553AvWxGR4=;
        b=NWIxcFiwY5U3Ew/vz0Wc4xR6VkxH7IjmYu9/RHMnUyksHkfTTjFAAdk/ju+oI1DkMo
         AMlWvTQP/JomyciS1jBi95ZbooE9a6//eehiOUmj47HVLn5K2Wu7c37rdvwA4CYUcvyv
         DmXWHl0jRlLJ4L453Ry3GdQJcV2kQ44yJo+Uwk+CqvXuq3tZqla4KBAU5fnF07bfrDi3
         ze4DKMs1luqRuRg9nKs5OLvXzD2qSfzSHHAhBrKRI09XZ2ICkroWLxjsKuozezgVfluW
         +MFL7L+469vaOdXXDH0qt2Ih5EhctZIA8dwU5f63xljoagrCOarGKfIAvRHg8zFoGhrn
         Bpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779359635; x=1779964435;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxkfxQ3xSUPn6AB8xQpyVDZX4pCwkMu4r553AvWxGR4=;
        b=mBYkgKV1cxRserSUbhJcqYc1R09G56baQdzQSHG6MZTzP0k6wyrFaCcZagZvFV7nli
         /FqxibwADxJTitWBB4hIXMeAsZLHBdlogYOKvlMozxJA+tg6wyV9JFq2okN+xMciOip0
         hh5E/AlL56fpvY6eziVgs6jwr8QhxGpL32+Ymav4T/ZcDpXH/GdjrIh4+5848soxamoe
         GJqtNi77KsPTE6TBG+X8Q3L2EwPSPhj1XokpK1sCPCM6TQC4NKgae7tCiuKtiRzKDw2s
         3PpKN39KgWp88pp9eC7YSGRUXykNCb2Yy5neYjvfXGfkXHQ51nYAURDassDMjRy4pElV
         jeCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K30p3HyJTjD0VQ2uwInkOgXM5PSKwwJJZy/V5mSumZmRY9Cua8jH08CVSzLB37M/tz/2ZvbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmW/YtpFuuOy3guYsoG2NM1rtlgKFgno/TeZwpMRiTttkvioAO
	5RX5eMK/6j/jGjiUYOssPvHSNqTvl3+gMF8AgzTYG8tmIpM60bXFDBCdrSHv498gZdcHz0NjAQE
	/+fIBXgp+bu2xH0G3ydZqT8/e7nryRmYwGEdc7MBPXbPHquk3YuVI9ZYIAw==
X-Gm-Gg: Acq92OF5cmr6v+aquOnVqk+QVIvq7b72dhUwQ5CaaLFFyYerJsXtCzuKKTC8JN9Cgum
	3xOmb0SJ5QPd8GOcTMqysP6rxONZALJ60yKQdXPYQs4tDc5LSJR3rw411Sk1Ne4JWd4hv0Nvt3f
	x3IfwOtlmgz6fXqGfHsZppks4+nFcv7AyAJ9NE0sQ7ZxKRsjci9uDo8+ukwlAQiYoOsLwg1Hnd/
	DcOJ1A7CZwmxGmQIzGrn4UAvyJAkcOiqiLKe5rVz6nqw+WUygArKzvqzHoHFugUyzy2DObiFZgY
	aWVouIWLJfVs0KorTjLA0PGs94HqnzObiOHRCLx9PyZOz4NEyp7k/v6TSXxKo/7fQMj+MPMc+zS
	ikiqpHsqI+nz8gJ4n7DFfmZNiQ7xNgVqWYWowund/klSMrI3yPFKff1n5Gg==
X-Received: by 2002:a05:600c:c0c2:b0:48f:e230:d5ad with SMTP id 5b1f17b1804b1-490360eea2bmr24691655e9.33.1779359635040;
        Thu, 21 May 2026 03:33:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c2:b0:48f:e230:d5ad with SMTP id 5b1f17b1804b1-490360eea2bmr24691355e9.33.1779359634600;
        Thu, 21 May 2026 03:33:54 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035c46915sm13197775e9.13.2026.05.21.03.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 03:33:54 -0700 (PDT)
Message-ID: <5315a3b0-4fc8-4d74-8e27-d7b84bd794c9@redhat.com>
Date: Thu, 21 May 2026 12:33:51 +0200
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
Cc: Tim JH Chen <tim.jh.chen@wnc.com.tw>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Liu Haijun <haijun.liu@mediatek.com>,
 Ricardo Martinez <ricardo.martinez@linux.intel.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260518075033.58996-1-tim.jh.chen@wnc.com.tw>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260518075033.58996-1-tim.jh.chen@wnc.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290344-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[wnc.com.tw,intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wnc.com.tw:email]
X-Rspamd-Queue-Id: 8C59E5A393C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 9:50 AM, Tim JH Chen wrote:
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
> 2. The kthread's state guard (line: "if ... state != DPMAIF_STATE_PWRON")
>    is only checked at the top of each loop iteration. If the thread
>    already passed this guard, it proceeds unconditionally to call
>    pm_runtime_resume_and_get() — which tries to acquire the PM spinlock
>    also held (or contended) by the system PM suspend path.
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
> the time pm_runtime_resume_and_get() holds the PM lock during L1.2
> link retraining) and hundreds of repeated suspend/resume cycles to
> trigger reliably.
> 
> Fix by three coordinated changes:
> 
> - In t7xx_dpmaif_suspend(): immediately set state to DPMAIF_STATE_PWROFF
>   after stopping the TX queue, then call wake_up() so any sleeping thread
>   re-evaluates the wait_event condition and stops.
> 
> - In t7xx_dpmaif_resume(): restore state to DPMAIF_STATE_PWRON before
>   re-enabling the TX queues, symmetric with the suspend change.
>   Without this the kthread would never wake up after resume.
> 
> - In t7xx_dpmaif_tx_hw_push_thread(): add a second state check
>   immediately before pm_runtime_resume_and_get() to close the TOCTOU
>   window between the wait_event guard and the pm call.
> 
> Tested: no soft lockup observed over 500+ suspend/resume cycles with
> SIM registered and ASPM L1 enabled (previously triggered in < 300).
> 
> Signed-off-by: Tim JH Chen <tim.jh.chen@wnc.com.tw>

This is a fix, it should target the 'net' tree including such tag into
the subj prefix and should carry a 'Fixes:' tag.

Also this is v2 of:

https://lore.kernel.org/netdev/TYZPR02MB5232A8C6A2BA56226D97CF4A90062@TYZPR02MB5232.apcprd02.prod.outlook.com/

the subj prefix should have included the relevant revision number and
you should have described what changed in the commit message after a
'---' separator.

Please have a deep read at the process documentation and specifically at:

Documentation/process/maintainer-netdev.rst

before posting the next revision.

/P


