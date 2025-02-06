Return-Path: <netdev+bounces-163391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23799A2A1B8
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B295016809F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A60D195FEC;
	Thu,  6 Feb 2025 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UPlV9lcT"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EABFC0A;
	Thu,  6 Feb 2025 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825447; cv=none; b=ud4GCScgnJ5bSZM7yrsShL12lrjnuwzFCi8f2FDApxImXjdq4mNyV/1dQ2CtR9D8/pH5gozL7O0CQ9YzrvXJKrmDdjkCzOemRkl9MFHWhcpx4GMHakXwOgBCe6jIXc1hAUF5pANDuJwwctaERYXai6vywa8loZNpZFVtTqIHu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825447; c=relaxed/simple;
	bh=SB+udie3EYlucC6dTmJfWj56GMEJ6uCTIpfyU7zHPLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mNAkl5/DYyOr9/wC+DraGyzXdLyykdbyaqACieQpXuzlv0Ymwx7Thejzx6TbUKGrw4SCiXnBeYtt7rvWx+hDbp8iYiaGBJ+XE3ex76GNkqcaiXfMcgJ9quPK+O+rRB4Yir/ufspjvKDPGvV/tZrehAiCKsIzqTUfVV7UHrQpTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UPlV9lcT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738825443;
	bh=mCQD/JSwZhRa/O6eq6MQo4pLafzBYgIJNtFlpaSlEdc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UPlV9lcT+UGWLNIs2frne4ZtQ3mJ14afq6yzQMnEX40PDUiHZ72AEyDx81jOhlnuH
	 tbv27o5GG1CL/01YDugngNBF2Y2PuGuNjMfEkor0teZiJlZKQJCLqMmwA4HGPQsJW0
	 09Iiwoi90BgSMuIN7LdMPKf5XVl9Db2UrTS54GPKsCXcehbDqOSnTrmYxJV1k24G00
	 zpTZ4MjUXFqDPI0aAo4OMUR5Syj0d0QTBuP89an6r8PPMQMCTWZOO/38FcZnwynjP/
	 ZuKsL4vg90EqaryKDdi87d4gr4baSLZ9oBNo7gpEogS0d8p/uDk99Ic3CmQL0w/+Dw
	 jRTj+xz1oSPIw==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DA9A37488B;
	Thu,  6 Feb 2025 15:04:02 +0800 (AWST)
Message-ID: <99629576779509c98782464df15fa77e658089e8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v17 1/1] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: admiyo@os.amperecomputing.com, Matt Johnston
 <matt@codeconstruct.com.au>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Thu, 06 Feb 2025 15:04:02 +0800
In-Reply-To: <20250205183244.340197-2-admiyo@os.amperecomputing.com>
References: <20250205183244.340197-1-admiyo@os.amperecomputing.com>
	 <20250205183244.340197-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adam,

One minor note below if you end up re-rolling for other reasons, but
regardless of that:

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

> +       /* ndev needs to be freed before the iomemory (mapped above) gets
> +        * unmapped,  devm resources get freed in reverse to the order th=
ey
> +        * are added.
> +        */
> +       rc =3D mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BIN=
DING_PCC);
> +       if (rc)
> +               goto cleanup_netdev;
> +       return  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);

You seem to have a trigger-happy spacebar; there is another double-space
creeping in here, after the 'return'.

Cheers,


Jeremy

