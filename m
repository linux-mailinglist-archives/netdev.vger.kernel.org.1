Return-Path: <netdev+bounces-102974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2016905BCF
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 21:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AF8B26847
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF65028C;
	Wed, 12 Jun 2024 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TkMZJbTb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82E59B4E;
	Wed, 12 Jun 2024 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219791; cv=none; b=nYcG9E9NR5IFD+8t4UJD2v4F63xXxlff29fnLT4t7Yat0yRInBKZqdKnQZynXX8lb+4/oMRXpYSpi6foSYGdWN41FQi4bkuBmcDMhWvo9liBkVpkNr5TfL+8JByEMnf3pgy9bx9KxpQp8xqVi+LlNXWipOXQ865RY4gvA28HLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219791; c=relaxed/simple;
	bh=h9OrCqNtDcSWplzbwmvzVv8Y1Pp41dr3XGTW2LGPiGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apGcGaTLD/XItXCuDICCJQiIcaIwAKmopAuIEefK5rne3NXOECTmJW4yMIZma3F2HbCRjay4CUOjgon7z0M0qbrXThswwCvBh08oatz9K1lLi9Ss0ctpftefErzn2DniBWUXJEFQZTFf38cQNwEh1voMqgjq3BDpZeRDP7K32kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TkMZJbTb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9B/Qk2uWCAxs4BHcvpRcMr2sP++AxA6OtnPjaYkILhc=; b=Tk
	MZJbTbE7A6PhroebI9UO3cW97crXUkmkqufmCKhqFLQPrcrl4kbCK9C+IKtQpp6l6Su28hXZ6h5qG
	8Cm9fNIa1vs9k8bRuUYcei+TeB5x8ekQySJEre2NyjrjlgnZuDVZL5aFNltvQydaU4z2OgwSgNR4b
	57wQq8BLTGCv1Sw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHTS9-00HUuE-Cb; Wed, 12 Jun 2024 21:16:13 +0200
Date: Wed, 12 Jun 2024 21:16:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Frank Li <Frank.Li@freescale.com>,
	"David S. Miller" <davem@davemloft.net>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH resubmit 2] net: fec: Fix FEC_ECR_EN1588 being cleared on
 link-down
Message-ID: <5fa9fadc-a89d-467a-aae9-c65469ff5fe1@lunn.ch>
References: <20240611080405.673431-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611080405.673431-1-csokas.bence@prolan.hu>

On Tue, Jun 11, 2024 at 10:04:05AM +0200, Csókás, Bence wrote:
> FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
> makes all 1588 functionality shut down, and all the extended registers
> disappear, on link-down, making the adapter fall back to compatibility
> "dumb mode". However, some functionality needs to be retained (e.g. PPS)
> even without link.
> 
> Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
> Cc: Richard Cochran <richardcochran@gmail.com>
> 
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

