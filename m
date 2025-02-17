Return-Path: <netdev+bounces-166894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C70A37CBF
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0971707A3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC4C1A23AC;
	Mon, 17 Feb 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRjwPcS9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995051A0BF3;
	Mon, 17 Feb 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779534; cv=none; b=dBgXrfYp9jA1iA16lUYn1RwmNnKcQobxDwoYXniOsOWfXEJDYMXGAWcPyx0R5NcWZFrfV9Q4I/STJmj7aC/WpSonqRqpA4b++i3ZxVnuUwcfMgHgJeHJURKuAAX4NW1lDOs1ZflOc8jNK1aKBUJoduo0EvBk00t5OcexqMnXiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779534; c=relaxed/simple;
	bh=dDkeJ7GH7avcKXBfyV1k8BkyzXTe+QGQ53jKuGm0Crc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf/B7+yZ0DpK82Eg7mUGSMLEe7cKvE4gfE27oiek2/2/n0wjqv376Nxl/ZCbzWeBt45VpkayeT6elHZcolFehfQtRPMzFhoIOyi+5HDMH7Z/03/G/Yw2YHPGIf1H5y3Hs4nJpqx/+sW4I4jzWelWRSRP0jU+3tClpn8aPM5glnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRjwPcS9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so2389431e87.0;
        Mon, 17 Feb 2025 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739779531; x=1740384331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzEsmazWfkKI94Mb3+KwyFEdwSSXdViX2jkMcHce6as=;
        b=FRjwPcS9Q3ZOCltQ4ZmPHb0pMw6XVzdyxznNe0x7Y0SRpG9iA9MdHxGvGaDZl/0PhD
         RG2YuZEY0GpvMQoKiBTa8C3MpwDrNLCl5o6iCj/67jpxoSVhIuAS5xNsKcA1vxT6lfgH
         +dAZc0WKUoMDUptO8MYGyHXIjAAxLqVrgU3YzbznpFf60ti+gbGoNNFFqqYeQ4igIsrl
         TbD+OionSLXwh6rq+UdrzhlwWhG7hw6dGQP5gMKNhbrwFh5YRvz8hpu/hW9Z2qKVvRnf
         PH/WUfDsWDOfijwFfKVrBZtReRSGqucBL8iR0n8hXnZs7zkPXaElN6YiceLrFYj0+TYT
         zn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779531; x=1740384331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzEsmazWfkKI94Mb3+KwyFEdwSSXdViX2jkMcHce6as=;
        b=IjawxwICZtcrR+YCnz1MBme/JpSCh36RYp1jSYURVXtGTH7J4U+rR14NybOIoMjyXu
         F7uI46ZpHxzU+b9tGNa4u0tJkOr/JcCYRpzYd0s1726yNxq6a7O60NDCvAck8JCeKYeb
         v6LSvyzvkF8EGaDaPJUbS4KX655oXVDLO7S2dZz4n6xL+AmsdCmkCHe8AnVx2a2+EQA5
         J2jXhtibz4AsV3mV6EuqvIanBEFzkYiDHe0RxnjcYMOXdoekBwK4xtQtQpfRj7yy5Qyj
         ffQbHepcwo7bZ3zYL8ILawYdnrGZa7qatgHfmqB7kRE/sFIE+zeyEwG8hi33LetAxXp1
         2hCg==
X-Forwarded-Encrypted: i=1; AJvYcCXVf2LW0ttyc7ztoY6I9oAkHRa++xn8VaQCh7V+kZJdHBMQCs+mt0E4z2YN3vtA/nb4Q3ecd/NW@vger.kernel.org, AJvYcCXtSIGmvBg0yfIsVLFPGRladeZm/tzhjNX7uyx8QsGU1v58DUrmauLVuXhZsdwKCsFRnSmSUb042xtM@vger.kernel.org, AJvYcCXwn8LassWcVZusr9dIQo05nFMiWaSvb6Cfi9VLQY+Jjao9tfhkpBVK1FoZ9vJEtpkKcO4swicDEFQCQdCQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3MJMzCBS41ozmhutXwgGZmZ2/5SaxOXno46G4NWBtSmO1ZrL
	gfTzWuZXBLRCDNm81z8PCbrgweGZU9GeVa0zHo23D6wBNbL2KVXmEdEGO2lnTQc=
X-Gm-Gg: ASbGncv2ofI+uO5QQe0Fk1B0ocAkzcP8OAqbhH8V2a7JH/ehdosOihv2liATfGvHbCp
	VCjpBnoUA9Q6WEBcQuzHeALnOZhkDDajNdSvPoGsbf1w/z6JvDRkVk04FFlWmx7K14oeiqzxIna
	yxFctY3ipKfuaH9v3rMzhUo49VRWEpOoRJ3mXgvTdacGo2ZfHtOVDIUe6qTHRtAXdabUBU/EriT
	PZVgtB64dhhn7W+rh+utg985TdphBMxiOAdCfRaO6MOkN9Av+7PmytqZjHrQJH5kNPKAkmbosbV
	BtGvOC/JP54lVnvF5vHR3PbO568FZ62G
X-Google-Smtp-Source: AGHT+IH0gQt6LbSVzt7ANJ79QPtBjmUGIh3dOqM8t0B1cAgFQOMYUuVEsqc+9rOEGXqZm90qlOS2kw==
X-Received: by 2002:a05:6512:a91:b0:544:12b8:d9bc with SMTP id 2adb3069b0e04-5452fe264f6mr2464728e87.8.1739779530326;
        Mon, 17 Feb 2025 00:05:30 -0800 (PST)
Received: from clast-p14s.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452848ed13sm1173028e87.255.2025.02.17.00.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:05:29 -0800 (PST)
From: Claus Stovgaard <claus.stovgaard@gmail.com>
To: claus.stovgaard@prevas.dk
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: net: dsa: b53: add BCM53101 support
Date: Mon, 17 Feb 2025 09:05:02 +0100
Message-ID: <20250217080503.1390282-2-claus.stovgaard@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250217080503.1390282-1-claus.stovgaard@gmail.com>
References: <20250217080503.1390282-1-claus.stovgaard@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claus Stovgaard <claus.stovgaard@prevas.dk>

BCM53101 is a ethernet switch, very similar to the BCM53115.

Signed-off-by: Claus Stovgaard <claus.stovgaard@prevas.dk>
---
 Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
index 4c78c546343f..d6c957a33b48 100644
--- a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     oneOf:
       - const: brcm,bcm5325
+      - const: brcm,bcm53101
       - const: brcm,bcm53115
       - const: brcm,bcm53125
       - const: brcm,bcm53128
@@ -77,6 +78,7 @@ allOf:
           contains:
             enum:
               - brcm,bcm5325
+              - brcm,bcm53101
               - brcm,bcm53115
               - brcm,bcm53125
               - brcm,bcm53128
-- 
2.45.3


