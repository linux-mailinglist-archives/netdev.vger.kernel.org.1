Return-Path: <netdev+bounces-186494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D10FA9F705
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D231C3BA646
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB2F28A41B;
	Mon, 28 Apr 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WJm971bq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5325D900
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860324; cv=none; b=nWgT32Pqpb7fet8ibR3nk7EKwo569oNn6IM8MRHa6iok8bu+U7FSu1hKlcrVaStJTzv9Wi80lHNDPCWJn5x47jiKgt+F0TkNCpiAQNHJSPCRw8o59mRoMHLHZsVeHmKkYTfskHxZN7OKZUWJnsf1zPjx8O++XK3vGR8/SJfT8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860324; c=relaxed/simple;
	bh=QVIQI1ObmzWnmz5k5/+7wCUSkb9H2j5unMOgKwzFzn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy1PQ6Y6XVxwGmmJ89KSP68lMfSBsLMPIDYueKzZP47+obQhBgY2bnWcuTOSVQj1N4QAtumN11G9YDm/b0dDWQ6E4HHABcc689HLwMkYeTC8iaw7/WSon7d4fNgn2tCUfEVL0dfxrCrDTrN3+XGFDcqODl9S5UyEWgyBtZZtuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WJm971bq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73712952e1cso5454386b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745860322; x=1746465122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kSEmqEPBkV5onPgB2VqjSUf0Fj9MIHXq4/h/WvnXvg=;
        b=WJm971bq5pPb6pEZ1AZR5g6OO1FYcELd8p/j6m4aCEJgVanWiIS49+Qsaqg2DPwMrJ
         aHtYhQF6QVPRNUuuAH/GEAs3vuFefz/qdicwVLZf+SzomChuGYIhj5Jt4N4x1oz/7m05
         QMRyClWbExRDqtGbowd1TodZsulf08+tHXf0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745860322; x=1746465122;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kSEmqEPBkV5onPgB2VqjSUf0Fj9MIHXq4/h/WvnXvg=;
        b=bHjKgz0ydCxSj31Dt8G/eZnlhzqtIuHV1UpRDYvgswyafcVXa7MlgTpAY7WxebYwEB
         b6YeFyncXcKSxitCpSg7bJiS0k/b1TC3sWH/DfAYiiOOz49eVs6eFmh9L1/uBoGMg5wd
         9osCjFJavt8q1OnzxWtMjwJyB+X8bDdeyUfLCmU3pg9M1C4AlTGYGjH9Sf87ICK2kRRU
         UGxk5Y9f0wgXeSBH+IjUpYz/IZEqLZJ71k6nc19/mulaup+5Y+Qcsu/fUwi9iIX1fesO
         Lur/HNrklTrtXRdD3gLC3K/GPOxKAGm4niFu6UDLtDT6K5VFMXeE+gkIzgi82e2GkPdZ
         EKKA==
X-Gm-Message-State: AOJu0Yy12q9XGwA8BQl34ABmb6pZRQv5tC4K/cgjSQG3tH9oIR7dh7LB
	+KEXr9hr/3kJJPzMlGyQhHwAwJIjIhRDDkC8F9ZqRCTSjyzQLDBjSmEQzNgnZztnW9bcEkJrF2G
	X
X-Gm-Gg: ASbGncvAaDsYncWC3O3uyNJUwQtzOLosKFpi5s/7jcQ78kZWy/gSp5xCm+r2KyA0sj3
	Z9QKLBjMobIUIpdk4aVehOcF5DY/jQfHVdW05a42SJkSTUL5q3NF3poe3wbpK+ZuPfNmK6tjMb3
	G7kfWl8quN8a0GzevoDj6E0J8xsPIGa6bjt6jZpLFw+YPHxq5iWaljWS6VvZ8L5EPkDpog7Cylx
	aMLnIbOwqcLtpMAFUJvYRoOeajTFnY2NJ2dH5qCWY9suXa6uQUPeoFkRQXwFSGlQjVYKiOxuCgo
	4E7hvy1T5Xl7FTak9FCVJtkVStwwjh1fvRSg/Jkkq0yex8VFQm9XuVuZdWTAaS/dP8gIwC5Bp7f
	FVXsUpFw=
X-Google-Smtp-Source: AGHT+IG/CmSMevyeEIfzylFRTLvz+F2yVMriGaWEjyU9czbsClCGwibQbZFE9LAFqpQpFTSltShGBA==
X-Received: by 2002:a05:6a20:c91b:b0:1f5:8622:5ecb with SMTP id adf61e73a8af0-2046a6364f6mr14793574637.34.1745860322435;
        Mon, 28 Apr 2025 10:12:02 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca33fsm8273502b3a.164.2025.04.28.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:12:01 -0700 (PDT)
Date: Mon, 28 Apr 2025 10:11:58 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] io_uring/zcrx: selftests: parse json
 from ethtool -g
Message-ID: <aA-23k3znQtfxebM@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250426195525.1906774-1-dw@davidwei.uk>
 <20250426195525.1906774-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426195525.1906774-3-dw@davidwei.uk>

On Sat, Apr 26, 2025 at 12:55:25PM -0700, David Wei wrote:
> Parse JSON from ethtool -g instead of parsing text output.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> index 3962bf002ab6..5b2770cacd39 100755
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> @@ -9,10 +9,8 @@ from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
>  
>  
>  def _get_current_settings(cfg):
> -    output = ethtool(f"-g {cfg.ifname}", host=cfg.remote).stdout
> -    rx_ring = re.findall(r'RX:\s+(\d+)', output)
> -    hds_thresh = re.findall(r'HDS thresh:\s+(\d+)', output)
> -    return (int(rx_ring[1]), int(hds_thresh[1]))
> +    output = ethtool(f"-g {cfg.ifname}", json=True, host=cfg.remote)[0]
> +    return (output['rx'], output['hds-thresh'])

Thanks for doing this.

Reviewed-by: Joe Damato <jdamato@fastly.com>

