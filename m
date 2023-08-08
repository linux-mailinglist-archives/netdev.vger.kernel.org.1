Return-Path: <netdev+bounces-25580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F6774D41
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9F01C21006
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112EE174C4;
	Tue,  8 Aug 2023 21:44:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642719896
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:44:36 +0000 (UTC)
Received: from authsmtp.register.it (authsmtp19.register.it [81.88.48.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BEF1BEA
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:44:33 -0700 (PDT)
Received: from localhost.localdomain ([213.230.62.249])
	by cmsmtp with ESMTPSA
	id TUUDqYXukCJCaTUUEqEu4p; Tue, 08 Aug 2023 23:43:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schroetersa.ch;
	s=key_mmumrc8kf9; t=1691531010;
	bh=8Yb4Jl0Mb1TmDbXrGPNIPZesvom88SnHDY80EoicmSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D6HSCPjpyAHsJBfkGZIT4ogUx0bQdaBGJjwJ7p/25Cn2Bor7rH8kgpWSVD7hq8ZKg
	 XGvSY9kcsFerPhKate0Q5JU5ETBtxBsKKG5nxC6XLrcZ6abLz84kVVe8tB9Zs93Z+w
	 TZ/xRGxgdfsXkpAeoTzX7eF7a/iuLo3SWZysrZb3NbWeMIxe5ZqAhsrdDOCXyMGpfY
	 MTAEWT1cJoNdUgUTgVNDsmrqQBfW2CHRXIQISL2Oo27CHbtCSC2q2lD1sFiAc8fGBf
	 lB4dKfI1RJkigY6slqC3bgxZL6UZ4LLP8nwof4eXocHBIzEq22qWHA8C/+9b/VVx2G
	 Z4u+RlQ0TaiUA==
X-Rid: mathieu@schroetersa.ch@213.230.62.249
From: Mathieu Schroeter <mathieu@schroetersa.ch>
To: netdev@vger.kernel.org
Cc: Mathieu Schroeter <mathieu@schroetersa.ch>
Subject: [PATCH iproute2-next 3/4] ss: change aafilter port from int to long (inode support)
Date: Tue,  8 Aug 2023 23:42:57 +0200
Message-Id: <20230808214258.975440-3-mathieu@schroetersa.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808214258.975440-1-mathieu@schroetersa.ch>
References: <20230808214258.975440-1-mathieu@schroetersa.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIeu2yRNlD6HCRfYz+sUir1zNW5O61EciCMSD8red2oD4n7rVPf5VsQAwCWV8Nhlg50/Dus8SP4EjaEEsBxih9GP6zB/IMlEwSOVvsJYGDjfKDxn1s/H
 qS+XJmjJesFiUDpl3YBINhzGsexTGCKAqz7K8YEUz6/MgOAVYvb1nO25Me8DdnF+MDd0LHhOwfPdav2WTl276KHNLSHkje7+xAxBH2YL7+OlDiEuHqW6YYal
 wWx2WDA5b/RdM+PXOzX/ZQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The aafilter struct considers the port as (usually) 32 bit signed
integer. In case of a unix socket, the port is used with an inode
number which is an unsigned int. In this case, the 'ss' command
fails because it assumes that the value does not look like a port
(<0).

Here an example of command call where the inode is passed and
is larger than a signed integer:

ss -H -A unix_stream src :2259952798

Signed-off-by: Mathieu Schroeter <mathieu@schroetersa.ch>
---
 misc/ss.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index e9d81359..baa83514 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -1733,7 +1733,7 @@ static void inet_addr_print(const inet_prefix *a, int port,
 
 struct aafilter {
 	inet_prefix	addr;
-	int		port;
+	long		port;
 	unsigned int	iface;
 	__u32		mark;
 	__u32		mask;
@@ -2256,7 +2256,7 @@ void *parse_hostcond(char *addr, bool is_port)
 		port = find_port(addr, is_port);
 		if (port) {
 			if (*port && strcmp(port, "*")) {
-				if (get_integer(&a.port, port, 0)) {
+				if (get_long(&a.port, port, 0)) {
 					if ((a.port = xll_name_to_index(port)) <= 0)
 						return NULL;
 				}
@@ -2279,7 +2279,7 @@ void *parse_hostcond(char *addr, bool is_port)
 		port = find_port(addr, is_port);
 		if (port) {
 			if (*port && strcmp(port, "*")) {
-				if (get_integer(&a.port, port, 0)) {
+				if (get_long(&a.port, port, 0)) {
 					if (strcmp(port, "kernel") == 0)
 						a.port = 0;
 					else
@@ -2335,7 +2335,7 @@ void *parse_hostcond(char *addr, bool is_port)
 			*port++ = 0;
 
 		if (*port && *port != '*') {
-			if (get_integer(&a.port, port, 0)) {
+			if (get_long(&a.port, port, 0)) {
 				struct servent *se1 = NULL;
 				struct servent *se2 = NULL;
 
-- 
2.39.2


