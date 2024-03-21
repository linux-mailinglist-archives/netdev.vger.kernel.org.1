Return-Path: <netdev+bounces-80992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8088856D3
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 10:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362E51F225F4
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC57B537EE;
	Thu, 21 Mar 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZQPC+7IZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CC5645E
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014565; cv=none; b=YZygTo0sUMJuVvQin7cO5Wtjlr6WZk3vihdEuk/4BQzYXZpHpd6pmjDXCCiW5VlpJa4HYbV7q/AyES4P94dI7E4SVTlu2RmDryMvCj2O2VhdLk+uLPBu71sf3Rr0WuiXrI0tIueeYtmR8H7PpiMNELqmne6QLyfPRHJWKMc/FP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014565; c=relaxed/simple;
	bh=l3ghcW6Wpc01USfRbBDFgdXMiPSFcEy9PO1CFvr9MzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6UguQTddEeF+rv/G0WTEjkrzObgdSmrR7+eNR+KfEP08ubSA/CzyvGoROIKs2bXw35hCCZxmGYAm7YvUnVV5drDxmpKOdl7U0OsQ6r4kLPRw84Bme1Yd+BlnrwJdJ+7RN+fdGbEfd3NT949mn4hsquKIcAn27NInFrPf92ZYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZQPC+7IZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-341950a6c9aso500158f8f.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711014523; x=1711619323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQnaVRKvIjzKZu/W9svAkJqqB541GQ+AgFRgogKa+oc=;
        b=ZQPC+7IZrh7UOTSELthV+dbIaYcZTg3R7VX+FsoP7NWz+jdgsQFaC70YCDHgcDozW/
         tj+abfD+IYjUW/hZm7mADgwztUKyWBOgZMqL0W5uwY6WQf8PrIWy0vpZ/kr4exOulvi9
         WlVDg75O3V9wZcGVmoGYtTqh+SjmdAuFyBwDd/TVHlpKUrJ40VRYS8O1WINEjoRqZAkP
         yoMcNiCIVIgwVzUb4kfdWh1BBoqZvK4EyJk0WbecL/3gAD1mXmvJxB99rU74+MqVRCf4
         fBhNAhzu+ZuR1QGdH19YRkcl+b0cK63HeJIWOVk5qf21BkisMiG7KwSDPGF474lO9c1l
         p67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014523; x=1711619323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQnaVRKvIjzKZu/W9svAkJqqB541GQ+AgFRgogKa+oc=;
        b=p7yLKhYgHo2gScmVIshTLj5UUyKgkbcxD3fFpXhIJu5D5wrG2oHxqJzrn1Sj6chMdz
         3/N3OTtB0MqoXxfaaATc1YScDquSpAyXwWXywliDQVhnKVd0+Bp7WtNfpvvPm72He/kU
         k3KjOYQiylt3y3375Lv1qScX9E2xEohrHjeEbWJtcrBbQQO/Cy+FsKS7+vr/0qzJ38we
         xWQ2A+AoQO2lQHNBhomYr3qaH5aFwoktcCxNEJr73mJ+xQEq0acQI1i1zet3QR7ODo0i
         sAJsWKGgdFynDCLC7A60IngJ2P5zZBh/xlg549Q4KjGcVsfhEsMmwPBdPya7/wHUylPi
         k9tw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZ/hNWVV5UtYuOqIkQWdadmuHLKSjpRCVck1KecIveKnDGJzKeqa2+NY5ozVu9lfCZ+iCjODyGRBJRKV81u1sE5rnz7QP
X-Gm-Message-State: AOJu0YyS52qVfnEWcTJtzC/xMMRP3FmaY4dmzoH7Fj0PsMoPeb8R07dP
	L11vHByiXLd6ulpsZ2xOrRqbM1F6RkIzY147SJiFTwfi8ytZxHmWFD/eqk/bTjM=
X-Google-Smtp-Source: AGHT+IGvSZEOt1oQ+NlJ1ttHSdpngsPBxO1aKwqD8k2tM3F3kCenyeLG4fsre/EN6wfoIDduTKE1xw==
X-Received: by 2002:a5d:490d:0:b0:33e:bb67:9596 with SMTP id x13-20020a5d490d000000b0033ebb679596mr1273242wrq.64.1711014522487;
        Thu, 21 Mar 2024 02:48:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b0033e79eca6dfsm16682495wrm.50.2024.03.21.02.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:48:41 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:48:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, u.kleine-koenig@pengutronix.de, leon@kernel.org,
	asmaa@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] mlxbf_gige: stop PHY during open() error paths
Message-ID: <ZfwCd_7RuyEJRpcq@nanopsycho>
References: <20240320193117.3232-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320193117.3232-1-davthompson@nvidia.com>

Wed, Mar 20, 2024 at 08:31:17PM CET, davthompson@nvidia.com wrote:
>The mlxbf_gige_open() routine starts the PHY as part of normal
>initialization.  The mlxbf_gige_open() routine must stop the
>PHY during its error paths.
>
>Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
>Signed-off-by: David Thompson <davthompson@nvidia.com>
>Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

