Return-Path: <netdev+bounces-233059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE68EC0BB04
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5ACBC349818
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C6B2D0C8F;
	Mon, 27 Oct 2025 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yu+kPtf3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722215C158;
	Mon, 27 Oct 2025 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761532256; cv=none; b=DXj5kW4lsNTXs6Lzfp2i9eaIEQgVvs1Sqd/V87gLb/Vs8XyZfzAIepeG/OoGqYA8YvShmRK+3gKhM6q9NIFM/XSFQQZhYIwTqmrp3Gm36K7grepZ4apCXwZiJEGRWMXtDa2hK5llNnD2bnIFU7DGAwX4IIPQKatZoc4/xo0JgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761532256; c=relaxed/simple;
	bh=oqvc5v4ranmC5iE3oWnXlMsOHgF5s6guC5HLfROWycY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga3ImN03HE/ZO3ZZZzc400jx1ZkqSU8ucZ/fWrcXf3yRL3yC8WdGoJgSkyNObNCVyglIfCpqI36B+GIBJ7jywa1fq1fBXL0c60DEIZRJZiXFt2eZhlKAcJ/uHDNC9Ez7C7ZAN+Bp3R4zREI1E+kRFCJ6PpAEQF8k+AGbKeYE7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yu+kPtf3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xp/wA3Fp4AJdWr9N7jvPoaU+e4cgftlch+OYMg6F3A8=; b=Yu+kPtf3oqnzzpHlUHpgNe/dRY
	lAZ2Xm/Ma4TmwiJ7dpgqoRFXzYSU+GR5GDvVlGklamiTSSbE2tlpKBG+0hzIL0SKlI8fLVJJuOzNB
	ThEuEP/mvzlnZLbd1+qan1j/g+DI9QOjGYI7iRA3Xj27O8KtGrHxDrN+V7z4zWPjpwD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDD0P-00C9OF-7c; Mon, 27 Oct 2025 03:30:45 +0100
Date: Mon, 27 Oct 2025 03:30:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: yt921x: Fix MIB overflow
 wraparound routine
Message-ID: <cc89ca15-cfb4-4a1a-97c9-5715f793bddd@lunn.ch>
References: <20251025171314.1939608-1-mmyangfl@gmail.com>
 <20251025171314.1939608-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025171314.1939608-2-mmyangfl@gmail.com>

On Sun, Oct 26, 2025 at 01:13:10AM +0800, David Yang wrote:
> Reported by the following Smatch static checker warning:
> 
>   drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
>   warn: was expecting a 64 bit value instead of '(~0)'
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/yt921x.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index ab762ffc4661..97a7eeb4ea15 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -687,21 +687,22 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
>  		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
>  		u64 *valp = &((u64 *)mib)[i];
> -		u64 val = *valp;
> +		u64 val;
>  		u32 val0;
> -		u32 val1;
>  
>  		res = yt921x_reg_read(priv, reg, &val0);
>  		if (res)
>  			break;
>  
>  		if (desc->size <= 1) {
> -			if (val < (u32)val)
> -				/* overflow */
> -				val += (u64)U32_MAX + 1;
> -			val &= ~U32_MAX;
> -			val |= val0;
> +			u64 old_val = *valp;
> +
> +			val = (old_val & ~(u64)U32_MAX) | val0;
> +			if (val < old_val)
> +				val += 1ull << 32;
>  		} else {
> +			u32 val1;
> +

What David suggested, https://lore.kernel.org/all/20251024132117.43f39504@pumpkin/ was

		if (desc->size <= 1) {
			u64 old_val = *valp;
			val = upper32_bits(old_val) | val0;
			if (val < old_val)
				val += 1ull << 32;
		}

I believe there is a minor typo here, it should be upper_32_bits(),
but what you implemented is not really what David suggested.

	Andrew

