Return-Path: <netdev+bounces-140134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7129B555E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E91E283CC4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F043209F24;
	Tue, 29 Oct 2024 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iel0o12Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127520823D;
	Tue, 29 Oct 2024 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238906; cv=none; b=RRBqgkcpHg0Pj4KQMAMC+0OWARkFMdopapxjyI36V97ln6m/Y9QbDdqxNWKWJOQRLeVSXRZ3oTpcEhQzRoWJlX8JZzgtXhu00fzpHVRc+cNiG3xeSvRMD+hxcRLvynX4bsh5TPz45gZyn46GVo/XlScHMnbwzJ6gJ2gzISFOrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238906; c=relaxed/simple;
	bh=W3V1cUMtwprKr9to4tQBjItpnObSfwcOm0CgaH3waOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YoTLYPjihq6zsS/vscWUs17woUvNwgXycPDn/lbDJQ7qHZWT/2cuqyfmEzatMgXtDYQ3+8IcEJ+YBQb4t5bUmuVwINmC/9gLHRLWc/GN+rSN7VJczpC8Ut+ZrujYqbSMaDuz0r7cnktCX8TD2+yf7g9x3b6TL8Lc0GvtYeOrcZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iel0o12Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6CFC4CECD;
	Tue, 29 Oct 2024 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730238906;
	bh=W3V1cUMtwprKr9to4tQBjItpnObSfwcOm0CgaH3waOI=;
	h=Date:From:To:Cc:Subject:From;
	b=Iel0o12ZEpVz/mtTpAQcdwMDA+pB9XV0hEyiGtqsSUEMeSjANgmnXhD1RajtCQPOm
	 /iA4T+qD/SwzKM+ATD3PW8rObrItIWCRxC3dptmG1pIKSpsfZUrQw+Eq7yAVOdZ98v
	 Dq2DZKXnZmkCQILk9D9A1NGSWWRE9XMtlGgZXB6we5Sr/7bSW3N81RC+AxRgoU5ipC
	 ZGVYcmF2NmG8Chv5aExgY+2imr5P7lOe4n3CA/dYa2icTC7glYK2Cd+msfVEzy/NZd
	 RGKO6JTxM/lc7XpiuDU+Temba6WtIlEC1mSvAz7uZx/CWLb1a6lEUB89fx54pZxYBN
	 0a/wpcXCqNJcQ==
Date: Tue, 29 Oct 2024 15:55:02 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2][next] UAPI: net/ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <cover.1730238285.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Small patch series aimed at fixing thousands of -Wflex-array-member-not-at-end
warnings by creating a new tagged struct within a flexible structure. We then
use this new struct type to fix problematic middle-flex-array declarations in
multiple composite structs, as well as to update the type of some variables in
various functions.

Changes in v2:
 - Update changelog text in patch 2/2 to better reflect the changes
   made. (Jakub)
 - Adjust variable declarations to follow the reverse xmas tree
   convention. (Jakub)

v1:
 - Link: https://lore.kernel.org/linux-hardening/cover.1729536776.git.gustavoars@kernel.org

Gustavo A. R. Silva (2):
  UAPI: ethtool: Use __struct_group() in struct ethtool_link_settings
  net: ethtool: Avoid thousands of -Wflex-array-member-not-at-end
    warnings

 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  6 ++--
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    |  4 +--
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  2 +-
 .../net/ethernet/cisco/enic/enic_ethtool.c    |  2 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  4 +--
 include/linux/ethtool.h                       |  2 +-
 include/uapi/linux/ethtool.h                  | 33 ++++++++++---------
 net/ethtool/ioctl.c                           |  2 +-
 net/ethtool/linkinfo.c                        |  8 ++---
 net/ethtool/linkmodes.c                       | 18 ++++++----
 10 files changed, 44 insertions(+), 37 deletions(-)

-- 
2.43.0


