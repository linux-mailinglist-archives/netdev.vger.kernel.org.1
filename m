Return-Path: <netdev+bounces-205593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B9AFF61B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D540F5A508D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33EA2260C;
	Thu, 10 Jul 2025 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC/mqOg5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97254685;
	Thu, 10 Jul 2025 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752108349; cv=none; b=hgx20JlxsZGw4FjmB3S8xewkToL/x3X5lEBdvlqPGLK6LhjT5GKSDnnIvVZ/QptRIAQmVNJZUKN+ii0DAbBdqKTpvUyCCwrmpJOF3OXlhWjFVX1cw47IvhLyyYYfuW4JvsSoPFxqyucL3BvnhP/zR3P5VxlsVJN1eeTG47GLy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752108349; c=relaxed/simple;
	bh=I8FcxIOIccOF8O3uD9BAyqflfYcKOaUA+uygcdy4BKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWJay1btcqAY74k6XM5LCsEeLyV28p9f8pfZop6rFPqiiGVd4ctq5n0EB/RcxKeKz/eKrqo3PACicyRglYTGWpzrllNhj7Q1CdsOlGaPoakp8CHOz71Zeoc5YsGz5OJleELMK+HcCLYpGt+ZQyGfs4ejuzdsEx2pwrN/FxLQBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC/mqOg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BC0C4CEEF;
	Thu, 10 Jul 2025 00:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752108349;
	bh=I8FcxIOIccOF8O3uD9BAyqflfYcKOaUA+uygcdy4BKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HC/mqOg5BA8Epnm1y8zqbbSKk19YFNBhzplqqtChWA+juYcbly5iZSoUPxeOYG2LR
	 AOGz512aCf5E/ai4n817/p+MKIFRWBPmbKh+FWb1I+zjEFosesRSejyWcqcowi1n9y
	 XZdgM+TBsUDO9p+gC/RugZ7viLF9inOz9L1b6a3mzUvWz22mvFePXBQew/sVOcjgJP
	 g/VFoFEIkJdLDmQOTWgI0Ljip/yIF5CIoXk74zhaRXqg3Y06pBU/XOD4e32Ig2WNTb
	 jHc/tkIfT052ix2dM2jxsaUWIRfD63Ye7+7/5/kaH89ghXIbkf9wTiqlaD3BKgfpU2
	 jDKThEP7PcN5Q==
Date: Wed, 9 Jul 2025 17:45:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Mark
 Bloch <mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Arnd Bergmann
 <arnd@arndb.de>, Simon Horman <horms@kernel.org>, Cosmin Ratiu
 <cratiu@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] devlink: move DEVLINK_ATTR_MAX-sized array off
 stack
Message-ID: <20250709174547.3604c42b@kernel.org>
In-Reply-To: <20250709145908.259213-1-arnd@kernel.org>
References: <20250709145908.259213-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 16:59:00 +0200 Arnd Bergmann wrote:
> -	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
> +	struct nlattr **tb __free(kfree) = NULL;

Ugh, now you triggered me.

>  	u8 tc_index;
>  	int err;
>  
> +	tb = kcalloc(DEVLINK_ATTR_MAX + 1, sizeof(struct nlattr *), GFP_KERNEL);
> +	if (!tb)
> +		return -ENOMEM;

Cramming all the attributes in a single space is silly, it's better for
devlink to grow up :/ Carolina could you test this?

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 1c4bb0cbe5f0..3d75bc530b30 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -853,18 +853,6 @@ doc: Partial family for Devlink.
         type: nest
         multi-attr: true
         nested-attributes: dl-rate-tc-bws
-      -
-        name: rate-tc-index
-        type: u8
-        checks:
-          max: rate-tc-index-max
-      -
-        name: rate-tc-bw
-        type: u32
-        doc: |
-             Specifies the bandwidth share assigned to the Traffic Class.
-             The bandwidth for the traffic class is determined
-             in proportion to the sum of the shares of all configured classes.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1271,12 +1259,20 @@ doc: Partial family for Devlink.
         type: flag
   -
     name: dl-rate-tc-bws
-    subset-of: devlink
+    name-prefix: devlink-attr-
     attributes:
       -
         name: rate-tc-index
+        type: u8
+        checks:
+          max: rate-tc-index-max
       -
         name: rate-tc-bw
+        type: u32
+        doc: |
+             Specifies the bandwidth share assigned to the Traffic Class.
+             The bandwidth for the traffic class is determined
+             in proportion to the sum of the shares of all configured classes.
 
 operations:
   enum-model: directional
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e72bcc239afd..169a07499556 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -635,8 +635,6 @@ enum devlink_attr {
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
-	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
-	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
 
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
@@ -647,6 +645,14 @@ enum devlink_attr {
 	DEVLINK_ATTR_MAX = __DEVLINK_ATTR_MAX - 1
 };
 
+enum {
+	DEVLINK_ATTR_RATE_TC_INDEX = 1,		/* u8 */
+	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
+
+	__DEVLINK_ATTR_RATE_TC_MAX,
+	DEVLINK_ATTR_RATE_TC_MAX = __DEVLINK_ATTR_RATE_TC_MAX - 1
+};
+
 /* Mapping between internal resource described by the field and system
  * structure
  */
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index d39300a9b3d4..83ca62ce6c63 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -346,11 +346,11 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
 				       unsigned long *bitmap,
 				       struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
+	struct nlattr *tb[DEVLINK_ATTR_RATE_TC_MAX + 1];
 	u8 tc_index;
 	int err;
 
-	err = nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest,
+	err = nla_parse_nested(tb, DEVLINK_ATTR_RATE_TC_MAX, parent_nest,
 			       devlink_dl_rate_tc_bws_nl_policy, extack);
 	if (err)
 		return err;

