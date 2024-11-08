Return-Path: <netdev+bounces-143229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F499C178C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 09:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDDE1F23B3A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489BF1D0F69;
	Fri,  8 Nov 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bNaTsDHG"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D517DA95;
	Fri,  8 Nov 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053462; cv=none; b=MKyIVmY+BsvDXhrJUhavLLlJJ7SGFtu6/XOTvOwTTSEZPsIZr+gFDT+c3D2H5ThoOS14CIsSkjZ9kB5EqrtWBKCDcQTYfNVc9nKdJauAz8dCbXm1D5hMUuLkd4cwNfFu3IFr6g1tNCf9j149eQTt6sCYGrZPp9kNuoP9lXLSJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053462; c=relaxed/simple;
	bh=cRdY/ye+3agJ02o6hil39dpSqzUS9DutLmgp5HUYkK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GCu/JJuacVoT8yyZKwGyaygmRkAgXFnKXn6GtvtUvu2HEftsXpFkhDa4yfZQerblelFBmQ+1lXXn2stGo1w6Lhq5LFEn3AQxiJ9UI/tv6Wlp2QCm3OHf74/N/oc636ZckW1XxlVdmZx/syvhbU/ke1A2nb3TfCcAgM3ICAZ1my8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bNaTsDHG; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731053452;
	bh=cRdY/ye+3agJ02o6hil39dpSqzUS9DutLmgp5HUYkK0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bNaTsDHG8znmHdUOCeji9LJUUP5buLzrb+QyOLt8KeKMSW3Fs7JljiTlwu/wOqPcR
	 6SLwGgUnqnjkXM1z+GigY+LdYu7I2TRx4lGbqr+aOQ3PGxyjeO6MKRBQsREiTK99mD
	 KA6F1fb4a+yWvCjD00z/nQtxQJDTa8+DY2aF4e4nnXP3ayM4FL7eA+5cwWUVrBPoGz
	 38LrpWziZCeGHnBf08uBN+VWUBmkRvQDzWDK33K8rmBRg1mPiuItnRG1xecuqEQVSk
	 nUnXZAZ6qjY5a4DjtLhjWWI8gfqEdHlDAR/pa1B8Vlfg4zvyMWUQ3MCpuaq05szE6E
	 fL7VIAcuqCztQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4B2ED6A95A;
	Fri,  8 Nov 2024 16:10:50 +0800 (AWST)
Message-ID: <84fa07f08bce8af2018e4f81949d227c9b97fe0c.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] net: mctp: Expose transport binding identifier
 via IFLA attribute
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>, Khang Nguyen
	 <khangng@os.amperecomputing.com>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 ampere-linux-kernel@lists.amperecomputing.com, Phong Vo
 <phong@os.amperecomputing.com>, Thang Nguyen
 <thang@os.amperecomputing.com>,  Khanh Pham <khpham@amperecomputing.com>,
 Phong Vo <pvo@amperecomputing.com>, Quan Nguyen
 <quan@os.amperecomputing.com>, Chanh Nguyen <chanh@os.amperecomputing.com>,
  Thu Nguyen <thu@os.amperecomputing.com>, Hieu Le
 <hieul@amperecomputing.com>, openbmc@lists.ozlabs.org, 
 patches@amperecomputing.com
Date: Fri, 08 Nov 2024 16:10:49 +0800
In-Reply-To: <20241107204157.683bca11@kernel.org>
References: <20241105071915.821871-1-khangng@os.amperecomputing.com>
	 <20241107204157.683bca11@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

> > However, we currently have no means to get this information from
> > MCTP links.
>=20
> I'm not opposed to the netlink attribute, but to be clear this info=20
> is indirectly available in sysfs, right? We link the netdev to=20
> the parent device so the type of /sys/class/net/$your_ifc/device
> should reveal what the transport is?

It's likely derivable from the parent device, but requires some
heuristics in userspace to map this to a transport type.

Having a well-defined place to provide the DMTF-specified transport
identifier makes this a little more straightforward to determine which
spec we're dealing with, for any transport-specific behaviour. For
example, some bus types require endpoints to announce their presence,
others do not.

Cheers,


Jeremy


