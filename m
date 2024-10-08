Return-Path: <netdev+bounces-132931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A448993C0B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 03:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB571C23D2E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED21E79C2;
	Tue,  8 Oct 2024 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1jQZ3HS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E413AC1
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728350165; cv=none; b=B/O+nof9ZoIiPmoAliJke/8Zf+p8SbFlXlCkDdCIrrex9OwocSp1Zs7P5IUdJR5CHSxrGIe3E9dcdWhn+u/KGF8272O6tzzaB2kaoVn4pBZjeEbgdSWIQKo4YDxUmgjgeVDRKFjjSHSasoOeD5vO7pKrB9spv4L+931/D7yFGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728350165; c=relaxed/simple;
	bh=JBL6/a4FSioJF4HQpe6EcttVKQeTepl/J0XoJlx95nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcwS5sK5YWNsG1F48TsntZAiHoDgUnkktasgHo9geWZ7/N4GiMeZkskTTnOHCX1mg8PinW6GfyUhdAJGrKn8EdNsJDta9HJOEsvqsy1cVUp43nffCktAE+e/zbEAgASrYZHxfGVp+m1rhB76SO3KG2VtIphxtcvWDkss0x0igXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1jQZ3HS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DA8C4CECD;
	Tue,  8 Oct 2024 01:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728350165;
	bh=JBL6/a4FSioJF4HQpe6EcttVKQeTepl/J0XoJlx95nk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c1jQZ3HS2MM58aKkQHAnM+NmSIQQSjt/IQXr74iKXmFxGHOkaGFpYNsFauGnXvAIR
	 L/kPNM25m8M2az9v43HGElzWWVxleKAQqSCt3jd/lqzXRamh/knI2fVC7uczWE5lpH
	 o+YgdcqVpyztaW4ldyaIcL5eCpDWFkl9As99FFu9/OFubXOY1kxvWM2w9/gEqtnVJH
	 gavm0ZhdvZBwbPh3u8JkqijGaP6r3oX/xrxrsc9hCfgSAGeSIxzivaXpE5AhAPdfoW
	 u6FHUJYigN8/m5F3OR48hwW/tZsIV7/FF4DFmrcZWgh9y6AupqqpoFT10H8y82Vdhf
	 abScWRpnHWEwQ==
Date: Mon, 7 Oct 2024 18:16:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vadim Fedorenko
 <vadfed@meta.com>, David Ahern <dsahern@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Alexander
 Duyck" <alexanderduyck@fb.com>, <netdev@vger.kernel.org>, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v3 2/5] eth: fbnic: add initial PHC support
Message-ID: <20241007181604.32b5a330@kernel.org>
In-Reply-To: <a836c401-d071-42b2-9d2f-45d821941286@intel.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
	<20241003123933.2589036-3-vadfed@meta.com>
	<9513f032-de89-4a6b-8e16-d142316b2fc9@intel.com>
	<e6f541f8-ac28-4180-989a-84ee4587e21c@linux.dev>
	<20241007160917.591c2d5d@kernel.org>
	<a836c401-d071-42b2-9d2f-45d821941286@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 16:49:45 -0700 Jacob Keller wrote:
> >> Thanks for pointing this out, I'll make it with timecounter/cyclecounter  
> > 
> > Please don't, the clock is synthonized, we only do simple offsetting.
> >   
> I still think it makes sense to re-use the logic for converting cycles
> to full 64bit time values if possible.
> 
> If you're already doing offset adjustment, you still have to apply the
> same logic to every timestamp, which is exactly what a timecounter does
> for you.

"exactly what a timecounter does for you" is an overstatement.
timecounter tracks the overflows by itself and synthonizes. 
We have the 64b value, just need to combine the top bits.

> You can even use a timecounter and cyclecounter without using its
> ability to do syntonizing, by just setting the cyclecounter values
> appropriately, and leaving the syntonizing to the hardware mechanism.
> 
> I think the result is much easier to understand and follow than
> re-implementing a different mechanism for offset correction with bespoke
> code.

This is fast path code, I hope we can get a simple addition and
an overflow check right.

