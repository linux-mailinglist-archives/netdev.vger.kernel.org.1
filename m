Return-Path: <netdev+bounces-88119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98E8A5D1B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 23:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7483B23E87
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDBA823CE;
	Mon, 15 Apr 2024 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2HDqMVb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BAE157467
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217186; cv=none; b=RbrfVS16cIj8x04u7Ev3VBmQYXndP/vKlfAfkEWTd87W6z9vxxr45v/OsSpm+amxds+Hk5ctaASQX/sUlD0v+JSrvV3mujda3NWcyeiadtdFd13VJBMf7KEbAeUadiOItBpkfwlT31XaN9/6xNwNcPeE9WfjQs9CqkhmKC360vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217186; c=relaxed/simple;
	bh=Ou+FvOs1B0WuJzy4wjnTiHrS07o3mwtSQsNGZnNkSo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4uFbh5DJqUgusN4clcuvdFoDuJtGIlqpAJNs8szAbKfKddwq85wJl3R+h65PzIy5AEkxVo0sZMvIjW9BK0knlvYRKuzkJjfe2fSe4aUct8iVk6BkT4zwZX0IaaRaydy/cRk71xlDvFEH+fh9JnGrFlwU1KEIFMzvmitI8J/8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2HDqMVb; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61ad5f2c231so15808847b3.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713217184; x=1713821984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4Igzsw7nTVFssFguk/Rbj2YFohqP9KtmCQuZOOHSCU=;
        b=a2HDqMVbDtozTmEdIClIQJo9FL3/AinIORJwrNpm5QXlXViiKsUCvOpk0ELHKDgmQK
         GhRTw9nGGmbhL0L+nILpkamRfMn1zCRLh9AQ5vo9HiVkycIskfw61Og/Uc9s8FI3rWYI
         9vFjzAucSkoQkf3Wnq6kX8//8Ao5yTBHmHeWA2f74Fa+eD6D+t1SSnNJWJ3/B2Dn36NP
         fU/0BBqGmUNNGrBdyuobTT6W56UV0JmpyGUgwSVgeSCL4pzVciCo5a9Td3VHWqDNNXK/
         6sMhoYQLA9qfaa8djWgsHalD5RbhQHkQuYIXtOob+zAMvvVj418bUyZQQc53l6oEgySw
         Un1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713217184; x=1713821984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Igzsw7nTVFssFguk/Rbj2YFohqP9KtmCQuZOOHSCU=;
        b=JmN1w0gpmCEm/Uw4IuTcTNUOG5YI54j5v703iOeKgadCfkZQa8qKmfyJWkK1pSkRq6
         AHUNw4cE3N4iuZkYnzYLzUqFnDzKxlCR/AMDEsNY0WIo3AM2Sgf/rwRjUOjLW41pjJ3k
         mFLNyV9i6RVeEZcs/tLdHzCVJ2X6r0/TYJHtdheAHomgCfEbXWpozb7rhJfsRnRnb8zB
         InQvuWjzzhk8v5AaO80NQKWyZX+99yX2n4AfYV0m6MLKPvUDun5zdT1bxpuFX7iX/LLj
         nyG6h4WYCxr04/BNAIldTRLJYMMskWOOXl5cAIT0ZUY3tW17SpOvxVgwYscz1qYdphef
         IKoQ==
X-Gm-Message-State: AOJu0Yy/l0cI9lrz87Pg4I8ayy/VWnO0UPEQSTDT4XC+0NeID7+IkqOE
	va3ZmhTS4lo1b68ZbPQloSbSoMUXGq5XwjL4Mvj3uciyRc9wwkFk
X-Google-Smtp-Source: AGHT+IEuBFvQdGq8XC+xGsXmOG6swS+A7y4Wz4C+E83HgqZ7NES/HexAlN3tWxT3W9BaCURm0cI74g==
X-Received: by 2002:a0d:f584:0:b0:618:8a27:f26 with SMTP id e126-20020a0df584000000b006188a270f26mr8434646ywf.48.1713217184009;
        Mon, 15 Apr 2024 14:39:44 -0700 (PDT)
Received: from localhost ([2001:18c0:22:6700:503f:95a9:a73f:4ee8])
        by smtp.gmail.com with ESMTPSA id l25-20020a05620a211900b0078d67d40c49sm6825704qkl.70.2024.04.15.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:39:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:39:42 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v2 5/6] selftests: forwarding: add
 wait_for_dev() helper
Message-ID: <Zh2enn9ArVKDrdIy@f4>
References: <20240415162530.3594670-1-jiri@resnulli.us>
 <20240415162530.3594670-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415162530.3594670-6-jiri@resnulli.us>

On 2024-04-15 18:25 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The existing setup_wait*() helper family check the status of the
> interface to be up. Introduce wait_for_dev() to wait for the netdevice
> to appear, for example after test script does manual device bind.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - reworked wait_for_dev() helper to use slowwait() helper
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 254698c6ba56..e85b361dc85d 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -746,6 +746,19 @@ setup_wait()
>  	sleep $WAIT_TIME
>  }
>  
> +wait_for_dev()
> +{
> +        local dev=$1; shift
> +        local timeout=${1:-$WAIT_TIMEOUT}; shift
> +
> +        slowwait $timeout ip link show dev $dev up &> /dev/null

Sorry, I just noticed that this includes the "up" flag. I was confused
for a while until I realized that `ip` returns success even if the
interface is not up:

# ip link set dev eth1 down
# ip link show dev eth1 up
# echo $?
0

So wait_for_dev() really does just wait for the device to appear, not
for it to be up. If you agree, please remove the 'up' keyword to avoid
confusion.

