Return-Path: <netdev+bounces-49843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC547F3A86
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375C2281B1F
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB632BB03;
	Tue, 21 Nov 2023 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD0Q3Q7N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E82BB01
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 23:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FED0C433C7;
	Tue, 21 Nov 2023 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700611094;
	bh=RpcmV04Y5XssEbTca1q02Yjdopi3rB3NOK/3fMzbaj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jD0Q3Q7N3DsvX6sLJReEOxJuUr9/ay4yEYPRnx698HUHlGRgTCPpBt3q4r9+o6gZe
	 CdEpwa3ZmVSqGU/WfS8ZmnVNqQzDwM+cTK/9oWT4kpNOPYnGaYavXIfHnC9zmYE8Ec
	 1h0u+oVutz7lXx5+R7W+J1NL8A9By3MsAVg1RHyoEr+uMQbkkeniXaz3mvDF49v7ae
	 UH0ZZ8Emd1vsM7p0XPScgRve5l+PVPeBcdP2kz2bENuCJvP6bCsMHZErIl4HONK0uO
	 xIb1Ue7tcP2TFfd3TweP38mRGs5X74zX1VYyBI5VSZHjM8k2lLcHNW3dYHhmpM1AOF
	 jt/jgsQi9wk5w==
Date: Tue, 21 Nov 2023 15:58:12 -0800
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
Message-ID: <20231121155812.03113405@kernel.org>
In-Reply-To: <655d41b4.050a0220.36e34.359e@mx.google.com>
References: <20231120193504.5922-1-ansuelsmth@gmail.com>
	<20231121150859.7f934627@kernel.org>
	<655d3e2b.df0a0220.50550.b235@mx.google.com>
	<20231121153918.4234973d@kernel.org>
	<655d41b4.050a0220.36e34.359e@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 00:48:01 +0100 Christian Marangi wrote:
> > Not so sure about this one, it puts the u32 on the stack, and takes 
> > the address of it:
> > 
> > 	u32 word;
> > 
> > 	word = (__force u32)cpu_to_be32(word);
> > 	crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> > 
> > so the endian will matter here. My guess is that this part is correct.  

Actually I'm wrong about this, you're reading and writing the data,
so endian conversion happens twice. Canceling itself out.

> Ehhh this is problematic. Data comes from nvmem or filesystem, in theory
> they should not be touched/converted.
> 
> nvmem_cell_read or request_firmware return pointer to u8 and it's the
> firmware (that is always in LE)
> 
> If data is not converted and passed AS IS from what is read to the
> allocated data, then data should be always swapped.
> (this PHY is fun... it's probably BE internally but expect LE stuff in
> the mailbox, as it does emit BE CRC.)
> 
> Any idea where I can verify if nvmem_cell_read or request_firmware makes
> any kind of endianess conversion on the data it does read?

The underlying storage should be byte-accessible, so neither interface
should change anything about the endian.

You should probably switch get_unaligned_le32() for reading it into 
the word variable, tho.

