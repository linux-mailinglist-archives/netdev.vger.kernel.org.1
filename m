Return-Path: <netdev+bounces-176427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36805A6A3B6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04093BB1EE
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7862220685;
	Thu, 20 Mar 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p5hn94XP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BAB21B9F5
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466705; cv=none; b=hLadR1MFNX5jopbq2WjCIAwBOMpPIRsItopdsfzQfyk5wQWj2HNPi/Ool37lSkZLam1632NFPNDhqFmNPE8nuEGfrSRkSQc/H5I0h1Y2LyzqZLGkG42SXU3LWGRVjOfKbAr3U65CC7EKqAoOzPL3S3nF1XCTZHK9x9qlEBF+Oxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466705; c=relaxed/simple;
	bh=+OW+RtgKsRJs1bzFMDq5bzw99FZCh7zsF6Y14sSOP+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZOzrd7M/CFw8uK6YIfL2tIUUBvzjge8NAJ85ZBLxiuDQt05CrVUI6crmCC6aLQDMadugpwd+kxFSvnXCdabSdf6aUhDlTsN7EmZC6qG0Go1zKFDwJlnZbFwBMcjdtnrtsr7qGNd1dZM7W7KhbSyxonuuXkUg1DAyN2Oa0XyyR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p5hn94XP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3997205e43eso459471f8f.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 03:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742466702; x=1743071502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a128zcZc5YRGP5mY1JEmfIr8nMkvTHKg1+rmTOEaIJM=;
        b=p5hn94XPe+oX33G2qekgun81c7xeOTufH+JFeuVla/KCcVwCqGKIJnYsWOWhDL/ZwC
         wQvtk+vCK49PG7LehIuO3ftVb7FoBBEmn9VUrPqX+8uJxS3X49dnvMCKkRVEIZgZ0cVy
         I911s62N+cAprBueMGzVs1KxLdDA5vZWWWZj96OFlYHek+Ai/y+ZQBLC3NrUtH6YOCba
         grmT//GRRP8uNJktWWZ9OMZ4cyktZ3vPTdkqfatm91ayqemMs2exjRFn21RFh4G5Hm6p
         60pPR3hTidKPjaSvwaTUpWSUhf+kOurLxOOf0DNJYJTjW9Mod2gXG9+4u+Eze328Nanh
         u1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466702; x=1743071502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a128zcZc5YRGP5mY1JEmfIr8nMkvTHKg1+rmTOEaIJM=;
        b=lzZwnlMAH1RdywVsPibDK1IwQOFQg4fzJtoCJr38SJz1avl+LzLkkIlGr30VXCU6tb
         ssYVdluIM7WLhF7rW7zvkmJKjMWjrvmBvmaQeyj3wYQH0fY+GBmjGylz4yfVFdPusUlJ
         ILcnjfUCUIUJdXCVrpmP6rlYpdJsZHCiISd/Kz6Rfms5ILf1fgrm9SguhYnz4acRFLKh
         +u0GxrxYtyKo0uOj8n3h+wPWIb8Mydo/ri4DiwdEALpbXjeEFAguB0o/CeSU7up8lkt3
         SvkZblK4NR5kDZ82xTsALCaSXziyIXUO0DYQRAf5pmzP2R1Qtd++uX2ex9uU9wBLx9Eu
         PtCw==
X-Gm-Message-State: AOJu0YwgUAOK73CiD8afLQ6C30dRDesv1QXRCd0Fc2BdY4gEEfO/kryY
	pBz/pwe6qsCWMpRghv+d8p7xAkpzdkQy5CQHlvtSQVpZom/q0MTmZWEgnciZIn9MiKDQoFzwNdw
	Z
X-Gm-Gg: ASbGncsdHFNN1knGHM8v/gcDokx9Ys4boCEtm7EpU44K8r7ps2ocpzFy+fFqp7pR3Gc
	LoPiOO1pGBbH8W5xMSh0+TWh01R+Js/elD75tKxyTsEGBISPMTQCEwzpssoc9J1jv3/ja2yfOqD
	HxmTn0pWvfvp9OwwgVJDlmEOVHZAcEhn1ND9CljydMNhpa7AsGCaLeJTiQp8ABs8z+Bxwfa5/+h
	pYmUpbd08+HaS+KElQaqiQmXX8cvNz5/i1LCCcErDgT2ya5S1YckCR0C/yo4KOOi0ZEAgiepbyl
	qUl2XdMIK9TnMp7kMFJJ1kJgnCuxLgGGelVMXA==
X-Google-Smtp-Source: AGHT+IE1v7xGaThgPKbQYTMecKv9zRxxwRIweegAHuM93Y3cIBFEVJRUVS/+NKrvacuFcJSUWzkE7w==
X-Received: by 2002:a5d:6daa:0:b0:391:328d:65a2 with SMTP id ffacd0b85a97d-39973afad10mr7342682f8f.38.1742466702066;
        Thu, 20 Mar 2025 03:31:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdac92sm44424175e9.26.2025.03.20.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:31:41 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	parav@nvidia.com
Subject: [PATCH net-next v2 1/4] ynl: devlink: add missing board-serial-number
Date: Thu, 20 Mar 2025 09:59:44 +0100
Message-ID: <20250320085947.103419-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320085947.103419-1-jiri@resnulli.us>
References: <20250320085947.103419-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add a missing attribute of board serial number.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..bd9726269b4f 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1868,6 +1868,7 @@ operations:
             - info-version-fixed
             - info-version-running
             - info-version-stored
+            - info-board-serial-number
       dump:
         reply: *info-get-reply
 
-- 
2.48.1


