Return-Path: <netdev+bounces-251315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32243D3B931
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D56630A8D63
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C42E0B48;
	Mon, 19 Jan 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="E7+2jHhW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34F2F90DB
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857198; cv=none; b=tlK3E1T69DdoBmez/I+OaeLVLj3GJPDwybxCJua7fi/Rv4mnlDJFw6dGjMDOdpc4ijR3B/4EAuYAgAMiRi3kNdIVYV0LmLWcz62e25lD5pZ7xXr6Py2vlRnbP6dTaEKmtnCbGwhtbIsrbrkoSCQB6RW+AZnKJsW4oYbCWja+s7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857198; c=relaxed/simple;
	bh=qTopuWubtrMFV6MlxNsS722c0Us+1x0uxe4yrXck0ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxC2FJj0dxmGgRdumTvhUdqeD6bGJelQ1xCZ3RNX11ZbhNISjB6ClyhoNuI8DhTsq2qlsi+28lJU24mGIoGoGXgjnMzzJJvj6mvVtPLjyRyXUntCbLG0IYJvWj9fVnLJaDiG8WCLCK9g60pp4DeOnLY/AmoE+pRUv0VMVTFannc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=E7+2jHhW; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso5629461eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1768857196; x=1769461996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPbavb2sJQGlVQhbrX9Rzn+WVTbW2cKCuvhKEUeejoY=;
        b=E7+2jHhWGrclLMCjGhZSOA8Yfkg+J7dNYhVU8GkgodvmLU/YZuLiEE3ISYs8eh6u6t
         OeTIOlb3dxALcjy3fNa6Ek75U61Rg2cv7UXrtAKkSqRJF9WmO9HTQMhCv5xR4VHSpkWB
         +wUbhVbJfFv/DvdI3ll4J+Nm8v9sQLVOPrjxQtYN/U2VK1sTbpn87pOjLfYGSVu3G7yO
         jJYFltD8v2DMUh9wQ0msNp/fOleIRr1gKaq3RY31/t7Uzl7GHW2RbA5CqXC3o2YKsPTt
         wU+gzAuZ13Gi6BrWl6uX183gIOfnpE7iXkIrUPNLkrMika2VZKoETFD7eOKbQigdCRxE
         RrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768857196; x=1769461996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kPbavb2sJQGlVQhbrX9Rzn+WVTbW2cKCuvhKEUeejoY=;
        b=oMTdIj/wVRbhs0/aK7rDuUeC1b2VMG+cSo8naX0tX5z2SYTuUPDsfOB4hD/SvWED3N
         09M0Zllb15nGG9O6ucwv58hntxWPNMG2rdW9FaAwB5yW8FACkxAR3M9tkwqadtI0HRx6
         463bikn/v/OHpIBkV8WoBF2Siat23YYGWA6SeMeBsqAl0dqqLR6OBrprNzft4MFWsMgP
         sCGaSZ9o1rpryC/glPg7xIi0XkFLpjnrohUtzzDDdEl60hAKN9zuDT31cJOjYCgzxJXz
         MW6X7Sx5R0oRH4fkWorBErqnSpsSiohDD1+hOCM7Vu4uxnXnx3taKrdejjVUzr5RtawP
         8Hqg==
X-Forwarded-Encrypted: i=1; AJvYcCUBbgbfi7wVTIFvjLS5ynhcAcWMdriTNnBWjPIGjUJwioD/ULC5NTIl6NKZJAKO/ZxtMh7G6Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPSy5pce72br7ZhQaaurVQHmJIwW8bU6oUGsqedKaHI6MgdhPC
	wl5T0Gf9GnTpL5iDkw+pjE4O4GS4FvoYzhU/kSKsLLZhFyer6qc4lti05UJ4buT1Yw==
X-Gm-Gg: AZuq6aKEAYIxJscDXG9FiRQ9tS3V2ewwOeSajxdWd014+N3LdJAF7NKj3ScE+KP6msn
	JIy3nNN3t1z5O9y9qRDGuVgw93yiMXtGCm3zQos4qxarhIiKySQIOGu4DU/pzmS5u1j+dRngFjb
	wjJlXxdWgdw4bFC+aYfMIpS9pzg0XSvT1W+mDR7tE+eA8W2uhyIKi4e7cuQMG5l+v9MlOE6rEUt
	KS73T/R44+n/2TttH5dKvWEuY6N3nrgSMY4ewgZeYjR2mEmqNSHmC/a9nMbvyXGdUnoTv6bRdfe
	m/rfvfQN5OGWuCrWhpkuwwCPKTbQgW1AfD+6JHJ/aO4a7kayNuy5okU5vodUS/rWPuPBiH026ig
	nOImkCsBKbICFdyckUIZPwPiBqKmw3M+0x832X26oS2AacJf3MYTdta0VCbt/Ctu2k5vMGjglPM
	4NBb60lGP+zcw+FQNGnSDQLPSwTQPipZQBaSuUAZTWxvEHkXdQ2hT0PBeU
X-Received: by 2002:a05:7300:690a:b0:2ae:59d3:46d3 with SMTP id 5a478bee46e88-2b6b40f3892mr10931694eec.25.1768857195561;
        Mon, 19 Jan 2026 13:13:15 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:850a:22d6:79cd:2abe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14348137eec.14.2026.01.19.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 13:13:15 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 7/7] ipv6: Document enforce_ext_hdr_order sysctl
Date: Mon, 19 Jan 2026 13:12:12 -0800
Message-ID: <20260119211212.55026-8-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119211212.55026-1-tom@herbertland.com>
References: <20260119211212.55026-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the enforce_ext_hdr_order sysctl that controls whether
Extension Header order is enforced on receive.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 31 +++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 5051fe653c96..4713adb002e3 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2478,7 +2478,7 @@ max_dst_opts_number - INTEGER
         options extension header. If this value is zero then receive
         Destination Options processing is disabled in which case packets
         with the Destination Options extension header are dropped. If
-        this value is less than zero then unknown options are disallowed
+        this value is less than zero then unknown options is disallowed
         and the number of known TLVs allowed is the absolute value of
         this number.
 
@@ -2581,6 +2581,35 @@ ioam6_id_wide - LONG INTEGER
 
         Default: 0xFFFFFFFFFFFFFF
 
+enforce_ext_hdr_order - BOOLEAN
+	Enforce recommended Extension Header ordering in RFC8200.
+	If the sysctl is set to 1 then the ordering the ordering is
+	enforced in received packets and each Extension Header
+	may be present at most once per packet. If the sysctl is
+	set to 0 then ordering is not enforced and Extension Headers
+	may be present in any order and have any number of
+	occurences per packet (except for Hop-by-Hop Options). Also,
+	if the sysctl is set then Destination Options before the
+	Routing header are disllowed.
+
+	The Extension Header order is:
+
+	    IPv6 header
+	    Hop-by-Hop Options header
+	    Routing header
+	    Fragment header
+	    Authentication header
+	    Encapsulating Security Payload header
+	    Destination Options header
+	    Upper-Layer header
+
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 IPv6 Fragmentation:
 
 ip6frag_high_thresh - INTEGER
-- 
2.43.0


