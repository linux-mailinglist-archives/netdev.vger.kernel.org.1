Return-Path: <netdev+bounces-245736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9FCD66E2
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 15:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD69306758A
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3FF307AD5;
	Mon, 22 Dec 2025 14:52:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB72877D8
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415154; cv=none; b=vEifswOpX47WlKg6eoJ1ogzvWmSzBi50o8bnhhE3VM36Lv8+pXi/F8o9mPfMwyGkpSPbPDKyhy6PhpeYD/3/8kbt/IZFa9EzSRD9WV8f9SOCHA5L3Rze6p2D8rF1cOJ2ku2NYobrRT04Ci9AnENx9/XJOryWb+0OfR6parLbKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415154; c=relaxed/simple;
	bh=LPqPvdo4ubuN2gY32YVboTIPFg+DFP6SqSHcJnYrbP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5i3uGNicKpJagGPOKuLFP+IbVv+QgGuNxpaMrHxDPi8hqMhTWGd279Y1l9pc4Pb8mAMH/1FDMsNvsOYTPzCKmwS46ljNHpSvNQPD+YWAtpjJhZzbBzEsiVDTjk/I0WteN3sHSxBaEMzYgGb3Vw7qI0PoyL1ckX5/zxFu9JA2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c52fa75cd3so4085755a34.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 06:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766415149; x=1767019949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=139yU9Ss5ceAD3zqfAdSIlfmM0ryxaF7PuGn9Gft+UU=;
        b=BDduBqMwJBrj8zSaecQEujB8fXN8vKYwMe8sceD9JxZfuWoTVJxFF8te5PJsOSTt6A
         2/4Wvl0olNoPo2gyfWZ8UXAdu/zKfbrxc2ANFlxcwmP+5xKpaNWPKzOxtK6hL9pmQPa+
         87RIIQGCCuAEvNiaDdg5J3FIck2rbRkNDqlZ5IVfPZ4emDz0YMbUePhdmouKPLD/RrOY
         ugZW4tGofdU0H+QTUjYpPxVmmrnlO521uzs4D4oExuV2sEHcSBOUUZ2MrWDKWsKBn3zC
         FoqiG4qcLvSLu8VVr1dXtVckZfL+QpTvhfDzaYXmZLhdtD+T+AtHtRKIP2eriAiO6wm0
         b68w==
X-Gm-Message-State: AOJu0YycgtVHyeyllcSnqhFV8tsJW+t0SGDutZi8WHhFoFj7tieAGGjX
	wglllnIr7nBKqbh6UAH67PkiM8NmawyS8CaT3axqjGharJqxkv/HekTh
X-Gm-Gg: AY/fxX7NpUACqcai+Uqb1VddOUzsbBn1+vJ89CqwUc6nvDXg8fJyKuqZi2/ueyCHERK
	jHtQ8f6aUWix7exXz5afFcghhO37PLWTXf4ETMVdFQVfH4u4YFta5h9hc0uh/Q3f8RIhkg/eVG5
	i2f+SBvNOM8PsbtTu3c4H+b+GY6vE6aIXJpC7UtIuSbLYNOTHZg9RgoLdaAnh7MhIHGFd4BYIb3
	HmddBMAQHF3oWvqX/Qw2rYC0VCKowQTAUvKL+ZhS3/i2089rFYGc6GWho6MKczZQ4uCcUiiD2bm
	tRvbcyywnD20s5e6eYpFcA/QjsS/CPnApoEVFpxFU/LOvH5yhzjgSmPO7mPQv4z+8z01/pq37Dv
	qJhL41DRMr1UC0FUxoSYgSN4Oli39NeaS+Lb05NOjW7xklIruHeEs5RbNREcTvAySLz7J2VeqN2
	V4EUI5zYKEHyn0
X-Google-Smtp-Source: AGHT+IH3tbsSEr0/AQiwbNCVHlP6Q8UAIjhGE3igU6X5ropEQgFQ+7kR6t9vgznTOWu1CvaR1o2FyQ==
X-Received: by 2002:a05:6830:828d:b0:7cb:1411:b5d8 with SMTP id 46e09a7af769-7cc66a130b0mr5704525a34.28.1766415149281;
        Mon, 22 Dec 2025 06:52:29 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667f958asm7368336a34.27.2025.12.22.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 06:52:28 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 22 Dec 2025 06:52:11 -0800
