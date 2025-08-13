Return-Path: <netdev+bounces-213140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0E9B23DA2
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A995F1B6033A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF333991;
	Wed, 13 Aug 2025 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9EW8JTP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62562A1AA
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755047716; cv=none; b=rLdbVc7V+VYWpanSFNzn+IrgwiiQCg1BcJOwvz2Vd98dTnIeIRGyBLxM1TcLcjBo2upMEWe1gyQ9/hUf5dDXXQwc8R5hbjdPUHqNVL3aHc7gh3DR4kwY8nhlTwHjyIj5ifzT5ly145ywbOxGADiy8Xc+w2XLtb4yaKAPleRkohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755047716; c=relaxed/simple;
	bh=MJ9VWpz1qUr5xoTXEcGHgxXNuvgQFJoO8s2+y+R7Rm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ybiu7qk7Cwz1a4V0oyYfQawzw5rmsjDwA37jVi7MQMFuqw4oUcYWukl6prpTYYNEvOnwY4lN8+tRx4nSpiK0jjF4pjnBQhJLG1OtigVO4byRqDFZ+ltqa3+JkHSnJbGdKN3RP08fTEt+4A3q2/SpDoix5shmmNl8iT6atlD6u1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9EW8JTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07AAC4CEF0;
	Wed, 13 Aug 2025 01:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755047716;
	bh=MJ9VWpz1qUr5xoTXEcGHgxXNuvgQFJoO8s2+y+R7Rm0=;
	h=Date:From:To:Cc:Subject:From;
	b=t9EW8JTPYcjKb7bjHaV/vAtwr+R+9ZghuNXt0lnTFplKrHLt5iVRMRqqOP4uqeTFz
	 pBFBBwoniAwU+oDAbZAVdakPYMplKMmlyFpTR7HnvPAuiZYdUn1DSwiCYbH4FIlfCr
	 K11/rC+1Q1qOymVmOZ5AX5Hn3gO90aMvma1Hu3p6fdBCKR5K9OYPx7yONON9F2V1Hs
	 D/8iW2grCKUfzq85BGcMm/jp0zRsOF4uInsdVxD97eXsId2CWAqRCI6dIcMfQXhyGS
	 r7m3zvGM4IIxHNLns8SoriYJaN/ET55AGgOkMl38aWrVuPfP0f2/P550JYL7JoQtMo
	 BArt1S9qerr/w==
Date: Wed, 13 Aug 2025 08:58:06 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Subject: [RFC] mdio demux multiplexer driver
Message-ID: <aJvjHrDM1U5_r1gq@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Assume we have the following implementation:
          ----------
          |mmio reg|
	  ----------
             |
 --------    |      -------
 | MAC0 |--MDIO-----| PHY |
 -------- |     |   -------
          |     |
 -------- |     |   -------
 | MAC1 |--     ----| PHY |
 --------           -------

Both MAC0 and MAC1 have MDIO bus masters, and tie together to
a single set of clock and data lines, which go to some PHYs. While
there's a mmio reg to control which MAC mdio master can operate
the single mdio clock and data lines, so only one MAC can operate
the mdio clock and data lines.

We also need to fully support three use cases: only MAC0 + PHY is used
on board; only MAC1 + PHY is used on board; MAC0 + MAC1 + PHYs are
all used.

How can this be modeled in current mdio? It looks like a kind of demux,
so my initial plan is implement a mdio-demux driver, which firstly
switch mdio master then call the master's corresponding ops such as
read, write, read_c45, write_c45 and so on. What do you think about
this RFC? Any comment/suggestion is appreciated!

thanks

