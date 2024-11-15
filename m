Return-Path: <netdev+bounces-145408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE79CF64E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF41282E40
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684AA1E3762;
	Fri, 15 Nov 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgnXoeXy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC61E284B;
	Fri, 15 Nov 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703392; cv=none; b=Z/EEsM8J2UXwsFwGlb93HEV5ov/WvgKjJEuKjwIyv1lBT5B3C9sr+28HI5PoVjYoUiTcnjn16O8qkJ7SGSV/4SD1kypBvldz3Ir5Zc7f/qpT1sN+zRoYNtP7Cz/ji1SK+IoLdQc7s6PevMAWPDIjd1jGxsqseFHlGVUUrIoKyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703392; c=relaxed/simple;
	bh=Ccs4+fxbEG0SXm2z2piX1zTfr7x8e6ZLDBkf7LQCW0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ACVH3rqAV6HSBkZkHxyiu6h/LxPU6mvArFNAdpHcLvMjFs0s/1nEXJ4WNUUVEyyP+CZyM72ED3P9kPSlh+iOi3jmC9KC/zWUTiEVxaWLUJObKPuLqUxEDty5MKN9lGoKZHQJSW/+MzrQZeBVibWwTgU6nXG7jood59FQkF7nRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgnXoeXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D32C4CED4;
	Fri, 15 Nov 2024 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731703391;
	bh=Ccs4+fxbEG0SXm2z2piX1zTfr7x8e6ZLDBkf7LQCW0A=;
	h=From:To:Cc:Subject:Date:From;
	b=KgnXoeXyOJo2ZDRajin/E3J7ga/4Y72rL6+Oio1pyTuJArJsxFTfbzL+uRUbO0Rey
	 /nUwu50ecx70AEdAn3UO0Cg8AtZlK4uYqKucFzUIk3pLMf4c/7SjDX4RanolvPYXok
	 4XNh6cI3GmJwKqNIQ3yCioEXnBr9OeZOOUmjka6hIdFTEJHnOmhSJtLG3QC60ETbcN
	 lAiVpXJmPS8oQth4ITqqj7pULcSk8JlqptS3N+W/+Dz1/oc/U4iQZWW4l8AA20MAif
	 DtSDnaLvsRZmB8hFk71Msmf2t7cfVyE2DY1AQjEX32RTQzw8b7L4e9tTkFZKhUwVBg
	 bREL38GLX1izg==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Takeru Hayasaka <hayatake396@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] UAPI: ethtool: Avoid flex-array in struct ethtool_link_settings
Date: Fri, 15 Nov 2024 12:43:02 -0800
Message-Id: <20241115204115.work.686-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=kees@kernel.org; h=from:subject:message-id; bh=Ccs4+fxbEG0SXm2z2piX1zTfr7x8e6ZLDBkf7LQCW0A=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnmmyKKYlbuD2BQyuOW2RWzxnWZtJ+M3Qz1lZt09tiJR ZvFbCztKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMhqUYa/ssfXyZ/s3ae/ZFGU 8xn95deMgyQda/0T5gXkHpLxFVDqY/gfyF204Jj5EtXzfHGKtpuSF+6cz3In5wPv/V2Z00/WP+f mAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This reverts the tagged struct group in struct ethtool_link_settings and
instead just removes the flexible array member from Linux's view as it
is entirely unused.

-Kees

Kees Cook (3):
  Revert "net: ethtool: Avoid thousands of
    -Wflex-array-member-not-at-end warnings"
  Revert "UAPI: ethtool: Use __struct_group() in struct
    ethtool_link_settings"
  UAPI: ethtool: Avoid flex-array in struct ethtool_link_settings

 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  6 +--
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    |  4 +-
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  2 +-
 .../net/ethernet/cisco/enic/enic_ethtool.c    |  2 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  4 +-
 include/linux/ethtool.h                       |  2 +-
 include/uapi/linux/ethtool.h                  | 40 ++++++++++---------
 net/ethtool/ioctl.c                           |  2 +-
 net/ethtool/linkinfo.c                        |  8 ++--
 net/ethtool/linkmodes.c                       | 18 ++++-----
 10 files changed, 44 insertions(+), 44 deletions(-)

-- 
2.34.1


