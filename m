Return-Path: <netdev+bounces-202744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F3AEECDE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 05:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DB31792DC
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3F1FBCB0;
	Tue,  1 Jul 2025 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1u0kWnr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED761EDA2C;
	Tue,  1 Jul 2025 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339594; cv=none; b=peoF9KxVQRRc2H4piFcm84ObMUYAWCrqXojyBHl9F5NmMC9PCS7EhulZ5YJUbwgK42Rw7/RteYJ8NcIvGxgE7P+xS32SyfXHvtLleYGxryTCey6p4Z8/nwpHYdOkHqTCLnoRLxqjVSHhl3vHuYrZMUDM5fIWNTn4Gatl8tJOqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339594; c=relaxed/simple;
	bh=Mo3qLJAqGtaw/5KsjboFvgs0yCHJgHSanxBj1p5XsGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9IdwEU1xa2aySUyfSsY0R6cMQ+H6qVq7byw10HZzW5ZjHMJayqLZxw+ZI53uW5CkendBWfpw8rMcW/ZhicSPtKS+UAWhYZfKY9EFRF+8RLfcw/+jKeWZP8GXZuTjLTXRQKh+n0d0x16ELR5mKMaIRu2tmvXBiwE2jM+UZexchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1u0kWnr; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3220c39cffso3088499a12.0;
        Mon, 30 Jun 2025 20:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751339592; x=1751944392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD26qqoj7KryJYkEgO4QEZYoJxSM1+Fc8ROnt89bQJU=;
        b=d1u0kWnrAkERRJcgh1Z5gnQKWMLvwo009eUNViqUqQ++3/XFXlTsly3zpDZ5KabCIB
         Hibocrr6AmG4bKQtifrCZ3h0laaiXt/w3gzfZO58dX4CaZprXI64DVjWxBy7Aj3mtYGc
         xsxiQpPxHHBt/59IeuvDwyQipKwyioR63E+BSO1xSpmWk0e4lao+E1fZ7x18+bfiTXvz
         BSucrZ1UeM5H+CvZn1XbiUwloDU3iFrKAogY5gJgqBO98YjnJ/DapA7vADPWzVU5kVAL
         0ugF3Zg7ieg6CO7sbOCdCMKYyRtUaTua0Oc/BSJcz0baDkObPPLt/AU8FG2u4yi0yaUH
         QPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751339592; x=1751944392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD26qqoj7KryJYkEgO4QEZYoJxSM1+Fc8ROnt89bQJU=;
        b=pzbIBjb79YwHHb3AgNrWbdBbT7oySymyYyBV2RHTgJNWn1KAfjx2fgX0IzADKwKo70
         e2R6ACBz1mOEb1ySR4Cr9Wm5rjF1hGxlXi1HwjEWYqIk09tM/p2n7Jp3CyFhLS4KpBYZ
         jGmeV+pyYt+nD398sUYFQ2Ezb74vYNAmACoWooCaa9mqHb8JHwDWjx5bod8jluVz6UZ6
         iKMwnGfpSbr2qnbNQrw9X4b6ApcCqtM3m6G3QEZp1ayOM4sNE9r+wiMuyQQ6xQtT8ww3
         1CGsog9IfJudY/HaDOPC71Q/aE+X85dNs9m7vfi1pM/IJSeSFs78nJxRY6UeE6AuTZXE
         6XKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrqR9CByTwGNEWPyYBUvc5zNVZxJ852jmSIwDHOFUpnAbQgjD0XlOVvwVa+OhwKRgSZX1tlE47@vger.kernel.org, AJvYcCXF53LdSiZ2+6Fvi4/5i78x4SGvn5PDzaCq8rWU2gw4AlLfrcUSusCN/fvGIf2JMri/wIqcvqpaiCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7lzegGtbl6kLOYJPPYO7TNbTbg1ftTwxhVW/5VUgHjdoOCje
	G81Jkk8lMjsKqUdJ/Nydgac7GGQU6m86Aqodd2lwQ2tdWVwZXn9MMUUG
X-Gm-Gg: ASbGnctNLuCBZHqcvM5KlqCbPbXORs3k/K7+h2fo5B0jAw98Bkfh/9h74HLeYowdKet
	ZefUWRjdDcbLKnYK+gEGBw7FpslMI7oWWBboRs3FHyWDQFAWIesBzSzpfaf7QSgVzqV0nRZMlhv
	8FLjxdE9vCXVLcQ7ME8MQ9xaMcIJpFu0WKG7eNuklBphn2IuWARwgaSJEMN5zFT9BFh6IZgfpsV
	mfatMXK3smy+i+FKgfvggJrsdElwk73aBGIuDO3TxUVblUoJ0ZZz9HbPpAxAFmH+HBAblp/cTAo
	qE3H16RY1YuL16Ye5EzWluRVst+Kynomaxo/luOfSJf/skfZmdzwOY5q9xfLPA==
X-Google-Smtp-Source: AGHT+IHlUGhjqylUe5S18JNbzZrmzumkoAqADG+jDL11BXHVjDo1BIfDikKmJyypp2Go/bi2ccn1zw==
X-Received: by 2002:a17:90b:2dd0:b0:312:db8:dbd1 with SMTP id 98e67ed59e1d1-318c8ff231fmr20332533a91.5.1751339591611;
        Mon, 30 Jun 2025 20:13:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c1502b9bsm10548857a91.42.2025.06.30.20.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:13:09 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3A3BF420A784; Tue, 01 Jul 2025 10:13:02 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 1/5] net: ip-sysctl: Format Private VLAN proxy arp aliases as bullet list
Date: Tue,  1 Jul 2025 10:12:56 +0700
Message-ID: <20250701031300.19088-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701031300.19088-1-bagasdotme@gmail.com>
References: <20250701031300.19088-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=bagasdotme@gmail.com; h=from:subject; bh=Mo3qLJAqGtaw/5KsjboFvgs0yCHJgHSanxBj1p5XsGU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnJ/kcPiMZ865U6c/LI4sL3jtYqn2tnl/7xr6ibUbBUJ qZ9acWLjhIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzk1QGGHwtCniy1Omm23zrM Qzx35rbfiSEswkveWIrK/8n6xszvwfBXULCa78gry8K28265Ggs8lil9mXPy9ve/21JXSy15+r2 NFwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Alias names list for private VLAN proxy arp technology is formatted as
indented paragraph instead. Make it bullet list as it is better fit for
this purpose.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 9af5a8935d575b..a736035216f9b7 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1891,10 +1891,10 @@ proxy_arp_pvlan - BOOLEAN
 
 	This technology is known by different names:
 
-	  In RFC 3069 it is called VLAN Aggregation.
-	  Cisco and Allied Telesyn call it Private VLAN.
-	  Hewlett-Packard call it Source-Port filtering or port-isolation.
-	  Ericsson call it MAC-Forced Forwarding (RFC Draft).
+	- In RFC 3069 it is called VLAN Aggregation.
+	- Cisco and Allied Telesyn call it Private VLAN.
+	- Hewlett-Packard call it Source-Port filtering or port-isolation.
+	- Ericsson call it MAC-Forced Forwarding (RFC Draft).
 
 proxy_delay - INTEGER
 	Delay proxy response.
-- 
An old man doll... just what I always wanted! - Clara


