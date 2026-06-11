Return-Path: <netdev+bounces-297974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GUv2CrRfKmp0oQMAu9opvQ
	(envelope-from <netdev+bounces-297974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:11:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360466F46C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:11:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xu1fFD11;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297974-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297974-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3317311B002
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26763B2D0A;
	Thu, 11 Jun 2026 07:09:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BA390235
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:09:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161781; cv=none; b=dAqrvq98H3En3XDykNkO6X+Mg20PXmKirR7zbt04nAVxxk9UjefG6KyB02XTixU5SM3GAjrA/l0lN/HGqjq+mNXKjRPMnW/2nWyPDGtViDjwC51hHpZ9NGKU+fgL0g3Q+cIlXR8aWU0diWHn02UIQNp7VRNeAG7tUdJkphuUfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161781; c=relaxed/simple;
	bh=k+IxjsuLra3cK2VhDLngm56iDPq+9Z/ufCcPp5tTvE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCfNFAgxoWers8pGLj29doPb523U05mhpdRjd/+vm6A2vJC50+br6hvtwUmnFDU6q8jii1R+EKyqpCV38n6Ybv5S1WT2oxolDdMP3DWY1jfzdFCrjE4EHGBOuJKocSUMT/j2upligl3DvOE1UhiCJcsVD3k4AduHTVF/IVDmQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu1fFD11; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso73094295ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161778; x=1781766578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kc3MFHKXytuLZID0ql8vfVlQxw8tF3bNPdzjICZ2Iw=;
        b=Xu1fFD11W5Z1Ec9n/JkWHooxYDyf34mTGjvsuPlkCZW1oTVrI726tUmKypofUMVklu
         lK2yKEntlhFpkVH/59SNrLmdsMlbDEDzaOUR6tk4kJ/W0984/nQh0CsTNb0wNZ16BFwQ
         USGBicTmvc/4rYNiDhXJLgSN9cK8V5cOseqEhNs5RBNeWm1/mvttl76UOgbQvS72x2RF
         367t5zam2gKPY1x9cjhxFBciMJ8BtNzvh0pb/vPJMjQ5sjOiJIBF37+K7PlrLXS2NcDT
         DpLKwFyUo4KCLmTPnwTcBpyhFc1625bT4QJAjyY1qf2huGhQwWvHx19roGygpkUdGc6F
         Ownw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161778; x=1781766578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6kc3MFHKXytuLZID0ql8vfVlQxw8tF3bNPdzjICZ2Iw=;
        b=AQN5ug6zL9sCbSfp773XaXvWl3u5/ueh0snFvqfKGWOSaOHPXmEvoF03l1f1aoK7a8
         QWf7oiOSqifpdum7g3w05FYHyWkmFnGdrJYs9Gn2jSdkzaLZzpPYZQIQcNUd1C7d8TvN
         NJ3dUgjdzNg6HpRcjRUNir+PRa0dSCnEHtIujnZImOea3AWgbsf5kktV74xYGs22FKKp
         xa41eTBHPuAd89YLWKZqX/nRzPvLGgSm7ZN1r9bv23KwyoJVUDsHuclwwGwdFsl+hwQG
         vg1A1XBESRUCJfcxW6kX+4zcV1yzErTDP1LPL3eMlEFpWZ8BQlBGViT23KYhFY8qxU2B
         h7HQ==
X-Gm-Message-State: AOJu0YwFJ1gHRjtPa9IuYcmA54Y8kOqaZKGNnjSEJ3RKV0hCBhAALET5
	tdL4euH5jLI8XRsOvlljo4ealnnff7A1yqeJjN9noDiiabqSfjcGdEA0RGO95yRt
X-Gm-Gg: Acq92OHLER6dS0eOUHzrS7VtUWhFh9k9MPsC6uJh4F7HwNSWrz1WFBl/QABj7qI7/MS
	4uJy1gja3cGH/u/l8r+2agy+v3WVGGxKrYatzD0sLrcj5bohnWx8WYzvDxZ5eRfFtitiRGtRw6r
	RJD7SAbMRi4DTKSIray8EUIMFi0rI8XEl51CVKspfKHf1bp8lzfUC8583B9u67ID/HILVb+IViC
	LJEKfRBX8PA02o3gV5SgTcg+cBt0597ubZCTgOenrOLiDcaG2AMmBkHYEC0tNP5/J0XYrbePLlZ
	SzVolTMGEEtU9iHA444KdVR0hZJaS2o1mhdv1KnS9sWD1eXNpgyNjHuG2zcFA8kxOjQReI2Gttq
	mLWrlqSgPg73i8obqu3xWUkO23HpvBECOsIICRmCniqIYXHFqaTxVFELu96UBunOgV7J7/emARb
	txdQD3oDTO24kpVFKUN8EE7yPpZM9ECG92ds+CwBTjWMxUEBDUiVDBao7lUUK/
X-Received: by 2002:a17:903:2f04:b0:2c2:cb80:e4bd with SMTP id d9443c01a7336-2c2f005d132mr19819545ad.2.1781161778122;
        Thu, 11 Jun 2026 00:09:38 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3046::4cf:39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm18818975ad.77.2026.06.11.00.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:09:37 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/5] net: dsa: hellcreek: avoid devlink resource IDs collision with PARENT_TOP
Date: Thu, 11 Jun 2026 15:08:49 +0800
Message-ID: <20260611070856.889700-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611070856.889700-1-mmyangfl@gmail.com>
References: <20260611070856.889700-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297974-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,resnulli.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kurt@linutronix.de,m:jiri@resnulli.us,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7360466F46C

This might not cause real problems, but the hellcreek devlink resource
ID collides with the sentinel DEVLINK_RESOURCE_ID_PARENT_TOP (0). Avoid
it by keeping the real resource IDs starting at 1.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/hirschmann/hellcreek.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.h b/drivers/net/dsa/hirschmann/hellcreek.h
index bebf0d3ff330..95593b5f002c 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.h
+++ b/drivers/net/dsa/hirschmann/hellcreek.h
@@ -311,6 +311,7 @@ struct hellcreek {
 
 /* Devlink resources */
 enum hellcreek_devlink_resource_id {
+	HELLCREEK_DEVLINK_PARAM_ID_NONE,  /* DEVLINK_RESOURCE_ID_PARENT_TOP */
 	HELLCREEK_DEVLINK_PARAM_ID_VLAN_TABLE,
 	HELLCREEK_DEVLINK_PARAM_ID_FDB_TABLE,
 };
-- 
2.53.0


