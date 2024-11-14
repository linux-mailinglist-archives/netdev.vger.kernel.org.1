Return-Path: <netdev+bounces-144736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060FA9C855A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E14B27B73
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55251F7573;
	Thu, 14 Nov 2024 08:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34E1F756E;
	Thu, 14 Nov 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574564; cv=none; b=rQv1kUUkvuGlkBt7fxB3BV3E4GF8Gl/UBagKWRfBzkhaIdqAuYPiTB9qttN7wA4AQ1AHOAwXRlye1nHCXyxNXkY/FxGAoZGeEJDw0BvLeOYJJCT4JKwn6CUyW4xPO18WyrRFi5WOy8t7octPSZsiDyNVeJX/O5Z+pc+APANKiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574564; c=relaxed/simple;
	bh=TjRB9Gbd5aNrtHmKCEEdvrHAXTxMbkUuReyrNvQNkzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uek20w021LjEctX7fSxelFtIgI8tx4aj+gnjaUeO1VyafQp/e6UdrrMKltnTITVp+GlUg04rII8ninJfLUchWyQkiZz+I8pyp8CSiXct2jvBf9oQlIOY4b+Yqv7qoZ8/SEf9MCbDU3GZr8UUVRGzz2MU8JO16VQXHX17lIDNhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso469635a12.2;
        Thu, 14 Nov 2024 00:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574561; x=1732179361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHkLv7JkIdyvAs/fip3Bg30agNeNMKKQhB/ug+JtK20=;
        b=lcsvZUrNnZ/emfc4FMoJIokfT8OL7e9q0jBp3tB7YmcmgFTqUukFc22Kequ8icIlSY
         Q6wvj5ExCSqFU2zsjxZw/+ermrryfeOtLjrypywyq3+ZEsP1Ey6mqzzP/TT1Q8y+9/N/
         tV37Oj0NXs/OokDGHWrT8tyGrJJuB1eVh9jX/2dJmOrFLhVoH79wndU2AX5o8S0638j5
         Ogg44SZFesEK3W0D2mYAXjuPj5IGIqYLbOjtMaFXYoxaAv7DoyNv1qmfe9HdwdRGYa+r
         D3UoF9oFbpzRxig7vFyvFC9DKZbug1+RtFc3vVbkccsh5gZKAlTQcXOKIXxKGRD/aVPK
         8jdA==
X-Forwarded-Encrypted: i=1; AJvYcCVYW7/ESURGGYstKQYSbZUApORzx/WDx2CTpSVxRzetDC3iHJjqNqN71farQyOh3pqBgkIY7Kw7@vger.kernel.org, AJvYcCXGIBeym9LVn657FujmhCn6WUh+62JAhPv7GPRoatHHHgtgM2Gxx3qvDPnKvIRR2hzc3zjEwm8gwXYZ6iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7CpoTi8XiuyITsDgaZb2CXchnm3+g9ouAiSiQDV/yNRq6KeL
	0B+YiSXuCqiTOLSFMYqoOIyNQD/yVZsg6nWFTjjMg6naHzmzSp77
X-Google-Smtp-Source: AGHT+IGXh1M3pU2yYS+KqOaINla/6nHEPBMvrrgnBQTNw56mpKaKeVjwZqpckdzHp9FNm7dPRfD/NA==
X-Received: by 2002:a05:6402:350b:b0:5ce:b720:8bf1 with SMTP id 4fb4d7f45d1cf-5cf77eeba60mr883872a12.31.1731574561226;
        Thu, 14 Nov 2024 00:56:01 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c0a5e1sm338248a12.70.2024.11.14.00.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 00:55:59 -0800 (PST)
Date: Thu, 14 Nov 2024 00:55:57 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
Message-ID: <20241114-ancient-piquant-ibex-28a70b@leitao>
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
 <20241113191023.401fad6b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113191023.401fad6b@kernel.org>

Hello Jakub,

On Wed, Nov 13, 2024 at 07:10:23PM -0800, Jakub Kicinski wrote:
> On Fri, 08 Nov 2024 06:08:36 -0800 Breno Leitao wrote:
> > Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
> > following code flow, the RCU read lock is not held, causing the
> > following error when `RCU_PROVE` is not held. The same problem might
> > show up in the IPv6 code path.
> 
> good start, I hope someone can fix the gazillion warnings the CI 
> is hitting on the table accesses :)

If you have an updated list, I'd be happy to take a look.

Last time, all the problems I found were being discussed upstream
already. I am wondering if they didn't land upstream, or, if you have
warnings that are not being currently fixed.

