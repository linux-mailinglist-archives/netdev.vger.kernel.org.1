Return-Path: <netdev+bounces-76814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC8B86EFD6
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 10:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E612846F3
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA88F12E52;
	Sat,  2 Mar 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QZjgqXYX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A91FC8
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709372182; cv=none; b=bK+IUPfXUneirDhUUSg+IC3AGtHknR3Ya9YhXQuP7G1U8gZ0pMvSBb/O53dON4JBzlDJS5Q1DPC+xNmR6NYRe6MH/AijVW+In4ppgsLmPGF8nFPeguvm1etKADPtLvNMenOC5nl2NbzKzRknSvzE0cd5qNMjVRxj1rnXCo21ipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709372182; c=relaxed/simple;
	bh=B256r5zEmIOiTuXLBBBmOaIxhLjEb9CS3AnBdn/wqE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n82LMkb4MsUdEt1T00UExO+OcMZgfrXypuF5H+YSCs/daJnEzPIk/u9bduELC9bkJZouGm7P2+yleGaylHKmU4axxphToM0WQeJPXdUJda+JrwL0XrtPSo/PMSEc5rB332sKaYNYquM0k+N06O6Pxw7oSgQqo7MrBeeMSIVaiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QZjgqXYX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so4027764a12.0
        for <netdev@vger.kernel.org>; Sat, 02 Mar 2024 01:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709372178; x=1709976978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBR8jTmgqloeC9Yb/CqEXV702gGyCkKiZC9/i73Gnt8=;
        b=QZjgqXYXRMSui7yCyD3qaofFZ+gGz06n89hAkNCGab3wta9iCGT4w9qYCZ9EUwl7MB
         HLON5pylst/ghmbqVi8FNsk7MyJSLLb6APTc9DaQ9ZfPp8iWCowRu3hjATNkYNYsiPJ3
         DMKft2R8mc1zzxowcDy8zYzTuloEjaehUljsvJr61zR1un7Orjoo36CfeA76beBiPqWU
         Vwl1jVX3KudmRvoubtzuLcktp019x5Ww8jkZQeMtosSn24lH8tvbzCe04HwBKomoJXES
         taCydoIFL4pYHynKQ3z0aiW6u6L/Q6xo4lOLSzcsqSjzQn3vsWKQwQoGupMhuLf3EdHd
         +PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709372178; x=1709976978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBR8jTmgqloeC9Yb/CqEXV702gGyCkKiZC9/i73Gnt8=;
        b=WKotoJD7AhF1vGDgAXA3tqOZ51RakT0LNtbuvvTURXFHs37P6F1l0qpd3Qo5zIGE1K
         TMwV2NPgQ8PO7qtf1QUsiuKex00AgqItaMKKFlD0lda8xF13SawLnDHsF9lCYHHtJVtt
         xXY8TSkGnaFk0I4a9qslwZbP5MtwruOvuTJTYWSViT34DyHql5xJnHw+NPDjZMPp0FHs
         SNo9PKLbNKJBhBZ++PLKYbes4G0B9DHGGm89E6gLkPXu09sZeaBRaHwM6hJKARYgAUJ9
         1r7R2vYsF3J7XiYlG8Y03qNdlsykh6+Dwo0rE9HmONkdzm4st3AHUlQ/JdOfl/qdSzNL
         jFWg==
X-Forwarded-Encrypted: i=1; AJvYcCX3s7Iqgt3GVM59j86zzrk5eglEkrWq0dweNmi16f96g1676NIWRznVV1hcNgtLUKMfDsQTGdg2IBpepqnogMSIJL6ilcZe
X-Gm-Message-State: AOJu0YzH3707+jCLB0ZkpjJZLAoYlWWj9fjBfN86rtYxEHnaM5cEoyc0
	p5BgP612d1oC8hnfdI9NSQkPNEqfIYT6dg3Dsmt2rwGE7iE1YFXOScG8uvHkoyI=
X-Google-Smtp-Source: AGHT+IH7l5mn8VM9fliWodgit9CoqXbIrIFtbPY44s4b+8rNBmbrbiwT7eCceWY9DwfmX3DetILkrA==
X-Received: by 2002:a05:6402:2894:b0:566:16e3:65a8 with SMTP id eg20-20020a056402289400b0056616e365a8mr2962788edb.18.1709372178372;
        Sat, 02 Mar 2024 01:36:18 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d40-20020a056402402800b00565671fd23asm2388813eda.22.2024.03.02.01.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 01:36:17 -0800 (PST)
Date: Sat, 2 Mar 2024 10:36:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	netdev@vger.kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH net-next] dpll: avoid multiple function calls to dump
 netdev info
Message-ID: <ZeLzDhuhTeI2YBtT@nanopsycho>
References: <20240301001607.2925706-1-kuba@kernel.org>
 <ZeH26t7WPkfwUnhs@nanopsycho>
 <CANn89iLcOE7aJ6SSjCSixLOQd4CsMdmE1UQZWBsp6UgufA2pwQ@mail.gmail.com>
 <20240301093128.18722960@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301093128.18722960@kernel.org>

Fri, Mar 01, 2024 at 06:31:28PM CET, kuba@kernel.org wrote:
>On Fri, 1 Mar 2024 17:24:07 +0100 Eric Dumazet wrote:
>> > >BTW is the empty nest if the netdev has no pin intentional?  
>> >
>> > The user can tell if this is or is not supported by kernel easily.  
>
>Seems legit, although user can also do:
>
>$ genl ctrl list | grep dpll
>Name: dpll

True.

>
>> This is a high cost for hosts with hundreds of devices :/
>
>right, a bit high cost for a relatively rare feature :(

I agree. Let's remove the empty nest then.

