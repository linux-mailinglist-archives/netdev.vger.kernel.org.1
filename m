Return-Path: <netdev+bounces-239471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8814CC689E3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5A5502AA61
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0432573B;
	Tue, 18 Nov 2025 09:45:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D4325704
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459110; cv=none; b=V8Q+aYs2hWYkGGMddWmfBP5JO/wgtlgEelFkadmcda4fgaiDlSNcJZn7E+Tfxd05U5+CkS2uHjqUcALxvAAiFUCYvhQaEybOpVotp1F4XbkboGI+ZURwiXxrovxvUqZgcXsoSNAOX0jPytzo03kF/9TWAjZlVjefgG7tna0VEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459110; c=relaxed/simple;
	bh=s1BMpFDktgmZz1QYM2zLBfUSrIIsdKv/b3E9kSp9X4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MwH7rTbGNdo45smA7fqJyHPsmXOkOebYNjL5Bs4xxisKbs5mrXsI01AZChB2gJTTJdtfElqpdGWpMftLl58fzg6MrvtkolqJDJQ7soUd4GmKE2Efkal2gdCXFB3WQwoZ0x79E4ZvOikg34fM0Wc6PyA71OEEfzujYARs7I7tUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c75387bb27so870658a34.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763459107; x=1764063907;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEqiAfhejULIq7AeszpWEVxYz/7fly7wkHF1NCGerrI=;
        b=dYE4U8+ON6cGiiJ6c0V8ByJbH+UGsp2/TMmDSYmiWqg7uWw4FQ7aZy2SD6rygKFkaT
         sEWEIgUiyVbc1d2u0pJr96mWGbwN0H3AWthjfhyNJpXRWJsk+HRbeh+x2vgmqIKh8pf1
         FHrvGywxh+IqTFp5l954Tr+gWQnngps13u8LiYJqxrCLyjXVQdYVWHyd6EZmwTv/dsg1
         oMl48jpPL2SwhcpnKgC6ZwnoZ1H08UmjS7Glzb5Het0WtxLiRLdJlNIXn2tvv7XBiS9/
         QW01amv3KQzrLA93QpmzIcki6EYXZ1UbgijdBzR2+69VDXC7dwe8Fe19eoyDjb0jFJMV
         uT/g==
X-Gm-Message-State: AOJu0Yz/mxibyJdx7KO4g3Hoe43xHfAfh4EUAoewgOG6LBrdSU9Mt3DO
	nBhlfmn/3QE6QtL4pqppRgJEyBJdfnCI+zrWdCSiH1nLueDf5lnNGhy201oPPR12
X-Gm-Gg: ASbGncv0qTPZKlNSEnPXDn5LcPjdPk5QSL9oPz09zqQbMkjKr3PMYBo0ebxIouAKmqZ
	doEKq6csfOzVqolDwsu0YfDS9Dl95dIK6LZJRnGLj+LiviDUScBmklM0/GkfeQjAjQdeoty9Qwp
	i1XwM/M89C+D5QhRxiREYUrx9y7/KKr4aRsDJ9jG6uHoWrNgC3Jo1ata5V1v1c4KY+0jqo9Q7Hx
	K8UjabzTwM+enyV3Lb01IC8d9JFq9ZVhNrF2s/dDwo9qzWvG1v9TWKdoCpzs/wpW38+/TLb7/Ej
	dPx7Th7+MpK46hkrxfu5rY8LdtW/MOrnCmxw3s/oApSAMaMRv3NBmHHZW7DnmZWj6OCYn/0SyPU
	cB2ZPBzxMLBcLMmgn39oXONIxDKEKaAYXxocvjCuHn1VO/vyLmVeSxP4zhWjw09V/92OPlNO5EL
	SfQjY=
X-Google-Smtp-Source: AGHT+IFcvyWv+gPFEikWeC+1OA77TExWgSa2A4nRhXG+RmBX/vB/apO4zRsF0+nH+vIw1Gtvys+kZA==
X-Received: by 2002:a05:6830:40c4:b0:7ab:e111:1a57 with SMTP id 46e09a7af769-7c74455634emr9923987a34.31.1763459107359;
        Tue, 18 Nov 2025 01:45:07 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a3be41csm6481914a34.29.2025.11.18.01.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:45:06 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 18 Nov 2025 01:44:56 -0800
