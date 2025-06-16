Return-Path: <netdev+bounces-198138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64CADB5DB
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1908188E70E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C65127AC30;
	Mon, 16 Jun 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="FkEL7YfA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB42690D9
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089006; cv=none; b=XOigkGl2VKxwU3JOzaPOj+ispxdiZBVnv3acrZCpAnBg1VT3QKhqLhf1vLwPjIWlf/rwzKno57+l4g+QZ0RLpebTsLHkPDy2/s8PXzu3uybJ9D/OAGIhCE+oqGDbjBaJYNfAQn+9LkA3rV+PeS/xxPVIfwOGVUBSQBj4ffO+nm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089006; c=relaxed/simple;
	bh=qob5NJ8G5c6QzGmBfprP/lA7j97XJ9zNuEiloSsBDvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvyKdEdMvvcEn3HzofvA77obah3i08jXcUSRi4YQfxe52OjyOPSQlb23ZuDJE7C7MovroPseC4lgpUcIKeRlkIn7HqqF63HWCTK6NWhfovbIZYZJcMpi3igFq+dpK9510QXBqI9WgmnxeVfEXX71KokopebHR+j1cTnnNio8ai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=FkEL7YfA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450dd065828so37860665e9.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750089003; x=1750693803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HG07yhDdt92251lTiG8gm/91c+HEf0mdiuFjonzF6Y=;
        b=FkEL7YfAb9m+0CijchWGHD1+f93zOBfmNtpruELi6g5lE5Qq8SORF/+GLUYR0tVhdB
         tWjE4IawaQjOrCJmwxVJIRrF0Nf7vyZrUmpOTmX0kPto28y/kbOuRwt74AR7JKXqJgbV
         H4mclPjAJDXReqqoktoVDlNaKKVZjkhr5+Wjyo/GhfS6XBYndMWkKz8JU/A3QiO6t1PM
         /yl9wOEQTfCEwOTFnLPIpKGGIc6w8Jn8c6DEttCmiBTD+i2nxz0ETILGQJDFFMYHbX0b
         +Yz17pjKFsCacEzttZNzIw460mekcWbXGej2kp4LeTkXW3fGufdfjevEYaBU8RGW06ke
         FM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750089003; x=1750693803;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HG07yhDdt92251lTiG8gm/91c+HEf0mdiuFjonzF6Y=;
        b=U6PkzOOy/CXTPuNKHLNkavOioQQXN+0URHLHf6Dmo/nzI915/sq6uccRYJegqX3dwp
         lCXrb869ZZU1j2YnSKWxoh8dRgDhA++rmR7d8w3fPYR7gU+Bl9YAkFCOwDTZTd161xCf
         TIPX5wDIosJ/rykDXgasZMmR+25N5pmUgJGRKTvgCwtocT+KeQ7aJhbPPxcAit9aAgfQ
         3/EbYJEpdhuF/JFNdQvjRo4iIz/RhGY9hiQVhVO5Q/zkae1nHYcINKSqT0eM5Ke/uq+h
         nt2ekJQuuR93YBDy68ZBBPzEplN4GjZQFpa9rh23PTHr8WzGrM1ghMcv404hXsU29Ufb
         OYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgnZo7tRNNhxVtD9+hDCiQ6/BK3ftB8WAiavn5pstpPYmUxYdUzzys3l7pxjNuOHacvb1bSu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIuJtg3SPkUeb9deXMpLVQ5yQwk9B30mHTaiAzIps7SyJzqnRH
	bRqFM7ih0w5ritVg9p9rmihEkTnZXJOXjLQh9uczN/ZL4r5Xsc7eRExixhb5Kr3OtDA=
X-Gm-Gg: ASbGncvhzoW70yZ1nzKaXyjidP50jcM45AlmomTZGkKyHyqtvatHS9pxWyWY8zVdEgL
	Yn/dfP6DSsZzkyn0mQHKtl6BVicgStAUfB0R72Hatjvvu1IbTyaLanzq/Q5Bm/A5Ucjhj62dlNc
	c8wM9EPNtahjM3knNsSFc5sHpoJHzrVFptmW0I7t1fezQoh8A65As2x8kDLyDtxzq6d0kOXRxM7
	Vp/HnDdqEbuesTFZFvOFUau0X6BuWBdEKAkd8Ki0cIijyg5m6kQYJdHzq4hEiDDVj7/iHsSeKDQ
	NbzcjsvfwUfW10AMHmu6Ql0PtIZt7ch7LzqeqMchjwkvQPF/RC2RmsD8EBIr+K24rUk=
X-Google-Smtp-Source: AGHT+IH0ZJ7gpp+bLXTmZH0utmqDobsB3MfjlLY8LYiad1AFTLXWZpdDhWNjYJrUzP1yR5mvXiTn3w==
X-Received: by 2002:a05:600c:1f94:b0:450:d019:263 with SMTP id 5b1f17b1804b1-4533cad3c9cmr103710705e9.18.1750089002809;
        Mon, 16 Jun 2025 08:50:02 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b70d77sm11543216f8f.94.2025.06.16.08.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:50:02 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:49:59 +0300
From: Joe Damato <joe@dama.to>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: pabeni@redhat.com, kuba@kernel.org, jeroendb@google.com,
	hramamurthy@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, netdev@vger.kernel.org, almasrymina@google.com,
	bcf@google.com, linux-kernel@vger.kernel.org, ziweixiao@google.com,
	joshwash@google.com, willemb@google.com, pkaligineedi@google.com
Subject: Re: [PATCH 1/2] gve: Fix various typos and improve code comments
Message-ID: <aFA9J6-6Kj3LcQL8@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Alok Tiwari <alok.a.tiwari@oracle.com>, pabeni@redhat.com,
	kuba@kernel.org, jeroendb@google.com, hramamurthy@google.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	netdev@vger.kernel.org, almasrymina@google.com, bcf@google.com,
	linux-kernel@vger.kernel.org, ziweixiao@google.com,
	joshwash@google.com, willemb@google.com, pkaligineedi@google.com
References: <20250616054504.1644770-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616054504.1644770-1-alok.a.tiwari@oracle.com>

On Sun, Jun 15, 2025 at 10:45:00PM -0700, Alok Tiwari wrote:
> - Correct spelling and improves the clarity of comments
>    "confiugration" -> "configuration"
>    "spilt" -> "split"
>    "It if is 0" -> "If it is 0"
>    "DQ" -> "DQO" (correct abbreviation)
> - Clarify BIT(0) flag usage in gve_get_priv_flags()
> - Replaced hardcoded array size with GVE_NUM_PTYPES
>   for clarity and maintainability.

Subject line should target the tree ("net-next") and it's helpful to include
the base-commit (git format-patch --base=auto). Since this series is two
patches you should probably include a short cover letter.

That said, the changes seem reasonable so when you resubmit you can add my:

Reviewed-by: Joe Damato <joe@dama.to>

