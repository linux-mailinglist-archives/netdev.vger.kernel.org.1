Return-Path: <netdev+bounces-73036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B500585AAB9
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555881F21101
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB4E481CB;
	Mon, 19 Feb 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mku2ja6U"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF4481AE
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366614; cv=none; b=op/OkDjwA/oLxo4OUtG/oCWE7mBLKkrR3vNI6Zjsk9IOMa9kGYyYfqOkDlNwli7B492OBFooCQ9FdNCOjkt32Vzr5s5TBBDCJiZoPLK1/RgaDueE/TqSsy5h3GMw8VpBivmj17DMConHT6uYpbLiqsYHIQ24gxe0IUH2DYnoScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366614; c=relaxed/simple;
	bh=ITrLrI260LHpVSBGrmyu/H/eYmCgrCP09fSGmRTleXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDg/RTe1N3d+sSfhAvR62kLZTUh6AkQkbSuIeRYpRefMePF6+Ig4O6MQ4IZvcoTCe1vuomn9+42KTYVGM/ObAOmD2ooHsdoehf/mfu7XDHQkmqM9tW+VgNUUKJ2qq4tfdntkE8qPSlDl5YWnCHNBjwty5dIhRQFGQL34e5MawVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mku2ja6U; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E058C0009;
	Mon, 19 Feb 2024 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708366609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kDjJIB3VfeqTO3f+6fEctV5vkZFJYMY6TvCtBICPhk=;
	b=Mku2ja6UYNQHS4jXwS577X3RbI+m6wV9QfVDWvUBfAzPlEw3JTlC8ErkWvcAOUFbf598ap
	tOfVAT/JLZwLyRJfl4wuYB8Oj+WMV5LIihi9U+mYTegyHd8h2784sXxY4Wl1AnDju8BuMd
	R/nZS/zv1qTEqB5FYfUDlA3NpNt+e2usNwAT8xGieaxghTT9YIgqLpicEPvnWLBkJykaNw
	9fjfEAiCbMlUY/kgXj5aMhk9+tbqNxLECN6pk03OY/qmgzJVVINsufjGva+/TXLhwbetZx
	ZieMhr6XcZf4EUxYUddRA2+4ckVwRnNc+kLvImBl+GqSU3+ZGXjFxXZCyhKKsA==
Date: Mon, 19 Feb 2024 19:16:47 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: wan: framer: remove children from struct
 framer_ops kdoc
Message-ID: <20240219191647.1e896e5f@bootlin.com>
In-Reply-To: <20240219-framer-children-v1-1-169c1deddc70@kernel.org>
References: <20240219-framer-children-v1-1-169c1deddc70@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Simon,

On Mon, 19 Feb 2024 17:45:48 +0000
Simon Horman <horms@kernel.org> wrote:

> Remove documentation of non-existent children field
> from the Kernel doc for struct framer_ops.
> 
> Introduced by 82c944d05b1a ("net: wan: Add framer framework support")
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Yes indeed.

Acked-by: Herve Codina <herve.codina@bootlin.com>

Thanks for this patch.
Best regards,
Hervé

