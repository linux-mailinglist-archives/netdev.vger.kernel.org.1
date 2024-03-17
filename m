Return-Path: <netdev+bounces-80262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980D787DDF1
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 16:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119D32813AE
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 15:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858D1C6B0;
	Sun, 17 Mar 2024 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="t/ohHseF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF21BC3E
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689308; cv=none; b=Wji0VUek2xDS2SfoNtI2na/F7WezBYfZEcH71AzZ4S2XvZ33JnifLRs4TQcy7RsUMy8+8mSbV1dzc3x56W6Tgwxhw+/g26edCVJFx4dOI9swgYnjybl9rw9RJzv3fvQ0DfzCpFZJZ0sAXArPvElf9M1XaTDKBeeIGucOtvto5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689308; c=relaxed/simple;
	bh=YIaaaBBgvwlXSX20zYsNlwMvqtEmC/57EJQW5lqAUr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUHCj+aIH6hL/ocDNJVTsKQL083Yj+HPSx9Siq7nm+56kM/8PoZQO5BUU1RyVn6QH2Hl1EyAfwTwmM3O8lx7hqGzvuYlcWSFlhkU/els+kX7fDm3DBZEDagedcam8gkY0FFd5jnzzkOXmusc21VoQspZfZjNyCRNxoATy1DmCsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=t/ohHseF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-414109de4a1so477815e9.0
        for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710689305; x=1711294105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwgcjp0weLNxp98CRwtASrSw9liqeX/V6E5QJd63HBY=;
        b=t/ohHseFbgKZq5mJ+QwNKYqQNR8fBfHVh7UIZYSDfMrz3w+BZ/P2nSq+iakUdoAFWN
         xYQqOJPWBnt72iaFc4S3A537TJG1YTNq4n5LHnwo0SbIFnPLEZPLt5pvBd4B2kOP4qMs
         DTOA+btiRvC1AW3DUdb0/wNwQVv+AjUBkDqiC5j261B+CLrP7ORuN4lSC7TG3Yp743Xr
         mQd1WGRgzAFqnnrBvAp1gx9oOcPvL0Vp5nhhYqOaotK01fJTaXDDUW6pxJwLhK8tIVu0
         /kwiKZt8yuazctHDu9YNjtKK66gLo8PNHH6bbVGtLThIMQrECZ+2fC58seqcSioRnZxq
         3EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710689305; x=1711294105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwgcjp0weLNxp98CRwtASrSw9liqeX/V6E5QJd63HBY=;
        b=cA1nYS58nykfdWeome3NjeRB53t7H1NOVXhnnQfqXEHfvODvjer7+XHZXuMt4Uuvpa
         66Gk4dPqW8bAagEKAIi45rVxZc2c7+MLb5b3R/+nk00RwmaaD0MqpPC4S6sAXK/Djl2d
         y6sUoenUR+3No4F8uY5a58h9yQv3oOmCrXJWkcG6d51zPOsJo/E5ZrKUhLPvMWrfXHRl
         TovlKsdbCzR+g9kMuJdDf7nrIZVaJb3CB6h31ZDABZvtTEFFHrVxKl1oariZuDFkucnR
         rKv4+1LV3J4bX/FDFJgpUIVTw1g6/GTvEmHvyHhmksNQncaJF5Mb+8ghQetaZrEKK//W
         emdw==
X-Forwarded-Encrypted: i=1; AJvYcCWuaynBFjgOoOu0vlMv9OxZ9IjKqnfAfYj6YoxFMA4H0HXgNl7gUT3e92IxzwVRQImC4x2KsjZop9NpA8TCS0ee0zte2m5p
X-Gm-Message-State: AOJu0Yw5doHxPyZ916UM6cKiVDiXtw0BU8YmByL3aX+XwS6t+ld3JsuA
	haSLXIOJlt7cs+NqwyW/A6zEw7hoHkUbxSei8bExrdfeij1NDEiNiWfleQIpoeU=
X-Google-Smtp-Source: AGHT+IGMuH5PGta5RX7cF19pcwqvZj3InDGy1xP8Uiy9LWzR13NMZTSxnRYyZv2KKWCw+F0Uq+m2YQ==
X-Received: by 2002:adf:f884:0:b0:33e:c0c5:1799 with SMTP id u4-20020adff884000000b0033ec0c51799mr7120068wrp.45.1710689304903;
        Sun, 17 Mar 2024 08:28:24 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id az1-20020adfe181000000b0033ed7181fd1sm4763862wrb.62.2024.03.17.08.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 08:28:24 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ice: Remove newlines in NL_SET_ERR_MSG_MOD
Date: Sun, 17 Mar 2024 16:27:57 +0100
Message-ID: <20240317152756.1666-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warnings reported by newline_in_nl_msg.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 65be56f2af9e..ebece68d1b23 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -464,17 +464,17 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
 		if (ice_is_eswitch_mode_switchdev(pf)) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Go to legacy mode before doing reinit\n");
+					   "Go to legacy mode before doing reinit");
 			return -EOPNOTSUPP;
 		}
 		if (ice_is_adq_active(pf)) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Turn off ADQ before doing reinit\n");
+					   "Turn off ADQ before doing reinit");
 			return -EOPNOTSUPP;
 		}
 		if (ice_has_vfs(pf)) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Remove all VFs before doing reinit\n");
+					   "Remove all VFs before doing reinit");
 			return -EOPNOTSUPP;
 		}
 		ice_unload(pf);
-- 
2.44.0


