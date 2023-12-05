Return-Path: <netdev+bounces-53939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 780BB80551E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92681C20BB5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE73F8E3;
	Tue,  5 Dec 2023 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="S1pXFNdO"
X-Original-To: netdev@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A928C6
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 04:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=xmYX3iHCDz0zWB20iqNWRlfDjouACK8xEIX3J9JrkfI=; b=S1pXFNdOhz7F53Z88x94WjGxtb
	YfC7ViW1Nzom/On4x7inz+Ws/Gue4pMMSBzc3mgHuELEpVzMY/CMekp0xqTu6+mcO8ni7RohadmS4
	nN21c2VumULoyvr9ASkR44N+Aefa/HFq0zbja9KuACb6QE6rton9rlAg+P9FuSSxzQ5Q/ApevtUuh
	FOS56ZWgvws50nxHUnWE/HtrKcOl9/+6emQ6hQkuq/wOPnO33zNnXq8hn+uf6Pcid3fLFL5ZfGXh4
	0gs5pTlyDZuj9IJRQHlLP7URaL82IgF2sQlufq/Bn9YTUX3zHYp6i1h1n+YY1zaPoU9509cePZVyq
	yyckwuVg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1rAUox-000MZs-Ut; Tue, 05 Dec 2023 13:46:39 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sean@geanix.com>)
	id 1rAUox-0001m9-65; Tue, 05 Dec 2023 13:46:39 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	ceggers@arri.de,
	netdev@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] net: dsa: microchip: fix NULL pointer dereference in ksz_connect_tag_protocol()
Date: Tue,  5 Dec 2023 13:46:36 +0100
Message-ID: <20231205124636.1345761-1-sean@geanix.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)

We should check whether the ksz_tagger_data is allocated.
For example when using DSA_TAG_PROTO_KSZ8795 protocol, ksz_connect() is not
allocating ksz_tagger_data.

This avoids the following null pointer dereference:
Unable to handle kernel NULL pointer dereference at virtual address 00000000 when write
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 26 Comm: kworker/u5:1 Not tainted 6.6.0
Hardware name: STM32 (Device Tree Support)
Workqueue: events_unbound deferred_probe_work_func
PC is at ksz_connect_tag_protocol+0x40/0x48
LR is at ksz_connect_tag_protocol+0x3c/0x48
[ ... ]
 ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0
 dsa_register_switch from ksz_switch_register+0x65c/0x828
 ksz_switch_register from ksz_spi_probe+0x11c/0x168
 ksz_spi_probe from spi_probe+0x84/0xa8
 spi_probe from really_probe+0xc8/0x2d8

Fixes: ab32f56a4100 ("net: dsa: microchip: ptp: add packet transmission timestamping")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 42db7679c360..1b9815418294 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2623,9 +2623,10 @@ static int ksz_connect_tag_protocol(struct dsa_switch *ds,
 				    enum dsa_tag_protocol proto)
 {
 	struct ksz_tagger_data *tagger_data;
-
-	tagger_data = ksz_tagger_data(ds);
-	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+	if (ksz_tagger_data(ds)) {
+		tagger_data = ksz_tagger_data(ds);
+		tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+	}
 
 	return 0;
 }
-- 
2.42.0


