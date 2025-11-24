Return-Path: <netdev+bounces-241092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE2C7EF23
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 05:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCCC3A20F9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 04:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB232BE035;
	Mon, 24 Nov 2025 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB/jj6Nv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970302BDC0E
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763958834; cv=none; b=ZeKl3lyJu6MbvLy5w3zhlWGtcb2arKBJ58SKP0dGJukBJT4FZBaAlLYi8Y2FyGWF0h+t0IgdZ3tiJ/aIVjN5EM80yMK1zGW6nPj4wn/mq6D2jQKqwvOLr4eQyPFqvogYc/RaKGvM2OT+XpmlCLHx7c94jPaxGJt/PWIGJrNu3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763958834; c=relaxed/simple;
	bh=W6PBf7PdMxwl5sxXKwCDPTJg/Po+Avybb+Aqokp7zto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNO48QxCZx4Jyir7xs1/y8kCsoqmNlZjA1uhiAkFN+EePOZRG4Oln5gVeJ26va+HQ4WeMG4mj4Je3GtA54VgfkWKt9eGssAg5EQUtfdfLVUv8nY/CcMIgFP5+eqnJHf+cajbF2cJs6VmNwLWHIr4wNfCEWJ5U1xzjjDzRCIap2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB/jj6Nv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3438231df5fso5063465a91.2
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 20:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763958832; x=1764563632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh0e3cob9xg0UfNEEeCmm6wm0hKOqqoxoFVLHXYzIJs=;
        b=hB/jj6NvLngobFK+wDVbKit7J3iiNZ2Vt4iKdFTuwD61JBG7lsBsMMSD5YlgatB3IO
         2zKhSWfXLunH/myHDzKIEohFxMM44XKwpFvve8ndRhVLtSAyDZenNIaLa3cnCHABaJvM
         vBf8oS1w+h5D1H3aIPcglD4vRn8BYMu0cN2elrzlAOOZ1aA2k2Z9n59TWNnld3s6FClc
         nwksxy6yoPWqa4fKQHva2HaCfzdlcDXmkPHVQCPhpdE8usKDwxmKuL7tCKnPz3S1jxjw
         hIq4lJfcRJiAIObZ9aqRDMCFgvnm+eVhCzoxI02oFyhOUXq/roFPb/swCaFLJ/PZN7DC
         Rf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763958832; x=1764563632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hh0e3cob9xg0UfNEEeCmm6wm0hKOqqoxoFVLHXYzIJs=;
        b=s1b7zjxxW2Aozebdvt14vpUCOos+VQuzx4RtLb6XEsmh2m4J/LdwirWGdOVW2q0bpM
         0vEV2/rpNIWXcbQRm3WZbudFGIx0vjURv6sR6jUMHVhgfqujUFITb7ZuzjMnpvRvf+He
         OtXIeh8ENdCt7mgn9nPgdNhFKJ5CXnS68hzuytWGaFH0ylO9NjA/FIcbehux0AJR0N0r
         SmS3L3o7WExlvjb4eWUWaRmG9Gm31uyCGxP5hxTyJ5JQyxGd+n12nCx7skLwg29L0sVP
         wKwG1yjPMNcpfnYCw9cKEzkmFO5GhLbr2TuQX7Mdem7FCBhSBjONWpaqgyuSzbl59syR
         dccA==
X-Gm-Message-State: AOJu0Yyj23F2Ty8YjJDZWo8zT99ThttYMyy4JgsyyIPivWY3TbgqditL
	hy+8BlV0LUXyjK/iDth8lcZL6rPvpkJm0waIMsHAUit7i+cVBG9MKJLHDYRmTbsU
X-Gm-Gg: ASbGncvtg4XI0b5073R61ALypEjmsA97hvM1QxTBWnEdhPTepC7mRTTfII2k3fxe2Gk
	VIMK7jLEwDFCwy5y+BQ7LdHrOqPwU/FRzq79ghNNNIF+Nb6/PBhOCAXYdm3McNYMUC+at+49Ctr
	X21lusBXlBLXUn8RsQVNTqBXLVgrB7bhXyQye06sYfINjCTGYbHXpt8oJnsQzFELCRc60dcpU/M
	VbNZ82GkA9zNbu295fvSE4zdBJ5n/8MI2m5pEvXDjI4CG+3HGgzoC5oPpUEs3Z7AZTRWr9yb7TT
	Fk0c18CWjyIecwpP0tWqGU99dGPNfjMJDeas1ROEFYCZBbyaceyaEMBFlWJy/L6XMGW0JpJFNHd
	v29bC5ABne6v+/c0L4pD8mS93ICFuhfrmZ5iEdgFkkf/yPIf1/BZQczldMQn35FlhYW/irWj3gQ
	SkgiQkZsbuSLhZI+o=
X-Google-Smtp-Source: AGHT+IFS7PubKfEnizaVitxnmb/guztAvJx+5buvOkD1qNO/uxlfnExk2UHLqs0lv44/WStooZFrYw==
X-Received: by 2002:a17:90b:5704:b0:341:194:5e82 with SMTP id 98e67ed59e1d1-34733f4449bmr8964902a91.30.1763958831714;
        Sun, 23 Nov 2025 20:33:51 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm10359878a91.0.2025.11.23.20.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 20:33:51 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 1/3] bonding: set AD_RX_PORT_DISABLED when disabling a port
Date: Mon, 24 Nov 2025 04:33:08 +0000
Message-ID: <20251124043310.34073-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124043310.34073-1-liuhangbin@gmail.com>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When disabling a port’s collecting and distributing states, updating only
rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
so that the rx_machine transitions into the AD_RX_EXPIRED state.

One example is in ad_agg_selection_logic(): when a new aggregator is
selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED is
not set, the disabled port may remain stuck in AD_RX_CURRENT due to
continuing to receive partner LACP messages.

The __disable_port() called by ad_disable_collecting_distributing()
does not have this issue, since its caller also clears the
collecting/distributing bits.

The __disable_port() called by bond_3ad_bind_slave() should also be fine,
as the RX state machine is re-initialized to AD_RX_INITIALIZE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 49717b7b82a2..d6bd3615d129 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -205,6 +205,7 @@ static void __enable_collecting_port(struct port *port)
  */
 static inline void __disable_port(struct port *port)
 {
+	port->sm_rx_state = AD_RX_PORT_DISABLED;
 	bond_set_slave_inactive_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
 }
 
-- 
2.50.1


