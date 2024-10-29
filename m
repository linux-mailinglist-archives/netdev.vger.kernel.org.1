Return-Path: <netdev+bounces-139939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DBB9B4BC2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3591C22721
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5B206E80;
	Tue, 29 Oct 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="IgQurlvF"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1021345
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211034; cv=none; b=kuI8Q1HLoeJ+7TCsXn/EKMxxg0cn2LTn5btr0XWlK34FVI1HVHtQfMRRCOvYcB5GadXg8uHCo6ZJNNIjNO/+TrbQV0i9FUX3evm8roLH4GCBNMlmkuyMBfhtSSUwiCMTfjnP+Evb+b4ZIJqH4QAAz+BjwDVRlkbt59OjZ5IM+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211034; c=relaxed/simple;
	bh=AJTK+6/kMKORkTlvqrVf83EFCPr2LaZhC6uKdi4hEVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sG2Mf7Rd3CL0Kr4fB+ko71jJ4ZY0/c0dFEw+7jC80E+BY3WB5Un9Vu3h8TovXhQI1iIiy7CmLlDUQL/h2C9mqtq1VuZ7xuapLa4GbQaeZevUdCDE1IX4s2qq7npoSJ2/0iC0xrK2jLtoorUWOfHxrk2LyRvi3lrnQDYTuhVkQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=IgQurlvF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730211023;
	bh=AJTK+6/kMKORkTlvqrVf83EFCPr2LaZhC6uKdi4hEVg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IgQurlvFtSejd84FS0p0sKYNdPN3IRW7URguksHC2pHLKBhY7Bi3N93Hn3JIdPZbZ
	 u2QYQdSYXhTKIASas0TOF2CtBomFxpbC0g2Dg8w0T5JS2XbkYaU+vAxAeEVPLHH09v
	 /Yx+UFqz9mNI8GNmujqs0R5IvfNzMQJ/daIaMuu5mt0srI2rPXpbY/tirNPXDlXMb+
	 iIvR7wG92s+Nkis6CRHwpf+JlCuW2rknzgmKewwFJNAWE7ISLZpAlutQ8WnShNIWt7
	 x63MsNBq7gvv9Kqi9+zd8W3MIlAdXGCkVuRNJkZ9gg/FGbsTuvTt3aGZvn0hxV0oRc
	 FUhwQ+7VS1gTQ==
Received: from sparky.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E3FB66A28C;
	Tue, 29 Oct 2024 22:10:20 +0800 (AWST)
Message-ID: <f241ba4c7b57ec5142648de2b14cc070b0708823.camel@codeconstruct.com.au>
Subject: Re: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after
 free on unregister when using NCSI
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Joel Stanley
 <joel@jms.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>, Jacob Keller
 <jacob.e.keller@intel.com>,  netdev@vger.kernel.org
Date: Tue, 29 Oct 2024 22:10:24 +0800
In-Reply-To: <29efcfe2-852d-4df2-9b9c-a06b4fd2deed@lunn.ch>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
	 <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
	 <fe5630d4-1502-45eb-a6fb-6b5bc33506a9@lunn.ch>
	 <0123d308bb8577e7ccb5d99c504cec389ba8fe15.camel@codeconstruct.com.au>
	 <29efcfe2-852d-4df2-9b9c-a06b4fd2deed@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andrew,


> The order should be reversed, you undo in the opposite order to what
> you do. This is probably not the issue you are having,

No, it's not - the crash occurs before the introduction of the phydev
for ncsi configurations, so the order didn't matter in that case.

> but it does show this driver has ordering issues. If you solve the
> ordering issues, i expect your problem goes away.

"solving the ordering issues" is probably best done by the driver's
maintainers; I have very few facilities for testing the various
configurations that this driver supports.

I'm just sending a couple of minimal patches for crashes I have seen.
All good if you'd like to explore some further driver surgery, but I'm
not the one to do that.

Cheers,


Jeremy

