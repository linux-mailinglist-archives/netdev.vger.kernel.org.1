Return-Path: <netdev+bounces-101572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E98FF7AA
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9802285BE7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46744315F;
	Thu,  6 Jun 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW7EWKCs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEF199A2
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713093; cv=none; b=KDprDFokDzuRzVzDNAZSsZl4xMpjL1UyTlIVQrZqQio7cvbcxGsSu7hv+R0Bo3Kq6aqZIz4+jo9qMsPMFahwPE9+aN5kcOush/npIZozjpzKbrqY5mL8BKxT/HD/V+W14g/inInhqxzamYck/ONBauv5keWYrdR4vnjwlzvkcnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713093; c=relaxed/simple;
	bh=pMSRuVThWHHV/uvUGar3ef8M7/Bg77IqjLFUMCAvToI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOgu3U9PoOJknw2QC4cLae06TpiZEGYePxDqroOAKC9zF9846BKiMxhC4IcRHT63zsZSOCEfNWKSKcCbzKPUUJppAJ80h7pTBZ8PUipVtfKFcJlTDKY0CzvDf+1ZV/bYgqp8ZE280Nrz1dDL0o7gzj43BUbcKRMNjF/IbmnhO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW7EWKCs; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3737dc4a669so6390455ab.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717713091; x=1718317891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCraPdOIhbqRWY0MP8+IVkSVbvl6gxt5Tm2c065L3C8=;
        b=LW7EWKCs6Koxv9taemmvBj9rx/th0ZmVI9TWJDJ/8WOOVKJ9CgpAjwDwBqXv0fDXkb
         L3m+eqdZ94Qda7TZ80Ho0tTzEaDL/suULp+L20IJ0cndj0jL9bVYauKLNqd2Us/RJCVK
         yIT4nTADAGpT0YJ5J0ZZDZZS2SObWaVKXtf5E+fSKslrlJavD6b/1BVhybLV3ybHOgZp
         qD9s9DsOVmYR6RE4zs1dGbIlQ/fFouoeAIAgcxyOWOYOISuPKq3p8Y7jReOLn7MX0bRo
         zUPMUpIkgP30fq8/zsexCMCWuKQcxzfDCsSji4neF9nO6eHkBDlvcghUVPS7rbxl3aYd
         NLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717713091; x=1718317891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCraPdOIhbqRWY0MP8+IVkSVbvl6gxt5Tm2c065L3C8=;
        b=LKXuvybX3kHatGhkpFR3SJxY2v3CqUm4EieCf89cDJfSSEXGwaxDh3ler2H+/ZORuU
         7HUXQSU6iwPAJIr+BsGZ2jIjEK3hSZRM9+IuOxzFcgsieKXQvBe3SIqGgKpJJ+77yX6e
         4BOmDX+4XTTX7B2CIw4Syrkl5Z690TKIDgkkspmuYBDaJx3u2+ZF6AlAzUnx/0Yyveei
         5+lUsmRK9IfLYV1iHexoh6ZNP1TKK1x/tUpVxi8BmTehVQpGQ0Hxq4VvQZ51xVhKogWR
         3FMnMByafx0MiZcOUbvWY0bzi2xJmC5s+IlgegapkCr/b1mJdFU+fD6ALt2/uXdSYgda
         AI8w==
X-Gm-Message-State: AOJu0YwoASp6eaX9ibtoEfjwQQ/eX0DOmRNUBpcLORpbrxwLHZsZ0a4/
	3p19LwPiLzmoyXuitF6Y1OO+nBKZNC+ILqcA90YN+9g5XabB3G1l
X-Google-Smtp-Source: AGHT+IGaMnV5KBibNhpcxzQwcj92OzQkBMQBcQhY9PGaKE5uJASbnXzd+SX2GGsYW8kj4O74aPhNfA==
X-Received: by 2002:a92:d787:0:b0:374:93d5:e370 with SMTP id e9e14a558f8ab-375803a4e39mr9536315ab.23.1717713091300;
        Thu, 06 Jun 2024 15:31:31 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:25ed:a50f:20b0:1405? ([2601:282:1e02:1040:25ed:a50f:20b0:1405])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-374bc12e5c8sm5033465ab.9.2024.06.06.15.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 15:31:30 -0700 (PDT)
Message-ID: <49b29dbe-5a33-4b4b-9d48-91d12a425249@gmail.com>
Date: Thu, 6 Jun 2024 16:31:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] rtnetlink: move rtnl_lock handling out of
 af_netlink
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us
References: <20240606192906.1941189-1-kuba@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240606192906.1941189-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 1:29 PM, Jakub Kicinski wrote:
> With the changes done in commit 5b4b62a169e1 ("rtnetlink: make
> the "split" NLM_DONE handling generic") we can also move the
> rtnl locking out of af_netlink.
> 
> Jakub Kicinski (2):
>   rtnetlink: move rtnl_lock handling out of af_netlink
>   net: netlink: remove the cb_mutex "injection" from netlink core
> 
>  include/linux/netlink.h  |  1 -
>  net/core/rtnetlink.c     |  9 +++++++--
>  net/netlink/af_netlink.c | 20 +++-----------------
>  3 files changed, 10 insertions(+), 20 deletions(-)
> 

both look good to me
Reviewed-by: David Ahern <dsahern@kernel.org>


