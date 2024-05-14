Return-Path: <netdev+bounces-96216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772B8C4A88
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414FE284E3B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD365A34;
	Tue, 14 May 2024 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBk4+8QN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEEA7EF
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647351; cv=none; b=mBYOXUBMAk8pUGwmVzKN4F66TIg4B0GYJ9zmfHeIJFW2rtPGD7iR5YIHbnOUTyiqdulL+wD+fydllFDLM/7idpqNo/GPRKEkFYM7Fdv0p/zHCZGQiQDJoubqlDPAoNPo+U4oLfa1WrSjrBAJTgOxRKaI68DkY9TZ2uCgr2tKzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647351; c=relaxed/simple;
	bh=2MpnvqBD6DvqAhTrqX5oyxnhPl3vca3CQazvTQrvUig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPjL9O5NlXeYUCVJMBsGT0xXIgDK8FyUYcYhhk0cWQ4wud1d5nr0Zu1lM5AqluWCNrpa2uXSleVPYi4ibWkDsXiSSzV1tN/fADN5t8yPpDQMZVK130ztTZIuxH723t58YvW+00SDqn74B4lRTJNNe/gQiFu9X7VCMTJNdFJh3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBk4+8QN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee954e0aa6so38618705ad.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715647350; x=1716252150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDv6WulsmLQrx5i35Hr3ztFDpTYtAjDplykoKz/q3Co=;
        b=gBk4+8QNAt+r8A0772q/zG3EMYqBVgDUc+vng4Vp+ysnUkejuRG9/fWfDg67SLJgOJ
         vBc9YYfcCOyNQs8VY0lNv/Hd5bKW5seatuOYDS161YrgUHmAt0CCZ+Af8zttTVcmWplW
         gIzAIKwdu05q+NXga+tZcdm6+KHhyFJ0YYDOdVOzlvYZL1Fjl/55EHdy3IoBk3qAxdGL
         4mDAw/3BEoSaB6JDFMx4eo/mepTxtkbPZ1ukPWteJEyT4vniGMZuzvrgLpSgK2NPXuAj
         kut/TpO7dwEANTOkO8P8lO5y3OxgvkJ6djkQDRXJWkAvOQvmAsxaA7dK8fNMNZgdGJS3
         zc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715647350; x=1716252150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDv6WulsmLQrx5i35Hr3ztFDpTYtAjDplykoKz/q3Co=;
        b=E5KmEBrsqAOwt+AyhQJNbzn0hfib3pVeqbF85OXCbHMv3jD7fu4vtpixVDka9fViK8
         +VeVK9PyAqL846P3aggnsAc/I0c6/+RZqcwAD3xLUnVkMrVo6JMEd10VLp0U8iAo43DA
         fJ1CDuPrUbjH28wWO8AciIESta0q/H0y8QAr4xYpX446JW8pPkjMKRu/bZxLApRkQ5H2
         jTAAq5Gb2ghPHPvx6+8oIFdjpN84Sicq8i9rdDjkz5FaextYWiPb+D8aYjDZcj2YSQKN
         hT5jQLcvit1JlzJTV2yG+jftOXANg5BYP/M72KaDle/Pnuqg3KXfVabIYxJgYLqrUfHS
         LGoA==
X-Gm-Message-State: AOJu0YwnGN7yu3YvlOAdl0Lfj8tzSGJU/m9MImUm508R9zP/9VeqDHMs
	frc8jk3bYKb5OA3WaTwXRQgrurVr4Ad4SbzHM+BM4SwV/AkA+p78
X-Google-Smtp-Source: AGHT+IG5uMm/dHhBbasES+H6x57LswrMla0Z7VCj9EWBhZ6qfKlLw+MjzvxjiMh4HCjxxKWH9XIEXQ==
X-Received: by 2002:a17:903:110f:b0:1ea:b125:81a2 with SMTP id d9443c01a7336-1ef44161e50mr137549585ad.53.1715647349499;
        Mon, 13 May 2024 17:42:29 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036952sm84761515ad.214.2024.05.13.17.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 17:42:28 -0700 (PDT)
Date: Tue, 14 May 2024 08:42:24 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, roopa@nvidia.com,
	bridge@lists.linux.dev, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] selftests: net: bridge: increase IGMP/MLD exclude
 timeout membership interval
Message-ID: <ZkKzcJm5owdvdu6B@Laptop-X1>
References: <20240513105257.769303-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513105257.769303-1-razor@blackwall.org>

On Mon, May 13, 2024 at 01:52:57PM +0300, Nikolay Aleksandrov wrote:
>  	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
> -	sleep 3
> +	sleep 5
>  	bridge -j -d -s mdb show dev br0 \
>  		| jq -e ".[].mdb[] | \
>  			 select(.grp == \"$TEST_GROUP\" and \
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
> index e2b9ff773c6b..f84ab2e65754 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
>  
>  	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
> -	sleep 3
> +	sleep 5
>  	bridge -j -d -s mdb show dev br0 \
>  		| jq -e ".[].mdb[] | \
>  			 select(.grp == \"$TEST_GROUP\" and \

Maybe use a slow_wait to check the result?

Thanks
Hangbin

