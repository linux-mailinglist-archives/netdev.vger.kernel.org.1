Return-Path: <netdev+bounces-237047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321F4C43C88
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 12:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4D93A9F7C
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 11:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6A2E091D;
	Sun,  9 Nov 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agqh7DzN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBE2DECAA
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686385; cv=none; b=h15PbvNdi4xa/ROqaFEc3zTqq1w20genj0bNV0FSwRbBpQCOYjLM4UsUlr37LlePXvgo8Qq+tJx6VPLYl0TPt9avM0TAaStozNc4z8hv2+NqPoba6U+YmTI/fRNwYc1caI7wE8IjvyIEfg2Y1i/+1Sa6J5E/wq9xNkmqrJQrc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686385; c=relaxed/simple;
	bh=9cnt0djUO8JMRLcFmi+xdYZfECvsjjDzxRKEBkD5M50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sK80EUf8u5ai49qVuXONggfl95VnRiOSMGJuVonRjc+Ryhb1jYFZQeeWDOgDein1reL46qXE5c45LdtDK10oFlAnppdeBFdaWwQ0Ex62z2RSXt0oEWj7DVmHR1wLA2C0pJFzikLlzChqqM2g7mg1cTDTYdFgoYlyx9Z1fsHdP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agqh7DzN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c19b5de4so1533464f8f.3
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 03:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686382; x=1763291182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2+JaghnusHQ5195f+mHqwHveTs9ZCK/yCVn0nawZBU=;
        b=agqh7DzNf9srld/vkBJxJL/rX1frVCUFny7EE6Uub1ugHqQL6jJWTiFXOg1b4Wo1cf
         uGoapt2PwntWpJDPiqwk9wfhsgqwgldfgO8IQlbp7LvrH20WewYMohw/t0ogASxtRKn2
         pId8yunyhXUoKAmQj6SIALsPaOLpgzRka57UwjNsCjOUdBHxcihPnb1k/YOX6cr7TZYb
         aYajHIQIX6Vk4klFGfz0WSDRyPaDDBpubGmSNy4c0AO4qnreVWrZqbMotU5ir2QdZf8H
         S0P/+Pkm4v9CSZr2ybe2OTGU7utK/4UGkW/CX1/7qKXBF2aBld9Xz93ykL3ihJ7rI4qY
         FjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686382; x=1763291182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X2+JaghnusHQ5195f+mHqwHveTs9ZCK/yCVn0nawZBU=;
        b=rbcJekjH9rMCspK8aQw/qYr40hTIqIF/nR5wK74NF3oS90ui8aMlb3I99oIkVsdXja
         nptBjC38TgWJL3XrhqNYgJqs6McGA3IiX6E04Lvuu+iGJXp20bWEP4hNKu1YLFBpW8A4
         FwFR6Ql/onGTxkgXzTjL+Bt4KJ7EjxMUEZ/Mhk0UCpPDGOBIp3jxRFXeDXDclPwgTCR0
         387CKy8mAK61sdpKRkF7C/LwnYEMVuUcUF2KyqOpjeWcm6QWWUxaleV/K0DSBkZ4R6KK
         1OuQ8HuR+dAsxC5tsPD9wTus2dxEDz7nduutQLuZKjSwYpW8baHMdDZbRSq7JrKClZ0O
         J3FA==
X-Gm-Message-State: AOJu0YwVfR1xekYQVl45Y8fnfEp79G154MAtBvpwVL4388wJFUp7viW/
	pRkp/sVyFQ2xGgRkDD03JK0yOYnu0y+aV9qTVZc4/xKi1hnTOmu6uRd0
X-Gm-Gg: ASbGncvpGr4Avms+0IEU7hwQiHdPlO2kY1mBl6I1usUz9baUJ099HQWpHUqkRs05RXf
	pM1R8HnVmm34f0/rLYy0jorFzIcvzC0bBXUEurjuKQ/OwiR7fgi5V9uwn67Hm3vuIMBPUBoQOLa
	omGLfsiJdoyoilbNtLY9UlX+axlMhobpc3SNMfZlCp2IOCJd84VsrJDUMS9hf7/9IRUQ5vQLrgl
	jHRSOd1yYPMMjvpW2KNOXO9nvhkqAKjQtMY5mVWy6EIqqbwLF5oAoY6ICb4n8gN78L6bSSAU7Xs
	XNnJNwN482PWRKRvqHdPeDeDwqWmT2XmRHBbSjHeGw7zslKBnuX+AzQ6YCqo3eFoL6/1WLFCanB
	CxHy8Om0sU13WMYCn5vKQ5TBsm/e9l3DvBhzUPcZ4wWWvMqpRtRiWAWyxGUDGsp3ZQp3exQHN4f
	TcQVPZ
