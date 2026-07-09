Return-Path: <netdev+bounces-306132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jF6BGohxT2pRgwIAu9opvQ
	(envelope-from <netdev+bounces-306132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:01:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF272F43A
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:01:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=abftVDo+;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306132-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306132-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 290A33034DE4
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02DF401485;
	Thu,  9 Jul 2026 09:55:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A96401A08
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:55:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590942; cv=none; b=BJD6d/HP/ipXObxzVh3mVufC1wggOdec9N1/J/9503gJAZ0XKI9WQoGeQdJAPEDk0rws5WSqrn4h+PdGw9zCgpgOKJrzdt2heSvGFbonRDHHhJg9CD41GLQ6tnqTnvBu0PsfPpoKXT/MmiUWlB+rXoOqleebtg4tXZFKKnUK9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590942; c=relaxed/simple;
	bh=fj0Q6ihUmYqKUkY8KaHXFWF5Aioa8BtTYy9MtuieBMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1z9SaNcESyD3f6SSL5L0ZBJGRwFPeICl4qfK4PchSAPb5+p+l9qQaLqL6OF55WrXq/O9bVGcrGIQu8DmXM5AZHGCcdx7HedncwDyj2FWfmT53M1bsDLF5/ZyapNDj8m0MAA45OsjZmBOrQOVB5JVZP3tYW0njdL3qpTDnrp1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=abftVDo+; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493ba701891so11992925e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590939; x=1784195739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+RolV7SjzshTN5zqSzxTVIaSTGOodHrW0P7odUB/p4=;
        b=abftVDo+TqZFBqGgvWr2ca/J30dmn23Ggx9DM63vd/vD9ZAJwAwOpIDORAvdSq8bPw
         sMb9DVZOY1/lJUlO8wSJd4lKhxJ8D130Qxv8Z1lqBrKG63cXICGw/GdoSxYpSeSvYv28
         K4nIk6NsO55qQyeWvRhicqMNBD1u+nV9lj8+YYz89ewiL+9ZNDXnEafbVV4xs4ftX3ml
         OoQLNY2wy/zHDOehiTfStb1/l8UrZ+YZYT7i2ppWn3HLlBReOcaWJa/NBv5GMhBJ2aNH
         v7eX0nFTi0YmmojY7AbCeoc9WTv8x4jvo3ML3I4Fpmxw3Fga94SLzzSqkVc4i+ukn7Rx
         g78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590939; x=1784195739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+RolV7SjzshTN5zqSzxTVIaSTGOodHrW0P7odUB/p4=;
        b=HyenE//fkEjgReXKERefxNzDtJHn4QRsJogjkUCL3ai/BeOGw4cFvpaZtQ/cjJs2gY
         P38LaTYvTuW4abvpxVSTnGebtNlaikw+q5PjbVR6G3xMwODk4Xvb/efb9pmK9JrkWjg+
         iv37jDPrc9OiEUYSyzB3okBeBNdVwXlKi8tb3rcA0+pYuImGisC/gKQYD5Y5viVMQjg/
         f8otnWuDNxZPZe7oVvdepKE318nvkell+Og5T/n7xEQbSlLevqqGAmwgLXn3K2Hl0Abx
         er/l/0feUOi1pZ1X61Is2uCtLIONEvTnaCAwqZSJtEZ1WDJeAIzS4UFo8KuLBYxxQ3Om
         44ug==
X-Forwarded-Encrypted: i=1; AHgh+Rp5UhJXmAA2UBkRFSdefytC4ibynTWAxtswvT/CHHeS1QKLDIsRkxL/ed/wQ23VIcesUtDCW4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YG3Ehxgm1BjPmMX+zSJbtinMFkvuigN90UShX2xqyufm+Y26
	YvmLw2+O429hTThEzdtxYXJ4OHYN3FxXg8cRWUc+pVl+i90YjrmtafBjSPh//pt1QN0=
X-Gm-Gg: AfdE7clI8x9QdwjfmN+hyj3mh51OA5x8nfC3a7DIMDQDQx51GeOWjrmEhNdC+4z+1ef
	QNPDXucDUSo/lc6Fk2zA2vEpGfoV70algPryvnemnc0SYR0QGZQvAC5G749P9R3RiuahRyDeDVX
	NSqcveKf0dzzC1hH88Zug7w1/pyzZP/AgMiwBxdY1Jk+5GwBUfF/ku+Bi/ggv0UXO8Cr0w3HUsW
	3Ie7htCpu8zTLR+/3Wn+9rjVF1P+n/vmg5idKCiDA6C5KrozrKfm/fs2i+FVvGAcPQyzmhbNln5
	PDEFdqPgOjHH/vPfQQ9TrUPlCfBrxbV46jN075Cx6b2CCmB64O7pcN5ozUr26OyqXhcrfzHWX6w
	V4c3kWwbMQKOGrJiK70+rh1SDGcYA6RpmURj1G51HRTYfAoH4nhdC5JnCvnsg30IueNMBPVlVgk
	IxCKpQNoMh+5+uAPjM70Jxuw==
X-Received: by 2002:a05:600c:628e:b0:493:a5f9:d345 with SMTP id 5b1f17b1804b1-493e68c6944mr61922075e9.26.1783590939349;
        Thu, 09 Jul 2026 02:55:39 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm148937985e9.2.2026.07.09.02.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 01/13] RDMA/core: Pass the net namespace to the device name lookups
