Return-Path: <netdev+bounces-283912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALZXJGW2+Gn1zAIAu9opvQ
	(envelope-from <netdev+bounces-283912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF784C06D5
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28047300341B
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845BD3DF017;
	Mon,  4 May 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onULxrUM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B603D7D72
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907052; cv=none; b=rjjJMeW6AXQ0+NxegJpFrw3zbTd/2u7wrKigNY0dH+GUO6MRDgxxIH7ZMMLzyZtaObtn0URpHTTpFOkkfeaoNSU0D87hNp9uQpGpCAKml8rZYsCZdhe26SY5ALf00FJRVNW8QvQT2bq9gHokgjTWh8GynpxMuEcr/25TAcnr3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907052; c=relaxed/simple;
	bh=Zt52XDDhonHJAIyeH3TKYgmGMbFia/F7uYhGZrwZ78s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILJGVVB8WNhWqjE9Czv5HFDy5zBp/bRxz4ArFFjz0Oxtf4JtasxKaB2fYdgyrLNp/c7sGHrTJ9S3PkW1Kpy8PdhT4EyDt99o3fDr3GDTqhpISZn6J6Yx6GHU4+3vYv0xLyoQWhm4awNF7O74isGG+2GVAJBpYZ3MALBZNOGFDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onULxrUM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-365425c98c6so813017a91.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777907050; x=1778511850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBLYio4dSORQ087NCKhszziXEykjpp/cDyPH1+d3fvI=;
        b=onULxrUMjhzLm5puv1d9pqEJ7vJdbSP4bXgJf7uKfun40OnaOe2HQqhP/cOXhMRoDR
         pwkWT8q2YT5eDx32wWdPBd7JoRTMpIhrudUF26AjFjX3S5euHFbaFx2q/+SXSKbBGY1C
         TaT2Gg7asdgr3hEfsg3jnMJ5JsKGArPKLtsswnlDVgintQX6j99Unh6CdU8mZX0Utfxb
         52YoExea/B3xc2d3bpFtn2se4ho8WWjOiuWwrM604F/W07GmpzG09ymZqUX4maVps0iF
         mgP4IrGrKwdgvTh2aSmS077i0dvPJaLmcTliZmY49pkEM/O1zs+9cpdAKYBaOpjqbKW7
         W4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907050; x=1778511850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBLYio4dSORQ087NCKhszziXEykjpp/cDyPH1+d3fvI=;
        b=l1OsNd+nB3X6y3mSuVbQSLFUT/AIsqeKk9zp0yCu0eE4NOKRk5RK+2qDhlOBnjT/Zi
         6etbsNedGi+yMeb4xn4dBxnw6g9FCy3A7WVrh21XolmHtF5JgQDWRSxpyRUmT9DvB90i
         bdJy0UmYIkAXhBC/UxBXyMWcBUrrqKnhhfihZjVWlhXlMpzf15Mry3HdKFOQDajXqK/3
         Z9PZN6DaD3ORgl0Q/w+g8MBx7/+SFag+s1jBYnvbUmQlYAK6X+e3i26w/Mp2lUVMo1WK
         B8bgPmiJgb/fYJTMUMxC5ZV7YwgHbRKSCaSXGTt2JEaq8aFF8JK3PB7rDJg8pKNvxbrW
         r4vw==
X-Forwarded-Encrypted: i=1; AFNElJ9az0dOwyPkvwIcX0RBRdRIjEgDz3KO/0b/AXhDQ7LcLsAi8BgKtZhmCKsh7dAbr0ZXqbtbDA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ps4O3/IWnHMZ5ET8Uv4X1hSbhDXsnHbHh5FZm9J/TyO+UY3r
	XJ2J/WpQkbyHgKGNLYfiCRBrDR5Yh9F5ooXGaCuWuA2iNiIrIOfbKhTx
X-Gm-Gg: AeBDieu7dTR4lwRZatNQbMl4CwbsUI2aYYUE6jGo7v8JeoTMA9qx08UdLlsgrZ138KC
	lMJTotSfVzfSvAf7T+byw/BjWuhzGeB9Ooc0otA63HmTqQhlervLbPTHIT0+eiyV75xndHXy2eS
	UZGLt+/uToYHYQMVJnW7h+CZUJu2pjEpx8kpB5Wk6d3gZVaxXBihm0glxpOJrzRBbF2H5YGEovv
	pve/t5DckaNmaUjyIvCeANYnbR4a7pr+Kdnh+Z1teeqGcKsV0t72gK3WWKM9veWNwZiJDnfHaWC
	NY1+NizVI45X1sYWDdxlrjGQoWXm3DS0lf3re/L4bVdF9NOBcsDcuDWUYuD5qEc0HXd1jRdPEjS
	cS9ZdiRuWiXWpVcwrRFuES4G2xP7avVUD9mTnHhvcpCn1QbwpqqTNfSrXpTBljiZWErZNZhUUgd
	FjxQdUzfL0SyA3ct8gKCRqzR8+hITv6vPqGWuxxUf6IWhfsPsE/P7SVGWro/IFNd+/6Fs+YtwBp
	N+TvbzI77NvOTWz8g==
X-Received: by 2002:a17:90a:d2c7:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-3650ccefbdfmr9350785a91.4.1777907049979;
        Mon, 04 May 2026 08:04:09 -0700 (PDT)
Received: from arch.lan ([2409:40e1:3007:cefc:472f:1ad7:13a6:92d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f3c55bfasm7325410a91.0.2026.05.04.08.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:04:09 -0700 (PDT)
From: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aadarsh Chandra <aadarsh.official.xz@gmail.com>
Subject: [PATCH] net: bridge: replace simple_strtoul with kstrtoul
Date: Mon,  4 May 2026 20:31:46 +0530
Message-ID: <20260504150146.457562-1-aadarsh.official.xz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0FF784C06D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283912-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aadarshofficialxz@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The simple_strtoul() function is deprecated. It does not handle
errors or overflows correctly. Replace it with kstrtoul() in
brport_store() to ensure that invalid user input is caught and
returned as an error.

Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
---
 net/bridge/br_sysfs_if.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7fc0..3e948d781970 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,7 @@ static ssize_t brport_store(struct kobject *kobj,
 	struct net_bridge_port *p = kobj_to_brport(kobj);
 	ssize_t ret = -EINVAL;
 	unsigned long val;
-	char *endp;
+	int err;
 
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -339,9 +339,11 @@ static ssize_t brport_store(struct kobject *kobj,
 		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
-		val = simple_strtoul(buf, &endp, 0);
-		if (endp == buf)
+		err = kstrtoul(buf, 0, &val);
+		if (err) {
+			ret = err;
 			goto out_unlock;
+		}
 		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
 		spin_unlock_bh(&p->br->lock);
-- 
2.54.0


