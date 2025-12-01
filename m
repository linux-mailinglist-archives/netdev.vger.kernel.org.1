Return-Path: <netdev+bounces-242975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8235AC979D2
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 14:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60F6C342BB8
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B833314B85;
	Mon,  1 Dec 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Kq9Ghp6m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6F314B6E;
	Mon,  1 Dec 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595827; cv=none; b=Qf9c2I5mpUdJbjFCvNVOtCuN11trLkEqRmrEvl1o1mTR2tDNv+JAt89QVplZ2a9arDltQdVQvuTNRhM/95ge3kAxYytNd4trgKMhLwbKy5FAgbhcTIuCHEGzgBpNW8BCTNqvphKSrkWsQxgzaITKq+PdEWmtWGYMgob7muCxDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595827; c=relaxed/simple;
	bh=QMBJF6xR5E2HsR69IgyQcq53LJsXDW0YfjfElIhfnmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNjon/1cE/nINpQdvcXdP6fUv4hFGD+7RPzPE1rAqzF9YClv7oNlUS/9h/1Mn5VE7uoZ1OIsaNef0a87IO8ystYs6PluPrhP9rtNHrfWstMjK9+D3W5RNHkg99VD4lntk2bz+Tn7tdc9aS6ajfS95E5NfpqEDFCUMbERYwLrisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kq9Ghp6m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qpv0J/6Q491UqUv0ZFU2N8evkkM9o/anB4SEZCZJc2Q=; b=Kq9Ghp6m66tatk5JttmgVulzcY
	0t0qxJSIRT7vn/yH1HU1wLH0EjjATUTaCz6OJutvhB8oJeMuY5m1TvOKZlnmJv6D+txWhfHnKK49K
	VOD2vhXwfWzpLfAPKNEZ+3J/DGZM+pJdbjcdygSCG0WLROePPuBXpeshFnm81+kdRpRI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQ3yr-00FZjS-UC; Mon, 01 Dec 2025 14:30:17 +0100
Date: Mon, 1 Dec 2025 14:30:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: dsa: yt921x: Add STP/MST support
Message-ID: <a1f5b946-b4f6-4079-bdbf-7b75aa9856b1@lunn.ch>
References: <20251201094232.3155105-1-mmyangfl@gmail.com>
 <20251201094232.3155105-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201094232.3155105-3-mmyangfl@gmail.com>

On Mon, Dec 01, 2025 at 05:42:29PM +0800, David Yang wrote:
> Support for STP/MST was deferred from the initial submission of the
> driver.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

