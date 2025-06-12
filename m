Return-Path: <netdev+bounces-197215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D0AD7CE1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 23:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0111894E7F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 21:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727FA2D6615;
	Thu, 12 Jun 2025 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="f36H/lKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536671531E3
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762173; cv=none; b=CzQSl6YIx6MWocdBh2KhsnHDIUfk4Xa5gkwQxDZIqT+suJs91G9KFi+XXjtNWlcrpDwQgiAqsXx9/b6lvORtHn/BfKKAZGO7QGvmSBZYigeib8feTB+DgkN12xOD8IsTegXlEy0TY/kOjLD8gL1xlLy4bv188dE2IxJ+Te8Ukko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762173; c=relaxed/simple;
	bh=ODfA+wEnIn/6CsotDiuHYeyYmCIR3+RcqtaoOkfFKGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHCyXBWRpLGh7OfaIP3wOCHvTXR7lNuhTC05/1PElD8zj1eGuyjQWDeOMa5xU767QoN1sA/8FDkIP26yFAZ/e1/x24vG8pUPScsL0wY6Ht7PoVzLzfdYbsbdm6pUXibjWdkE+4y75vBMbQRE83N3bgicx4s7G4uMmPHbSqIQLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=f36H/lKw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4508287895dso16555895e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749762169; x=1750366969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Au+17Wuofs+waKpZUoed4qga7D/BvSDy+Dsn9OKF5XI=;
        b=f36H/lKw2uoFxJQPRuU7ShEvDogc5XbJXY4Tsbd5LvIldcdrqRGHY5GPOayeUcBm0B
         r1shp1TJUeTUPf2C+Op+yqcYxG5FaovRp6qEMVEXu5QCT9DaEgwHsKgq4JdYVDQ+ySDN
         hdpsqr2P+z9HNccnkb1CUjL1kp8uvmOKxYoXzXfD8CgzzvBOxXCp7eylAuJmc9DMrwUM
         YW2Dt21LidyBnif3EkCkdmKfve01tskVGFdzRThwe4EasjrW9ceUuSmF6IZacZk+vdMm
         ssLxv0QgRpQ/bBa40tHA+pKO7yxFbqv26QU3pOhI4Tx9IwMFg5F+FfuUns8TrXQDEPYt
         rWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749762169; x=1750366969;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Au+17Wuofs+waKpZUoed4qga7D/BvSDy+Dsn9OKF5XI=;
        b=bbNh3vNTRMnMn6q6xB2tTGIoZ3oqOGeZGQN795FdxiO7hJkCy1p+sTvFUdBOcHOSIq
         y1kBX0E+ZFelATLJ0mJCX4LsHKXO9GgcowoVXDJfRW5Lhk+ghiZ3Xom9WgkOpfv90TV5
         8pYCHakVcBRjg1RU0YbT+urg044XTCfDsAQcdvuER2D8CEZnXphY59vEL95qp6FpFKZm
         PPnc88SvoD3RcDtfGkPpt1m950xJiuwYy/i88L5A5g2LYy7nIuSLzzJP/lVN+k6AfFde
         +T3PqJujjsr6bJFKrlTRhO2s9EW5202JqSl73BGHkkev/F6wlVpNOFwUmKHBIhiQqKZg
         eIug==
X-Forwarded-Encrypted: i=1; AJvYcCUnu/uqDGkfEZC2aj0X/DhWw6IxA319DDpH38EJP4vFJ2dyEhlyVnTvYVkMnkc9wn4IlCPkdQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWETDdDzAOkoZHXCsDIFn4lp9mlAscaFDFQDNVbwBeWyDz+XD
	aV7xI60eBYEbxb8nfDxpPpNgWlblxtupW9TF/BwoPPT0qkERPntjSW8kW9DsoYGRJnw=
X-Gm-Gg: ASbGncuCCiKxqIIHFtKRk5aFXOAJqzCGphZ/dzQaGOdIncXDvYiWI4VZBMVXpp5SnkB
	JfFO5geb4smy7yRmILGWidhRSaJH8bOoIUdVWF7jbdznyoKz4q37Rndt/SKo3A81a0N83OSk7/X
	WmgT8ZO7uhAkol64qkAZ7ejL1rjLuIeWDcGr0WjuA+a1BHHr6F63HGxh/C9ZxrSziqTyCyL5uwS
	DjAC4fXxleVDKvoWQkYq3jD3iKfD9K9C/CJruO/K87LiGl/7bxmw6ztl5vsI8PjwtCvMoX0ni5N
	MF4/pVjMSUm9QpS7Q5VptCZQOdeTH3CtNmsal99Rf6m+n99LHb+Te9pDbGS9LmdOYp4=
X-Google-Smtp-Source: AGHT+IGzgXOf0XLf2QCRod2mtrusK3PV/qAeGAkTLvwq+cCCkfaUrVXPiGrX3qMZS2/ki2ezA3Nj/g==
X-Received: by 2002:a05:6000:2408:b0:3a5:2915:ed68 with SMTP id ffacd0b85a97d-3a56a2ee72dmr13517f8f.28.1749762169621;
        Thu, 12 Jun 2025 14:02:49 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b2b113sm350440f8f.75.2025.06.12.14.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:02:49 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:02:46 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ecree.xilinx@gmail.com, andrew@lunn.ch
Subject: Re: [PATCH net-next 1/9] net: ethtool: copy the rxfh flow handling
Message-ID: <aEtAds9sHyRsjpgP@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, ecree.xilinx@gmail.com,
	andrew@lunn.ch
References: <20250611145949.2674086-1-kuba@kernel.org>
 <20250611145949.2674086-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611145949.2674086-2-kuba@kernel.org>

On Wed, Jun 11, 2025 at 07:59:41AM -0700, Jakub Kicinski wrote:
> RX Flow Hash configuration uses the same argument structure
> as flow filters. This is probably why ethtool IOCTL handles
> them together. The more checks we add the more convoluted
> this code is getting (as some of the checks apply only
> to flow filters and others only to the hashing).
> 
> Copy the code to separate the handling. This is an exact
> copy, the next change will remove unnecessary handling.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: ecree.xilinx@gmail.com
> ---
>  net/ethtool/ioctl.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 1 deletion(-)
>

Reviewed-by: Joe Damato <joe@dama.to>

