Return-Path: <netdev+bounces-140803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA73F9B829A
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 19:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F821282AF0
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FC19EEC7;
	Thu, 31 Oct 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nDaRjtLp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0B1E495;
	Thu, 31 Oct 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730399550; cv=none; b=PkD8ogmkaHk+QU85hVeDGSN9WdGEesPwKGn54tLevNDuBmY+GNP5J7mmlfa+dhxJ9r+SOme2LU/z0DRnBBIQcIoUMvXNWqmDjneq6439vVhNYqVmvYmz8M07U8AbqzcX71MB1kFYp0klaRIS59ICIlnW23vGgqWmWcZYIfjIwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730399550; c=relaxed/simple;
	bh=RUVPQiaY6OPpCJwxkx+ZZ+6/bxNeiQFSWHfTzfRdhwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg+io1AdSo3dAV86jMX3yjb/coF/TCZFMLoXGN307U5LPKVCV68bysFXhEBhqiX3tgLeHzFimFgawSfJL9FAiHIvGsZlqCoCMdN5pJDSenHKer/Jn7uTpjwOg8+NLy6wtvFd58uqYtOE3ovA+xSVYRxs1K9bU6UbdfRPwON83IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nDaRjtLp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9a6uJMY1OTi250MM0G0CrVJdZwYpREXYVIulqx+LOXA=; b=nDaRjtLpuY07q8gY59h5Yx4Rxk
	O3qLtlNpnlubLHptxAkd+2pd/0yXKx++xA8c4TSDzqcQGr4AEMmhnsk4qyhmGwTcudsJSEcnCL+dh
	FsT6Z5+LrNUT794dkFg4pth3rFScGJYCgXAPRlHuV6/E68eluKtqFxENrMRa6yGeeMWE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6Zxk-00BoX0-Kp; Thu, 31 Oct 2024 19:32:04 +0100
Date: Thu, 31 Oct 2024 19:32:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, olteanv@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Yosry Ahmed <yosryahmed@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] MAINTAINERS: Remove self from DSA entry
Message-ID: <acb6b523-3eda-4695-8021-2d8a4b0ca5bd@lunn.ch>
References: <20241031173332.3858162-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031173332.3858162-1-f.fainelli@gmail.com>

On Thu, Oct 31, 2024 at 10:33:29AM -0700, Florian Fainelli wrote:
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

