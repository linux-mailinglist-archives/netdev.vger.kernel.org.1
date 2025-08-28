Return-Path: <netdev+bounces-217805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F414AB39DE7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397E11BA1B1B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860230FC14;
	Thu, 28 Aug 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RFsB/18d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B61494C2;
	Thu, 28 Aug 2025 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385880; cv=none; b=EKaunK1hmdV3Prn9dV8r2T6XWIFPkR/rF9fmq9DDL4vUPDx7iG+ASgKq85TLB6LJ+0vg7Y0OFfNTaQCA3G7Fb73trZxgnQkuvn8CsP6N8bSNSkRNt+dtiJHyv7s6Ms4FlCnRhYXQ4uasRCEig80HjnUhIZSYaASnYvs/rXAZ6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385880; c=relaxed/simple;
	bh=34sSFaKnddndMDSeSYtHKxGqObxUARxAn761ZJYmWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/TjIpCneGEkKlGhAEqLYnYNNTTps8lKNEaCIbYU7MEiVoA2gXsW97C6yIDjnt5jmI2t9bkqjnSsZK9n2/gyhHWpv+egjJO4SjHpqMhWsdMHz6JccIRAadJiNDSOO6o4eqlU6XbHimzXmTJ6s7KN5EG/DsdExHorkBjSYCvPso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RFsB/18d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h+f4SwpD3k3csxTNLN2b+o/ZZ3kpeA0OeD7CGKxQtO8=; b=RFsB/18dZMjGBETEYy7w9yQWAd
	yGHRsBOzjI+LNRESt6fE6YxCQ/NEI81hFhMDA1HPmLVtG/P3dLdzs02Vkxeq4cNDsBLAKEX9+LcUI
	vJXEzolFKeaYgV+ce5fk/i8fXb1RrojHXM9KedC+lDE7Z2iLOa0wLBUefbKxNsB00PV4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urcBw-006Lnb-Qz; Thu, 28 Aug 2025 14:57:24 +0200
Date: Thu, 28 Aug 2025 14:57:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	rdunlap@infradead.org, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v9 0/5] Add driver for 1Gbe network chips from
 MUCSE
Message-ID: <cc11ce2c-04f2-4f1d-8d40-53206e6bf171@lunn.ch>
References: <20250828025547.568563-1-dong100@mucse.com>
 <0651d5a9-dd02-4936-94b8-834bd777003c@ti.com>
 <BC262E8E0C675110+20250828053659.GA645649@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC262E8E0C675110+20250828053659.GA645649@nic-Precision-5820-Tower>

> Got it, I found the v8 pathes state in websit:
> https://patchwork.kernel.org/project/netdevbpf/list/
> It is 'Changes Requested'. 
> I mistakenly thought that a new version needed to be sent. I will wait
> more time in the next time.

We try to review patches within 3 working days. Depending on reviewer
work load, you might get comments really fast, or it might take 3
days. The 24 hour requirement between new spins is a compromise.  But
you should also listen to your audience. If there have been active
reviews and they have not commented yet, maybe wait the full three
days.

	Andrew

