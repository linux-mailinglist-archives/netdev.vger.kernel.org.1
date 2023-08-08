Return-Path: <netdev+bounces-25577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E2774D3D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509F91C20FD8
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D75174CC;
	Tue,  8 Aug 2023 21:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC4E569
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:44:36 +0000 (UTC)
Received: from authsmtp.register.it (authsmtp08.register.it [81.88.48.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6110D1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:44:33 -0700 (PDT)
Received: from localhost.localdomain ([213.230.62.249])
	by cmsmtp with ESMTPSA
	id TUUDqYXukCJCaTUUDqEu4c; Tue, 08 Aug 2023 23:43:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schroetersa.ch;
	s=key_mmumrc8kf9; t=1691531009;
	bh=Vgf9WaXByktY1QmN6KvRZlFTz+cLxrhgeQg1RDwJoTY=;
	h=From:To:Cc:Subject:Date;
	b=vXoDimFYSQte9zI9UaFuhTUcBJSBNG5DNbU5+CYoYzHai3z+WnkIwKF1T0idB3t8A
	 y42n7kI9E7EeLyL/f2wTQaWdhzkJAPE85TUNIepCdHOVcq6wKP0fXNt/uFTINIrsuX
	 GQchgZD8/8Ry1xmTvlIi0WSsGFfo4j2M8YplJlmX7XjHDBtoe6MktOeXocExhEObfl
	 VqXNejnuzNLtYyBJmntDRxnUo7aSmcZHUrBRKDoM2ddeopf9wUUEh2Up+5pdaXPd55
	 teKUKTD+Xv7s+ZMJIwFQ0Rqcl0pVWcuC+cr1uDsRKKdbduWY+uaksY6qXzFPT2kztD
	 y9+3W1gSbEfWw==
X-Rid: mathieu@schroetersa.ch@213.230.62.249
From: Mathieu Schroeter <mathieu@schroetersa.ch>
To: netdev@vger.kernel.org
Cc: Mathieu Schroeter <mathieu@schroetersa.ch>
Subject: [PATCH iproute2-next 1/4] Add get_long utility and adapt get_integer accordingly
Date: Tue,  8 Aug 2023 23:42:55 +0200
Message-Id: <20230808214258.975440-1-mathieu@schroetersa.ch>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLt7SBoWUeaf3xVaYQb4iEtj++3AhAg0eXHa0B6Hau3WZ783Y67BQeMaSPhjG427t+7abRj05edwBeIGBrdZ4gU5fkZ32GjbZdkoZE5y3H/79EXmIQMK
 0z4lfkOeF81TettWceUuo0CrzIYoJCrPcl/j5G6j2ULz/ca/mcz2rENYIniS0+myFt5iJ2CiIucSIOKihvsXtEzimfFdPQTjgwUUdgjL43PBuGQ04TyhDCVX
 j3SwWad1V/EySEyVtN6xNg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Mathieu Schroeter <mathieu@schroetersa.ch>
---
 include/utils.h |  1 +
 lib/utils.c     | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/utils.h b/include/utils.h
index 3159dbab..cf11174d 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -142,6 +142,7 @@ int get_addr_rta(inet_prefix *dst, const struct rtattr *rta, int family);
 int get_addr_ila(__u64 *val, const char *arg);
 
 int read_prop(const char *dev, char *prop, long *value);
+int get_long(long *val, const char *arg, int base);
 int get_integer(int *val, const char *arg, int base);
 int get_unsigned(unsigned *val, const char *arg, int base);
 int get_time_rtt(unsigned *val, const char *arg, int *raw);
diff --git a/lib/utils.c b/lib/utils.c
index b1f27305..68f44303 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -108,7 +108,7 @@ static int get_hex(char c)
 	return -1;
 }
 
-int get_integer(int *val, const char *arg, int base)
+int get_long(long *val, const char *arg, int base)
 {
 	long res;
 	char *ptr;
@@ -133,6 +133,17 @@ int get_integer(int *val, const char *arg, int base)
 	if ((res == LONG_MAX || res == LONG_MIN) && errno == ERANGE)
 		return -1;
 
+	if (val)
+		*val = res;
+	return 0;
+}
+
+int get_integer(int *val, const char *arg, int base)
+{
+	long res;
+
+	res = get_long(NULL, arg, base);
+
 	/* Outside range of int */
 	if (res < INT_MIN || res > INT_MAX)
 		return -1;
-- 
2.39.2


