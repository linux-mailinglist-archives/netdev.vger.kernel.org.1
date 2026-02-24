Return-Path: <netdev+bounces-260593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KsKGtjXnWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:54:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F4218A246
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C2BA30FC61D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784E53AA1A8;
	Tue, 24 Feb 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+DBacZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE13A9625
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951772; cv=none; b=VwzTc0PrxRQhM+pwaG2n1tutl1Rt0zRYepnWcVyHgND7q8g7BdoPC+0Zs308ic91eCpb22H4Wx5aejtfCADlz+k2IcNJAk2UsKBZyX/Z6tr32EFp7tTN/9D1sDKMHkXeLGqZifwlfJhkcZHn0J2kXOUAzL00UNFWY1WtazcSOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951772; c=relaxed/simple;
	bh=N68rztWaSPFT7EWLTVeEBYTiTamnBZR2Ck1uIkEXnO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrtIX4YJ+SY2sa2VxMRgEJyjvg3Vi5iEzwuU//1tHKQknLHe6XVQPy6QU0WnIfmfXAqnNaW/d6HUnbE9NmZtEBdKuefMdqn1SHgPJpAMDEgJGInCLOxiudw21MT36hXIlOd9IZY5VJopxezuBKZJdveKa0Ta3vJKfTwKNOgb7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+DBacZZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65b9608a9adso9720969a12.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771951769; x=1772556569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4JY4FtMQMrcvknA0R7jnHnULTW5UTmi+8FwqfvcNko=;
        b=I+DBacZZ659GtZSjo2xTWDrwOTf1zgFxvaQ6ubfHzKAM/VSbfn6MoCfIntTfFznzdA
         lTy0bS4i+lripc7iq4gXX8+gDf1g5lufp1UUTgEmdxHn5XJ9OgkwEtAxHqWSHXCEGZkK
         RqmPWuk95auLnFKUIb3b8MH5c6Wdk+du5u3pLkkh1RKrRh776bJP+vPcF60xKpmvUl4+
         EFDQPk49ciz07tVChVDznzGH7XlK7VTT9hPqP/xzxVsc9srYEjcExEX1NpLwff0VkR9O
         XhKLxt0Xei0DJnls32zxOw+/ts7/KdJNTFB/7V98kQRYRU0z7XNmltZWll7WSgoICZ49
         f0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951769; x=1772556569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4JY4FtMQMrcvknA0R7jnHnULTW5UTmi+8FwqfvcNko=;
        b=hFRDAY/5D0ghEQJEPBUcP7fIf82/NYoh+N5sah757hFaCkBFP6Nicszki1sRex0LY7
         IuNisfMy5KfcGT15fh7C6vlzn1Rk8sIbB2FiO0VriOliLXfRTyfrZ7Py/VEDE1bkkVYa
         ZT3XBB5oV7QUP8zh/UP9CvXANV8wEN4gArXprZvQlWwSPgsLDP8MeWgp5aqRDHxb94vx
         Xccl2lnEnaeCIGhiRbqqoF7VZH1Gm6Kxn1JU9E9XdA13O0BUC5E5FJOaLvc9HRQ0qDnc
         lKkIfXI+vufXCsNvw2O7FjKgeVOX8xMWgK02zMMcmNVvXzgBBRQfZXM3Nee2/06L57ZS
         n5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXMD2y4nM4FvFFkkrxvSE6mBvNo6H1wjKJ0Sinml9acDrwnN3BQLnPqhUh00meExzM8UeTaGqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyiP4C0ljOLzUidGo1Tw0Xbq0bn+l2nMcqJ33hVssWho5UvhVa
	/ym2eJEvb2OOG89/qgT4JtBxkAh26mzKnic9rwPqCfSKtCixYd3zp4Kk
X-Gm-Gg: ATEYQzwhc3+fBebtMG0hea3T/UW14okXE8eoioXO8h7xwZdFQ+vR5f02klPUxYaeS41
	ISwpDtsrwmm3/+Afpk7QrQiIBBltFc4jNvpAZcPr5lV5FqSzoYFcLszR7WL2qv7GSfGr/nndKUY
	selJfUPi+DPLnhqTKb6yV8l+bR2gF+0Ic61JSXqrv2LhLWdl/WQPt5xuHLVipFka51ZnKfNmh6v
	lbdhF6446S2P6HOZQXl1w9+b4Ujxuqi2oipaURytL/Sju1ZWI1EaHSI6dKBR5Bxp5tGlnbXQGYo
	X8WNKFo59ro3KSnYQyCOVSGqRGebFrJPsJk6ra50kYfbzKQRuDNN8CqIG6O7TwiqHOiNSXDEZsZ
	dq/CgAyYt9QWRCCvhyuKpdGNxv4suNvW01dS0ERtZL3kvpGtEKP/IyJq7fRKKyhrl9bLlnccYVZ
	HFBqI+yZrXPcCQ6FSeTsV3O6ZNMOw2IXUJhnMEf/TZrjQTpcUIz4jstb7qtOsOwE8Sr7zxxhvwA
	/i5Cf9CVbQe2mi22ldqBeFo+q0/hI3JnUQSixGjSiGqlp775oS4/G8wUaoiRhwagXNk
X-Received: by 2002:a05:6402:24da:b0:65b:fa9f:fce4 with SMTP id 4fb4d7f45d1cf-65ea4f1d6demr5539931a12.27.1771951768246;
        Tue, 24 Feb 2026 08:49:28 -0800 (PST)
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
Subject: [PATCH net-next v3 1/2] rust: net: phy: add speed() getter to Device
Date: Tue, 24 Feb 2026 16:49:25 +0000
Message-ID: <20260224164926.1760-2-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224164926.1760-1-iprintercanon@gmail.com>
References: <20260224043211.1747-1-iprintercanon@gmail.com>
 <20260224164926.1760-1-iprintercanon@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-260593-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 49F4218A246
X-Rspamd-Action: no action

Add a speed() getter to phy::Device that reads the current link speed
from the phy_device struct. This is needed by PHY drivers that must
detect speed changes in their read_status callback.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 rust/kernel/net/phy.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 3ca99db5cccf..3812f8fd3e49 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -158,6 +158,14 @@ pub fn is_autoneg_completed(&self) -> bool {
         bit_field.get(15, 1) == AUTONEG_COMPLETED
     }
 
+    /// Gets the current link speed.
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


