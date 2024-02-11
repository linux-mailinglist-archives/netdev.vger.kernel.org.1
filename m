Return-Path: <netdev+bounces-70843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D12850BB5
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 22:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14EC282C44
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 21:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4449E5F496;
	Sun, 11 Feb 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2KMSAoL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A745F478
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707687851; cv=none; b=PtxYzuRjeOpI7NfFmSGd8Rb9hSmRzT6Tz2zD91m28u5ryM7ZkywgVlfayyt7IRgMQ0mn50DNuVP2FadOVSoPRboK8LqKE1ZwwtiLjdu559KEQ+0BtxLLWxa+Eu1AvZ1qY704tQnTRBZVqt4KxtDlSxtfYzZcxEXxuG+Q2N/B4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707687851; c=relaxed/simple;
	bh=FKdaOYH0qBxwGBrGswUUgIwsxGavgv7PrwxosIO0tMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KMpoqxZQm1QNuP/KizC2EPvQ80y91Ge6rTxfV5mt2waed/LV1iRw8UolxL2xvg+OyhIGgkKLLWiExRDTptYuFV4TTqH1sVQQ5C3cTFKrfqzNeTRtOKCQVqJ/N4cN17vFBVI2WsSp/av/bq25zNOH7vJpUwg5l2Jy9HWMSKk//iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2KMSAoL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6049f0f9856so50345407b3.2
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707687848; x=1708292648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWe/4S3CyonS/oMPtT6S4UrZVWeFp7QesWmpO/EBmzs=;
        b=o2KMSAoLA7MAca3mcMQxSDYFETeXLQx5phFE02JeNJFOFNu6RSU0B2SduViTIS9P5X
         fax6lrccq3+RszM1NW/Pl2R+r7/8oODLMGeX4o5llnHU42n/goBmKNLTOIw14P1H+sX6
         AjBTsF78Ax7zpTwaIS8w0gfURi9NviX7fxV26MVC4xtka7wWgaKf3Xv36ISTcVaaLKlf
         I/+QRxphnL3zP9laKR0nWAmr2GvNrFn/vqLY4bgfdQ9whiF5nwFcRu19B3qgMI2g04CZ
         2624Om422Hpa9hNs63CK5+04GG3ou3ouB14oVvo0qtiH+1cK9b57B7hXzXYZL0Kx2NXA
         N4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707687848; x=1708292648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWe/4S3CyonS/oMPtT6S4UrZVWeFp7QesWmpO/EBmzs=;
        b=SfUYJDNeeWeOQklig1tHNZQCw1sdU3zc+cXwPybsoaEpT+rtF2dS0z1wUleEdeZyon
         EEChXy0vSLav/98XNz69Tz2V1Ymoq+PJ1fD2CpAkw/izgqVSwbc2dmQQegZS1bTNk2a+
         /7u7HDMxioSK7cocqB8Rzi7P+Ioy+4VdZjJnY+7OBq3LdEpWtmnwr04+gYdGR2Ku7kq9
         2LUrHOPWsiScjPVRCitW+tzvTr67vIBS6xoroUCtilZ1hKOGPVIxZKHFHhmfqJXkRZi4
         jwrpQ+eaaW+eU/cB/BAEiNqqnjZBpUGjRBzdo+nDRMw3OWHE+ptgNsHRv6CZWBfkxiby
         TAPw==
X-Forwarded-Encrypted: i=1; AJvYcCUAY+Kqmp9kdpaUIIviy7hT0ZjmCudIikjOAAm64Z7lTXa6S3xTgKIdBTdx6Aci8fB1euI993qFEq3DxbkLjY7q/sg+hl2H
X-Gm-Message-State: AOJu0YzV+oSA5/FECzvSVSnticDg2nk5hS193EAUX8/zY2dnOVc6YyVz
	7gv1NVDoyttUttu4RV4BSdCltYUVo7Tit6ij2aBbTnBg/pNbJxJ3co+wfuwTUiBUQeoAxzhcFND
	wBVNc8diskw==
X-Google-Smtp-Source: AGHT+IHxc9vr65z3pcrmBT8guiccTmSUcJ7P0kUy+bnk8Xtk4+lZiT2tGSDZo4K3is8JEYaqCTDCMwmFNk/ajA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:704:b0:dc7:4b9:fbc6 with SMTP id
 k4-20020a056902070400b00dc704b9fbc6mr1453965ybt.10.1707687848721; Sun, 11 Feb
 2024 13:44:08 -0800 (PST)
Date: Sun, 11 Feb 2024 21:44:03 +0000
In-Reply-To: <20240211214404.1882191-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240211214404.1882191-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240211214404.1882191-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/2] vlan: use xarray iterator to implement /proc/net/vlan/config
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Adopt net->dev_by_index as I did in commit 0e0939c0adf9
("net-procfs: use xarray iterator to implement /proc/net/dev")

Not only this removes quadratic behavior, it also makes sure
an existing vlan device is always visible in the dump,
regardless of concurrent net->dev_base_head changes.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 net/8021q/vlanproc.c | 46 +++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index 7825c129742a0f334bd8404bc3dc26547eb69083..87b959da00cd3844de1b56b45045e88e6a0293ba 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -163,48 +163,34 @@ void vlan_proc_rem_dev(struct net_device *vlandev)
  * The following few functions build the content of /proc/net/vlan/config
  */
 
-/* start read of /proc/net/vlan/config */
-static void *vlan_seq_start(struct seq_file *seq, loff_t *pos)
-	__acquires(rcu)
+static void *vlan_seq_from_index(struct seq_file *seq, loff_t *pos)
 {
+	unsigned long ifindex = *pos;
 	struct net_device *dev;
-	struct net *net = seq_file_net(seq);
-	loff_t i = 1;
-
-	rcu_read_lock();
-	if (*pos == 0)
-		return SEQ_START_TOKEN;
 
-	for_each_netdev_rcu(net, dev) {
+	for_each_netdev_dump(seq_file_net(seq), dev, ifindex) {
 		if (!is_vlan_dev(dev))
 			continue;
-
-		if (i++ == *pos)
-			return dev;
+		*pos = dev->ifindex;
+		return dev;
 	}
+	return NULL;
+}
+
+static void *vlan_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(rcu)
+{
+	rcu_read_lock();
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
 
-	return  NULL;
+	return vlan_seq_from_index(seq, pos);
 }
 
 static void *vlan_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct net_device *dev;
-	struct net *net = seq_file_net(seq);
-
 	++*pos;
-
-	dev = v;
-	if (v == SEQ_START_TOKEN)
-		dev = net_device_entry(&net->dev_base_head);
-
-	for_each_netdev_continue_rcu(net, dev) {
-		if (!is_vlan_dev(dev))
-			continue;
-
-		return dev;
-	}
-
-	return NULL;
+	return vlan_seq_from_index(seq, pos);
 }
 
 static void vlan_seq_stop(struct seq_file *seq, void *v)
-- 
2.43.0.687.g38aa6559b0-goog


