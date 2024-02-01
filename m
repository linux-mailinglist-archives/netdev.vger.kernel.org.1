Return-Path: <netdev+bounces-67966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B28457FE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A382867E1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC28662D;
	Thu,  1 Feb 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lvb5lgh5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059353360
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791521; cv=none; b=HcWSzTQfo3x5Tg2iiXCSZ5/wb+z3zKGtdgX6A31JcpIjXvMvY2HXqeTs6zjKJg8GlkUv6FjQfvuU9fg55weYiDZJ9MJj5+aK5m4B61BGYWzziYNwOAN1wdflTHIIpicobwYY8mAa/bru0HE15iYnqM94YGq2Z0rJQRkFGJ8aMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791521; c=relaxed/simple;
	bh=hUsOruoqz9C0i9e+ni4pvIXs7Ofy4b7Bwj3AcpleiEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFvwas+5DSkWQSxucnDFdOEnW4VJBjQXQTScHfQlarPrwU9kYUdUr6V3ZmPeM3XtQsj3HqrWZWPNsKVb2By7ky26z6kSDWj3EXq4fM1GNL+CmNMc0cU39X/tZwx80R8/HAzOv/VDd35PB4YgQkEpIsnuVCTgFukOi5H5AKKufCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lvb5lgh5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso7733665e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706791517; x=1707396317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDUli7SapawbEhgEKj9MamTZrwmLEwNl4//XOWrPO4g=;
        b=lvb5lgh5oR6qETR2AlwM5n2KN+bYNNbio9RlUt9DdLl3BpWzno9hkKTXLsUloi2T2G
         orECqceWvq56fHSKllZIVBbAu1ny2jruIfIjw9dAANMWzjJwu+bM72oBPe26Ii7ItQgy
         sXfOkw3ylWqGW+DIFg+2SBKCIbub8dZQXOsQzTzBoBzcNFh0XKnKWoZKFQDyZTg46dS4
         chXfJJrcUdBEOArpbuuU/ZEpSKl8xS96bcn2671Ls2zsumftNydgJWZ+EFEtaLl5Iehi
         7IAHS3J0/RBs4eQutOvqVhpgUvyyZOLdYbc2pupzWD2zRiOBzJ2VTnYT88zsv78B6hb9
         zY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791517; x=1707396317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDUli7SapawbEhgEKj9MamTZrwmLEwNl4//XOWrPO4g=;
        b=UO8+555T8zsEcB7bLs+cPolxzwyukr7LSdM6GlRevMRzcDav6geV0tVTdhJkfkBCqO
         nE9JQJElqmzNDZJA4Sx8w8GHUFhrkxDKH3De1+nmM+ejjG/d4/5EKxCGUcvYFcsdfEE5
         aSuPc9Bipd7BKeMfxymEoyK4t0oUSNoNVL5/4hexoUGun+7ivhYCxmJ2XnMnZ94qMnFt
         sq0Gt2x4MiUA0r955DMCBckXt/xqb2vnQq+UCYU4Y/y80+0Lxsv30pCqJZPxZj3qOsmH
         27eV8xy/wTuF8j2FA9aR30TzRxlPPE9sj7/CupELeKN4JcMIMEHpQxx42fAlitMnTsrn
         5iIg==
X-Gm-Message-State: AOJu0YztXZb77FvlWdC/wdBnKbOqRceL8WkGtvjXosc7vghgDZBmBmZN
	vsGIwmETutG9zCseGKcTMdfcP967xYB/QoOvp0j+xZZ3IL9BBTKKXgrpMNtL8PM=
X-Google-Smtp-Source: AGHT+IE7YRIF9LNQJN0puA/OaBO1KsLP3nFPpzLwR2pe6cnPSfcKRI2VQVm1mzLAkfgPzBru9OApmQ==
X-Received: by 2002:a1c:4b09:0:b0:40e:fbb3:f67c with SMTP id y9-20020a1c4b09000000b0040efbb3f67cmr1788910wma.38.1706791517457;
        Thu, 01 Feb 2024 04:45:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVRua4yjVXfNtAY6t3d0Z4DYUafdiqnHUsEtWJywYHruYPZh3zgQlHkHcnbYHiklHXhMsyIx1LXN48u+t2WZ/5Vz8m3/H+WKg0yXac2MbH0Pxd1nHn61VYaA8IBWUNjz0n1cs0fv5QKpdeub+NmooZ2yWcOEmV8JbDfMu6DK/nw2cRG5p0miTgP97+9E96+HYyO
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040fbdd6f69bsm1328732wmb.33.2024.02.01.04.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:45:17 -0800 (PST)
Date: Thu, 1 Feb 2024 13:45:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] tunnels: fix out of bounds access when building IPv6
 PMTU error
Message-ID: <ZbuSWVur9iOYXp2v@nanopsycho>
References: <20240201083817.12774-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201083817.12774-1-atenart@kernel.org>

Thu, Feb 01, 2024 at 09:38:15AM CET, atenart@kernel.org wrote:
>If the ICMPv6 error is built from a non-linear skb we get the following
>splat,
>
>  BUG: KASAN: slab-out-of-bounds in do_csum+0x220/0x240
>  Read of size 4 at addr ffff88811d402c80 by task netperf/820
>  CPU: 0 PID: 820 Comm: netperf Not tainted 6.8.0-rc1+ #543
>  ...
>   kasan_report+0xd8/0x110
>   do_csum+0x220/0x240
>   csum_partial+0xc/0x20
>   skb_tunnel_check_pmtu+0xeb9/0x3280
>   vxlan_xmit_one+0x14c2/0x4080
>   vxlan_xmit+0xf61/0x5c00
>   dev_hard_start_xmit+0xfb/0x510
>   __dev_queue_xmit+0x7cd/0x32a0
>   br_dev_queue_push_xmit+0x39d/0x6a0
>
>Use skb_checksum instead of csum_partial who cannot deal with non-linear
>SKBs.
>
>Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
>Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

