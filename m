Return-Path: <netdev+bounces-306141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sH1DD8VwT2oQgwIAu9opvQ
	(envelope-from <netdev+bounces-306141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:58:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC8172F396
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:58:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=LD3Fad6o;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306141-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306141-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 357D03082BE7
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B10403B0E;
	Thu,  9 Jul 2026 09:56:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDB40242B
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:56:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590972; cv=none; b=RUVlcZDaMZ5p7i3NRdaslr7fujIUHOulQVi5Ao33n+sOhYdM8vdb2SnCNBJn79Y5FQD0pwjiPzT+pOj8F//nM3GpFUb2vYhZLR4Uz9Ya/BXKmJbylQbCBhFUgu+aV7qGPA/XYUocnlNDF8NQu1yeIe2EoMnlJ/X6FZgXqa30j4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590972; c=relaxed/simple;
	bh=2JgBpAWc31ZSpkYiSaZDvjmnHKEA4A5V63g6j0fsopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAsLMThz71Ez8Vx3qiX6u8GZ7+2i/GVuH5PUJVvPS0EkgFIMOL3icbyaoupLTqbVCz1VYAyFKUfnXMMnLmlgSjYAkzaxmrTeEuY9aqNQ0rpCZcVL5txe9Mx/DhbvoXEFEF/WWWVo8dyz/U4eL+sBtS5aS5tyL15GHKfG833kEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=LD3Fad6o; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso9977335e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590969; x=1784195769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=LD3Fad6oh39v8c+zQa82JZBsYIfQEkOKAD7U54Yp6LpXoRZa3be0fua16CIXdNP137
         YKaKavVDpq5LxPMx//tGV6b8NpL894RgbRTMI/6VpCD1i2O445qTMygiCTf7U9ZlavNn
         K0Sc9CbY0APGtGIX73E0JN+JhwSXXbn/MwnG8p7s1jYO/NTY0lZDM7KPboGJEDIh61jC
         VVZxcm4LuB+efPQi73Qh2Sxua1dF48A6MAx/O6LQKJapBUZSS/jlXxGt85IHLKpDRR8B
         QJ1p0ygWV9LL0XU+WGRMJ+3r5hfo57BvXwtInPv3TTblS0Wde7efcijJfdQkc1YjECk4
         hdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590969; x=1784195769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=WMGPRxhyxCyHtO52jSIeZXzbUClnaDS7Zf0qxUhiV3Q4kbmIyPOFnBgeiTqee7o3a5
         JY10cZJ4M67zlsz0GHHUZp8bzKJnTbb1C3q7Z0B4LdV162phpM2samzgKpLmN6uwnU8K
         05Z6eRJaSo+RvIrvaIXRjHNqJ3Sh4h9DNHg6EOGRcRCWFUHasHKKZM91NublslIrKsEF
         DgVG2ThnXxAQ5xh5q9hSJUz2em5TD2CtAIB5u9bsZwA5XrVsQ6kBp2aRSBrjtzJ+YQgb
         im55ejTU7EjtUJTLxpFzKcKnTEnAAnHUDetYmuNQslh7dYDmlg3+4TjdwMsOEvxyqxO5
         nu+g==
X-Forwarded-Encrypted: i=1; AHgh+RrMLf3h2sM6yEXshl1gkU8irRsD+v8pMfNyDRU72rFkiRJpWrxBJwyea7jxriFT4Qw+Wy9Hq4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsaz+lbpsJVZaARmQeu51fF8K74zD4+o+IV246R/mPQRByVogY
	YazmNpmqYKlgE+GZNSPYxmlRGEuBAg1RxlwySRDpcFTRl3InknsBINa/wLZqaSZ1R7w=
X-Gm-Gg: AfdE7cn+WkpwcV0z5DMcVqAnGrt3fkDS93oXQft6PqFDbBLMkGMnTCmewjeagLsHT+L
	PjVt4Nz3ho7iJRV16CTdkFK9m4wqyBQWBFQ1O24wDPzhfTf837WQhEBcKXOx9iV5y+0z4IZhMPh
	/89wpPSQeW006rZCjxubS8SZzVLKft2TvyLqSC6/lbqrTGuyYakz3ybtD2hljRbeRPUdz5M7wG2
	kVYb/X62jTU1lRH6vb2kytszXgC776dt734SfvYDHYoAKV4WTe518tiRoUptpVUxMlqG71iioFp
	PpN1B/X6TMimvOsjGSAvIPKtV1ZV0FB5A7zBQ9tyuY3Zcr6ARoAzGTUb+EE5m6zIjExvmbDK+vD
	XftbrsqG8kwt5EMWgtrhyuCS1kpLTPDi6iCjp/MQtuyjwJj+PRtbJsMDL6fnUD6cF+VbWFzoZsz
	CGbOavwU4HZtFU4nF+czJTuCBYHLfLN6bu
X-Received: by 2002:a05:600c:c4ab:b0:493:e4b2:5290 with SMTP id 5b1f17b1804b1-493e689c26amr56899785e9.12.1783590968959;
        Thu, 09 Jul 2026 02:56:08 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm148972975e9.2.2026.07.09.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:08 -0700 (PDT)
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
Subject: [PATCH rdma-next 10/13] RDMA/core: Document the SELinux ibendport net namespace limitation
Date: Thu,  9 Jul 2026 11:55:29 +0200
Message-ID: <20260709095532.855647-11-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306141-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli.us:mid,resnulli.us:from_mime,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBC8172F396

From: Jiri Pirko <jiri@nvidia.com>

Document that SELinux ibendport labels use a global (device name, port)
key, so same-named RDMA devices in different net namespaces share a label.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/security.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 9af31d1d9d70..a82c46965416 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -700,6 +700,12 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 	if (qp_type != IB_QPT_SMI)
 		return 0;
 
+	/*
+	 * SELinux labels an endport by (device name, port) from a global
+	 * policy. If devices in different net namespaces share a name, they get
+	 * the same label; distinguishing them would need net namespace support
+	 * in the policy language and tooling.
+	 */
 	spin_lock(&mad_agent_list_lock);
 	ret = security_ib_endport_manage_subnet(agent->security,
 						dev_name(&agent->device->dev),
-- 
2.54.0


