Return-Path: <netdev+bounces-259050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EInKKH54lGkDFAIAu9opvQ
	(envelope-from <netdev+bounces-259050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:17:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6A214D12A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B61C1300A61A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0A3164B5;
	Tue, 17 Feb 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2uxFfvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155320296E
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771337851; cv=none; b=kEHIctQQN/b5TGIQXQ+5TqiSXM82PMvW2VkVghH5yqr2m/pZNudKjPYPIbZ5LsEzxENxeDdblrYfjaT/YssCQTlxLeOGb/zoJR1GBXs79hBuGnIEKjea7eoJPLO4ckqgZ11z7xsY7ZVNDJhI36z2Kr+D/vNz/ML11PdottL02xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771337851; c=relaxed/simple;
	bh=nvNtpLa3XCTU00EV0XLITmZ01O3NAvdsANK52o0aqfM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GeYQgeEEnLtF7fO3ULLzPtA4XMjKC1z/mqhI/R+i6n6JUqOzZ6oOi+MLQzN13d2cVuxcMR8Ml2Nx3z4EdA0TydbPzdk8pZ6OIVrq7RJ8CazNW+EIVx7+BR3TylNgRGgyoK53hob6K5EkFvZtq1WZ1bL/cdEEoTgzp5pe5Lj+NFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2uxFfvx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-790992528f6so35609387b3.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 06:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771337850; x=1771942650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPqS5qJZxVR6nSx0qlOH1FlzctRqYngHJBRgOUKBj5s=;
        b=X2uxFfvxihKKndKO/lvcCYTWpRS00QEPIiQEbr2JaN5eRgDDNRz6uVYHzIo5+xi1wX
         f7yVJ4B87ICYU/tPgXrrf8ujfp8T+0GJC9cpe9cUFrQaM1LkRNaoWwWbt6VaLkdKR1cy
         NZxYq2g3hFxZUuP1IDB6AS79NZ+1OvNXy0ayR2efclhA5eqvHTUcmQOK6kWTZ34tDUTD
         3iIlmqv0M57TDoRbVUdf/V+bzl14hlyaxZBwGkvX/9YUb7W/HDtZXJ9Z9Yo0fuOB7uR5
         onA58nam6mWvkS3M9nJdIW/J5v8pZiN/Fv1rwmvCPGgamSr3xjyORx6SIFozUwPwCWuL
         rnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771337850; x=1771942650;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPqS5qJZxVR6nSx0qlOH1FlzctRqYngHJBRgOUKBj5s=;
        b=Yx8DbjonZX0sDM8CkEU2owoWsaI/Cz8XzdYCqg9tPsCFvjatzxbw9xyr1gUOR9T8Gq
         tihcHnto1hzBkhbLvDR38w+dmfGk/XbksSrXhDQDkrfRJXx+X1mVk1j4CiN917/d+xh4
         jux6QvOzDuyWcLZ1e59chQDib42viVP0xtj0QI44/3ORvZEDhGGlvmZGtnpkT7AJz73d
         Ur57WKfXHjt06H/fvdDxZ64GqVn6vPycde21lickkiU/eEACdp8v6LdWQEUvnra5Ayxu
         JI6y8XSkMmrrHBLrVok0OdHvkOqXtmcR0A9veVlZ594Uymkc+3WFy5HzG6BzrP6WRg1y
         NyTg==
X-Forwarded-Encrypted: i=1; AJvYcCVS3Bw2zdg6ChQi/XD7pLpPhTJbENTuDG+UfuLbQ+1GBubqD5VxuHu9kb+7jzBsOf7HuzGO0h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oCDn6PAwbbjLDR3TZIxD+lZmIU9U8ePlK1n1gBY/cPDMiWyQ
	8t8XzkNKsovB8i54Jr3mNl+hqaKcIr5+KrvHh2eMtauqA/h5Omj15ofE
X-Gm-Gg: AZuq6aIuoCchhV+Udp6FbywVCEbXqSjay7yiFWntLmYw+X7UqUUwdIgv0RdEFj/y9PL
	A9PLBleoAXIIx1SAr8bjnR1pxjrg8qjFBdy3C8955gUpQ9vtLxX4IEDVODTauw60jGkdFnWLz+Q
	I+VRwvDkK5iKANnL9S0BtOjrnyrNx3i5aQl4Mc38drDEAsIRzGhc//VY93vlii9tv8miGGZaF4w
	E8EppQF9+/Ap5Nm71qg9taojtjEcb599LPUc0pvhQ2A8FiUVxs59uoEyaJWhjqQ69AOjyWLN3O8
	kOUseHPEblBBe/zRZYS6tp/14qLCsA7eiv8Cj5t2VN5kjdK1wDUsQP5Hngo6kbPv9h2dlFXOHpL
	RNurz+c9yy+VEgkOCD2tWaAFFbMaWGw8Dlk/xIOEuV7MYEPYccxrjL19jIjTr0HFWWUjsNKzKWX
	W/LgeCdufQMLtWiPBqxLwvzF3FgoSBqgKEGxTIGKIofy9kTv0/Skiy2WWfSoOGvmxYWBVyx9I=
X-Received: by 2002:a05:690c:e3ea:b0:797:ddf2:7cbf with SMTP id 00721157ae682-797ddf2b7abmr35062537b3.66.1771337849577;
        Tue, 17 Feb 2026 06:17:29 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7966c267b98sm116394877b3.49.2026.02.17.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 06:17:28 -0800 (PST)
Date: Tue, 17 Feb 2026 09:17:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.250288c955291@gmail.com>
In-Reply-To: <20260216193653.627617-1-edumazet@google.com>
References: <20260216193653.627617-1-edumazet@google.com>
Subject: Re: [PATCH net] net: do not delay zero-copy skbs in
 skb_attempt_defer_free()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259050-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C6A214D12A
X-Rspamd-Action: no action

Eric Dumazet wrote:
> After the blamed commit, TCP tx zero copy notifications could be
> arbitrarily delayed and cause regressions in applications waiting
> for them.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")

Reviewed-by: Willem de Bruijn <willemb@google.com>

