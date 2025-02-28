Return-Path: <netdev+bounces-170519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B6A48E71
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8908E7A244E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735FB433AC;
	Fri, 28 Feb 2025 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT3jyfR7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AA3D3B3
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709137; cv=none; b=Cl4IKd0/Mwj+0whHdj0MebX0rTZLGyQ0KaEzzL9NMboCQtcKmuKW1TxNGwMniYo3XHCK8TUuM5paSoB+dQXDMBa4CjRQFSCQWuAjJJez0dTTLHzB+V0DZlchgrZHX3QQ7GW/2wKEb7TL9hWax/t41lFKtkWnAZN++IBdlEpYMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709137; c=relaxed/simple;
	bh=V8wyvQvs+a0fV35fPpcbTVCElLtrpl9YLqEwbW4UYyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPF6iYri/1PN7cC+xFW8lryefrnGg1jH2fo00B9IFHl/mTogDKgaWWZOBdUeS9aKI7UYa6hCzU9F1sPt0QTdF8kdGFPCpcYIRZjiBO66prQ5WAJ01rmR5fsa8IpPguugGxVb8+xShwcQWpvqKom0dBPtpkn1mb9wB5FZneyo0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT3jyfR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA8BC4CEDD;
	Fri, 28 Feb 2025 02:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709136;
	bh=V8wyvQvs+a0fV35fPpcbTVCElLtrpl9YLqEwbW4UYyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=kT3jyfR7ZSycq/kixrsQ9pg2LSRLzLYDCDFf+/JtjU2qK5B58drv4NJ9MMR+6bwGf
	 PVvhQo6NF6yXz1PHQKuP4pJViJ1FaqvbovZit7G6tG3At5YKSHIyHXecOULA639uYn
	 V6Xc2S2TwrMJ8P/M/ZxQMqulwzte/32xrE/bLacBETPUMH1prNhdjloaC0zSfSERWX
	 G44K5ZmVDbsUfgBNRse0wHwZSKAILm8vk/kmPGlc2d5KaG2wL5xTMo6jB7rXy1IdTP
	 VUewgd4qqwuB0jo+e7aEvBzUSZZ6bsNQgWYykm7I7zfwor1ZSyTh4GNRtFiZ748cqm
	 UzcrVmZun1y4w==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 00/10] devlink params nested multi-attribute values
Date: Thu, 27 Feb 2025 18:18:27 -0800
Message-ID: <20250228021837.880041-1-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This patch series reworks devlink parameters and introduces support for nested
value attributes. It also adds support for showing and setting port parameters
with multi-attribute value data.

example:
     $ devlink dev param show pci/... name multi-value-param
        name multi-value-param type driver-specific
        values:
          cmode permanent value: 0,1,2,3,4,5,6,7

     $ devlink dev param set pci/... name multi-value-param \
            value 4,5,6,7,0,1,2,3 cmode permanent

This series is based on the following devlink kernel patches:
https://lore.kernel.org/netdev/20250228021227.871993-1-saeed@kernel.org/

Thanks,
Saeed

Jiri Pirko (2):
  update kernel headers
  devlink: use dynamic attributes enum

Saeed Mahameed (8):
  devlink: param show: handle multi-attribute values
  devlink: param set: reuse cmd_dev_param_set_cb for port params set
  devlink: rename param_ctx to dl_param
  devlink: helper function to read user param input into dl_param
  devlink: helper function to compare dl_params
  devlink: helper function to put param value mnl attributes from
    dl_params
  devlink: helper function to parse param vlaue attributes into dl_param
  devlink: params set: add support for nested attributes values

 devlink/devlink.c            | 689 ++++++++++++++++++++---------------
 include/uapi/linux/devlink.h |  18 +
 2 files changed, 422 insertions(+), 285 deletions(-)

-- 
2.48.1


