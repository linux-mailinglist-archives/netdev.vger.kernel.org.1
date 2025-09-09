Return-Path: <netdev+bounces-221417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D476B50799
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289E23AE351
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEEB303A21;
	Tue,  9 Sep 2025 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us8/WfQw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFAB3019D6
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451610; cv=none; b=HBlvbk8cmGfi/uOdws0dwKM+LTFh82YI9q2/6Xskzj7Ecy807DZaLE9a07gOIGKQPgAqAztjIqMapQs9jX3R8Diqez5PJG0CjD+hD7N/qSiSUYsdzlwgYSkVsOdUOr6f+/GgTRMAxzQo4rCK2G9KW3k8Ro3IADFQy4MedGl6uPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451610; c=relaxed/simple;
	bh=Zg5V41kOGMssaiy2ogiz4Rm3NyjYr7Q8Go5BnrR5lpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaRLug9jlBkQ7oVb9idxD3RGrgzBTZulHM7Zjqm6B/KI6iCqJ6Nh7ptwFBn2/3f48sT2akhIFm/v/llQguE4y4Utvi+LwKtcR6EDgpxMA3LQeTkw2owgXuDnns11YElGJiNDAxEzzvGEsmeUn0wtjpdcVt9KnvknuFg7UA1j6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us8/WfQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B256C4CEFC;
	Tue,  9 Sep 2025 21:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451610;
	bh=Zg5V41kOGMssaiy2ogiz4Rm3NyjYr7Q8Go5BnrR5lpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=us8/WfQwp9elB1IpOrQYUu3th0ChhtICXnbsg4+3xfU1SsVVB2sZhhAo2xqF9pvIv
	 D6BvwgtHyAO7foMnpk6aAb4rzlywIMSmUeF/hFbnL+oacL8HR2iolUwXo4g1Cw/o8w
	 lS3HaKCPRr/I9Rs53Fk5iDI94q/3C6z6tUFAom2yJtVXzPLh4V5J89eiFyG0FiF7aB
	 pR6qAmmEYcCtGvgaN95q229YhmNM2AE1o+Y0o0uWTP+WPqSvM+eoqdCGOT4TDyEwL5
	 e98mGMQfG9gwCYa9j+UF2KQo4IAll0K4hhCOOyVZvJEGPYrO4Ki9jJjWbDyF/BHu/A
	 YTE2Hir0t4ikg==
Date: Tue, 9 Sep 2025 14:00:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: mvneta: add support for hardware
 timestamps
Message-ID: <20250909140009.33a1ea82@kernel.org>
In-Reply-To: <aMBTKTz6Oi0bzI6B@shell.armlinux.org.uk>
References: <E1uw0ID-00000004I6z-2ivB@rmk-PC.armlinux.org.uk>
	<aMBTKTz6Oi0bzI6B@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 17:17:45 +0100 Russell King (Oracle) wrote:
> If a driver has skb_tx_timestmap() added, should the driver also
> fill in the ethtool .get_ts_info() method, presumably with
> ethtool_op_get_ts_info() ?

Yes.

