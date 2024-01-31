Return-Path: <netdev+bounces-67477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A3843A10
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A96A1F2F57F
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F795FDA2;
	Wed, 31 Jan 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Fg9tabzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CA6772F
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691324; cv=none; b=bC5Cy3WluBhm9z25VdoxnFktm0vSZ/I7Ad7NgM2JQFFG2YyJtOUoU7OBTze0olmMgA5nHzILS2LcISqT4HJcXdL1huDRrIn1QkrxdPe/rwzZxrMtVTrX1ON/w1DQINVN/ZPb5AagH4tuIp+G9/bNpM6/wK/Va8dE0s8XFSu6LF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691324; c=relaxed/simple;
	bh=1zAz2+MFVhaNzjF0CUHFlp2iK4QKE8zWsjZLLf44jk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddQ0/Gn/Hr/4WrutzFOsXJ5jbnJMlYv1Zw69tQxH0rSmcd4mjxlX//XN9N74zPwNpIMCnXESbpEdYggc7ow3afx3vOkGR6ukHSIIpLg93CHJkovEug+ZjS2BZZkxQZAkiiWp9PgTpNcNxUFiJ8vA77CKAEhKzX01xA2P2OckXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Fg9tabzF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33af40493f4so1593832f8f.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 00:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706691321; x=1707296121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zAz2+MFVhaNzjF0CUHFlp2iK4QKE8zWsjZLLf44jk4=;
        b=Fg9tabzFtad5EwKggaEcDrs2/ZmYJgVp0eQLjYfftJD/GGN9DqbBjrSzWpf9P0vuel
         2H2p4iUBl+z7ZcoiyXgY7tKPHl2wEELXSPz9QHhIR1yFzwOJddRcaFbdrH4IaUAA+x3e
         71xBT/WyuXGZEfWjbJmE9Bb/PyQjzA6cq1Gl9D7u7xn3+g3OkDk21bE7j4UCzXisM7z0
         1d9Qr5ohvYSOSrALiOIFqu2OzFRpVRkz7mLfMphGo0aZO4bQCgOfazaHSFShW0yx4+Sl
         9M33WfiHHlZGjo2YfomsK2Tb7PZfGfCmkk7jAM0hhMnao5/V5+4C0vYQGdYf6ursuSWA
         uNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691321; x=1707296121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zAz2+MFVhaNzjF0CUHFlp2iK4QKE8zWsjZLLf44jk4=;
        b=Cqm8SJrAPA3+Gn50js+CL9jEFlyBaZqkFmM2ToebBLrU1Bk7hdLZsDEl1dhEVLNrzw
         r1BXylmw5SV38wpitKKz0BTHsVvSowV/5gVV4OtUxUyFYzp4dAv2zFNcMmMEmc8jkE9W
         Zd/tamwX+0d54MA1TsnNDOTcsejkJmr3oBmAdnvkJcr2D7FYanNlymQka/a7GKe686Wh
         ng4201ozhV/TIyR2tUm18zpI/zMO/jnNaMwcmkHkJApBVxCCJwELXunfrhQ09S2dD2ja
         rG2oGZt1z+CQHdy4lopKa9sdMPXLZGnkZuOLODAyUxSx4Zh3Gftt+kcbumW6dUWT8FXa
         jFzA==
X-Gm-Message-State: AOJu0YzOm9R2rxslr9LGmc5loYOg1zF5DFV6P8CFD5r9Y4GuYzZ8szLf
	v1MTyJXqb4diMJ/zt3bZP+M/QkIP9ORECMmgmvf2qzLcB9+PZ7nyMze1a6ATqIg=
X-Google-Smtp-Source: AGHT+IEDaB/xrJB9e/nbcOYh/jzhcipifSUQvbsXwmciEyC3bvRWprUeAzSWNd6QobawgPm3fQCCjQ==
X-Received: by 2002:adf:ffc8:0:b0:33b:290:253 with SMTP id x8-20020adfffc8000000b0033b02900253mr711420wrs.59.1706691321011;
        Wed, 31 Jan 2024 00:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVijmjMIBMPrVUDqpjOW8DpKrsuG/p+eiyjvljc+dEmxB6q2VcNXli1GoNTXWTgsQuSMqmzskCR7aGyn4nRAwYXYG/UmYNOWWOF1uwNI61zppf43lGmYYizGcUNUFCZZQNUGCpi7w4ZtgCB0WBCIqRnfLxpSC7406NOM6iHs7q8O8FAcRbp9PGzvBG0YR8wPtWvmVSfJPd2E13lM01BVx/i0geEPVTkXUA85quOLBts/lbIapx0m+Jo+E9NT+8V7zgl1CDqyXsAmJTXcg8qrf6IjK7V6+Bm05MpE4tIP18QxWOvc6hJnHXPaG/FBv9hHppA6A2RVm0KvkfqxOQuL2hN0bjIcYdO2SCRlhD74ep7iaQ/4VlTQOZdnqM7BYSCfXvf0IC11iSL8TmQkogGy7tRWyt308LRGyblF0Yop5iZy4AyE/JLjXz8YbuWg/lkm1NH80kP
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ay12-20020a5d6f0c000000b0033ad47d7b86sm12915043wrb.27.2024.01.31.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:55:20 -0800 (PST)
Date: Wed, 31 Jan 2024 09:55:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: karthiksundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rjarry@redhat.com, aharivel@redhat.com, vchundur@redhat.com,
	cfontain@redhat.com
Subject: Re: [PATCH] ice: Add get/set hw address for VF representor ports
Message-ID: <ZboK9aHNTngj71ue@nanopsycho>
References: <20240131080847.30614-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131080847.30614-1-ksundara@redhat.com>

Wed, Jan 31, 2024 at 09:08:47AM CET, ksundara@redhat.com wrote:
>Changing the mac address of the VF representor ports are not
>available via devlink. Add the function handlers to set and get
>the HW address for the VF representor ports.

Wait a sec. The API is there to change the mac of the actual VF. Not the
representor. Apparently your patch is not doing that, changing mac of
the representor.

NAK.

Fix this to change the VF mac address or drop the patch entirely.
Thanks!

pw-bot: cr

