Return-Path: <netdev+bounces-176176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F56A69417
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EEC3B81BD
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827901DC9A7;
	Wed, 19 Mar 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MOuzlnOG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE21D5142;
	Wed, 19 Mar 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399218; cv=none; b=KDnLfzBgxsy+lsEKrWmGHsVh9bNgcEDUXwGKWYx4CW0rGD+LclqXAfbXSg8DQn8WiStXEvsj5v55rX0kt9rLKxWAmAzJQgEb6RnwYZjyEpvwt54OWItE0szqkjUQ485yHDkv0XhQcSfwQmhuwfUpiefj+Hwh4a4yq7xaiP76PMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399218; c=relaxed/simple;
	bh=aMbtdvd7lPx3VzMWnSDe0in/nBa9AF22jEaDljtoGGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWapF54HiL/psog7VJ/rIHAqzD8pvFEoxDUqtUS8oIcfoYSO9x244NILuIgb0MpkhaAWILSsnPhZW2elZ7twhYy1ndw9kjgTra+uQqA1Sp4C9upr4ubRXZ95/eMKAugA595QAa0e59zFN3e7AED9t6Oe7X7Dh9jggrzJHJD643A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MOuzlnOG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+qJlruxx2j9t0DthHj7xMEyCL4PZ6YK/QOIB1zY+fZU=; b=MOuzlnOGG9bQxnE4Akg9HZDLH5
	UqqFWBcRCRju3nH/550uQUvRg1vX2x2OGFbtTBF6+7x+7ubiH1qxPcrg2G1FejbBIL7u1af12v1+d
	r4jRG8FDkfhUsDEWLtG9VvpRrxqceGKjREXnpov970GJ8f67/fRcmrKxawr3qZ1bwJ507rEmiQg8Y
	0vuKw8NFmj2eW1tbwS6kqcWGXr/w8Lr+po1/UMZE9MGE3uuDIDSSlFZDETzCGoJBU9HTGQqVSNKqF
	BzuCwWPdr35ELcPl1/8Qm8qWuSFtagsHmrAzu05mLFZpB955kAUhZ1nsBqDd1XmgR7/Jv0k1B8Wjy
	Ck8W0+QQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38252)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuvd5-0006cu-11;
	Wed, 19 Mar 2025 15:46:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuvd2-0005jS-1G;
	Wed, 19 Mar 2025 15:46:48 +0000
Date: Wed, 19 Mar 2025 15:46:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid
 potential string cuts
Message-ID: <Z9rm6NYEQpbo4-pz@shell.armlinux.org.uk>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
 <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 12:54:33PM +0200, Andy Shevchenko wrote:
> -#define PHY_ID_FMT "%s:%02x"
> +#define PHY_ID_FMT "%s:%02hhx"

I was going to state whether it is correct to use hh with an "int"
argument, as printf() suggests its only for use with arguments of
type 'signed char' and 'unsigned char'. My suspicion has been
confirmed by the warning the kbuild bot has just reported.

It seems this is not a correct fix for the problem you report.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

