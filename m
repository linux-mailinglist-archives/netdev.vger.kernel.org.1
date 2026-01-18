Return-Path: <netdev+bounces-250901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAF4D397B6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD9013005B91
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97091FF7B3;
	Sun, 18 Jan 2026 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WgApr0jE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E3171CD;
	Sun, 18 Jan 2026 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768752422; cv=none; b=tAjF/gVtwifUlGnw2EwuSBcF/bXGbqs3TcN6e35J0IdOeDlu5BzAH1wQ92nWtRQNQihQdxjVrCuuGeZjgB4OyImw1hvhk0xTQJlgbQsEyNjZe+YWdgYvJO2tR534EEtpxCRTwJR05n4dbeJKR84GWHbyKNZrApR5WFOvIoG5urQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768752422; c=relaxed/simple;
	bh=PYYKQHME8BcbdvvjgN3DNo0ndMOEmx5iegw/X+KE/V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUTCJWsRfPJM3w2B/qH+x8i6X4UcrJdjkQuMmOQ9mkyg5zbB2WpAeNeJ682c6ZN3EbX//CDSZiEGCpdvJDngRrROy1hzSlxDAjkYkIOjOZURAips73/hGRynx0lZW8LEwsHAk12/MbNpw7Om7T8qxV6+OV1uEA4cdo/ev9js0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WgApr0jE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i4gSKN9gBKNJlYD3KQYNpAc2MI48Gajd+JBAqcB6IUk=; b=WgApr0jEJOLNDcPMYH95uQumKn
	upw2qR1wHjhQu0XI3v9seXHHEzZ9C+EvN6xopI8hLYZzIQZeYiDyZeAoKCKMkOhWq6NhXwzme1z6y
	dypmsm20ssyd8KPbAoflyjjCiB1bTdnhm+3S0xK/BQcibBhE6HdfiKQRSzqBlfeMZWUY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhVIj-003Mkq-O4; Sun, 18 Jan 2026 17:06:53 +0100
Date: Sun, 18 Jan 2026 17:06:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/3] net: dsa: yt921x: Return early for
 failed MIB read
Message-ID: <5afaff9c-7be2-4464-b675-4bf70aaa17af@lunn.ch>
References: <20260118013019.1078847-1-mmyangfl@gmail.com>
 <20260118013019.1078847-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118013019.1078847-3-mmyangfl@gmail.com>

On Sun, Jan 18, 2026 at 09:30:15AM +0800, David Yang wrote:
> This patch does not change anything effectively, but serves as a
> prerequisite for another patch.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/yt921x.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index 5e4e8093ba16..fe08385445d2 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -707,6 +707,12 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  		WRITE_ONCE(*valp, val);
>  	}
>  
> +	if (res) {
> +		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
> +			port, res);
> +		return res;
> +	}

I know you are just moving code around, so i can understand a straight
cut/paste.

However, when i look at the code, what is the point of %s and the
constant "read stats for"?

	Andrew

