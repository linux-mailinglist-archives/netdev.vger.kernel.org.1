Return-Path: <netdev+bounces-70550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BEC84F7F5
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC2EB21BE5
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEFA6D1CC;
	Fri,  9 Feb 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fy/x8hdp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709E6A037
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490581; cv=none; b=sS56HO6xeobb6dsNY1i2I5uivd7CLU0UUrZhiaUeZlSm/SC2IEvfCcQLNlOfduKm14YtwFG9IhkhTporz+mDY8dPgmIMsdtN2LtKj0Oj0Af7GjTj75C4MtqJ5ML85S9kRDS+046VNPuZ68qFJ8P8b1wPWTpbTsHCYWtBNKg//k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490581; c=relaxed/simple;
	bh=Vnr2IaAe6ic+7suQWk3JuHowdks/ASyK6PFk4rDwLRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=buGi55htoZ6k/ihmtFfoUBHWNj0dkYArR+55+Ue24hCAguQrO6aDF60IWgrSzATya+xIrD13MJioCDBEDtHfAc/VVRqJDDZjV/eTLpC2AWH95gFZg8GSkGBdMEOdfpkbVeaQ0vm6nC9s7nDrJiNRi3NWaUXg70oQNL+HzRZj8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fy/x8hdp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ecfd153ccfso20528297b3.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 06:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707490579; x=1708095379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcOZetMZy/77mw5CtMoy1w1oKlHr51XSKDnK+Nfmv/I=;
        b=fy/x8hdpAe6z6RTiaUNitMfTDZZ0/3kbdmEi9SWqBuwEsmSPU2c82tAABK6IW4Dpc2
         UDClKqJOS4TLw1KVk2DkN7eb2WmOEgfkk6pypmSInORiDHr6PJqd78lmzRlxIi1RfnSV
         6KlTiluMKUQA33mN3g67ZFbvhrr4GKQwTs96h8cJPIKdofWPTrjhStv7E5rSnVH2jVx9
         uwdsfYOadnJ0fJkLVeFU8Zax/y0M28s/Gpmp7cZgzqnniHJ7XI5DXmysSiMHpmIINt9J
         8vM2/reFRFH11sUUlqzco0r/dsiZwzI3+hy8F270kEO7RuJApq0gHA3VA2sJRO8U4rNY
         a9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490579; x=1708095379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcOZetMZy/77mw5CtMoy1w1oKlHr51XSKDnK+Nfmv/I=;
        b=hx0PSDRBc4PgB55mgnVGb24mMrs+0gmA1OOFQJnQF7ytv7WaX5+eUrRHE7865Dzef/
         dB6pzTzBDyaYDprtXg3g9XQquiTPuV8apsMjiOpWA/A3TyW1VXERuIk2DVgmOFsMTqib
         2ba5OxyNWvHAbs1uqDq7aTLk1rTzRgw7Ak41hXSHyhPwlZIw0qV9Gk7RRuMSweAHZljB
         gpM60MczJtOHMDZn3JpTcxm6KqwASx2QlYxJraDcQeRN52xe28WtSOdCG73cn5FEM4zA
         B0ls33YXcYnClvmeG5MVI6sL1L+WGBww9V6VkQbV4BMun460c6vfLXSzo3rg12XP9onE
         +FSQ==
X-Gm-Message-State: AOJu0Yw/YXTwRoYu7jcMFUCfL2gE8UGpCkZsVTqaVGishctXHSGjuL7z
	bs0hC5KkPpNjx1bF19Lyh6kO8eh7f+Mh96vTwqSNWURu/ysIV/qa9bLsEnkwJH2Z91hpEOAVlS+
	Mzo80oj0nAw==
X-Google-Smtp-Source: AGHT+IHzu9CN7Koo6EF/vYU3ivgNG0/1tJEyxbLlpzt+1WLwVcXC+aUoTDDccELruy4SFkJ03miDfoR+dTFFZQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:e601:0:b0:604:45d:27e5 with SMTP id
 p1-20020a0de601000000b00604045d27e5mr394643ywe.7.1707490579085; Fri, 09 Feb
 2024 06:56:19 -0800 (PST)
Date: Fri,  9 Feb 2024 14:56:14 +0000
In-Reply-To: <20240209145615.3708207-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209145615.3708207-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209145615.3708207-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] vlan: use xarray iterator to implement /proc/net/vlan/config
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Adopt net->dev_by_index as I did in commit 0e0939c0adf9
("net-procfs: use xarray iterator to implement /proc/net/dev")

Not only this removes quadratic behavior, it also makes sure
an existing vlan device is always visible in the dump,
regardless of concurrent net->dev_base_head changes.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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


