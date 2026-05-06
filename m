Return-Path: <netdev+bounces-285011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CDgLC+X+2ladAMAu9opvQ
	(envelope-from <netdev+bounces-285011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:31:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC34DFCB7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 225DD300A600
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CC631A072;
	Wed,  6 May 2026 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyCe8NJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101AA275B03
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095811; cv=none; b=Zhi0rsRgztfDib3BQ1jKIdWFJGSkVBrIfqYBwZuSTee7EebOj6z/1lZZQkDI3YfzfqQQTtwxfMDyNmKA81tXLJBLoqHTPddHnaWk7eb2jzY1jMOIhn2HvMaADhpoX+09z8G6D4sh5r2fBNRuTI6gGi4kOhFVsIvSHWDGoRSlu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095811; c=relaxed/simple;
	bh=T/Z0ue1NjRjnHIwvygpPdlK10J9GktOfORG2BaFoOP8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Cg3Z3TcgXc94unohgxWgozuHGJvRD+WGeNoMt4qiP/KoaWcfsYxQya9QbC8k89lech3KUXIuWLial9tpK74kNYNrcozwvrudAdScq2wppWnBV2DAelmLXAUloWJZsXS1o9y7TnQyg/AXPls+rzjRR/yJbC3ga88nCMz6uiysUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyCe8NJD; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bb0d18c7f9so197727b3.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778095809; x=1778700609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PObqSo3yI/weBtZ6Fr+3JYSL4ynGoc1gJ3FrdqU23g=;
        b=OyCe8NJDhKG+n/pZc7dWnp6m1nfSIu5MPq33xP3SCXVD41LLstakkV96WP+zY5de6O
         25dhc67NFcBvrfVVPH6tEQXqWs86SNPz8fORCJtulgTzKpMvktzGdX4u7awITY6oYeBS
         vmSXd/BH3eh+I/8cPIflDI/9khdlPvFhujWBV77O4Oi+OsVTKLwpMX5sQtKcaqYlfFGg
         YDVC98oUi7kd35TRd4mkou1ztHlccc2zGw6o5iKKHerwZSMvtBtkZyWmx/GCkWZ1CGGj
         jJVNPqeU9b03yEnt7Kdcn9wudIS7lPfBqi/tj6Q0n4qTxglMk5eSl00edsIO80fNYV6p
         Vg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778095809; x=1778700609;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PObqSo3yI/weBtZ6Fr+3JYSL4ynGoc1gJ3FrdqU23g=;
        b=lnjAML21h+n2g7eCkkL1Lhc+cfceDWN+dU9zYLqEY/Kb9vpgnAeY4zjpxJzZMyNByd
         5X4pVMZkjeNgE3dwZGZurxgmcBWCNaNsmA+BpqiH/2Epx4+jz9uq6/2OE24Q2ip9SdQj
         bASyufTvQHOMaESMNys5eF5jDUg8EeRNq6hF84rBV8wnhR/db0fDiecTjRf2A8tdO4ar
         TQmejexCQg2FvaNgKO8wchhwikpTNSzLA82wnrKkOn3VOYF5J/mUXH00WzC8BxnL00zz
         Lc7TBLNl8SKCf7pNI3LfJ3wXLDBfYtQpuIRfmMCfrMA/EO4OIRfZDfM8J8F75Laf8RH/
         KMZw==
X-Gm-Message-State: AOJu0YwL56xgN3T0iR6jFgodpzOjRVo77/9/PzBsck78+rnIyU48Cf7h
	wZ4FXIP/W+26LSx6Y+FT4E2eBAZlnoXEZuIzVuCC1Wkj5cShXIveDkgO
X-Gm-Gg: AeBDiesgnpU/pD1FEWMjpiVhZO9uBb1ncNBa0Zu2tdx/wKr8LI6pozjBAeQFXqCMG6U
	AXB2peb7nk6745zWn/kHch2lC26gaXddFrDJSLvW4wBf0HnZoyVAIac2cMydsXs2ZkGEhG/R56M
	bMV2kCO4ZaXLn7KECiAzOO5T+YJjXrFbRJ8kQXHtBGTC1U0lxzUXWSLsVnEhgo5wrloujWdQgi6
	GPlFbe7UCPA2QL98yGuDyA8987jFWdVoPx711hGhheT88Z5G+NfcEJAcD59zRchvH1Q2LKUdAF3
	QVMGVHORuD77Zz6kjKiLzLf0jK62L8nltKF/6MsFjgj+/qMV3BF0dJBGJaual19ht0QMZm1yeum
	POovnKS+F8tEZLxkxG0t9OdTSpKoErTTRLoiqWx/Pj8zm40HDjkVWBwAJDSCpxvNUEh1H9WTn8E
	1lXG6/kaAHRXoRviF9KQ9LxSZMhKjcrdEe4Idjeyz1Cy0kCHHSn8acyI/fORK2tKvyBK9WBnZQk
	HtxwqnsXiovYPQ=
X-Received: by 2002:a05:690c:4510:b0:7bf:27e:66ae with SMTP id 00721157ae682-7bf027e70acmr4609997b3.30.1778095808985;
        Wed, 06 May 2026 12:30:08 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66527421sm82466277b3.2.2026.05.06.12.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:30:07 -0700 (PDT)
Date: Wed, 06 May 2026 15:30:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1dcf55066b2e@gmail.com>
In-Reply-To: <20260505-psd-rcu-v1-1-a8f69ec1ab96@gmail.com>
References: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
 <20260505-psd-rcu-v1-1-a8f69ec1ab96@gmail.com>
Subject: Re: [PATCH net 1/3] netdevsim: psp: only call nsim_psp_uninit() on
 PFs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 59BC34DFCB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285011-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Daniel Zahka wrote:
> VFs go through nsim_init_netdevsim_vf() which never calls
> nsim_psp_init(), so ns->psp.dev stays NULL. nsim_psp_uninit() guards
> with !IS_ERR(ns->psp.dev), so destroying a VF reaches
> psp_dev_unregister(NULL) and dereferences NULL on the first
> mutex_lock(&psd->lock):
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000020
>   RIP: 0010:mutex_lock+0x1c/0x30
>   Call Trace:
>    psp_dev_unregister+0x2a/0x1a0
>    nsim_psp_uninit+0x1f/0x40 [netdevsim]
>    nsim_destroy+0x61/0x1e0 [netdevsim]
>    __nsim_dev_port_del+0x47/0x90 [netdevsim]
>    nsim_drv_configure_vfs+0xc9/0x130 [netdevsim]
>    nsim_bus_dev_numvfs_store+0x79/0xb0 [netdevsim]
> 
> Gate nsim_psp_uninit() on nsim_dev_port_is_pf(), matching the pattern
> already used for nsim_exit_netdevsim() and the bpf/ipsec/macsec/queue
> teardowns.
> 
> Reproducer:
>   modprobe netdevsim
>   echo "10 1" > /sys/bus/netdevsim/new_device
>   echo 1 > /sys/bus/netdevsim/devices/netdevsim10/sriov_numvfs
>   devlink dev eswitch set netdevsim/netdevsim10 mode switchdev
>   echo 0 > /sys/bus/netdevsim/devices/netdevsim10/sriov_numvfs
> 
> Fixes: f857478d6206 ("netdevsim: a basic test PSP implementation")
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

