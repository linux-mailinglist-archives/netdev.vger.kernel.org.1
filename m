Return-Path: <netdev+bounces-98616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311E8D1DE6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10C81F22CC5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84E516F851;
	Tue, 28 May 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnLY5ZUZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E316F839
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905233; cv=none; b=SSVomAX+25OuVTMcFAH8/InwHsHf9SnsU9Ogon0tvgd/Co40x7p3pU3G6vN57b/JRSY8pd91ogkvTT9/cILWjknP0QfbLroYmj8OEqT8TDJemvR7k2U5rJM4v29knnGqBYxN8MUvNY26oGjnGu9+Jj48HaXZfmng6YSYZyCvt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905233; c=relaxed/simple;
	bh=RaTuZqpnMLUFacKJseAeTCJlX52CiEWM4nZjZsy2uFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHLr8JPyH7XXryZCFKrRq2KmxzETqErE6rN8n/iE0U6qRNNQrv+jMu+zDXEQggp8VS2jzCtaEjDxqtfr3QbxWF+8bsBf/9MbT0MUeKHvLjRrKilBaTY3YSNZiXZ688VxIIbVMwbXPrzf1x4qCYxi4+2zJZGQslpmYW7RUsWpm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnLY5ZUZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e724bc46bfso9190751fa.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716905230; x=1717510030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVmb9sP8GIUblthAc/eDiBYyoygYmdyWG7iTsuFrm+Y=;
        b=VnLY5ZUZEkz+FRaCsW4PdsCG7oRR6pyuCREPMjZmRSXVtamOzTj3EmJmQbl9U6T0x2
         C9mZYHL5nN6oHMbp0dCt0+yLn6uMOG9XNVCVn8xUV6W9XcyqS1R27OWs1I+bnUSQ/uvN
         zuvPRjzbkabmqZpj7sWKzUvHHJ0AfFR8AxrvyHi0pACHIm22SvaxbI4hXGaWDM0AFmUQ
         j9cYRNTDqejP3Au2g3y+dHMxqr3OnknA07FDZbvJ+Bk4gVdSHPNhHR4whq2w1MzM95ab
         cwL1NmEV88EGCSMbEhfuMRfHOagqzzffZ+JXBy8R0+nqBrXq5PZ0GXVkxfWy8YV0Rz91
         8ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905230; x=1717510030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVmb9sP8GIUblthAc/eDiBYyoygYmdyWG7iTsuFrm+Y=;
        b=nKHuyUwekW2Egkfx74OYEcyUsDer9yBOERUfe/FezM/DAdWlhBXUDkA1S8VcPLkrn0
         QJrItI1JbMTP2BTfJyjl8rUCA8a6c01TXH2CTdrXB2izSKKKw/kf2mAwuT0l8hHNfMEh
         EsXfT7Om5ZqR3nbbGWsj1amJo7H0SIhV1aKXCdzfR0Zu9zWD3uXk/4XuWbSlclQxmbS9
         PhlYpuoycDuHm6SfiIcDgCwtFfzLWZswcv2JjNX+yUnjr2B8s+StW2EYNNFeQBkAEfIS
         X5K46lSBX60JSePICcbGG8qi9x6EhgfMhKLm5p6SxmiQdFZUeMuY4zf4GK6Ti+FheQMS
         2lsw==
X-Gm-Message-State: AOJu0YxFa48U9WurCLXnkRrqEDbSEMt2JimmVxBq5vMQ2a8nBEGABlMB
	8eW1M+TVoR/3Ti+sMszK+iLKiQ1NTA1TnoqIK+1nP9Qy+wDEhYa0sSwwieo0
X-Google-Smtp-Source: AGHT+IHF0n0RpvDNsdtGlvl7PkBU87jLheGfy+amsVegWhG2KbXS3phfkipg7Mtp4L1iZalCZMzTQg==
X-Received: by 2002:a2e:a593:0:b0:2e4:f8e:3a64 with SMTP id 38308e7fff4ca-2e95b0bd93bmr86166581fa.30.1716905229421;
        Tue, 28 May 2024 07:07:09 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:68e9:662a:6a81:de0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-359efaf5402sm4534599f8f.78.2024.05.28.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:07:08 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 3/4] doc: netlink: Fix formatting of op flags in generated .rst
Date: Tue, 28 May 2024 15:06:51 +0100
Message-ID: <20240528140652.9445-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528140652.9445-1-donald.hunter@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generate op flags as an inline list instead of a stringified python
value.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 1096a71d7867..a957725b20dc 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -172,7 +172,7 @@ def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
 
 def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
     """Parse operations block"""
-    preprocessed = ["name", "doc", "title", "do", "dump"]
+    preprocessed = ["name", "doc", "title", "do", "dump", "flags"]
     linkable = ["fixed-header", "attribute-set"]
     lines = []
 
@@ -188,6 +188,8 @@ def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
             if key in linkable:
                 value = rst_ref(namespace, key, value)
             lines.append(rst_fields(key, value, 0))
+        if 'flags' in operation:
+            lines.append(rst_fields('flags', rst_list_inline(operation['flags'])))
 
         if "do" in operation:
             lines.append(rst_paragraph(":do:", 0))
-- 
2.44.0


