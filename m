Return-Path: <netdev+bounces-293429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCbwAnE8HGrsLgkAu9opvQ
	(envelope-from <netdev+bounces-293429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:49:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6219C616701
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA493040204
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C92D30E0E9;
	Sun, 31 May 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlOlmu+I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT3PYXI9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA790239E75
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780235330; cv=none; b=btAMCBtrWDGKXokqu6GeT1yuxtAHjXPBfNq4+zOm9XZpwZB0cQnu4n2KtpfJ/otlYLGs3Em/CA/IXEX+O/ZSW5+vLKWVqqFqb2PsSonAJK0PfzctNgAApKEGEuH3cBTaa0D3Th+kEOCD/aaFgFXVizBU/ILYmGHrWHnsQiNAmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780235330; c=relaxed/simple;
	bh=b3FOszVHkVm8U2qHIemMz8yWcVhXu0hqK5FQeA6pLFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+vEZQ56shJLSA6LARVr+uWIoX/HGP+E7/ukECO6kzheE15d9WkMdF8jbiFCn3gOUtgVdIRBPfFdbFrssp8hmr2XmswZ8tX2aKCail/G3wFa4xMN3FPMC4jmjMDezfZCj4uYCX96uj/+QhMXTvWAFnqNAZNqwPb2BM3OwnnPEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlOlmu+I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JT3PYXI9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780235327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NvsWgm5Zh3KY7uwAkRP+5UVl3cDUtJxbowpLE3/21Nk=;
	b=hlOlmu+Idme+M/JicBbHPg6XWthF9yq0yo/Es36QH1yKDehX4iodaPvtTVsTutTMfUr+3o
	3+CBPAv6L1NVItoYlnYy18vXA8oud3TvKkJ+uHKXi81WAxg5pZ9pIPavN7SjrZYOHnSPZO
	CRYkcZwgo68dURrVJC69iYJg5BTNV6U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-QGw9KPG4M2-g_wTEkB20eg-1; Sun, 31 May 2026 09:48:45 -0400
X-MC-Unique: QGw9KPG4M2-g_wTEkB20eg-1
X-Mimecast-MFC-AGG-ID: QGw9KPG4M2-g_wTEkB20eg_1780235324
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef5e38a18so856113f8f.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780235324; x=1780840124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvsWgm5Zh3KY7uwAkRP+5UVl3cDUtJxbowpLE3/21Nk=;
        b=JT3PYXI9qm40ZaLWWB7cogXvHv7uLWABv7lTaVAIkkmEiCZ+HI4AFSt216lbC1M6pY
         872M+/T3OF3OXAA+0tpkaEs2Q7nlzAd2PDH7VXzrwhf30ZNVvaHxOt2+b894kbFtq+Id
         OKnCiC0Esbjn62SrXi6Syjm+EQYYEKWK2VSsaaZzeQ0GmNDr4gGn/P/0MdXqJ3zCWL4/
         edsARB2v2dlaBkZ2hO5sJil7UcYw4q8REi9vs3PfNpr/5RoCdzsS8LKzrdc2dxJE/aFA
         6kiCVmcky9HLsHPl9Y2elkbkh/0x0ZY7g2BNWsV8LI/+6FaUcJ850VH1X2aG2Jidqg8K
         qMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780235324; x=1780840124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvsWgm5Zh3KY7uwAkRP+5UVl3cDUtJxbowpLE3/21Nk=;
        b=d/6pR6jT3pxl9ny1XKs9VOiYkVYHahP0Cj3WgCDW82JtVyAwhszff90hCLePW+w31b
         F7ayIgBkOsiFRkOwyjXiaxsoURQr1SyJpVudfvVR7NOTzCylJ3yNCDbT2i58ynd8Zs9L
         tkJiTJCfpn/uhubFwGQVik10ctWZW7u4+MnzF1JbFTjZO9Zr3Phss2Hn137bG1UGfo8Q
         D7PjbHXk5hRlK9gIkIBKrAdN2q8xBxx4tyL8LfkLv9pX/d816Di/DyADTaErolUncopf
         orXaeD+tWm6cBu4eNctEvq043AZZ7eWf3tH7Q2TogasnLl6UC4E+p/QKSKdmUQKGk6rG
         NGuA==
X-Forwarded-Encrypted: i=1; AFNElJ/g+JpNpcJsTUqsX9Js3s5G8uR+nJSjGFTbn47aJHwNrje/Y5yHEWdi2AkewCiVZ0+fgvZWsak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQg+tzzclP/R/Q30vtU7jwxzJnz2QdMo2W60nduZ1sNHs87x9
	6zxIUTuQQK4Em6smgflN12FrUsiw7A2/DcXYL8vtD6uQ9rG0ffCmEtNuO+0ZkfeKLJVKpMzjIN8
	EKxLooKf7GaPggTVMhCX1L/SmI5Dh/E1wEpNc5QGSu/vkEcgNf1b7xOzU3A==
X-Gm-Gg: Acq92OGAcQ29H03Q5DeA0OJFk9tEDfdo8rnoaYDzQl+WXGIBO0FUtNJzFZCUOjHbqSH
	OHmH/o1kdlxcGrjBP7fsQiX3bWdbFHcAsQwQ0Kimw8cmsUv1AtXeWIsoKLv1Nf/s2YBLrhUySSM
	thCMqu4h03CyEYrmA5KOMeRuGNKudxZyA65zUt6JPOmu36WowhzYfBrk3OrDMQGaWR+ldjj4AuT
	YhnOs8/nm8CaXQ/8n8vb2VVJR7a0Iz9F/1PHaLK9p3sYVUo9p7HbkKdH/c3xOxp508WH2WO4mZs
	OLhspJNlZtALJLfzlWcVYxU6mFwcv0QnHVcn6q0eyG60Z46nMMlKVpUlYTgzt33UCb6OLrpSqdE
	bj3l1Ymm2SjpmY1EyCvJ9Wj8ugdmQVvx2v+a+c7ucf2r3WQ==
X-Received: by 2002:a05:6000:4b02:b0:45f:1bd:a053 with SMTP id ffacd0b85a97d-45f01bda1famr9554775f8f.1.1780235324329;
        Sun, 31 May 2026 06:48:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4b02:b0:45f:1bd:a053 with SMTP id ffacd0b85a97d-45f01bda1famr9554745f8f.1.1780235323939;
        Sun, 31 May 2026 06:48:43 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a090dsm17549086f8f.3.2026.05.31.06.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 06:48:43 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] net: Remove orphaned ax25_ptr references
