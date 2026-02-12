Return-Path: <netdev+bounces-258395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OwhA6smjWlOzgAAu9opvQ
	(envelope-from <netdev+bounces-258395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:02:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F3128C23
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C72C30C0302
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 01:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0141E47CC;
	Thu, 12 Feb 2026 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DElgZIuR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638F194AD7
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858111; cv=none; b=N9THunUjQ30LaUwQsRIJx9hNIMB0fHDiaaJwH+46FouqIgibW3qZRXpZ5UVjLCSs55qmEfqVf8Rq54Z2YcfsS1PRwH6bRxhWXrCY2Gx647e0agJOdpGhmzCaXxVJuNzl++RgeMVz6bvSbcBaFS4j0LEHbK9Pwg1SnprfItLOZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858111; c=relaxed/simple;
	bh=DhtLQdLk4//tf3IWa0sFbqjSiWxG7QTlVQuS6MoOfc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kgYsH/kDAz9qvkZ+MKBO7LUIx3tgNYhe7rB1HLby32h2rN4Exn/Usj/eZnIZ/fSwaPCTPdPor80qH1WCn8OAK0XrUK4ntyivhuzYCtI6HnxhhZ/UL50zItQMtLyaxo9hp3bP02O7Fyp7O2yPDdzr826f5bWclTz9G6v7oSvuWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DElgZIuR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7963b25e0ffso41370167b3.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770858109; x=1771462909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaO2rgLLeJsYAQ1JVqZj/x1A/K/JlZAmp0S9Yly7UAI=;
        b=DElgZIuRwrVqzcIquXrLXlvujcgifCyWFirZ2r7wQrvjBZyqVT2ZWd7S5Slcw1uxHg
         PK/E0bF7p4DYE/2cO3M3o4dZQhl0U2kwCv2i/VOyyp/9i3YMQawosLBeQz+9aBvHAiuk
         EhNrocWhmVn5khubTjAXqk58R8KKIFiuvmVTP9Gw8tg746VsBcTWW0/EvUjLEr7U2srV
         +/4hg+RKLtSE+5N/pqrvemAdpWhitKuQhFN/9tOOSoLFgJOZkYP1zaNtfsEZZ5oi8dM7
         E4KkJSwyo3lZ2erwJX4VoWrHdDGzVRm0ZOo/mfPh7G5j/IuGkIkHAAZPOVZljuXDb8mr
         HCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770858109; x=1771462909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HaO2rgLLeJsYAQ1JVqZj/x1A/K/JlZAmp0S9Yly7UAI=;
        b=KdENxJrw9lw6eFzOgnk1SuBtOsi71GnmRNKRW7pzG2UjiaQGnm+XBrzY14o0O3bZcj
         nHSnnmUqXELYwpe1mEt5R/8e0I1AIYFJpb2OKXhhgBoMMmaZpcY0Cu3cgzPyqgcRbXSU
         orjc+QpXo76P89A21H+Deq/VHKCiG8+mUiRYz8mtUn/7w6sVVIfVwto9Bk6fPYNw7E/b
         2gLcwMEjE1gvjXADky91y94irtAzpm5mAkqtkc2GWjc+F62AGDIrCTDq+xxTHFLGpDgx
         oVPtNRt7aE8hxnn5S2TohzK1BVILPDDpUW4RCfkAIpHuzpu8HBoKJqNiI3c4v1PNVo/h
         tU3A==
X-Gm-Message-State: AOJu0Yx23uJIgqrTl50/JyUVPSCo9S86LVeJMEJTVz7byN8OkvX3eB7R
	+FCSpyRn/O2XZbov/280V27Nqxai3dZwgfWRxvI6+vFFTweYrEitqXYL
X-Gm-Gg: AZuq6aJVp4YHT+2vr6gB2tlx9ydI0/fPdTrkoZ1J+dkr50lTmWc1p6NadUguPVve3Yt
	Cl3gqMxfMPq7FJaJjQiYCWuV9c2iT+5OV+yEhQq9B8h48atmSjz9r85X/VbIYY7365FuwfeaGx7
	m3EYv5KEClQGoy5tw6o/6Xds/qdL8O8pqUeGYblHqhOyBO2My8NbPWkt7VZ0Z6HeZx1oklBSo3u
	osm3joRJvTSoOhk9SlmOq4xDztJLwaNJLd+EQblOrb15B/MZZNC4Hn3PkiqO7BJm2MAtJJj+MBG
	aCLGpeK/RLM9ewcVix3/JhCWVwccqw/6C/i2G4x0rcrBcqdPtznLqcFboDHayNPV6NyjVU2YxPV
	+dGPlJnK3lgJJVubDcE7oYgG7aU/gS0Y+lgsSOGLQ5paqbREQpsh3O2+nskFTNuBNP9tc12vtfB
	+XjtIvvAt7SEoc4DX92v5s
X-Received: by 2002:a05:690c:829:b0:78f:a5c4:791f with SMTP id 00721157ae682-79737673ad3mr10749977b3.54.1770858109608;
        Wed, 11 Feb 2026 17:01:49 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18b464sm33329567b3.13.2026.02.11.17.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:01:49 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 11 Feb 2026 17:00:42 -0800
Subject: [PATCH net 2/4] eth: fbnic: increase FBNIC_HDR_BYTES_MIN from 128
 to 256 bytes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-fbnic-tcp-hds-fixes-v1-2-55d050e6f606@meta.com>
References: <20260211-fbnic-tcp-hds-fixes-v1-0-55d050e6f606@meta.com>
In-Reply-To: <20260211-fbnic-tcp-hds-fixes-v1-0-55d050e6f606@meta.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258395-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 9F9F3128C23
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Increase FBNIC_HDR_BYTES_MIN from 128 to 256 bytes. The previous minimum
was too small to guarantee that very long L2+L3+L4 headers always fit
within the header buffer. When EN_HDR_SPLIT is disabled and a packet
exceeds MAX_HEADER_BYTES, splitting occurs at that byte offset instead
of the header boundary, resulting in some of the header landing in the
payload page. The increased minimum ensures headers always fit with the
MAX_HEADER_BYTES cut off and land in the header page.

Fixes: 2b30fc01a6c7 ("eth: fbnic: Add support for HDS configuration")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 27776e844e29..51a98f27d5d9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -66,7 +66,7 @@ struct fbnic_net;
 	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
 #define FBNIC_HDS_THRESH_DEFAULT \
 	(1536 - FBNIC_RX_PAD)
-#define FBNIC_HDR_BYTES_MIN		128
+#define FBNIC_HDR_BYTES_MIN		256
 
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;

-- 
2.47.3


