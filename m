Return-Path: <netdev+bounces-296710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0khyE/AkJ2pisgIAu9opvQ
	(envelope-from <netdev+bounces-296710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:24:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B752965A691
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:24:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UFsbQzzj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296710-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296710-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24AED30485DF
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99F3955FD;
	Mon,  8 Jun 2026 20:21:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0443AA1A9
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:21:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950116; cv=none; b=gWQjHDC0WEaNBdfwOsyhoJsbSIJcukeMpfpEt/QE8tGThQbmi7UvK6+IYJgkIFWudJVXjzILWoPKf8Ak2q73oWf7BgpyqoaRY2jXXdzPUCvYF/auIC75WHBnQqXuvH+KnFGxokkKzMDKI0bzhi8OBD6puTcUx3X8eg28KB9++xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950116; c=relaxed/simple;
	bh=GG3bH0mHITo8e2IjmSNNS0MDJVJrzC4tkYaGrtgXgm4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KOBICbutopxWq182ZO8Cm4+kOdx6RDPGdp2MFNsKR4AEHMJS+u2Qm0LTia8zMn8D9DpWbZ91HN7tquVoPaWZ2lxQw3bcCoTqzX+ou72mgPwlWnA7pk2CWBzPJQqy+G3L8uGU+G0LqFP1U/apeZaKM3oOSRsmKgw29ryM0ZAxjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFsbQzzj; arc=none smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dbcb505578so60574107b3.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780950115; x=1781554915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V71jhOp67264X/ZxF04li/3yqR7bsFMxe8qHJksdlio=;
        b=UFsbQzzjg8XP7LdWWItNuh8flKdfbMhBGa4q/bQRTBwHoc5qOeph1V596HFDx2dmWP
         cqYH3owb3blR3tMjou7DcNGStEpCCjpYsHhK/qwkvobIWszAmZeRciV+yb5W8D0iftWD
         XmgAVZbQm/PqAHAwf2P19yVAh0yatT7jMySYitW9RCsGS3RuFrLod8gRnnbY+nUBKthg
         oVpQ1oMiQZjCRr8CFmJENcdMHsqIQLrG+KSgf03GERZeAXfcVk0W8kjFMiv81PO9Lda6
         2poZ3qF3i5z6ncJF/Bm9pCsin8D7HvTDWRR1RGz785OXAaXAgkAjrbMrR3GV/gcrHcjR
         hP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950115; x=1781554915;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V71jhOp67264X/ZxF04li/3yqR7bsFMxe8qHJksdlio=;
        b=PklHiVD48sWytnP1KM7sGYcj1rR3t9fnTB8kWCo5uANRnx8IqEgANn2d/Pewbhk5v+
         sYraoimf96ry9GVlsau/2LksmOqm4llhPUOVc+UfkXDwg/m/7Ev05c3/LexnoYVa5s+4
         f0l61qvlz4T3AKjYgjcw2ssLB3WreMI+mIBHXKjX4cft7qF3c1GaCHFDMl+fITX9wmuQ
         tuyLXRGznr3bcWw1Dkgnw1dJiHg0xrorxP2hA13ibF1iC6WUKueOfO0AtIIXVGZGRJ7b
         VdkqFkN/fCCLP/M8+RyzS1TU4CQtwaO0L9KYMEl2Si+hfXWgt9G4CfVVT7bfshfr+Whw
         xDqQ==
X-Gm-Message-State: AOJu0YxOrKLkKCqVejgxm6Dmd0/7q4pFS8J7OXCrYmH+SM73wAIpvwkc
	5iode2Zpt8CSW1td3wvgVBnslju536VKKK0E/Zx0hHkt43Octp4GxWbH
X-Gm-Gg: Acq92OH+E8rDDW+4avgUm/JD9rip+8G+N57r8iY1d9VHtN8OTH4SWrN1sWXcS/w6OgG
	xAL9S205VVd1/XoGlK9QMDYHpz1cTdW74s5qwqe7Jn1Z2IMUhGe6Bj3U2PT6vwna2qbKcDh4uI0
	MusjgZmOfYrA+/U/sjxgUYezo5+fvWQmpHAiUN4tIijZUK9m5d6Mm4xUHlfjLmxucO75SgVjJFM
	9FLnWVNKVOz/OF+jWE/qM6LXBW2kYFL3LeY/3P3M+cROW9tKcnG0xGH2R2UJpTUlUFzlOYJcNlK
	R+3HuKZYo9Z5T5pVoluJh/WhiUiYAEIvHUgIiSWV80TWebBlQ5TJFcXnsNVhNz+iAqVXRK2oBoV
	zpK1uENLYDrE0+lttp5M+OlfWzrdFVL215SyqBDZW7KRPFG+yFO6T5WgGB5kQV+siC95Gj7xaNu
	+EwUw1+wRXc6Edpd7C4pxixDFxwLY/cg/ahVGr8yzC5EDVcgDEVzVay1U4bPo4r5KNpF0h3JcKS
	TpR+pJ408jVm3vhpQ==
X-Received: by 2002:a05:690e:1904:b0:651:c268:479 with SMTP id 956f58d0204a3-66106fc2e92mr16073089d50.57.1780950114602;
        Mon, 08 Jun 2026 13:21:54 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f883e2sm9799891d50.6.2026.06.08.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:21:54 -0700 (PDT)
Date: Mon, 08 Jun 2026 16:21:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.307535947a9b5@gmail.com>
In-Reply-To: <20260608173305.372987-2-kuba@kernel.org>
References: <20260608173305.372987-1-kuba@kernel.org>
 <20260608173305.372987-2-kuba@kernel.org>
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: so_txtime: remember to
 deploy the binaries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-296710-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B752965A691

Jakub Kicinski wrote:
> The test seems to be written with a single-host loopback
> in mind. We need to deploy the binary to remote before
> we run it. This is just fixing an obvious issue, but
> more work will be needed to make the dual-host setup
> work reliably. Most of the runs still fail with:
> 
>   FAIL: start time already passed
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

