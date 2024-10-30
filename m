Return-Path: <netdev+bounces-140332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC49B6043
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DE11F21285
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91B81E260C;
	Wed, 30 Oct 2024 10:35:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C729CE7;
	Wed, 30 Oct 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284511; cv=none; b=tqUPg8+MxHQZxzleBAB8q60odE5+x7KwkoGnCCv6R9vb7RT/fY3CZpym3D57ETncddKcVn74Mh0xROTdYJUFDqOZnInwnDutrYt8vAXsbXwQ9z/wknim8yZ53+uZTQHXlG7u8wFd36wYcD+6SpXz7eU37dck4UZXDZpartmkvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284511; c=relaxed/simple;
	bh=Dh/ygCMs9EkmyJgZCXuDVA/pwti7uq3qYxM6qQs6dmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2zXFe5zS/gim6M6/54TqZ6ZQyLn9ASiDT4fwCmlAERqISYkD9SlMYoYH2ANtt7kfvCP5vd2ANPFdKSYUDNW2naMm4HGWLi0jPBU43XjlWk/ml6qRfHqHr4Jbi79IGT9gCA6I9xxkXbcVOyy7xo7Ql98BM5tZmNc9sNc/FvWsu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so8598662a12.0;
        Wed, 30 Oct 2024 03:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730284508; x=1730889308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GifnlPtN7NiyeZMSkjEx+dbPyN49ofS66QMTyEeTgtw=;
        b=DvAljSiS9Z5O3Bv6yi++MA9IrkVyDIM3sEJpZV9xorATLgzja2I9LDS2kB12Vg4G5X
         Pq31lbP8KxBfQJedgMfh0OeTG6nmNKqDk6ifvp0qQb3g1VYb8QZQllHrymCiZJuO8D4A
         Nazyca3qnWAx+A1RTtaWzjddfq0UugAeLOnLSmJXwUjnhe1OQ4tf8dA2b+1lH5nx+rkQ
         aVQXhHrBRTUYVahJa7kv+hToNFwrBG0A+cnlq1Zitcs4THn2P15qiucMJB/STrXfkVY4
         L2ssDfGGy0GOqAM5G0JkNFEJl+bvunRJ7Y7AAlRh7XS65XIWLlXOYNNNV28rUqixqEn+
         rkjA==
X-Forwarded-Encrypted: i=1; AJvYcCV6nC3/6m1bo+HOeVvU8nui3tWD3hrgQOIa/bdHqb7s3NRdgpBdLHBEwKe00u7X3Ns0Iave0Dom8VG1UNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJ+UDpdEJlJoRwK95x3QkTwqoGeL8yoeUTMmDo5oeFGbfxMpn
	3L1rsuOLWsJkMdZT1FhND+9m5FBk67YxMOmQqt4JHJTyCOulEzU6
X-Google-Smtp-Source: AGHT+IF71lZKKH1Wi7ha9ca6zPk452ASkUG+FwwI2pKLbi61y6FlJ0tkir1WgK+psYexHGdJGCQKxg==
X-Received: by 2002:a05:6402:4403:b0:5c9:584d:17e2 with SMTP id 4fb4d7f45d1cf-5cd54a7718fmr1809727a12.3.1730284507741;
        Wed, 30 Oct 2024 03:35:07 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629f338sm4590147a12.35.2024.10.30.03.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 03:35:07 -0700 (PDT)
Date: Wed, 30 Oct 2024 03:35:04 -0700
From: Breno Leitao <leitao@debian.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Radu Bulie <radu-andrei.bulie@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Sean Anderson <sean.anderson@linux.dev>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 3/3] net: dpaa_eth: extract hash using __be32
 pointer in rx_default_dqrr()
Message-ID: <20241030-lemon-flamingo-from-uranus-35f6db@leitao>
References: <20241029164317.50182-1-vladimir.oltean@nxp.com>
 <20241029164317.50182-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029164317.50182-4-vladimir.oltean@nxp.com>

On Tue, Oct 29, 2024 at 06:43:17PM +0200, Vladimir Oltean wrote:
> Sparse provides the following output:
> 
> warning: cast to restricted __be32
> 
> This is a harmless warning due to the fact that we dereference the hash
> stored in the FD using an incorrect type annotation. Suppress the
> warning by using the correct __be32 type instead of u32. No functional
> change.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

