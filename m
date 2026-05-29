Return-Path: <netdev+bounces-292980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP07MQsjGWqVqwgAu9opvQ
	(envelope-from <netdev+bounces-292980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:24:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B1F5FD508
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62FB030D25DD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF823A2E36;
	Fri, 29 May 2026 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkQwhhex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1639FCDB
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032183; cv=none; b=GezMpxgj9qE/GyF9V4Ucucrc+lXeEGOLNyHIrYGjrRcPR9nWVLRgmrb7YyE+B6SOQ+KfiSYMy1ZGgB6OurvII+Zq8HwteEruUncXd18w/nHWWtwbcDDP7u5ydNNAVcgRwdvw4Fk2APQuHHvhWzmTRxcVwzsC0IfeKxPUF9rWGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032183; c=relaxed/simple;
	bh=uVEZU/+gipWULzqX7BJdsxlQpV9amP+FJ2XDIND7gxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDZpNvTdS2wk82v0AZclyqDswe/d0fPmAQ2XdLC0T7ZPGykBKJXEYhXevFEQ93+ov3QGFEzphCyKNI8cNf1DKU/gvi2bQHJLC18ELUGVnTF3jbgWixxriUMSAua9ScioINTc4CK7z9oO+sRB4+SptUOy++Nlzv3mroPe6zNoMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkQwhhex; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e582b3bcaaso11462555a34.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780032180; x=1780636980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kwqBkxBqToEXWExg8efj0rcQqkFJQIIdG4GoWkLr1k=;
        b=SkQwhhexE7R60DljNv9ohdMXEzSnfrj0pAxxBDOWT411u8zrc9ZF5nMVbQ4a1qQE+8
         64U/p7HtoVjilzwL3qW3Mr/C7p5PT+xTyH1t3ykCULWc4rhNAvlEtobuuQyc/9JjoCWk
         RSVaQ6ylmjyG64lWrWpLTQ1AGpoVSn1B6E/gsZfMCEJl1FEHxMEdZdjsUJhMRxRbXDXk
         LYcLTALqEWFdk6pXYrDAzaOfm9ePv0gvVnGyXFFSVzAIfyGS7ejPhSZ3d3ykWp5z+zbM
         qXUD/+zRS8uNp63xQkbQCF3+0gzLvP7z1BzYrcIa3qkkDxOF6F+4TsgFec+je317hQc5
         49Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780032180; x=1780636980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6kwqBkxBqToEXWExg8efj0rcQqkFJQIIdG4GoWkLr1k=;
        b=sQjAXT9pqBUcaDfwhagVLnpA1ni6tCEjhNb6XIwVUhVmzz6sUZWVKByLkZSL60POSA
         JB3EK8FlIMfKhIvB4hVmkhvM1M/wV44BlDjru9a0ORkLzq2BUZbBhtMCKTGthZB1OnJG
         A2xiV1aFrJcbYygZahH5P64a4R4gJofntP9omkTek/ao1bZ/KRZMNWz+Lnk+dUEEgjwL
         Z1D9bPA4obxxGkxzE+6XwuOBqvbkj5eIhof04hpne4hSsLGPzHWK8q81nFL6z76XB4bf
         Y6z93nhl+cpFMmCZfLK56GPy7jrY0U41bxuAPw04TAf74OEOGrgAlbP5zIVv5NCWxVZo
         W6+w==
X-Forwarded-Encrypted: i=1; AFNElJ+5Ayp/VnLGjJ7Cs1fNnRehhVZV68vaRWt/gBTVs9/v/xkFfyL/q+awVH1cY8HFqmh5JltGN30=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb3axj1bp2H9yoz5HZvi76v1DPdkXOjcvEf57talJbxsUbBnpw
	62GbUq1Q/7xsipeIS6b+ZOebBGco+Vydrhg9Ttj6YPtCGbep3MTAfFkP
X-Gm-Gg: Acq92OGAd9s0Jnt4zYECYUsFIgrAeXyh4wBH4Jpsz2vaRdE0Ce0BctUVQOAQ/dWRr9v
	ikZJ/nJqF9KARj3SWJ+pIK80AaCCufMVHPAyY2HaVWMzRsWZjoptMLHy+oO+eUN9X9R51QIh0hc
	4uJMy5tpgLMiHAi20ghJaanKQnJfjT5wmLXUx9zD1AMRqkYKGu5fcGC3uzYaWEuV2TK5H0KiWFI
	rzy6vMF0OyQXCNYnYHBgDBYq+rrJxvfWBxd62FkRdNb3hYHQk6zH21DV6XWJcTmz7ge4WsAvZ29
	7CCIpzJvRAEI5xSqAnNobJOu2nt4YVw6DF16XgrE3o2nmUbWcONZyytFuDdVTzAMtbqDRu4fflD
	G3qJUHPHFVUWD+iHovJVvr7Dvk6i9SANanP3bj0k3byUlqj/bhKlr/Pdpo7ZUV8YpXHah2kS7P4
	huAlYSgcVUj8a52pSy/llarAETmOwADjlEbXAqP69EOzUd7nwvcFN7
X-Received: by 2002:a05:6830:2118:b0:7dc:ddfa:73e7 with SMTP id 46e09a7af769-7e694dfa401mr929130a34.2.1780032180459;
        Thu, 28 May 2026 22:23:00 -0700 (PDT)
Received: from fsh.attlocal.net ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695bd790fsm760909a34.10.2026.05.28.22.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:22:58 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: devicetree@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: net: dsa: remove obsolete dsa.txt
Date: Fri, 29 May 2026 00:22:40 -0500
Message-ID: <20260529052246.4934-4-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529052246.4934-1-akash.sukhavasi@gmail.com>
References: <20260529052246.4934-1-akash.sukhavasi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292980-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akashsukhavasi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 31B1F5FD508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dsa.txt has been a redirect to dsa.yaml since commit bce58590d1bd
("dt-bindings: net: dsa: Add DSA yaml binding") introduced the .yaml
schema. The .yaml has the same filename in the same directory, making
this redirect unnecessary for discoverability.

Two files still reference dsa.txt, forcing readers through an extra
hop to reach the .yaml. The stub has not been touched since August
2020. Update references in lan9303.txt and
Documentation/networking/dsa/dsa.rst to point directly to dsa.yaml
and remove the stub.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 Documentation/devicetree/bindings/net/dsa/dsa.txt     | 4 ----
 Documentation/devicetree/bindings/net/dsa/lan9303.txt | 2 +-
 Documentation/networking/dsa/dsa.rst                  | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/dsa.txt

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.txt b/Documentation/devicetree/bindings/net/dsa/dsa.txt
deleted file mode 100644
index dab208b5c7c7..000000000000
--- a/Documentation/devicetree/bindings/net/dsa/dsa.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-Distributed Switch Architecture Device Tree Bindings
-----------------------------------------------------
-
-See Documentation/devicetree/bindings/net/dsa/dsa.yaml for the documentation.
diff --git a/Documentation/devicetree/bindings/net/dsa/lan9303.txt b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
index 46a732087f5c..0337c2ccfa9a 100644
--- a/Documentation/devicetree/bindings/net/dsa/lan9303.txt
+++ b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
@@ -16,7 +16,7 @@ Optional properties:
 Subnodes:
 
 The integrated switch subnode should be specified according to the binding
-described in dsa/dsa.txt. The CPU port of this switch is always port 0.
+described in dsa/dsa.yaml. The CPU port of this switch is always port 0.
 
 Note: always use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
 configured to use 1/2/3 instead. This hardware configuration will be
diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index fd3c254ced1d..42a99f5dfa2e 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -509,7 +509,7 @@ Device Tree
 -----------
 
 DSA features a standardized binding which is documented in
-``Documentation/devicetree/bindings/net/dsa/dsa.txt``. PHY/MDIO library helper
+``Documentation/devicetree/bindings/net/dsa/dsa.yaml``. PHY/MDIO library helper
 functions such as ``of_get_phy_mode()``, ``of_phy_connect()`` are also used to query
 per-port PHY specific details: interface connection, MDIO bus location, etc.
 
-- 
2.54.0


