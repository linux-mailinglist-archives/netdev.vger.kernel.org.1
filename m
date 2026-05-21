Return-Path: <netdev+bounces-290504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WbhKHZciD2rBGQYAu9opvQ
	(envelope-from <netdev+bounces-290504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:19:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D85A82C2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DC0433EAB3A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5111D3F54DA;
	Thu, 21 May 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKO9LRF2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D03F1AA3
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374559; cv=none; b=Dw3Je78woCfSPPinRPWJyoY6HojdAtkeD4i7J7JMgn62uDbKS52fuVJIGj6q9Q1g5/6aLkk2SQkPz6UYk31o0LpzCWnENtmRnrGaraFSfs+s4Z2GD/72qAYBqLtH2+ACtU5i8lKlGrspbT/vyqqZAOmFPQRjyRCBApbbLlTMVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374559; c=relaxed/simple;
	bh=JLb8dakvmIkiwIQ9BNtmiqDgh2DZEgTaUcPC8AgYwes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wf2uYxo1K/24zKWMSMR0wqtt39Av8bU5HilakuS33Wm9JrczTzveFKWStGQk1QDScVGCNDzZA2trZsZqPUivDVyXGeZcJNEPHjc9msXDPCh9Fq/+oDDUvjIQl+2Pd8scwt/MIPqRHI/DOVEJuFcxzyS5yrkJWYDAMdgf+HhNQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKO9LRF2; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651bf695701so6018334d50.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374557; x=1779979357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mENXEUb2I/IvitDd5eC5WRpQQNrmeFgj2UUSvwpfHeY=;
        b=qKO9LRF2UnxnP+DcHJPCXdI8rsrIvscuOah5ocTUWzIogWlUKpWso+CaPbRekC9se5
         sKvaUA9K5ks5HO/Aj/+tBlnrx1W/ftQV6/0oYrThZ3betqmbFMGV+zQioBHo/YlC9v1d
         EQjCocN+LduiD3lrVIGLCsvt1GpEMCyz54SRpSJH8nakZtEBfyzMR3S5dM1SSCifLFs+
         jiGR7nuL4T3sW5V1Qv10X5NW6/cp3nIbZRfdn5RUjOsCSH0OIYVpe983jzFQDZFxlO3/
         n9m5vB4S8skeNHGrtOfaCy2WoyjgseY+UzPT256DK/eg+8fpZtNi8A/IjRCO6AoVgln6
         V7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374557; x=1779979357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mENXEUb2I/IvitDd5eC5WRpQQNrmeFgj2UUSvwpfHeY=;
        b=W1qGrPrZ9sBqWx0ZAfDb6R4MU92k+sjD7iUKseXwI6qjY4DXieiodtvJLxg95bqeKT
         wDLw8AMym8DWYml5f5R8d9thiI+zNjZOUd34gqWFSNthQrezEpXeLDwGNFf+Vd4chLNp
         ZdGhIR/htzfxfyHpM7HhAWz4iqsmIyyVYlOd68sBlK8q6Ha0BzRUdVVmyzE8LC+eR6gT
         1w34iwzkNRUbGKQgqSygO7RCeEyzYZmUk1jNyki2gmgY6VSOu6ILOdCW6D2BqpqKI8CS
         Sh/Ws2QHcwYK/dQGWm3NsvztQfSfUUJcNU+3YAcgOVIaqK+4PUlvxx/tgC5qaWaro/qL
         3pJw==
X-Forwarded-Encrypted: i=1; AFNElJ96yj9TFgLhXb0B3n1l4GslwJkasaI5kfdsYquRcdZAWa8BlYl+nWxi4gP2VIap3TJtG7itpck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAmy05N7qztuBBT6Z9Gs7M6CBWbg2ya5AT55+WI3LgcjFiqKH
	xgjlN+ZcU3s7sjD8sQD9wN00ynHfXxr3XD8WZzdm6bxK1EEIFrYTXTBX
X-Gm-Gg: Acq92OH62yW2xPcpvhizoPzC5fq3RIgsw+m8wST2R2DK020U4a4Xbj0Zy1oz9G3zNT0
	g5T77wSLHk5OmaCOvop0HnOndoEPkifqH8DNe+OFm2ztzrTUDkzI5gubeAA02qrLddXxkC9m/vb
	x1y3p3HPrhn5sQe1v5JGlzHPpO6rgmSNyPNpXOUOmeK2g5NW0Sg8soza8NmILEDLWHjX5k5Il77
	ENZYEeSkFTGeRwoImJ6KWHIfBmfWlruMqAgIZRHB90ABmL6FVehnqoHL7NqXKj/qYzBt+M5Ti4r
	3+Mw4fxXVnuF7e0V2v8Drs1UjRXp3S/LurKTIxsjj3XKeA3d6RHUwTfUAJyQ4kx/UFd6jf3yRC+
	3jv0X+styAFTDZ3Zj/vRiS93t2GHTqXRh0VEGZmp2TbotTjJDGlHhJJhtcoeWmYE+Hhoa9GLxcW
	rol2maxA+0Ax0Tkz5x+jT6+82MpoLxju2fdXR1bQPTy04Ko/XjVlFx
X-Received: by 2002:a05:690e:124d:b0:65d:8f98:6bb4 with SMTP id 956f58d0204a3-65eae00c434mr2809147d50.29.1779374556706;
        Thu, 21 May 2026 07:42:36 -0700 (PDT)
Received: from fsh.attlocal.net ([2600:1702:56e9:4b40:ed8c:6b8b:1fa3:d14b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2cac72ebesm3596107b3.41.2026.05.21.07.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:42:36 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: krzk+dt@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: mdio: remove deprecated .txt binding stub
Date: Thu, 21 May 2026 09:42:34 -0500
Message-ID: <20260521144235.3414-1-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290504-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 099D85A82C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The plain text binding file was superseded by the YAML schema in
commit 62d77ff7ecbf ("dt-bindings: net: Add a YAML schemas for the
generic MDIO options"). The file now contains only a redirect notice.
Remove it.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 Documentation/devicetree/bindings/net/mdio.txt | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/net/mdio.txt

diff --git a/Documentation/devicetree/bindings/net/mdio.txt b/Documentation/devicetree/bindings/net/mdio.txt
deleted file mode 100644
index cf8a01054..000000000
--- a/Documentation/devicetree/bindings/net/mdio.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has moved to mdio.yaml.
-- 
2.54.0


