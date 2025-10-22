Return-Path: <netdev+bounces-231831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1954EBFDD53
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ED5C500EFF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7220134EEF7;
	Wed, 22 Oct 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Lj6HV18I"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54E34C99A;
	Wed, 22 Oct 2025 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157644; cv=none; b=A+IJELZde+zs8rheIcJJxi8RA9wenGkcQJsikZ4cCeabwW0IrIVLS7JGLzHWoscBfweoQrEKKGqp8NY3g2ixokKRrXnAbfcidkvW6RHO74gyj8Zg2ZH9z5ALJqanPWaOovvj3vSOe8zBmWNaV67vdzUv4vE2FukW7MZfs1Wrwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157644; c=relaxed/simple;
	bh=H4QLUCPTYmum7YJRk09TGBcRUEfaTbbQ/3zKr9PVciw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcWRQa3p6DsOp7Msm3NpC2eoyJTWMHN1/UDsXHQr5iiUvJ4fIlh6w7SKrYUctL3W3e8RQFsmcMoiZkdrvhlqhrt9bFeRCNw3TJsBBLY+LOPt1+urNxf43c1xtvxf63i8fuh54M3EtjuROVS7DKNF3fMUh+JuGilnIfwP1rnbLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Lj6HV18I; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761157634;
	bh=H4QLUCPTYmum7YJRk09TGBcRUEfaTbbQ/3zKr9PVciw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lj6HV18Ixlw0m5W36H+5K59f3Ish4H5sx1ZQPupjNlC5k0a7UPrSBXTnpsNDFlZSS
	 8iR0MDQU35DZOzvw9dYSAX8KWtzjjHMPGWo9y+uhJ9Sn7iCdhTmH24TrgPIYAT5CrG
	 Gt6+OPz1uz+h5FGV0VFsHFn8wMSzjnmUGGVUolZCt1xlAi5iBO95o6QiGjPPIILBdB
	 JRGUQa8YM5HhZFTxjJQ0uiuu+wznaXpOmtPnGLshK63hWjDYfc9x8aZPOqgdsWXCwH
	 0j6RdPHiv4jl1LH/1u+2zZ0mbilP9niRB6ymkX4jn/EdB8oppXH7CR1zZ5jY5LKl0A
	 OiH//VM6x7Sqg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 751E36000C;
	Wed, 22 Oct 2025 18:27:14 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 81B4A200C27; Wed, 22 Oct 2025 18:27:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/7] netlink: specs: add ignore-index flag for indexed-array
Date: Wed, 22 Oct 2025 18:26:54 +0000
Message-ID: <20251022182701.250897-2-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022182701.250897-1-ast@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new YNL attribute `ignore-index` as a way to indicate that a
given indexed-array attribute is really just used as an array, and
hence the nested attribute-type aka. the index is unimportant.

This means that the kernel never uses the index when processing
received netlink messages, and that it doesn't add any additional
information when sent by the kernel.

For backward compatibility reasons the kernel can continue to set
the index to a non-zero value in netlink messages, but it can safely
be disregarded by clients when `ignore-index` is set to true.

When the index is non-zero, it is often just an incremental iterator
value, which provides no additional value, as the order of the array
elements is already known based on the order in the netlink message.

`ignore-index` is not added for the genetlink protocol, as any new
families should use multi-attributes, unless they need the index.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/genetlink-c.yaml                   | 6 ++++++
 Documentation/netlink/genetlink-legacy.yaml              | 6 ++++++
 Documentation/netlink/netlink-raw.yaml                   | 6 ++++++
 Documentation/userspace-api/netlink/genetlink-legacy.rst | 3 +++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 5a234e9b5fa2e..5d022772cdb61 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -184,6 +184,12 @@ properties:
               nested-attributes:
                 description: Name of the space (sub-space) used inside the attribute.
                 type: string
+              ignore-index:
+                description: |
+                  The indexed-array is just an array. The index, aka. the
+                  nested attribute-type, can be disregarded, as it doesn't
+                  contain anything interesting.
+                type: boolean
               enum:
                 description: Name of the enum type used for the attribute.
                 type: string
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 66fb8653a3442..f7991a3c5e2a3 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -233,6 +233,12 @@ properties:
               nested-attributes:
                 description: Name of the space (sub-space) used inside the attribute.
                 type: string
+              ignore-index:
+                description: |
+                  The indexed-array is just an array. The index, aka. the
+                  nested attribute-type, can be disregarded, as it doesn't
+                  contain anything interesting.
+                type: boolean
               enum:
                 description: Name of the enum type used for the attribute.
                 type: string
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 246fa07bccf68..1d2ff5f79cada 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -251,6 +251,12 @@ properties:
               nested-attributes:
                 description: Name of the space (sub-space) used inside the attribute.
                 type: string
+              ignore-index:
+                description: |
+                  The indexed-array is just an array. The index, aka. the
+                  nested attribute-type, can be disregarded, as it doesn't
+                  contain anything interesting.
+                type: boolean
               enum:
                 description: Name of the enum type used for the attribute.
                 type: string
diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index fa005989193a1..839b0095c9a80 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -53,6 +53,9 @@ indexed-array
 limiting its size to 64kB). The ``ENTRY`` nests are special and have the
 index of the entry as their type instead of normal attribute type.
 
+When ``ignore-index`` is set to ``true``, then the ``indexed-array`` is
+just an array, and the index can be disregarded.
+
 A ``sub-type`` is needed to describe what type in the ``ENTRY``. A ``nest``
 ``sub-type`` means there are nest arrays in the ``ENTRY``, with the structure
 looks like::
-- 
2.51.0