Date: Thu,  9 Jul 2026 11:55:20 +0200
Message-ID: <20260709095532.855647-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709095532.855647-1-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306132-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:mid,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3EF272F43A

From: Jiri Pirko <jiri@nvidia.com>

Prepare for per-netns RDMA device names by passing the target net
namespace through the name lookup and allocation helpers. Keep current
global uniqueness behaviour.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b8193e077a74..de610f52c9b2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -351,7 +351,8 @@ void ib_device_put(struct ib_device *device)
 }
 EXPORT_SYMBOL(ib_device_put);
 
-static struct ib_device *__ib_device_get_by_name(const char *name)
+static struct ib_device *__ib_device_get_by_name(const char *name,
+						 const struct net *net)
 {
 	struct ib_device *device;
 	unsigned long index;
@@ -395,7 +396,7 @@ int ib_device_rename(struct ib_device *ibdev, const char *name)
 		return 0;
 	}
 
-	if (__ib_device_get_by_name(name)) {
+	if (__ib_device_get_by_name(name, rdma_dev_net(ibdev))) {
 		up_write(&devices_rwsem);
 		return -EEXIST;
 	}
@@ -435,7 +436,8 @@ int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim)
 	return 0;
 }
 
-static int alloc_name(struct ib_device *ibdev, const char *name)
+/* Pick a free index for the '%d' style @name pattern. */
+static int alloc_name_id(struct net *net, const char *name)
 {
 	struct ib_device *device;
 	unsigned long index;
@@ -462,15 +464,22 @@ static int alloc_name(struct ib_device *ibdev, const char *name)
 	}
 
 	rc = ida_alloc(&inuse, GFP_KERNEL);
-	if (rc < 0)
-		goto out;
-
-	rc = dev_set_name(&ibdev->dev, name, rc);
 out:
 	ida_destroy(&inuse);
 	return rc;
 }
 
+static int alloc_name(struct ib_device *ibdev, const char *name)
+{
+	int id;
+
+	id = alloc_name_id(rdma_dev_net(ibdev), name);
+	if (id < 0)
+		return id;
+
+	return dev_set_name(&ibdev->dev, name, id);
+}
+
 static void ib_device_release(struct device *device)
 {
 	struct ib_device *dev = container_of(device, struct ib_device, dev);
@@ -1223,7 +1232,8 @@ static int assign_name(struct ib_device *device, const char *name)
 	if (ret)
 		goto out;
 
-	if (__ib_device_get_by_name(dev_name(&device->dev))) {
+	if (__ib_device_get_by_name(dev_name(&device->dev),
+				    rdma_dev_net(device))) {
 		ret = -ENFILE;
 		goto out;
 	}
-- 
2.54.0


