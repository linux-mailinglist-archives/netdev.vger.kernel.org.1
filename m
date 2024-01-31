Return-Path: <netdev+bounces-67500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D84843B24
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8C1B2B322
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20176350C;
	Wed, 31 Jan 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EdllPm/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3967750
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693349; cv=none; b=n2fQMWjjcc47Nge5+wCItjaSHj/UuDOMsNTO2ON8yHratA89dcrL/s68Kmp/YVIA1d+G/qmsgJZLBJaQUR9RMr3KYXhxP214iaKSjfcKqcXabP+28CwlTDhRzx8b+etXS7lLWlgZ5rfYJB769KQ4+02cEd5d+lexlV35cssTUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693349; c=relaxed/simple;
	bh=f43fKUriad8uDoZeZk6V7VP3GUeZsSWr0g2dLquSmNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8FQmzsr9ba8URIMCfxlQ9lWhavLQQk5EUg9cvEHp+H5hH6ow/EIR+sFZegAkO2G9KF2o3gEhOxZeGY12PnKVnph7I9sn39HHW2zhteagCHFyGe6r/LAZxqEt+whWYnem6gh0xwGV6vimEOAx9gXKM7VDJmCyl3sNImsCRZPj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EdllPm/8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40f02b8d150so13234355e9.2
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706693346; x=1707298146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f43fKUriad8uDoZeZk6V7VP3GUeZsSWr0g2dLquSmNU=;
        b=EdllPm/8J17oq9R3/crIAnK+8S3WFFRMxVjFdt6D7M7RIg78TNb1PmAPN6x+IJCFGq
         djaPW2JW/C1QV9N/po6BBwHr4AU+srLZJ1zVV5C6vpNgeL6xb/EZgQL7+UcmdnnDPL6S
         mTv1FAOVzqlp9DDwHPQt2Tr0h0ZumW+OEQnqkdu0tjTuYKeWgD+VAzYazRI9pbqvb8iH
         cT3fcbmZzlQLXsd9x7DsEBdi5OuoTMst703u9SY8QUhhUiYH+wyriG9C4HgW3zNxeUP/
         t2IXaKvy/2pSGIaSAgPFHYZIZGID7chf/UzcWKHnAV1DMcSSxfaK7g0Uxc1oqXyOlVR3
         0a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693346; x=1707298146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f43fKUriad8uDoZeZk6V7VP3GUeZsSWr0g2dLquSmNU=;
        b=fxd4G/2cKWjUMpzlRzdaou6LnpLWhMS6xsZ/RDKh4DfKxb2UXnODCb/LTgBs27kRKL
         Huwi3pBFHuAr1W7Nugqh5lTTGh+Iy4xubICJ3UzVQFv1BovuyOs/D9bJ0goyZqbaQYDb
         nddaxX26G6V9Fd1EQi15xbRpYX7n+j/qfAoh9/3xIuAOH06gUZ0wc/rF0RH6qFdQR3Xo
         5pc14KMSTUQ95vCdHB5m6Vohok8Z2Nn6430w4BBukfB48jOSArbNx7kC6zGz+JGAWbOC
         70h84HLgyZU34wxfS3O3X4N9OfFHgZ9uW6By2YWAjkGc5BcGGuOseQnvCzqMM3OMcup/
         SEzg==
X-Gm-Message-State: AOJu0YwomSVlD0hOqCknbTVWjm3eYLMTWDh/UHT220WlqnrOP/ZY9b+0
	7yxkWUCXP7ufQvCQqoToLg8nUTDyeT/39+zrRMdmvKD6QSMtMJg5ejMfIbOFrNY=
X-Google-Smtp-Source: AGHT+IEY2lXWkefvxzH893aZoC/yJtLJWaibwPImgr2nOy1n6RN5x75B2Avq9gwETOse4c3xNrxmhQ==
X-Received: by 2002:a05:600c:450a:b0:40e:622e:7449 with SMTP id t10-20020a05600c450a00b0040e622e7449mr725550wmo.22.1706693346221;
        Wed, 31 Jan 2024 01:29:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVyfO36vqppt50qgUDOESB2a3qrfawNZwydoEBbJCI2JFg2TkSMzceQG+yb8LZPQSoO4kGRBL1+yY176OY4Z/b+KmamlIS3odBxf6UcJ27Hq4EF6aJfpHGtOeLTCZhO9oN2umde/v3UImFWthmDH5Xoiv/XqcV9dmzMTMpWTbBCTMXyBcLltIfas4oEUjKtRDE2aw0UMgmrSbi6inIFA8grw6yf+HLvDwwjXVuWQoYBvVNVwk1TQTw5qq5yNBGoPB+FFX2/9g==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600003c300b0033afe6968bfsm2433573wrg.64.2024.01.31.01.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:29:05 -0800 (PST)
Date: Wed, 31 Jan 2024 10:29:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dccp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dccp: Simplify the allocation of slab
 caches in dccp_ackvec_init
Message-ID: <ZboS3wXu7Pan4Szi@nanopsycho>
References: <20240131090851.144229-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131090851.144229-1-chentao@kylinos.cn>

Wed, Jan 31, 2024 at 10:08:51AM CET, chentao@kylinos.cn wrote:
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

