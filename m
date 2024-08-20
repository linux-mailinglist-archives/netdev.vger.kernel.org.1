Return-Path: <netdev+bounces-120256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8A3958B2E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708091C20A79
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DF41922D3;
	Tue, 20 Aug 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/VAVt1v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4BFC11;
	Tue, 20 Aug 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167575; cv=none; b=JLHfX6XRil2myKXRRwz7ZSUGgMhyUHlxvqG/F3YyRlHGzitIwGuczMpkk27CLoIRwhvTBBS/DA21wJCyNMPR5zDCsjVz5Dgat71yZL6hLwV393uCVvdwnJwMUiHTuwRkJCQqmtIhiyO5wk7opszs+l0KKzBJK5UmF0XKdTbgTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167575; c=relaxed/simple;
	bh=0N2hky20qHVrd1H0pYNXeX1ioHqZ/ak6QZOSVXGCN3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1wkllhysItrcgYPRyVhb1Hro+BJ3HbcP9cn8ja7emzh5PDmFkBCnNvpQ5+fc4nhPfeGC7hTVN4aDqoWE7oKuI340Ck/kd1SJT3T2ZaycRNmCOheLY5TYG2aOOGLjrN9uQN98teS8HwEh8IIhd1xRXEjm51Kg9Ou4gE9bzpdfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/VAVt1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FD1C4AF0F;
	Tue, 20 Aug 2024 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724167575;
	bh=0N2hky20qHVrd1H0pYNXeX1ioHqZ/ak6QZOSVXGCN3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l/VAVt1vt18f7fUvxJBc0b0J0MM0Vz/422bZlgjZnWyEsQjVuyGyhawhjt3EbBs/H
	 oDOXq6UmcVBE/eL/RLoMKWIBAMq6b3JmGi9QKpHYTRJDRt4QWUP3GK7Y67e0l97Ipg
	 Lu+g4C5tuCTuqSu9vfUZDijr+EBBnLmNzof+ufFOp2Hy0PJGl8Vhz/JlgWhoUAQSmo
	 MyV9R2ovScfRbRtA8MyrGRLUzxdkeBT+l1hp7ykiGgvdrsuZqtl2n2M8yg36th3Gd9
	 sEQ2/E4jSNmQKfLJJd10c+v1VP8ftc3cwQqKmtb19EvunroAofuoAaC7TV8Mx+R0d2
	 8ASDurBl0brsA==
Date: Tue, 20 Aug 2024 08:26:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] nfc: st95hf: switch to using sleeping variants
 of gpiod API
Message-ID: <20240820082614.0e9e9192@kernel.org>
In-Reply-To: <ZsPtCPwnXAyHG2Jq@google.com>
References: <ZsPtCPwnXAyHG2Jq@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 18:10:32 -0700 Dmitry Torokhov wrote:
> The driver does not not use gpiod API calls in an atomic context. Switch
> to gpiod_set_value_cansleep() calls to allow using the driver with GPIO
> controllers that might need process context to operate.

Could you explain why? Are you using this device? Is it part of some
larger effort to remove an API?

