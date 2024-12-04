Return-Path: <netdev+bounces-149069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6519E41F5
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B50B3A44B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E191F1316;
	Wed,  4 Dec 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="kbdWZQhP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236420CCDA
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329871; cv=none; b=OUTLuAb6KpiZ2h5ouIJOOSSB8Xx3WxiAM2/BvUjIr+ugPpDC4RFnijsOJVTeUXnq67rt8TZgPg3ktWEExpXrfDy5XnHwEBez4uNJAAkloCGU9G8OTHfqYXAFr/NXHsz6OAn0Zzn37cnVbbZK79jI1TWD6vq89RrwyxYdb0G63z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329871; c=relaxed/simple;
	bh=OwIm7ewoQ/tyyVEl2gtgBbM/FzCCUtYjHF0g2oI+RyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVTNaSnivj7rlKDXpaYjY4dnh/3QTCXf/zqFqmvNgKVeQt+EbbT3ZZ0BEqaiqRv9UZnrDq/pn+mcaI6NatJVW4wKXbXvOZC7yqvqd+jbQvTGJ83Wl/5gUrorLi7jPaBjUX1NJGA8g7Fo21zZWvQpt1w/UFALJGf0zNn6sUuno6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=kbdWZQhP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso2654b3a.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 08:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1733329868; x=1733934668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BePRakW479YdwoV8rL4Bf5U0PThrSiDz+M0PQMXyqss=;
        b=kbdWZQhPsljj2I2KA8dRGvAYoRSNHMwUs/6Vy3TIxdR/wehwIyqcKJQ+YlgpygMdfa
         Zws3hTpT7ssHRPYgPS9g716tWPQBm142+UMS1GtAW6hdX9WSODJIO1T7unrSKrEed/OZ
         zPi5jGlBUW6/UMIlr8RLwZ7qlQdRa6x0foZb9lSVS1/RLXa7unZ9gquvDe+yS65TLmBN
         OnwARPIuSAcYe0r2eMkwp2Edvspufwsl/Qud9svlLmPPVGDclQY3kI/Qsj+r2ylEfktJ
         7Ap3th9Vg9ZOeAueJyeNlN2hOQDqm7amS5x6H59BwGFbHDRX863hD2/97zC+uSjJgf8u
         VHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733329868; x=1733934668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BePRakW479YdwoV8rL4Bf5U0PThrSiDz+M0PQMXyqss=;
        b=sApN9RO7NXue9TBklHKl88TYyRXxKeO5qAbiiZe9zFh6C1go1Gc16oVou1RREmvAYG
         4Td/aQ8xwMtExhmioNT8ek8aJgeV7i6Fvvzy3ldvgXxmsAat/SO4zga6oIdxAOa0PjAh
         C4ekDoM1+HuX2L4l5irVW4ejGchwfd1y2aNlvExYnIqqsvq9HH5AqZT93CuzSSQGhw4y
         sbOZ9tW8ImXdkifjcjm0jJfTIhbogWHAiC6oQhiyRuEQKE8H+bCiANKMQpWyDFXyBx+s
         s9/i78X+Vj4k70rWvfPQ+n1snzeN2Bcy9hGwANKxYqUpbtuxSEWcuDIhbnb5C+pTIGqi
         EoYw==
X-Gm-Message-State: AOJu0YzJF8NYkat3IlafsJMzms97fRi8S5WDvUtnJ3nv5irdleKGQZNY
	mHfwqwsUn4gC4TuXgfk3QtcMrR9ScLoyUr8IfL54CawoGYTkd1WLdSgGXPFmtEzjUL1JxHJoJKt
	l
X-Gm-Gg: ASbGnctxKbd0I2pqLjQZ4lS3VuxO+/Fvg/y1IaGCki05FkNpCJS/ZpBXrQqmBIuaov6
	JexglUIWYU/WmBbGnqQbCPU9J74zceafn15sbgI6pUtGPhK4ku0pJGEXVKlAq/wD2K/faxpYwK0
	VjRCUVDKMnigNsqiDPQX/9lgVZLLm+Zjmx8GW7YN+GojQ685u1V8FMpcWTBurB+atpn/AtD3rEj
	nFStNaZaezI19Ys88QtmdJ2GMQVumQtlGPM5lLWebu4MUGjgH+g0p2EWJ+4cu7xVCRTOpLhiaqN
	FC4GwsFnwj39vv+xS2ICmbYvSJQ=
X-Google-Smtp-Source: AGHT+IH2gCiezvnfDDkWfddINxstjV2QYvR+BG0TKVIsBV8Z6di3xtH5a/GbjX/fnLTAtwjhnoWfig==
X-Received: by 2002:a05:6a00:2e87:b0:725:9ac3:f24 with SMTP id d2e1a72fcca58-7259ac31305mr1348367b3a.5.1733329868391;
        Wed, 04 Dec 2024 08:31:08 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72590d136c4sm1455389b3a.9.2024.12.04.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:31:08 -0800 (PST)
Date: Wed, 4 Dec 2024 08:31:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, dsahern@kernel.org, jiri@resnulli.us, andrew@lunn.ch,
 luka.perkov@sartura.hr
Subject: Re: [iproute2-next] ip: link: rmnet: add support for flag handling
Message-ID: <20241204083105.1827dd73@hermes.local>
In-Reply-To: <20241203124921.200637-1-robert.marko@sartura.hr>
References: <20241203124921.200637-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:47:59 +0100
Robert Marko <robert.marko@sartura.hr> wrote:

> +		} else if (matches(*argv, "deaggregate") == 0) {
> +			NEXT_ARG();
> +			flags.mask |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
> +			if (strcmp(*argv, "on") == 0)
> +				flags.flags |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
> +			else if (strcmp(*argv, "off") == 0)
> +				flags.flags &= RMNET_FLAGS_INGRESS_DEAGGREGATION;
> +			else
> +				return on_off("deaggregate", *argv);
> +		} else if (matches(*argv, "commands") == 0) {
> +			NEXT_ARG();
> +			flags.mask |= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
> +			if (strcmp(*argv, "on") == 0)
> +				flags.flags |= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
> +			else if (strcmp(*argv, "off") == 0)
> +				flags.flags &= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
> +			else
> +				return on_off("commands", *argv);
> +		} else if (matches(*argv, "qmapv4") == 0) {

New uses of matches() is discouraged because it leads to argument conflicts.
Use strcmp instead.