Subject: [PATCH net-next 2/2] netconsole: convert to NBCON console
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-nbcon-v1-2-65b43c098708@debian.org>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
In-Reply-To: <20251222-nbcon-v1-0-65b43c098708@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5192; i=leitao@debian.org;
 h=from:subject:message-id; bh=LPqPvdo4ubuN2gY32YVboTIPFg+DFP6SqSHcJnYrbP0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpSVsqHldtZsxTcwW9WAZQteQM0bthqPfP3utOD
 9Rakwk28ceJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaUlbKgAKCRA1o5Of/Hh3
 bRCwD/9l4csHXY05KVUulWnq35BblnQOEAG5Fuj2+I9FgmwAIdjspYhsPpsy5g6Uy+IqKlvYJDl
 y4h/VmEhgc6rm72FIkEgggj000lBNmZrAMPgxob2usOQDx1lnOx3/ROnbZ24gN1alQ/OPgg6FVu
 6O6gdEiBd3NnWwZr5wUmHLKbD6sfXclLLiE/rVwbgu9RxIMlEuqjmfKKORA7xiP/rx6UGuowaOx
 ywPBT77BrhEC1yEJIRjTN2MfZMM8fiRbjd33bB+vdUzZFep2XT3Cmb7i12pV1PavvkRvio3KznS
 d+7ZA0AptlHCAGMfRUJlmniFRVusTnXVCwoaqg7GhWkbZ9sRy1dqwg6O8qw0YX/t8lPxkzN2dUg
 Lj09lg6wVUo3IxIe7B2d9PYX1gS8a07m3zzGgrlPOKYAuWqvnYiNS+2vx2jv04d+bx4MxtvtNqC
 KsADQyqB6en9R1fCfAbCCQAdnEGPT5ng89vKqr4i/FAPgnES52B7kbo7+/ix+Jtnkf0+nW3MZBf
 ZeZEfN8JJoSmCNGGqLGQGEk9TzNceJyUhJCcl6eTDb2w0Jg9PDUtuiBEtQOmgcbJyGNkTQ6TFPy
 Opb90gPOtkz+l2gjMjbmwsVLfLOOcqtxA/wuRjpdxFlPVVtqldhxP9Uns4XnPdpedGnR+cJrFKI
 33L23AGiyww4Crg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert netconsole from the legacy console API to the NBCON framework.
NBCON provides threaded printing which unblocks printk()s and flushes in
a thread, decoupling network TX from printk() when netconsole is
in use.

Since netconsole relies on the network stack which cannot safely operate
from all atomic contexts, mark both consoles with
CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])

CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
scenarios (panic) where regular messages are sent in threaded mode.

Implementation changes:
- Unify write_ext_msg() and write_msg() into netconsole_write()
- Add device_lock/device_unlock callbacks to manage target_list_lock
- Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network operations
- Set write_thread and write_atomic callbacks (both use same function)

Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 95 +++++++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 37 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index dc3bd7c9b049..248b401bcaa4 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1709,22 +1709,6 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 				   sysdata_len);
 }
 
-static void write_ext_msg(struct console *con, const char *msg,
-			  unsigned int len)
-{
-	struct netconsole_target *nt;
-	unsigned long flags;
-
-	if ((oops_only && !oops_in_progress) || list_empty(&target_list))
-		return;
-
-	spin_lock_irqsave(&target_list_lock, flags);
-	list_for_each_entry(nt, &target_list, list)
-		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
-			send_ext_msg_udp(nt, msg, len);
-	spin_unlock_irqrestore(&target_list_lock, flags);
-}
-
 static void send_msg_udp(struct netconsole_target *nt, const char *msg,
 			 unsigned int len)
 {
@@ -1739,29 +1723,60 @@ static void send_msg_udp(struct netconsole_target *nt, const char *msg,
 	}
 }
 
-static void write_msg(struct console *con, const char *msg, unsigned int len)
+/**
+ * netconsole_write - Generic function to send a msg to all targets
+ * @wctxt: nbcon write context
+ * @extended: "true" for extended console mode
+ *
+ * Given a nbcon write context, send the message to the netconsole
+ * targets
+ */
+static void netconsole_write(struct nbcon_write_context *wctxt,
+			     bool extended)
 {
-	unsigned long flags;
 	struct netconsole_target *nt;
 
 	if (oops_only && !oops_in_progress)
 		return;
-	/* Avoid taking lock and disabling interrupts unnecessarily */
-	if (list_empty(&target_list))
-		return;
 
-	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
-			/*
-			 * We nest this inside the for-each-target loop above
-			 * so that we're able to get as much logging out to
-			 * at least one target if we die inside here, instead
-			 * of unnecessarily keeping all targets in lock-step.
-			 */
-			send_msg_udp(nt, msg, len);
-		}
+		if (nt->extended != extended || !nt->enabled ||
+		    !netif_running(nt->np.dev))
+			continue;
+
+		if (!nbcon_enter_unsafe(wctxt))
+			continue;
+
+		if (extended)
+			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+		else
+			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
+
+		nbcon_exit_unsafe(wctxt);
 	}
+}
+
+static void netconsole_write_ext(struct console *con __always_unused,
+				 struct nbcon_write_context *wctxt)
+{
+	netconsole_write(wctxt, true);
+}
+
+static void netconsole_write_basic(struct console *con __always_unused,
+				   struct nbcon_write_context *wctxt)
+{
+	netconsole_write(wctxt, false);
+}
+
+static void netconsole_device_lock(struct console *con __always_unused,
+				   unsigned long *flags)
+{
+	spin_lock_irqsave(&target_list_lock, *flags);
+}
+
+static void netconsole_device_unlock(struct console *con __always_unused,
+				     unsigned long flags)
+{
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
@@ -1924,15 +1939,21 @@ static void free_param_target(struct netconsole_target *nt)
 }
 
 static struct console netconsole_ext = {
-	.name	= "netcon_ext",
-	.flags	= CON_ENABLED | CON_EXTENDED,
-	.write	= write_ext_msg,
+	.name = "netcon_ext",
+	.flags = CON_ENABLED | CON_EXTENDED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netconsole_write_ext,
+	.write_atomic = netconsole_write_ext,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
 };
 
 static struct console netconsole = {
-	.name	= "netcon",
-	.flags	= CON_ENABLED,
-	.write	= write_msg,
+	.name = "netcon",
+	.flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netconsole_write_basic,
+	.write_atomic = netconsole_write_basic,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
 };
 
 static int __init init_netconsole(void)

-- 
2.47.3


