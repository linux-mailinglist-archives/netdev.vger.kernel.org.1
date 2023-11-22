Return-Path: <netdev+bounces-50229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0677F4F5B
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D7D281306
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D65D48A;
	Wed, 22 Nov 2023 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfx7RL1y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BA5D482
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 18:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41197C433C7;
	Wed, 22 Nov 2023 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700677428;
	bh=yZFggWdceu7rn7hUogOUO9F9Pf31Wzul4TPKXAC/3U0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cfx7RL1y4ISdbaje+SGuou7CtcmZrlVSo+mA0tr2l4eyuKze0qLS9FLGsH/Uvv546
	 s7lFQoD9HyEbwfoxy4Cvr6kIYavw/xkIhD5Bn5iNAQKfzXemwOgQb3bplHnFm5BIg7
	 w5kgoNaYBleytc03xf9iMLLT8dpedTeV5o0w4OEXK1C+iS0AJ4kNeMn1VzMRH5PHgQ
	 U4MvOpuzoVT+CffnRb3OADnazbboACsZBf0jhbD2rj8OQrhsqR4YB24oNzNd2p9IGm
	 gmTmjf9ABiSuJpyWpqzQ0LvRp116ghdK8gRzUr9Sq4s4P6kzIC1GKYmZwcBH5PdgmM
	 +k9NrEe+MlV+g==
Date: Wed, 22 Nov 2023 10:23:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Robert Marko <robimarko@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
Message-ID: <20231122102347.0bde86bb@kernel.org>
In-Reply-To: <655e4025.df0a0220.50550.3d70@mx.google.com>
References: <20231122170813.1222-1-ansuelsmth@gmail.com>
	<ZV45UY6nYZ/WAHpG@shell.armlinux.org.uk>
	<655e4025.df0a0220.50550.3d70@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 18:53:39 +0100 Christian Marangi wrote:
> So they DO get converted to the HOST endian on reading the firmware from
> an nvmem cell or a filesystem?

They don't get converted when "reading from nvmem / fs". 
They get converted when you do:

		word = get_unaligned((const u32 *)(data + pos));

get_unaligned() is basically:

#if BIGENDIAN
#define		get_unaligned	get_unaligned_be32
#else
#define		get_unaligned	get_unaligned_le32
#endif

so you'll get different behavior here depending on the CPU.

