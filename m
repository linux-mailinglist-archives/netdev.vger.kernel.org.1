Return-Path: <netdev+bounces-206944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD5B04D3D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 03:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677027AE233
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE0E1990D9;
	Tue, 15 Jul 2025 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bjm0GrI0"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496419B5A7
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542021; cv=none; b=gRjQtbKlZxedAvdQhshksBXB2sQYJRhNR9wPdoUkjEzUCRB4Esl2bpnnauRydEH0p4bsizh9pZgHisxbztU5KhjDwAkcjyoU2fChk2l8f5K4925y1lio9MpeMOy6leOryGnzjyinaYezthMZKbKlRfYNY72oNG9rT0PVludrh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542021; c=relaxed/simple;
	bh=iZ1Z/x+szc5fyfqygYTkGews5MfagU1nTTw55FEMShs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OIiLmBHIbs2xbYtBetj/ugVWy57Q7gtVH3JwxwhtdU3qsPj+4L62CPcN25/AYKppJiU5erxyHjyzpxhqa4hcPXTbVlfYWwxoh07cws1HzLXqywXvmQlLm5+l2MBWAZ7zlbpfU3/wvGK53JjCc64jQyXMLdprHJ3PZq8SfMDRkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bjm0GrI0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752542017;
	bh=OymME5DS5lcuab/W+OvngDG5RR42TaMWIVv4F+W4+vk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bjm0GrI0kKeI28NPqCWmilYR1kcRJvaJcgDyKaLCeZZKwMen/odKKQYRzuVSZkbYX
	 cKZIoxOO2nbUtNe1Py4M7G1YBJD69nhXVYIQEmY7faqAqFzb/96KduLZKfId+M+Jsu
	 18ydbB+WWRMWYUlKsrs9avbgM5XrOYGFeq7OfopQRjECET2JtQhxNn96hiBodQ/o7A
	 TTAM9sYAwv4NMUAHzL9Bb16DLYpebKRJ4Vur36QF4y3mJ1k2h3zk34SlEmhPv9rSE6
	 n25W9JmGrBonsff3LWkiyvTyG7CKsoEoOEmXLZ9Uq4PMbyf9AX79ZjzLDa1m/RFFl3
	 56AKPkmIlPLKw==
Received: from [192.168.14.220] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 52F296B68A;
	Tue, 15 Jul 2025 09:13:36 +0800 (AWST)
Message-ID: <13bda0930870d96ca0c27da57c9b1bf144cc89c1.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 5/7] net: mctp: Allow limiting binds to a peer
 address
From: Matt Johnston <matt@codeconstruct.com.au>
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev, 
 Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Date: Tue, 15 Jul 2025 09:13:35 +0800
In-Reply-To: <a51b1a51-8ff6-4607-b783-1944d324359d@suswa.mountain>
References: <a51b1a51-8ff6-4607-b783-1944d324359d@suswa.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2025-07-14 at 22:16 +0300, Dan Carpenter wrote:
> patch link:    https://lore.kernel.org/r/20250703-mctp-bind-v1-5-bb7e97c2=
4613%40codeconstruct.com.au
> patch subject: [PATCH net-next 5/7] net: mctp: Allow limiting binds to a =
peer address
...
> smatch warnings:
> net/mctp/af_mctp.c:122 mctp_bind() warn: inconsistent returns 'sk'.
...
> d58bad174be0c4b Matt Johnston        2025-07-03   98  	if (msk->bind_peer=
_set) {
> d58bad174be0c4b Matt Johnston        2025-07-03   99  		if (msk->bind_typ=
e !=3D smctp->smctp_type) {
> d58bad174be0c4b Matt Johnston        2025-07-03  100  			/* Prior connect=
() had a different type */
> d58bad174be0c4b Matt Johnston        2025-07-03  101  			return -EINVAL;
>=20
> goto out_release?

This was fixed in the v4 series.

Cheers, =20
Matt

