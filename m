Return-Path: <netdev+bounces-49837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB67F3A5A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B309E1F2321A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD00C56750;
	Tue, 21 Nov 2023 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhFltCL0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A754BF6
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 23:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DD3C433C8;
	Tue, 21 Nov 2023 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700609960;
	bh=RszxG6K3d072jCkBLTpgU6IMlmbsLSh8U2l2W3DjB44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PhFltCL0gbtiIIW1uBM0Rn2oSxvzt0/b0DVLL45rNn90lyd/b9GmKyzps6Mi39Qht
	 7oTRbeOBlMQYX2hlDp6/lyuWy7Kyh1W0q+3fnblhM20p4Y23sxo3v9V5BVtuZFVCqL
	 6UKvElsYYkddh3T/jLy3D94Vwg5DQt2PPh/Yfs4y4Q3NgEVCbP1Bg2ongMRwODTZKW
	 OCDGO6IODTj2VQE3A/zeHiqIK7n0K82RbUPO26Hm2uLm4div8Pr5mJgexoLxiYAtfV
	 46AoiSX9uHpF7pXuMA6AAyjAJBSlfwSyO7Lof/2rwESyJwE/XHLj3O5nNUAMfz6eCq
	 jf8Ac3+K6e7qQ==
Date: Tue, 21 Nov 2023 15:39:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Robert Marko <robimarko@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: make mailbox interface4
 lsw addr mask more specific
Message-ID: <20231121153918.4234973d@kernel.org>
In-Reply-To: <655d3e2b.df0a0220.50550.b235@mx.google.com>
References: <20231120193504.5922-1-ansuelsmth@gmail.com>
	<20231121150859.7f934627@kernel.org>
	<655d3e2b.df0a0220.50550.b235@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 00:32:56 +0100 Christian Marangi wrote:
> the 2 addr comes from a define
> 
> #define DRAM_BASE_ADDR		0x3FFE0000
> #define IRAM_BASE_ADDR		0x40000000
> 
> it wasn't clear to me if on BE these addrs gets saved differently or
> not. PHY wants the addr in LE.
> 
> On testing by removing the cpu_to_le32 the error is correctly removed!
> 
> I guess on BE the addr was actually swapped and FIELD_GET was correctly
> warning (and failing) as data was missing in applying the mask.

I think so. It's the responsibility of whether underlies 
phy_write_mmd() to make sure the data is put on the bus in
correct order (but that's still just within the u16 boundaries,
splitting a constant into u16 halves is not endian dependent).

> If all of this makes sense, will send a followup patch that drop the
> cpu_to_le32 and also the other in the bottom that does cpu_to_be32 (to a
> __swab32 as FW is LE and mailbox calculate CRC in BE)

Not so sure about this one, it puts the u32 on the stack, and takes 
the address of it:

	u32 word;

	word = (__force u32)cpu_to_be32(word);
	crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));

so the endian will matter here. My guess is that this part is correct.

