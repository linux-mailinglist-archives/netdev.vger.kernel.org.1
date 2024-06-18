Return-Path: <netdev+bounces-104550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E990D37E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F04428664A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB73157A61;
	Tue, 18 Jun 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MtcCU28U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E813C697
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718246; cv=none; b=DRyqed4qgm5hli3T/puPJxUOWoQOYLclAVKW8GEiohEmqtprvivIYnI17azN1umxRorh9eKmLyjoxTmTp6Lc0PJXGdcrdgit9CBvHJSXAof2SSfMt5An2xl+xadZSE9+EsrwxtQc0g0/CAfHbh0h1ssZCyN/HD9TUaosfSTxD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718246; c=relaxed/simple;
	bh=NWikXjpkRj2Id4OGHyodH6vOtWSmxTQcha4p8kJZ9Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeRzG35gLFOvEyRZGNJgdI8yLaKeXN3AI2MLsVoH8On91pv5AZzJoqiFwjtO/3PY4eG1tx/X9FyZIkuyJyXG4j6Nb2yxfYx48qPpiZ0oDuM4JN0FAf8GNe8MbJJ2bvqkH1gXCTllsN90xdV4xTVzomQ++fS45Ma4iazGUCLqNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MtcCU28U; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42172ed3597so34355295e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718718242; x=1719323042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWikXjpkRj2Id4OGHyodH6vOtWSmxTQcha4p8kJZ9Gk=;
        b=MtcCU28UrwqJOxUFqDad9a+QZEZvZ+XndEEL4mWc4iw1rlDegacCR2HKVeCTD2PEar
         vE9q+AKxhyOc4xRiVOWHG78S0h9RPGm9u42ndPxoYF0uDBmimUR4uNbgC84UfuAbI6rQ
         0vgyFv9kCW4XRPgplU2YvKOU2R3VfZyYiYsOK/HtbXX1onO4gtZo5OhZARdhbABvPSPX
         mkiLuz2TcHNKCEBUBfeov9A0+IhHnNnESllpC6J/xtoSGhjh79XSSJHtwO5Dl6aHVlhz
         MWzvG2RpNkwVMbMM8d13RzbG8YJVylP65D3SgbvKj/1DKyGRFWaoHi04pFUkRIXr3WL2
         300w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718718242; x=1719323042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWikXjpkRj2Id4OGHyodH6vOtWSmxTQcha4p8kJZ9Gk=;
        b=tJv9nwgBjzqsQdJmseG0LBr1lNEQ19mIo9PldwGOWnH4G8NVl/09ITn8Wo8ZUCxqmm
         OzPBxzGGn7wt+xih67IuKvWFm9dh+pQHV/q5kj9SyIvwdGqGuluQfhjgWg9hRal1zmfH
         vrIoqQlwK2466ePMlmZwXKQ59nYyppgyk5uOPtdDbgmDpttKxm9WfSaa7n66k6e4q6Jy
         sw44QeWgDU79s08aiKgHp/D6xEbePWHJAp//vWnMEc60dhTk6ybOztmXBiJf289xd5Ym
         mIlyWkp/eDm0CP/qxV1eqCV5mMWxVlXl3NB/vIQ8IadZTwal/Vsr/muvdL92lW7Rnc+y
         TBhw==
X-Gm-Message-State: AOJu0YzQioieDsixkwF07t6GytCH3awFnW/ZcAARO64F+iS9ECnGcEgB
	oddOkcOJaa6ZwRbzSmgBjipopgKot9lrzu5rYD07JKfzfS8JQLg9NlWnJzYDZEo=
X-Google-Smtp-Source: AGHT+IGT9NyeAwKGPItuCbiIYyLLhAcu28obA1HAvzNX5/D53inMb/HpuoISsfJg4pIy+rUEWHwkEw==
X-Received: by 2002:a05:600c:3b9a:b0:424:7443:e6d8 with SMTP id 5b1f17b1804b1-4247443e76bmr8350025e9.9.1718718241629;
        Tue, 18 Jun 2024 06:44:01 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73b1sm227480455e9.45.2024.06.18.06.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:44:01 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:43:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, ivecera@redhat.com,
	przemyslaw.kitszel@intel.com, horms@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Marcin Domagala <marcinx.domagala@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] ice: use proper macro for testing bit
Message-ID: <ZnGPHez662_8E7AA@nanopsycho.orion>
References: <20240618111119.721648-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618111119.721648-1-poros@redhat.com>

Tue, Jun 18, 2024 at 01:11:19PM CEST, poros@redhat.com wrote:
>Do not use _test_bit() macro for testing bit. The proper macro for this
>is one without underline.
>
>_test_bit() is what test_bit() was prior to const-optimization. It
>directly calls arch_test_bit(), i.e. the arch-specific implementation
>(or the generic one). It's strictly _internal_ and shouldn't be used
>anywhere outside the actual test_bit() macro.
>
>test_bit() is a wrapper which checks whether the bitmap and the bit
>number are compile-time constants and if so, it calls the optimized
>function which evaluates this call to a compile-time constant as well.
>If either of them is not a compile-time constant, it just calls _test_bit().
>test_bit() is the actual function to use anywhere in the kernel.
>
>IOW, calling _test_bit() avoids potential compile-time optimizations.
>
>The sensors is not a compile-time constant, thus most probably there
>are no object code changes before and after the patch.
>But anyway, we shouldn't call internal wrappers instead of
>the actual API.
>
>Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
>Acked-by: Ivan Vecera <ivecera@redhat.com>
>Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

