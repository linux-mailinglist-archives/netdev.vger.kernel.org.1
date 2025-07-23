Return-Path: <netdev+bounces-209153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC90B0E7C3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB11C867F3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C51519B4;
	Wed, 23 Jul 2025 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clng83CR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7B13C816
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232276; cv=none; b=F9c/k8TE1sngvV6i+wpHNmVU4ZOl0nc+6JS995LMGMrsts0VEEJ8d6LFn9NnT72iqiHBNdoVOS4Y6ST0UqV0FRNnqchdOxBoBjhxMgD3BAB6I7UhzHSm4oM6eDkMWGQ6Epb2GbDjQNgoqyty5Z6yi2pX99JjllLlnetZry4Q9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232276; c=relaxed/simple;
	bh=MmsW+KWITnrFhjK34jJP/gopSL7AZvsOmykg2aMqXL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0c0+qRUe6TiRH+JAIfCs5c/BKU4Q0EemoCey28SFTlGNxtg6gAcxvoj9lkgCxhQKK/BEsp/UlcrVbMqeZlcalkjGzHPh97YsM+Hl/hd/BrMQ5pzoHYn2H43UtE5+H9T1FllyW7HqXA0WmMiR6rn0XRV1Ul9BDlQ9gQ4iKyCA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clng83CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A210C4CEEB;
	Wed, 23 Jul 2025 00:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753232275;
	bh=MmsW+KWITnrFhjK34jJP/gopSL7AZvsOmykg2aMqXL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=clng83CRuMTlMcz7L/6djLGkCYe4y7JjI7dd0VVDKqakWKR7i57CCOzNFJYjZpawv
	 LqtV8qQXDbzyDBGVTnTLwCAZFjjP9EcYQ/ewoYYXx3YNFiVBGlRtOqEuOyaVEBG1F6
	 TunVwYZzCOIYlTFXho24PmbBN5QvjCyA9ZlC+ncWZQmPRA1Dx47cUCZlxowe4staMj
	 IFlyI0MwI2/lGv+AFY7k0FOG8JR/EVOCD/4jKTPE0ooPjZ94PyC2ohCyyUQD2goTdg
	 YEp3DHdxEhsN/y06qWTuhQ3Y/uveWyhOvRc1zA7YYTaX+YumY19WUyONTTrivwm3+G
	 fP/+v72gXxVAw==
Date: Tue, 22 Jul 2025 17:57:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/3] net: Use netif_set_threaded_hint
 instead of netif_set_threaded in drivers
Message-ID: <20250722175754.1fbc925f@kernel.org>
In-Reply-To: <CAAywjhTgBCrSQ9EhaNgoXYaKtqWn0Ks+8=nXo_-rnCU_hV4irw@mail.gmail.com>
References: <20250722030727.1033487-1-skhawaja@google.com>
	<20250722030727.1033487-2-skhawaja@google.com>
	<CANn89i++XK3BFzk4t4bvKeZtqXT-FUCaY_5SkSTOeV0AGNDdZg@mail.gmail.com>
	<20250722154127.2880a12e@kernel.org>
	<CAAywjhTgBCrSQ9EhaNgoXYaKtqWn0Ks+8=nXo_-rnCU_hV4irw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 17:21:30 -0700 Samiullah Khawaja wrote:
> > BTW I think we should delete the debugfs file for threaded config
> > from mt76. debugfs is not uAPI, presumably.  
> +1
> 
> Do you think I should send a patch for that with this series? I was
> planning to remove that separately.

We can attach it to the next series. As I mentioned I don't want to
delay the last patch of this series, so fewer controversies for this
series the better.

