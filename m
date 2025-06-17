Return-Path: <netdev+bounces-198779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FFADDC49
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA29040271D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058A2EBBB9;
	Tue, 17 Jun 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="12hng121"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C72EBBB2
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188555; cv=none; b=WN0LT5b/THmOaiy0TRQTpt4VLgGeoKSyBdWchaMYYqMXe7c9tDeRCzgzBr9GgDsJ7r4bFblJwl291J1A+T1pd5Oajd5rs5xwlfO0zsucOxS6RSIIqOwx1fvmc9jFJ0dOXc0itsP9f5ckMcNJT9LcRWUmU2Yx5MJwZqjQd4+6ZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188555; c=relaxed/simple;
	bh=T099ExzMFabuz6csrgZ9ZbHc8H5KGqyR2fBlccB1LvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHCTea2GI5uDho5zy6uXp37UMhrDdGRIQX/xSm0rIwcX5mS7e4j/zZ+UldJ0JxlboSX54fwNhsrybWMcBLhHnBy2YAEAZRlJDVScyVEhzhLoQ7dmgYjq8DyjNofxc9TXDxXuOZbhiUN5sAQN5sr8VOMarOaDXGYm7tCyU2oKZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=12hng121; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450dd065828so50137725e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750188551; x=1750793351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4stNfk3GHCwpaaw2yUA3F6HMELACki633tbD7QSViUE=;
        b=12hng121B5S4NjUjwu63ctzMIlDEDjHidL7tBth6xSEgaMwwUke1YE4YaVZwltx4uX
         fCYzkDg92y9s6u4Hx4ZbtJ/RlFwz3b0Wqv98JBpalPQvw5j87ZKOHmOtxTIjOSgHFhf9
         4XOLvzCp5vffngJ/+IVZrgLlNIdunQg/VWWfHcoVyCsfg8GfBSQwSOI5VNmZ5zClqfbl
         XC03z+S1ACcQ2lpTtxY5a7MMj7k4uvcl6RZbVMtiRzGZv0uivZ0ewVUHkgp+PJ3kh0Ud
         uP1Tee+2tOn7avIyFYuox8bf1r45phbqKjHt2CBwwtgUiDdUVgLs7qXzUZhzy+JG7Rhr
         Al2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188551; x=1750793351;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4stNfk3GHCwpaaw2yUA3F6HMELACki633tbD7QSViUE=;
        b=uSsMOJfeNBOzEztvLmCytyKKJpnjRjmfEPwVwnt8ArD45So3XmezbbD258a6C1EHic
         ZeoMqHcuePmXzKIta9LjKKT6Sgs2ZprQmdOT+Dqy5/tFOYK2f9Dz0+eul+sSjF0Nw7q4
         s/MddRwyKkEa12bv4PzOQEZJVZPTWzjdwF8bf3sYWFSS2SNo7+nsVz4CXnQ1ghB3ykKm
         eKI+A2tIMDcl5AUe0vmsPXDUV9zKf8KWCcA3gSMi9fd9Q+5Jf7K7/QiQyF74yulWDLF3
         gvm9QBFFlFFnJuzEDwGDJwK3poEqw0pvUiy8LuGvYtJPMPAOMlseWaDlLxlR07jL7lEL
         xtzA==
X-Forwarded-Encrypted: i=1; AJvYcCW/spM7WnfXVpL5/EkWuSu68htkikp1sU5Ur4ZaGjHBl6/L09LV8bYFo250N3Mp0LhIg864LNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0mtY5/CsKCqHvGuLz62YP7hllZNHJCSod3kmodEjDTjZovozJ
	ckS1XE0Ean2oG0AwghRjFG+x8RvOKDdTgZzlDdV46Np4RYxEZHKigiBuCf+chMHwlWAeIAciGA+
	E+C446uI=
X-Gm-Gg: ASbGncturHCuyNgLMB+tz+zZpFdNZWIqTyX8jCIm1GUXXHzoYQ5046StQAgE53xrEhV
	sh3f7a1cRz2VD9nOjwkyDjbVN0mbeaCEp4hCVDJjSOc4O14Lu5XSAiIafqL1cr4UrAy6WRnsTg5
	BIeMHZBPTWhGXLTv/lbFl1rDRScPVc/AsPVqfn/BYqGVDDl5TQtr5IncR9+cXkB4Ov/9d2tS5fe
	6yV/46mORN6Zpq1ysy2xoyTlp9dAOgdk7tRm+YQ9iSLXSDMyxXLGm3i3qPdf0RXNFmo+VypuS1w
	DpnBitV04OSGyswel3PA/hb2E6nLYV+RRcaV3FcN9J0hTJKIgoPqQm0ZjriV7ANa9I8=
X-Google-Smtp-Source: AGHT+IHy5pgs6SMY+PDfpvxn508zGNn1Hujoh6qFYXjQd5rXY6Go/uTinMHk0iQoJPisfeVzGGGcHg==
X-Received: by 2002:a05:600d:b:b0:43d:fa5d:9315 with SMTP id 5b1f17b1804b1-45341b044cemr92201375e9.33.1750188551106;
        Tue, 17 Jun 2025 12:29:11 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b74313sm14920824f8f.96.2025.06.17.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:29:10 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:29:07 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	madalin.bucur@nxp.com, ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com, bh74.an@samsung.com
Subject: Re: [PATCH net-next 5/5] eth: sxgbe: migrate to new RXFH callbacks
Message-ID: <aFHCAzpAFkC_dZha@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com, marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com
References: <20250617014848.436741-1-kuba@kernel.org>
 <20250617014848.436741-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617014848.436741-6-kuba@kernel.org>

On Mon, Jun 16, 2025 at 06:48:48PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> RXFH is all this driver supports in RXNFC so old callbacks are
> completely removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../ethernet/samsung/sxgbe/sxgbe_ethtool.c    | 45 +++----------------
>  1 file changed, 7 insertions(+), 38 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>

