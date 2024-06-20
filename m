Return-Path: <netdev+bounces-105258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B7B910446
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC23283E20
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39001AD481;
	Thu, 20 Jun 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3+pY5FR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078AD8175E;
	Thu, 20 Jun 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886729; cv=none; b=KDRuZXPPlpPW7S4qTXcIGP7AOWKF11Itazbfsq5VIBINDAdTuXUVJEtpd++/VlD/yNyqBJ8tfNgdopLzx0f6hDJEY5PMNr1N2ZoPySnWWcUe7+NJC62BtnRNIf9vx0nnMOsYdqSNmKPZxBfsIiRr50F/OE6JQcMQgMUSaUFV1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886729; c=relaxed/simple;
	bh=nKaXpPpSof8n4UB3UcwIjy4Jm8TuBE2JLXnXoTHOECQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9ACqm6IeJCPBMxmga9lmSrffxE2x5wycjOdbBf6ShrL14eCn1HJsDJCWPS1kwO0RLK9o9yjGf3F4EUo2TGW9PH5jGNY8vjFYtrpDCDf7LEUyZ/75uosW5gbGdBKNWznr+ft782kmKKttWXv5qA9Ml2ZqO4mWUpeDnZfcoJA9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3+pY5FR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d07673185so724421a12.1;
        Thu, 20 Jun 2024 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718886726; x=1719491526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cv9eGCvUmyf1AIeDWQRmRRnMZ9YQ2SloM3Dv5t7XOk=;
        b=m3+pY5FRX9skjX/gxgRQLX6TRwxblIia+anESG9r46Q9h1P23wqprTvagWqPL7TNdS
         f2rQ7NALjvhTLJuX+r1Nb13qjd6jAlZRJ/sWek4v5E0UVYwyMVMXjoBWmBBC+WOUtxCK
         Y95cnDHlrkKgSGhiyAIxEw2kXTygG3kbp9nE8HHu5Mf+47VH/tJBGqu6KjV49RWyiBip
         H3fDrMvOG5b6r3G/KDcwFyM4n1AgRSC88KuJ9TjNaZJKua9k0fiMN3JJsY6j0en15pQ1
         zxDq6FfNOIxXF80oVllMNyuayRIJQ/x/b1qLP0CX0kQ/fGAIH39KKQoV4Y6RKd4/W2B5
         3tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886726; x=1719491526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cv9eGCvUmyf1AIeDWQRmRRnMZ9YQ2SloM3Dv5t7XOk=;
        b=BlXwn8Zf9lXD3JD0EHlTv8qYBYvuiZRB9IpIAK0zmSXfhtvoBTV+aDGV//zlcVA55l
         zLOVMPWmcVWfmiLTjCgyi38rQu15ATTnRVDnWa+DlMW2w5MDp8lVhadAqMaUQFSyu/pj
         ZZoQAP4fhRdg6hZ/paxEACOlEXvo38oRhiGIOZ9s+KHy8iF/Gjltj8i6NAaxY2MThaaZ
         8abkChH9gnlDEBZaJJP24S3Kjq5J7mdd05RL4LwlJyNxD7jRbJu0yFLDvnJeAC7Rf4U/
         Vccvx/DOSNX2wqZCIgFX0YQTj0V9u7/SHKS6krwueEqcbrN/LQ6UXXuY/1JTRqMV4WRQ
         Rq0g==
X-Forwarded-Encrypted: i=1; AJvYcCUB5SQnMD8Zo1qffo8zXy82KVYNcmxCylgLlvWGl8APNJlf7xZsh/jSJkfrqNxJF71o/ZairbO4tY6OJvWLN+6mBWVmkKSFQHgCnDvd
X-Gm-Message-State: AOJu0YyLEinheyI8G6TKz61VsprUPKhSudmeuL4Mv2EIRqkxxqkDX6ht
	Zz1PcRaegJQq/SMGcrylpiaWyYEwimfoH0tW+eY8UiO8d0tah7vU
X-Google-Smtp-Source: AGHT+IGOis2MTWAcNxzECbjNi1bwQ7BFdytUq5/xg5cCjRjc9EZNqKgrFl3s1BK+59GcmJ+JlcfS0g==
X-Received: by 2002:a50:9b5d:0:b0:57d:353:ae21 with SMTP id 4fb4d7f45d1cf-57d07eabec3mr3535513a12.30.1718886725847;
        Thu, 20 Jun 2024 05:32:05 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d17d9471fsm1340167a12.52.2024.06.20.05.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:32:05 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:32:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/12] net: dsa: prepare
 'dsa_tag_8021q_bridge_join' for standalone use
Message-ID: <20240620123202.ygpoflgzqq5mipvz@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-11-paweldembicki@gmail.com>
 <20240619205220.965844-11-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-11-paweldembicki@gmail.com>
 <20240619205220.965844-11-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:16PM +0200, Pawel Dembicki wrote:
> The 'dsa_tag_8021q_bridge_join' could be used as a generic implementation
> of the 'ds->ops->port_bridge_join()' function. However, it is necessary
> to synchronize their arguments.
> 
> This patch also moves the 'tx_fwd_offload' flag configuration line into
> 'dsa_tag_8021q_bridge_join' body. Currently, every (sja1105) driver sets
> it, and the future vsc73xx implementation will also need it for
> simplification.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

