Return-Path: <netdev+bounces-213072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6765FB231BF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841C36233B7
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED092FA0CD;
	Tue, 12 Aug 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="nNLh4Lmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464332EF662
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021993; cv=none; b=MpQO4VLbCi8qrQHqLf6Sa6QNmdr3B1Uuz0hd44FkBh1R3hHZz4j+rb5jLkiUmabY3qSQY+Xecxilg143acVgKPh+l/jfeJECi1TI0v4SKIU8A3U+zwFdmRt527RFvacRQ0elEYOftLZqjA6J2QFt5qFOvrbaSJroW5Mi3kVmLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021993; c=relaxed/simple;
	bh=cDL75IpEVawW/Zf30zLrgXp4ChzUKPLdjONNxz6UI7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThGPmoeBknxFgMNl/Dr9c26ibiLDwIi8P2wYcYQbi8GOykY6ftCU7HGRiyD3oOVztngPAVjV+Hrdfz3JLIxOQt9wwGEP0ONZoQPS/6r07ljJOv+DZ2IvZ9jQPqmwvICOEJ6rMybjSAdgmVUzOmRNanVGing7WEJqtehE+v5/wsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=nNLh4Lmn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3215b37c75eso4928319a91.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755021991; x=1755626791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+qm0OVUwsPChSiO7EtY0l6gyVmRnTTf6kZu001Qmxk=;
        b=nNLh4LmnVCbhhnOAiEppvjNdhqK9UwwDMtMyu9NJYDDJvvzp7jaITDRGGKeYF4fXKr
         xkX0KuvLEo/XLwYEKWWdcW7atS1RaUj8YDYCYaGgOj7yRjRNyRETWgVlpVxjBnVUsNzb
         qiOQ7A59UGYkGFcbhPnSFVMS+H+4uZOivNdAPsYsXRlhuniq9YWNKpYwDZLkdox1dCGd
         5we7TLdbEWaL3ztoyfuaSffXxIKoMCFlxQdIepRnqrWvFXoc78v1ON89kxVaftDUoWHs
         0vF2Ue2N/Himv3N9G9CXFgVik4kk7gBn7BCfcDi8QZipD8hgPnUepF+RiSF7U8eJXXB7
         olGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021991; x=1755626791;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+qm0OVUwsPChSiO7EtY0l6gyVmRnTTf6kZu001Qmxk=;
        b=KOb2G3YR+A7WuZk9dZP5jow1+jVqf3dHqu4Gz0vDIZ4OCpboV4I2wW8Feain35pysc
         6Qc6lNNIexBBBlDLWzIH7F2ZR11k6mhn2U7GMS1b6Q9+Uma86bgwAYHhTJ3Cpza1bORm
         4ppQOcpEJ33geOFn5V5eYsh/snQGe/P8cCg578V3rd6YlFjL5UWYQSlir6JToSClZVwc
         lhbPOBHN37iSeicTbFSupVAJ/N90qolSqj0yvXSG8rxAFiDoUI0Tf8ZS+pkLAwUWt7ID
         c0iX4d0yB+UairxPT8q36hOf6DtTjgn0jksaWXtJU0XYngLV8aPKVuy28zTBJjAzYyue
         zpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXij2YAX5jI17BEJh9gSycEVnm9AF8yffMfHtAOwMEXliDjqeYiNXjWUtR12Uk3PLfsB8/bAdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKIdRrfioZCGFSkF5BxlaOc/HGPxgu8g6LcS31lJaU/8SO078g
	bbKJIMq/v8GoF8rnoa25gpHY0+lQCiPmWSpxY+Xl1mlZkPAUivSf5EFR+WbmdUmUsC0=
X-Gm-Gg: ASbGncsL3yA9jsWQPyv3Wi0oeLdL32y4wYmSpxirnu52DIoIXcdW4wdBmGV6dpxA6z/
	cVjdppjPx7QgTGQ2X2mtTdMKMuv5KmYcLjWU1CxnaQpiHwz+cDVbdLi6MsCAAho9Q0ipVEBOi3s
	iRX2IW+1PbvnkkUsdDRuXQHGxulZMskc0ZvV6qWREJZxL3IP4QKeT3CUKAoXs799QS8mlmjG3XF
	1ftwGtH4zB4jEDPvFJ4PHCR9VliYxK4IjTUlyRh9kTBBBTw/KbXKZO6YZ0xpJ791DgIoee/S8L+
	vW9yATt4a2Awlb/vWNUnXT7E8pWxIExEZBDk4s2uGnBhRK4EMBjd8dz6f/YjmYpLjxv52VRaQ4H
	/jrWANyAY8DvuTOHcSUCuo+39qPGkuc+tfwBDHt7jPFG+R2rw40eO8XSFEBVcnIhR7XWA8l0v
X-Google-Smtp-Source: AGHT+IEiZ+6cRgnpz7p2OFbfNkvWieaTaOrL4lJbiLs9XtxBwQXEItOrPqX9mADnKtClseZZXtmNYg==
X-Received: by 2002:a17:90b:3c49:b0:320:fda8:fabe with SMTP id 98e67ed59e1d1-321cf9682a3mr744231a91.22.1755021991451;
        Tue, 12 Aug 2025 11:06:31 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32160ae5eb5sm17892521a91.0.2025.08.12.11.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:06:31 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:06:28 -0700
From: Joe Damato <joe@dama.to>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sfc: replace min/max nesting with clamp()
Message-ID: <aJuCpLbCbYJg_MPF@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Xichao Zhao <zhao.xichao@vivo.com>, ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20250812065026.620115-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812065026.620115-1-zhao.xichao@vivo.com>

On Tue, Aug 12, 2025 at 02:50:26PM +0800, Xichao Zhao wrote:
> The clamp() macro explicitly expresses the intent of constraining
> a value within bounds.Therefore, replacing min(max(a, b), c) with
> clamp(val, lo, hi) can improve code readability.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/net/ethernet/sfc/efx_channels.c       | 4 ++--
>  drivers/net/ethernet/sfc/falcon/efx.c         | 5 ++---
>  drivers/net/ethernet/sfc/siena/efx_channels.c | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>

