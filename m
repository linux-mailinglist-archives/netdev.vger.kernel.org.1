Return-Path: <netdev+bounces-260331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9IvVCycqnWmmNAQAu9opvQ
	(envelope-from <netdev+bounces-260331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:33:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBE1181AAF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7ADA03044DD2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207522BF006;
	Tue, 24 Feb 2026 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdGPyQGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E1284B36
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771907539; cv=none; b=aG7g14LZTYjAIE1BqBuse9LZ5lzgIx/+JB5H0NL6bKVZWuSEDyndEdh/Ns+cKfjzsIFafjJZ6Aa+GuhBDjvsiQUVSOuAL+9X5erQ0mkQUatGRFTGkpjnIZg7wj6vng/AHtHLld/LBF7NrvJoLscsbYyaXYnV+Av27F3ouBWHlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771907539; c=relaxed/simple;
	bh=b1xLgounYgAgwix7HTIz89qnAwlJn9qu3/e7SYKIiwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXjzNsy/UYp8OsxTu5Li5VcpZtQYdu1x1gabpvXoAhdmNQK1bU0ITcQ7C07vLttct6bJ5GiZKVxaGWXenhv/C+J1P479po3RyCmOxdTeO8/odkhzlEGdwYCVdXwqbVD4xyUBtABCzKK5G9IlCmI6RzY3GNk0WrjKnRd83GLwfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdGPyQGd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65baa72399fso6734798a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 20:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771907534; x=1772512334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siyGLrMfYzfWpKFoliNweeMXGBRAFWTpZWYm7LAc1oE=;
        b=TdGPyQGdK3oSwAxxSiYzeVbtxiTigeB7wXXSHcKB/tzEtFkT33s8Hz3Cvupio/4+fr
         klYvKDU21KGDIAdLOCNqIxt4rHBw/yYG9r7OiXJObMaVQlUf2QKynR0yaHlGaAoXGrkV
         yW0Kz3GbEWjdrkhM2kE3gBnJEYsmR1GBNi8I1P1DCasNmF+lG7qWkJEMu5r4wdwfxY6l
         g+hsLmT3nyiEtJ9U/agFw/e/6Bv1NTOArq3MEKjZ2n5JFC6v0QrCgBRHNYnpnmZubgS7
         p8+xgrVFMyUxMcQ9jF99lnJM8BN90nQeBTbBCtpBtiAJpV9iOGt6gcAcrZgisRW0gH4u
         pKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771907534; x=1772512334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=siyGLrMfYzfWpKFoliNweeMXGBRAFWTpZWYm7LAc1oE=;
        b=OkWRmJTxIQ6vxWUltRCBvziIOSJRUTSo1XVM0rk6T0T0xYTApy0GrMvWDSBIFryeZv
         X8yAiqw+PF/MJstAjmdxJ4naE+Kj9aEy9v3bshdTzl289iuznhY6MRWhHk0P721WyItr
         +VjmuztR7Z5ooxLfsovQpE4MExe6RDdNiq4vCR9snOFdyEtIqjs74bVwFcOZDZ0R6yIM
         3OcU3AzRL3heTEPi7cAyQkKCnn96wpJBCd7migF9aatcFxK8+IYmLEqBlSbpB/iwd74J
         spCMbdmDW++5efvvRve8CFy69jzWzip297Ai8CrB27Ooji2Vg96ToydMGlwhfjfbZgs4
         g8VA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Y4iXx6jXV8AwXy4R5S7GXPUwP21cADoMdTKZQorissRhnG+1x/kHGXcP272xpvNan0B8t8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85u+QL4XMo1skufut8qTY47JrgmMiEC86iypqW8DGp95PyULl
	7cYDreueg0M5ysskrau/4H4EIihYNqfBcJDNsNU0WTqreGvLxls1JwWb
X-Gm-Gg: AZuq6aJu5WqzhzfBHRErNdOhiQyIuEAWTDkCWrNOZSk3m1fiLiQSX5pLlMpul0UlPE7
	ZSpXgwcSis1HUCUR9Oi9z3yFVk53vET6V0hWb3TbZTiLB29/nZlbLYBeZwbIrXY0iJ2BhQN5b3S
	SjyiZr5YK/C0rveGRSiteRy9CI6Db5om8kmPL2hYH0Xn9bFCOfbqdWTz8vBrmBUyuaOlZU3f4sg
	mGjp6/F50b9K59HE5UVBghLRE/NsKWnRrXWWLMVv7JGJ48PDnaDKRBpWQe2gXLI6akiS6waUZN5
	t/+SUQwgKMyjHob/zDXmIltYoim07V4dp3Y/KbYBXAQhV1gMM4+XgtqP3BRvjHa9i74InlUWLYZ
	XjFLTHDeEO1Yg51/wSc0EfFqFftjDAzIgNbBM3UFipbWIxG1VyekgJdRR6CcJxgj7yMlD3U34OU
	vuKWHzR3Zo8ZLoKdOb7GJQU6Oh6Kr+SLRe8yMlgrI7rkuWWrk1q8NOafQUq6h/ZZ5ImQqAvrvr6
	hLYQKU27jKqHV0HGDECPPGGKrksAm7GsPBAbqEufkZB+XNItsZzxmKhAWjsVjrp9Zo4zqX6Kg==
X-Received: by 2002:a17:906:9f85:b0:b8e:d4ed:5eeb with SMTP id a640c23a62f3a-b9081a45252mr723264366b.26.1771907534454;
        Mon, 23 Feb 2026 20:32:14 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.i2f7e30109524dc12-tp.internal (206.242.32.34.bc.googleusercontent.com. [34.32.242.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9088c8fc30sm371284466b.63.2026.02.23.20.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 20:32:13 -0800 (PST)
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
Subject: [PATCH net-next v2 2/3] rust: net: phy: expose genphy_config_aneg()
Date: Tue, 24 Feb 2026 04:32:10 +0000
Message-ID: <20260224043211.1747-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224043211.1747-1-iprintercanon@gmail.com>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
 <20260224043211.1747-1-iprintercanon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260331-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BBE1181AAF
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
index b86939b163e3..01597f2616fd 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -284,6 +284,15 @@ pub fn genphy_read_abilities(&mut self) -> Result {
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


