Return-Path: <netdev+bounces-68818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C817A848678
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 14:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E74285F6E
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3B5D90E;
	Sat,  3 Feb 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqHIS7jS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36AB5D90F
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966181; cv=none; b=PoYERsfiP3kCKrVhwC5dZfrkMXcC1WYR1HNVHb+UYWbsh4MLw6puToiesFL3MWJwvGiHGF4HAoWGuVSWKgCHa8qKPHSXy4bK8Pl69cKexvcX5HSFUDFzN4kJX/DFdQ6PoJlmaj5h8OAdTTHLIAEYbrS7yErB17Gp2jRT9l26e+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966181; c=relaxed/simple;
	bh=S79peVpsL+uvEe0Fg4btssQoZVVg/l6OxtKoUTn/NdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3WQJXD2bYW8QBhrqxE6vWixdojXU5vS+19IyhHISJqOb6n0WIm4Zg2J6E6I/Xo30rr4jsGqnRkSLspPE2kCaOWqFzUao/bnyf3YGO1gqM7NW2n64SNM71CBBRZKgqGczdo1bxb/ibcRY0GJpDAghmn/BiiJ2yX3V+TAh31PxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqHIS7jS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so13826115e9.1
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 05:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706966178; x=1707570978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9RqJ7tzw7+pTpCWrxQiyfUDDLrGWEmWuymHg0ncth4=;
        b=ZqHIS7jSWJnmPa1aH1eW68CujqBYpg/pr6wBfycCefnY1NQbb/51GNc/gDyKoufjB/
         UFuN3gjNSsptu5uHR1jVCQJmdfRBIEUKF9qOTlVDgiXA4BehmcpwwSLIiRj1B5fbkVfz
         U2Ijp+BmpXCn+yg4ckn4Rk5dZ2KKPaSBy3xo0QHdR8HTMirH82QcjTK7oP7ETbfk467N
         Tsr/6XAAi/2g9sNq6H0f2OwOIgLZCIVwfrzUxiUf8HWBTqFepz02xHHVELYzalNbRu5A
         Yiz6oIe57ZsmAQWHZH22CfXZU5/2xUt6aoOfW6+9+CPzdU3xsffoo6MAJ3LOwzshokZA
         +nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706966178; x=1707570978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9RqJ7tzw7+pTpCWrxQiyfUDDLrGWEmWuymHg0ncth4=;
        b=Afnkqait85HX5qYzTaW/64mD9Ur04SqcJbNcrgbrOgwWU1a7ZTEE1zXxcLBCZfeOUC
         LmETCLIM1G+rFkVXxzuuTnmdOQqt2WHCuq/D779p/j1WP8+n+7nqa5sm61PBPyEOzavw
         DywGkEt7rnXzuSU3yV+s2wnqjf4l/wyi+9TwBezfXVf8d6YhmvsktLerrf5dNeBLrE6L
         6D1dqfAXJIHc3fhiofSEjXWu2+LxQtXB1JPLyl7YwqmdPdPaHGkwXz1LE5koXtaEeHjE
         OIagub+rsU8W9bI0gYSMpsdjtNP3wYia66h2RXnDfr4vUDLD2tWzD2bfRh4+X/dW7sp8
         6NgQ==
X-Gm-Message-State: AOJu0YzZ4Mnpj2kEYhg6Q1Bona+yNF9ZWP6kesHcxQMi8dobDBvvWGzH
	B+7VUlcGY0McWte53i5+BuUD7m0lY6ZVRMArUgK05GQ4vMKScIP/
X-Google-Smtp-Source: AGHT+IEWlKggZWFK4Ikz3p3hW6w2FBefRlJhV1LwkRuu7p1vYlMunBFq4j3T7/1a20k0EFeOmTu2YQ==
X-Received: by 2002:a05:600c:5007:b0:40f:d34d:d4ea with SMTP id n7-20020a05600c500700b0040fd34dd4eamr567179wmr.31.1706966178126;
        Sat, 03 Feb 2024 05:16:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWtvsrkvu3AwuUDABguvJDY9UrIT7MaDDqnJzbgoQTOP+0i0QXUXNsmNxgOAzj5ukb76ExMQeDwYSd5ZAVIfkX/k5OkENqwZun32OrveXMy+pbBJwpzlsZcCzvfXYrI2whgABefFTUSliR9XR6Sb2jTq3ykfz6Jxgx/nrpakddjoZgk2RrjPCTskIVNQtCsHDzdixo51KEzdP+GInfXTu5gS9VKMrmYVv/KwOfmGpe4Ff6ppyF8E1WhEX8PuZW7B98UjKOwHT7VR2TzB+MmhAK6Kybk67DBmQkSyGYqWxMQaa77kONzCHx1VDEl+8Bgf3AAToJDFyXMKIBwidglnI7Wje+sAQtmF1kd
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d554a000000b0033ad47d7b86sm4036456wrw.27.2024.02.03.05.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 05:16:17 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v4 net-next 3/3] tools: ynl: add support for encoding multi-attr
Date: Sat,  3 Feb 2024 14:16:53 +0100
Message-ID: <c5bc9f5797168dbf7a4379c42f38d5de8ac7f38a.1706962013.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706962013.git.alessandromarcolini99@gmail.com>
References: <cover.1706962013.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi-attr elements could not be encoded because of missing logic in the
ynl code. Enable encoding of these attributes by checking if the
attribute is a multi-attr and if the value to be processed is a list.

This has been tested both with the taprio and ets qdisc which contain
this kind of attributes.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 0f4193cc2e3b..3f5a7d5388a9 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -444,6 +444,13 @@ class YnlFamily(SpecFamily):
         except KeyError:
             raise Exception(f"Space '{space}' has no attribute '{name}'")
         nl_type = attr.value
+
+        if attr.is_multi and isinstance(value, list):
+            attr_payload = b''
+            for subvalue in value:
+                attr_payload += self._add_attr(space, name, subvalue, search_attrs)
+            return attr_payload
+
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
             attr_payload = b''
-- 
2.43.0


