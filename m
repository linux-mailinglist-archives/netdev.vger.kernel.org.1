Return-Path: <netdev+bounces-132548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1206999218C
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1301F20EE4
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312018A920;
	Sun,  6 Oct 2024 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FRbvPRue"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF181A716;
	Sun,  6 Oct 2024 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728248783; cv=none; b=DZy5S3nXo58aFx1WQzU/1Rp8KQDffbLZ4dNzuE+FIrLzXts+NFWN6x/dVFgpRtWrxqsSzRbS+oyDwib4y4jTjRAlWNzlxDyPpWIjfH8YdfMiwauQD2eGMa0VHuo5dxdJONGygPQG5WGSQf8ROzC4mCN3Fds91XCX9LQDRkpKBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728248783; c=relaxed/simple;
	bh=wed6LFmWl9JeLPDEyAJrhItqTMj5dQt4hWKP3k5idhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPBuEXTemExkBm64204OKYLKR+LuOw1VQv93x2z+brBN8jli6nUTsoH8AptK+bygATVEIOZ5VD4UBLZMVtq2NnJpraER5cQaP+8Or/S5mWVA/BwJenaUFPrVxfec56Ji9CDf4REe7oGsSWQzUNTludU3sqFEeemP325fbLekpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FRbvPRue; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pfO4W8lm7Ei7Rz60VQ1bde8cdTQFeg6HQ2P+Fzxt1gs=; b=FRbvPRueHXedjh1/7TxiuqjXcM
	DuEGTUlK9g+durApButDlEHjme8CvKW43r4uWTWHAywwbDQaThrI4sFcaj8BznGONtOrdY+ShfySP
	Gpyqv6O/8/rJ3PtWUSbMbHnRm7pYxJkk0U+C6DPWbLRZj8iwxilweeJshsIOCPvdM48o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxYSD-009CuS-9K; Sun, 06 Oct 2024 23:06:13 +0200
Date: Sun, 6 Oct 2024 23:06:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liel Harel <liel.harel@gmail.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] smsc95xx: Add implementation for set_pauseparam for
 enabling to pause RX path.
Message-ID: <18622f02-5cab-4e0e-a640-22bfc03cf0bd@lunn.ch>
References: <20241004125431.428657-1-liel.harel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004125431.428657-1-liel.harel@gmail.com>

On Fri, Oct 04, 2024 at 03:54:30PM +0300, Liel Harel wrote:
> Enable userspace applications to pause RX path by IOCTL.
> The function write to MAC control and status register for pausing RX path.

Sorry, did not notice this version before i reviewed v1. It appears to
have all the same issues.

    Andrew

---
pw-bot: cr

