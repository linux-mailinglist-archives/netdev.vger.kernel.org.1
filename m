Return-Path: <netdev+bounces-176898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95EBA6CADC
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02A2886F8B
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C297123371B;
	Sat, 22 Mar 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="nY/5+cQk"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8823314B;
	Sat, 22 Mar 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654532; cv=none; b=Ec0h30zXG0rPaLuJtBAiDBBmZa4aV50Y+3Ja1IazXoulN6D9zQNr6WSlGTpU89FIJw71neqf7eDCbqCqhxlq2p17ak2pymizTYfFlKq62Tu9JPVeKdKicdfZz7pb0pOKeuh7mzLG8xm2Cbhmounskn0z4uS1619FVbhz3/eze0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654532; c=relaxed/simple;
	bh=DljgwlUD9DXB3rIcQe+6ym+yanfyJEBfdS8ce+jZ2sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twl2xQkqhoeCexgEne97Bfv6c6nTqxB6qSDRZDqXiKnXTb+nXmDhpaIA8tSDTUoox75p66CtC3R3k/HhTDJd5a6ihq/1Xl2halgxxolieDMpkk7BG0BxvCVUJOznmoItIVkcdWX1UFeUWsJniskfqi5W5P0Ivg3GPplINN9AiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=nY/5+cQk; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1014:0:640:8592:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id EAC4F60D10;
	Sat, 22 Mar 2025 17:42:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7gNCmaXLjmI0-ApoAzNXk;
	Sat, 22 Mar 2025 17:42:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654528; bh=ochHTAS5LuFICn3x9Gt7bCewOS0lDumijpNJdXCjt4s=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=nY/5+cQkzEBzNt3rQT5PzqeUm2TSuf61UtDqP8dosorW4hLnyGkAmjbi+iH5hD3Dc
	 PAwP59NSyNJmJDjcVy+nqNRlu5JlAInl1h6o6vlmNNm68YOSf1M/BHufmcozrvQpit
	 CNOr2HTfdGLrCzs7+3wWAWFS5r+5N656bRwAeuRw=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 34/51] dsa: Make all switch tree ports relate to same nd_lock
Date: Sat, 22 Mar 2025 17:42:07 +0300
Message-ID: <174265452703.356712.4878516873691237055.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

dsa_tree_migrate_ports_from_lag_conduit() may take any
of ports as new conduit, and it will be connected to
the rest of ports (and using netdev_upper_dev_link()),
so all of them must share the same nd_lock.

xxx: Keep in mind NETDEV_CHANGEUPPER is called
     by netdev_upper_dev_unlink().

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/dsa/dsa.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..6468b03d3d46 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1156,6 +1156,8 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *conduit,
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_switch_tree *dst = ds->dst;
 	enum dsa_tag_protocol default_proto;
+	struct nd_lock *nd_lock, *nd_lock2;
+	struct dsa_port *first_dp;
 
 	/* Find out which protocol the switch would prefer. */
 	default_proto = dsa_get_tag_protocol(dp, conduit);
@@ -1213,6 +1215,18 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *conduit,
 		dst->tag_ops = tag_ops;
 	}
 
+	first_dp = dsa_tree_find_first_cpu(dst);
+	if (first_dp && first_dp->conduit) {
+		/* All conduits must relate the same nd_lock
+		 * since dsa_tree_migrate_ports_from_lag_conduit()
+		 * may take any of them from list.
+		 */
+		double_lock_netdev(first_dp->conduit, &nd_lock,
+				   conduit, &nd_lock2);
+		nd_lock_transfer_devices(&nd_lock, &nd_lock2);
+		double_unlock_netdev(nd_lock, nd_lock2);
+	}
+
 	dp->conduit = conduit;
 	dp->type = DSA_PORT_TYPE_CPU;
 	dsa_port_set_tag_protocol(dp, dst->tag_ops);


