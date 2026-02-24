Return-Path: <netdev+bounces-260591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Hg+DcLXnWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:54:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB29B18A217
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3256A3068A48
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF63A962E;
	Tue, 24 Feb 2026 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOoZHcY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E63A961B
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951771; cv=none; b=Kq7egFWI2IOaGVLK5A9i9sH8DxPZ8hI+B7Fud1dxXzCnKapHGkrngeXh3AI7qkfndsXiTLRPdjkSHy3DhQZ8vJmDpGPUF8pa5f7yaKWlJDaMhywfg6mP0Kc/5bepylIBSVeRe68ZVGIHXZdmIY7zUR9gd/0D3Eo/nEf3mbu2Cg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951771; c=relaxed/simple;
	bh=EN/Ks3g8lgtC51URMTxXxDpUpldSH9S/dOB1pXvWwGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARTDxZeQjQRQyhzOdJJ6UP22nXzxNlC2RvGC5+NRCxo4f92fEeDVQDhR868IwBCl+u8wqO8VvwwToWJcXfmO93ctf9sOUL4fNdLOPbxwLXmM8Ia44+jKjqk5iWjp9S9V9kWIn488QnrN23q8VSbEJ5e/Q4H/mV76gKPZvBQbKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOoZHcY4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9047e72201so851410366b.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771951768; x=1772556568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/4jdgDH4nJh+ZV/35H0g53wBVJcWnan+PpgsjjzZOo=;
        b=VOoZHcY4YG+bQ1YOSNNEChFr3lc5xqdsvtWfohMdMKISUmKMTi1pxMgVSPzUoE/nTD
         Q9rZe/qaN0qKtVxNUrLEsyPsBhvkUqPTnlItluL9YiZszT4+N4eBJQ8lxcjj0iWtIS60
         kom+uqZe7+P6UEkpFIeP/avgH50uMxwnOZBKktObQDHGtq11zUstPu9gseV7PdVG2A+g
         1bc5BYYFtqvd3Kaw/5Oy28z0Cs6J0GspGfbYwljFY4CZOCgUUkPE0Nea5/2LxUHQpRoT
         yJFaG3iiThWTiWGc/10oMWbiP+apteNkUa56HDonJzoUKLVQ/VxB7vnXL9yf+xASr34O
         Z+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951768; x=1772556568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/4jdgDH4nJh+ZV/35H0g53wBVJcWnan+PpgsjjzZOo=;
        b=JnmSvY/qGPw6gZByIBJE61AKTN2+vfjcDwapvBEsKJJ16DGkDWqX5JEqOfqVJ8wxv4
         Mq60hOi8i49pIhOON3CStpM/aImRm3pNKBHFVgy1ZsQxryT/MDriCvgLsLgyEfCz9T9L
         ZDvLcNeIdfPyxaXHfF6MbJ7LaDbjy/TDEyZEFJkh+Q+7TJBiu0hFHQ6oFS+PhV/6ZUQk
         Fv6nNg8fBUtd2ykugFk00vuijlIselVoNlwn5fLH0d9zWOW770azWSvRX/RMj7dW5Lbl
         kXyZH6WtJbop78P122RtcikppxYNBYHWzWyd3GmRN6iHPlM57wP4VaDWiVcyYVtSF0ab
         x2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Uv652xQVLmeJbNigtpn9qXnp2DgrWxt1INj/MOYaQH2u3T75Q5kp69jRgf9I2TM7dgTFRyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cJcmNVnzTHoR99WE/H8+JvPWdYetnjRN3tnveL7K0ugBrMiP
	E5snXvqh7Ld90GBWGLG2VWxzNz2k3+0UTYr7HP2W9sWnUSHK5EZ1nPUY
X-Gm-Gg: AZuq6aLMGdd0RnBXR1CeRjvtjKD65VaYLTtQZPMrLQs8AIXQ9X/tJ9qEGuEm/hldNke
	vrtNoKpxO5NlbzRL1YtvAJWzinISHjDRA06bMEmM8/xkyVjqLD+YVWr/CD39e2BxDDMFxAVUtL1
	Iz9KcpPIoLQIuJKdbjNRsHPoEkaGZy/T+5V26yTj2PhwbHs3WtS/7ak8wbXPFnXLayB8T/A8CzG
	sSXcU4HjkcvPsgy+lWK4ne+iRwSr1GbrRIXFoLIXV0saTQmHFAx7uFcUkxd1e0eCRQrct7Iah6L
	BbGlD/wRqaZS0KOI+TY9o2r6JqwPYpwTd6LSGfvoovDo5JWoDQ93iinyB0NCrGicKMaol2oxNRL
	EOzUe9B3VZ8YWCAblEQQtcXhABOW7A43g26mUY4SqJbCq4VkwjKMsBGc6dbV34uLDrtQWGcx+PF
	oXnIz8GyoNK0kBgMdMx70J9FvHXka5BtiXG/7HAQDTGONzUsHfQEbn2gHoh69N/9JJLHGw2MvS3
	qImcW2iMb6nLUMHzO/E6wCl3C66I2HPICcoCrSsVC0fPruRxt+gVD3i1V2jqQUBMX34
X-Received: by 2002:a17:907:9723:b0:b8f:b222:34d with SMTP id a640c23a62f3a-b908191f2b4mr918950466b.5.1771951767709;
        Tue, 24 Feb 2026 08:49:27 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.i2f7e30109524dc12-tp.internal (30.49.91.34.bc.googleusercontent.com. [34.91.49.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eab9a077asm3771023a12.4.2026.02.24.08.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:49:27 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH net-next v3 0/2] net: phy: add Rust reference driver for ET1011C
Date: Tue, 24 Feb 2026 16:49:24 +0000
Message-ID: <20260224164926.1760-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224043211.1747-1-iprintercanon@gmail.com>
References: <20260224043211.1747-1-iprintercanon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260591-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,umich.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB29B18A217
X-Rspamd-Action: no action

This series adds a Rust reference driver for the LSI ET1011C PHY,
following the pattern established by the existing Rust Asix PHY driver
(ax88796b_rust.rs).

Patch 1 adds a speed() getter to phy::Device, needed to detect speed
changes in read_status.

Patch 2 adds the Rust ET1011C driver itself, implementing soft_reset
and read_status callbacks.

Changes since v2:
  - Replaced custom config_aneg with soft_reset callback using
    genphy_soft_reset(), which properly polls the self-clearing
    BMCR_RESET bit and handles autoneg/forced mode (Andrew Lunn)
  - Removed all BMCR constant definitions (no longer needed)
  - Dropped genphy_config_aneg() abstraction patch (no longer used)

Changes since v1:
  - Added speed() getter to properly detect speed changes (Andrew Lunn)
  - read_status now only reconfigures registers when speed changes,
    matching the C driver behavior (Andrew Lunn)

Artem Lytkin (2):
  rust: net: phy: add speed() getter to Device
  net: phy: add Rust reference driver for ET1011C

 drivers/net/phy/Kconfig         |  9 +++++
 drivers/net/phy/Makefile        |  6 ++-
 drivers/net/phy/et1011c_rust.rs | 69 +++++++++++++++++++++++++++++++++
 rust/kernel/net/phy.rs          |  8 ++++
 4 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/et1011c_rust.rs

-- 
2.43.0


