Return-Path: <netdev+bounces-69627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C084BE49
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 20:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B0F1C20319
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266A17579;
	Tue,  6 Feb 2024 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1cJ0JrH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F617730;
	Tue,  6 Feb 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707248883; cv=none; b=jdoyyWsbiG925wABolGb6ZZSpw5jbyt8JkiFWUJwyeR+ySBluEkiqmFMklvznR4xSS6yIXniwMys7UIJRNJzIHdwvQCrGtQQ2qlbEs0njiRbDvX50eDKtZUzhQkdsaYQmAE74uOVcYjo9Lr6Qda6+wubBuN7J+VXtzdOwglMBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707248883; c=relaxed/simple;
	bh=f8momyWthQvHXshHKFaZKW4+PsSEkHD5atm8D7vlgiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDHPezhwPrOPYSEmcD7g1S5DevEBbt/9rhPcpATVImkX1ITU7ivZh8reIK5SedgiYA6qxArSNKOU2YFrTw1iX5ZfNPz2bYgt4HPphzAmoIl2u33Q7KxysdtEG4QdLH6iTkslm/U9hdH5aiCCkGW1/pa3jGm9ZmMzj/Zh4n8UFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1cJ0JrH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a38271c0bd5so133190966b.0;
        Tue, 06 Feb 2024 11:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707248880; x=1707853680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1inhWZLgkqsIZoNuob5TJaNdpYv+jmAPLQY9dtW8I+4=;
        b=F1cJ0JrHmWQxgSi7sGEMY/rSFw9grlM9PDIkU+Z6iZMwZhNEb2KCqQkEDa3f2aqD5q
         XD+9mhntouu8ZcUBToOd6k6xJzfartCPAvtdzumIINR7V221+QGQTpUgVz3Ah7bFAqyn
         FH3P4ZjTSXfn+chga+vvAeV8WeBoEiKe4vWJm/S9/KIHOuLhY1wZY168MMLDGTLXyNTD
         bQjxZJuW1JmBbSYpKmUkFjFiRXf4Ta7ix65Je06ac7lcjoNDBlHlyTWKLpODMKhm1fc3
         PN1KiEqIUcTeFD1P4X1J8wpUrtbUoVwGRlk4Bx/Is3kq9SokDFN2TWLMCMmZgLdcHcjr
         8h7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707248880; x=1707853680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1inhWZLgkqsIZoNuob5TJaNdpYv+jmAPLQY9dtW8I+4=;
        b=WOTeAwK7WKAqDuc8L7Q+SXQjO6kIeSud09LXik9e11dKvF+fwY55O4XU24kodxqStC
         Fe8FZsWOfsnMXTKloGGvWc7g5JDIbYHHWSDGJSRReamJK1eegcmU+/kxO8gZXFCci4G9
         Yj5sy/+ukJ2al/RG5c7Gmh4BMfrWu2oWm0TB/sKktbe1+fsIiQPGi60EgYfnKfeXzaMZ
         MrVno+yO2kI6vdakUvbnNuVsyWDaTspiKa96LDEHt70y2IvnUcrbsXEO+ZzRAITFv8i/
         2tJkQGqzw1YUZg50frWSs6BWvubDC8mM7GtJmjseGx7WzirkfOs/cqZHtSgXMZUVuVq2
         YASw==
X-Gm-Message-State: AOJu0Yx2ISPV+l6hIggjREWdJoQTOVnxHNcBtzqoXYx/pMlk5XdY19rC
	5CQteW8RJl6wYsdBGaR5AAYFoZ1iyylrgFZqQb5gYhQlAONI6ZMy
X-Google-Smtp-Source: AGHT+IEJecEmIFbXNvKyaNthn4NmtrIZF6dG87jffosPBfxOiObTqJmO8nUyoxn2j7A2p3NYhqJQqg==
X-Received: by 2002:a17:907:7711:b0:a38:259c:1335 with SMTP id kw17-20020a170907771100b00a38259c1335mr1787968ejc.44.1707248879789;
        Tue, 06 Feb 2024 11:47:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWs/eCwG/eDszW1BhqsR3kKejgUHwF6IjMLRdu6nSVd0+TKoNkLZsrEGrdus3W1fk2PIclI3RkUJNb4JAALOiPFWw8UwJWtSjv6f5OjXI61tBvUSpHBaYUgjvop8JERQ2AsXNgHF4M0kPaNt1wH6zq+CrIwyMp7nFXxw8rvYV6xRsOE9itQIfgr/syU0MHmb8+fNH1JmD7XawlaCwob7EzEcOYQ+I4CKO/mwYcQVpeL0tLvdYcDiNnkCkx1PB7cezbfiFBi4c/4qVu5ScSLjELiTUV4jFEJGD5h6Gs6OmoxXI2JuSbkAFr8hC4tj6SKk0pG934s5PftTRGNVraBqaZyi0HVcE3KeskADZdDPt7xbGqb2RDFqko8x9Nm9bSz6fefRMVz3gtQc0rh07cL6MKOdspRSyjSu+OEU/RHOKIiR3qC02IRjoWImgjSAV32VMrlaLNJGfMzLwQZARt9zFWOflX0UVgKtQhjUUuIL/tCbFQnIFl0Dr9M/tKDhn4vEZAtGy9LI1kW2UaD/yrnNa6tZI0Na7OiMVJJKBsIysK9LXveRNzfS2Hpdaktl0xf/rkDrUV8x9gfSqKelmYdDHMvOypi
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a379be71a84sm1476767ejb.219.2024.02.06.11.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 11:47:59 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng  <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH net-next 0/2] Add en8811h phy driver and devicetree binding doc
Date: Tue,  6 Feb 2024 20:47:49 +0100
Message-ID: <20240206194751.1901802-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Airoha EN8811H 2.5 Gigabit PHY.

The phy supports 100/1000/2500 Mbps with auto negotiation only.

The driver uses two firmware files, for which updated versions are added to
linux-firmware already.

This patch series adds the driver and the devicetree binding documentation.

Eric Woudstra (2):
  dt-bindings: net: airoha,en8811h: Add en8811h serdes polarity
  net: phy: air_en8811h: Add the Airoha EN8811H PHY driver

 .../bindings/net/airoha,en8811h.yaml          |   44 +
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_en8811h.c                 | 1006 +++++++++++++++++
 4 files changed, 1056 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml
 create mode 100644 drivers/net/phy/air_en8811h.c

-- 
2.42.1


