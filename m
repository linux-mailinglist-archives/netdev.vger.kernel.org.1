Return-Path: <netdev+bounces-260330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ex8BLoqnWmfNAQAu9opvQ
	(envelope-from <netdev+bounces-260330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:36:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6675C181AE5
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A979A318707D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18271280CE0;
	Tue, 24 Feb 2026 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZXfwg/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49479292936
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771907537; cv=none; b=QUR0QgVXiqa4Om/n0u439ILR/bjmrY9prj89AUBh98ChSiv8ucECcT1Nc2r6g4RTgSxW80rN9/kWkYKW6JgPsyUYjD4RmfJqyFwD3ZpHYa/ktpBFySC/N9FeCIy1tWVwo/vQNe/J9bbE7/lkczhdvFHYD5CXgv8qPwU7b7dOwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771907537; c=relaxed/simple;
	bh=UEnQcp4MGlJixya53SMjZLpT9RLhpMLIX7hTK536NMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUXMnCDjePRtrwcVvO3H8YKDJ4vSzO5IMLXiVP9QUueGkdViyOJtXgpUXfcnnF1/k7D4msY8p/s4Man5gpr5xfw0dShpi0sdHipPZaeMFf+DpqWMK0SyUZZtBncChHCnuUZuUh0gAfFAuwgHl/j8feDH1qeSPlLpC6JgF9vWm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZXfwg/4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b90bb0e8376so179511166b.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 20:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771907534; x=1772512334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2TVn9WTr30egH9VBmZciSNVmo3+g7N5E2PAqbC/nLw=;
        b=LZXfwg/4tZ6HhrT9jl4EPeGkI3uDTT+znbzZuqrGm3vqHETOCp7DPPE4I3BJrlY4Ss
         gIM0R+yR0HQZ0LzBT26e1/i7HupkrLuAq+TathWp8I10RzEs8qkmUtzdkXGkQ5+avt/H
         G6Dyz1UOpDSv+woBt1K9ajTq7ncVzzwaXL8a7jty3Ww3nzipSa+BNaql3n9Dgx9JNZ6m
         aTMaK6pRB0Kpwnmwb6Tkc9K11m4ai/BG3huTEC/C0FYS03x1NonMLYM5d33e8darWG8M
         Wi39KgQVgU4MeZlc2Thf+hwyBZtPwjxRmc4RRhTj/JKoQBLccVXVliowTnGN3CHccqQ9
         lTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771907534; x=1772512334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2TVn9WTr30egH9VBmZciSNVmo3+g7N5E2PAqbC/nLw=;
        b=LkZV41P18TOiY+T5coy7IrEe4iIjhxtvEpMUEktRx5JqhMP2bOuN5e3PTAwrZPLPQT
         UU+cbLWHpibmZBy8mvlSHXayhQr0FrWedZhxSWj47dQjQa56wAPiAKEr9rvWArGqbQoG
         Ngdb5KOgTBGmQXMrT5MeDfMMG83W/OiRF/rSW5N4iv4PnH5bSEviWbhKl+DMNzhQ+Iuu
         PqSthWlJh2q6tNUbhwTxKKrJ+aZ/QVk6Sr6BcA6J4+MMMWiIEh7FQ0S85K3YAX39BlHa
         rvb1FC1Z0roJaIPQ+cb+z/QjhhPmv7VJ0xj1V1Rat6oIVdeSzcmtD7c1YDJOF+fNIZIQ
         atfw==
X-Forwarded-Encrypted: i=1; AJvYcCU+8T5X4wF8psNLS9K4/W1JllpGaJC/bieN73GQosaMfWWM9IaCqgtb+ugy0aqlwlNZUuCUw4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNANYqYq2jV/lJoGaG9GhojGRja64ynI0SrhRD1eAUzASI66I0
	7nIR0KvK2lIyA879Zt0EfOKg0ui3CYVQ/1xg9kK5C6QuPP8J94sj+ZmM
X-Gm-Gg: AZuq6aIDBUjph1/AKvJ70HzgIbMhXYQdBRjUHPljEAf6zUBWaJtVCNB3kgLbKOu+dKl
	G3HsLXYbeGUGRgeIeHNsbWVAJ6cyzX9GY5ZAVszhl40xp7GoWzg2KoghchWq9V8orLcxGMYNAVg
	nzer++wPOdk8gy9d3uHUVIci0Ucmx32WI2vgndtCeSfsGcHJgzvn4mn+Wmd8nAN+BW8DaUp7fs1
	ggE26oRF+5MvsVYpIjQGvufV7JdFS3PtiWeo3eWmwuX9BOfdl+faXtNilBCLYy2GL6tAFLezur/
	CBXsw2NaXq+ZqIyvJfINWNGm/9dO0CC104Zce8tN8N0viS9WguAPJd+mDmT4w53Lw2uWpwdTuiB
	cRhJALAHWn11unVT0E3AcT3RnfvL0KoR5a2df8ULuvwiMJ3QG7D2lb/s4diDYP2SdWGbWIkvBaF
	5X7tI7A1ynOyj9K9dlTvgGajpp0GgFqaIngOvK7+Y/1u2fkZwdSLwUxjAVbGkm5EHhJ2CWAtjzX
	xglunpUqtAWR5h2FQX89bM67K/29l2zZ0FA1APS2EwNo0mRx3CoryUQdcUQX7KFEd3zRS33aQ==
X-Received: by 2002:a17:907:6e8c:b0:b87:19ae:eb36 with SMTP id a640c23a62f3a-b90541616bdmr926260366b.7.1771907533547;
        Mon, 23 Feb 2026 20:32:13 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.i2f7e30109524dc12-tp.internal (206.242.32.34.bc.googleusercontent.com. [34.32.242.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9088c8fc30sm371284466b.63.2026.02.23.20.32.12
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
Subject: [PATCH net-next v2 1/3] rust: net: phy: add speed() getter to Device
Date: Tue, 24 Feb 2026 04:32:09 +0000
Message-ID: <20260224043211.1747-2-iprintercanon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260330-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6675C181AE5
X-Rspamd-Action: no action

Add a speed() method to phy::Device as a getter counterpart to the
existing set_speed(). This is needed by PHY drivers that need to
detect speed changes, such as drivers that must reconfigure hardware
registers when the link speed changes.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 rust/kernel/net/phy.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 3ca99db5cccf..b86939b163e3 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -158,6 +158,14 @@ pub fn is_autoneg_completed(&self) -> bool {
         bit_field.get(15, 1) == AUTONEG_COMPLETED
     }
 
+    /// Gets the negotiated speed of the PHY.
+    pub fn speed(&self) -> i32 {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        unsafe { (*phydev).speed }
+    }
+
     /// Sets the speed of the PHY.
     pub fn set_speed(&mut self, speed: u32) {
         let phydev = self.0.get();
-- 
2.43.0


