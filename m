Return-Path: <netdev+bounces-135873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6835D99F78E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A4C1C21CA7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4C41CB9EF;
	Tue, 15 Oct 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOuidJCU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830561F80C7;
	Tue, 15 Oct 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022076; cv=none; b=FHsoPPqJLCwxqYemnJrt6dxmWuwYdk6tPyIwIHcQ7cICRazZRCZpb+i3FAVlwYiYMNqAQ7CwvOPkoKc34xp9kfhdz4DfxibsYCSDYJbgkCZZ53iIMRqOCwGgfjMgcOXMlQ+pMqMJJgtuCuhPyQvkJeJ5redhhdzMsFkwQIj6jZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022076; c=relaxed/simple;
	bh=vXm4/hvPpAm8zJjBdiS3HDmCk3svgCMsk8IOgqsuWlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNL9drmqDKghmr/YCwOaZhSqWqsa0sdNRkZfqOCPhO/UlDnsnHeLSvmIr3B54fnxmtsNflMcnCeIhLA4Tn+LTkjJBh1buQxxTVUf50wJ1BrumVaTQw+hbT7baB5C96X0fSGd0fqOSdKJ95smFKpAUbYhpwY3RfLcW968FsRet44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOuidJCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854B1C4CEC6;
	Tue, 15 Oct 2024 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729022075;
	bh=vXm4/hvPpAm8zJjBdiS3HDmCk3svgCMsk8IOgqsuWlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZOuidJCUhKQyJEjzBFlVudNI5i6+Vf7QEAkMfbEOAm/dGNIbD819eBehS6vKjOMI1
	 s5sC6WyA21/hBUs759k5Bwi6Qd88TYuBt2xYg0FYe/TxvgfZv1Lb8bWERHnMnKIDP6
	 iw8+7DLb2WjFv5A06+mb5RvmEP09ThN+4xLwCMVNZwljUxvdpnF12/qiBozrLLUKd0
	 fZcukD3UVhJktvgcXr9wdkQVCXUGG6XSzxY0+tTR7RFLSHv/Aosx2I/G9mS+UUcFdc
	 IB1kiJPlOmr9mKOFxxPrOh4x1x8ZRfV6//JtUIkiJnn+WScufiOlk83Yiq37mkFEUQ
	 XNfqaiEt/ILEg==
Date: Tue, 15 Oct 2024 12:54:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Wang Hai <wanghai38@huawei.com>, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 zhangxiaoxu5@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: systemport: fix potential memory leak in
 bcm_sysport_xmit()
Message-ID: <20241015125434.7e9dfb04@kernel.org>
In-Reply-To: <ed541d60-46dd-4b23-b810-548166b7a826@broadcom.com>
References: <20241014145115.44977-1-wanghai38@huawei.com>
	<0c21ac6a-fda4-4924-9ad1-db1b549be418@broadcom.com>
	<20241015110154.55c7442f@kernel.org>
	<ed541d60-46dd-4b23-b810-548166b7a826@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 11:07:29 -0700 Florian Fainelli wrote:
> >> Since we already have a private counter tracking DMA mapping errors, I
> >> would follow what the driver does elsewhere in the transmit path,
> >> especially what bcm_sysport_insert_tsb() does, and just use
> >> dev_consume_skb_any() here. =20
> >=20
> > Are you saying that if the packet drop is accounted is some statistics
> > we should not inform drop monitor about it? =F0=9F=A4=94=EF=B8=8F
> > That wasn't my understanding of kfree_skb vs consume_skb.. =20
>=20
> Yes that's my reasoning here, now given that we have had packet drops on=
=20
> transmit that took forever to track down, maybe I better retract that=20
> statement and go with v1.

Sounds good, we can apply v1. Would you like to ack/review here?

