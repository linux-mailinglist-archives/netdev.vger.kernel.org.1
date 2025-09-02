Return-Path: <netdev+bounces-219042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D4FB3F828
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D30B7A2630
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CA519F464;
	Tue,  2 Sep 2025 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/jGJEGK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494632F74D;
	Tue,  2 Sep 2025 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801097; cv=none; b=q2YCuRQfe7W/DeIPQdVFVgidujyPqqZROODG++4aGQM+LLCa2oSnc8/Gi5R7ip78liPy2SzSiBonpaJsyQ60HFmOLZV7VpY7AFrR576e3bcoh0kylEsbT9x2mA5bONHZ4xNMsE5zdOSDkeUZHfDfq82CUMBZug7oCvk+BIF71n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801097; c=relaxed/simple;
	bh=p/A+g/Dk6J6noBc+vAtCnRHf8Lw5+fExKlB37haLfws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK1j3N0r7ZuxJU3Uy2418ujRA52CL92jn2jWpzjK2Oj9EVZPk3Kedbd10xEHZu0jWvamyzmhVsDs8lJPdwRJM+qF484UNA4F4xs21myFGL2K7GQz2oVgy6IDDQajFwzuvNfKWQ1g1Eb86q+hN75Ohq9SuJDzWwzLgPGERw/WWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/jGJEGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162F9C4CEED;
	Tue,  2 Sep 2025 08:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801097;
	bh=p/A+g/Dk6J6noBc+vAtCnRHf8Lw5+fExKlB37haLfws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/jGJEGKcWC+foksvdOjZeV9yTarpPORH17WhxzzV+kLDBY1/+ACG7TORh4lcCgiB
	 phoy8O/Nyw3e8nJWcy9Ereu/HFPr3g+/2w+gYU+nyM4Og7zxtILGzZn7wAJjejOwOH
	 J3dJbznWJLFYi7wGTPi1LqN0IH563T3QMU+yFgmBwHuIWNShvmHOBjai92xybkxgmQ
	 fFObp/ZeKwVrxww4BjDzQzFCDRWmNrvkBBfedjQLhZE5NK04tTaqSTIQvraZdbNsxr
	 VatQZ9DRx448ouL/3MBf8Kom62H1u/8ae42l8vG328dOxEP+5uSJ77CKgCKihEmP6A
	 YJFtbSiTO9X6Q==
Date: Tue, 2 Sep 2025 09:18:12 +0100
From: Simon Horman <horms@kernel.org>
To: chuguangqing <chuguangqing@inspur.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ovpn: use kmalloc_array() for array space allocation
Message-ID: <20250902081812.GQ15473@horms.kernel.org>
References: <20250901112136.2919-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901112136.2919-1-chuguangqing@inspur.com>

On Mon, Sep 01, 2025 at 07:21:36PM +0800, chuguangqing wrote:
> Replace kmalloc(size * sizeof) with kmalloc_array() for safer memory
> allocation and overflow prevention.
> 
> Signed-off-by: chuguangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/ovpn/crypto_aead.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
> index 2cca759feffa..8274c3ae8d0b 100644
> --- a/drivers/net/ovpn/crypto_aead.c
> +++ b/drivers/net/ovpn/crypto_aead.c
> @@ -72,8 +72,8 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>  		return -ENOSPC;
>  
>  	/* sg may be required by async crypto */
> -	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
> -				       (nfrags + 2), GFP_ATOMIC);
> +	ovpn_skb_cb(skb)->sg = kmalloc_array((nfrags + 2), sizeof(*ovpn_skb_cb(skb)->sg),
> +					     GFP_ATOMIC);

I think this could benefit from:
a) Removal of unnecessary parentheses
b) Line wrapping to 80 columns wide or less,
   as is still preferred for Networking code

(Completely untested!)

	ovpn_skb_cb(skb)->sg = kmalloc_array(nfrags + 2,
					     sizeof(*ovpn_skb_cb(skb)->sg),
					     GFP_ATOMIC);

>  	if (unlikely(!ovpn_skb_cb(skb)->sg))
>  		return -ENOMEM;
>  
> @@ -185,8 +185,8 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>  		return -ENOSPC;
>  
>  	/* sg may be required by async crypto */
> -	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
> -				       (nfrags + 2), GFP_ATOMIC);
> +	ovpn_skb_cb(skb)->sg = kmalloc_array((nfrags + 2), sizeof(*ovpn_skb_cb(skb)->sg),
> +					     GFP_ATOMIC);

Likewise here.

>  	if (unlikely(!ovpn_skb_cb(skb)->sg))
>  		return -ENOMEM;
>  

-- 
pw-bot: changes-requested

