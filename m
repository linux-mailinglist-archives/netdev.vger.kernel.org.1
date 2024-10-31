Return-Path: <netdev+bounces-140822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323459B85C4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C021C21AB4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7181CB521;
	Thu, 31 Oct 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4p+2YOoo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A165193402;
	Thu, 31 Oct 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411653; cv=none; b=qv4XJYcy39QBhKATUr8FwiyzwbTYqB0Jhk26iuhUbgrW9jwJmQTdwQOFHZTGizy2y2gvVtHEZW+b5uaITvzQs3FFx6FbOgoeQX8vQQfaX4Q6k8RVCg2WqImjZ/yC/BrPjMxLEiL7M/8H4lQgVhU4nZsVEXdVFXnIbcW3SoCny74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411653; c=relaxed/simple;
	bh=KdoeNpiS/p+rm8Qelj5rACdK1Lf1Zz8RIgV4JeX9MUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD9AaGLd+lkjnUCSO1crLmm2OM/ZyyLaWN/+cP1TmllF9VhokmEoQDxzrnMsi8R72uzyZCdSYZzz7RShlVZKLJyYhSA+LYLkCz0s7obgVGnHoTchIpgqaOdQ27qSwCssLSkGrBguDoU2o3+0wloXEWT5MNUMUIbR4bz/tiJnNpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4p+2YOoo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Md7xndCkD5h/1Ch/BvzvPhebt5YH0GB26ZGICP1J8EE=; b=4p+2YOoorOOUn81RfZBszqpd02
	3As8Zzp1BVYReRCL4m63N+KP7tSEKUD+78tkLXYIOnUxqpjpHRwftpR9h3wrqOY3TFyc0acwoq9Vz
	KvtlxzqP2sTWj30TIhxZG9GLjjyAhiuyt11D6WAe4BGDVohWOeCLV1Uln0q4b10plMVw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6d7A-00Bp5Y-Up; Thu, 31 Oct 2024 22:54:00 +0100
Date: Thu, 31 Oct 2024 22:54:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 08/18] net: pse-pd: Add support for
 reporting events
Message-ID: <ede82d07-6adc-486a-b715-e6e783655333@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-8-9559622ee47a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-feature_poe_port_prio-v2-8-9559622ee47a@bootlin.com>

> +static struct phy_device *
> +pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct pse_control *psec;
> +
> +	mutex_lock(&pse_list_mutex);
> +	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
> +		if (psec->id == id)
> +			return psec->attached_phydev;

The mutex is still locked. I'm surprised your testing did not
deadlock, and that none of the automated tools have reported this.


    Andrew

---
pw-bot: cr

