Return-Path: <netdev+bounces-51599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A47FB4D3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EEAB216E7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862C31EB3F;
	Tue, 28 Nov 2023 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWJxCqIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2BD18D
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:54 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b5714439b3so2526021b6e.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161453; x=1701766253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxvhsW0saJ83g6e5ZOFAk3YuOJwuK9obkrTu/0UtzO4=;
        b=gWJxCqIkETaZXtxsGfeqSLWyy0KiBroeuhT5t+oyD9FtnQyB3HL1H0IJo9KoncSiMN
         NqvKBL5KniMeZEb+J1kJC26SQ4kGHJkDgXITWA3KjNW65Ur+l1Wrn49sYZcOuhpqIxoB
         8v4TGXR0P2C02I5Ed2/9YVPfpXCSzISXVWaUyP09op/rwX0VMg7FFNrNgSyeza4aUq4A
         yGqWVy+ZgTKhFtpMvdwNRtsmWDNpROnK2+/rVvY79j2hwtwa0BmwSYq0K4leJvhi9VAy
         mkkxSomiaAaIn54CiYUOPNBNgW/mzlYLatxnmAHE7dFAE7I88Yh0oWMzQycpIC9Cjfti
         QPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161453; x=1701766253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxvhsW0saJ83g6e5ZOFAk3YuOJwuK9obkrTu/0UtzO4=;
        b=cR8c00CuMpDH92s1tGbBhgKSzIKlJEF6cAeLz0C9N1QmnZ5uutKbwrlRy9vy7hNf3G
         UkyhM3yb0JlHs38+dFCqINOrhNWO/96SCfTvRn9m93bDQgQ1sWGIhqJypyPxEz6nz3tK
         Rv71W23A3lIBa5O5V1NyM+yu0Zkp6G4Y1Nt4S7aGMbxegeEo2oRZFTPty4ZUzxEueGRs
         X5aF8e1MlL8kzaJ9BSl787oL6hQi9RFGtFE2QI4j8lHLp78VcfAmDFRmogusXzq3Xl4s
         meYsqPF6tC8EasUankZQBG5mEgFXLTGEC8lGhA78AXs3Gju7Dw+4e/IzixQMkNMnzxxh
         nqbg==
X-Gm-Message-State: AOJu0YyNQPHkp1wntmAQDTAh2pSvfDzT5fhSA+lgAeItmC4FwOneomET
	61O10CpG9nqvBgWaNQkRVC1fZ938Src+cQDA
X-Google-Smtp-Source: AGHT+IGCWgdjbl9Mlpq70ZYL0PkUpeZcltqRA66U7SzrbrVD+96B99joNLXt3CbLqj2FYbpOseRJ6Q==
X-Received: by 2002:a05:6808:14:b0:3a9:e8e2:57a7 with SMTP id u20-20020a056808001400b003a9e8e257a7mr13674579oic.53.1701161453321;
        Tue, 28 Nov 2023 00:50:53 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:52 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 10/10] docs: bridge: add other features
Date: Tue, 28 Nov 2023 16:49:43 +0800
Message-ID: <20231128084943.637091-11-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128084943.637091-1-liuhangbin@gmail.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some features that are not appropriate for the existing section to
the "Others" part of the bridge document.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 06c2915211d8..ed48e860c12e 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -270,6 +270,20 @@ So, br_netfilter is only needed if users, for some reason, need to use
 ip(6)tables to filter packets forwarded by the bridge, or NAT bridged
 traffic. For pure link layer filtering, this module isn't needed.
 
+Other Features
+==============
+
+The Linux bridge also supports `IEEE 802.11 Proxy ARP
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=958501163ddd6ea22a98f94fa0e7ce6d4734e5c4>`_,
+`Media Redundancy Protocol (MRP)
+<https://lore.kernel.org/netdev/20200426132208.3232-1-horatiu.vultur@microchip.com/>`_,
+`Media Redundancy Protocol (MRP) LC mode
+<https://lore.kernel.org/r/20201124082525.273820-1-horatiu.vultur@microchip.com>`_,
+`IEEE 802.1X port authentication
+<https://lore.kernel.org/netdev/20220218155148.2329797-1-schultz.hans+netdev@gmail.com/>`_,
+and `MAC Authentication Bypass (MAB)
+<https://lore.kernel.org/netdev/20221101193922.2125323-2-idosch@nvidia.com/>`_.
+
 FAQ
 ===
 
-- 
2.41.0