Subject: [PATCH net-next] net: vmxnet3: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-vmxnet3_grxrings-v1-1-ed8abddd2d52@debian.org>
X-B4-Tracking: v=1; b=H4sIABdAHGkC/x3MUQrCMAwG4KuE/3kFs62ivYqIuC3WPBglLaMwd
 ndh3wG+DUVcpSDRBpdVi34NibgjzO+nZQm6IBH6Ux+Z+RLWTzOpwyN7c7VcQhyu08jTLOcxoiP
 8XF7ajvIGkxpMWsV93/9dO4aZbAAAAA==
X-Change-ID: 20251118-vmxnet3_grxrings-539b41bce645
To: Ronak Doshi <ronak.doshi@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=leitao@debian.org;
 h=from:subject:message-id; bh=s1BMpFDktgmZz1QYM2zLBfUSrIIsdKv/b3E9kSp9X4E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpHEAii/7ZxLpQiVwyyuy8W3hVOYPT9WSAyDPAj
 KtdrLC9sASJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaRxAIgAKCRA1o5Of/Hh3
 bdw6D/sFSJ4HSLABOA1bA8MZ8HyvQ/OeF7Jy+DbEx9K9XkZOrHDU2G7K3U9TD2nth5bvx5QyYly
 d4T3TqDEhnrr4RNvN4PQz7i4mPDd+IxGNxsu7jcrL9P/Tc+s8vrwh5GMz3VAnAq15ZyGM9zD/Ww
 LKYhBltQliYjB2CUVWbPpjnHNqp0QeUyIvzncgjLjX9roAHy1IQGFAizqVy8rTI0PJMI64iBPcM
 Qts9c0pCP4cULTA/et1E5e3jgF7464PBf0P00Z4BcqNncY8Kw7xxmlS2EU5ldYzKI0jhcOhBZgk
 hLgqjIDd4z4aoeWjxpvzwkdiKDWXxAj5K51BkNjmJssGHoNejPbDDWQOk0ttmRzyOH5qattIHhv
 WjbYL6QkG85yXuWCPXFH9/+4Xmq7XedMZXvthyUeooAFsq70lAmyU/qdPjF9SDu0HvBlT6UMwuH
 KbK6LeTOrhyssEPJRY5g8Knv7etFlpsYYgg5jGRL77Maf+TwLIrORw/AlSTIyRGA3gyDaHbZoJF
 iA/5j1uavPm+EW8T+RYT+nta4UUOxIbi7toF4cL7IlbzMlcpBOnr18n1VJN5754mfk9ZIy3ehFw
 ett6EiiSpQTSCCmFjkLCj46m+KGGQKYXXpegHDBubwo80O6O1NgqbPFDqPuSZGCkVl1Q3aHAoIU
 2n2aff3n4B9jcJQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the vmxnet3 driver to use the new .get_rx_ring_count ethtool
operation instead of implementing .get_rxnfc solely for handling
ETHTOOL_GRXRINGS command. This simplifies the code by removing the
switch statement and replacing it with a direct return of the queue
count.

The new callback provides the same functionality in a more direct way,
following the ongoing ethtool API modernization.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Note: This was compile-tested only.
---
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index cc4d7573839d..a14d0ad978e1 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -1081,23 +1081,11 @@ vmxnet3_set_rss_hash_opt(struct net_device *netdev,
 	return 0;
 }
 
-static int
-vmxnet3_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info,
-		  u32 *rules)
+static u32 vmxnet3_get_rx_ring_count(struct net_device *netdev)
 {
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
-	int err = 0;
-
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = adapter->num_rx_queues;
-		break;
-	default:
-		err = -EOPNOTSUPP;
-		break;
-	}
 
-	return err;
+	return adapter->num_rx_queues;
 }
 
 #ifdef VMXNET3_RSS
@@ -1335,7 +1323,7 @@ static const struct ethtool_ops vmxnet3_ethtool_ops = {
 	.get_ethtool_stats = vmxnet3_get_ethtool_stats,
 	.get_ringparam     = vmxnet3_get_ringparam,
 	.set_ringparam     = vmxnet3_set_ringparam,
-	.get_rxnfc         = vmxnet3_get_rxnfc,
+	.get_rx_ring_count = vmxnet3_get_rx_ring_count,
 #ifdef VMXNET3_RSS
 	.get_rxfh_indir_size = vmxnet3_get_rss_indir_size,
 	.get_rxfh          = vmxnet3_get_rss,

---
base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
change-id: 20251118-vmxnet3_grxrings-539b41bce645

Best regards,
--  
Breno Leitao <leitao@debian.org>


