Return-Path: <netdev+bounces-296723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IhB7CSEuJ2ovtAIAu9opvQ
	(envelope-from <netdev+bounces-296723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:03:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 726DB65A976
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:03:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=obmKeJRE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296723-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296723-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C36FA3050474
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE23AEF24;
	Mon,  8 Jun 2026 21:00:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584D3AFAEF
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:00:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952403; cv=none; b=BSL6XZj799ldsAV0b2Kik+2ClPbPfH9aB6KT4y98i4QsaiCD52EJ7FflBJsxeVBkeHIcJqI7VZhEo/Df8N4F2Qf1bNgWXtL7E1yUy4Q405/8i07b5IklStcDxRiV4nkoG9WSQlNPPbJVEvhzhhB/TkgnnMIhrtEtN3mNWfQmnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952403; c=relaxed/simple;
	bh=YnG669LdQI1Qepo1x0Tvjca4QVrQO2bT2gbR9OyAwoc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jWMkkJOEASpHZotYeqdbs7cw+P3iw9yK6s+TMwXhzsVtNVD4yKR0PNGnH36wM+mLwo3ZaeM3mUjSUsQao10bBOb0CSRZNw4Ti9kM6VTDUGvrffUcY//O2YJJ2plh5BOW675pueTatZgkPopKEKsNV9yYXvsXEHa5yNTVBW5KC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obmKeJRE; arc=none smtp.client-ip=209.85.128.171
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7dbcb505578so60991377b3.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780952401; x=1781557201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Oijz27RrPucc9vTX1j7ZWYkRtkcGQCqgqETYUMZp1U=;
        b=obmKeJREoeC2NQfoL7t35kLIXOvJQPLvjNo/i3yAEWL79OBgT57UBQsH9bPdkqcULg
         lYN+hTdfweclCFPCOSBxqp9GlmsLpz6H/2lz7LlqFriC3vlDrhVKzCYWY9H9X1M+ZUsu
         HRXwiWYI73kUIHh2JJgDdgEBXKbPN5kLSG6RQe6EKC9FS6/boBIaoWC2UDfFsWDhh8nl
         CCAFzimvPUtM/+9XUqwGdyUDDOck+QBR3sZ9hej0HANPdnYxGU3p0wv65BgkUBB+/k3Y
         kXcl1nTV8ZpFsivUl3YVoGJxVMTpEdOSeNpWKs77s2uKT8PNHFtVi6y4txUI6yCjb/SB
         4FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952401; x=1781557201;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Oijz27RrPucc9vTX1j7ZWYkRtkcGQCqgqETYUMZp1U=;
        b=MVLCVdlwWq0yMHN4shPfC1LNPLQVJBGMQvV5FvZbjtl4fUGmnDsHHvQfZLPG/ivNwn
         cayqCEdL2Fs54IuGUGrO0yZlP82jrcHbGdjfTrLshinXWsM7bdpJeCmZt+TxsLhdVuNN
         TTkP9aErSffqPOwm0AEvdvDuTIfQVgG9c4iBuQEY+d8vvbYcKNld9J2qxrZbsbp+GZQs
         zYKEzuitPLE4jNuoT9EtepExv+c4qaDinLrZWhQP639DAZPUBenYzxKDr+h6+EcelogU
         15NIlPRm5zk5qRCHqgrEUYgN8k6SScWzZL6GU38MxUdAzff1RHVglEYYSi31zazuJAGe
         fRWg==
X-Forwarded-Encrypted: i=1; AFNElJ9SqLjgiG6fTRqTDlFuYovr8O8Y7tyYSSfmoDOj/wOXoRfPq4de+rZDFh1Hwev7D68/soMgB1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzir4HAFUZjMrT2NLAiXwasel5md0kcSd3gL8f3Tkspngtu/KAJ
	anGCl31u3XpH+Hqv0Z25Stxe/BDQ/AM14HQTINA4Gkar71nUH6ZWRqlB
X-Gm-Gg: Acq92OGGxwKFV4NLY2yUQiE1TxqvKfH5TbaplYlKTqzY5YnSEKF47yyNDfqcSmlqWrL
	0abEzYH3EO6x6LthFYpHPL+bocYfLCURYkHUn0OnDFqJq/gRLndphiSwqoBpljORsNw5LPPvaXF
	vuFdr6807JOLxq2BcjadMcuzoP9ZpFQERCmATh+Q7dTfn8o0ZPJnvf5nirCefrWe7RIzGxjcp+1
	tQabHgqTKsQkU2ozZH6zyMpR7M8kz9WQ9jEP90OoVlcmS9Udhyr3b3MBHxsbISlPtoR8lQT1Bom
	lA8W5VIl1jHNCUvi0M0siQcscXJ76/nhR3sM6s2dsC3UZ4YPjHJ25gsfHbDhuikEBTPxMfRciGl
	54v7pvJCffLVGuTc0WRDM7a/2qyUfWqd6d2aImMZVEjUQ1j96l1x21rrQuFhIYwQ4g/Ymvgw8Gm
	J7e7stTlhPBVyFBhbEhUlcpKhlYFHriYTI2mzr/uK/gtdUVO6XQ4v+IaL9+MwWgB5nhwsa0bVRf
	RBMMFqUf8XvNZ4hvA==
X-Received: by 2002:a05:690c:3391:b0:7f0:4c1e:8b83 with SMTP id 00721157ae682-7f04c1e9926mr74676037b3.36.1780952401339;
        Mon, 08 Jun 2026 14:00:01 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea9f9csm88488757b3.1.2026.06.08.14.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:00:00 -0700 (PDT)
Date: Mon, 08 Jun 2026 17:00:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kyle Zeng <kylebot@openai.com>, 
 netdev@vger.kernel.org
Cc: uniyuki Iwashima <kuniyu@google.com>, 
 Kyle Zeng <kylebot@openai.com>
Message-ID: <willemdebruijn.kernel.fb60798ea1d4@gmail.com>
In-Reply-To: <20260607021819.49698-1-kylebot@openai.com>
References: <20260607021819.49698-1-kylebot@openai.com>
Subject: Re: [PATCH net] net: guard timestamp cmsgs to real error queue skbs
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296723-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:netdev@vger.kernel.org,m:kuniyu@google.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 726DB65A976

Kyle Zeng wrote:
> skb_is_err_queue() treats PACKET_OUTGOING as the sole marker for an skb
> from sk_error_queue. That assumption is not true for AF_PACKET sockets:
> outgoing packet taps are also delivered to packet sockets with
> skb->pkt_type == PACKET_OUTGOING, but their skb->cb is owned by AF_PACKET
> instead of struct sock_exterr_skb.
> 
> If such an skb is received with timestamping enabled, the generic
> timestamp cmsg path can read AF_PACKET control-buffer state as
> sock_exterr_skb::opt_stats. With SO_RXQ_OVFL enabled, the packet drop
> counter overlaps opt_stats. An odd drop count makes the path emit
> SCM_TIMESTAMPING_OPT_STATS with skb->len and skb->data. For non-linear
> skbs this copies past the linear head and can trigger hardened usercopy or
> disclose adjacent heap contents.
> 
> Keep skb_is_err_queue() local to net/socket.c, but make it verify that
> the PACKET_OUTGOING marker is paired with the sock_rmem_free destructor
> installed by sock_queue_err_skb(). AF_PACKET receive skbs use normal
> receive ownership and no longer pass as error-queue skbs, while legitimate
> sk_error_queue entries keep the PACKET_OUTGOING marker and sock_rmem_free
> ownership.
> 
> Fixes: 8605330aac5a ("tcp: fix SCM_TIMESTAMPING_OPT_STATS for normal skbs")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

