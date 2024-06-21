Return-Path: <netdev+bounces-105599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B938911ED9
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4811280551
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631B15A49F;
	Fri, 21 Jun 2024 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqWcslt9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560116C876
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958779; cv=none; b=gOAxxEzxyQprz+hS9HPThgDQLzseow8t4ERIcF7a5gmpOd0RUi/1aXKoMciTPviPI+qCkFMpUKT84jgHI0bOUOy7Mp4Xu13uo/D+OjadwIaf6ITQX/J09Ttimw6AUCKVgEC80yuCk6YRfycA9axKkbxfmkOGICLxog9XXU7TxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958779; c=relaxed/simple;
	bh=tG3znAHJZM4syAITgmLtvLwPZFfOlDJ4SI8GkZB4rtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joD3v037zNUqmhH0nTO94tEA6B0Oxw3RWanAC8wjQY8p9XYIo0IzZ4Mjph0x6z2FEbcA0JejJsquBiZz9di+iLpdoXrtlsbfJN6OzLouZsEim8GxpPPRXJGug+58LUzJNhm+vOYgUvA9iVfUjvnFO26sXtJdC2melNYrQXwTuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqWcslt9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36279cf6414so1418977f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718958776; x=1719563576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsQqZfmZnF7G5pXEgIPTwwy6YUhi81BmkWZvX7no8rA=;
        b=PqWcslt9qJIutVX75EcX5GZgGbcnEq650dk1N7pq+sQUy303O8yRmnPokJH4KO7wdu
         OeNxQAoVDe0kyf9PhTmXT6nq9dOCzDJNkGOgSzrkLe1mFc3LayV6rh39g2VUL+m60AHY
         xw4aihTDB2cYciCJ+Cdvva2IUITXouwtEG2fiiUgM/CSDw8HNqObroXoEsnEojzLyOLw
         bFBMnwjrF8f3BX+zL5LASx6VGXCMtB1oMBkvoVwU8OJCU+EovqPsPJxKdxKrlh1KPhkr
         owBjA7v5zdBKt3WxFugXwmXCpzhwm8bhAbrhImJjTCis1LihUu++KeZqy8gcnbwnvGvb
         s8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718958776; x=1719563576;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsQqZfmZnF7G5pXEgIPTwwy6YUhi81BmkWZvX7no8rA=;
        b=X518nLhwwQ/V5cmhOAah10umxkpi2d4ecG5LBvkPiks0DlK+OonxcTtZfUv2hNWHB0
         XHSlLB+KXQSSDG7ZFdQsElJIHCZMufGn7LRPvucGI4FYZAAcL1BhNvn1dwBfRY3x3mHI
         fYWGEgzP+ajsJLqTCFEa+/9kYJ5PLjILLCQ3K7QMJXRwsHx1TaMiFIgJcrd3FUv8Mmku
         ISzbvQdlp6fWJxFw1viLoyxDV0xO8DM45V/vE1bSNkt+Un5v5C6NzMncG6s29P3xSkEh
         I3R/8TPuz74LXqnDIvdvyIB/4rUXrxkXRjQ313DUzvkO50IiXkRW7nvRBOAmnUNfxfm3
         rBNQ==
X-Gm-Message-State: AOJu0YyDmqvkGrb5mLDegDWZ7gzbjkEjWT4L2pKC6GPLfxekJNEFjooA
	rmL/I2tiU8ldG3a3hgOZeXTXSnbJyK6uUsk3JHVLV3mBT3KHz2eE
X-Google-Smtp-Source: AGHT+IHhKDaRZLGVoI9kOxCogvbN7IO+pGCZVe1/ZUc2jibYg5czElZ/zSUDB9+G1Xnjdd6WriAD/w==
X-Received: by 2002:adf:e443:0:b0:362:9888:c37 with SMTP id ffacd0b85a97d-36317b82b6emr5423426f8f.35.1718958775726;
        Fri, 21 Jun 2024 01:32:55 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36676e11337sm713462f8f.1.2024.06.21.01.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:32:55 -0700 (PDT)
Date: Fri, 21 Jun 2024 09:32:54 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
	drivers@pensando.io
Subject: Re: [PATCH net] net: remove drivers@pensando.io from MAINTAINERS
Message-ID: <20240621083154.GA40356@gmail.com>
Mail-Followup-To: Shannon Nelson <shannon.nelson@amd.com>,
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
	drivers@pensando.io
References: <20240620215257.34275-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620215257.34275-1-shannon.nelson@amd.com>

On Thu, Jun 20, 2024 at 02:52:57PM -0700, Shannon Nelson wrote:
> Our corporate overlords have been changing the domains around
> again and this mailing list has gone away.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10ecbf192ebb..1139b1240225 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17532,7 +17532,6 @@ F:	include/linux/peci.h
>  PENSANDO ETHERNET DRIVERS
>  M:	Shannon Nelson <shannon.nelson@amd.com>
>  M:	Brett Creeley <brett.creeley@amd.com>
> -M:	drivers@pensando.io
>  L:	netdev@vger.kernel.org
>  S:	Supported
>  F:	Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
> -- 
> 2.17.1
> 

