Return-Path: <netdev+bounces-73177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B3285B41D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4CD1C20F1A
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ED05A4DE;
	Tue, 20 Feb 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eovrHKOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91EA5A782
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414939; cv=none; b=kkJyBfn7nkb5FNPO5enN2Ftyb744/JCNqLsdobz8HEZKoWR39zj3FV2hk2aFniarXKKmOxO73wKLXWj1cgcJi3rSmMtVaqNBAhbif45oYlQXcYmlg6NEhRZjKQ9qX4LoHAo31gO4w+AVpf6ynMgR9yfFQ5+GWXPByC+feGOy3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414939; c=relaxed/simple;
	bh=J+zYeJqlBPHTPRgTIQeAJ3oMn+ZUCupZUdoOVGZTVfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1WTsVKJuZjVXl2ZhwzsvbH3+9BlWkvD6yt4y0LyiZGiCYkvmg7D4G3U+NVcbZrjOfz9Y+wF/6399RQPMD/UpBfqdKgvOjD94YrdwLxmKHQQ4Ggr0Hhzqu1j/q38twWcgWFDTLlkZcBorsJjt+fY4hmWaKYo5bbSZa8EgkoPSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eovrHKOM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3394bec856fso3485461f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 23:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708414936; x=1709019736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/DSDybLrVzjdRAvVymD3Q0Ne4EDeLAq0j34Q0JPJ4k=;
        b=eovrHKOMJ5iG26eYNPQ3Fe7bmpCh7M3iyZbzugTftiWgYNcne8itRAK6640cDimi2+
         wcYLqLHujj7t0t1FrejMskaHcI2h9LLNIh+Mz1nv+uFrm0CuAjBNvCEY8IwErhu4vS7P
         kTWm0CPll6TynXI66swCEcBA8+2rjeR+QimVOLF/YcaQlNuO7ozSagSH+bxD9sixbUaN
         5XdNDZOOOzadmbOfuZPIPjsWOr5IpnBfgrQR7yLQC1N7FY/uGc/yS1FspVgXtyPQZcdP
         hGcFIIQCPROvfcsNpVtVUzfhW5qyHSR3G/NlnUD0zqK5QWPPfnjNY9SFxYYe3X/iS2gq
         AgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708414936; x=1709019736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/DSDybLrVzjdRAvVymD3Q0Ne4EDeLAq0j34Q0JPJ4k=;
        b=jT3x2utSvIoSz+uSMFq9LzUWdBu4uQjA//oP+Jga/S6vSzj38mkZbl+dFJ50ku9ISR
         M6e8pXd65JwtK+T0M3XdGY8Iip8fjDqnBuH1aaTJMx9W61w/N6NivQ7RFm6crrWUdfjy
         As3Tm8UO1uFs119NMM4h45/xS+Be0kvlgyDenO1wAXYKjEQgYJ15Y99noHGj/Nep6GEB
         eIlb+bKBaIgYvR84yE4aqmM7qGVwbseh/OLOXWdGQ1SRLMeiTfuYGEADtZYxCXJHDVYy
         AH4LBmoxhk4ozM1pvPIROQ/3bYL/+G2rf9SJZV8PV7aM6du650T0OZ1knk21EY2BIZq9
         DlZg==
X-Forwarded-Encrypted: i=1; AJvYcCWwBk0OuG3njXFTAee8stLw6oru+ZRxkZXqbhG+yBkTBjoI/VNBzcRiBDapT1mNcaot8Cf2rKlfCK/xQwjaFZka/ythd6f9
X-Gm-Message-State: AOJu0YzsbiOFYDariX4s6fFr+pXNf6IVWWTmh2AmpQHeBNwz6DUXEsp7
	rVQyiZM6t74FQl1AKRObGcB43QMrMK4Bd04du+X/VlPwbTNxGOfdf+kdg673zig=
X-Google-Smtp-Source: AGHT+IFmDYiXbAq+GZXsPe1Qqz/I0j0cFa7FpMBW/qXFUFi9HXyoGcuYe24+kqL4Q7z4/yKCsn75ng==
X-Received: by 2002:a5d:588a:0:b0:33d:3b83:c08 with SMTP id n10-20020a5d588a000000b0033d3b830c08mr6570251wrf.23.1708414935867;
        Mon, 19 Feb 2024 23:42:15 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ba1-20020a0560001c0100b0033d67bdce97sm1376016wrb.84.2024.02.19.23.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:42:15 -0800 (PST)
Date: Tue, 20 Feb 2024 08:42:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next] devlink: fix port dump cmd type
Message-ID: <ZdRX1KhTJju1PpQP@nanopsycho>
References: <20240216113147.50797-1-jiri@resnulli.us>
 <20240219151343.GC40273@kernel.org>
 <20240219122038.5964400d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219122038.5964400d@kernel.org>

Mon, Feb 19, 2024 at 09:20:38PM CET, kuba@kernel.org wrote:
>On Mon, 19 Feb 2024 15:13:43 +0000 Simon Horman wrote:
>> > Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.
>> > 
>> > Skimmed through devlink userspace implementations, none of them cares
>> > about this cmd value. Only ynl, for which, this is actually a fix, as it
>> > expects doit and dumpit ops rsp_value to be the same.  
>> 
>> I guess that in theory unknown implementations could exist.
>> But, ok :)
>
>I'd also prefer Fixes tag + net. YNL is user space, even if current YNL
>specs don't trigger it (I'm speculating that that's why you feel it's
>not a fix) someone may end up using YNL + YAML from 6.9 and expect it
>to work on 6.6 LTS.

As you wish.

>-- 
>pw-bot: cr

