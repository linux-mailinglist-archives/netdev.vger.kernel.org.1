Return-Path: <netdev+bounces-79219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD64878522
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1141C21825
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C551C33;
	Mon, 11 Mar 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsEeXq/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5724AEC1
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173987; cv=none; b=Ci2Tf32w9Uc//RwDJgQzqfxNlMZpgJRpQ335A1cTJ7AIt+cb/OTD1W8seQeq7gnkMU+vUv7YBXm/Y31mCVUBUBYXdzsLYPQizJW2Le94pPOqjRsg4W/TIenvT9KotQWd6UgDqgSH/6YxnWrMtthXa/2ahBpmQUgYpaiznckvpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173987; c=relaxed/simple;
	bh=k7jOBaczrzP/dL5t3WBjMMPWSH9b+GNgInQVCuTlp+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjLxBoo9HxWwpHLk1zswgWL4BKRlL+2JTr1zfgtDiyxgItsbAVcSTl1dp7MPzIzvuoJ4awywzpFLgSUC1UUehZZ+u57yg7qnM2wDJyBL3iRp+Zri2WUdRrKI4PzxODu5nHZ8WeBC2nYP7BlDrngokcezGovA6dbYOPhebRFi9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsEeXq/v; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c19dd9ade5so2064451b6e.3
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173984; x=1710778784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpTevDXPiK3e/RqTRVk9DQy0lJx+u7v12LML056Rwt4=;
        b=TsEeXq/v3zT+sOZbRsLnFnAoIA1AdWOlZ2GscnyfFAB/CrVabQ5mzhsUVMWnnFmJ8d
         OaNp5unlx4AEnCyll+1VBXKkWxitekuElqO+WWaFQodw3Dmu/HJQ67GEJuJfYmpqcCSH
         ge2aFYAJetel2zu3xfefO+nyMbKWOXvSz5NL6PDlrD4wz4V1TqyUjVyFa1hnbHmKUwzo
         IqDhfK4WnDWP8NPjewwICv7Nx2+7sq5oFAzKD+wsbB+FFwWFtqYjjW6aZHoFGtsPZkja
         BjSX5liT4S+rv1lC7BbbmXYeVW9dfVdqkr8XIdF8Krpkf/cFf6Yew9vCypkjjzx3d4Bu
         ZYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173984; x=1710778784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpTevDXPiK3e/RqTRVk9DQy0lJx+u7v12LML056Rwt4=;
        b=Q7RVmkr5N+mZlswy5UxSfXXtwSKqtiCc6CKEA0FEUHSUF/MdFTqxWyOXh/gmuIQyTY
         56vCGlp7slWy/qw2W+8nQuKCALcljlX+nJlVJPr2P7XCXrBhGJsxFQfFd6knb1UPGRh0
         3dFE10yGrNmcOybnMZRCboYgyL6mKBFG3wZSQiLggkUsQBrYr4OfOCzdm97MvrLK+GqZ
         sM73sA6WsmQsrywohmpe0+ux2IQQe+P/3PMIwVzR9h8sjgL9ieku9z8wRyynkseBVGMK
         cVdQ/ss38WEUV82W2U6gQ4E38hFqWmys8yeFayVHgsI6c3pBvUXDmzOXHMvpx2njh9gf
         cR0g==
X-Gm-Message-State: AOJu0Yxa0e57ogBeMAAvpp8Ov1ejzbgTjIVswf5WzW9+28lO36ikQ33Y
	l+saD/cfFmF5EYYBLdC+oqNxIEOls8ctBU6ocZ7zz3iXT/miqTt34+WQUTq/Cjo=
X-Google-Smtp-Source: AGHT+IESXLDWF+aQY894ZLdwBLONp/Fq+786hOVTbmyP1S+7BFgSURbdBC+wuzN00bbb1E04RCW/IQ==
X-Received: by 2002:a05:6808:1201:b0:3c1:b7ce:1e1 with SMTP id a1-20020a056808120100b003c1b7ce01e1mr7477789oil.23.1710173984604;
        Mon, 11 Mar 2024 09:19:44 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id w18-20020a056214013200b0068fc5887c9fsm2788245qvs.97.2024.03.11.09.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:19:44 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>
Subject: [RFC PATCH net-next 4/5] net: integrate QUIC build configuration into Kconfig and Makefile
Date: Mon, 11 Mar 2024 12:10:26 -0400
Message-ID: <f5678996612dc82c990da0dbceb19dcd062d97bd.1710173427.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710173427.git.lucien.xin@gmail.com>
References: <cover.1710173427.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces build configurations for QUIC within the networking
subsystem. The Kconfig and Makefile files in the net directory are updated
to include options and rules necessary for building QUIC protocol support.

To enable building the QUIC module, include the following configurations
in your .config file:

  CONFIG_IP_QUIC=m
  CONFIG_IP_QUIC_TEST=m

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
Signed-off-by: Pengtao He <hepengtao@xiaomi.com>
---
 net/Kconfig  | 1 +
 net/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/Kconfig b/net/Kconfig
index 3e57ccf0da27..b091b633b3e7 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -235,6 +235,7 @@ endif
 
 source "net/dccp/Kconfig"
 source "net/sctp/Kconfig"
+source "net/quic/Kconfig"
 source "net/rds/Kconfig"
 source "net/tipc/Kconfig"
 source "net/atm/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index 65bb8c72a35e..0562e72482b9 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -44,6 +44,7 @@ obj-y				+= 8021q/
 endif
 obj-$(CONFIG_IP_DCCP)		+= dccp/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_IP_QUIC)		+= quic/
 obj-$(CONFIG_RDS)		+= rds/
 obj-$(CONFIG_WIRELESS)		+= wireless/
 obj-$(CONFIG_MAC80211)		+= mac80211/
-- 
2.43.0


