Return-Path: <netdev+bounces-285971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHfqIKVK/mllowAAu9opvQ
	(envelope-from <netdev+bounces-285971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:42:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE32F4FB915
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEB57304EA3F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB220421A1C;
	Fri,  8 May 2026 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4Cwu+5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4803FE34D
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272878; cv=none; b=j9eCQ9iMLdmK9yZh3trvcFKhVp7YKGHwBTO6ll6Q1QZU6VvIc9GnEHzbKuLiI1SiZPth69ONc6eNEBF5wopT1jIQ2QUYVde6baXZD3fEPxEX62vQ9UsH8EzuikExk9lZ2aNrNZEzg6o5id7WtL87r540+OaoaIDtwKuxfs2MUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272878; c=relaxed/simple;
	bh=ZejcGvjNoKJ+168GlcWC60GUVbQug+g6EFKGYGUZ9uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIFlbleocjF33p8PgE2uw7XPNApakre6Qix4Az9idT00vYhdciXmWtii0QnWpsXyc4YPBboaWR0p1WYws5XNnQ1SDesz3PO92yYAij3qUVU6+FEFwJfZFYaYP22HDPvdHoQMLjQUZcX/g/P+b89etw9NkoNzfrziK2fdPSqqZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4Cwu+5s; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so1377108b3a.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778272877; x=1778877677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgBGn+2rXtyyJsqVkmH06WkJeLCLcvohOXBffi3wbRY=;
        b=b4Cwu+5seMU+6TS4m+9h2M/NGcwipL8SZXvUOUalFde8hVIJAW/h+FnJHouzm0KbYj
         nWyMLashDG1EiGFz8bOh+oNalV7Kdqo1+Pzmfh7+vJxGG1ZH7K98y+yOa6buc74hxjnL
         JsgHagkHjW7io+HtovBVzJvEvM9nBnBUkP0oS5dcrrl7rGEbEcJ4vE/qDTyyRzBJp6nq
         tNpOyZOUy+2G9nOH5zN9uJcOtoMF7b2omC3b3Gum+6mitedN1TQ0tkgOlW8ZjuGMh4mp
         wLJOeLW2Xsuqv9y3mLv3sFU3rqwfNDa2KgALTbyp82/JtnbgY21CZArLEQeI/tJDRBIE
         9Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272877; x=1778877677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgBGn+2rXtyyJsqVkmH06WkJeLCLcvohOXBffi3wbRY=;
        b=YyOLWumwbURuoCghSVxNdObNbE5ieLjuus1Zv6bvp0Ojt1A+YEjtQK9McURTskWPfj
         fi54MpNXzYVe/9OM8i+Naf1RtxoEAdIoxiO5UHde6qKXwXEmUMFMNxQsA6xbsm93IqCg
         79VcIW60nmRSAEiGKpx9f2VpY1OHdkrtWZmRDo/X8krwq43OcNu0u7ZDQGRZoSw1S/rX
         WpKq0viA9me17y4GmfQoWkO6WhddPigfz17QDX8PE6ptcdhsA39c3DtoQq5lOeVRW+zs
         lxQiLlPPYZpsdE1UrlkSXpUo3vlE8kDFUSDQoAyW6lgmjI3ZQtBqQxHc6yrGADoFkZ/e
         qdgg==
X-Gm-Message-State: AOJu0Yzel/sKHsSe2NMXD2V59gNl7biNLOcNc84tfZj/hLJDrV91wa1o
	jMamf62GGgsCNGe1V40Hqez8oB3yFhfsAmaMfPbditV/R0q1r7bF0xE8ugOZdsl6
X-Gm-Gg: AeBDietID3fDKIM1/cHIgmgHza7il4gJksLd1/+GwRkjvnL/5PZQk3FTvFnNKg5IIUo
	v2/fSKJ+hhHytoLeHX7vyCdT+Hu7YLE7tditjD7CE1kQNYyYZx6/QN0NOocZ/8QxPcbVPt9ZLgB
	/vyBLNJq0ZEKIkbs5cE1K3hJgeOfy6E0mfCzf3unTojJRo8DHfNu9laig2/BC5rViefT2MKeY29
	kYHNL+C79Y7BF10XbjtcbqMa4yx2la0/RTjQfS1sLddGtmnN4aeN9chkT3MoFYGKnuVsY7dJKoD
	4wFLLzf2GOm5AjT0vm9TJcOs4kPuYbggqygHk6k+N8HJtoFar0jxp0uiXmx+U9SMVvu8PK+ePvF
	Vziz7vOVvbDesP3xLMxz5LztBuDgKARpkDZE6eyZBwQ2vKDX82qwP8+RSeCGgQda2yfZ4LOqw+I
	tBbPJLxn7QDp1J2cDg
X-Received: by 2002:a05:6a00:1248:b0:82c:d9d0:f482 with SMTP id d2e1a72fcca58-83a5e34c689mr14306022b3a.46.1778272876601;
        Fri, 08 May 2026 13:41:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965646254sm13661955b3a.10.2026.05.08.13.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:41:16 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] tools/ynl: add missing uapi header deps in Makefile.deps
Date: Fri,  8 May 2026 13:41:13 -0700
Message-ID: <20260508204114.205896-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508204114.205896-1-sdf@fomichev.me>
References: <20260508204114.205896-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE32F4FB915
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285971-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Action: no action

ethtool.h includes linux/typelimits.h which is a relatively new header
not yet shipped in most distro kernel-header packages. Without the
explicit entry, the build silently falls through to -idirafter.

dev_energymodel.h is a new YNL family whose uapi header is not in
system paths at all and was missing a CFLAGS entry entirely.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/net/ynl/Makefile.deps | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 08205f9fc525..cc53b2f21c44 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -15,9 +15,11 @@ UAPI_PATH:=../../../../include/uapi/
 get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 get_hdr_inc2=-D$(1) -D$(2) -include $(UAPI_PATH)/linux/$(3)
 
+CFLAGS_dev-energymodel:=$(call get_hdr_inc,_LINUX_DEV_ENERGYMODEL_H,dev_energymodel.h)
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
-CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
+CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_TYPELIMITS_H,typelimits.h) \
+	$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_netlink_generated.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
-- 
2.53.0-Meta


