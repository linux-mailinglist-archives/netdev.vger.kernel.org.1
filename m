Return-Path: <netdev+bounces-132400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D53F991860
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4121C21087
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB23157492;
	Sat,  5 Oct 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SjAn1BZN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A711CF96;
	Sat,  5 Oct 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146586; cv=none; b=Mt/O+s3Zy+JdvO7GiyvMfhlxf4qchm2/KAKvB6sd4CXzsSAZnCZ1cBnN3MbT3/c9y5NJAho+OMx88TsIL9odvFjaVINHfti9lZ7VDsTJWDM12er/qkNTscH6SGi4hofp8xE85LmDFBLr5Jw3xva+zZ60mEREjcKkghMZEydQabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146586; c=relaxed/simple;
	bh=MCHt7lwhoCFNgpsQuXwxxziBnZWGL6rZ6iXZ7iFmbKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5eI590dFvF3Ih1qME+FPxtdQCbRIncU2XTvkXGox1V03CRJn3QuE2VZaBFJ3QgAu//L6mb0r6THLNaW5A3KSNT7ubfOtAz6RxEMzPzEMaQOYxZoXR8lAWOdK4Wf5b0NxNMAUCc3DpGdVg8KRX5a2dMMaxdb6yjKjdXpzh9Zc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SjAn1BZN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=uki+OVHraU1cgdBkx9wbcgC49RgVsYIYvWO0+W8oLkY=; b=Sj
	An1BZNsOpPEZ9DdRIKMOu8JTtdLFREdsbBqbb+mDMl13cHpW5ZlRVf/wdjcDRpAtFSKOkPCKqBiUh
	ZrBOzs8OtVRME1JIhrt/xqYd6f7BjRPNi7/KuEgx4OymU6y0R/WbuV6K4+1QGa6RP3WyMKnfKomDV
	jxuupoD55iuyUkI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx7rs-0098t6-Eh; Sat, 05 Oct 2024 18:42:56 +0200
Date: Sat, 5 Oct 2024 18:42:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qingtao Cao <qingtao.cao.au@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link
 when autoneg is bypassed
Message-ID: <7f39b47c-30f3-4cab-a9eb-8396598aa9c3@lunn.ch>
References: <20241003022512.370600-1-qingtao.cao@digi.com>
 <30f9c0d0-499c-47d6-bdf2-a86b6d300dbf@lunn.ch>
 <CAPcThSHa82QDT6sSrqcGMf7Zx4J15P7KpgfnD-LjJQi0DFh7FA@mail.gmail.com>
 <927d5266-503c-499f-877c-5350108334dc@lunn.ch>
 <Zv_wv67TGIUz5IZy@shell.armlinux.org.uk>
 <CAPcThSHA3bfvwbHWtL2HrDtv=d9z9vGape94J7Pucq65csHN3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcThSHA3bfvwbHWtL2HrDtv=d9z9vGape94J7Pucq65csHN3A@mail.gmail.com>

On Sat, Oct 05, 2024 at 07:25:05AM +1000, Qingtao Cao wrote:
> Right, the section about it further states that "... To solve this problem,
> the device implements the autoneg bypass mode for serial interface"
> and about several hundreds of ms if the device receives idles then it
> goes to a new state similar to link up.
> 
> In my v4 change no BMCR is used, but the partner's advertised
> configs (1000BASE-X) is read from the phy status register, using
> existing code in that function and testing still finds its working,
> which makes me believe that the autoneg end once it is bypassed,
> it simply adopts its partner's configuration.

Well, for 1000Base-X, autoneg is not about speed, since that is hard
coded to 1G. Autoneg is about pause and priority for duplex mode.

So play with those settings and see what happens.

	Andrew

