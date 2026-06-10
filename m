Return-Path: <netdev+bounces-297655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hkn+HcZTKWoFVAMAu9opvQ
	(envelope-from <netdev+bounces-297655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:08:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F9A669161
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:08:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PeXBa9Nn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297655-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297655-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7529C3090DA6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5577540587D;
	Wed, 10 Jun 2026 12:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B971404BCA
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:08:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093315; cv=none; b=dVHiZnxYpvDlOr1mpTzY86/IjerVvXbv+qVPAntB87Ryn9THsjC2Mw9GPUFHayrJYlqq0gGttJp11h/K9SR4wLfvGfUpGOh089hRuENchEXXshKiKpIP1H6xrHg/gx8GAt1rdte/uidhJ+SkJ61YYKbpGcX7695m1B4qmhd0HPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093315; c=relaxed/simple;
	bh=OMZlOCXpaovVcRo+FqsWLxmKYFRygEYqo9XgpYn1les=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYebD1OmoJbQPsYjxDk1MovAFh4t0bQPbTNXsnh5XmDdYKXIPLt8R685Ke3Obu4tqnRaxXsl0qHDSdTM+5cpU0IfMrhyjaWT7ZbruEYNbRVshfnJrVgCCoMCDbW8tpQq2mScWG1bhoPLBLGKmksarqeCRCxFBjRWHbR+vWjQ9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeXBa9Nn; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so4092525a91.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093313; x=1781698113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/JZjOnmgY5Q7FGHdiYrMUdSiYaYtTF9tdiRSoMhHQU=;
        b=PeXBa9NnfrXOVCeEgHi0nr8xpybZG4speHrUmQmFcZWALRCCnq3+IEdgCcEt3sbSH9
         T0nDamxU7iU2PV3mYkdYDV82WizRQNNJwQJH7fAqFarttpvdf97WLPoj8fb+/mU6g9qq
         czcisCfpB7wuiMz+bmw3WCHZ06IcMbbAoulLiruhfvWpFmM3PbefJvOiFRTaQhmbILRQ
         9T8V6zx4W4HTk2sMI41XfGQTlgVAaNHpMEE2ARHCXbaxl4iwRnROnE8xUBzXySo9emHi
         tZx6TwbLAlxOdoNa/GyGDj/jsV8J+fqd40DDYL0YHQGGgYlgCHfy5tddCiWTdawCXPwz
         fPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093313; x=1781698113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/JZjOnmgY5Q7FGHdiYrMUdSiYaYtTF9tdiRSoMhHQU=;
        b=WPJ0Rf/I4j9wJmlS7IQAKTJPeapEgDEIQDBGJwZb4xx7Nk8nb9aQ1Dn3MnmFX6ryiB
         Y4P2ILVnd0WfJdIw3PoIIJMauLacrflTL0jF3bBeq1Zt43WOjTDw6I6Sieq//Th3y7/X
         ZeFXtx4Azu72bjsLUEYBurdAeHGL0GSIt6a6MZsTRzN1tM3LIxzL19IgXPXrbp3FhLhT
         anpBHa7lPE88DJ5+MaTTQebii9OMM4YDxIrOZmG/OiYmXHq6olEqjrWUmZvhzZIUwvJe
         VQeS07wUa4Lw5cqRFtOetkE3zijidJFPb/hRl0TPXBYgUktkZLrr6PyNSYmLPbHljrOZ
         ioAQ==
X-Gm-Message-State: AOJu0YzWM3c9EXf7YwLDRAIfxcYtZNLdtm46hg0syl/NgtzPj0qVP+Nb
	jFlk3H3NQLecGsGQte0FD5lBGHs86xorg0CRWKmK21qZad+TmyWht1/l
X-Gm-Gg: Acq92OG5Y3BY97BM3pt4GWgynrutN17GY7QeKxVUdHYIlC3nr2s/QWjYEXwsCTOBE1z
	OVngAU6t5Oap8ejayZv4aghZgaCCvjiuSxOUzW9XHSD7HWaMGFFDDcrU1KyIt92l4HNQaEzCLAz
	tauqy6py8U54V2HmvGYQDE23EjSeSBPvcr0GSa69GRvTvEOQ3KhKCDlA0IQ8jeyBgFwxyldYrf+
	8MlsQHY6eLzhZveQ63vxRixgN1cvsEe/eyVQJ9XHxFdjK+C6kqlQe2psgZotdHBCt+FlgwQjbM0
	wAdzC7TaqldeDgscx02plbiAXKmFNdQ/CGQFYq7QUkrH+GVePcITIZNeMpirArZixiuEDgIA9Kr
	hVu5nHMthWNgBPZE5oo1+6jJgiYZCxNIW4DAqVRDN+UTb3czKJbfFZXUl5QTfYlFqZ52bxT7Gcc
	XRp+REa1NhiBgGxeawD80Y2JsDHAec7dochp1BnOQTal8dpOsnnx9gL5QVbOnMYb9IobFho/pXS
	AiqK2WaIQ4yb7y62263qUx0
X-Received: by 2002:a17:90b:570f:b0:36b:877c:42e5 with SMTP id 98e67ed59e1d1-37133372f4emr18171979a91.17.1781093313072;
        Wed, 10 Jun 2026 05:08:33 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:2200:31a0:d9c3:9e95:32b9:9b7b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3761e8a717asm3505874a91.0.2026.06.10.05.08.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:08:32 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Tonghao Zhang <tonghao@bamaicloud.com>
Subject: [PATCH net-next] bonding: add sysfs interface for broadcast_neighbor
Date: Wed, 10 Jun 2026 20:08:12 +0800
Message-ID: <20260610120812.49054-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bamaicloud.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297655-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:laoar.shao@gmail.com,m:tonghao@bamaicloud.com,m:andrew@lunn.ch,m:laoarshao@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bamaicloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3F9A669161

The upstream kernel has supported broadcast_neighbor for 802.3ad mode since
commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
When upgrading from our local kernel to 6.18.y stable, we switched from our
out-of-tree implementation to the upstream one.

However, the iproute2 package on our production servers is too old to
support the broadcast_neighbor option. To enable this feature, add a new
sysfs attribute at:

  /sys/class/net/<bond>/bonding/broadcast_neighbor

This allows enabling the feature by writing "1" to the sysfs file, matching
the interface we previously maintained in our local kernel.

The result is as follows,

- For 802.3ad mode

  $ ip link add bond0 type bond mode 802.3ad
  $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
  0
  $ echo 1 > /sys/class/net/bond0/bonding/broadcast_neighbor
  $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
  1

- For other modes

  $ ip link add bond1 type bond
  $ cat /sys/class/net/bond1/bonding/broadcast_neighbor
  0
  $ echo 1 > /sys/class/net/bond1/bonding/broadcast_neighbor
  bash: echo: write error: Permission denied

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Tonghao Zhang <tonghao@bamaicloud.com>
---
 drivers/net/bonding/bond_sysfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index eaba44c76a5e..24eb23634d98 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -750,6 +750,17 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
 static DEVICE_ATTR(ad_user_port_key, 0644,
 		   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
 
+static ssize_t bonding_show_broadcast_neighbor(struct device *d,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct bonding *bond = to_bond(d);
+
+	return sysfs_emit(buf, "%d\n", bond->params.broadcast_neighbor);
+}
+static DEVICE_ATTR(broadcast_neighbor, 0644,
+		   bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
+
 static struct attribute *per_bond_attrs[] = {
 	&dev_attr_slaves.attr,
 	&dev_attr_mode.attr,
@@ -789,6 +800,7 @@ static struct attribute *per_bond_attrs[] = {
 	&dev_attr_ad_actor_system.attr,
 	&dev_attr_ad_user_port_key.attr,
 	&dev_attr_arp_missed_max.attr,
+	&dev_attr_broadcast_neighbor.attr,
 	NULL,
 };
 
-- 
2.52.0


