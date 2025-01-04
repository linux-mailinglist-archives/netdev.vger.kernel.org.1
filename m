Return-Path: <netdev+bounces-155138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1BA0134C
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDD93A4292
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF514D29D;
	Sat,  4 Jan 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsBl0GFm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E914A4C7
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735979962; cv=none; b=SqFZddjSVQzycNLkJ57ZBOfkshoDTZaZ97+DrBZRcrRzG9lJAdqQXaL3eu4NXgCpQj26QAmLQCXVfpHTS166qAuWsxCElmWI67P9TlZIWijqcLFO+FUT0WE/bkG/ue2ZzZFDjiPczWfD2jEjlhoPTmerhIAyqbdyhkjO48CShJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735979962; c=relaxed/simple;
	bh=NXan8oxIYy/ZmaOV0exlIOxUNFHEgCAh9/q/86ZqEQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o8Ly+l+TmKUY1/SVHk03pbz5c2jIVBfq31PWob2JxaEqnwNYjfMPYIV7K9LTPVdK356ZWANHizn5HCgDE09Vr6eT/HwNX1IJC2LRku1VKhFI6rP0UvaygeHY80nUZu+KVmj/y0PDD+2F5uQQyv+9lu+9P7wiIG07gt38OIpV81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsBl0GFm; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71df1f45b0cso6332166a34.1
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735979959; x=1736584759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ms578HFiFMJZleG0QpTq+Vnu+FBkWfD/5q38w3RYJo=;
        b=WsBl0GFmezuasKVDQJFqtFr24RZnLxGiS6e7S52aHblPyk94mCNICA8NVtdjBI7mIn
         szSNQAKv/t+rm+qoIqDbj/2wI6X3v4OZQvOt6rsNVtetr8fqUKkIg9vTOegbvfIwii1c
         zE8yu6VSYHG/Nk9FkpaTQdpWogXIjNg/mIx9ewSxfR/FSV139wD34po0LC5AeL6bE2QT
         3a7Tm+S6g71S1PIjXYcLlSTS3ERlarfPQpT8D/68cw0gP57uQ+z4yZAtlYsalj80T61I
         pJvX/6bciXVoZm30fCuNrW78PVLjfBN/ByEMzjzUcSFHd42F53zovOYRT8WfoahvdPFr
         epXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735979959; x=1736584759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ms578HFiFMJZleG0QpTq+Vnu+FBkWfD/5q38w3RYJo=;
        b=OAPGmHiDCqw9YPQ61l1pFwyY2sWaE74BMFQ8RHr4Y2qddMAdW32Vk0cBGaSN+VUFys
         O8Vo6TPqSWEiyz234IfkjCHiyxSG8M8PCo9nqP1yJa0Ji7lRTz9TeqFzmNdwl6xv1RfO
         /I58tf9DgH39XGcqK54u9nZQkLUf7lPt8F2L557X/JsQF7p8t8fAHd/qWh23lILMeTaT
         B+xDCPBGVRRVxiXM700DeolHFakSjbfVQRGPnpn8ME4mMXgxorGZl4pXbFzxv0OG1eFd
         QbctDRLUefuiPAfEp8eIj7pmWZdzA0UGptONGAflAa4so7SrGaRHR2+t9LZGfdI/dEIh
         5Fxw==
X-Forwarded-Encrypted: i=1; AJvYcCUaZ3sgxYDb+QShtR9Z/Kww6VTmtKBSY9S5NBgBK4FpyjJi2OFCBkV+0l8KGjH9kMBtXWCfIkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZytNcPOpDRqK8u7tMrGDx/DBA1Hz3NRckYRM7Og5qsG2EJvZ+
	q3wxl5VgucmRuXRudEx063CN7uSHdgmlGfSSHH5ONkgSnlg3eWk=
X-Gm-Gg: ASbGncv7h26swAU2CKLLHig5XoFEacHeP/ux2wfyVlsGx6euY4HypJATODCzjCAkcez
	2/N/UksbiQv573U+7ncXJirjOtUdQxBeOb7MGXyeoq8TxQ2ZIEc87uJ5WACaXaSYy+WY0QkRQaU
	jZVw+KrMf4QEyVg2B9wKP8WIXWjPqJmgUUzlsetpSeR5sWq7nDqLkUtDDBflCk1KyT43IXPddYE
	vmD2GTmlt4bT+UD4jimiBnE6X7eOmw3HA5ZHMbF9oUel+MLg7N+CseeqFY=
X-Google-Smtp-Source: AGHT+IE/5GwGUtvKwqDS7wa3/g82WNA44zDDcQRhUiRtgY4gcX9Y36mSnYtthXDEmg6XMg1KFXCvZQ==
X-Received: by 2002:a05:6870:b28c:b0:29e:7629:1466 with SMTP id 586e51a60fabf-2a7d113f93amr29344927fac.7.1735979959636;
        Sat, 04 Jan 2025 00:39:19 -0800 (PST)
Received: from ted-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77f0a69sm10305427fac.45.2025.01.04.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 00:39:19 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>
Subject: [PATCH net-next v2] bridge: Make br_is_nd_neigh_msg() accept pointer to "const struct sk_buff"
Date: Sat,  4 Jan 2025 16:38:46 +0800
Message-Id: <20250104083846.71612-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as
const.

Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
v2:
- Rebased to net-next (Nicolay)
- Wrapped commit message lines to be within 75 characters. (Nicolay)
- Added net-next to patch subject. (Nicolay)

v1:
https://lore.kernel.org/all/20250103070900.70014-1-znscnchen@gmail.com
---
 net/bridge/br_arp_nd_proxy.c | 2 +-
 net/bridge/br_private.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index c7869a286df4..115a23054a58 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -229,7 +229,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
-struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *msg)
+struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
 {
 	struct nd_msg *m;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 29d6ec45cf41..1054b8a88edc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2299,6 +2299,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			      u16 vid, struct net_bridge_port *p);
 void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
-struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
+struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
 bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
 #endif
-- 
2.39.2


