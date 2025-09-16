Return-Path: <netdev+bounces-223549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82DB597CA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8D41C00329
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3816307AF9;
	Tue, 16 Sep 2025 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eGz4ODFA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D85315D42
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029770; cv=none; b=fsbgp3TR92pDFH5Xj9DoFYZkhKCpmG5IN0Cr1nFuQI3lv4kmZ8fs/XYILhjWrXnNIbLZdhq1kO68vkVNdfyPDGhJmLhXgzYGHOjgz4THsqMe8KGk/+6VXRpS7BSPbxT4p39hiUfCDNMGl2snfLWXL0B2/iw/F97Axah6lypKfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029770; c=relaxed/simple;
	bh=xFRCyL2WDmkrtNm03A9g9oT+S4mojlc1DDge8SoRfbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huNmW6RgOpQr8m7S9XZDMPmSjN9F7YPzOt6r7C+aCRIPBlXDiO0qF0EX3Woj7vDDBgn9lp/TpkxyMiLntxa0ETHMkHC6r6tkVau2RdEdsf+gThiFg5C6SDf2VzhTdLjGOK3ns43679VinPjxhpj4Si9U9OymFkdxtegenefwLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eGz4ODFA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kyY21yOr27xcLHtI1lj+r7d+LtVzKCIoGkhvHyOU3MM=; b=eGz4ODFAwEmLFXWCdMoSLA24qL
	N/QfQpfJyZgevDQRsMJnm0EDVTY5kr3iu996qXpaEP8Z15MRFEZtf/al/2pM7KFcs5fKKajZvYeYI
	+RdQjgsSQNZRZPppVn+MuhMVmfic64OVUJPTrLiuzikUKxL0QLjwD8kkGH032DQHswKfyBLtY9BP2
	Odoc9pg/Xgb4XHvvEeMrhr7TOMAeCxpkVHINYE77jtP8D7fBOrZY0VxLtquckuSicYMhpukC1wZ09
	SlZIRyPYS4Z2xxdTgD1vnPmvM4N72fbpqtPTmD7mvxO9XyI2dtXndNmyW0tD/BBnBeOrSsOfEdtqX
	hsJUuieA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59482)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyVqk-000000004eZ-3GwI;
	Tue, 16 Sep 2025 14:36:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyVqi-000000007gP-2HXh;
	Tue, 16 Sep 2025 14:36:00 +0100
Date: Tue, 16 Sep 2025 14:36:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 1/5] net: dsa: mv88e6xxx: rename TAI definitions
 according to core
Message-ID: <aMlnwFGS-uBbBzRF@shell.armlinux.org.uk>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uN-00000005cF5-24Vd@rmk-PC.armlinux.org.uk>
 <20250916084645.gy3zdejdsl54xoet@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916084645.gy3zdejdsl54xoet@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 16, 2025 at 11:46:45AM +0300, Vladimir Oltean wrote:
> On Mon, Sep 15, 2025 at 02:06:15PM +0100, Russell King (Oracle) wrote:
> >  /* Offset 0x09: Event Status */
> > -#define MV88E6XXX_TAI_EVENT_STATUS		0x09
> > -#define MV88E6XXX_TAI_EVENT_STATUS_ERROR	0x0200
> > -#define MV88E6XXX_TAI_EVENT_STATUS_VALID	0x0100
> > -#define MV88E6XXX_TAI_EVENT_STATUS_CTR_MASK	0x00ff
> > -
> >  /* Offset 0x0A/0x0B: Event Time */
> 
> Was it intentional to keep the comment for a register with removed
> definitions, and this placement for it? It looks like this (confusing
> to me):
> 
> /* Offset 0x09: Event Status */
> /* Offset 0x0A/0x0B: Event Time */
> #define MV88E6352_TAI_EVENT_STATUS		0x09

Yes, totally intentional.

All three registers are read by the code - as a single block, rather
than individually. While the definitions for the event time are not
referenced, I wanted to keep their comment, and that seemed to be
the most logical way.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

