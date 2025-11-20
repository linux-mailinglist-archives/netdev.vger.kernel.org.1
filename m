Return-Path: <netdev+bounces-240209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CF0C71850
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7C514E2D00
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A4318A6A7;
	Thu, 20 Nov 2025 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilcqdqx3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674BD54262
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597730; cv=none; b=sOnV0ZwL7g8quKoa6tK+p2pv8qopXv5EQDiEwJxuUncpiVDU5ivF5MfxOP6ErLydyiHEmmOAJ3Ez6pwBgCuXarpK6e5wArtxMJ/BLhFpyNX2xe9m8KJ2C7vWusr1kq1horVGeet8Np8oJK13vU91ITNcdar3WYtDGOVavPWKqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597730; c=relaxed/simple;
	bh=xCpkEYzNomcjUq2RBhM2Nj8mJD+qDxOUs76mrgKtjgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYNhm6l7F1k1slIDxeaR646JNNEEF0JCOd+QgPZ5gZPTX6GlDmRk6gzMOdV9WSMZ3CjPlEDe9fyTMciIvOnA6vxXOU78yNP9mCVuH3x5EibXD/eODHubb//TvANS8xV8sDv2wRFu5FRK2++fjQSnKnY9lAeLDPnSCSf43Rh5x30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilcqdqx3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779fd615a3so432575e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763597727; x=1764202527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trfVqswjg1NdlW9xJm6ysY3CFs26x2tsI+zzVlfdYrM=;
        b=ilcqdqx3DfVtObg3ADQ08riv07HVPT5l6fTbieMSfVIjZP/KYSdsP0CB8JKs8dZdzi
         mZFdHxcYQw2N3LG3a4bpzrYfCNAI/yYZFHRZHv4GuRF1tPHj/yi12MCRAckywJeR+dbc
         aihQBSMF5TlSvlpStPiwJAfbt72ADHVv2XjkLgCce8mbUUliwi1QkpGm/ErJvX67qJQg
         KpwOSLibOVjfzEh27M4tCwXOuZhGY10Awd3dtkE2iGRRlTOKsht6pr+FEltz0CMtYUy6
         C0Cxsi0ABvZugEp7z2s0uihB5iGuRxArDWfgsjpblN+ZsTbIAPYSqr4WsDPZQAX81jHA
         wE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763597727; x=1764202527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=trfVqswjg1NdlW9xJm6ysY3CFs26x2tsI+zzVlfdYrM=;
        b=W/LvwUj8QLO1nXphGbgH62/TOTib2sh/6M5mvILCzY9XGkv+QewHec9fbYhCY4iE9E
         P/mqsWW7PJJx3/1lLPP16lG6NulY3TU29ndG3bkRiXHEPwHtbesTc9JBE59Qi5BNRW3o
         OPDcyvMMR1amiKUzQuQ/vy03K/FlfUuhqSFRh93ZpKLDSMQFnwzwzUgIsNLLMpk/DR0a
         CynvSPhFZiyup1frYhSpIsnDDbKELaYuAbU25TSS0vsOBEv1o3UQnRPyDulH/SN3JusQ
         8xKvkfBU3McJl1+MndnlFIXU93J0Q8kk2xiasLy1qZjs6qjHu2kLtKMM3PBbgrHjUntu
         5erg==
X-Gm-Message-State: AOJu0Yw7ETFOy3oMF3J4nc2kJtgR04YP3nsUittrtXGy3WxV3HrtgHVX
	YdAtR/xGNYiBZCwuYjsZhdm0roRveLJP4KEJ64VMTG/eeB+TZEKM2G/j
X-Gm-Gg: ASbGnctc5MvTVUw4VzBIVRaheoh1LI+2WKyY+YfLnYu9xV6pv1YNF+hIL4IQV7XPGKO
	6JFCIubT7ivGmPrP6wFR11oIxHTqNyNsoGtdaSRs0B+YAYCWaTJz5TOiraJHBr1eLuIRIBR5Ibe
	NsdgxpO/WMrdfJ/NptIPP1M96bF89Ac7ybA+kaFBRgFkVOK5xCxzOPHbwa4N3zw+zpwsPD0qu5U
	WVUMWyqXZQvMJd90TSQuT8HlP/R09GxjpfA4ZTfEfbKMdd6KhPN2nVeEWrEaI3R2ru3+F4jzIm/
	Uwuk1tuHbaNesTxQqzRbOfQjEg85d49/4rpKrQ+hJZm3jp4b3pvx5kUodGY+bjyTIcanoRqVzXV
	Zjcp7O3LQIQbfPevwP4xq+Nn914z8Z19PolL4gwL3N1OeT0dFxLc27Y6kZPjxtD0r+GXTSAxVxv
	JnfE0V8l8tT7kAo2C37RoDtK1OHn492G70+yp4dQ==
X-Google-Smtp-Source: AGHT+IEiQxaxA/A54OsLoBVuiEEkFz+e6t06y8Ajf7M4vany3n7BtGT/D3/7t3IQL3xUNHYfHJZUQA==
X-Received: by 2002:a05:600c:4f4f:b0:477:aed0:f402 with SMTP id 5b1f17b1804b1-477b8d8a7e2mr6219385e9.8.1763597726622;
        Wed, 19 Nov 2025 16:15:26 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:40::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e432sm1970904f8f.9.2025.11.19.16.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:15:26 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 19 Nov 2025 16:14:49 -0800
Subject: [PATCH net-next v3 1/4] netconsole: Simplify
 send_fragmented_body()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netconsole_dynamic_extradata-v3-1-497ac3191707@meta.com>
