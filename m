Return-Path: <netdev+bounces-139657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353B59B3BDA
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE86B282977
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8761DF991;
	Mon, 28 Oct 2024 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SpCgUsHB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A630192B6F
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147471; cv=none; b=SDl01hISUUn2613Rpgpz2SkqBBFDboC/fnNyHFHLP8psGcHo63T0IZg6cRezOMeuC9g9LOnpvdUJuitlDXoCq3JmPxsdDYmpGRK6eNNpQcGTKD4kKK5bZbgnjHXJnqoUtOEBjfh9fy97gCn1YHLiomDjujxlvgpbFrA+kWkc1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147471; c=relaxed/simple;
	bh=ToyF5taUmoj8i+m2IwN4p2x6q8+z6B7Y29uGW2HRwcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+0Y9YRo25XeuQaoltOXtUqtmEpR5qfihjb5UGU3AhREKP6ZuyiDHO8wJDZ7ri1/bh3DMYH1KSx8BoioxaI3KNMskvWLJmYxGvFG3L54EHF0JG2w9n8abBRDIulghvq+9FtaYqexGYK6Y1Uggixw4CFCxgrXYuIlsZFzE6JUYSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SpCgUsHB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HByjGyI4UNDxEUXRoQE4+mHDJJFBbwUSZsDfOsEGFcg=; b=SpCgUsHB6kSrVRGwHjCpgBVvsf
	wBe739w6TeMrY6SmtcqJAvfy/0VFQwSqtRc9ASBEfOEHlPJlPlvQL9S4UIqI+AEih+bnDTeDvLocb
	ZCROtbMAlnFYGIfWu4aKNtxjR0XXZEHn99mlhv3IqpsqRGVGOVXd5quAMKPZ7MFOO1u8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5WO8-00BUFy-2t; Mon, 28 Oct 2024 21:30:56 +0100
Date: Mon, 28 Oct 2024 21:30:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Vijay Khemka <vijaykhemka@fb.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: ncsi: restrict version sizes when hardware
 doesn't nul-terminate
Message-ID: <286f2724-2810-4a07-a82e-c6668cdbf690@lunn.ch>
References: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
 <20241028-ncsi-fixes-v1-2-f0bcfaf6eb88@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-ncsi-fixes-v1-2-f0bcfaf6eb88@codeconstruct.com.au>

On Mon, Oct 28, 2024 at 01:06:57PM +0800, Jeremy Kerr wrote:
> When constructing a netlink NCSI channel info message, we assume that
> the hardware version field is nul-terminated, which may not be the case
> for version name strings that are exactly 12 bytes.

Is this defined by a standard? Does the standard allow non
nul-terminated strings? 

	Andrew

