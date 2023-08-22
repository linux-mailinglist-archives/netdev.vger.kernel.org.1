Return-Path: <netdev+bounces-29608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D4784093
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD661C20ADE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1011C29B;
	Tue, 22 Aug 2023 12:18:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AE28F78
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 12:18:50 +0000 (UTC)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE9196
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 05:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IcAisKll3lz7UQrYFhZIyuQLWKwC6t0F2YpyCjHDpK4=; b=Y4GKeW+vSXGKf7WABgAimmqu0R
	RTVieykWNNF6ZHuwI5bGTseTngH0Qx8Owd2ZrGZZm9sre5geNsEGR9js0Jw9kWw5LCeULlqamzAIu
	Mw8JdAPDd05NDdPJdMmfRvjnJHRitnUOF7FTAzjeGubM0uoMnN9JfDlBubkJAiD691cZ6WFc0shEE
	qRqxA8nLOPIBod5G6LNirTxvTnrk+xH6LhMigRfGqUcca3MgEuKc/ym8prHm9fA5OdL0Sa0XE82bB
	fjbwaCkq69MCqaqzylfrdmdmtiqlYIACgExAtJAqwBczXpIKEVVZTYMJWGP+YUrWkzWibRbbi+sna
	jzDDyxdg==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.94.2)
	(envelope-from <phil@nwl.cc>)
	id 1qYQLF-0007l1-Um; Tue, 22 Aug 2023 14:18:37 +0200
From: Phil Sutter <phil@nwl.cc>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [iproute2 PATCH] ss: Fix socket type check in packet_show_line()
Date: Tue, 22 Aug 2023 14:19:16 +0200
Message-ID: <20230822121916.23912-1-phil@nwl.cc>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The field is accessed before being assigned a meaningful value,
effectively disabling the checks.

Fixes: 4a0053b606a34 ("ss: Unify packet stats output from netlink and proc")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 misc/ss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index de54b0da7a192..5156faf4dca7f 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4534,9 +4534,9 @@ static int packet_show_line(char *buf, const struct filter *f, int fam)
 			&type, &prot, &iface, &state,
 			&rq, &uid, &ino);
 
-	if (stat.type == SOCK_RAW && !(f->dbs&(1<<PACKET_R_DB)))
+	if (type == SOCK_RAW && !(f->dbs&(1<<PACKET_R_DB)))
 		return 0;
-	if (stat.type == SOCK_DGRAM && !(f->dbs&(1<<PACKET_DG_DB)))
+	if (type == SOCK_DGRAM && !(f->dbs&(1<<PACKET_DG_DB)))
 		return 0;
 
 	stat.type  = type;
-- 
2.41.0


