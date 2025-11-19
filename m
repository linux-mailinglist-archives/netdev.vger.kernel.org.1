Return-Path: <netdev+bounces-239863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D777BC6D3F1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B43E4F64E7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020543254BB;
	Wed, 19 Nov 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVT9wFUK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC43254A5
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538575; cv=none; b=m1bfSxs+mcwmpbqF+uuaVWNspQU+MeU5gAn7Nm+oJJ18Rkek3AuSAldGyn8WGLw5Hcrhd8soCdWf68Q2+b2qqpAZ0nxx6IolP866EbQby9hghALENC9TMjBqF2Vmugopvq10d0gl8zHYHPJj+SaxhUObqTG5oVqazIO5GNjaoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538575; c=relaxed/simple;
	bh=b8FscmmisLfC2hrZ743eM0Q8mvR5xh9F7WYVK3EV1tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTkS7M1IY7AH06F8MzN4ikP9kyhEtin56fhY/SBWgLONP94i/dxFejOPjWnDdkYjJedvSitgCl2PaYwshHm4ENC3AUT7guGkM2ftY3nBg2KIwCgcvkayCngLiD0syfb/3jaBC/YwjsU1QX4s4BeBaMxdRmHBePnc3XrjOnTIRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVT9wFUK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42bb288c17bso2338588f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763538572; x=1764143372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TImvYlNnQRMa8IRvJ9GWsrXwTK0Q8nmLpVv9SLrtH8=;
        b=GVT9wFUKcZnxOaXMo+JgG5fXyDxf5v0pPsOoc8E5WRFhLkKzjJmLZoRIou+Hc2eGUW
         Xs8EXfgW1oPqw7Q6NUhMjWidfRFQcMvbFcz46aK64zyUDzBiCtLU8IBqPs25owz34cJN
         gE0ORa2jzr1MU+J1pZRORitYG+vHzS3NT3vZID0EhVrb+QL4/Jlu+wsfsJkXmA3r4Rla
         16Mzlqczbf0qjdVOLeV9p0HXHd3Fdthp9PcBrIpRLclrxLOwgBt31bgohxf414oGx6VS
         lgJwtjgB9PKp3KKO4hgPfRuyiTRpkGdsyB5XLS+6cZYj9eG8hvo7TSWb82IX+IoD5VFi
         XV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538572; x=1764143372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6TImvYlNnQRMa8IRvJ9GWsrXwTK0Q8nmLpVv9SLrtH8=;
        b=Z+CwUozVE+Z/J0zbNOAaT5t763iIiOggp3XtJOE4K/AZ6paDR8KGNMFQWszUTJz/fq
         frnMEgv3FqMYd0D8mJEU4y289ItBCkciJMa5cvFe4O+C2S97Le/q0NK/fQNx3RZv71Ws
         UeJcM2RSoS/naM0vERFnlTCmtjxfKeNn/xWH+btI5XL0zPhv3WDXNfpyvs6sUy+5Q20q
         0b5S5R7vxz1i3I6W+IOGZat9yiNk9HXR217+2pbrhETnwV8vr1WVt7G+NR4LFNVouHTA
         5PMnz/5dLu8l4MooEOoNdANuoXr2PNYROlg1/P8pb/BNwss4SlaeTeZNQ6s/NoJUZf3w
         C00w==
X-Gm-Message-State: AOJu0YxQYRRUncdSpoYu5uRKHgEO/rNoGfgvCU5jRdnCQl2gLeoDEo47
	l9c9d7fOP/FA4+IyuklS+dwkDe7BrHTgWmdxpmkK7jQ83cHgzxMUGcFv
X-Gm-Gg: ASbGncuLOWHXJwSW4SJLbCTVdOqtu90hWhw2p0GXCVFr25rZbeFdUSd2qrs6LClP5M1
	O+aTpQkHY3CDUkTnW5CH9U9DUFeC98LHevDjirWRN8B5V2O5uSgmaRwqfG0C57wrQGkXsrX5Foy
	weeOv2eAYLhRtAPh/lrZGS+ULZYzUXWy4Hu3E/MY9tvci5EkwLXhNodUb2/qDYnBuzduOIeTHKE
	F6K+pz5llh6WA8LD2SsmapwhyxCtqlfvabVbrZ8+pijaEJhxsOrIyNje25vI9iMQLRjUdeL/Nt/
	YIAspaZKZ1mla6VB2McBEIswK5qcEBW6nYrFjfPEtZZifkrCDLbhj/VXj3gGA5pSKu1PUGp98rA
	XxVe1Zr45BcEzWiyhCvEG8u6oTML0qNNICXpgJJdJUnex43tOSJYXGmaeAHrV0Z4ds57P2zj5hU
	9pNj4HMeF199xs9/0=
X-Google-Smtp-Source: AGHT+IExKSEYuSjTPblU2hxyhKKajyovUPxWOzaGhBnrkrN3rrrRZSJw3ztuShNlULzBNBuZEh/Fkg==
X-Received: by 2002:a05:6000:2913:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-42b593234camr20195873f8f.2.1763538571920;
        Tue, 18 Nov 2025 23:49:31 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37461146f8f.19.2025.11.18.23.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:49:31 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 19 Nov 2025 07:49:21 +0000
Subject: [PATCH net-next v5 3/5] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netcons-retrigger-v5-3-2c7dda6055d6@gmail.com>
References: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
In-Reply-To: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763538567; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=NaSr0aRo/KeIcHaXa24IkgHFUS2s0iyQ6sB/nOVkiyQ=;
 b=AfPaO140aeo7SeI9ECUWkGDzjLBwWiPAMfF6RVgFJC1p1ZvjcQ19wWNMVrRxj6cSX6acWoOQv
 t3krehSGJUFBLOPFXulnjSaBrIAZxriN8GXhpXcygPCr3NFSN1vyOH4
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.

Devices (de)enslaving are marked STATE_DISABLED to prevent automatically
resuming as enslaved interfaces cannot have netconsole enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2d15f7ab7235..81641070e8e2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -120,6 +120,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -575,6 +576,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1460,10 +1469,19 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				break;
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
-			case NETDEV_UNREGISTER:
+				/* transition target to DISABLED instead of
+				 * DEACTIVATED when (de)enslaving devices as
+				 * their targets should not be automatically
+				 * resumed when the interface is brought up.
+				 */
 				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
+				break;
+			case NETDEV_UNREGISTER:
+				nt->state = STATE_DEACTIVATED;
+				list_move(&nt->list, &target_cleanup_list);
+				stopped = true;
 			}
 		}
 		netconsole_target_put(nt);

-- 
2.52.0


