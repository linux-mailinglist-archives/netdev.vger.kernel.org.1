Return-Path: <netdev+bounces-179941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E332A7EF5F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9F716AA8F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15439205ABF;
	Mon,  7 Apr 2025 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="csqrYtYL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DD190485;
	Mon,  7 Apr 2025 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744058363; cv=none; b=VY8Z5Kj4wjXG9zo5is6AviU8M7pxuqY4dMtyqheANDAZfUyDGdMqYc6k9HZSBHR8M4TIph8P1RDB7QWNaic7ZcLIB18xZa1fQE3CTJpbA5JtDrmnGoz/SoMJOUZ5KVhQRgOAOLVgMmxVkSM3uFM3KvhoKjaFsa8oOD0/K9wBqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744058363; c=relaxed/simple;
	bh=V7DUCjs9kVxBcWLtbI3zoQPAQpX2qv+UjffXf4Yk/Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpeJSq1lP6NKfNygCZxHYeh7F7/p0mz4aN0IYcYQ2dNxrK4+BRE4PBZjxY9wD8ku7FKqgDIedlqoH2BCvVFzprOEV8npx9s/l1xgd0oH01IXgmASky3zRLCyugrIKBMcl8Hty9WP12BXzWoyiaz8ZwWDxZF0tpP48cF3RQCzf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=csqrYtYL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tQe0PGDZfmp8rpY/ZTodvp4bt57E+3mmu/u8JN+CI9E=; b=csqrYtYLrstOUDID8fDr0c9AqB
	F0CAlOxBHi8sEuYWLH4NxtpkFB0cFnr/nEQ9zSvw1CMeufnlKnqafFISAsHlRWfJYS3qx6ykJO0gz
	5lcu6+wGw3Hukod7vFax88KwlV/trkypwiQU7uuG2TcYyE51USeDS5vIaTwlML5OslVw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1tFV-008IsL-2W; Mon, 07 Apr 2025 22:39:17 +0200
Date: Mon, 7 Apr 2025 22:39:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Pazdan <mpazdan@arista.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jianbo Liu <jianbol@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH 1/2] ethtool: transceiver reset and presence pin control
Message-ID: <8b8dca4d-bdf3-49e4-b081-5f51e26269bb@lunn.ch>
References: <20250407123714.21646-1-mpazdan@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407123714.21646-1-mpazdan@arista.com>

On Mon, Apr 07, 2025 at 12:35:37PM +0000, Marek Pazdan wrote:
> Signal Definition section (Other signals) of SFF-8636 Spec mentions that
> additional signals like reset and module present may be implemented for
> a specific hardware. There is currently no user space API for control of
> those signals so user space management applications have no chance to
> perform some diagnostic or configuration operations.

How do you tell the kernel to stop managing the SFP? If you hit the
module with a reset from user space, the kernel is going to get
confused. And how are you talking to the module? Are you going to
hijack the i2c device via i2-dev? Again, you need to stop the kernel
from using the device.

Before you go any further, i think you need to zoom out and tell us
the big picture....

    Andrew