References: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
In-Reply-To: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Refactor send_fragmented_body() to use separate offset tracking for
msgbody, and extradata instead of complex conditional logic.
The previous implementation used boolean flags and calculated offsets
which made the code harder to follow.

The new implementation maintains independent offset counters
(msgbody_offset, extradata_offset) and processes each section
sequentially, making the data flow more straightforward and the code
easier to maintain.

This is a preparatory refactoring with no functional changes, which will
allow easily splitting extradata_complete into separate userdata and
sysdata buffers in the next patch.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 111 ++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 65 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..5fe5896d6ff5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1560,89 +1560,70 @@ static void append_release(char *buf)
 }
 
 static void send_fragmented_body(struct netconsole_target *nt,
-				 const char *msgbody, int header_len,
+				 const char *msgbody_ptr, int header_len,
 				 int msgbody_len, int extradata_len)
 {
-	int sent_extradata, preceding_bytes;
-	const char *extradata = NULL;
-	int body_len, offset = 0;
+	const char *extradata_ptr = NULL;
+	int data_len, data_sent = 0;
+	int extradata_offset = 0;
+	int msgbody_offset = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	extradata = nt->extradata_complete;
+	extradata_ptr = nt->extradata_complete;
 #endif
+	if (WARN_ON_ONCE(!extradata_ptr && extradata_len != 0))
+		return;
 
-	/* body_len represents the number of bytes that will be sent. This is
+	/* data_len represents the number of bytes that will be sent. This is
 	 * bigger than MAX_PRINT_CHUNK, thus, it will be split in multiple
 	 * packets
 	 */
-	body_len = msgbody_len + extradata_len;
+	data_len = msgbody_len + extradata_len;
 
 	/* In each iteration of the while loop below, we send a packet
-	 * containing the header and a portion of the body. The body is
+	 * containing the header and a portion of the data. The data is
 	 * composed of two parts: msgbody and extradata. We keep track of how
-	 * many bytes have been sent so far using the offset variable, which
-	 * ranges from 0 to the total length of the body.
+	 * many bytes have been sent so far using the data_sent variable, which
+	 * ranges from 0 to the total bytes to be sent.
 	 */
-	while (offset < body_len) {
-		int this_header = header_len;
-		bool msgbody_written = false;
-		int this_offset = 0;
+	while (data_sent < data_len) {
+		int extradata_left = extradata_len - extradata_offset;
+		int msgbody_left = msgbody_len - msgbody_offset;
+		int buf_offset = 0;
 		int this_chunk = 0;
 
-		this_header += scnprintf(nt->buf + this_header,
-					 MAX_PRINT_CHUNK - this_header,
-					 ",ncfrag=%d/%d;", offset,
-					 body_len);
-
-		/* Not all msgbody data has been written yet */
-		if (offset < msgbody_len) {
-			this_chunk = min(msgbody_len - offset,
-					 MAX_PRINT_CHUNK - this_header);
-			if (WARN_ON_ONCE(this_chunk <= 0))
-				return;
-			memcpy(nt->buf + this_header, msgbody + offset,
-			       this_chunk);
-			this_offset += this_chunk;
+		/* header is already populated in nt->buf, just append to it */
+		buf_offset = header_len;
+
+		buf_offset += scnprintf(nt->buf + buf_offset,
+					 MAX_PRINT_CHUNK - buf_offset,
+					 ",ncfrag=%d/%d;", data_sent,
+					 data_len);
+
+		/* append msgbody first */
+		this_chunk = min(msgbody_left, MAX_PRINT_CHUNK - buf_offset);
+		memcpy(nt->buf + buf_offset, msgbody_ptr + msgbody_offset,
+		       this_chunk);
+		msgbody_offset += this_chunk;
+		buf_offset += this_chunk;
+		data_sent += this_chunk;
+
+		/* after msgbody, append extradata */
+		if (extradata_ptr && extradata_left) {
+			this_chunk = min(extradata_left,
+					 MAX_PRINT_CHUNK - buf_offset);
+			memcpy(nt->buf + buf_offset,
+			       extradata_ptr + extradata_offset, this_chunk);
+			extradata_offset += this_chunk;
+			buf_offset += this_chunk;
+			data_sent += this_chunk;
 		}
 
-		/* msgbody was finally written, either in the previous
-		 * messages and/or in the current buf. Time to write
-		 * the extradata.
-		 */
-		msgbody_written |= offset + this_offset >= msgbody_len;
-
-		/* Msg body is fully written and there is pending extradata to
-		 * write, append extradata in this chunk
-		 */
-		if (msgbody_written && offset + this_offset < body_len) {
-			/* Track how much user data was already sent. First
-			 * time here, sent_userdata is zero
-			 */
-			sent_extradata = (offset + this_offset) - msgbody_len;
-			/* offset of bytes used in current buf */
-			preceding_bytes = this_chunk + this_header;
-
-			if (WARN_ON_ONCE(sent_extradata < 0))
-				return;
-
-			this_chunk = min(extradata_len - sent_extradata,
-					 MAX_PRINT_CHUNK - preceding_bytes);
-			if (WARN_ON_ONCE(this_chunk < 0))
-				/* this_chunk could be zero if all the previous
-				 * message used all the buffer. This is not a
-				 * problem, extradata will be sent in the next
-				 * iteration
-				 */
-				return;
-
-			memcpy(nt->buf + this_header + this_offset,
-			       extradata + sent_extradata,
-			       this_chunk);
-			this_offset += this_chunk;
-		}
+		/* if all is good, send the packet out */
+		if (WARN_ON_ONCE(data_sent > data_len))
+			return;
 
-		send_udp(nt, nt->buf, this_header + this_offset);
-		offset += this_offset;
+		send_udp(nt, nt->buf, buf_offset);
 	}
 }
 

-- 
2.47.3


