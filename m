Return-Path: <netdev+bounces-142438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C169BF1E1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB17284EBF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB12036F0;
	Wed,  6 Nov 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i7q170w1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA01202623
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907602; cv=none; b=oOBLTBsQqEA+HBLFWzOOsIwXzS15/AVEqZGydnzt0vYXWrO9D+ZdEUK/Xlbzqq6b1J8XfnR9+dYEvx8cpp9rWdHpRqGUg3jZZXUYo8iM1NLMSyt2S1JDLqYnhy7z9KxgAu+tF/G50hU1P6Y3chUNkl16hDjTK8npHkgysEi0jiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907602; c=relaxed/simple;
	bh=PLn+HGkBBwpOW7CICc2SyOy0BDrPR4BmKQAFCYmIWqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVKgOM3iP5ZlSiC+C1o8E4KVpkYyT4znOOizH6ZU8DMu2+jIGcdylMQ28r73/OmT9LA52hADnedJRrzr04+Syk7CqtdI6kntD/tNleL2M/dhODs3KB2KiJqj5aBOndXkEg/qyKbzjVhHHPKRuquW76uUhMrKXRQMfVGtPtZ5yuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i7q170w1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d5aedd177so4346349f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730907599; x=1731512399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+lke+kSJ/sHNhBrjG2QR3DbhnvDmE7dM4quD4X0oVI=;
        b=i7q170w1oBFFo2ijcUpH0lB3v2ORF8xyY6czqMAPtMNiOz+YQ7T9BxfwERp1rZF5Yv
         tLlEs98O1nQGDewYLnxBxZfbz6bEfavoBMlAoty7XVruSOEWKQYUmdqgF/X4iXfUlmCG
         jWRUk5gAjZ0ydnut8JrbiGsIMxsnTEI2TMVr/qjX9KDjb8R4Iu1tge4speLCNG+6/ATl
         ZInyIlapWbtEI/9qPHP1aJUexYoLS4Lbg943F4TUB9q7frR3IB4WkZzaU2O6PgZPOpYu
         AHzCkKSw5EMOgtYA5fDfrQ0FVlq8xgoeSM9oRWzgF195VIBZcP34OznPUUjpWduRuZYh
         nZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907599; x=1731512399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+lke+kSJ/sHNhBrjG2QR3DbhnvDmE7dM4quD4X0oVI=;
        b=GxSfn97ZesyZN0xvFsXO9GirrYl/dBfmzOF03qiKblW9ET4d1D09Q3qQr9iB63rEdW
         TCBeAIVHlq1ZbveeesMbq617MJHUAS88OvDFKbvx79ADWAO0J00RELwiE6+45boscqEx
         8K7gTunw4J/UukiEGBP2QYVaCPzKNCvQyn4h2edm3+kNCR0l6BHjN/m0JQwR7L8MKyLE
         aMgjQamh2uWUwQ/ggs0h/HXM36/kofTszujmZqQ25Umh3+MgXROPMuWTQ7czmFQwr7lE
         zFY1Ov9a0O69e+kkkcGeC8z8g6u1+r5Eg6oK6HwHg3oEYDiMg1SsmN7zzoV0KnxaM9Vq
         I6Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXtgZlg6+pwYu8Rx6fVwhfDfltNA3lcTBoZVBQ3whcsvUrhAQKjgtpv9IhQIzvKGz2WQ6WQKzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXEy0Ac3y7btkgLPFI1Mxo+xs11WhVUzqbiFklCSvWsKHBth3i
	O/UZFlmqiagvUZaf2uuLcsgDAxzO9u3wbyRzKYbJVewXm5M6WExJ78PJG/8vkM4=
X-Google-Smtp-Source: AGHT+IHaXpKkIZTp98WaTVKW8arf8yLJ6KlxXz0Ga7zfB6YCb98iODL5Q30kaHjC536zM+O/RrwHzA==
X-Received: by 2002:a05:6000:4711:b0:37c:cc67:8b1f with SMTP id ffacd0b85a97d-381bea0ee17mr17133942f8f.48.1730907598706;
        Wed, 06 Nov 2024 07:39:58 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b32sm19556510f8f.18.2024.11.06.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:39:58 -0800 (PST)
Date: Wed, 6 Nov 2024 16:39:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: geliang@kernel.org, liuhangbin@gmail.com, w-kwok2@ti.com,
	aleksander.lobakin@intel.com, lukma@denx.de, jan.kiszka@siemens.com,
	diogo.ivo@siemens.com, shuah@kernel.org, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v3 0/4] Introduce VLAN support in HSR
Message-ID: <ZyuNyzu0kv1_pemU@nanopsycho.orion>
References: <20241106091710.3308519-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106091710.3308519-1-danishanwar@ti.com>

Wed, Nov 06, 2024 at 10:17:06AM CET, danishanwar@ti.com wrote:
>This series adds VLAN support to HSR framework.
>This series also adds VLAN support to HSR mode of ICSSG Ethernet driver.
>
>Changes from v2 to v3:
>*) Modified hsr_ndo_vlan_rx_add_vid() to handle arbitrary HSR_PT_SLAVE_A,
>HSR_PT_SLAVE_B order and skip INTERLINK port in patch 2/4 as suggested by
>Paolo Abeni <pabeni@redhat.com>
>*) Removed handling of HSR_PT_MASTER in hsr_ndo_vlan_rx_kill_vid() as MASTER
>and INTERLINK port will be ignored anyway in the default switch case as
>suggested by Paolo Abeni <pabeni@redhat.com>
>*) Modified the selftest in patch 4/4 to use vlan by default. The test will
>check the exposed feature `vlan-challenged` and if vlan is not supported, skip
>the vlan test as suggested by Paolo Abeni <pabeni@redhat.com>. Test logs can be
>found at [1]
>
>Changes from v1 to v2:
>*) Added patch 4/4 to add test script related to VLAN in HSR as asked by
>Lukasz Majewski <lukma@denx.de>
>
>[1] https://gist.githubusercontent.com/danish-ti/d309f92c640134ccc4f2c0c442de5be1/raw/9cfb5f8bd12b374ae591f4bd9ba3e91ae509ed4f/hsr_vlan_logs
>v1 https://lore.kernel.org/all/20241004074715.791191-1-danishanwar@ti.com/
>v2 https://lore.kernel.org/all/20241024103056.3201071-1-danishanwar@ti.com/
>
>MD Danish Anwar (1):
>  selftests: hsr: Add test for VLAN
>
>Murali Karicheri (1):
>  net: hsr: Add VLAN CTAG filter support
>
>Ravi Gunasekaran (1):
>  net: ti: icssg-prueth: Add VLAN support for HSR mode
>
>WingMan Kwok (1):
>  net: hsr: Add VLAN support
>
> drivers/net/ethernet/ti/icssg/icssg_prueth.c | 45 ++++++++-
> net/hsr/hsr_device.c                         | 85 +++++++++++++++--
> net/hsr/hsr_forward.c                        | 19 +++-
> tools/testing/selftests/net/hsr/config       |  1 +
> tools/testing/selftests/net/hsr/hsr_ping.sh  | 98 ++++++++++++++++++++
> 5 files changed, 236 insertions(+), 12 deletions(-)


Looks fine to me.
set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

