Return-Path: <netdev+bounces-120357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6F595908A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB66B21AB4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926081C7B67;
	Tue, 20 Aug 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXMonYl5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE043A8D2;
	Tue, 20 Aug 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193351; cv=none; b=hzi5PyzKu7VOzOgbvo/5FPl8+zJd/rFcTJXP+cTVd2txK8nhIFPhsN641omoeuKKrh89lF1u1n13m2PB3sYv1//0GlrMt/DlqYkD3xe8968B/0r6UQplygOEHnqsgJQr9Afxy3tCvw7ijP9RTa1xw1/+wmgwubUBk/S5zYJsdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193351; c=relaxed/simple;
	bh=kk804djJ8UfkY1GYJR19YRqoPjl2bxSclvtq/wtzXDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lF+uby4DR7jAVf98VNpFHvu1RmQ2+QcgTqTqRHqsOm/tZAdV2EKDsQCW7cOrZj2H89lnKs3UObatG9SoaygClO/WFD7WX1dNyBAhPKn4W8vgZOUPjSq00pFd231pKS5oswYiSX5aJXYjTx02vDYQD6l2cMKjCRZTTdiiuh0b7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXMonYl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50572C4AF0E;
	Tue, 20 Aug 2024 22:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724193350;
	bh=kk804djJ8UfkY1GYJR19YRqoPjl2bxSclvtq/wtzXDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UXMonYl509s4ZT+I2jLNvCb5RZao1bUZ83/bG6UVuo/kwTkqtb8XvF9UWmO8g4JEy
	 /iIBqLx8G8Pads83qDrCk2oEbSB5kLqj8dGpj7bYk/auBoIbrBUf/ABjFk2ebmppwh
	 JS/1BNMtmDn/j16nxNcpfvnyY31YGXOjj2lhDGwRYWajeOwUXERcti8n3IOx87Vgn4
	 xqmSpMjLEHmaQB9VNmMhvfz+mVmYK0uWN6GLCRDr59l+2BVLM9iryR8k93FsOav7Xe
	 5BRU20wuOiCZ+EpnEwiDk+Qvgm6ATyooZotHoDUNYSw+CCOeaOTrWZZFHEdc6q1+pW
	 2E2jV8dWu0uHg==
Date: Tue, 20 Aug 2024 15:35:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
 <richardcochran@gmail.com>, b@mx0a-0016f401.pphosted.com
Subject: Re: [net-next,v6 1/8] octeontx2-pf: map skb data as device
 writeable
Message-ID: <20240820153549.732594b2@kernel.org>
In-Reply-To: <20240819122348.490445-2-bbhushan2@marvell.com>
References: <20240819122348.490445-1-bbhushan2@marvell.com>
	<20240819122348.490445-2-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 17:53:41 +0530 Bharat Bhushan wrote:
> Crypto hardware need write permission for in-place encrypt
> or decrypt operation on skb-data to support IPsec crypto
> offload. So map this memory as device read-write.

How do you know the fragments are not read only?

(Whatever the answer is it should be part of the commit msg)

