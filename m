Return-Path: <netdev+bounces-95391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9611E8C2247
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76521C20C8A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAB13D27C;
	Fri, 10 May 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FNhyV3qg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF1364
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337442; cv=none; b=VfZXtdk63Ry8mevWheeIgCC2kjRTdJX/agcaOPDyxSMpE1AE41yv0wC+Q724T7VUfvzVV6LT+V1caepBtqn6AKI5o2zSfvHaxU7jFn7XJqVYTQfH2/ziELk+JKfYwRwEKYwm84t7UtU5FnhXy1NjzExRrpN2Wi7AjbOfBtmYhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337442; c=relaxed/simple;
	bh=nXgflE5B95vd9pNg+4/If8fnc0fknILcfN5X2631qLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oigiMYYMJVhCh0xX7QpXP1bAsYT0gw5uyW2k24gKyBXOB34UL3IPrrSiyIyq1TO8CpstxNqwqzNi/kFXUX2X/p7w5IIqGG2yaDq401Ky/H6PfKVsp1TB0kDkW9AdqzX4in6DrX5HCHdFvvqec75GrPQ+8DBpOP8mX7hxptpUjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FNhyV3qg; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e5218112a6so7716841fa.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715337439; x=1715942239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wD5INpBrnsarO0AiJUhZuKf0j4l0d3r9JcWEyVVrlA=;
        b=FNhyV3qgWaIbd2vD34Xf6P+R40I2q9bvutuvXWrl1ZHpWi1A+thM7OZ8MCmHTytrFo
         OE8rNwFZexDkfBnqPdSg4Tv9vlI8iu+8lzW/TJpeBji0QRV99cIIBwFEEevCQztdZhfI
         1ioIOKkos35AKHWVGJ7k8GD5YLBoj2P14ABZG+YcLbrrq448f32UZWXgQfDqWA2MEjDm
         RGdWSdmAYvHlTfXg/xm2Ypi53AhIu2Lm3Yq9jaapVBMpu/Bqo0o8WBC96R6Tz6V4yUFc
         xJBTO3RdmmOmvzgSjW87eUpOBbejzXTl9r0KLlfeE2qzreEnVIf4LOOGpyFAwl0ZWnP3
         BsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715337439; x=1715942239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wD5INpBrnsarO0AiJUhZuKf0j4l0d3r9JcWEyVVrlA=;
        b=dRw7VwleePyze3ilU4UdB02GABMa8b69v37TFx0BaINLqR/MtUWNi7w+NgK5txsWJm
         n2ppgcloGliYZQKaY/6vA1r81hbXU2C1Ru3khni+rz+/ccFwOXnpFhFPSgt+parOoZ2S
         cKVHWUIcSQw8pkfXdmuAbancBxyF4qVeDAZOWZG2OE2MNhxxRF82DQjUqsKNdvyO0wG5
         vEQbpIjLMoAgF4sDsspgMB42h0m9Tahrm/UNpMa8Anwpt4FsQ+dYKVARhQXyhhShbj/u
         ROMPOkI+ZNXdSyq4hO0fiMNebwABPZZFxRJOdqApw91CD6Et2+EGMku4KrOM/LLiYA2r
         5j+g==
X-Gm-Message-State: AOJu0YwWwdO4I/ZTB7QgwIaQVqLxafwM5XuKzk8jakFv/HnI7VXuaH70
	hY8++KxiCesbbAakUb4YeIfovImeQBWLyGHA1myTkbx44r5JFTDyxch0rIZIzSM=
X-Google-Smtp-Source: AGHT+IGk6Tu9ZaxL6acgoYnm6At4B4bc73fVWAaY3JZYI+o01Kpih02yFjeVK4Va11FoA+V+WYLocQ==
X-Received: by 2002:a05:651c:50c:b0:2e0:ffea:4298 with SMTP id 38308e7fff4ca-2e52039c0c8mr17507961fa.34.1715337438710;
        Fri, 10 May 2024 03:37:18 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88208886sm94053465e9.45.2024.05.10.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:37:18 -0700 (PDT)
Date: Fri, 10 May 2024 12:37:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <Zj3425_gSqHByw-R@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509102643-mutt-send-email-mst@kernel.org>

Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Add support for Byte Queue Limits (BQL).
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >
>> >Can we get more detail on the benefits you observe etc?
>> >Thanks!
>> 
>> More info about the BQL in general is here:
>> https://lwn.net/Articles/469652/
>
>I know about BQL in general. We discussed BQL for virtio in the past
>mostly I got the feedback from net core maintainers that it likely won't
>benefit virtio.

Do you have some link to that, or is it this thread:
https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/

I don't see why virtio should be any different from other
drivers/devices that benefit from bql. HOL blocking is the same here are
everywhere.

>
>So I'm asking, what kind of benefit do you observe?

I don't have measurements at hand, will attach them to v2.

Thanks!

>
>-- 
>MST
>

