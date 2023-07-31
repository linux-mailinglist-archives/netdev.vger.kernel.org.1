Return-Path: <netdev+bounces-22886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B36769C21
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773291C20B4C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1619F19BC2;
	Mon, 31 Jul 2023 16:19:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAF18AFE
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503BCC433C7;
	Mon, 31 Jul 2023 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690820362;
	bh=bEBF9ioUxTPmqzcBjNub2fxvM2F7G2o44CLXoEJALSs=;
	h=From:To:Cc:Subject:Date:From;
	b=mBvdxMeCFOEabSFnCMZOsGYbQQbWaEaWxj29iwdFk0gitq8XMPiKaLjZCe2kvNqAy
	 4W6C5/ozoSkp0WhkiGhOgSXeqZtXbOzxx7UZiTd4E5jcebWWdvFIjumR3RxJ8zOrh4
	 3WXHVqBuBH43NmMzDDi6X8qNjixdCvJEwSJUH0B4Io5E4zhPoGioFsK1gD2aXwAA65
	 qKs73q0ksaKa8snrb4bbAhWFnK14QkgIMJTmMcYtruN8OSyD68u1jfO84APevfAiKe
	 b05gLcxcNhJ6kszpheP2sokWnh0ucD3gSA7VxQy2iLobLEqq1v6kXTOC6Kb3dr8N3m
	 ARx6EnBpYgK7g==
From: Jakub Kicinski <kuba@kernel.org>
To: dsahern@gmail.com
Cc: stephen@networkplumber.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH iproute2-next v2] ip: error out if iplink does not consume all options
Date: Mon, 31 Jul 2023 09:19:20 -0700
Message-ID: <20230731161920.741479-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dummy does not define .parse_opt, which make ip ignore all
trailing arguments, for example:

 # ip link add type dummy a b c d e f name cheese

will work just fine (and won't call the device "cheese").
Error out in this case with a clear error message:

 # ip link add type dummy a b c d e f name cheese
 Garbage instead of arguments "a ...". Try "ip link help".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove the ->parse_opt check later
v1: https://lore.kernel.org/all/20230728183329.2193688-1-kuba@kernel.org/
---
 ip/iplink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 6c5d13d53a84..9a548dd35f54 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -1112,13 +1112,12 @@ static int iplink_modify(int cmd, unsigned int flags, int argc, char **argv)
 		argc -= ret;
 		argv += ret;
 
-		if (lu && argc) {
+		if (lu && lu->parse_opt && argc) {
 			struct rtattr *data;
 
 			data = addattr_nest(&req.n, sizeof(req), iflatype);
 
-			if (lu->parse_opt &&
-			    lu->parse_opt(lu, argc, argv, &req.n))
+			if (lu->parse_opt(lu, argc, argv, &req.n))
 				return -1;
 
 			addattr_nest_end(&req.n, data);
-- 
2.41.0


