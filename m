Return-Path: <netdev+bounces-114980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64923944D7A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A432284CD2
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4F1A38C1;
	Thu,  1 Aug 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPrQic7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711D16EB57;
	Thu,  1 Aug 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520350; cv=none; b=f8U2V0Fzk3BUrD4Jbjy1T9au3OtyAJ88o2p+hz0qs/JPUg80ZOzIE0hDr5tbsLhZ+t94QMsd5a2HxALpjRSDg2rMwS0M1jI8P8ZNWRvbNUfmRgVUF5tQ5dYbxhUvUjYcTM20s5ZcW8CZRIPxMWSUj/hf2CJszASnqLLfRYey2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520350; c=relaxed/simple;
	bh=JAqMcM7uR9rP2Jlvmq2labce4w7cAXaFQ5PgocCyBtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj2lwCXwr/3CoM9rmap6wS4/jd65l/B8XCOA0BSRLUSpw+2UAmOdH9u1YQ+BdIGB6CuJ+Hf+wvefbfIErc26MDBXQDmJDmgtnMqNBJw/JsbdkATUes/53P/nRFpEmSgekiVZVqineL7g4HZ4MGLrwp4hiKBAQ8KSFQJV3AGskDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPrQic7S; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so87607221fa.2;
        Thu, 01 Aug 2024 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722520347; x=1723125147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3GzdUtWjktANRszP0tMrsKQuTHgq6vxP6NFWVMXHZE=;
        b=TPrQic7SQ7m7DTFRt26VJA+JtmTeL4yl0qjXvphT3YlOe/L/AlimNrcJde0xfjfm4X
         pqMFm0NpXPTwrK+fhLNHoFs0DWRcZSzkzig/19WXd+3UC8i4TG36mGvr2rJkDAgC4QbT
         ivASurSynyFwmVdp/eJz5ES8S8OXLR9RvwfuHAjx+aDhZ766yv58P0flKrnpLyFM3rLS
         Owa7FnFhTuplP8Gv9YIfjkqeli881avX1PYi1mhDGjPtzW0xmmTEw8wOl4ggmlKNxqW6
         m3z/jDo+KRQ2A30Bltop0SefUY6TaA+4MiOcoEhBD12PE0YVLk5t5vjkhkjPYnJ7eqPI
         KczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520347; x=1723125147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3GzdUtWjktANRszP0tMrsKQuTHgq6vxP6NFWVMXHZE=;
        b=KWj4VZMDGjilFTIKaGkVVOC0LuosEY2B9uVxNZ6OCw+eVRFWujreSQ0Le3UwuPwA0i
         LTgNa9Ci8WlgLRL1G0lY5Mvvr6wZh5s8gZp/gJusgoHaTWPWSrJSx6xPoOgmWNx9FTeL
         GeBASdgLH3jzjM1JF7B253at1V3qCkqDxwv3p/U5PvKf88+dlOlZQyxZ+kWCfk7W+eML
         PaUck49RKH2QEf7We6wiTJ89k9nqrwEHIX6IMZXsMh4NDr6YJnJ7BDd8YanfFrGxGAy3
         eC3GkQ+AtZbcUuHFtEoD2SnshG5zPssVpcjV8HzkWSguR96fiiXv8vK5XIs7Gu28K/SZ
         rPlg==
X-Forwarded-Encrypted: i=1; AJvYcCVVlqWp8tns4EYDVwoMVOUrdqjhsCBcjPeLG/s+k2b5pPqz9/7xy9yj3I44QxP79YOXkp2psat18JLvgpc/63Xal9Dgfm6h
X-Gm-Message-State: AOJu0Yye+Xx7EfByZ9orerVHoRape2O/s4OkddM8RaHVuUYY0arGS9xN
	Ht+5D/cLdhNudkSGq7fKDrL75dj20RmWricD3pC5XrGvTyqyhHpe
X-Google-Smtp-Source: AGHT+IF/lFEv5/DOPkw6lvIFumrbEATJpAQpadqN5X7Yp3bUFn8h8snpotwSs6NxJXrplYunQaVKVw==
X-Received: by 2002:a2e:3c18:0:b0:2ee:8453:5164 with SMTP id 38308e7fff4ca-2f15a9f899dmr2812791fa.0.1722520346480;
        Thu, 01 Aug 2024 06:52:26 -0700 (PDT)
Received: from skbuf ([188.25.135.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baf3a1csm56611485e9.35.2024.08.01.06.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:52:25 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:52:23 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: vtpieter@gmail.com
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 0/2] implement microchip,no-tag-protocol flag
Message-ID: <20240801135223.l47anh2ew6xxcznw@skbuf>
References: <20240801123143.622037-1-vtpieter@gmail.com>
 <20240801134401.h24ikzuoiakwg4i4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801134401.h24ikzuoiakwg4i4@skbuf>

On Thu, Aug 01, 2024 at 04:44:01PM +0300, Vladimir Oltean wrote:
> 	ethernet-switch@N {
> 		dsa-tag-protocol = "none";
> 	};

My mistake - this was supposed to be:

	ethernet-switch@N {
		ethernet-ports {
			/* This is the CPU port */
			ethernet-port@0 {
				ethernet = <&conduit>;
				dsa-tag-protocol = "none";
			};
		};
	};

