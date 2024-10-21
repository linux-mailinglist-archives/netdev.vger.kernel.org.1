Return-Path: <netdev+bounces-137620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C29A72C9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3815F1C218DA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410AC1CF7DE;
	Mon, 21 Oct 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNoQXODq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942E2209B;
	Mon, 21 Oct 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537281; cv=none; b=nzb1MFECNCq/qdYP5Z/t7cZDGASwPGupqKWHOVNpFfshj/OWC1YHpWLkRWU34P+A0q1tNKI6mRyuT8mO6iVhzDVq5xgdZgI/y47ojFFW1aUxFe06lCEYN89c2ghA8iS5Iu8A2XirvA31PjvJqofLvu2cQ9yrP9l59Gz/1FTAeOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537281; c=relaxed/simple;
	bh=a7MLIhvKgoWca20O9T3j25ODuB5cY2LujuRS+d01lbc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hnw7sRv1bnL5fjMKJZGmESPxc5W0nV4PP7lerlnLu7QOVyiPqpIG7IpJ8y1B6Z/4CeRFJjDFZRjW/WUSKN7Mw8bW2sEDFVX1Aibo2ztW1vhy3ddG7Mp2A0XN3ndemw6cfohSdEEtC4Ea0+yN8+SKsSeIcSdxYlqBn2JZkmIi4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNoQXODq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6925C4CEC3;
	Mon, 21 Oct 2024 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729537280;
	bh=a7MLIhvKgoWca20O9T3j25ODuB5cY2LujuRS+d01lbc=;
	h=Date:From:To:Cc:Subject:From;
	b=LNoQXODqoaS8EqOShuwAx1DeqlhL0BlHuPpvCVpmQNiRqIkZpzEEhvm3ZZuAgo6lu
	 HMX7HjLCsrQV8vyNhUnqSlXI1Dp05iziWn5aDvE8jMWvw5U3YgePLbyie/DdIXT883
	 eovrShQ7fIIH9Ti9qyo3ckfhZ9Hy/OvPB34KDs31iUlMuSXN67UND26XEK7dlODg3M
	 AE+3WV23vVkUvgIydc23hyp3rnXz/2eulL8Xci5xKC776y5f5OaXPJj5IOMV36pKcA
	 m0P+pgW0B/wv/afgALNMTGZAOv0hHkwwXaCvcrMIXgL4s48ddHd6VKstOJL6KPcxZR
	 mIYSJ6PEhomXA==
Date: Mon, 21 Oct 2024 13:01:17 -0600
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
Subject: [PATCH 0/2][next] UAPI: net/ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <cover.1729536776.git.gustavoars@kernel.org>
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
 net/ethtool/linkmodes.c                       | 14 ++++----
 10 files changed, 40 insertions(+), 37 deletions(-)

-- 
2.34.1


