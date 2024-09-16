Return-Path: <netdev+bounces-128482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2F979C37
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E61C1C21FE4
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B43F1304BF;
	Mon, 16 Sep 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjDfi8uU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407D360
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472756; cv=none; b=qtxx5+ruKVWz8A4M+FJ/QavmqrWFtiJe1dht2ceMc5GDYlNDGeBdF6DRrVJC1Ra07+gailsx/qSueqUCyTz2KWlm0bLD4tu9S+6Nxk9dXs4u5+34pbKaenYTRdXJI5RPMemhNV40PaRb0JP/NSiaLc4U8nIOJcFvUZrAJg1VZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472756; c=relaxed/simple;
	bh=TBWnroFIb926skk4uG40zrAePcGiVqKI8iYQ1HPZstU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT5xQFwH3qk/1/xjrnEWAwx9zkcAyrhWlJ9GgInRbA1yIcUY9rMLnKCK7W2G/vzh93Jn8goKrAd3qtkLjMyesDm0PjFJoT9G8oEIwwfl8agwn4F18NJaVDVQ43WnpSGyBvAfwZn/xeNvYgQOOQ2tPg5x5tt7PbwpZos9MHQRdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjDfi8uU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c243ef5322so387525a12.3
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726472753; x=1727077553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBWnroFIb926skk4uG40zrAePcGiVqKI8iYQ1HPZstU=;
        b=HjDfi8uUQWGWva1A7y+xOGBQvU4CNnV1BZvusMJqnfjIGDVgY1I3OJZKGcozDLD9hf
         hQhLKhTAsQeOK2CZJ3xKzY3vNjo+0N2BwulEXrdOyFC1i0M9zzGgvhPmrupAKWT2m5Va
         9Ke9HN3JLHvYpL3AsDtscfAqOrQYKowIQBwA4kszXegQQXswKLJSHyzpyUflYYXTdag5
         +jVJm69atlEdQN6rT/7O1ciMH2xjpJosSRn0oJJRE+3EJ4rzfekSha4rwTygoByp8EU/
         CRxAJSGC3DplLIHixZNrh/pHV3SHlxtBhOszuoHXOXFNV8cs5MgQjpCgJ3HvKsgeBHUg
         j1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726472753; x=1727077553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBWnroFIb926skk4uG40zrAePcGiVqKI8iYQ1HPZstU=;
        b=M5hNcRIFbKiDuzyCk0aEXEXVvD36VEU6BLpleuHBdrz1/370dtAF7ieSQkkmRY6H9s
         KkeKouNnK7VDNg75q5lknEm8Kh9wbCgo/eBgkPfg3I8SDFUL2Vl4oBvBrc4w8psoeo1q
         mmj+0O0WZzIvB/5HgF2BECPgJDR1NTXZUFiGjK4req0qE7DLMxMmsc7FyN/48CnJzONh
         ZXNvzeQ+DXJSGpo0b3d4FTHVc8t9sUjPjg/K/WUcES614NGfewbg2k+uu0sBJYg/8pvi
         iLAdEaZMWmHR4prIAn+t2+LDuqNKFqetZHaiL9Av0Nq1NHAoa26Ocj62mVHW2Of3Irbr
         QU2A==
X-Forwarded-Encrypted: i=1; AJvYcCUESUj2TLYmDmV1G4Yx8+rBwGdS+HR4B7bUWnjJK4rBe9B/yI9mLGNPjig0mMShd/14zuzYbHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8LRxj7Pw5UZEmdKvpMPTTSTzKoQiI0mJjQJT/X7Z3Mj2HRZTl
	+pfpYNY12PXniTH3rITBOI5qZeUqM1PGb8MkuEJhaIlsQlnDnrYrM35JYA==
X-Google-Smtp-Source: AGHT+IEj1fpFf3CR7LuqItNqn3Z6pdWHE5YvKpTDkyk/3F1i5rwgFOz6eg6GqhuGr5P/F1JFYkJmDQ==
X-Received: by 2002:a05:6402:e9e:b0:5c4:2508:aa1b with SMTP id 4fb4d7f45d1cf-5c42508ac84mr2988275a12.6.1726472751751;
        Mon, 16 Sep 2024 00:45:51 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e97sm2267508a12.65.2024.09.16.00.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 00:45:50 -0700 (PDT)
Date: Mon, 16 Sep 2024 10:45:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Message-ID: <20240916074548.6thyqbak5ata7422@skbuf>
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
 <20240910130321.337154-2-alexander.sverdlin@siemens.com>
 <20240913190326.xv5qkxt7b3sjuroz@skbuf>
 <28d0a7a5-ead6-4ce0-801c-096038823259@lunn.ch>
 <524fb6eddd85e1db38934f49635c0a7263ae0994.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524fb6eddd85e1db38934f49635c0a7263ae0994.camel@siemens.com>

On Mon, Sep 16, 2024 at 06:54:01AM +0000, Sverdlin, Alexander wrote:
> shall I send a v2 without "_currently" suffix and Mediatek drivers refactored as
> Florian proposed?

I would like to make some more adjustments to your patch and send it
back to you. I was not planning to do this exactly now, since the merge
window will be open for the following 2 weeks.

