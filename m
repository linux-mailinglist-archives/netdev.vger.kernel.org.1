Return-Path: <netdev+bounces-53848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BFE804DED
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F548B20B80
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84983F8FA;
	Tue,  5 Dec 2023 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="xFTMUKXr";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="aW6B6SpX"
X-Original-To: netdev@vger.kernel.org
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE349B;
	Tue,  5 Dec 2023 01:32:06 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 4169FC022; Tue,  5 Dec 2023 10:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701768725; bh=Bcs2wqbN9pFVw67N2sNg9eeh6V11qjKxUE3FaK/pUSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xFTMUKXrihhDPAXEq6ldua3G1TG6BFCYfSdnMZVvsrIkdaiL5tRpFWgWUiHwXQSja
	 lP3w87pKZyI+0ctVEoF51b8dm3zwwA+5fD8femtJakh9CThlmdMYGtNepsDc5ys2fV
	 poR8aiWuxQu/DffkdVEbYPwBCMNq0EPJ3T9QOF6WSvrIaT9z4+/gn0x7Sl2ngtzmHy
	 1aenxesO023aylpNmoGXrs7cA1n7MKujJJfjzW5zlioIEuxKVsF2NNyypE2T+sm9pW
	 SmLbAVEDeRQIsf11jpLmElPeFHS8Flas3P0oub32MoIDGUYmOPfBhRzeUqc3nUaAFc
	 dA3/YWg7cN+HQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 7F8ECC009;
	Tue,  5 Dec 2023 10:32:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701768724; bh=Bcs2wqbN9pFVw67N2sNg9eeh6V11qjKxUE3FaK/pUSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aW6B6SpX7GCIFOKh1snzGGYDqWdOHLrB2fzRC5ZxtYbsQMtDsIpyZK8HIgMuCV+gj
	 Bcn00mMZ+oGZNIpxt2G72E5g2rVJb84YmptEXh05b2Vio1Q48groPrD1wSAwS4mwig
	 OQkEtroJPLaPmBRJMp3iNqdS5qZBXWe8GTfhNWYCXU+OBlGIZHBgMCWIHIsRuFvbuy
	 qbrHrm9WkIrOaUcrKKLN23N47vaXfmRpokGhD1P5pREqAJWiGKSftubt96DIkFXaJR
	 ZJe3EiVPELTs3epJmoDYarjYKUpfMEANLfR/0O3clADUtEWrYCQ46CgJt+ZFDCWlbd
	 rhZ/Qvucjdv5w==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 8d6a1af9;
	Tue, 5 Dec 2023 09:31:57 +0000 (UTC)
Date: Tue, 5 Dec 2023 18:31:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZW7t_rq_a2ag5eoU@codewreck.org>
References: <ZW7oQ1KPWTbiGSzL@codewreck.org>
 <20231205091952.24754-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205091952.24754-1-pchelkin@ispras.ru>

Fedor Pchelkin wrote on Tue, Dec 05, 2023 at 12:19:50PM +0300:
> If an error occurs while processing an array of strings in p9pdu_vreadf
> then uninitialized members of *wnames array are freed.
> 
> Fix this by iterating over only lower indices of the array. Also handle
> possible uninit *wnames usage if first p9pdu_readf() call inside 'T' case
> fails.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> v2: I've missed that *wnames can also be left uninitialized. Please
> ignore the patch v1.

While I agree it's good to initialize it in general, how is that a
problem here? Do we have users that'd ignore the return code and try to
use *wnames?
(The first initialization is required in case the first p9pdu_readf
fails and *wnames had a non-null initial value, but the second is
unrelated)

I don't mind the change even if there isn't but let's add a word in the
commit message.

> As an answer to Dominique's comment: my organization marks this
> statement in all commits.

Fair enough, I think you'd get more internet points with a 'Reported-by'
but I see plenty of such messages in old commits and this isn't
something I want to argue about -- ok.

-- 
Dominique Martinet | Asmadeus

