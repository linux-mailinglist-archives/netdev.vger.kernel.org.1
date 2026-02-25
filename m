Return-Path: <netdev+bounces-260946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJRWLnb6nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:34:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C72198228
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D230E30349A0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0823BFE3C;
	Wed, 25 Feb 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BczRShrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB33B960B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026470; cv=none; b=a2cq0fX/WkE2LPSfo9OTt3g2G+DPkH17/YLGosezMBX0lnAK5Rjy1XdP8nF6sldb2DaH1HtlYzKVyAOocReDmgI25tnaFs1EYUU65o2z6AAvYfaDMdo/ryy8xcd+K7zwNC7YntfRDkGlRGfp4zr9M85h+lJ6bLClC78aq174OtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026470; c=relaxed/simple;
	bh=Uit1Ti7AU3XxeFhawNvwoDfVMeh6nJo+iBe3Dbimg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LS21S6+HvjKolF/dFxUm6ZJYfXyfSnixSD/xSokLVqFT8b31SRqv6AgXbxfCkgB5KziZ6v4nLFQrWQEHLw8CK99s2MFLnMF2RtZyGmeFF+Xj1aW0ajvpaT4S7tqqdsbteYmUkYHmIcwsm+TeEPgW92sTTaANIoE7lV3qyJ3IJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BczRShrX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso56150935e9.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026465; x=1772631265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=BczRShrX8kFKRl+NNC4TUU3fx++ERqfTYVffd2fsSe3xeCriS5DSeUmMKdTEoUHysn
         X3ZmaSXJAvzF4pgV3FkHk6zblNlljRC6aT3NchOHj5J+Li0ugawnQgQJxtIW+1BMcIBb
         SW+vqRD3kp2jz35omeGV09paNT0niPtgU8DleEUp8UuuJywTRQJ1QiZhFlasAn2Lmdoo
         7sIg9/E6661RsgEERrFVhNz0un2Zn7Fiqjv1nu24f2Oq82fYVg4KsISULKTpJsjoWf8D
         o+uHzcud1eTMY3KlqGXr8WPu25QIkzJAvuiy9xCOUTkCoXWDPim8C0gJyI2rgdym+r0z
         gKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026465; x=1772631265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=wUwj56mubBC3XTa0ZnTvTd84j8dxay4HT5HC/8xTNAPfOUmAfcRfE2C5u/srrTrTd+
         d5tu0X15Jz9rqMKrLReMgggxHoU02Vl2BzEydMyhyCsCLbihNtvqo3loWw43hzRifGW1
         NobOg8/TLFZ9pemXxPyuxXjOIHZyqtBUfPH3dKX+QnyNn3aIfkDb7YDNbHuK0JhRGq7r
         enEzINrp/n5uH7iFyeL33jLnY5mfKKqALq138A9PF8lppTczuA8Zue4g6dLDtUCzqX+F
         O3cIYPZYe4hm5hXz+BYt4o/NZ6F7/r5DONel3JHMOWb9VYrul/YRPt66lnGobF46io4D
         BBPA==
X-Gm-Message-State: AOJu0YwWVS1CQJfxYJHh401zVyEC9ifhuxWY/kSZqEokIbMxamk/Qq8q
	cWwtQ4d3ePu9ja4JJzFAIvEwyehUXIkcHA5Ji8I98rTd+qZcna3OGLpRQ5SN2Dmqd5A8i2PhLZt
	iOVMi
X-Gm-Gg: ATEYQzydjxqCz1KezVd97A1S/IVDeac65xBYFrQF/tb1VTbzQlWveGtZsHdWYy5r85D
	KHkP591DEe5mbutpcwyVUZb7BZ/C84NmJbYj3FTVswpNoNKnfIUEngSqXdqT8PQBnmJS2E9/947
	sAwWvzr4jc9rrjaCf4m3WQX1AOwQj3RilSDg7L85zd8HtHrHT0TgNilodoiVELchjGscoM7POyh
	cIM44wfeIXsW3MHMhYvVdAtumXo/kuZU+MUzG86TnXtlsaaQCqJT8xIsiLrd2jOjRjGB7arCZCZ
	5we9APOpYx7tEOA++uZHRloOMV1bkdKv72ywWrYL2FBpvXmx/ylfkQCNKpqIVkNlOnJfMyPXmaj
	9Plmi8ku6nwv7PH3RZSBezPs3QJnzse3V1EEZ271IskGaZtdMaAa3BfkTs9uiaUVvM2NjViyU0b
	owtAtlvmfbquvYn5XOJx3WDc31
X-Received: by 2002:a05:600c:a11:b0:47d:885d:d2ff with SMTP id 5b1f17b1804b1-483c21af52fmr5939965e9.29.1772026465278;
        Wed, 25 Feb 2026 05:34:25 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776a3sm16744665e9.7.2026.02.25.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:24 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v2 01/10] devlink: expose devlink instance index over netlink
Date: Wed, 25 Feb 2026 14:34:13 +0100
Message-ID: <20260225133422.290965-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260946-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.975];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: B8C72198228
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Each devlink instance has an internally assigned index used for xarray
storage. Expose it as a new DEVLINK_ATTR_INDEX uint attribute alongside
the existing bus_name and dev_name handle.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 5 +++++
 include/uapi/linux/devlink.h             | 2 ++
 net/devlink/devl_internal.h              | 2 ++
 net/devlink/port.c                       | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..1bed67a0eefb 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -867,6 +867,10 @@ attribute-sets:
         type: flag
         doc: Request restoring parameter to its default value.
         value: 183
+      -
+        name: index
+        type: uint
+        doc: Unique devlink instance index.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1311,6 +1315,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - reload-failed
             - dev-stats
       dump:
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..1ba3436db4ae 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -642,6 +642,8 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
+	DEVLINK_ATTR_INDEX,			/* uint */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 1377864383bc..31fa98af418e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -178,6 +178,8 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 		return -EMSGSIZE;
 	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
 		return -EMSGSIZE;
+	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
+		return -EMSGSIZE;
 	return 0;
 }
 
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 93d8a25bb920..1ff609571ea4 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -222,6 +222,7 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 
 	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
 	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
 
-- 
2.51.1