X-Google-Smtp-Source: AGHT+IE2l9dVnKOvGwUJcC3n+1EPzSK1kOENPu25VX1LP3N9NDrShgiRVJ9RZrWo8xw0UIcSYg6kCg==
X-Received: by 2002:a05:6000:1acb:b0:42b:32a0:3484 with SMTP id ffacd0b85a97d-42b32a03626mr2142456f8f.45.1762686381898;
        Sun, 09 Nov 2025 03:06:21 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:21 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 09 Nov 2025 11:05:55 +0000
Subject: [PATCH net-next v3 5/6] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-netcons-retrigger-v3-5-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=4767;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=9cnt0djUO8JMRLcFmi+xdYZfECvsjjDzxRKEBkD5M50=;
 b=pNaI95w3bEi2PMT/QZLOFwdJ/5DWGD1iyWEpW6PUTOqocGVcermhyxdP5+sJcEKUBs7sJz9e4
 SkbLdo7vxV0DLmYfGx+Nw/jCJDVilkf+tk9EAgMFTB8eY0EsnMiSSpr
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Attempt to resume a previously deactivated target when the associated
interface comes back (NETDEV_UP event is received) by calling
__netpoll_setup_hold on the device.

Depending on how the target was setup (by mac or interface name), the
corresponding field is compared with the device being brought up.

Targets that are candidates for resuming are removed from the target list
and added to a temporarily list, as __netpoll_setup_hold might allocate.
__netpoll_setup_hold assumes RTNL is held (which is guaranteed to be the
case when handling the event) and holds a reference to the device in case
of success. This reference will be removed upon target (or netconsole)
removal by netpoll_cleanup.

Target transitions to STATE_DISABLED in case of failures resuming it to
avoid retrying the same target indefinitely.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 62 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5a374e6d178d..50d6df101c20 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -135,10 +135,12 @@ enum target_state {
  * @stats:	Packet send stats for the target. Used for debugging.
  * @state:	State of the target.
  *		Visible from userspace (read-write).
- *		We maintain a strict 1:1 correspondence between this and
- *		whether the corresponding netpoll is active or inactive.
+ *		From a userspace perspective, the target is either enabled or
+ *		disabled. Internally, although both STATE_DISABLED and
+ *		STATE_DEACTIVATED correspond to inactive netpoll the latter is
+ *		due to interface state changes and may recover automatically.
  *		Also, other parameters of a target may be modified at
- *		runtime only when it is disabled (state == STATE_DISABLED).
+ *		runtime only when it is disabled (state != STATE_ENABLED).
  * @extended:	Denotes whether console is extended or not.
  * @release:	Denotes whether kernel release version should be prepended
  *		to the message. Depends on extended console.
@@ -1445,17 +1447,50 @@ static int prepare_extradata(struct netconsole_target *nt)
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Attempts to resume logging to a deactivated target. */
+static void maybe_resume_target(struct netconsole_target *nt,
+				struct net_device *ndev)
+{
+	int ret;
+
+	ret = __netpoll_setup_hold(&nt->np, ndev);
+	if (ret) {
+		/* netpoll fails setup once, do not try again. */
+		nt->state = STATE_DISABLED;
+	} else {
+		nt->state = STATE_ENABLED;
+		pr_info("network logging resumed on interface %s\n",
+			nt->np.dev_name);
+	}
+}
+
+/* Check if the target was bound by mac address. */
+static bool bound_by_mac(struct netconsole_target *nt)
+{
+	return is_valid_ether_addr(nt->np.dev_mac);
+}
+
+/* Checks if a target matches a device. */
+static bool target_match(struct netconsole_target *nt, struct net_device *ndev)
+{
+	if (bound_by_mac(nt))
+		return !memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN);
+	return !strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ);
+}
+
 /* Handle network interface device notifications */
 static int netconsole_netdev_event(struct notifier_block *this,
 				   unsigned long event, void *ptr)
 {
-	unsigned long flags;
-	struct netconsole_target *nt, *tmp;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netconsole_target *nt, *tmp;
+	LIST_HEAD(resume_list);
 	bool stopped = false;
+	unsigned long flags;
 
 	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
-	      event == NETDEV_RELEASE || event == NETDEV_JOIN))
+	      event == NETDEV_RELEASE || event == NETDEV_JOIN ||
+	      event == NETDEV_UP))
 		goto done;
 
 	mutex_lock(&target_cleanup_list_lock);
@@ -1475,11 +1510,26 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				stopped = true;
 			}
 		}
+		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP &&
+		    target_match(nt, dev))
+			list_move(&nt->list, &resume_list);
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
 	mutex_unlock(&target_cleanup_list_lock);
 
+	list_for_each_entry_safe(nt, tmp, &resume_list, list) {
+		maybe_resume_target(nt, dev);
+
+		/* At this point the target is either enabled or disabled and
+		 * was cleaned up before getting deactivated. Either way, add it
+		 * back to target list.
+		 */
+		spin_lock_irqsave(&target_list_lock, flags);
+		list_move(&nt->list, &target_list);
+		spin_unlock_irqrestore(&target_list_lock, flags);
+	}
+
 	if (stopped) {
 		const char *msg = "had an event";
 

-- 
2.51.2


