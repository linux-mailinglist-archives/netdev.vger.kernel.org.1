Return-Path: <netdev+bounces-194574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE64ACAB89
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5889517987C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF691E1A3D;
	Mon,  2 Jun 2025 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiIbTwgn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1111754B;
	Mon,  2 Jun 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857224; cv=none; b=eVrn4IyMBzWeHOxk10sqnIDBLNcOgscd0Imw3zR7eO3BJ5myM/PANahXX2lbNXOt3kf7xGrpv8KANuB3WkQ4lKmWwZ8DZ1THGgG+6uFjTRbLL0eNRluxfA0byNUUK7KtRhz2/x2V8gsRpdyKoi+GnazPln1u9zHg6AlLDUWSocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857224; c=relaxed/simple;
	bh=zE0mwc/RcKH8gM2hFS8h/fZRz+9k/yquYhfJx4nipTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzFcl3wkTvw6c1iB9RyJDeqt1xUHGtZqMWt8rg8MSWZijuZoAYbbTZsSeANepGXScQLuOCsot8HKc515DvH0s5pVl4OwwlElGahKGzZ95O3iORedZEkn4XrZ9fLy0N5T5xeqd8fK9LZ0PjQAZZk96H+TRmc/8L+otOMd2XgCVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiIbTwgn; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604bec4865dso902039a12.3;
        Mon, 02 Jun 2025 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748857221; x=1749462021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qrWYlAR6wd3qmAK0M0nNJeAoqkDCZ/oLzwAwISJAfsk=;
        b=UiIbTwgneq/9/SxZC4+/Txl1yD3cWVyCX/ruaXKgg2QMRrth8b4tqNXztfRsRAOFCh
         AMnol9ELW5d1hiKEZZk/3/J53+6ccTtJM1lV6ovYO1JnX8d8P7AyyEZYuMhluzg/jhse
         DAoa2L8gAx9TK/pQGZcqIqMAlA65/56kFpl2eymGAsF6gMogj+xCIeEBAankrV0E9408
         m16DM0BUNtIaeX6QynLM4C+7e4zPm04SghCksYw/TJxWESFkCLoRLCUaTwPOf9aVtqWw
         rUyQNfyjv0NV4gSyAAghs5/v4SCOOFxl4jD4J2/n/f5b3br+PgGdHW/Q+FM9Z62pvDtt
         Hffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748857221; x=1749462021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrWYlAR6wd3qmAK0M0nNJeAoqkDCZ/oLzwAwISJAfsk=;
        b=kYJ3orKXGP1kGrbZzErGgKLEub3H5I0SrucqCLJ+0UeS0Nf3G79+Mu4VPMCQjMARHY
         lMEjv2r9CQf3egLSzv44bC+X5MzKksYTy/5D/JiviY2m2i+kgWr7ksBZ2LSC3TYajQBr
         7N3cJOf2PeHPTmUVTdGkrN5thLcYJBfrYoPThiQBxlmvKnradtwx6eN8yv2IQu1wzXel
         udoPcYHH/PAug3UOZcSSTiaV8vpV+c0cJ3G1bAjD3Hnq56kraLVwoXIU4G8WK6UPv5X9
         VIJnyId8x/RAq+YA3roD6hsOYsM+Vx/jL6bm45wURij8dTkHA2c2hy65CCGI8WQGRQeW
         4DdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg7AwncCtizd9rdv6V+v1Q/kLlOJHnHQCQ48884yy657RJY/gabdG1bA/xuzp5mxBi0+71rkEUcZEwEek=@vger.kernel.org, AJvYcCX/IeXr5sTZrs6F/qSZiKqVBOL4PhHN3i/rwN18tg4iaJHitX1mOQ9g7ncmcHZgy2s4OC2Dx1/P@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQJrQjvaniKkNZkwvb9b4x0d9GRFkTQ5ELYI7jlHbP6MEju9p
	LlgZsfVzu/G7OEYt9cr02rrmZ9PXYZY9pwkDpXkIJL3QpQsrEEfGAqAQ
X-Gm-Gg: ASbGnctL9Nh79dIuuA5atVnFMkuMyoX9ru0klCyde1j5sfDT10jkbIz0anFklUAH+E1
	r1mrPQfvLvzr6cwhFOqJrfAK6T4vAUj/PwnSVPL4U0YRvRIkH42tx8h6N6W8sr6yzq+u8OhzViD
	KXn3ocisLNKe7dysVaWngs9b7Nkf5bBRMDfGCtOJpQZDZbp/H5POwbvzI1lBGFCejccBj+H/0O9
	perfIAvbXzz1uiyrJAyZHlUruAYttQpm3XuHDJe1OMIdja4FDLTEVUoCuUapcpsbdkG7JPHq0CE
	iPs5ArXsjIiCM3uUui1UP4Dvbr8jiv14DFgpxIM=
X-Google-Smtp-Source: AGHT+IEzOrAPuOl4ymMnttZEqAIiXMR3gv/R20MjxtP9vGMX5aVcIjA0s4029Y9psPj0jg9gW9fhIw==
X-Received: by 2002:a17:907:2da7:b0:ad8:ade2:e42e with SMTP id a640c23a62f3a-adb322b2ec8mr384064566b.10.1748857220586;
        Mon, 02 Jun 2025 02:40:20 -0700 (PDT)
Received: from skbuf ([86.127.125.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6abc2sm769845166b.173.2025.06.02.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:40:19 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:40:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vivien.didelot@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Subject: Re: [RFC PATCH 05/10] net: dsa: b53: prevent DIS_LEARNING access on
 BCM5325
Message-ID: <20250602094017.gicndnpplnncbekv@skbuf>
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-6-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250531101308.155757-6-noltari@gmail.com>

On Sat, May 31, 2025 at 12:13:03PM +0200, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement DIS_LEARNING register so we should avoid reading
> or writing it.
> 
> Fixes: f9b3827ee66c ("net: dsa: b53: Support setting learning on port")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 6b2ad82aa95f..9667d4107139 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -593,6 +593,9 @@ static void b53_port_set_learning(struct b53_device *dev, int port,
>  {
>  	u16 reg;
>  
> +	if (is5325(dev))
> +		return;
> +
>  	b53_read16(dev, B53_CTRL_PAGE, B53_DIS_LEARNING, &reg);
>  	if (learning)
>  		reg &= ~BIT(port);
> -- 
> 2.39.5
> 

I think if this switch family has that limitation, you should also patch
b53_br_flags_pre() to not permit BR_LEARNING in flags.val, and return
-EINVAL in that case. Otherwise, the "ip link set swp0 type bridge_slave
learning off" command will go through.

