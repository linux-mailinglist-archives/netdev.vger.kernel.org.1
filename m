Return-Path: <netdev+bounces-81229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125B886B18
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C562B234F9
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6A23E479;
	Fri, 22 Mar 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="L2ezaGws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B12C18D
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105873; cv=none; b=gPO+yyBvKVx5vfEdEgwsV21OHJRiVeZXcaMZ/XM/2XeepMlHKpqHB/nK+/fOXy2KAevyMFiUmypPSiLfh72w3atie/FsQaP7hNL41BqUpwi+TdPxX1a2jIrvPrhaGB5k8buK8gK57NsLnKIpmWBqoFMcF1iK32rMP9pdVq97ynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105873; c=relaxed/simple;
	bh=OlXYRIH/s09HittZWeVyvp0YZvyM3t+mnfmS05nM6EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er5SiEU2oFIClQoRTm3lxE+y94zZLmAx98tl5hgrtFu1WuK8Tlytn3QJ8K+bi+yghchOXEi/kQNnGGBszUEnLAtOefaLKyNBc0pTITqtuvIUnBvdAEHFoT/vkOmCJmgxNEQn9r4H7IyBfqZs6HvzXYHDPf0TT+/Fcg6p56b6RZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=L2ezaGws; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513e134f73aso2541883e87.2
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 04:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711105869; x=1711710669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1Q0JqQ2lDHQx2HBzkx09xDtDVBpVyqq5z/MmDmfT8A=;
        b=L2ezaGwsvNeakqwdSdcW4L3EnzHJXZWqQvismbITfGVfY7KN3Xn7xdEZV0S9EmH1md
         qZoaNf/7olGCKIoESln70hf413Hf5PQm+7ei4zhlZRK7USZs5qEVwZBLpIKQNeKRXr8y
         smQo1Eil715FznLMMqEh7jaj2zUV1fthv4nHLY9Gli3o4nKBO/soseIRNlAiFZkfVdQE
         3/gHME6bM5jb7bLiku1EAWohwm9EMPed2UTTcEUNBIiY1LjVcT7EyFH6Y0lHJMX5a+iX
         MzjEt+dqI8D2Rf2ptW56mwzhpWXyKyu38PK39NLff6ua6hGJd/8keNRHUvKSL7iyRqGz
         0rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711105869; x=1711710669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1Q0JqQ2lDHQx2HBzkx09xDtDVBpVyqq5z/MmDmfT8A=;
        b=RC0YabXdBqK7kgYRB2tOVlxygvBTbO2jXutfMXf07wxwXQzRkCWqSIbx3MP5Y6m+Ho
         rQG7yyUJGO4U0xoKRCYDpbEoBzczFIUhurTOwKvORUUAZ+MB+WMqFfugYKEJFmCh3aGZ
         idI8D54ch7p62KPYBwTAVrcpDBnoazIrnpp404hFv8e5gTRCWgJjYjaljEO8RuisK4C0
         BTSktB6dLFRmmJ79dqULWKtJzpmUg31djzMOzO018bWU1X93xGQQhGsZfXyBrMSndZkG
         QNi9ojhP4g1uUkylAtKuoCXYjf4M8IGbrKkmBVsdDYmvNi/WqU1Qd/wS8jYkuAO8rphI
         zaEw==
X-Forwarded-Encrypted: i=1; AJvYcCXY3O7S+q61gV9gZbc+ntQ4bZlRgdm84I0yRg1bkKOkKKA4bdJ0OZlha5Mk+FXZAvxaJp1irQy6fjUu3t2mvzRiiR0fOTcC
X-Gm-Message-State: AOJu0YyYqSABoaPOFEwA0/eBc0KBWIYKqfohTOtgvrOOzAoVms8vrw3P
	OwUF2zDE1Jj9NAL23jjJdp5vmwNJfx5udxiPoKG0CevmFubmw/lssHxNZW2Ttho=
X-Google-Smtp-Source: AGHT+IHfuBMs9ozLEaCvAc3Ons6Whq3N/3ZypNoAuNB5koWwo+4NlOYdEqvdO+8bdlDTI/6oSVdeIQ==
X-Received: by 2002:a19:4302:0:b0:513:df6:dcd3 with SMTP id q2-20020a194302000000b005130df6dcd3mr1476012lfa.48.1711105869299;
        Fri, 22 Mar 2024 04:11:09 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4847000000b0033ec9b26b7asm1814855wrs.25.2024.03.22.04.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 04:11:08 -0700 (PDT)
Date: Fri, 22 Mar 2024 12:11:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] dpll: indent DPLL option type by a tab
Message-ID: <Zf1nSa1F8Nj1oAi9@nanopsycho>
References: <20240322105649.1798057-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322105649.1798057-1-ppandit@redhat.com>

Fri, Mar 22, 2024 at 11:56:49AM CET, ppandit@redhat.com wrote:
>From: Prasad Pandit <pjp@fedoraproject.org>
>
>Indent config option type by a tab. It helps Kconfig parsers
>to read file without error.

You should indicate the target tree:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr

Also, please include "Fixes" tag.

net-next is closed, repost next week

pw-bot: defer

>
>Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
>---
> drivers/dpll/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
>index a4cae73f20d3..20607ed54243 100644
>--- a/drivers/dpll/Kconfig
>+++ b/drivers/dpll/Kconfig
>@@ -4,4 +4,4 @@
> #
> 
> config DPLL
>-  bool
>+	bool
>-- 
>2.44.0
>

