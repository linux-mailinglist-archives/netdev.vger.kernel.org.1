Return-Path: <netdev+bounces-22409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467CF76757E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35B5282746
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B86C14008;
	Fri, 28 Jul 2023 18:33:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38C1BB4B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 18:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9855EC433C7;
	Fri, 28 Jul 2023 18:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690569215;
	bh=9zGb2T2gSm+kIlbfOd1TNk8IdKjhl4LekFgonO8Tsdg=;
	h=From:To:Cc:Subject:Date:From;
	b=IoWKu7lGzbu2m6OkwZvYGB5jfUk/0EVwVP7YXbMzE/gN05prBy74lGjWcfzJ7Bh4I
	 ii3EaNOXnVLVpz8z1m3nPpuUpmnR7IhjKt6CtD8fG34mV39jVhTTYrlPQ5tqd+2pB/
	 /ES+YPMtsi5shhurAkQVlZWE/hiu7eQdNqRXq4320yVvGs5UuqWV2X7+L4znBvYPfI
	 k/Sop8Kh/HdBR8zDkLuVk4yUdjolfBhFHkQALQDtMNAAOijc94VYe0ujrc1ZAzH4el
	 0NVgu6QLzSEk9dVkguGj08BvjaPb5BzehaLsfiKABmC6psfYM+6q0KP5rIEyBnNqDq
	 absPfFMZbcLBg==
From: Jakub Kicinski <kuba@kernel.org>
To: dsahern@gmail.com,
	stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH iproute2-next] ip: error out if iplink does not consume all options
Date: Fri, 28 Jul 2023 11:33:29 -0700
Message-ID: <20230728183329.2193688-1-kuba@kernel.org>
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
 ip/iplink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 6c5d13d53a84..f60cff9c4b5f 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -1112,7 +1112,7 @@ static int iplink_modify(int cmd, unsigned int flags, int argc, char **argv)
 		argc -= ret;
 		argv += ret;
 
-		if (lu && argc) {
+		if (lu && lu->parse_opt && argc) {
 			struct rtattr *data;
 
 			data = addattr_nest(&req.n, sizeof(req), iflatype);
-- 
2.41.0


