Return-Path: <netdev+bounces-161905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5959FA2488F
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 12:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AC61889140
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 11:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E306E186E20;
	Sat,  1 Feb 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h18rCXa7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3D15B111
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738409659; cv=none; b=KSabVX9ixmF2/B2Tfhw6q+57zhSRypHJfig9pg377WCtFUkOjlQ8ccSQZ5MFwG8P2WABoz62e/5mS4DO69YkV2vydQ5RpHKIuk7JMIvmx0QbPluNNIm/MUFJSUdEBQkiNqn1MqKB+sMIkfLOKykufPrfu008nf2czzHLOolGBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738409659; c=relaxed/simple;
	bh=ATj64J7ePinHmQnjCFg+/4O5OZQrh73VR2xWGYhDYuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mr5cleQio9oSGvqosF7v+8ZjWuWuRqqxqlMjrwugN0TXXrD0tGGS+qaN/2dKAt6S2OHPny/kTy0v9eHx5rEi4hV5oNx7gvHUPAdYJkw7tyZ3D7rtBiLfC1hAMPTg5u2+r3/7SQWAcMxPr+NkmnFtZxEfKdEL5MPwiORY3O88Qs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h18rCXa7; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e2766994bso1466151a34.3
        for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 03:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738409655; x=1739014455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYarXz+1rPX5MQ983eljbZkfUj12hCqEdtN2eWPVIGE=;
        b=h18rCXa7zC4csZusZbepyLtKi3Z7b0tni/fY7jrEGexVjPfrpO3UiwJiPK231Lzd0J
         UcsRb22cYcRDj+yW1YDxd50o+W8d4pjs4mckB9JJRLTNGglvoEL05zxkuza07bf8rbGb
         mfwF7mJxQtMABFXFACbVxHwafrU15hGc45XJgBqPce1MdIyMsherGRYw9rhhG8Xnf4Yx
         QXXw2pOKQMOrd1/gQTfdL8yRmGzx7KHzFfrcxS3ypi9Y7VNLdhNpz/pdFcB3r5QLNN8s
         lyc1M6e/LoP8FcZBS9IB5PfHo5BjJa+sDb3fZk8TYkymvfSgLrdX5tcoBeU2aSrBSELl
         U/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738409655; x=1739014455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYarXz+1rPX5MQ983eljbZkfUj12hCqEdtN2eWPVIGE=;
        b=Xwwvnc8QPly++I6+Pk7it/inKciNwz3kuBKrfU2IrNIMMdQfDywhh6uY1NMJfPtiWS
         75nyH0NTC4uUQEV/Duxp/ADIqufJYTkZL6VRNVpJfSbDRO2sNa54HxJmNRa9BFhicO1z
         vLwGQHVkhbPWbgCfgcR/duJUXkGVLviRYKScBSqV2IgjOSTRaV2oKzCHMXfu6rw1zWeQ
         Lfa+9NadoK/6h6H8NVouSJHen9g8A3EF69A/kXGI7WGMwW4RTuqacWKIwo3nrmuCHSlu
         h3WJqiGsr1XLl61l9idSYMlqvho/iCKmTC46Zwzry9dhoUdGBXFk2b3PWK7QLIsUnEBN
         6l/A==
X-Gm-Message-State: AOJu0YyjJUTj9XD4lcGVNH/ClmXSO2uPoOLojioJ1ROppYaJqRjv9HGJ
	2DSL/y5gHNp7cfmwM1bvOnRFFphqtBa64Tcve+wb0JJ3OK9FpBw=
X-Gm-Gg: ASbGncsBzXCwUL467or+PUh5eCXDOW5oLqapTeDuy8UY3vRdtJTDIEAQgni0njzV9c2
	4Zuaiz4YOrQza3W14widjKut771jQXpxRYdwN4CxobXCI4bhi8BX6NjpghKq1pisHqFd8i5bX2r
	HsWTrE0GOgST+07Bx+skO+6bW9z+5MmxR6Jz1z+QSUf7ifSp8AfeZzItBon7bPwagYxv7xbMKGE
	/xQQxYlF+v7GtTZSBxVKjoaeAFcLgRlxB5q1rO7gG3BNdbicDG6NyNEB58NugqR3X/3iQOOrzi7
	ocaMA2bC0muZFfJ7NQ==
X-Google-Smtp-Source: AGHT+IFSUaTIr8LCiItRi0dy93IEp9DMWvVOP8ffMiU+J4GhZfVFcLu56BLQ96mxFva53YLNYpIqmA==
X-Received: by 2002:a05:6871:788c:b0:296:b0d8:9025 with SMTP id 586e51a60fabf-2b32f1f8dd2mr8892510fac.20.1738409655369;
        Sat, 01 Feb 2025 03:34:15 -0800 (PST)
Received: from ted-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b3565b8120sm1837174fac.34.2025.02.01.03.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 03:34:14 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>
Subject: [PATCH RFC net-next 2/3] vxlan: Do not treat vxlan dev as used when unicast remote_ip mismatches
Date: Sat,  1 Feb 2025 19:34:12 +0800
Message-Id: <20250201113412.107832-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201113207.107798-1-znscnchen@gmail.com>
References: <20250201113207.107798-1-znscnchen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not treat a vxlan_dev as used if the vxlan to be configured shares the
same vni as an existing vxlan_dev but has a different unicast remote_ip.

This enables multiple vxlan devices with distinct unicast remote_ips to be
bound to a single vni.

Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3ca74a97c44f..5ef40ac816cc 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3723,6 +3723,10 @@ int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
 		} else if (tmp->cfg.vni != vni) {
 			continue;
 		}
+		if (!vxlan_addr_any(&conf->remote_ip) &&
+		    !vxlan_addr_multicast(&conf->remote_ip) &&
+		    !vxlan_addr_equal(&tmp->cfg.remote_ip, &conf->remote_ip))
+			continue;
 		if (tmp->cfg.dst_port != conf->dst_port)
 			continue;
 		if ((tmp->cfg.flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)) !=
-- 
2.39.2


