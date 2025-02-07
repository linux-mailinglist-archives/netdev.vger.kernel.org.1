Return-Path: <netdev+bounces-164210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C1DA2CFDB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 22:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902A31629FF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558851A8418;
	Fri,  7 Feb 2025 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI84LY+U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856CA1BC07E
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964312; cv=none; b=Ukh2GBO2hcGLkZiAWvNyg6rNlpgBRxAx6Z5ANErM/NwJi2grrgv3cawW6bSBptqeXbTtK+3HIsnjzS3ciSLtnpivB2uUR1M3TJGovLQWj5k0Ber0mmT+inOWmsXo+KAWbqSclw42lGRqGwKWxNLck7Unu4X+u6nu1eBo/ffgJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964312; c=relaxed/simple;
	bh=gr9VEPaQiARLAyCwAlhOr4tBEEh63PrDoIaQP0hl77Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byrn7g/0akT0HNDGhdcSJv4ZCnHiohb9btX0B/gB1Mh4o6i/ubrZL3G/K+deBWhY6WW65k01lbunv1lbU9BZek0VfEX0fBSsB0xAw5l7VLpcz3F8NxPb/0QxeQ6jO6aGRKvscfCOPydCrfJfjQ8WQDI23+ixhjfbqTwFNqiFtio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI84LY+U; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7922f8510so10975566b.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 13:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738964309; x=1739569109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gr9VEPaQiARLAyCwAlhOr4tBEEh63PrDoIaQP0hl77Q=;
        b=mI84LY+UJvFGpZnFmdy+GchAOHWUPuXauJ8fVZMKrY3/bIfNcPufP7Ik/RQ3JaJDLn
         EPZx49SNuz6+Ug4fN+60rXypTG4Zzfch1BVT9GaWKCWPKK4I9+GK4t5I1p1xWwesMFGB
         vC24QGKFns+B8f3IdcyF5G8yE+NdwgKMlwpchf+FBJdTMRrXoM342H1dFlrXTtZfJv62
         wXYykqQF/Sbtl+bpMYFoiyaBAWdh3Aw8nM7O/krzEiMUG9MK51aNd7wjB69kbnenFqDf
         m8muctTYq7tluZgHNZq2/caagwOUKl5PlOVwYq2qRIfVcHolDIBtcWdFv850NpPJvVLN
         Zfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738964309; x=1739569109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr9VEPaQiARLAyCwAlhOr4tBEEh63PrDoIaQP0hl77Q=;
        b=m1o8W5cIkyMM6dTxGUik6IobFQZfbRLTJJSQc9Z+rcmC9dqay1D5zb0DntEAhwFIdr
         Zq8MmwlEVRZgRmixKW78uhTZLPJ4Z//5XzOrXSObWVakQWDcTHLgrOvtr2+mCYqtLRXD
         E7OTtOKbl8Wi9/qFuW2500E/04/cstdoqBFVEJrej3NYKcU9EFTFGLgImWVQa43A6ZLZ
         jIDVkd+KFptv+EHULNSy8qv8dLnrr/G2T9DpbLEilRt22OYzQHtUUrKBw9bPOLUgLppn
         3Z/Ncw/dfgfq02AQisWQ3yhauFUa3JorQCqu2o3p+p9yGHOOyOtMkZYsptk88MBb+Rbu
         6k2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZnFQl8FdBy08APZ/9A2GR8XBJ9G+vaFFsXGbUq3BmWISVEkAavSO2xLSE1rhx33Wh+xPfrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBY/KsVZojJ4dsVBgK1p+HEHw65dKePF+sTlgQd9d9Ff3unuwF
	Ej3HZtqVkPk7iYMj6EOTuE18p/N4jfLxsWmhZpKNuF0mtEkwbkch
X-Gm-Gg: ASbGnctQhO7BqIOEQOtymQbtaZXpArIqZRHgA1X0/tQm6JMJmhrFGEVbjv2RIXErtIP
	Re1Orjp0kyLsGexdEln5jlH8iwPsX97ILDKP39YzpYJlNLCl7GfcdoyGiqDXwsYeDWBF9RqX21U
	FLQBh8pUqlww8QUNdpnAybuzBYumuC+nl6QJuCj4++gZcSUzUwFvuYo4hTFMJT6+jFd3GuiH7ow
	BJ3eCdJbJQWRBfJiq2DAMLSobOa+BMPddsAbmz4N6SEeW3NUH6rHP/V4Bnftgg4gC9bqcyWHnoK
	Edw=
X-Google-Smtp-Source: AGHT+IEbl3ScrFja/NJm9wAQ69PqhUaZeve8wDcZpAf9mkb2psE9C9zpwnLLE8BSnYVHKlIS6q1f3A==
X-Received: by 2002:a05:6402:5254:b0:5dc:740b:3cd9 with SMTP id 4fb4d7f45d1cf-5de450aba25mr1916038a12.5.1738964308342;
        Fri, 07 Feb 2025 13:38:28 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf6c9f8besm3202574a12.52.2025.02.07.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:38:27 -0800 (PST)
Date: Fri, 7 Feb 2025 23:38:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: dsa: allow use of phylink managed
 EEE support
Message-ID: <20250207213823.2uofelxulqxpdtka@skbuf>
References: <Z6YF4o0ED0KLqYS9@shell.armlinux.org.uk>
 <E1tgO70-003ilF-1x@rmk-PC.armlinux.org.uk>
 <20250207151959.jab2c36oejmdhf3k@skbuf>
 <Z6Yn2jTVmbEmhPf9@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Yn2jTVmbEmhPf9@shell.armlinux.org.uk>

On Fri, Feb 07, 2025 at 03:33:46PM +0000, Russell King (Oracle) wrote:
> Bah - actually I _did_ update the patch, but in a different tree:

I'm glad there's a reasonable explanation for what appears to be an
oversight on your part, and I wish to make nothing more out of the event
in itself.

I just want you to know that it was really hard for me, looking back in
that thread to make sure I'm not misremembering that I asked for this
change, to get reminded how quick you were to jump to an insulting and
sarcastic conclusion in that same reply. It was a shit reaction and it
really didn't sit well with me then, and it still doesn't sit any better
re-reading it 3 weeks later either.

I don't like it that the more subtle hints apparently pass you by, like
me leaving a link to your entire reply, so I have to tell you straight,
even though I like that even less. I want to respect you and I'm very
careful with my words around you, Russell, but I need to know that you're
mindful of your own reactions too, because otherwise it makes me feel
that we're on an unequal footing.

Whenever you make a sarcastic comment about how people don't do what you
expect them to, as if the only possible explanation is that they must
not have read what you said, because if they did they must be dumb or
something, you just put yourself up on a pedestal where you're above
making mistakes and above misunderstanding or not thinking things
through - which is such an obtuse way of looking at life. And so, when
you make mistakes like all humans do, it's really hard for me to react
in a way that isn't just giving you back a little bit of your own venom.
But I've tried that before, and it led nowhere, so now I'm trying to be
kind, which to my desperation seems to be treated neutrally/not seen,
and it's just too much for me.

You know how with Andrew, whenever he says something on the mailing
lists that you disagree with, you never make a sarcastic comment
about it? I want that too, and not because I dare to compare myself
with Andrew technically, but because the way in which you treat a
human should not be based solely on your respect for their technical
prowess, and you shouldn't get away with reactions that stink because
you're good technically.

