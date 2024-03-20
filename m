Return-Path: <netdev+bounces-80811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA5881249
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1837286143
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C84087B;
	Wed, 20 Mar 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fcHCHE5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD013BBEA
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941195; cv=none; b=k3S1VYWN+d+EWzTaakFnBYr5oNw+6wQCjpxEUFEo7CshhQDUkR6yJxOErlfr7BxDCjKPKxpSDkQ6Zzj87X7xvfajhx6CCy3ABY0mIjHXThNR1iYaQ+7jnx/yWJpo01mCmQixip+T99FBL3xGBumYV0sS43kmrCvWYNFeWM73F30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941195; c=relaxed/simple;
	bh=893iRlbBaz+5EnQXmTZLgZENYLuOHa4dk1AVWY+v8xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty8Qx403Endw3mU1ePmF9dBz0ZBXUvrmFZi9K8yrY5WR3nBcB3B2TZ3sP17jHGpvD00Ct4jUeJWVO3CztvtVfS6riQT4IfCUSTHZCHGMWYZ3NJtrKUFf1kaU3ecpNB1GiExoMyaIs0/3fNVybym89pgEcbS9DYEmHzN91ilAlbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fcHCHE5Z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4146e5c719bso3212265e9.2
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 06:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710941193; x=1711545993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=893iRlbBaz+5EnQXmTZLgZENYLuOHa4dk1AVWY+v8xg=;
        b=fcHCHE5ZWaUUbWyGmXP3G8pmYX8/JWWDJzyywPUO/gkzGow4RXvc8rO3ml1IBFkbxX
         SS+S+AHQc5IkO/qK+kv73nUGxkmjc2HMJPyevuNKYEnnshQkrOW/Jl6kjVASRfG3VbDi
         Kdl48rUAVM2hO2a/4zEZaKBBdtTgQ0mcdQIgQWWlkfj8RabF8XvMUrA5SMqX9knH6NDn
         Z7HNVw19LEUSV9cKU1d4iJrsCD2d4PUgYUcfUyxsVZNNW+M+npFcQAIUbOQbQRLOz5hP
         NCshqmz09d1TEOTV6ike3+Lerxqe5esyHrtz7VYzP/j6u7mLjZ4re3U8BByrAc6orAHz
         n9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941193; x=1711545993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=893iRlbBaz+5EnQXmTZLgZENYLuOHa4dk1AVWY+v8xg=;
        b=EAPpEpylvUIqzA1r3JD0ggPYxK7/QJJw0yORgHmSrT0UpO3w+047xLh/0LcjvmyyEg
         +z9d5/S1x5mD+gl/TbU/m/jd7P/GtGyhdLVBtuozoO5t6JTLs853+5S87vVoVVTNmwmT
         hURMpdRzLEzNC87hUawv4PRgZjFbau6TK0AQYcMWOlRvL+buLWqrjFQbw6pwg61twGp7
         yi/bx6WlYtuS7RghbJfBXVpdldeTchsUemaM9aVApM9HoHCd41lIHfeKGP++L5q+YUXR
         oeM40squfqbNgSzjmKD1AvQYKEFDrUF9ham0ebSQFahfIKOkJReqL3qi4SIx/O55QbW0
         jzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTZ0IMxsGJib2YIfXdEz9Vx7WJBHtnZUc6mh34ba7eInxX0lmH6OnrZbhTHXX3eoh+H6lUuoc3HLht6eY5E994MxtTH1ev
X-Gm-Message-State: AOJu0Yxmcf64HU3COWu+SPZQOx1VsF90aBn8Mc3JHw5k4PuwYQOziJSj
	hKzog19DSkUjGiNPN4IZzK8k7i6YReLAMBi4OZf7J8X3G63WKCSwIzIaA6yP+0k=
X-Google-Smtp-Source: AGHT+IFOsykmZ6HySkxLsE5pbbhYKeEzaOT5ZMsMxw1OyFPzXdruGzUK6HEUq8tROXTi+BNddwf7IA==
X-Received: by 2002:a7b:cb91:0:b0:413:ee37:20e0 with SMTP id m17-20020a7bcb91000000b00413ee3720e0mr1510600wmi.9.1710941192581;
        Wed, 20 Mar 2024 06:26:32 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id he9-20020a05600c540900b00413eb5aa694sm2228394wmb.38.2024.03.20.06.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:26:32 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:26:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: ethernet: ti: am65-cpts: Enable PTP
 RX HW timestamp using CPTS FIFO
Message-ID: <ZfrkBvv_Ak_HWoUE@nanopsycho>
References: <20240320102600.3418248-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320102600.3418248-1-c-vankar@ti.com>

Wed, Mar 20, 2024 at 11:25:58AM CET, c-vankar@ti.com wrote:
>CPTS module supports capturing timestamp for every packet it receives,
>add a new function named "am65_cpts_find_rx_ts()" to get the timestamp
>of received packets from CPTS FIFO.
>
>Add another function named "am65_cpts_rx_timestamp()" which internally
>calls "am65_cpts_find_rx_ts()" function and timestamps the received
>PTP packets.
>
>Signed-off-by: Chintan Vankar <c-vankar@ti.com>

net-next is closed. Repost next week please.

