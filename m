Return-Path: <netdev+bounces-138646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF41F9AE768
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890BCB26360
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D131EB9E9;
	Thu, 24 Oct 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fVLk852m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC881E32AF
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778696; cv=none; b=Mb2Vg3jOBwWte0PRpIX0vlq800Wp9ugsZ4gOYgQi7oX5RHmwcOaTbogPCIrw1CSDAABfcT/nWJZxxkGf25c8GqzM6wpRZMftydtZ5a4zfNSpzUAy0Mla2is6MTWqIQUdECOcLwUcBsb+N9AUX7T4f9LlL26tix0CSUVlXI27cmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778696; c=relaxed/simple;
	bh=d6uVdVofXZGEjZTXu9CRg8oJq4dyLU0txV0kKW3ZHKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqJaZU2pBI28XdhySnnFG8Nwt0xSPSCmtqBC39X14rhYljzqLbJC1tcE9ILNIUXQkVg5Pl++hQbexUD/4VArUxiYbaT7ZHfkKf9K+/j+MxqR5DlQEAb6SqzJj5HfMyu89EWCKr6YGyOLrOnYcjoNFLPZM4JVZvMtcjY/mksGoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fVLk852m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kZ6YqHlJ5NtESw2CvqdAom2NnpjGNWB2B0KtXyRLQyI=; b=fVLk852mxB1cyeiDtKimVk9gKN
	ahm7BDgKMGVUesRrueBOU4kIGERyYJxEn22bVvpHwhKkVMECSozWz1vLC2HyGsQE3KvvqC+S/vSVT
	BA8vuC900tV5/IR4Nh9zyUHXEUKjf3KNlyoAiiCdg5sMWB4FerX2Qr3THr3WeaE8c/5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3yS3-00B83U-2j; Thu, 24 Oct 2024 16:04:35 +0200
Date: Thu, 24 Oct 2024 16:04:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Simon Horman <horms@kernel.org>, Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] bna: Fix return value check for debugfs create APIs
Message-ID: <d7d04629-941b-4efb-84ee-92fbd0f42f9c@lunn.ch>
References: <20241023080921.326-1-thunder.leizhen@huawei.com>
 <20241023080921.326-2-thunder.leizhen@huawei.com>
 <20241024121325.GJ1202098@kernel.org>
 <19322579-a24b-679a-051b-c202eb3750f7@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19322579-a24b-679a-051b-c202eb3750f7@huawei.com>

> Do you want to ignore all the return values of debugfs_create_dir() and debugfs_create_file()?

All return values from all debugfs_foo() calls.

debugfs has been designed so that it should be robust if any previous
call to debugfs failed. It will not crash, it will just keep going.

It does not matter if the contents of debugfs are messed up as a
result, it is not an ABI, you cannot trust it to contain anything
useful, and it might be missing all together, since it is optional.

	Andrew

