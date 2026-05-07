Return-Path: <netdev+bounces-285436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C2PMOpTH/Gn1TgAAu9opvQ
	(envelope-from <netdev+bounces-285436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:10:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C04ECB32
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5DBF3044A6B
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB03E7151;
	Thu,  7 May 2026 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieUmIgrG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vb12oJn6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4729827E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173722; cv=none; b=pZp5+nQ6FGOGq/BEm9djNbyuAptxNSml8+tfb/YCC01o7eaKo79Ibqd+WjsbYxW5nAcG8TF+nny8EsuxY2vaFAmChjY1rDAGWOb5DJpbwI6zgHNKPznBlTLC7na43Q905HLF+yKkPjoeXE5UIQjWz1Ql2m9rybCEvJjQSlR825s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173722; c=relaxed/simple;
	bh=k5L9T9HuspKLeaPcV4E6F4xntMBi1FakBcE91U1GjXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I50deE1UG17Ppv5dlKd3vfsIdp4ABiCsmLVZKpbinCwj0XHapKTsIV5bNPP5PGvqcfUX2yo9Rwct8c2uXZjPmeLyC/D5nMqtX9eh/GbvDp06oBsrMtGK9K9ZD36R+ozJXLDhUmwsOlWz6wJF3H/vKOWz1WXEBWUGGzTquczwAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieUmIgrG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vb12oJn6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778173719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g8BZOUIqwFMf5MczCTWS57/QZes3BdStmRaQBqy/OM=;
	b=ieUmIgrGp0qdnGGLJ5aXXJ1WbFPv9CTo3dB1qYW576s5AM/SVK1Z8Sb4DS17IN2jsDIBLx
	/0ZsIsetdsf/gFGycEIOZDsqHmyToEnj6R1S8OOj2vAoVZOk7rIPgcopxAMfcww1/g1ZfD
	8HD4JTUX7Uht/gZv3DIZwBMs0QDTzzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-ukS0AcrtMOSkDmCN9gA_KA-1; Thu, 07 May 2026 13:08:38 -0400
X-MC-Unique: ukS0AcrtMOSkDmCN9gA_KA-1
X-Mimecast-MFC-AGG-ID: ukS0AcrtMOSkDmCN9gA_KA_1778173717
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a7994e8ddso7756275e9.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778173717; x=1778778517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0g8BZOUIqwFMf5MczCTWS57/QZes3BdStmRaQBqy/OM=;
        b=Vb12oJn6O8xgf75lpVlNhN2tOaSohb/WvVg4aKzBbmbj6/0YSmRWY8/2+XzeV8sDFJ
         KFSBpdbg7Q8q0uNFen4ut543HbG5rfeNXEP9CBafZmPAYuhiHENkWSP1U2cWEKgDjias
         NJVjiX+nGaCmNjvGJZtxruJCkCCDGCRWvmI8WGZObF4BVoCNDK8ahHOnaApwEWdyqQqf
         hqprGvd5iuH/f5xcwPQeOtAY5u3dR1kC6oO0V+GFbFxl9ws+vtq9kfSa60BCId9oOJuG
         z6xFfZ6YLh0XDg3LCnkOQzFEPuXSouwPiS2lRMcHFM+QaR2jD4YBuUJJe9KTJ+8UWsSl
         QTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173717; x=1778778517;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0g8BZOUIqwFMf5MczCTWS57/QZes3BdStmRaQBqy/OM=;
        b=WS9b2Pwu6AcM3DBLLPxu5LNX2snJva8RYBCWzhF1XBpjZNb9wZFutlfeMcbpdZoeoi
         khkaotTfsFxLuanK5o+RQttGpwGWf5weMt6xEloV4iNh1ldayk2kDN55NSIYvDhPwiAH
         NKMZBLbepamdG3nIA5nzItJHwLl2xjlbTE4eTV6vFmpqT+1+kaxFvtCm0TCLyx5Zw6jk
         afk0Kwwv1K5uCt+xVmjFzX2lm4f5RUl//95YaDZBdUI+9O/xFFwkrqRGLNLrcU2V6+6Z
         jKGUIE4v8UnH7FgVas6M+GpfNf0pA9yajj0qO2BSTVzlBiUR0xw3r6BIrDMKiRo5aCSq
         CvSA==
X-Forwarded-Encrypted: i=1; AFNElJ/LehyhLFqUMTq8fWXZlaxp4F/+Uj3qKD4Ox+MgXrkp0e5ncBKqA2PhEZQeFYjcPLyutTjAm5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8JliXcsFM5Rfu8hkfRUH2iYBby/ys0h6KbMAiAz3stllMvEv
	/fuT6c0MAzOI21Wbkf9dlCanBZ0UtNiU2s0Y3fZ2iPehkW+ExDM4/WSisRXRcYlTFhGQw7QxqSz
	prMRepret+7+pPbbYdUV1eO5PZYlT0TJUeOont6qo5hcOxvH6i3nBrfT7EQ==
X-Gm-Gg: AeBDiev6rsSKRoUtKXfCrqTYOEIot1tqDejBc0zXmNX7n931XAiXF3hZTSpJelmr7oj
	NnqSqquR8DCqyIzY2zCjOprD1QyL0imQOziQ9jtejLP+I9PACtgx0TsgzrbsRZan27wxikHNDnq
	ns1TE78qnz0QqmFjSq2Q+SVdIAeE+x0ObKPtMpnhDye76WYrNjGBaj9YDJPXNbYk1FDus/7L2P2
	BrzMjBSRCRVxqyjJ1mii/sfa3BUmbOpD9IgmyO8RRfbG8N140RYjvoka/GDB6YyC/nyiO0jQo0M
	s8ITC5R8MJ83IplMnVglwVFnoV4iJ8DFli5bC4EHLe9N9P+EwB8KEBFK1BwSLgau6doDLYmlhho
	tyQ2Tz08CXsAkvXVmCyy3/4pHpjQ0/IGp3uV2cromDhJxPkKyO4vHybY=
X-Received: by 2002:a05:600c:8485:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48e51f32811mr149911035e9.17.1778173716950;
        Thu, 07 May 2026 10:08:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48e51f32811mr149910515e9.17.1778173716440;
        Thu, 07 May 2026 10:08:36 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45417bb92ebsm329213f8f.37.2026.05.07.10.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 10:08:35 -0700 (PDT)
Message-ID: <b04ca1cb-6247-4a6d-9c86-d86648a7a4e0@redhat.com>
Date: Thu, 7 May 2026 19:08:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: serialize subflow->closing with RX path
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, matttbe@kernel.org,
 martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com,
 shardulsb08@gmail.com
References: <20260507072802.612125-1-kalpan.jani@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260507072802.612125-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 728C04ECB32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,mpiric.us,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285436-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 9:28 AM, Kalpan Jani wrote:
> There is a race between mptcp_data_ready() (RX path) and
> mptcp_close_ssk() (teardown path) when accessing subflow->closing.
> 
> Currently, mptcp_data_ready() checks subflow->closing before acquiring
> mptcp_data_lock(), while mptcp_close_ssk() may concurrently set
> subflow->closing and 

Are you sure this race can really happen? both the relevant part of 
__mptcp_close_ssk() and mptcp_data_ready() run under the ssk socket
lock.

> @@ -2653,9 +2673,12 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	if (sk->sk_state == TCP_ESTABLISHED)
>  		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
>  
> -	/* Remove any reference from the backlog to this ssk; backlog skbs consume
> +	/* Remove any reference from the backlog to this ssk.
> +	 * Serialize cleanup with RX-side enqueue using mptcp_data_lock().
> +	 * Backlog skbs consume
>  	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
>  	 */
> +	mptcp_data_lock(sk);
>  	list_for_each_entry(skb, &msk->backlog_list, list) {
>  		if (skb->sk != ssk)
>  			continue;

The real problem is here: the backlog is currently traversed without the
data lock (wrong: the mptcp_data_lock() protects backlog updates), while
the ssk is still possibly open, unlocked and can keep receiving packets
and adding them to the BL.

A better solution would be something alike the following patch (completely
untested):
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 718e910ff23f..68d97926cb81 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2550,6 +2550,21 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
 
+	/* Remove any reference from the backlog to this ssk; backlog skbs consume
+	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
+	 */
+	if (flags & MPTCP_CF_PUSH) {
+		mptcp_data_lock(sk);
+		list_for_each_entry(skb, &msk->backlog_list, list) {
+			if (skb->sk != ssk)
+				continue;
+
+			atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+			skb->sk = NULL;
+		}
+		mptcp_data_unlock(sk);
+	}
+
 	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
 	 * could be negative at this point, but will be reach zero soon - when
 	 * the data allocated using such fragment will be freed.
@@ -2653,17 +2668,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
-	/* Remove any reference from the backlog to this ssk; backlog skbs consume
-	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
-	 */
-	list_for_each_entry(skb, &msk->backlog_list, list) {
-		if (skb->sk != ssk)
-			continue;
-
-		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
-		skb->sk = NULL;
-	}
-
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */


