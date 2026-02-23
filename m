Return-Path: <netdev+bounces-260228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOyiDJrQnGmPKgQAu9opvQ
	(envelope-from <netdev+bounces-260228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:11:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B78B317E0B2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4C630474D2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6F37BE78;
	Mon, 23 Feb 2026 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5pNyYux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAC37BE62
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884308; cv=none; b=ko8OtZtr1xTVbHcYAorp3SkRyxJhzOQdB7EOC/sybByTZtY2IX0LTdexa0cVziCK9UawZ810NSk5t/FQ4poyURqvoKSRM54m5EJ5sndgE3ZSomIRZCmqMlU/hBjno6GDPOdKEuPeho8dzncyYoZH9w8FNKNTZVuUKjCI5LuXd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884308; c=relaxed/simple;
	bh=hRGB9oVjZrDC5m4XZKHO2WMi1uqtMLbDhKE3faTS22k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgbGpOrWp/q4+54OBBJFW/vFITLqV3zgjiEH1aTy7a0UZy4T33j26d4w32XJE0xnWqNCQgioOuyRrS4gM6zIgQLaragoehrcRiDTOLlIpsyA0BaCoIyHPB6ZFi2ClS29eMazpAuyixFQwbAvuF/vOrQxUY7ivGI+azqGp3GZQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5pNyYux; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f96f6956aso666587666b.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884305; x=1772489105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJnwuXlwPqYBkjbw57cs4hmL2PjDi3OofAmEvUVEuyo=;
        b=e5pNyYuxf0xHsF+XHzH0+Bhgh7yFJy58SnPuA5PH4pmpJl3fXe/OEFdVO86cMFyozs
         FnxMJxgDOKBEgCvNmMMEL8cerEMk91LmtZG3IvxHSOOCJuGTfr6wwePKf54KJ7TWxXc1
         3NXARy8GwkUi4TRFnU8VFwXbyHIVRmn+C/jwzBdRCDIOy0B++hxrolCH0gWRf/Wv2ghC
         SaA7yTUad6y4D8UCoaz8mdR6ITUX2wUZhPvZYEY8V/xTeFhe0pGuXdWMwKseQ8SEJjwA
         Mj28g7lFdgW9xPAx/67m+IzQxuCFgB5dEb8ytGWfw7+DG2N9QRcM9mVXyMrhzZAVPYCS
         /tXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884305; x=1772489105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJnwuXlwPqYBkjbw57cs4hmL2PjDi3OofAmEvUVEuyo=;
        b=W4KIs0Jt8+FpqdjKLq6A0KovmgODBnUjf/qXlAQdL34r7DaUpEPSZE2/YKI2eRNr6j
         7EaTtZDZiYpVV33AOGsBEyz4CkQJxxnaJj2Vy9XjYqYSP2VGal46IU0E7N04UH5OQBaC
         ovH1X4/rO85KdY8i0qne6ovaENO6RuScaOWKrEWV/m+DO+lpkD43KWy9bPtQHa1ePbEc
         U1zFtGRgGaxUYAQNwLrevazxo2kK2X/lYOhFTNbA+J8oDCncH1aJB12aeeAXrMmSmGsz
         /jGLaG9QwALUWK8M9EC6tq9ay/uJ7bTRqCS9uj7FDi7bx0geLKDPr1X7ia5SC9IKHvzC
         UPKw==
X-Forwarded-Encrypted: i=1; AJvYcCXkp7eboqv75hGonrP+J6eNHbLzDi30j9jzp92v8GrxRAwoqS24zUpiiJUBLt+ryaPa7LePAiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgaryBjZg+D3Pb3yozLDI0/8DeC1g3N8iJYn7I1pHgKCcb2ixC
	iyR5Os7mw+UuTLdG5EAMyQYJ7N0tVSG4DzbURcJkWSn6mkr6H6RAC6Jl
X-Gm-Gg: AZuq6aJniUR+J2AspEt9Oy+aqNOybQMS/pYOeDm+JJxXI2+sqjrCy90+MIje7YjFDS+
	Cc1shxPi9AozOvUEZ5canWh6er9MK8t3JTG2BUkcUV0VycBdqtQGIBba5ivwKTNYwxJ8Lr+Ba1C
	p+5nkwqPM93lgq6yeDT43UNTsdkKs5PQyEXrQuc7A5acMio8A7glGnvUKsV14tn7gI/2j3nrkqd
	Ut1iMI6tgKISTl+ftvwQA23jqwE5LIcrkG6tbnZOfkeI0g9JD8xMEpkZUbl7riwHiZgr+J0kQHj
	z4wukIad5qiSaxBdi2elPp5TMmwD2VigJdFPo5l6hQLhh3ZzOesRqzZcxh8zYkboVjdntJ2G1m6
	ZomaOUZlOm6OXb+gSeTy4L0nQ7tmF4P2BoIXbGxG/ns3NSA56RchvDrzpe+q28IAjQIrGWmg038
	Y3Ic8AWBNUHimTKYh49560l1X6E0l+40gijZglEkNINmq3jZGxE3Xd7QoZWmSiT+81+IVEjpjDV
	1H4GhD5n6K8RVLxBA6PX3w+vDM3j+WKCRDh5NMWC1khcoNxJJiZgyI0JCpsUv1qtOubVCc4nsVC
	w83wlg==
X-Received: by 2002:a17:907:9288:b0:b76:f57f:a2c3 with SMTP id a640c23a62f3a-b90819214c4mr711516866b.12.1771884305230;
        Mon, 23 Feb 2026 14:05:05 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.i2f7e30109524dc12-tp.internal (230.86.12.34.bc.googleusercontent.com. [34.12.86.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084f191b9sm359394666b.67.2026.02.23.14.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:05:04 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH net-next 1/2] rust: net: phy: expose genphy_config_aneg()
Date: Mon, 23 Feb 2026 22:05:00 +0000
Message-ID: <20260223220504.2102-2-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223220504.2102-1-iprintercanon@gmail.com>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B78B317E0B2
X-Rspamd-Action: no action

Add genphy_config_aneg() method to phy::Device, wrapping the C
function __genphy_config_aneg(). This is needed by PHY drivers that
perform custom BMCR configuration before calling the generic
auto-negotiation setup.

The wrapper calls __genphy_config_aneg(phydev, false) directly since
genphy_config_aneg() is a static inline function not visible to
bindgen.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 rust/kernel/net/phy.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 3ca99db5cccf..5ccadc5e2579 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -276,6 +276,15 @@ pub fn genphy_read_abilities(&mut self) -> Result {
         // So it's just an FFI call.
         to_result(unsafe { bindings::genphy_read_abilities(phydev) })
     }
+
+    /// Configures the advertisement and resets auto-negotiation
+    /// if auto-negotiation is enabled.
+    pub fn genphy_config_aneg(&mut self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        to_result(unsafe { bindings::__genphy_config_aneg(phydev, false) })
+    }
 }
 
 impl AsRef<kernel::device::Device> for Device {
-- 
2.43.0


