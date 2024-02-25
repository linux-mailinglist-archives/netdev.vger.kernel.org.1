Return-Path: <netdev+bounces-74783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3290862C63
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 18:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5011F22062
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F51B810;
	Sun, 25 Feb 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akrmxdAA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681B19BBA
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883193; cv=none; b=GLtUftfmr39qdnqg5lZAGMoqZ7TNtyWCmbXLwRaHyjs+/UZqIxkBFVUAM855aEG8kYehWwJZwF3MHi6e2HxhXL3cCFHe0uaPZnfESU7AXMIR51Ddq8FDPT1UimW3pg4YBkycGRpKglh5gvIrr9RYTD3Noj6/EXQpY7ey1yr0s7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883193; c=relaxed/simple;
	bh=7wAqg9foTIHMmx4OsmIdZ1GzxvWbzdvDTUIdriH5JmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNd3GtoV0OmG5SqZzrny65ZgXdel8DROqerADGuSlsjCXg9TLF1sqseTKQT4/hUJ/KUh2zv5p9XcbQhecrnb3YzSHglqLg9lqZyEJcds595ckN8mVzm7ubhjuR4NR4UJx0rDNUjsKgoCjbeTRkx0DaFoFcOtWoxl7oDVSno3q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akrmxdAA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d32f74833so1326742f8f.3
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 09:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708883190; x=1709487990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgJVZsaQlQklBgNjFjDp6oBPw9KW1L83Q0alGDwej54=;
        b=akrmxdAAbJoQR9C5sIzhLMOYBx90bVXXRMiHmVN9BdLTj5RHIx/R6iOseR0keIFYN6
         hRw6iksTUkopa1CKgwz0hOcMlvaKuH56i3+e2ipvuULy3kJD6V70j4d9qo2zznP/EFnA
         RhQdROJ/3VADf7SaoNoG8zlV8WNHYPawW55O8wCnjqZeARoKlR5b4GCHnefQ+WfRxbL3
         ZUeegOyF2vdtUXFVyP8EOkhoI1ZraAinMPibsu3ot7r2uxALEjK65AgUPoNA7v1jX0vb
         DJnuZIvIWBjeC8q0/plJGYAHxQGViayxinqx4/LwmPkKDYQZHwHifnFAY+2n538UlcEI
         s/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708883190; x=1709487990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgJVZsaQlQklBgNjFjDp6oBPw9KW1L83Q0alGDwej54=;
        b=cQ3XcrGubIlwrw9YRgy3Do/giEqv51FNBcna01HMuD6Ygag7aUW4V8RRAL5Xmweh4N
         OFPesGQgB85I5wwNCSy7yzVB72feNh3evkbtawqhq6FSB2LLcYKC6USSw61BAIuVPmoJ
         Q5mkke7qJx/BoMIQimikSjDUDp7BDAkkSQ9H8Rrcg6n6790TiLoNQ29SXTOybT8PpJmI
         GfqIiLY0Qxj7ovx8LDyMOWKn06+b1ITNA4QlRCOhButDP+Np7Hf1bNVyfF2jAhwm2TZi
         rHDZw37NhogDGStYe4HYoVXbPD+O4GfoDMJc0vIMvMBPqLlwHOJxFzFcNH3FTcf0HAO6
         gF8g==
X-Gm-Message-State: AOJu0YysGnbkQrockcMuaHV/c9sQOp2oSWUD56+ssxpIKpvvShMKWQCp
	P6l+SV75mHK5xp12SNcVSJzch2p5ulmoHKH1C1xjtBO1+Mr3lbTXdBbtJmS238c=
X-Google-Smtp-Source: AGHT+IGImNXWxkV4fXyqi6RrpEBzIqmZgFgT3YbLWpqU/hBlz5s8mLfKbrxSQZ83nxdbRwdvFTdUdQ==
X-Received: by 2002:adf:cd89:0:b0:33d:3830:769c with SMTP id q9-20020adfcd89000000b0033d3830769cmr3325376wrj.65.1708883190253;
        Sun, 25 Feb 2024 09:46:30 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:907c:51fb:7b4f:c84f])
        by smtp.gmail.com with ESMTPSA id r2-20020adff702000000b0033b60bad2fcsm5558729wrp.113.2024.02.25.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:46:29 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC net-next 3/4] tools/net/ynl: Add batch message encoding for nftables
Date: Sun, 25 Feb 2024 17:46:18 +0000
Message-ID: <20240225174619.18990-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240225174619.18990-1-donald.hunter@gmail.com>
References: <20240225174619.18990-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nftables families use batch operations for create, update and delete
operations. For ops that have 'is-batch: true' wrap them in begin-batch
and end-batch messages.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index c6fc9588c235..3a4af3c5a6a7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -841,6 +841,12 @@ class YnlFamily(SpecFamily):
         msg = _genl_msg_finalize(msg)
         return msg
 
+    def _encode_batch_message(self, name, nl_flags, req_seq):
+        msg = self.yaml.get('operations').get(name)
+        op = self.ops[msg['operation']]
+        params = msg['parameters']
+        return self._encode_message(op, params, nl_flags, req_seq)
+
     def _op(self, method, vals, flags=None, dump=False):
         op = self.ops[method]
 
@@ -851,7 +857,16 @@ class YnlFamily(SpecFamily):
             nl_flags |= Netlink.NLM_F_DUMP
 
         req_seq = random.randint(1024, 65535)
-        msg = self._encode_message(op, vals, nl_flags, req_seq)
+        msg = b''
+
+        is_batch = op['do']['request'].get('is-batch', False)
+        if is_batch:
+            msg += self._encode_batch_message('begin-batch', nl_flags, req_seq)
+
+        msg += self._encode_message(op, vals, nl_flags, req_seq)
+
+        if is_batch:
+            msg += self._encode_batch_message('end-batch', nl_flags, req_seq)
 
         self.sock.send(msg, 0)
 
-- 
2.42.0


