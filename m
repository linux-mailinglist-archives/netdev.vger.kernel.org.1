Return-Path: <netdev+bounces-123022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE8C96379D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E604C1F2388F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A117BA4;
	Thu, 29 Aug 2024 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLEYi7fK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30840BE5;
	Thu, 29 Aug 2024 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894503; cv=none; b=cL0Xs1BCiM2Ix2Qmnebr63/KjdQ39mOoTxP90AhKJazwEhWJ7cSkkH2NEJv3WPrnC+NyQHBBPp3X3Pow4BHgI1R0YuXV2IFoMG8p5ucLDSlstO+6kWCCbQJBgMeeHmld/H+bGsPdO8A4edmh11DTHVlwjMAfhqit4Xjd8SCD+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894503; c=relaxed/simple;
	bh=V8XMGni5wY2x3NUArUcHtlp+QJXKGB1EsAnp7f7SXYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOrLn9j2Nm72MsnjPV9OqPuMCQLvS7eAaZkknyVu2/9wczo6E+bPwcYteln8Poxk4L/uDCrufP4RBtL8VoYAgPdazpfZvdImzIjlT0lzfU3sRLFy1CXCw594CDJkWRhNMm89lAgk4z2diA+WyDYMs2XfV0W/8wziXwpwWWZvhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLEYi7fK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A05BC4CEC0;
	Thu, 29 Aug 2024 01:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724894502;
	bh=V8XMGni5wY2x3NUArUcHtlp+QJXKGB1EsAnp7f7SXYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VLEYi7fKcaU/KB82b1cwhMtyysgisSekHn9LtxbkTrjdzn3FTPSIF9LG1i98haVVj
	 9DQ7kPY6pESNEDmRqPDy9UhU+u+7RPbhCEc8fVO9g0gIJF/f7AKyirFtE22xf+s1Q+
	 VjHEHmREMqxDH1EQHTLv2a7FihrJa8L+JFN/WAbChzdbVwsB9D0jH8ZDEF27h4j+/t
	 JaOkZy4Ufbt0MJdExejKv7Oksd/Gp+FB+GTbetvsGQUsqTpaUb77iaUUV717QJocdt
	 ZznUMWOqo9yJDBDM15RGDJ57DzwYPfQqmBCyigAbdJygnce0v+MBUwjt629Bqj0vuH
	 m+mul1dXDHZWQ==
Date: Wed, 28 Aug 2024 18:21:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
 <richardcochran@gmail.com>, <bharatb.linux@gmail.com>
Subject: Re: [net-next PATCH v7 1/8] octeontx2-pf: map skb data as device
 writeable
Message-ID: <20240828182140.18e386c3@kernel.org>
In-Reply-To: <20240827133210.1418411-2-bbhushan2@marvell.com>
References: <20240827133210.1418411-1-bbhushan2@marvell.com>
	<20240827133210.1418411-2-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 19:02:03 +0530 Bharat Bhushan wrote:
> Crypto hardware need write permission for in-place encrypt
> or decrypt operation on skb-data to support IPsec crypto
> offload. That patch uses skb_unshare to make sdk data writeable

sdk -> skb ? :(

> for ipsec crypto offload and map skb fragment memory as
> device read-write.

Does the crypto engine always override the data with ciphertext?
How did you test this prior to adding skb_unshare()?
Could you share some performance data with this change?

