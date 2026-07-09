Return-Path: <netdev+bounces-306138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ZQqBWFwT2ruggIAu9opvQ
	(envelope-from <netdev+bounces-306138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:56:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D6072F322
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:56:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=yeh3j9NB;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306138-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306138-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DD84303D329
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D63403B00;
	Thu,  9 Jul 2026 09:56:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10055403B0D
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:55:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590961; cv=none; b=NrHxB4MRwmjzt7JIlkT0Mwnjre4c4qPqHFEggRA0z1ow5torPQx5GKDK3P1e9/bY8lV8CwETLy7RZnl0FP3aWCn4J8SJj9bOGOBaHw20BTBe1fRvuXs8b5UXwfX3IVVu0fhBzXiu9yWBDnRvg51Z70qbRQBKRBJyTjyLTGWtyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590961; c=relaxed/simple;
	bh=awVS+vQGfFNww7dDbkg0d58ZIZ/RFJpwp0CqYWFg7yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP7pcreXJYzq7glgNQnEJUHqAB/pAoQOegD9pWsNMZSzwf1XRZKV1D+gBqAObuCYr7blUgkyz//byWNqxurH524UcUE1qGRT7uRaV2Yff6Xwr3bKE36w+4miz279ysqxS28M9dAEB/v5Hm930i0Q8Y/qDf2qimsclvhdlPcBU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=yeh3j9NB; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so8773665e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590958; x=1784195758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3yvdJf8rTADXlXQqLGp3uJl8dCU4opoMAKhUr4P3so=;
        b=yeh3j9NBf4Uy8nYz2Tlz2QOY4RKLaAqKG139KrLDfIv61xcfVt4SRgLF9QO+2n0IM7
         xWpvQWE+xVIBthY/C4A5fUZGVs1WwOvLjgpNxvC/RLcwK0KtRw4SVKlNY3gAAUxf0fpM
         6dMBnfrd19qHrh26U1EfBpvIeMyoijg7Ow7rFEGpI4HxyscaUULxCr7HZrAnKzAr6IFd
         mMJSC9MaHjUGRNNUVrQGP9vIxHurx6fwkS6YIgj1A+t3K7Op/nH0jIkspSRNWWey3YBf
         bS72jnvs/ZLrH9YwEEnN82thwsj8iYH0N/m/97khkjmNhS5jgdI0aGRoXIiBmRdmZNP6
         tFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590958; x=1784195758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3yvdJf8rTADXlXQqLGp3uJl8dCU4opoMAKhUr4P3so=;
        b=bz5ZrRwK6t5MKDBoQhhlcCI/BWKbwcc8wC3MLUN9arNUbTFXpuZIfThDWN3v1CkI5Q
         FdAe5qQMq7DT3HJ76C4Krz139mISWlWFKltzP7gb4iz3ICaub/aSNjBK5Q/fjlpt6DEI
         V8iCgpOZHWvV2iu/Ov0r9iQ2X8go5UwiVKwPVRDYNogx8Ha5MI0efzaiYrDVSgDKqA1I
         xHs99mU3WhAF7g9nJeD3NfvReJ36kC75zmxjgswSKcQRzD1kzMqnrO0RFQDOxr1UhS5q
         VFZqRtM2LliWicM3hamlMUHnDPoOuOb7bZsTEM0WAstEj8nqhFzYOBlJz+qYZnyDssGW
         5/zA==
X-Forwarded-Encrypted: i=1; AHgh+Roay4WC86PIpgZbMv733DdALZfOT8JdYX+iXWxZabClZVDAQhArPn9SQvX8gfuPzS68Z4DB6h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1D85obnb2AOvUkDLf2BbzgIEMrtFYgLs16JMOJS8y8IEdjl6u
	kVzlIHHK7DWwpbZn2o8MyXJTadNmNwvdbNc2UMa/uEQjGXbmxQDG4/oFx3B8mGzpnJ8=
X-Gm-Gg: AfdE7cm0r6OZHl5oVOc7SF/GEjX+PMLpqm+3OGTDsaudodcbaISBaO3ZEENsKlh6Ksi
	y3Nab+a0i9aJPRlWhY0zgryYpaW3uGFZQ0XP5+Ah9Q6zj06AWkbBd897kjNdxEhYoZC7yYh8DjK
	jBqj1/DJ/lnWCm2qjgVgU5Y7/QiQL8BBNY2/JnZp7A11mSWmAJSsLZYQ4KefQDvPzXni2emivXm
	ZBPvdEMkvxbfkMuEex4zRvxJFi5zHTfbucGGHPCDxhfje8GtldsfJWp0fOcQSQSbnmTyyztfFqr
	fVunddhxMcSk/jS7IKKKyRncKbpsBkgs6b2XOsWQ8zCG8uEKEafJIw+IDyayCO+0Qs6bNGXAXes
	fgFGDDTpX9s0jXz9dYR28u97hOhwXvqQ/Etjo93R17WvRVYI7KfFUDQFJX83jr+tttz6XA4wQRD
	eDDF+m968T88vLzJv+dTuursl6ijWuxRY/
X-Received: by 2002:a05:600c:3b05:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-493e6859787mr59433245e9.2.1783590958491;
        Thu, 09 Jul 2026 02:55:58 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm52753503f8f.2.2026.07.09.02.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:58 -0700 (PDT)
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
Subject: [PATCH rdma-next 07/13] RDMA/srp: Make the SRP sysfs class net namespace aware
Date: Thu,  9 Jul 2026 11:55:26 +0200
Message-ID: <20260709095532.855647-8-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306138-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,resnulli.us:mid,resnulli.us:from_mime,resnulli-us.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4D6072F322

From: Jiri Pirko <jiri@nvidia.com>

Tag srp_class by the RDMA device's net namespace so SRP hosts derived from
same-named RDMA devices can coexist across namespaces.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index acbd787de265..a070fcf86e8a 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3189,10 +3189,24 @@ static struct attribute *srp_class_attrs[];
 
 ATTRIBUTE_GROUPS(srp_class);
 
+/*
+ * SRP hosts are named after their ib device, so tag the class by the ib
+ * device's net namespace.
+ */
+static const struct ns_common *srp_net_namespace(const struct device *dev)
+{
+	struct srp_host *host = container_of(dev, struct srp_host, dev);
+	struct net *net = rdma_dev_net(host->srp_dev->dev);
+
+	return net ? to_ns_common(net) : NULL;
+}
+
 static struct class srp_class = {
 	.name    = "infiniband_srp",
 	.dev_groups = srp_class_groups,
-	.dev_release = srp_release_dev
+	.dev_release = srp_release_dev,
+	.ns_type = &net_ns_type_operations,
+	.namespace = srp_net_namespace,
 };
 
 /**
-- 
2.54.0


