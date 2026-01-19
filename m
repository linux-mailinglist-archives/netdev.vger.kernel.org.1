Return-Path: <netdev+bounces-251313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA9D3B92C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE6F7302DC9D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82A2F9DA7;
	Mon, 19 Jan 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="PVc4Ck8H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931F2F8BF0
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857188; cv=none; b=Efo0V5i3bnn5pU7zDG0YRfwZUmeeiUjEQQ0Q7bEHhoW69UScfuw9FCsDcSJa7cQb0mF6vWPUxBrLmlJ0T31lqXBR5I6w6iNiNhaov0qYbj9TAQCDPuioi+5hde21OWkCMVUZISKFXzBOkIowBuIvUwzwEtkHQYesnhPJuScfwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857188; c=relaxed/simple;
	bh=aVCycgrrN/pMBa7j/V1XUjFE5vyf9msPfIlQTHiAIZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiO+LN488pwv4DxgW9c8Vix4CewmNLx5dy8gbCKzCvXqGTfIsiNJ4wCxe6tmY41v8r/8oIAefw3OonY369gN2xZQtzBnRVwKpGbBnnuCYJ+JPvzRJWDenAVQnXzNOrfC5ThpvIFzZhN3yANNHn6z6h587EQ7Wy0/yRHJqNJnggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=PVc4Ck8H; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ad70765db9so4963040eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1768857185; x=1769461985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFHrzVMQr6m0k+CuvTA33w8kuU0amqOxpW3rMFiQp14=;
        b=PVc4Ck8H2GuyWWVRBy8wp3oE1YBjvi5ss48xaNE9fYj4x4I2NzwUubPQGViCLu6X+6
         IJl/+Pl1hg8K5k9uqvxer/W6rnVVKRFvAC0LFP21xNA0iwE6WDdoqcCzbfXIFnCUTmRH
         8GEqfDBMB3Dn9h5D078djBSR2wPSVfAHd7hbh0Cvv2EB1PMdF7gmgxTqG3/5lYaSPfUs
         NSTF7xGqIBaHxUOe06w1+ol04i6xM0xVgxc0+LdqIFRQLHUjmDJiT4UJoFITVegzNZoR
         nq3/+QK+lmiGgDdB0paQB8I7AvplfU5GNud5+VEhX008H8nN5j8+AbywlIqn6oETzlT0
         8VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768857185; x=1769461985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFHrzVMQr6m0k+CuvTA33w8kuU0amqOxpW3rMFiQp14=;
        b=wFosEfB+fc3ntjF3kKg+YmiYRkfb5uxcq4V5qKRmM5EliTGjhEE4neLoTjfgV+MTTs
         Y4eFGvQaP494wVtvWQTTuzAfHy0ZLdt3A5Kh6d+GdDQPiwyWdH9njlrjfhVuntG1LSLg
         bwDAwSKyErPxF/OhkslsZsbi9zrWKdBvhCGc/o+o8Od0zu9KDehXAbxObS9M+xsxEpx0
         Q4lTVS4ZZh2NekzDimeZyTTLW0OVB+NnN7I4sw7o7I0VoE7E0mNVoj1OZ7ags5JJvZ6G
         X53dUM5z94Umwo2hq+o8+kCnuYgSbtQJNTML4c3mebLOPT2BjTc+f0s5MFlzpyY3hSCM
         VYgA==
X-Forwarded-Encrypted: i=1; AJvYcCXenJGZjsVhkYUBZRdiKG2tvbtHrC/Y/xZ4Iqeh5nGgbNN9tV6kqfm/ub2uatoUhYCpW3wInQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1Dvlre7Q204sF1GGSakCTSL76dnF8dAgU/79qhcJgI/niddB
	WsVS1lGEJuYQ5Yy5kHEToQ6SDS8h9AuvDeq1sCfUj9JiUI86SJHwvn2WDBc1w8Ej8A==
X-Gm-Gg: AZuq6aKYudaKrVjEuX5tDrXUNu6D+D9UoynmitluzUm3xcKaK9vnwcWV0iIU2S9PDqW
	FydpQ4Z/N7/0p5edNKW/xOO0tvD4/hBa9YZJjtmnnRMUzq2ihfuMW/0bSv+L99KMcyb4oQOev3Q
	z/L0zELGTPUClBBS/GvLIsXVON9nt92fATQT4H9m0XOTecbvja8mWS0W9s0coOdkGzR8INqRPg8
	4XbQvx9zjbYm15yCoriHjF/eixs479huxujsaWCoHEssMOkyntUkw3xEGATjnAec9AKq+fKwxZT
	rTCo7KHhO/4qVPvK08+LW+H2Hjqm2QRH49aOaw7iuqI73lQAbnwItK1azgi4D+mIP/vWHYe42k+
	oPGbgix4olRe0F47/pvISqAIgiNL+PBLruAJUaw2XsSbhbKKiLEc9OThjqYNnUQl9FQq5VAwtPw
	yMhF5rx4eLzX+caI7QuC+mJNo3XdehCzm6Jxbyn0Pnesc3yHJzoQQh13a7
X-Received: by 2002:a05:7300:a889:b0:2b6:ab62:ae9b with SMTP id 5a478bee46e88-2b6b4e5b598mr6877136eec.11.1768857184861;
        Mon, 19 Jan 2026 13:13:04 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:850a:22d6:79cd:2abe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14348137eec.14.2026.01.19.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 13:13:04 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 5/7] ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
Date: Mon, 19 Jan 2026 13:12:10 -0800
Message-ID: <20260119211212.55026-6-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119211212.55026-1-tom@herbertland.com>
References: <20260119211212.55026-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the descriptions of max_dst_opts_number and max_hbh_opts_number
sysctls add text about how a zero setting means that a packet with
any Destination or Hop-by-Hop options is dropped.

Report the defaults for max_dst_opts_number and max_hbh_opts_number
are 2 which means up to two options may be accepted.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..5051fe653c96 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2474,20 +2474,26 @@ mld_qrv - INTEGER
 	Minimum: 1 (as specified by RFC6636 4.5)
 
 max_dst_opts_number - INTEGER
-	Maximum number of non-padding TLVs allowed in a Destination
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
+        Maximum number of non-padding TLVs allowed in a Destination
+        options extension header. If this value is zero then receive
+        Destination Options processing is disabled in which case packets
+        with the Destination Options extension header are dropped. If
+        this value is less than zero then unknown options are disallowed
+        and the number of known TLVs allowed is the absolute value of
+        this number.
 
-	Default: 8
+        Default: 2
 
 max_hbh_opts_number - INTEGER
 	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
-
-	Default: 8
+	options extension header. If this value is zero then receive
+        Hop-by-Hop Options processing is disabled in which case packets
+        with the Hop-by-Hop Options extension header are dropped.
+        If this value is less than zero then unknown options are disallowed
+        and the number of known TLVs allowed is the absolute value of this
+        number.
+
+        Default: 2
 
 max_dst_opts_length - INTEGER
 	Maximum length allowed for a Destination options extension
-- 
2.43.0


