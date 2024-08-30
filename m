Return-Path: <netdev+bounces-123554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7DB9654FC
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DB21F24F4F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D41130495;
	Fri, 30 Aug 2024 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJOFVQpH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421114B097;
	Fri, 30 Aug 2024 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983367; cv=none; b=pFGGLU8kRQhPFQD9igRwOivcsIshLTwZzSMTQM+0Nb4lQNtka0StVSMxN5QOATU1pBUX51HyETdsBI+7i1X6LO2UQ405tdsQDWrDYbRlt2WZ9urNKVCRXkbZaR2b52RJfqRO8mCWklyQsI1z8UxZCSDYUIWFHZ0Q9AydEIMUMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983367; c=relaxed/simple;
	bh=aBF7BdEbtvUR3jPGtnebfo8mQ0ewwAnRt6acrSq9Ev0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AzYq1ZzcIqdJJyA8oZT1t4PbrHKw2+sGMtEHuMdWhrhZcNJNDRnDdQAxmtLftZElbVOcAZMe8pjLtIHFdgBoASTjaeQM7obJ84ODEfFxdRcakqpEns5a+zN+CRcDQo+Nhq42XUhsWqM6q6y6ilz7zFTxexyctvGP0y/Rn+PaWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJOFVQpH; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-2689e7a941fso809877fac.3;
        Thu, 29 Aug 2024 19:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983365; x=1725588165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb3cI/l2kR4qi2wOCdvzBBnO2j9CmeaZt8Yl3w3xMJw=;
        b=fJOFVQpHnYZTUIieFc31DXYeHA3QlLOiFxQsEhn494tgo6DZuwa1syVthbEMOjSL5M
         aRhIGmPn/Ek4o5NiB2gwbkViPocHdPFcq3+pOT3GvnezANteFyHGb6bcnPRK+vEXX6CQ
         xNuf6TwDEiMocb6Ik/cWC7vre0mVblh2oH5aPsjRI3lhDlYsKxeqKIeO+GyL32HLZJH2
         6Y66WYsN4WYUQLNH7dEPWogSXOj5GSKIf72IOjedUmyoKVO6RZW//EBF7ua1qXMKB+EW
         DOoSkBo4y8RTAzauQ4RjcdaIkWnph2LULS2/kbxM9JRCHo3Vm3IPu6DpvwPXMz8tO38V
         rqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983365; x=1725588165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb3cI/l2kR4qi2wOCdvzBBnO2j9CmeaZt8Yl3w3xMJw=;
        b=s+jM6YJIL8351n2fvULZAx/6Y2fzTFkpGKCXPdVvIH0oSKlT18XCUY1mGN1mITeXzl
         nCbt90H51j5xTqMWl6tzx/iAuiGpHvVn9474znXOUml0DDOPWT+jn0HOLrjS6S5JNqCA
         hHyrP8fRH6chi6laZ1Xe0iYqSY9GZBq/q7u2O6es4ZK0TUK2U7P36re+Dd9l3FbmyNKi
         yvajaYG8YtYpeccI8dW2WicyZdBGilLR8O7UT/wbygi9EZUWqO5oYGAQDtESGYQCy9ky
         vq9CxFjK64s8hA0HqS9De226FdcjicgQQWYlKKu/QtQgT1iVLKa0yGAbLT/TdT2gYDcT
         1OBw==
X-Forwarded-Encrypted: i=1; AJvYcCVR1l++bz0TzQIEVfCY8rN3d23vy5KSdmF/9/JepzBH4E9r4sJdZgmsP1dYWd5tcHedVxZMKltN@vger.kernel.org, AJvYcCWRsfc6fvxRMv6FxeiVKlXPMuK/fSZKOmvtaN1CfUTF80XrMiYKLCvHK310wYsHKQvSP6vdyXQ/LrxABSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOaKG/WE0Ih6BspgERMCGoOAiCT9St0MwcDKc+OQAGiU8IzolQ
	GFdNb6Q+9IHX1Xrutvt0a4IIs4xQZAy/ww2qBRa8fgxYt7mDd6WG
X-Google-Smtp-Source: AGHT+IFQ8Vi7HEQbuJ3RGHdpRaJsG9O9Ytb9eOWl36HX4fN4OaNwWwJBtZY3HZxNsEakZRTF/fiVsg==
X-Received: by 2002:a05:6871:ca0f:b0:260:e2ea:e67f with SMTP id 586e51a60fabf-27790080fbemr4717643fac.10.1724983364848;
        Thu, 29 Aug 2024 19:02:44 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:44 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 06/12] net: vxlan: make vxlan_set_mac() return drop reasons
Date: Fri, 30 Aug 2024 09:59:55 +0800
Message-Id: <20240830020001.79377-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return type of vxlan_set_mac() from bool to enum
skb_drop_reason. In this commit, two drop reasons are introduced:

  VXLAN_DROP_INVALID_SMAC
  VXLAN_DROP_ENTRY_EXISTS

To make it easier to document the reasons in drivers/net/vxlan/drop.h,
we don't define the enum vxlan_drop_reason with the macro
VXLAN_DROP_REASONS(), but hand by hand.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/drop.h       |  9 +++++++++
 drivers/net/vxlan/vxlan_core.c | 12 ++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
index 6bcc6894fbbd..876b4a9de92f 100644
--- a/drivers/net/vxlan/drop.h
+++ b/drivers/net/vxlan/drop.h
@@ -9,11 +9,20 @@
 #include <net/dropreason.h>
 
 #define VXLAN_DROP_REASONS(R)			\
+	R(VXLAN_DROP_INVALID_SMAC)		\
+	R(VXLAN_DROP_ENTRY_EXISTS)		\
 	/* deliberate comment for trailing \ */
 
 enum vxlan_drop_reason {
 	__VXLAN_DROP_REASON = SKB_DROP_REASON_SUBSYS_VXLAN <<
 				SKB_DROP_REASON_SUBSYS_SHIFT,
+	/** @VXLAN_DROP_INVALID_SMAC: source mac is invalid */
+	VXLAN_DROP_INVALID_SMAC,
+	/**
+	 * @VXLAN_DROP_ENTRY_EXISTS: trying to migrate a static entry or
+	 * one pointing to a nexthop
+	 */
+	VXLAN_DROP_ENTRY_EXISTS,
 };
 
 static inline void
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 76b217d166ef..58c175432a15 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1607,9 +1607,9 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
-static bool vxlan_set_mac(struct vxlan_dev *vxlan,
-			  struct vxlan_sock *vs,
-			  struct sk_buff *skb, __be32 vni)
+static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
+					  struct vxlan_sock *vs,
+					  struct sk_buff *skb, __be32 vni)
 {
 	union vxlan_addr saddr;
 	u32 ifindex = skb->dev->ifindex;
@@ -1620,7 +1620,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 
 	/* Ignore packet loops (and multicast echo) */
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
-		return false;
+		return (u32)VXLAN_DROP_INVALID_SMAC;
 
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
@@ -1635,9 +1635,9 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 
 	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
 	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
-		return false;
+		return (u32)VXLAN_DROP_ENTRY_EXISTS;
 
-	return true;
+	return (u32)SKB_NOT_DROPPED_YET;
 }
 
 static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
-- 
2.39.2


