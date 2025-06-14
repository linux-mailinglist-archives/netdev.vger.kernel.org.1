Return-Path: <netdev+bounces-197843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA38ADA042
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77E21895079
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7E51FE46D;
	Sat, 14 Jun 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y5f4vhp/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B73179A3
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749940169; cv=none; b=ZIJEUoR3sicA1v/iiONTbBF7GP4gRQpPKmiDX/o1jKx1rmQfYseF1t9zUB73r7KAJ9KAqA/XX+7NFp56oQawtFTRdaNYaBSgOhlL5LG4ZWEDD7xvTRkTpM63rTlMYFboN3SYSrSNe76Dgstpm+FVN+9goWNilA6hK8pYGrY79po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749940169; c=relaxed/simple;
	bh=2i2a9YxWVTj89ACkH6AOrxN2mTOmYcY0mnp32Yr1elo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEVmbcAtxwQJzSb9N6AmcoP27QeF1QFI5N7ozP3iJGqf8SBIazPtWYGA+6DUL9+83ZQQ0SG/V1n/bWiH+03qxNyOmR19VbKL3TrSkIiFnu6HCfC4f0os3sMPJ1wA80gdMGr1HP6PcDuPb0Dus07k/AmoEMxNCpn1wyaOdaw5Lbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y5f4vhp/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1qasc1IU45cZbEqLudKsp7M6KFJOTrMy9n08tY/3aLw=; b=y5f4vhp/RDhSSyRA8zngMGTqno
	txpHfLUmNWzCYwza2GMhY0fa+CQIES3q92aPkrhjNg8kSweqkWavBFdxt5IlIjgW6n/8Jd6labUwU
	HoWZnEMq5VODusgalop6BAWDvzSs0cGn91k6y3J87LTH+15hsEJSoXRNRgjJaoUNRtSY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQZNN-00Fsfd-8T; Sun, 15 Jun 2025 00:29:25 +0200
Date: Sun, 15 Jun 2025 00:29:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, kernel-team@meta.com, edumazet@google.com
Subject: Re: [net-next PATCH v2 6/6] fbnic: Add support for setting/getting
 pause configuration
Message-ID: <04e89c0f-5f0d-4db2-bbf2-c9b4a5c24355@lunn.ch>
References: <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
 <174974094061.3327565.12270122195433259632.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174974094061.3327565.12270122195433259632.stgit@ahduyck-xeon-server.home.arpa>

On Thu, Jun 12, 2025 at 08:09:00AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Phylink already handles most of the pieces necessary for configuring
> autonegotation. With that being the case we can add support for
> getting/setting pause now by just passing through the ethtool call to the
> phylink code.

Yah! a pause implementation which is not wrong :-)

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

