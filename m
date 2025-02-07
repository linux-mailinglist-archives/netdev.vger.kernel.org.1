Return-Path: <netdev+bounces-164158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17094A2CC90
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A643AADBE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240131A3145;
	Fri,  7 Feb 2025 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cPEgdg0a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF319D072
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956460; cv=none; b=sz6JBWjiUX7zWVXQPs9Jww8NUoRN4mBeUiRQ0tY+AqtfHml/kf63udpmy45jDD9/Jd4G+RfWAaevvQhjUfTLwUl9lVwRPVRmPzD0kMEHDPCwYFDmEyWooSzJpJNr5SnK0S3OIOX+ZZOCdAt5iXQL40HOIZjAlu1vHSOkQeMcxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956460; c=relaxed/simple;
	bh=uaLgx2F8vFMpjWzVEVskiaSW/W6Fq/0kEb812AEkh10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3iBBNAkA3Isn8UHCmCREKaP68Yy7EKI4NQMKHxs6Vn7UOKxlZx2AYNJKtL8ljlpcaNoJo33V8JBqLmn48dpCjSiNJNMI0BhjaGfeU1e2RnImJAfD1G7uOrkFZW1nY7uttmOUrhsfHLmGA5Wpjv0WxVbdsVfVl2e2HyGHwNHZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cPEgdg0a; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f4a4fbb35so26898905ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 11:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738956458; x=1739561258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AGqpSphEUXaOVV96AwpA/N7z6AmrhfmgOb2ebxvnt4=;
        b=cPEgdg0aJkYvb6E3VZv/Mr1X/+I9AMswK9qxf53m4USeI/+xq1+hBfLoiRjXe+Mqu8
         KaWZJU1aLF8FjiafhYd1YzSx6n8aGrHVQ6CryViBYhA42tp3ZEZyqCX4/XxBCmOxGMHC
         WXtP4X5WAdx/Y7e5PV4MZ0rQesafrU/RQa1PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738956458; x=1739561258;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AGqpSphEUXaOVV96AwpA/N7z6AmrhfmgOb2ebxvnt4=;
        b=so9Kx0M9Pmw2Bo760hoeOMieapjrAOAMep1SF7ESWFEXzhh3jWz7U32OEhmPfEsw6A
         NTzMlvpRCdwX8sdti8s5w7Bq3WsJORwWtvYMkzGgSuHCrGI7eihOFX2zcANHtMXoDph+
         k6LUvt8WW5eryI0Fte30T6tdoqJUUcGjpaTQuC0NsytGDEjHaTxigmg11XyHQh+vRMuz
         /Ii0z8skzVEgHd7aXMiGxI92qTi0rvvVCG5fji12MzrDMiE3NZa0PlUD1IfqGMs7XMIB
         tcRc0EuxGSqyEO3JI5KWwzsC+lX1RK7GX9rbSy3HtowZk5dC4k1cykkSRn/KfkTo/aE4
         ImDw==
X-Forwarded-Encrypted: i=1; AJvYcCUazB0ZyCQ32N7jjgOeuGxSlO7azaDlz786zfq5N6VZ9DT6Tdzp/yrA4m1owO6Ij6xDD/1YBwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZJNP/oj2b/HrD+MUzBbsSZYyba1L4NhvnuQ6CUVCTZw/UspL
	kANyNioQL8n3sz6ot+1Kj+h6akzI0KzmqkzQJumeiaD4z6QpNW1WCGoWevH1pA0=
X-Gm-Gg: ASbGnct3xIE65x/VNnb2hnWWovE3+KRWpV62ko5684E/pf4kQCv5XhWATU25jGY7Pf3
	O25788oc9czrRGTOEgmKJU7dEEkokA5FHY5gmE/iGWJ/pQg1dsYLNkJiUW/2NE1yyZ/4y9hQkwN
	DszH2N3lVsr4pcWjKJbc7aHmRD5WAuwxwmqOfBj4pOksEJqJzbFuHnJ6XjiOdeajOiGNfoXOd/N
	26NO4lc9apsQeMMaFkGK6aR+BgbF03whHea7b9+fr0vcgmJmJNNmj6XOAFFkhpKT7WBjfkqDNV2
	i3kHrEgxtqee7JDhq9VFyAoQHHulZZvZQpsM6+3Vz4ahulOZuMdhUHXo8A==
X-Google-Smtp-Source: AGHT+IEqGSwbbfe7x+02GvK9S0+QjbvhZz1kpYfgI3/1bz4pe1TM2GiDO54hpqIv8kjFyjZb9Jxxxw==
X-Received: by 2002:a17:902:cf04:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-21f4f0ef803mr66053595ad.1.1738956457693;
        Fri, 07 Feb 2025 11:27:37 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650eca2sm34253775ad.19.2025.02.07.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:27:37 -0800 (PST)
Date: Fri, 7 Feb 2025 11:27:34 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ecree.xilinx@gmail.com, gal@nvidia.com
Subject: Re: [PATCH net-next 1/7] net: ethtool: prevent flow steering to RSS
 contexts which don't exist
Message-ID: <Z6ZephEIxtHfG4bi@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, ecree.xilinx@gmail.com,
	gal@nvidia.com
References: <20250206235334.1425329-1-kuba@kernel.org>
 <20250206235334.1425329-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206235334.1425329-2-kuba@kernel.org>

On Thu, Feb 06, 2025 at 03:53:28PM -0800, Jakub Kicinski wrote:
> Since commit 42dc431f5d0e ("ethtool: rss: prevent rss ctx deletion
> when in use") we prevent removal of RSS contexts pointed to by
> existing flow rules. Core should also prevent creation of rules
> which point to RSS context which don't exist in the first place.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: ecree.xilinx@gmail.com
> CC: gal@nvidia.com
> ---
>  net/ethtool/ioctl.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

