Return-Path: <netdev+bounces-153350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CDC9F7B69
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08231890F14
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E59225797;
	Thu, 19 Dec 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="SLBZ2Ayg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062C227585
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611505; cv=none; b=cQWJ1p/M17ziGAsPyovExunaKPY0okjK0ab7ruSDFDkFQgz0DsUXT6LeHG6IGqorWOyLVkkjLPJ8J6irITyJg//ktbI7ON2RH3IiBfVGMLqJbQVXo+TKekG/DeQ4EDSiWRzLPYaV46ETbQQVMGKr0g9HFw9ikFGRnVbgEA7sTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611505; c=relaxed/simple;
	bh=CbzA0ebUpgodKBCOzJODVN++NbuW1U0YDdgtoYEfYpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCspui6jEuS1poYLfr8Xx/G5U5Dx1QaIHAnrTTY3JFCYrbY/ibsoo4+ZkuesF6Cd1C5EnOzu/O3XvNNFjDkNnm755SLtfztPGqcrBS/OyRCa9iv8DHGpdF0SsJwkyAkz0q/TejKmQYQ7sY8alWXGjMbvZ4AJ3lrXaHZz5BIjX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=SLBZ2Ayg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e399e3310so737209e87.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 04:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1734611501; x=1735216301; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MVYDwDZ41knrDBuiD+vu8AjdcCDrx177r0ASKL3mDEQ=;
        b=SLBZ2AygluqdZNDpjjvwZHJcI33gLOM+VIxu3m0NqwFiNlKSlsIfKME24GBljkAjPa
         b8AiWjeY3l1Cs91zPb+HRVESHWXVq33A2jSSQctzC2hbNCtGy25NgKZ4gUtaQUYtQsWp
         z1ujxKPaxTukHuj+WWb/WM6cfLpaqokA+CCN43n6wJR3zlki7/Y8VzBVv6krSOGCQLkD
         IuIfXiR7crUOnDUPxdIQLW95d3R/Is3IzONoOvcCqxCPzJimuLfDfqpbgbB94eXiQXS9
         piXgy8NlLpEYQQAg4bct2D1CQvOV62Qzn6SBIUlAYILKfRjl+UY0l7i3Qbyf3DNzqOaX
         nS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611501; x=1735216301;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVYDwDZ41knrDBuiD+vu8AjdcCDrx177r0ASKL3mDEQ=;
        b=Qyg8tNeVuvWYWqcbfX3BX0hKi+1GqwRQUqdGphZQAxrFtv0iBqUMOj9bV0ahjMa/8B
         A8i3mUY0ng1EzS1P073Qggc/7MiMa5kKWq4WWwaRK2tD488bdOZoYPFpha8G0r1FFjtj
         21Egh6BEl8LvNZHJRmKgRxv58Jy19YFv1KQsB4Hg5QooxB+Ta9UXqAN3J4lsIF/GQODi
         2X5RYyyKISirQsBla9r8n8C0tEajFsAE6AYEF15KuiZoX2q82XGgF5eK3c9Zd81nPX0I
         gx4bxfkjUFs3NKrMgTqn9Z65j01+wn3hUkGFH+fO3TasU0B/wDo+yrxrgUt/wCoWMDaT
         BeXA==
X-Forwarded-Encrypted: i=1; AJvYcCU0IFY+3hNMEzTcnfTso7TY+3hkecALeF4Za97qSCWvPynTz+s5YkpfBgvivOxBZ9vVE/OauNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBw7vW80FSHpkHFwo/qwtQXDpmwnwig9fZH0vpVL7jWjvSj2rn
	i5xQRqCAKQfbyARVcnitYEC4D3tPBNyONwhDtWjC+9WWwowcCb1+Vz86PU0ckKw=
