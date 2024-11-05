Return-Path: <netdev+bounces-142052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4939BD3A2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBBEB2130A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC31E5709;
	Tue,  5 Nov 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hd5nxbTj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0A1E3DC1
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828651; cv=none; b=cTSizPSpqR4jU9zyftO6qLYTAxUBOW2W91WOShOwuaOQxSh+h+QDVyd30Sxlnn/uXk4KTL4gN5lr8b/lNSllIERmhLurzlHXgXgBuBC7QL9C10QpHAiEDkCnpEDEpAGPeK/weAbaotgItXHU92VxEow4PeFQIkLQjPp7THQQOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828651; c=relaxed/simple;
	bh=LJOQMLlA26Q290qA39cG9YTSX7kqLdq64iNNElxTlac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eZqDhRKAgsQ5QrkvXqpeNMGxtEjXilFdEtxmM3fBWGVPV82mtgoHkmZL9DY7mbgxk+t9Ez/bfZfYv0VVjFRR8Fg6B8bZTvTRQ/1h2vjdgox1mEnQJRzwndEEhVpXnGxgmrLrZ4lOO6nc+IrcMqjEypPmeYrZ4WgzqEu1ud3Wkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hd5nxbTj; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d35062e1fcso79616436d6.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730828649; x=1731433449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6m10eq/NSUt3eEIqzqDeIdNeLEg07jANrEaMvtZtdlI=;
        b=Hd5nxbTj76mCsMnUlXcqXZBnvgsHF15JZp8Gb5gzSzr5uGXuJ52AxNdD8C5j83smPQ
         z920zaRzeAkt0La4Vnp7LL8Q+lDez0ZzADPTSEyoY4GTn2s4E/qNIvA7DBl1UALz14/p
         K4H3bdtD04RMet8256GPOsDoLwq+DYKyr4wVJfX+LXcjVv4JHkXCssPk3fxfayB0vTea
         TLZALRc3rilHMiopRvIPWMkM/qEFiuPNiiABDWTdmTiSUmPugEGFPTJ0K7vUQVln2QYw
         eGTK9mXgsDFp2ssJF4DFBMlFcHkVuxh33IKVySU1RrD1u4O0zIcH9cd0J9XSvA1SS7az
         06rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828649; x=1731433449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6m10eq/NSUt3eEIqzqDeIdNeLEg07jANrEaMvtZtdlI=;
        b=d2cUaD+c9+l0494x8OoXDaZPbIcMWaEf0tZwgIJSErlc6jGaET4maHXLecEdeVmrG1
         1eI79xrRPiusFEIkAyVD49Ltvus37Ge/yWxipQlu9ConuDufBQy9ZcBi9i31PQ/o7rB9
         kxVSKEZPyLc7YfgZJFN3v/E6q0N2HGYJpcxtgoSIdGQG9K1ybKuqUavLyuISblhBpEWP
         DzBMteLKxLBC28fYw+LNKMsHrTwjz8G4rYP77E7yBaVOw/lHdbtzAVhg2aES47JuQcty
         rxyhf+mcPpNf+qnH2Qrq1bd6VkOlwlrIvqjU8ykNyWlvjyJEyxwY1PEvx/lhROY2413x
         FCFQ==
X-Gm-Message-State: AOJu0YyzGN+XWcFvyB1CtjQPbTx1jF0pWgVhKS8mq43lcWb6Q7otl4wv
	9+RUi3M9Ws7ZJ3Rn1EzH4EnggqaotKCxquVQjgQiWFJevSSmfH0LQfEBj4P6MjByKb6msOgK0c8
	7Fb2EzyoNJw==
X-Google-Smtp-Source: AGHT+IFi81xLBR3cNb9BziWG8Yd0ZV4rTpS1KI5i5jiyeedptgcmhhUiL6RKb5ryk9Knswf6HWxo6jbm/vFiWw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a0c:fc51:0:b0:6c3:5c19:e749 with SMTP id
 6a1803df08f44-6d35c0802f6mr145556d6.1.1730828648604; Tue, 05 Nov 2024
 09:44:08 -0800 (PST)
Date: Tue,  5 Nov 2024 17:43:58 +0000
In-Reply-To: <20241105174403.850330-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105174403.850330-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105174403.850330-3-edumazet@google.com>
Subject: [PATCH net-next 2/7] net: add debug check in skb_reset_inner_transport_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure (skb->data - skb->head) can fit in skb->inner_transport_header

This needs CONFIG_DEBUG_NET=y.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5d8fefa71cac78d83b9565d9038c319112da1e2d..75795568803c0bfc83652ea69e27521eeeaf5d40 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2937,7 +2937,10 @@ static inline int skb_inner_transport_offset(const struct sk_buff *skb)
 
 static inline void skb_reset_inner_transport_header(struct sk_buff *skb)
 {
-	skb->inner_transport_header = skb->data - skb->head;
+	long offset = skb->data - skb->head;
+
+	DEBUG_NET_WARN_ON_ONCE(offset != (typeof(skb->inner_transport_header))offset);
+	skb->inner_transport_header = offset;
 }
 
 static inline void skb_set_inner_transport_header(struct sk_buff *skb,
-- 
2.47.0.199.ga7371fff76-goog


