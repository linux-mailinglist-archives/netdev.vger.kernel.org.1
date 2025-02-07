Return-Path: <netdev+bounces-163738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD0A2B727
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEB63A7A86
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6ED26D;
	Fri,  7 Feb 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="iiiAa4HB"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174924C83;
	Fri,  7 Feb 2025 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738888258; cv=none; b=JeUCT8CiQmapT0HSCo50I4+tyxxcXXCP2Xus8EwqKK9cLlR4mS6XW8eZiDubkeTl8g7171zyHhJuoGAg+RbJRi/D1tvHh4m9roEX8+mzPdDrXB0bJts4YTK66FolJf/pCrERCGhlJogfsgA6DjP8JDF+Yhtxs6+h0KtbfKAMZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738888258; c=relaxed/simple;
	bh=f6QX11ftdCfY6kNBmj6JPctntdXs2EUjTmvX8mE2Pn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOqI9sglmgr4VP36OUK0Z8ZMblzcGtMF0z2z2rQnw6SPgsM2z+lj++MkS3NcXSXOTosPFTYxXbZbdN4tG6T/dZ8YvFPtvPj6JQQbAKTeU/eJDIYRLtSqEVVmn3pFrzmZ6iOuoIRrjDZlGSkRVXPYORl7G3+vbhWFuoztRIIO+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=iiiAa4HB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738888253;
	bh=f6QX11ftdCfY6kNBmj6JPctntdXs2EUjTmvX8mE2Pn4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iiiAa4HBK3bn13H+H1kOwVh+mn5z6VWo6Ahhndd7+Wnswha9uSjavAwn9CNZCtCet
	 AxPq32AAq3/inh+uMjY2SBaGaNLqVQibCgsubIp+V4hCV/0fLBRNk5Tg/Cx+GApr08
	 7YotrWhz0v6O0i/y6ZmDstxGztwGtpNWZn29CjbNj4Rv9b1DicISREvkExtybfBXzY
	 pTebmGviXJQfxUnK+imwNpYuiWlWeMPqec9n8VGR/K2XF6t2euY1Xvj4FVDsVVdWgB
	 Q8qqtuR/hCgDbidwImTyhHNiBWb8yMN5dPKOQiHx33hHtuDq22+vasCcddLEHnfE3N
	 uTkfQUxyp7Ltw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6F446746BD;
	Fri,  7 Feb 2025 08:30:52 +0800 (AWST)
Message-ID: <1b38b084be4dd7167e80709d3b960ac1b4952af3.camel@codeconstruct.com.au>
Subject: Re: [PATCH v17 1/1] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, 
 admiyo@os.amperecomputing.com, Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Fri, 07 Feb 2025 08:30:52 +0800
In-Reply-To: <b2ab6aa8-c7c7-44c1-9490-178101f9d00e@amperemail.onmicrosoft.com>
References: <20250205183244.340197-1-admiyo@os.amperecomputing.com>
	 <20250205183244.340197-2-admiyo@os.amperecomputing.com>
	 <99629576779509c98782464df15fa77e658089e8.camel@codeconstruct.com.au>
	 <b2ab6aa8-c7c7-44c1-9490-178101f9d00e@amperemail.onmicrosoft.com>
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

> Is that your only concern with this patch?

Yes, hence the ack. If there are other changes that you end up doing in
response to other reviews, then please address the spacing thing too,
but that certainly doesn't warrant a new revision on its own.

> What else would need to happen in order for this to get ACKed at this
> point?

It already has an ack from me.

As for actual merging: If the netdev maintainers have further reviews,
please address those. If not, I assume they would merge in this window.

Cheers,


Jeremy