X-Gm-Gg: ASbGncunNBZjA43CD8Vo0CjgoUUYUdgQ21be+EbzEZa9gXKSDQWIc0SlsFcYIXW/NOj
	FBfP/WbQAMEVh7b6YUPwIthW3aFVUHdpR2QzsObvVCTtdkklnT8Xvz8mR6oSO4jySxQqNw3Ajd8
	/wPDY8GyVzqVS4Pu4Mi9QPOnztgEe+EBD0fZZx/18F2MuHG1xILtK81x9u5ZVMZ0g6XOgiHmrZW
	k8gMzToqH6XF2I9TU6dPkgpR5OuTygNkTEYoypXqTXT12kSaxy/on9T1PkG49rwLIY/iUlImPil
	VJdQHOI/wompJ9Alr6gnuHZs
X-Google-Smtp-Source: AGHT+IEkfcxejU283LMvHEVPQU6FEW7iLvaVaJsci4NVYYNhJicTs5e6hc3knIRCuy1qStPve37jwg==
X-Received: by 2002:a05:6512:ea3:b0:541:1c49:270 with SMTP id 2adb3069b0e04-541ed907322mr2219218e87.49.1734611501101;
        Thu, 19 Dec 2024 04:31:41 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223b28722sm145975e87.243.2024.12.19.04.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 04:31:39 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz,
	pabeni@redhat.com
Subject: [PATCH v2 net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy to user ports on 6393X
Date: Thu, 19 Dec 2024 13:30:43 +0100
Message-ID: <20241219123106.730032-5-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219123106.730032-1-tobias@waldekranz.com>
References: <20241219123106.730032-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

For packets with a DA in the IEEE reserved L2 group range, originating
from a CPU, forward it as normal, rather than classifying it as
management.

Example use-case:

     bridge (group_fwd_mask 0x4000)
     / |  \
 swp1 swp2 tap0
   \   /
(mv88e6xxx)

We've created a bridge with a non-zero group_fwd_mask (allowing LLDP
in this example) containing a set of ports managed by mv88e6xxx and
some foreign interface (e.g. an L2 VPN tunnel).

Since an LLDP packet coming in to the bridge from the other side of
tap0 is eligable for tx forward offloading, a FORWARD frame destined
for swp1 and swp2 would be send to the conduit interface.

Before this change, due to rsvd2cpu being enabled on the CPU port, the
switch would try to trap it back to the CPU. Given that the CPU is
trusted, instead assume that it indeed meant for the packet to be
forwarded like any other.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/port.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 56ed2f57fef8..bf6d558c112c 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1416,6 +1416,23 @@ static int mv88e6393x_port_policy_write_all(struct mv88e6xxx_chip *chip,
 	return 0;
 }
 
+static int mv88e6393x_port_policy_write_user(struct mv88e6xxx_chip *chip,
+					     u16 pointer, u8 data)
+{
+	int err, port;
+
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		err = mv88e6393x_port_policy_write(chip, port, pointer, data);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 int mv88e6393x_set_egress_port(struct mv88e6xxx_chip *chip,
 			       enum mv88e6xxx_egress_direction direction,
 			       int port)
@@ -1457,26 +1474,28 @@ int mv88e6393x_port_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip)
 	int err;
 
 	/* Consider the frames with reserved multicast destination
-	 * addresses matching 01:80:c2:00:00:00 and
-	 * 01:80:c2:00:00:02 as MGMT.
+	 * addresses matching 01:80:c2:00:00:00 and 01:80:c2:00:00:02
+	 * as MGMT when received on user ports. Forward as normal on
+	 * CPU/DSA ports, to support bridges with non-zero
+	 * group_fwd_masks.
 	 */
 	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000000XLO;
-	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
+	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
 	if (err)
 		return err;
 
 	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000000XHI;
-	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
+	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
 	if (err)
 		return err;
 
 	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000002XLO;
-	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
+	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
 	if (err)
 		return err;
 
 	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000002XHI;
-	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
+	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
 	if (err)
 		return err;
 
-- 
2.43.0


