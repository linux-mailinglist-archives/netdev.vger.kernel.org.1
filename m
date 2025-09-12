Return-Path: <netdev+bounces-222501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FBB5488D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A7D16D3FF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46D288CA6;
	Fri, 12 Sep 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtEGVVDs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423D27B356
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671186; cv=none; b=nVSlFWTyde33WqliMusPGP7vJT0e8sdCCOCqJIU1eqMw6zFf2b3/VuKAOdE7I6nL9ntK40Pgd5gkg8rRmA+Bb4GCp94VfbOerYLh6MYWEJWlJZHIS7mWJCMyQnN8WS0EX2urPxQwlNNWpy5bCMK974Aco+6rCxLAT3ToV8IwBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671186; c=relaxed/simple;
	bh=lTfgKImhQNfN6u2BxK6SF4NKf7soc+1lwEKH6F0tn1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/DBtXOHRn7qTWsUdResZVZNZi76apwJOMmA+xNzfVCem6nSRHBohnzJzRF5eEIyyQvmqS9EePd957danr6su4p0fpopfEnHrrtLNNEVzqLHlUTsCgVM/F9U9SXNZr0dzNPIu/gNL3i48cBHB1TBcf0SPJHcHspija3m63C2R88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtEGVVDs; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77287fb79d3so1473409b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671184; x=1758275984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/U/oc7TDR2VUzY00gKP0s0JlDQ9xsneooHDgr8AAAf8=;
        b=UtEGVVDs8lo+SfXJAlTs/ShvRs7lg/G0NbFd0YxfNaqpNfea4yIiNjhAxbSqAc6ly1
         5SJntktBYAhpsZbn1sbkfdktWyNXPjoPspNfdpKWprlKuLno2bZHFCPi/DJAyxg4enhW
         All/bjFhHPEnlUu4MLQTJwYhw1da/X7z47iiEtCKF9h0m1WoteQZHvf+j0/jnehNefT8
         RBXlAzy/4NPz4JsbfgJseW5Jq9bEt8Q8juInDC7yFnbG1F7Do7khCASyC5dh5cJpuOvU
         AeB+WmcAWvfxNpx5QzS0jxk72ciXA/DYGuXn0zL4wMRJ8UU2dCj/36XaoNIhDlKHdQWk
         nN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671184; x=1758275984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/U/oc7TDR2VUzY00gKP0s0JlDQ9xsneooHDgr8AAAf8=;
        b=T9697DduR92Hfh+H33hNRqpBHHD/szRtSXPUhxRbjheCzDVJCAmYUmIbRUsTZ8Ukga
         oUotYOyadfDVwtS7f4UwMfrjPTJptwiL2umuQ9ghIjtz2PD00QUIurd/rT7Jad/JXOjr
         LSnpHTBlu3TQsLv8ta9eQhbXa09iORP8Gw1XbuiBa3cBVchkjInZhr7d0pq9l0h8Plj4
         IutHhHQEf0wijxgRxR8McgxvqnHZh1YIapMhy2nc6wfWSG0aBfHCFLeMxJZ6AaX5PqNX
         +w90UO+zMDmRUSqss+fSWYMfrGdILwbRxl45aoantW0aw+2ieGqfu5qtYr7A7i/kS9/W
         JIXw==
X-Forwarded-Encrypted: i=1; AJvYcCV1gaJnIbzPKBm/QP34MqAL3BDy5yXa/xd0d34ojrt6RWM//Ic0qRcXtMs5IdvDO9ctDgaLGk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFb9VWPDhfOvRVqvVUJXfOVhlSm0O9QqfjmJy+smPyySvDATW
	9GxAEYuDBn4oJ3pNhhazM/1Ztr9xPJj5f+H8PXuaHWbGrAT/IH/wXCIYkIksrBC3LJU=
X-Gm-Gg: ASbGncvFCCP1Fyia+RKsubSKtiDVYaWWgT8/ZokDNruQZNKLEh4bqWTcBuflJv01wn6
	lrmXUGHQ4GPZ2sfIrGn7p0K5Z5RDQ6LbLaQ6bTLtao4rBoujN8PKhY8WfgFvEkH3uVgMxEC9xei
	JfpdYTEEYJnWC4IRJ3BW5iXcyEZVf8OYH/IJ0uUFIcFKH355JQhU7ci5iCpf0ko02Uzy0LU+501
	qHfFL9cxOJD+IlgUexJGloxvtR0Of9D2lNu7NKhpkxyzkF2A0e9Op++/bIBZCRUHorjO5z69kSx
	gF8y7HPTQfvcvm0lfdPKVQflPojqpwJWFUbWJt7U1h1WF49XFUSPMgqw8VyyJcrZxRw2tcfkFZb
	Rf0CswKTw92pbMA==
