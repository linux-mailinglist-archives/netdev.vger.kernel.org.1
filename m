Return-Path: <netdev+bounces-134565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B7299A296
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 13:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8361F221F4
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A1D21265D;
	Fri, 11 Oct 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lHqbs8e/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D62141AE
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645563; cv=none; b=pt331BnzIzB5qur9W/2FA7DHTHlBh4SsG6q3ltqkdD9e8krBJRM1O6Ca9RLjRrc+zi5RWGpxxp047vecFWVL5eGxFjJwlMMq0IeYgFT86gvhte6MTSPJdS9jKUsa031FvtIUj1FVzwXkIjooBwT0N2AUlWmAsIvwzL4O1Ay1P6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645563; c=relaxed/simple;
	bh=u5AO+gxJJda95mUN9KN9KtEUnwUnOL1Bo0FVLw4/FpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJqaJAURPXi0izWP7k8ROuz6QPaFZtc3hVGzVjfHzv3NgHxTeywVWImRIcA8/sdlWcJ1FElCV+dlWNw/L+Xq/b7SNb33gvC07xxTdN+jbAOB7NHNs5sCGjFHvTtVgJXPKGng9kGiHTpLkQjLgue+624RykBEVp7H/hslcwWxo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lHqbs8e/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso2309976a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728645559; x=1729250359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CljS6FhtN651wopFttoSAVl5QV+6I/h3KiZFQ9qPOP8=;
        b=lHqbs8e/AQqzb+EEng/yER7i7oGfpDoGoNMw0Wv8ImjqpmZXLSflsvtZNjIguIG6Gd
         BrdBEFDUj9+p3wduVZQZXpTTHSLCKbwsfg1PDzxdc+m0dtO6hwqtZMsKps5muH2NrhHB
         xSMWrmgTde6qg7nk6XL9jLZolVs6dphMykARLHkObaI0VXRYP7JAUkvZm7l2BBce7AGy
         ZRbY1kh4GPm1TrUJpxTzn+N1TSujxMkw9LhpU/oGKnrMy1UV0iGmvJXlFr06HiNnz0x5
         MXLGn5AP8oWB9zotc8S8zUTKQD/qPiKU3ygj2uu1MqqGUF4EMWAWslbPQi3g2KaclXrH
         yFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728645559; x=1729250359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CljS6FhtN651wopFttoSAVl5QV+6I/h3KiZFQ9qPOP8=;
        b=O1gn9uaH6qf79WJAsh852DiW/z+un49xaoszrLIiv2RV5hNwVSrWCPuZdz6ir58Ce5
         K6cNZ8GrYmbtnugEh95fs/ygusPK4ghtqI5XTx1/oliT/ycI7HbXrUCNjx8gkcFAVBkY
         4uZaQZQFOWSqjXNb4jxZpvnAefRKogiCwUWFBFxJeBmRHiMKOvDEJ1DuEFm3b9jePyro
         lnnn02ShkoqMSize6CoDm1q2lWuScmsVpYh0ZQ7N6f4G4gPOQcxxTLZ0tl8bWcLUxSRD
         0JzPeq2LEBz/ykQOCIzZkreKEvmkVttxnuxz44HpaHEf5sIf4qEu3O2YwW1HugVWGE3g
         ueQg==
X-Gm-Message-State: AOJu0YydB2s02hFkWVsGDyCPJFSAlCRmcxRLVzNhmPwXc7rxlB/E00od
	J0X5yxzhnrLpSQ/wclxlLZZJlaHYJ9QhkpHc1xeR4A2rQ/OmgvAH2HubKb6GntmJiYhrfHyfjvV
	7dI8=
X-Google-Smtp-Source: AGHT+IF3P8/F/ZYTf+OdbLkQrS19dgKjq53KeYFdqJO/RXTRav+qiSX5FGo+Nc5nAWy32/3TYMfy0g==
X-Received: by 2002:a05:6402:434b:b0:5c9:4548:eb32 with SMTP id 4fb4d7f45d1cf-5c94548ec76mr2849577a12.3.1728645559234;
        Fri, 11 Oct 2024 04:19:19 -0700 (PDT)
Received: from localhost (37-48-49-80.nat.epc.tmcz.cz. [37.48.49.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937153939sm1833977a12.47.2024.10.11.04.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:19:18 -0700 (PDT)
Date: Fri, 11 Oct 2024 13:19:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
Subject: Re: [PATCH net-next v2 0/2] dpll: expose clock quality level
Message-ID: <ZwkJtG3Z-mlzlOqU@nanopsycho.orion>
References: <20241010130646.399365-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010130646.399365-1-jiri@resnulli.us>

Note that there is still discussion going on in v1. Will let you know
how that ends-up, if v2 is okay or another v will come up.

Thanks!

Thu, Oct 10, 2024 at 03:06:44PM CEST, jiri@resnulli.us wrote:
>From: Jiri Pirko <jiri@nvidia.com>
>
>Some device driver might know the quality of the clock it is running.
>In order to expose the information to the user, introduce new netlink
>attribute and dpll device op. Implement the op in mlx5 driver.
>
>Example:
>$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --dump device-get
>[{'clock-id': 540663412652420550,
>  'clock-quality-level': 'itu-eeec',      <<<<<<<<<<<<<<<<<<<<<<<<<<
>  'id': 0,
>  'lock-status': 'unlocked',
>  'lock-status-error': 'none',
>  'mode': 'manual',
>  'mode-supported': ['manual'],
>  'module-name': 'mlx5_dpll',
>  'type': 'eec'}]
>
>---
>v1->v2:
>- extended quality enum documentation
>- added "itu" prefix to the enum values
>
>Jiri Pirko (2):
>  dpll: add clock quality level attribute and op
>  net/mlx5: DPLL, Add clock quality level op implementation
>
> Documentation/netlink/specs/dpll.yaml         | 32 ++++++++
> drivers/dpll/dpll_netlink.c                   | 22 +++++
> .../net/ethernet/mellanox/mlx5/core/dpll.c    | 82 +++++++++++++++++++
> include/linux/dpll.h                          |  4 +
> include/uapi/linux/dpll.h                     | 23 ++++++
> 5 files changed, 163 insertions(+)
>
>-- 
>2.46.1
>

