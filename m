Return-Path: <netdev+bounces-136876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D79A3680
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8F1B22C6A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292E1DA5A;
	Fri, 18 Oct 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WL6ZpEzZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9A20E33D
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235242; cv=none; b=M4Krz5bfauFRDl0AHDFbatfsOsQR/kl9SmJmCJhzwcg/Lqnv5GzmYLfDtbz9Wjeem3lpxTruOH9NuEGC5Vsi4P6v2a0bKIGJXQX4gAsgc5B0RU0h3CYkug5Clwv5IaLSOPBa9xo54hj7yAD0iRQx5ox3qzu0/EMfeDUOL7PDBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235242; c=relaxed/simple;
	bh=JyenqulQwdtnWaf6PJv9UwKmAD1L4exTrCEMZU5z0iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU7DoiboAYPOTKRupjYccV2loGgvkjdukmHoj0KvidgDJz9mPVO9UFnh9Eaxt4GwxR+m/M8AWisw4ddCie0CbqkpNyPSoH3SPDhwBtG2p8b3YLY2Im6uf2zRKKUwTI+4fYiqMuMcyMnYpVRR332j176J4jUApl7JK54ug7p1FFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WL6ZpEzZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43055b43604so18501945e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729235239; x=1729840039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiB+13hgFlC25InhTHZJ2RcYqbhdc5ZnMcL4xuQ2DDU=;
        b=WL6ZpEzZXAaJCz/dBWq8Q0ocoCpawM2P2AQQ4cRNyhBLXlfPIfXWiEMFaIgMySasOT
         N0EJr0NFdhRUQVsU737oWfY/90zEcBTrtZEYwDKwmAhxoG821MQLvGJlIEjX7PKclzV0
         4iW9W7jFI8Df13paV4Mas8GsjKHrkquGvttX1cTgnXe9YO4nHkaJPil5a4WUSKbfN/rW
         OfBlO43lnC4obrZtooYPXESXhNhKKOXZO3JyERkaxYi3SeovYaoI3ZKH3KDrp9SAbxNA
         hDP9L5cmZwFgdkpXKf4B3PX4IPbGZbrSOHE/3mAMeNJ6yIPeOcTvMa0KAs4IupP5EV5G
         g3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729235239; x=1729840039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiB+13hgFlC25InhTHZJ2RcYqbhdc5ZnMcL4xuQ2DDU=;
        b=e+zRNcc/9zPcYy8/YTink604IeWdLM5BdFYXgF2s3t4tjRO/a4DsBmX6r/yeRyLsnm
         cEY+CFDDHS5sUQalrnje4A9KUet0SRxXhEZdBxu529UzaWq90aKpOFsZ9U1nFPQkcrMx
         KTPRhsKIuguqF6gXIIi7eYPcXsKlkRz1By1UH3XJnBHTwFrF3KdN+6cjZ8n+FyG99sBg
         2MkfZ40BfVxlGeA0NKucWsoxlHPRj/ZoW+JbdhbFtD8x6L/X3XqfHArygXfu0e87FrTU
         4Tf1JBg4c14/SJ/jTWFfBbtRw/euSibTSdZaj4VJGT7KolNacBVn7Tc+qBgQjrb8ZScz
         r6+A==
X-Gm-Message-State: AOJu0Yz4XxUgAR/TbIaYD/b3/rRZb5jPx16r6QLg4b6MZ0P7fDWKQ9VN
	kC9LWMaYW0pUC4jI4nm+6LcpaGWjxGfM3pktrFiA9l1+gEJGjDmh6B943YAHgCg=
X-Google-Smtp-Source: AGHT+IFnASlaOzPDaFLOx20oyoARW9SrpJfyzqHu5+8oGdahlRTGJbiOw+wUMg1ebiaFFW7ul0VxJw==
X-Received: by 2002:a05:600c:3b08:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-43161687de8mr9403725e9.23.1729235238330;
        Fri, 18 Oct 2024 00:07:18 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf066600sm1102690f8f.37.2024.10.18.00.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 00:07:16 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:07:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <ZxIJIVryvts85hv0@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
 <Zw5-fNY2_vqWFSJp@nanopsycho.orion>
 <20241015080108.7ea119a6@kernel.org>
 <Zw93LS5X5PXXgb8-@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw93LS5X5PXXgb8-@nanopsycho.orion>

Wed, Oct 16, 2024 at 10:19:57AM CEST, jiri@resnulli.us wrote:
>Tue, Oct 15, 2024 at 05:01:08PM CEST, kuba@kernel.org wrote:
>>On Tue, 15 Oct 2024 16:38:52 +0200 Jiri Pirko wrote:
>>> Tue, Oct 15, 2024 at 04:26:38PM CEST, kuba@kernel.org wrote:
>>> >On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:  
>>> >> +    type: enum
>>> >> +    name: clock-quality-level
>>> >> +    doc: |
>>> >> +      level of quality of a clock device. This mainly applies when
>>> >> +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
>>> >> +      The current list is defined according to the table 11-7 contained
>>> >> +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
>>> >> +      by other ITU-T defined clock qualities, or different ones defined
>>> >> +      by another standardization body (for those, please use
>>> >> +      different prefix).  
>>> >
>>> >uAPI extensibility aside - doesn't this belong to clock info?
>>> >I'm slightly worried we're stuffing this attr into DPLL because
>>> >we have netlink for DPLL but no good way to extend clock info.  
>>> 
>>> Not sure what do you mean by "clock info". Dpll device and clock is kind
>>> of the same thing. The dpll device is identified by clock-id. I see no
>>> other attributes on the way this direction to more extend dpll attr
>>> namespace.
>>
>>I'm not an expert but I think the standard definition of a DPLL
>>does not include a built-in oscillator, if that's what you mean.
>
>Okay. Then the clock-id we have also does not make much sense.
>Anyway, what is your desire exactly? Do you want to have a nest attr
>clock-info to contain this quality-level attr? Or something else?

Jakub? What's your wish?

