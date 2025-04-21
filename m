Return-Path: <netdev+bounces-184335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD026A94BE1
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 06:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A496B188A579
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 04:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33732255E4D;
	Mon, 21 Apr 2025 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH6k3kEU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6DD531;
	Mon, 21 Apr 2025 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745209454; cv=none; b=ODAcx/Dk8GGdUkQtQvl8FuDFiogIaz19OoHGD/zHuGNuhPdI3LSG+RpNYED6z8SD+LnF7okzhKrHn+YZ9xpKO6p1iN+xwSmtLjuchgWvlRh2z84PQTXCiTAFcvPmrdQdeea+cNFdwgZOJX4M7mvsPXXbwi7+mVdEKy6b/eilri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745209454; c=relaxed/simple;
	bh=8XpL7LgHM8PMPLRHG+npcwHCbX1D8crLdJyc1SzrAtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlzUeaUzG/lzs/Ih1/9R2IT9RMZcWHeLOBNa/eUzqb3gsjE7gFJ2r8YV79wRnUANFIonWo0k4MOGq+GWGssR9RjyqmoJM16tjezRoDiiHRYq2f53WilkRCzIVumkFS8YRtzPpVxHnNh4go0HIjtU5+7LvmBxeeaRmL+RKYCRrl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH6k3kEU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224100e9a5cso41777675ad.2;
        Sun, 20 Apr 2025 21:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745209452; x=1745814252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gD1lBT2qzhBlSXZmFrSntZGpuEODCjw4D1I4gGa8lhg=;
        b=VH6k3kEUPv5/G3ANSIfGWrfan8yQT1BK+ZvE5sZHF8GW5yqRWIq2wZ7K6QfjIj8mx2
         /vl5mfbbtetRupsU32yB7iQTWVnijGzTfBjFvyste1spj5Zewg6XgcDSLj791ORvqkDn
         7L7aNISkJDHadwtq+tRP9TzOPCXymlmbX9cEqe7m3Q3lir+e7LDpMIeWYL9KNFqvqh/t
         p8/fZinUk8r3cRR82v+ub5M6qGuE4PhFjb3hdHiJOzqzq0Ideq4CoQwqzw3V75ZQRiQE
         qsdfpMGDwx3a2T9s8rLw/DbB0+SW5IzEL3IcI6eVNpQwF9fxIJ0s/JzAuh582sw4RTVX
         /U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745209452; x=1745814252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD1lBT2qzhBlSXZmFrSntZGpuEODCjw4D1I4gGa8lhg=;
        b=PAnTjIhVYFTp0WP+xkvp1ZpWpl4kYCSZpZA96uIb3F9Xqr5zERXznMnXVf54HpudLE
         YCsIxdYuLuShE5uK9Hg2xlynPZzQ+yb/BDfh7rsRJzEAXJ74hYBNja13vR3HE/gy3EF1
         /8Eabu3pcB9uogk9+suvsZPZMdc4/o6dXdLXGARuRLbPIs2oISL3gns2hUBKDTUOB7nX
         4kmEucq5rNO0DfxJUS2bwpgyPUTkOzTfsQnGA0Kn68sLVOLAcbJlq1aha8vvuyiO1cd5
         EVriyWGVzTgJJKHh/wKJy5U3mXdFxj8N5C+QIM+46lgnxm8xq9rLxsGNsrMZlb2Qaqgg
         zHyg==
X-Forwarded-Encrypted: i=1; AJvYcCWiBXO0Jj9ARygKwTZjQQNNiWYH6xgKljeA2X5C2UnKZk5M5g5XUphaS31uW/bFuQbTqls6efOUjMLLYk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT36d4z/bRU9Z3JX8BRS5ODznC8vyyfIvUV+n+7GklAyRI56ms
	34i4mT8nusIfDxLK70kIBDbrZDiZJZdmV6aeWwLAm8TeAO3Ohw+Py6pRF6BgEeM=
X-Gm-Gg: ASbGncsVECru51E8rHSRB0I/E7jJ1sfWSD36NmPuzyUMlnJk+7slcSg/TDi8Xtqpdjo
	IHQAb8k7jLuAaoTFQcutVyDzIBr8Fw0tkF3K67tjQ0GCYqyioD4k4H1T7vourYGe9vKCrWFu9WR
	hAKBfDxx9ca2ZxMQaae1B8ba02BiHkDvprFGRLSZhZ7xajn0eQiPAymV73ui7kMcFBEstd5TtX7
	cmfF9HuGhEQugHlfS3YoZiUzIosbSmv54f/iGmgGuvkGs0omCBbfLILKEafk8POElY2ZKauWyF+
	olxAbFVUZqnHGX49HoxYvC8vYREsptHELO/4btlOhuZ5CQ==
X-Google-Smtp-Source: AGHT+IHW5VHwndq5VFkPfBwdaapMexDkhjRLo/7mVQyTVfKh4gxoemeFfnR2QhdJLx4vfv6y2rFJuw==
X-Received: by 2002:a17:902:ebc3:b0:220:e63c:5aff with SMTP id d9443c01a7336-22c5361b3e7mr145469015ad.47.1745209451866;
        Sun, 20 Apr 2025 21:24:11 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ecee92sm55994535ad.187.2025.04.20.21.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 21:24:11 -0700 (PDT)
Date: Mon, 21 Apr 2025 04:24:04 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <aAXIZAkg4W71HQ6c@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine>
 <Z_OcP36h_XOhAfjv@fedora>
 <Z_yl7tQne6YTcU6S@fedora>
 <4177946.1744766112@famine>
 <Z_8bfpQb_3fqYEcn@fedora>
 <155385.1744949793@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155385.1744949793@famine>

Hi Jay,

On Thu, Apr 17, 2025 at 09:16:33PM -0700, Jay Vosburgh wrote:
> 	Wouldn't it be equally effective to, when the conflicting
> interface is added, give it a random MAC to avoid the conflict?  That
> random MAC shouldn't end up as the bond's MAC, so it would exist only as
> a placeholder of sorts.
> 
> 	I'm unsure if there are many (any?) devices in common use today
> that actually have issues with multiple ports using the same MAC, so I
> don't think we need an overly complicated solution.

I'm not familiar with infiniband devices. Can we use eth_random_addr()
to set random addr for infiniband devices? And what about other device
type? Just return error directly?

Thanks
Hangbin

