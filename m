Return-Path: <netdev+bounces-210805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82838B14E5B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1564E1C30
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91F614EC62;
	Tue, 29 Jul 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwWhuKB/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32C79E1;
	Tue, 29 Jul 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795692; cv=none; b=RMFVgpeMpDpFsF94cVkoyESmO4ras55+BZnoAT/F2pVF9smFU5IL3duWzVNdRZ8cWLaol+aNafWvf0X+GjHX/kV9NenpQHDjYCK+7FfBps/6TlQgcX/S3FINx9DLkEMM7ZLKT8WGZmH+aA+acMBjn/vcVKmgHtirbs94poC6nB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795692; c=relaxed/simple;
	bh=urEre5Ii7miPxcwy180JSXAw0Sr9MquZ6quc0ap7TOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmUmTx3lIN3BBjQOO1Fm/0NtdDjU4RBUzR9KGCVN9oHWndWmRnO75TveN2CYIEAPa946a9KFyg1/kpCl8x8OYNnvUeivB4ujW/QzPb/l//q5PImelFkO4hO19nIkNHlmAzH71ogLNnttOIGo3d/tLGXmaSRjEpYGqsLyOX5GcDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwWhuKB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A295C4CEEF;
	Tue, 29 Jul 2025 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753795692;
	bh=urEre5Ii7miPxcwy180JSXAw0Sr9MquZ6quc0ap7TOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwWhuKB/HEUtgrAXpPfXXeirO/HKFboUWuaF1SoSlkmeVzu1S0tgoO8NW3pnI3dZ2
	 gkH3hNDSUfQ588q6JT8xQWLXBsoGCHK+F1lr+bZXeUQ9Xuk76TTPSYRSSMalvO5g9K
	 AqtRsmZXIEs7lk7uE/H79eGxUIRlenZa4viu/hNACuZmnC8+Acyml4MyWD3zd2TSry
	 3Qz32TUyWsTnlHKzfLzhnWWVOc21L7ZtqasQoRQ5KGPPgADZ957aGSqEotKmHMntcs
	 +yj4SXuWIdsT2O31aaQvEvq6Sd2SjWjmu5N+PRrL4OSEg36MIhyCV3fBiYFVjK5Oru
	 0JcCaM5pnqPvg==
Date: Tue, 29 Jul 2025 14:28:08 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tian <27392025k@gmail.com>, irusskikh@marvell.com,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: atlantic: fix overwritten return value in
 Aquantia driver
Message-ID: <20250729132808.GD1877762@horms.kernel.org>
References: <20250729005853.33130-1-27392025k@gmail.com>
 <3ef5e640-9142-4ebb-9b0d-a6c62e503428@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ef5e640-9142-4ebb-9b0d-a6c62e503428@lunn.ch>

On Tue, Jul 29, 2025 at 03:39:01AM +0200, Andrew Lunn wrote:
> > This patch uses `err |=` instead of assignment, so that any earlier error
> > is preserved even if later calls succeed. This is safe because all involved
> > functions return standard negative error codes (e.g. -EIO, -ETIMEDOUT, etc).
> > OR-ing such values does not convert them into success, and preserves the
> > indication that an error occurred.
> 
> 22 | 110 = 132 = ERFKILL
> 
> How easy will it be for somebody to debug that?

Hi Andrew and Tian,

I agree that this does not seem to be a good approach.

Looking over the code, it seems that we can just bail
out if an error occurs. Returning error codes as they arise.

Does this seem reasonable to you?

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
index 7e88d7234b14..6c490f61ce5c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -492,6 +492,9 @@ static int hw_atl_utils_init_ucp(struct aq_hw_s *self,
 					self, self->mbox_addr,
 					self->mbox_addr != 0U,
 					1000U, 10000U);
+	if (err)
+		return err;
+
 	err = readx_poll_timeout_atomic(aq_fw1x_rpc_get, self,
 					self->rpc_addr,
 					self->rpc_addr != 0U,
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
index 4d4cfbc91e19..48f7c863c04b 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -101,11 +101,15 @@ static int aq_fw2x_init(struct aq_hw_s *self)
 					self, self->mbox_addr,
 					self->mbox_addr != 0U,
 					1000U, 10000U);
+	if (err)
+		return err;
 
 	err = readx_poll_timeout_atomic(aq_fw2x_rpc_get,
 					self, self->rpc_addr,
 					self->rpc_addr != 0U,
 					1000U, 100000U);
+	if (err)
+		return err;
 
 	err = aq_fw2x_settings_get(self, &self->settings_addr);
 

