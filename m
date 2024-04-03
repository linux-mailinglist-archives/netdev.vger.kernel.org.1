Return-Path: <netdev+bounces-84633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B386897A6A
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 23:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6A71C217A9
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 21:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D274815664A;
	Wed,  3 Apr 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sduiYmCw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BBB2F24
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178713; cv=none; b=a+x+xNXRMRNzJj/H/4lu/D1q3MsJGi3JORcvTZYOrYguUtdWdhmZec+RAw5r88CHUE7knq+bVrqPLG6v0n7lSYT+1wR56iAFtjc04smbwYRTClHoS4wBtY6nrD5C/LV6U/N0rz3rSi2O8n/jtH2LesSwhaKQO7iiEVfWk74I+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178713; c=relaxed/simple;
	bh=skX93573gnUmEfggTKxPIaDIj031bnSSN+11TJaCx7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVjCjojSzqToFVtnIhIFHk8hH49nUBwPCQejMnlglOJV74GG7TKAwfy5AJC8v3jiIx/5HhUSWUlI0NQrG778J6KKavWyf+GGONNuKQ7UTwbj8X2dyZwIF04S9CjYTiX8ytwjcbZKztVMFOjwKqRHUrMXTE2YKyiyNCccNH2Krog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sduiYmCw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XefOiSETJaRTUAGyBJeKN1ejKeJwan5nmergzUjZHtw=; b=sduiYmCwI+KLYV3EKvtTyBtHnJ
	mSWh8HCk8cBp1+q6Tf9EoxzVFhWKThqynVd9G0nsZCxopOuACrDUvU87XrXFGqc0HFe/euyyIol48
	DVCIhIOIM1WhBQzR3pffrYC9A4u47qLmigH/CgouClNIxQ4N+nSYCav3JfmFUVemmfGU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs7td-00C7Fv-EE; Wed, 03 Apr 2024 23:11:49 +0200
Date: Wed, 3 Apr 2024 23:11:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 11/15] eth: fbnic: Enable Ethernet link setup
Message-ID: <5b66da7c-f533-4092-9918-1612d9c84cb3@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217495098.1598374.12824051034972793514.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217495098.1598374.12824051034972793514.stgit@ahduyck-xeon-server.home.arpa>

> +/* MAC PCS registers */
> +#define FBNIC_CSR_START_PCS		0x10000 /* CSR section delimiter */
> +#define FBNIC_PCS_CONTROL1_0		0x10000		/* 0x40000 */
> +#define FBNIC_PCS_CONTROL1_RESET		CSR_BIT(15)
> +#define FBNIC_PCS_CONTROL1_LOOPBACK		CSR_BIT(14)
> +#define FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS	CSR_BIT(13)
> +#define FBNIC_PCS_CONTROL1_SPEED_ALWAYS		CSR_BIT(6)
> +#define FBNIC_PCS_VENDOR_VL_INTVL_0	0x10202		/* 0x40808 */
> +#define FBNIC_PCS_VL0_0_CHAN_0		0x10208		/* 0x40820 */
> +#define FBNIC_PCS_VL0_1_CHAN_0		0x10209		/* 0x40824 */
> +#define FBNIC_PCS_VL1_0_CHAN_0		0x1020a		/* 0x40828 */
> +#define FBNIC_PCS_VL1_1_CHAN_0		0x1020b		/* 0x4082c */
> +#define FBNIC_PCS_VL2_0_CHAN_0		0x1020c		/* 0x40830 */
> +#define FBNIC_PCS_VL2_1_CHAN_0		0x1020d		/* 0x40834 */
> +#define FBNIC_PCS_VL3_0_CHAN_0		0x1020e		/* 0x40838 */
> +#define FBNIC_PCS_VL3_1_CHAN_0		0x1020f		/* 0x4083c */

Is this a licences PCS? Synopsys DesignWare?

> +static void fbnic_set_led_state_asic(struct fbnic_dev *fbd, int state)
> +{
> +	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
> +	u32 led_csr = FBNIC_MAC_ENET_LED_DEFAULT;
> +
> +	switch (state) {
> +	case FBNIC_LED_OFF:
> +		led_csr |= FBNIC_MAC_ENET_LED_AMBER |
> +			   FBNIC_MAC_ENET_LED_ACTIVITY_ON;
> +		break;
> +	case FBNIC_LED_ON:
> +		led_csr |= FBNIC_MAC_ENET_LED_BLUE |
> +			   FBNIC_MAC_ENET_LED_ACTIVITY_ON;
> +		break;
> +	case FBNIC_LED_RESTORE:
> +		led_csr |= FBNIC_MAC_ENET_LED_ACTIVITY_DEFAULT;
> +
> +		/* Don't set LEDs on if link isn't up */
> +		if (fbd->link_state != FBNIC_LINK_UP)
> +			break;
> +		/* Don't set LEDs for supported autoneg modes */
> +		if ((fbn->link_mode & FBNIC_LINK_AUTO) &&
> +		    (fbn->link_mode & FBNIC_LINK_MODE_MASK) != FBNIC_LINK_50R2)
> +			break;
> +
> +		/* Set LEDs based on link speed
> +		 * 100G	Blue,
> +		 * 50G	Blue & Amber
> +		 * 25G	Amber
> +		 */
> +		switch (fbn->link_mode & FBNIC_LINK_MODE_MASK) {
> +		case FBNIC_LINK_100R2:
> +			led_csr |= FBNIC_MAC_ENET_LED_BLUE;
> +			break;
> +		case FBNIC_LINK_50R1:
> +		case FBNIC_LINK_50R2:
> +			led_csr |= FBNIC_MAC_ENET_LED_BLUE;
> +			fallthrough;
> +		case FBNIC_LINK_25R1:
> +			led_csr |= FBNIC_MAC_ENET_LED_AMBER;
> +			break;
> +		}
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	wr32(FBNIC_MAC_ENET_LED, led_csr);
> +}

Seems like you should be using /sys/class/leds and the netdev trigger.

      Andrew

