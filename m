Return-Path: <netdev+bounces-115501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4C946AE5
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296301F218D4
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDF11865C;
	Sat,  3 Aug 2024 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PHgmjbq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9D19BB7
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722710408; cv=none; b=HDZ3A2OC1caZqegYjl2zYJiFQIil23FEHM0ESi1ZS+LD5PYUkU7LXGVnpy6+1/un5+Qk4ucP34uejpvF7LwEznZAnZillMOXpFzqMZAY4Km8HMmjFx0VMAaWatnTjyOP4L57uE4EO9IDzpFmtHoHpZN6jHMUSTTcG3ZWncqHhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722710408; c=relaxed/simple;
	bh=mGzs+Pa1t7Gv5l4Oc3lHZRze71IPKawkm2b4dBKEd2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnA/NhD0KYUGPE6M+91vw9dgxpqkUcFMFJ3gqf2HlHILZoZytyYGlfEwSU9lrELE+mCZ2+1Fw2en564ZAo9qfnqLm/UzBPc6fPSp4soZgCFVJsovHHVtydukewg8J/ULOqDpUozC7dZcFS1xYKzjLrc2oJfmJUq7G7PbsFfAqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PHgmjbq4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428035c0bb2so24077555e9.1
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722710405; x=1723315205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h68DdsHIrj7j+Jn7dPq2MnnpK48noTroaARYQk4NEM=;
        b=PHgmjbq4005bH8EeEi/0E6fgLE6rWVDnSYY+gytpXqoJddfMsa7h6U5QTYuSLPNt3x
         tBcEyGlMrpAFjS2ny6Gyj/t4hoqZq4nh5x2cyN+BeORuvJaq3TPpk5VA7fwrE4SfjRes
         qGv1az2PCvbPknI7sdwBJVBTDz0g0fqPiGfxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722710405; x=1723315205;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7h68DdsHIrj7j+Jn7dPq2MnnpK48noTroaARYQk4NEM=;
        b=IIzKenLB1fMbUMVIc7fAWXyqqFKZ3TJiLoV/PAY/7e8XAFYra5zw0PUHZlz9JCuD8e
         6tdzDkDJAR8NxjBO6prLmS+JTdAASb9DjF42armi3bOoPHr0EgfDjs9s2AFh+ufAhc2c
         vobk4BvCJlOi9auawhPb5pUd1o2YB4fP+j4/PcJRis+iL8NQ/ARleVrGIyzVETkYaaeP
         EH3upkdoQOJoNpmk/INlNpIKgnxTVjbD58s+Qw0+b00yUjojjvg0rofazPXuEh1Ng8So
         tXvPGCs9yWJMTDazwdFkSE1Eiot02272BoVo/PW+cKlARHd5WKyGKJu/w6F2oyAl6q8v
         kGDA==
X-Forwarded-Encrypted: i=1; AJvYcCU6+Vs6uJoFl9LDP1Knn9oKRN+FA+qVuBATWUdxHZm94nv3kx7OSa0Chw1ZDGLbWD/qNZXNHBAsqpjYuv82S/vs+lashvph
X-Gm-Message-State: AOJu0Yw+t+SExqU+fnf6eQvDkwc5o/qQJl8VUoBuJKCEuXaXkVe5KfyJ
	+7veAlDbwe+DMh+ZETvuSNVcjYea3nZzdgHSC2d0Pe6D2O/ODS7KjLjBYVoUYf8=
X-Google-Smtp-Source: AGHT+IEVsOMMwVhlh9KQyAmzwdgh5QHVJdjHE4OoQ3KMDc4vkMWnWqAPC7sGgEXbYGPMnzgSNTiqpg==
X-Received: by 2002:a7b:c5c7:0:b0:427:ee01:ebf0 with SMTP id 5b1f17b1804b1-428e4714cfemr74251075e9.8.1722710404818;
        Sat, 03 Aug 2024 11:40:04 -0700 (PDT)
Received: from LQ3V64L9R2 ([2a04:4a43:869f:fd54:881:c465:d85d:e827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a862sm136087485e9.4.2024.08.03.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 11:40:04 -0700 (PDT)
Date: Sat, 3 Aug 2024 19:40:01 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 12/12] selftests: drv-net: rss_ctx: test
 dumping RSS contexts
Message-ID: <Zq55gUyi_FRYAJ2u@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-13-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803042624.970352-13-kuba@kernel.org>

On Fri, Aug 02, 2024 at 09:26:24PM -0700, Jakub Kicinski wrote:
> Add a test for dumping RSS contexts. Make sure indir table
> and key are sane when contexts are created with various
> combination of inputs. Test the dump filtering by ifname
> and start-context.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/hw/rss_ctx.py       | 70 ++++++++++++++++++-
>  tools/testing/selftests/net/lib/py/ksft.py    |  6 ++
>  2 files changed, 74 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

