Return-Path: <netdev+bounces-255999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPpDIB0EgWnZDgMAu9opvQ
	(envelope-from <netdev+bounces-255999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:07:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D39D0F19
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133243026C06
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6910130DEB5;
	Mon,  2 Feb 2026 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7Cun27Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90830B52F
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062664; cv=none; b=VQjNMGvCM3j9+pEo4oT1TD+YjIEm52r42Ak1AzKNz+V6OMQvvcC8+1on5ZXb55HTG7Cfse6rFoWirUkSARw+qYPNCLncmYIDUFQhxjTYHQOFz42wt/398nPiXExeSbfaQ4fjzeQJMl/tZdsD+djrtq/ouXT2ruacZT3gYyTNE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062664; c=relaxed/simple;
	bh=6mwvgcU4b+9/QTYhLf3cWuarnifzlcz1Qc4XoUMHFqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kk1sq7rmWcwP5eaZstE58EMw49fq1PQ63oQJcB/+OGqcrZx3f8McdXoNkQZL4PcI7fsEMMcrDjDiBa/xseTpHq7nxNaWOxcKYhMUJNcb95zZG0292B0nfxAuFrbHRuuG3BdiJNBrmZlWIka/Di7XBvaDq0AU5dP3pf/tYcRcwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7Cun27Q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso37278955e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 12:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770062661; x=1770667461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnYB/5fk0KIL/28WT7coTBmZftn7pWijOsAyfPHOv0M=;
        b=F7Cun27QNCOib2REAEqHghZdC+P4RXNgP8DndZJ+9FXrerYXZqhy5zjJmAV4CXfYUA
         XaUFbz1seYnZpYC34LCTsVRwbR8cv8MP/7mKvvUE5Bn4UkZqpg8ZevZFGUgJt3nJEbmX
         ba7zJIwTSNYo40nN4oxAiKJGsmbdZBSXFhSXwWGkT7yvOM/O9EnfCd1YO+5pZDeRf7VP
         QUlQSM+uL449fVmertIG36He/wb78txxKxCTXfqWC+ccn3dG9gxIrtX1SPEiSGeNna42
         r/qh7WBev2ebF7eurRIw46EmnGmQ3aHoopECWooKVfN+8ZLAnaBvUD/5C7MAVb5gTXKy
         qwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062661; x=1770667461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnYB/5fk0KIL/28WT7coTBmZftn7pWijOsAyfPHOv0M=;
        b=SkLtgjZyw5JABytPt39hXwB5q4JyAeZ7obJ+vxzmLZfNkts4VY+EvBw+72TMLwQLHb
         8MSyZnPjGcTPvVplHSYiiKmnN8Qboj+Jmzt/0P2jD5UTnRHm66zpL3lteN8JWevxf5d4
         FdYsJLzS7GxMz8YLzHOm5sO5+wDe4uFHy3QRhMrBa1xb4jvI1FhobUVgo/6ehQLXkxi4
         d7IPLwAaTLMZ8YKQ1Xa/v1ihVSyP8ps9IfK1SFxP4c6XjhiUMEcA4WACnthQGjIT+wnK
         8Nc+sTejGQ35UqzZqObGWb1lagHHUP3tzM/lHJ0piRWJxuTXg6FT8U7hmhZ1ldslOp9i
         jjWw==
X-Gm-Message-State: AOJu0YzJZ4TbdCAplGUGNnlzqtg9WfEp59rrGuXUOtTmuIvqFTYVz+qX
	5RupAUiK/WShZU55TGrQMIUSUiPKmJ6NK4SMAjvwWB+9oaszy1Ts044i
X-Gm-Gg: AZuq6aJ+WnUJXCg8OgW20IyaBr6tOtUJqCnrHE2YWfb0JdKVWEmA9cp/tLFDhVGoFa0
	Q1H00E7Px4NXCS1k4na4XWoFdXwo6iCcRrQr7Qef3IYBZ36EynzEYt8FxwmsK8baH8Rdp+L6S0i
	X8NuIGcKT4mGU46LA93mAmMKARpLcjAhuyJW3VQXdzmaZ2U5tQD9OLWpKLpIyxT3pT6mL2BQCaF
	X+nCoLJSh0D3ljWmFPnktz9TF5UfiKWlrIL8OuWQaf3VbFuTM/vZiWkk29zLfKDeWLiAKu3slOY
	2YT5O7I7b+SFoe5sOzrbcZnx6NcmaTNWMNcFJ09xahdxY26/sc3va9htt2+qGMb8vOrKU/riOr7
	7aAewB9kjdMqhv+4CmXMq3IFZh7HeFRwTJkQz9aZp7uqgokERSK8XDfAsxTYvpeSJPfsuABAdtC
	HNujniY4G88XI=
X-Received: by 2002:a05:600c:4f8a:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-482db456350mr180655745e9.3.1770062660562;
        Mon, 02 Feb 2026 12:04:20 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd3953esm120842955e9.4.2026.02.02.12.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:04:20 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v5 1/4] dt-bindings: net: ethernet-phy: add property enet-phy-lane-order
Date: Mon,  2 Feb 2026 21:04:08 +0100
Message-ID: <20260202200411.373161-1-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255999-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28D39D0F19
X-Rspamd-Action: no action

Add property enet-phy-lane-order to the device tree bindings to define
the lane order of the PHY. To simplify PCB design some manufacturers
allow to wire the pairs in a reverse order, and change the order in
software.

The property can be set to 0 to force the normal lane order (ABCD), or 1
to force the reverse lane order (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 58634fee9fc4..8347d4e134d2 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -126,6 +126,12 @@ properties:
       e.g. wrong bootstrap configuration caused by issues in PCB
       layout design.
 
+  enet-phy-lane-order:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).
+
   eee-broken-100tx:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.47.3


