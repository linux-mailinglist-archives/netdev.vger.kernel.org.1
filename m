Return-Path: <netdev+bounces-103683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AF59090C4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504E4B213D8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A91D192B8F;
	Fri, 14 Jun 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b="k3GxTF1i"
X-Original-To: netdev@vger.kernel.org
Received: from mx2-at.ubimet.com (mx2-at.ubimet.com [141.98.226.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA718E0E;
	Fri, 14 Jun 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.98.226.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383892; cv=none; b=WCXTo9tNkjntcFlj4przvt66luNAXk+BUnjGvVv1z1TDKYqpjgpZ6XLPWSgZhClEoYalNiIJSzEv3ZJKmANPTES8/TuteNv1OoClxfJFhE2IbgWAWG5QEXI/upISZw3yd94kzUeWpIjeX49BKmPXnWWxtCruk80JGKYp2ROFkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383892; c=relaxed/simple;
	bh=qrUaj5lI1R/yYXW+ER2z/XL6OGq3gh0QVB/X+hJZpWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J853GgpW6xUkYQoiGMzQqalT0ZbWcsbMYrcICCnHXd26nFD+f9sHbrLwCVFyZQatArsr4VufrbrSofebEHy3v5Y2xbL4T3XxsMRwA7B0qKO16/M+/lbL63GaIeJ1uE9X20jrsYRD0TkVvYXCHx2unpNzCiSkPkaNP07VDr2i1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com; spf=pass smtp.mailfrom=ubimet.com; dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b=k3GxTF1i; arc=none smtp.client-ip=141.98.226.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubimet.com
Received: from localhost (localhost [127.0.0.1])
	by mx2-at.ubimet.com (Postfix) with ESMTP id A05E9811C3;
	Fri, 14 Jun 2024 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ubimet.com;
	s=20200131mdel; t=1718383889;
	bh=qrUaj5lI1R/yYXW+ER2z/XL6OGq3gh0QVB/X+hJZpWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3GxTF1iKjOpdHVBjOmrYp6yWFQKAyrm1B/OZbiChxa5X6hd3sxKuKK+p7V9ZTQ6D
	 uVl3g1/qG8uqwW/Uylh5xERzagzK0WEjv1JcNBcpLoVRcrW5EpwnoOvmGmeGOGq6Su
	 uz71epuntOOOMQcurQmrXNhWgHtHcGKzO0clqYrHoxZ3OL5hVQ109bBBA3XXZRLWKP
	 ln7zMaiCbomuCWfz6QBZdSj+i+Z9ufgvkPbtfbU0WhQ8USwYtq5zEQIXrrseYtf2Zg
	 pZE7nq9gXX6NYnIxVIqLBDisWe10E75/iiHd5bTDQBYDMl9JF0vVNjPFiGXH+KZG00
	 YdsRL11iWUzpw==
Received: from mx2-at.ubimet.com ([127.0.0.1])
	by localhost (mx02.dmz.dc.at.ubimet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VylruQ35qsGF; Fri, 14 Jun 2024 16:51:29 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com (webmail-dc.at.ubimet.com [10.1.18.22])
	by mx2-at.ubimet.com (Postfix) with ESMTPS id 8DF4180C5D;
	Fri, 14 Jun 2024 16:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 7B38F807AB;
	Fri, 14 Jun 2024 16:51:29 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id sDMl8jLTD7Xm; Fri, 14 Jun 2024 16:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id AC01C807F2;
	Fri, 14 Jun 2024 16:51:28 +0000 (UTC)
X-Virus-Scanned: amavis at zimbra-mta01.ext.dc.at.ubimet.com
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8bRAqD3JwIzq; Fri, 14 Jun 2024 16:51:28 +0000 (UTC)
Received: from pcn112 (pcn112.it.hub.at.ubimet.com [10.15.66.143])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTPSA id 5F65F807AB;
	Fri, 14 Jun 2024 16:51:28 +0000 (UTC)
Date: Fri, 14 Jun 2024 18:52:10 +0200
From: =?UTF-8?B?Sm/Do28=?= Rodrigues <jrodrigues@ubimet.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "open list:ETHERNET PHY LIBRARY"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: phy: dp83867: add cable test support
Message-ID: <20240614185210.3a53be61@pcn112>
In-Reply-To: <d2e2232e-7519-4d62-b2be-265058350e08@lunn.ch>
References: <20240613145153.2345826-1-jrodrigues@ubimet.com>
	<20240613145153.2345826-3-jrodrigues@ubimet.com>
	<d2e2232e-7519-4d62-b2be-265058350e08@lunn.ch>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 19:19:45 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +/* TDR bits */
> > +#define DP83867_TDR_GEN_CFG5_FLAGS	0x294A
> > +#define DP83867_TDR_GEN_CFG6_FLAGS	0x0A9B =20
>=20
> Is it documented what these bits actually mean?
>=20
>    Andrew

No, all three (CFG5, CFG6 and CFG7) are undocumented.

Jo=C3=A3o

