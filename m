Return-Path: <netdev+bounces-177295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799FA6EB8E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 09:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C431894850
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F81F1300;
	Tue, 25 Mar 2025 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bXP5bnlv"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBB2528E5;
	Tue, 25 Mar 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891406; cv=none; b=dQluWEAXE/LEQmcwBsnBkUvuO6trNR5O9IVQJXfWj6dg3dKyHMOfOWTW99EBYqW51495vPhhtHYmRZ0oHK4Kx8pSeHFdXYLBeZioDPf2tY+MZQdeD7IQuZ3psagJCmrar7W/9CEjfAs0Ke5MM7cJmcr1F4oPGVN048hjPtiq74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891406; c=relaxed/simple;
	bh=nAVOsZQJ92gRn3Ahuu2IieJvTrdds8cOxyHP0tu8+nA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lq+eNvQjsmQa2haWiBRYnKOWxrdxk94F0fF3bUR6dOzNm4ZshbVx8VHYTRX3gcMFQbtpidjb2D7qK1zK03zrDNpP7Oh1EkC9h4iqupydYDCBZeUUzK9uV/ePWsg8Cuk8siRUTnvbpCKpYZA7YRdv35kCyAgx+DatRLOv0QXFgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bXP5bnlv; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742891401;
	bh=nAVOsZQJ92gRn3Ahuu2IieJvTrdds8cOxyHP0tu8+nA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bXP5bnlvKuKsTcBNF5So5XQ1L8cVkqXYJ+5Qsomet5R3Oz0goUAN0ZevLqf8CZQFI
	 vGdQV5j9Q9JBN9oh9J9GoNL6dEOBV4G/X4sm8fgHcFw6etuiPo4JCO9VctM8kggY4N
	 VOiGOxBc4g7sOyXef7PkI4mAqPZ1pSztYAZVWWdwbTsT/spvgzwePo+Q/YG6f3sejR
	 hz5+iU/aLAFUq53ebSwPJY1PjMN2xfS4PiVGYvdFsWOPWtBFEGXfFpvjsgSdDUaG6b
	 hYDyQni+sTcOeGwRscUhed1PDzc/YrGJG7T+WkYPWp7E8Z1oVvDXZoUhpVKhZ02+wO
	 1nJdIzeeE84SQ==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C119A7B42F;
	Tue, 25 Mar 2025 16:30:00 +0800 (AWST)
Message-ID: <b24e0c05bc9ae6eb102d71119bc3dd917a7f7c6d.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp: Fix incorrect tx flow invalidation condition in
 mctp-i2c
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Daniel Hsu <d486250@gmail.com>
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org, Daniel Hsu
 <Daniel-Hsu@quantatw.com>
Date: Tue, 25 Mar 2025 16:30:00 +0800
In-Reply-To: <20250325081008.3372960-1-Daniel-Hsu@quantatw.com>
References: <20250325081008.3372960-1-Daniel-Hsu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Daniel,

> Previously, the condition for invalidating the tx flow in
> mctp_i2c_invalidate_tx_flow() checked if `rc` was nonzero.
> However, this could incorrectly trigger the invalidation
> even when `rc > 0` was returned as a success status.

Yes, and we should be seeing rc > 0 in normal behaviour...

> This patch updates the condition to explicitly check for `rc < 0`,
> ensuring that only error cases trigger the invalidation.

Looks good to me. I'll do some testing in my environment here, but in
the meantime:

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

I figure you'll want to target the net (not net-next) tree, in which
case you'll probably need this:

Fixes: 338a93cf4a18 ("net: mctp-i2c: invalidate flows immediately on TX err=
ors")

Thanks for the contribution.

Cheers,


Jeremy