X-Google-Smtp-Source: AGHT+IF3JR3ArS2DE325tp7329BslWJiRQgkK4DDMmc7Q78E5uRK7Xm4SsTgTiPWVL89HRrP3OJy1w==
X-Received: by 2002:a05:6a20:4322:b0:246:1c:46d with SMTP id adf61e73a8af0-26029fa0cf6mr3110864637.2.1757671184180;
        Fri, 12 Sep 2025 02:59:44 -0700 (PDT)
Received: from gmail.com ([223.166.84.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b5absm4192951a12.25.2025.09.12.02.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:59:43 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH net-next] ppp: enable TX scatter-gather
Date: Fri, 12 Sep 2025 17:59:27 +0800
Message-ID: <20250912095928.1532113-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When chan->direct_xmit is true, and no compressors are in use, PPP
prepends its header to a skb, and calls dev_queue_xmit directly. In this
mode the skb does not need to be linearized.
Enable NETIF_F_SG and NETIF_F_FRAGLIST, and add .ndo_fix_features()
callback to conditionally disable them if a linear skb is required.
This is required to support PPPoE GSO.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v1:
 Remove the test for SC_CCP_OPEN and instead test for xc_state changes.
 Link to RFC v2: https://lore.kernel.org/netdev/20250909012742.424771-1-dqfext@gmail.com/
RFC v2:
 Dynamically update netdev features with ndo_fix_features() callback.
 Link to RFC v1: https://lore.kernel.org/netdev/20250904021328.24329-1-dqfext@gmail.com/

 drivers/net/ppp/ppp_generic.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index f9f0f16c41d1..1132159a8b92 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -835,6 +835,10 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ppp_unlock(ppp);
 		if (cflags & SC_CCP_OPEN)
 			ppp_ccp_closed(ppp);
+
+		rtnl_lock();
+		netdev_update_features(ppp->dev);
+		rtnl_unlock();
 		err = 0;
 		break;
 
@@ -1545,6 +1549,22 @@ ppp_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats64)
 	dev_fetch_sw_netstats(stats64, dev->tstats);
 }
 
+static netdev_features_t
+ppp_fix_features(struct net_device *dev, netdev_features_t features)
+{
+	struct ppp *ppp = netdev_priv(dev);
+
+	ppp_xmit_lock(ppp);
+	/* Allow SG/FRAGLIST only when we have direct-xmit, and no compression
+	 * path that wants a linear skb.
+	 */
+	if (!(dev->priv_flags & IFF_NO_QUEUE) || ppp->xc_state ||
+	    ppp->flags & (SC_COMP_TCP | SC_CCP_UP))
+		features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
+	ppp_xmit_unlock(ppp);
+	return features;
+}
+
 static int ppp_dev_init(struct net_device *dev)
 {
 	struct ppp *ppp;
@@ -1619,6 +1639,7 @@ static const struct net_device_ops ppp_netdev_ops = {
 	.ndo_start_xmit  = ppp_start_xmit,
 	.ndo_siocdevprivate = ppp_net_siocdevprivate,
 	.ndo_get_stats64 = ppp_get_stats64,
+	.ndo_fix_features = ppp_fix_features,
 	.ndo_fill_forward_path = ppp_fill_forward_path,
 };
 
@@ -1641,6 +1662,8 @@ static void ppp_setup(struct net_device *dev)
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->priv_destructor = ppp_dev_priv_destructor;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
+	dev->hw_features = dev->features;
 	netif_keep_dst(dev);
 }
 
@@ -3081,6 +3104,9 @@ ppp_set_compress(struct ppp *ppp, struct ppp_option_data *data)
 				ocomp->comp_free(ostate);
 				module_put(ocomp->owner);
 			}
+			rtnl_lock();
+			netdev_update_features(ppp->dev);
+			rtnl_unlock();
 			err = 0;
 		} else
 			module_put(cp->owner);
@@ -3537,6 +3563,12 @@ ppp_connect_channel(struct channel *pch, int unit)
 	spin_unlock(&pch->upl);
  out:
 	mutex_unlock(&pn->all_ppp_mutex);
+	if (ret == 0) {
+		rtnl_lock();
+		netdev_update_features(ppp->dev);
+		rtnl_unlock();
+	}
+
 	return ret;
 }
 
-- 
2.43.0