Date: Sun, 31 May 2026 16:48:36 +0300
Message-ID: <20260531134837.4111349-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293429-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[costa.shul@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6219C616701
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The AX.25 subsystem was removed in commit dd8d4bc28ad7
("net: remove ax25 and amateur radio (hamradio) subsystem"),
which removed the ax25_ptr field from struct net_device but
left behind the kdoc comment and documentation.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/networking/net_cachelines/net_device.rst | 1 -
 include/linux/netdevice.h                              | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 7b3392553fd6..eb2e6851c6f6 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -91,7 +91,6 @@ struct vlan_info*                   vlan_info
 struct dsa_port*                    dsa_ptr
 struct tipc_bearer*                 tipc_ptr
 void*                               atalk_ptr
-void*                               ax25_ptr
 struct wireless_dev*                ieee80211_ptr
 struct wpan_dev*                    ieee802154_ptr
 struct mpls_dev*                    mpls_ptr
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index beed64b8d93f..460350a7f77a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1947,7 +1947,6 @@ enum netdev_reg_state {
  *	@atalk_ptr:	AppleTalk link
  *	@ip_ptr:	IPv4 specific data
  *	@ip6_ptr:	IPv6 specific data
- *	@ax25_ptr:	AX.25 specific data
  *	@ieee80211_ptr:	IEEE 802.11 specific data, assign before registering
  *	@ieee802154_ptr: IEEE 802.15.4 low-rate Wireless Personal Area Network
  *			 device struct
-- 
2.53.0


