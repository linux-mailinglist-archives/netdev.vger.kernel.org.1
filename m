Return-Path: <netdev+bounces-214312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118AB28F25
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F347517B4FD
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410C2F60D4;
	Sat, 16 Aug 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yoluvoiw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28B2ECEBD;
	Sat, 16 Aug 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755358161; cv=none; b=fRQ9ZppKSApO4GU1r5vD1fHtvLpOmaqNsVO8kdRqIb1ex73ALuCulkMGXO5UTR2ZjsNXE6gXlCO4A7gRrI8abY9E0ra3tKB/JLPTN+g21mlACENZzZLF5AlhDoSU83dwA6Mhh+fm7xfszbsCCBJge/X7Xd/4OTwhu0C73W7FnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755358161; c=relaxed/simple;
	bh=AN3ech0LTfGbrCPbaUNpgbJ2BzWQEov4mSdREN5/rkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBgrhImxUECWtftcmkXogZ3PplXAXwa+Z5NZwEmjIT0B+Zr5gXebPcbH/HrJg0lKWH2e/x18jkmTdHkt3A/xKeakp/fha5T9OjaW8FDnxZeTuq/Gbm9dAn5xnlQ/lNTi5WLcaehYByahkJy3mbrJMIB+v9Yhcgi3O4JjW2b3SVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yoluvoiw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i5t69DMowoXeK1OBYzzEg7YkLA6qxp/aS77f2fkx2KQ=; b=yoluvoiwmakFg4E9fgAOkcCD+r
	/l0zeMb89WmbiNZ1XC3sveiTVQhKsuH9gwBXpYVsxbwgKxH6aDLGzJIQC6VNBR+LkbC2wIXDBq1my
	T1WKmdThP9pfeyTDYqcj9zIASWDR74bOJ0XEhbg/qbQgCP0ONK0EIAlEGUxAsyFmL3Mg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unIqD-004uct-7Z; Sat, 16 Aug 2025 17:29:09 +0200
Date: Sat, 16 Aug 2025 17:29:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v3 3/3] net: dsa: yt921x: Add support for Motorcomm
 YT921x
Message-ID: <f4b9a113-51f8-4c5f-9aef-05abf33c4dd9@lunn.ch>
References: <20250816052323.360788-1-mmyangfl@gmail.com>
 <20250816052323.360788-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816052323.360788-4-mmyangfl@gmail.com>

> +#define u64_from_u32(hi, lo) (((u64)(hi) << 32) | (lo))

https://lore.kernel.org/lkml/CAHk-=wjLCqUUWd8DzG+xsOn-yVL0Q=O35U9D6j6=2DUWX52ghQ@mail.gmail.com/

	Andrew

