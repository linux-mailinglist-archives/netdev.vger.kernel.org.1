Return-Path: <netdev+bounces-227260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D3BAAE7B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15ADF7A3FDD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6413D8B1;
	Tue, 30 Sep 2025 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f73XlsS9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123735977
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196388; cv=none; b=pSJcuOwNb0BwaA8y6N2fG3mHW9x3L0PGloZFt/79ofL4shTBJ5mU8gI3IJwPiJDcDEel4K9WgRuF2Aceb/Eg4EvjzpSofpOk/Pmm94dh4bsxmaIeW9Uolyqw/PpsRTyhFDp0qYWYomqOwjs+Ya/fz3wTFjGMH/ew9Ew9xNUi1yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196388; c=relaxed/simple;
	bh=ru0TFcgjnZTFAmLpU4ims2fYrxccZfrqbo1j+c/AMvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHr4nmGrFru2onOjFjcgxsyw0EfQPOG4QaCjltR63kDZQZGBTzDLJbG//uD1j3FgYGrtCiBz7NJZm4HiqyDImmKiBj94ZEJWMqVHS5lWLRL+cEv9AUiYDEykod4qVjSKvp3LMc5Sgaq+TmuZAzHQl+pzD27QGwYzU9OZU+QoYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f73XlsS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B50DC4CEF4;
	Tue, 30 Sep 2025 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759196388;
	bh=ru0TFcgjnZTFAmLpU4ims2fYrxccZfrqbo1j+c/AMvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f73XlsS9J2ypUusiWF9DNWe0ihlAyZfXhPrd8BBBRCDW021zBIYT2JvttQl1CX7BQ
	 VcanUxyeNz6heC3pM7UT/zdlDX7zDvJpznfvBOXaO0RW6QSDYH7g5QdrBN8+XfpAWZ
	 pcgIW+6ejxF7khtRCGeYiDGzRwzx/h2EbGT4LPMWNgPM0d4g0BZndunl7TY9Z5rZix
	 wnjxqCoBTO59ZNHTr7pSvMSOT1jXu9NMOwY6DYkbxVQbYkpUz40k1+ulqZsB07FFKm
	 epKRr+0Ss46eHjQuJtcrHwwbInugbqm2xrQYL9wy9F4X9Q2Ceq22xEQbeVq3Gc4xl+
	 WhtxFxSCd8DwA==
Date: Mon, 29 Sep 2025 18:39:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 2/3] net: txgbe: optimize the flow to setup PHY
 for AML devices
Message-ID: <20250929183946.0426153d@kernel.org>
In-Reply-To: <20250928093923.30456-3-jiawenwu@trustnetic.com>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com>
	<20250928093923.30456-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 17:39:22 +0800 Jiawen Wu wrote:
> To adapt to new firmware for AML devices, the driver should send the
> "SET_LINK_CMD" to the firmware only once when switching PHY interface
> mode. And the unknown link speed is permitted in the mailbox buffer. The
> firmware will configure the PHY completely when the conditions are met.

Could you mention what the TXGBE_GPIOBIT_3 does, since you're removing
it all over the place?

