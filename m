Return-Path: <netdev+bounces-152005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B859F251D
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD57A1648AB
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191AC1B4124;
	Sun, 15 Dec 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KB+/Gwvr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E951922FB;
	Sun, 15 Dec 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734284651; cv=none; b=WvJVUFtXx9Mj+QutsoUa0W5wkNWIwxQeyWKKAscC7UqcATi8RPuSgMjW9B5HCEoU651XuZDcA+BHXrzcaweLipjtEd+DSnGzW8YhC1JBDeqFgJrDhbLRIYvTwKhUeP42l4DN1dfdzv0nO0cw+9vaK4Rmx4ByZX7Y+JW5pEvsr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734284651; c=relaxed/simple;
	bh=m4coHam65CQzfvGK+uXCW8H3x23IFG1j7jYWoe7Nzrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WKmW4lgy+m3+pT0ZOoFdBD0CvNoL96/e7Rr7JJkVOpe5GU0aksYZxVWJTC9K9bGz4fTrsrqJOJbX8eysJrDdmKZZ9bWxfmxA1tNiEGsQNQnf/n/Q4xbYMoskbzv9yh9B13L7+umWeY382TDAeYD1nUQnwlpOtBxRZ7vUEU4Apek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KB+/Gwvr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Sender:Reply-To:Subject:Date:Message-ID:
	To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P+CYKBqglvyd/Mbd1yBF10OWGj9J10FWUydtXlErGv0=; b=KB+/Gwvr94b75nZiqLxOn7dcPs
	2yjvMI+VX2UytsB7G2MEuVQiJsh4i7OQJ3ceZKU7ZugC4Y89zEBcBsTpfr8gVX1N82kYUt2xzvibb
	2ISm/hCm3WucqoCweiR9ZHTvK60FV0eKdceA3sHHIcKzjnaZhjNeFKbNZChumh9KfDmc=;
Received: from [94.14.176.234] (helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tMsey-000WMH-72; Sun, 15 Dec 2024 18:44:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 15 Dec 2024 17:43:55 +0000
Subject: [PATCH net-next] net: dsa: qca8k: Fix inconsistent use of jiffies
 vs milliseconds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-qca8k-jiffies-v1-1-5a4d313c76ea@lunn.ch>
X-B4-Tracking: v=1; b=H4sIAFoVX2cC/x3MQQqAIBBA0avErBtQSciuEi1Cx5oCK40QpLsnL
 f/i/QKJIlOCoSkQ6eHER6gh2wbsOoeFkF1tUEJ1UkmNl537HTf2vjIUknqrndPCGKjmjOQ5/78
 RAt0YKN8wve8HB0ZWlWkAAAA=
X-Change-ID: 20241215-qca8k-jiffies-01e8c5dd5099
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=m4coHam65CQzfvGK+uXCW8H3x23IFG1j7jYWoe7Nzrw=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBnXxVjcEj9ppNgUW1rrj3cSRr15n0rWWOe/uMMa
 kQ46UWwtIKJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZ18VYwAKCRDmvw3LpmlM
 hGHZD/9visKEj8/ePwCp1C3pguAn3WIHAcoUbFxa2jdbYd30XInwvTp5O4maX+8GuNJBuSmSayN
 ofHmPCSbe6aD8PSDxlSa/42d6835ubam2qZIJ2spTzRgn49ElFzxLUL0yGkEy2f+WTSKeaPPLME
 PV7hrjxbG5ovKY4O6X1DoyayG5Qh3DZKIvM3cThZ7M/nmvypaKHq6n7mxgl2mMg1uOcDbGFqbBx
 kQ7JAHOC7xe+vcNl1dWO156FcFfcTmLFgKYdDfFBzgpTY9HlV1xmvoAyxbCmS947gqCPykw1MMF
 COyRFRBNQ3TOJQjow2M/xWOtwsaSc0avr6xJUVBit4NNivgNBt6wMRi9yBsSY0mwJFhO0PaWfRm
 c09r3QvjdXUkG50gycsxPEbD2Rpw/c2fk12wGHlXrXgwneSqa59B8+9jIvUb2csGWZx1X5EDH7B
 XkZeYL8dHcRAfvykm6Q+kCTPHPgfwNSJqwaGR5s5vN0T6wl8bzXRXRPvWuG5y/FjZlljVr5MOd1
 YyS4ngB9VneyS/opPh+R28Lw41IgFsloKblEJ3Cqe0sECB2AQsOxd+VWF726bJmeHbwLYRN6N0q
 hetC3SG6t9U6HudGV5Ir7rJ8HfY7WRy6ZWxgKJ4FjQVUfG3g2xaJMOLsadNY5JzZwpiMDtxb8lr
 /6ja2Q27LdYqquw==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

wait_for_complete_timeout() expects a timeout in jiffies. With the
driver, some call sites converted QCA8K_ETHERNET_TIMEOUT to jiffies,
others did not. Make the code consistent by changes the #define to
include a call to msecs_to_jiffies, and remove all other calls to
msecs_to_jiffies.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 4 ++--
 drivers/net/dsa/qca/qca8k.h      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ec74e3c2b0e9b90b29de4442f056783043fac69f..90e24bc00b99cca1f65ed1df8b06713d7002e029 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -342,7 +342,7 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	dev_queue_xmit(skb);
 
 	ret = wait_for_completion_timeout(&mgmt_eth_data->rw_done,
-					  msecs_to_jiffies(QCA8K_ETHERNET_TIMEOUT));
+					  QCA8K_ETHERNET_TIMEOUT);
 
 	*val = mgmt_eth_data->data[0];
 	if (len > QCA_HDR_MGMT_DATA1_LEN)
@@ -394,7 +394,7 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	dev_queue_xmit(skb);
 
 	ret = wait_for_completion_timeout(&mgmt_eth_data->rw_done,
-					  msecs_to_jiffies(QCA8K_ETHERNET_TIMEOUT));
+					  QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
 
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 3664a2e2f1f641d2d5533b767f709bf34eec3753..24962a395754c1f12de58d11cdc97e5fe5f0d046 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -16,7 +16,7 @@
 
 #define QCA8K_ETHERNET_MDIO_PRIORITY			7
 #define QCA8K_ETHERNET_PHY_PRIORITY			6
-#define QCA8K_ETHERNET_TIMEOUT				5
+#define QCA8K_ETHERNET_TIMEOUT				msecs_to_jiffies(5)
 
 #define QCA8K_NUM_PORTS					7
 #define QCA8K_NUM_CPU_PORTS				2

---
base-commit: 2c2b61d2138f472e50b5531ec0cb4a1485837e21
change-id: 20241215-qca8k-jiffies-01e8c5dd5099

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


