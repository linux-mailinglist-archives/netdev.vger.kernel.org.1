Return-Path: <netdev+bounces-198127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CFADB56F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0736188CACB
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC2B23D293;
	Mon, 16 Jun 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="gdz6kZGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB82BEFF7
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087828; cv=none; b=ZE4aleM+zjse7Y/teSKatKCpdXAF+aRW1Zg8YSNqEauN97+2x0kZiLm3IrhxhOoi6Jt1V54RDcSLRj+L3pZPwv+/xtzjmE+pd3JR0a6bqQWJbgFTYGvhkGKJtl9n/VNGFMgQgXO8Fiv5r7L7oSvThQVHrVONIY8Fq5o5VnBFM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087828; c=relaxed/simple;
	bh=pSZXA3ar+pLhIUWk91brBffXf8icVUnzt/wg1B7yfrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsvVbzvNgpzZxE38g1G31lit4WfPw87onFqz9tQtUU6U8YYlyYNJO82mgTwegWvIXjxwsVSGADgDjmsnaMA16OYnxmXehZJlkwF0F5gJBJS0IDtFC0u9r9YaAVIS56ufUMOrz4zYfTJhWjcU935auFZm0FGmihHqRMNfTtB/xx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=gdz6kZGO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so3751249f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750087825; x=1750692625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cvWGfqvAHegxKwTqRT6pqv8NWEdRZnW6ynL47ZacAE=;
        b=gdz6kZGOuDzCoHT4gmsl+iScDD6WERoYkcUaOKND/nIgGGFdUSoMtH5H2068Rw9MHd
         ayKlzkIn+5VICWJGYpkva3M+yZ12mIj0dopxh6xmRUXG4tnKmnyyXYcyvdohEbPjZ7K4
         zUnQoYSOu0JL4pUxqHuAVyuagOTIkkoyfxilegYIk3Y0w2KtKEFGYsSRAiOSscWHKEAA
         MDq53x25aTn2Qd4ou4dxr0BKj5v2dWY5t43pkXqIilCQBVWOH4PuMhyaT+VlnAMT8Qvx
         bMVOTnlsJuXIP0JqVtLMVhr/EVSShWWmlj0yE+JfsTDGFawILen9gyTaa3pHzoC8aa0J
         6JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087825; x=1750692625;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cvWGfqvAHegxKwTqRT6pqv8NWEdRZnW6ynL47ZacAE=;
        b=lSdIyqTK2Ko4uKfcwOWk+Di7lb7GC0jRqbwEzMDyVkts+/6Yze9Q80ub4oQA/2qhaK
         cr05hrrbR7Q4gJ4swba6ae/EbYS/eaMtUgS2TN0+77DZh9OugYMdII1dNSP2VeZFkHQg
         LFodLn6aWYSvgDqFNXDf7aulsmp4RO07CZDC5SY8ToElf14sAY7USD/ipMRAjaETXqHP
         ++xSaBijuEB0+KWNyPn3jJqMXiPtogFEMycI9IE5oIenGjDJcWGjS5Fy/3MI84J3W8MR
         fBeRoZ7hu+/rnFAKVaXfepqRymnPYyiVSya+8GsSN1YkphEbX2kKuZyjixCxpi/d6vTW
         gudA==
X-Forwarded-Encrypted: i=1; AJvYcCVTUHWuUjKHI9JQKUNXRKv0evtkmJvlNH85BPBoH51vyz96wEU52u0gNsjImo3RBadK6HVykrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZml8jgdSZebkYhWaVJjww7JXSnF/U6cXyJ7dj5Bn+Xfzogr1
	ksejYz6D3OVOARnznYD3SKqHMnyK1E/B/eOXLVZYUlrsUXiO7GseE9qA+C6TSQkccpA=
X-Gm-Gg: ASbGncuiO+1dhdD8bIxUJD9YevSAaAZYYDRqg14UOdVXFH9z2ci1Vm+ZwD2bKWt3hgp
	ZAByiXaseKWt9WKooEcIUFMdFtdijbwdGv0dVHYcGJ1FfsjgrdxTCdjy2M6ykmvJBL9pzLC210a
	Ymzl251yb2Pr7E1tfIvcjTl+6IB1Kfvkzo7x9fTYtuXXM7pQPfLn3rW5OldeXJxlGHOy/q2a5Ac
	tqxt5OLgXNdD+Ho7ZMkuCAzpgZ/hy1SybU7KM8aO06EiHModGmKlepvh+q0Vfc8PINRZhSmWN32
	UvEhctBQ1lHEk+DyA6wYC5HbcTc4y8AKEMVlzvDjiJaHKk2FxCEG6cGjBbP71JeCOxo=
X-Google-Smtp-Source: AGHT+IG596tYxW0ljWuNt4gT0TSmu4NhzRCCR7j9XtoZvCcR0RQqrU2i7H9ddacVmwF3JsA/oLlLSw==
X-Received: by 2002:a05:6000:40c9:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3a572e67394mr9107688f8f.14.1750087824809;
        Mon, 16 Jun 2025 08:30:24 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b5bfefsm11133140f8f.88.2025.06.16.08.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:30:24 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:30:21 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 5/7] eth: i40e: migrate to new RXFH callbacks
Message-ID: <aFA4jSmkt-U5SfJj@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250614180907.4167714-1-kuba@kernel.org>
 <20250614180907.4167714-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614180907.4167714-6-kuba@kernel.org>

On Sat, Jun 14, 2025 at 11:09:05AM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> I'm deleting all the boilerplate kdoc from the affected functions.
> It is somewhere between pointless and incorrect, just a burden for
> people refactoring the code.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 38 +++++++------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>

