Return-Path: <netdev+bounces-175400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63676A65AD3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA1B16E674
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E9619F40A;
	Mon, 17 Mar 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKXf6Y5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CA323D
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232775; cv=none; b=J4XzAUaTxE33Su16weihOX4/XjEzVBTieKn6xSVDomVT3AaqchQukclABtUEk8lt8gNTTywx1IH5Y/i1B9OWRBogVkUr5TiEx8wV0hjYxbdtqQn21AtU1IwjSzNZd0qNoCvgwfrz2RR3fWhX5HUfgZQzo3lKGr76J8DD/8mg1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232775; c=relaxed/simple;
	bh=etRNOSTYd8peP13e+WEuBLs3dcxOGaUpLwiMM7hmM7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RQMy629v1No15kIp61d5Jl/ZFBeP2k/mNYmfr9Brju6AJm1AuCL05DBLUyIEX6p4nLGpk1Qm1jStZr4zOnc7w9lF61L9jggDeFX41Ec63x9XZcW5P4nqfqE5pavSNIiphb4+8tBSI3dWUhehJdqeenSuBJZGYn5+BO1ZHv0yECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKXf6Y5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E15BC4CEE3;
	Mon, 17 Mar 2025 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232775;
	bh=etRNOSTYd8peP13e+WEuBLs3dcxOGaUpLwiMM7hmM7o=;
	h=From:To:Cc:Subject:Date:From;
	b=kKXf6Y5bI1QCLPUiPJP5CON9L8Ne4EeAEL67fXUsKyCl4SFfqpYByd/ckluGvSgNu
	 9O5tlgx6Hruu1beJoN9ul0u/mjUa8KGtAtFoHcU/bdltBcBI0+irfqxI9oj8OnxxCb
	 LkqC1IWyPk251uua2LCItd5X/cN4iKFXUDnuLbh1IvwmPuwK4wCl9BMcWMgjmBpRGQ
	 Yeh0b2HZ4Fr8dKhLwLFOjd2nAnu36ybdmkXwhhp3JAZ56Hcb6LNz7q+aaZwLnhcEt+
	 mtJCY0GhnhsoaYaH1OxrZGW/tYPLjn1TZFKSFtygku/etTkL3w/xn/WbFMISy9NODS
	 So4gbrI72lmQg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net v2 0/7] Fixes for mv88e6xxx (mainly 6320 family)
Date: Mon, 17 Mar 2025 18:32:43 +0100
Message-ID: <20250317173250.28780-1-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Andrew et al.,

this is v2 of fixes for the mv88e6xxx driver.
As requested, I left only the fixes that are needed for our board
to be backported, the rest will be sent to net-next.

Marek

v1 at:
  https://patchwork.kernel.org/project/netdevbpf/cover/20250313134146.27087-1-kabel@kernel.org/

Marek Behún (7):
  net: dsa: mv88e6xxx: fix VTU methods for 6320 family
  net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
  net: dsa: mv88e6xxx: enable PVT for 6321 switch
  net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
  net: dsa: mv88e6xxx: enable STU methods for 6320 family
  net: dsa: mv88e6xxx: fix internal PHYs for 6320 family
  net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320
    family

 drivers/net/dsa/mv88e6xxx/chip.c | 44 ++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 8 deletions(-)

-- 
2.48.1


