Return-Path: <netdev+bounces-250960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1C8D39D54
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5BB300660F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6E264A97;
	Mon, 19 Jan 2026 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AayLtz1r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396625782D
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 04:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768795498; cv=none; b=dvt0sqFTdYCaNRXB1PVOuR0aSBknnWetwJmbFOVlHc20pHgWU+7oGTKYbdG+YC3afHm5f/ivy/FVMF6NmaUdozjhNG+oIxw3y6fh0w6fjmMusodMlVtl9jMBrRWXoeP+FRifnIZdnsXevlG/a6zBfL/vH9xyy4yKTo6EbuuPX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768795498; c=relaxed/simple;
	bh=e6W/QWKMilaDQrE7rliH6vK8V6KAclqW+44W/IXn6I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jofzo9I2Bti5DBcB6URGEHpWZB3+ZSMjnyf3z/yBKON4hnJUPQcuMIqxwPlOmV9h2yeKrYhnCXYNcsIIcOLHBaa0bxVRdwkCwBsVuY3wlubHYEl3N/WrivDwkHsjDGk9S+9cp1Tbcq/JQc+9zLjzIGxWa2db2SHvK2gKgXuxBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AayLtz1r; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233bc1117fso2446651c88.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 20:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768795497; x=1769400297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4KxwmlBlOeG/SijIjUydp6Wq7QE+G7DwqwSIAw1kKc=;
        b=AayLtz1rlUF8ioLXVDuuo0Ru39novV//ECvi6BIyZOrgLj/8hAO93+GsB3cNdluiFy
         AGBmOO+OB/v6xqq1PVzmS2/JLXklJ/6y+5O6niAsph79JOorO7ME7AAWGTtXkooh4fIR
         TW1qbsEIy4NwIMWRWLQ+9NHsauKVnxztIGCzgewNVhYxZzosLPc0kueOFO+cV7Y2SQJg
         6t1rWSjQIrXGY3UCz1uSdx2PTzt7I6YcGhZ0XDEgqryLZNHdg1x+XM2PC9Lnf9+PYltz
         gWPr+DlWZVA5tOdaLRP42b0DBfzGsQX/voKUy5ZlKL7Y0i5I+L/5a0AQVXVrP0BBs5xq
         YHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768795497; x=1769400297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4KxwmlBlOeG/SijIjUydp6Wq7QE+G7DwqwSIAw1kKc=;
        b=QOdq0m+RE5sM17hPh3q4TrajsoVDplBvnH+sRJkBgvKcKGvdpKdt3PSFCrUzkOt3SG
         WIviPHTLPh9bjzamp5mYW+wqPRIjvkjv1quRjAiQ0XMGy2JN9OaVPp/Sq1fMZJ6tigGb
         coH3OwZzt1BmRyMU6AtJoabQBb6WyggkqIEGKWG6VClZfCMaRx5Iov/9fJBbCm+Q8mKd
         Yw9wXD1IoRcwUn+LXoUhOJa6LAQVJCPvmVfa7uLOm1vJ9UYddZjWYMQ0fGfxxoYBm2UZ
         RFo9DaSXc2DrT2GPUUSAtwKYZA+2/+rmSUtIYzqU8f1QNc7Oag7VgmS3+NxkW4zS03OL
         00jg==
X-Forwarded-Encrypted: i=1; AJvYcCXOfifh/QrX+ryfhnghclqdqqV6JVwCSH/8+JBLYrrV59y0/sSxCkwnM3SFfkaqf5rxbXBONZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMv8HEjKh/k13n3QEGPuo9oOSEMHXhdiP5fb9BnDIgqkApqaKu
	S5RkPWDAWQ6KLIlw7WYXAtA3gbW8/K7UmTPl8CZFnstG6Fyfu9qVA+m3
X-Gm-Gg: AY/fxX5pRcGizgwxcQeqY+OOIeuKsJNvrs/aG/QAU1oPapPTO4rHo7H2gFp4iAo95ve
	XpZUB7OxI+IfLuGhJ3B0I2tvGVoz/zC/HV8BRkdtF5wcOHmp+XTItvbgpMXWk/1kXuU/f7agStr
	aRkpWmQvFf50F7DEzvFIzEMySkTzh/9AjpG+DnQB9R0Rf3M51aFw3DPdVhVWxL/m29AnsGjYM67
	hpur9k/1/n537u7aXh351TErWMpAtGQ3J5xPn9MrNHO7hGf+HpszLChI2CVXvBTH23PHeoP1+eh
	7iZwSj/FKaAyloakz0/jj5Bkk3xmZYH/7CaldMaNucm1mQW63PdPxlmkqSIn5zfho0FIensYyLW
	/wbDhgwRkCYBmPBvEvFxdr99cSqxRwY/zL/IXRRQDoKJQQNPayvieEQ/rzdjGFlayyDG/4WEL6+
	aSws/qAtFk/A==
X-Received: by 2002:a05:7301:9c92:b0:2b6:e793:caf7 with SMTP id 5a478bee46e88-2b6e793cc47mr871823eec.18.1768795496562;
        Sun, 18 Jan 2026 20:04:56 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3503a30sm12828922eec.13.2026.01.18.20.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 20:04:56 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v2 0/2] net: ethernet: litex: minor improvment for the codebase
Date: Mon, 19 Jan 2026 12:04:43 +0800
Message-ID: <20260119040446.741970-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the litex code for using the device managed function to register
netdev and replace all the "pdev->dev" with dev pointer instead.

Change from v1:
- https://lore.kernel.org/netdev/20260116003150.183070-1-inochiama@gmail.com/
1. separate the original patch into two patches.

Inochi Amaoto (2):
  net: ethernet: litex: use devm_register_netdev() to register netdev
  net: ethernet: litex: use device pointer to simplify code.

 drivers/net/ethernet/litex/litex_liteeth.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

--
2.52.0


