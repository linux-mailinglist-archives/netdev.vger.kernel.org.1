Return-Path: <netdev+bounces-93694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C198BCC84
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C50E1F2181D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6117128372;
	Mon,  6 May 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fNsq5IzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DF142E6A
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714993186; cv=none; b=tSnAD3jnFNILb+HDEyhXi7PmadqUFSydUdZO3QyaxdJZUS+ds/dS6qmXV6Ovnb6wpOuVl9xzEH3jU38AGeY8LMaMIt6lw4W35bbw8kWBKm28cmqJLPUSSCSBnDV98pEeNjbn6DVBO+rS51FN3yfPvRxKbo1X2cJ9z+iZGWEFKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714993186; c=relaxed/simple;
	bh=P+OglS94Et00cI+S5fDEtR1ur4qsAJtvWDOKz0gQ2yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFJLeYvV1//pBTCNv2hAPJALLxTDYeKT+wGsxnxDlHxlSMA/0HxxWrcWV9uaQvvdQ8hKf6EBWmRZBjzRRCXbYwgsGERQVLPWaXFJkHXB+yn7b/Fcjy9NLzQyXMS43f4BweB2diPVStLsRKGp66bMg4VMOGyQ/Q2BMC7+8bgRYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fNsq5IzJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b2119da94so10726265e9.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714993181; x=1715597981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+OglS94Et00cI+S5fDEtR1ur4qsAJtvWDOKz0gQ2yY=;
        b=fNsq5IzJ3rhLQFWcTO6C69IFxos7yf0V4j3aVP6cdmSTG8Ss0oYorTBdesg/WhDMjO
         nBHGyYsUY132EDMdlcbKEFG/6XULwL/lDGgwGYGaujXkPJqMNYW9FPufR7I6Qnm920/6
         JceatGYojbJgRMAvDFtFwPOnfh8GmXkI09SVmHqiUQTQmPNfcdX6nuROspoIRllvyuNS
         ojivxlFzHZWnUBbjfd93wetTJM0LSTMb4WDLFewIaxj1e0oj9Bmn0apuWcTDOfoNULlN
         ICIcfaLlCxdQsswrOzVebUeccenit4uTxdGIBWUmjFYUeJNaVbu8RPBuVZ+WvI4Yub+n
         1BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714993181; x=1715597981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+OglS94Et00cI+S5fDEtR1ur4qsAJtvWDOKz0gQ2yY=;
        b=WuDVhVU9dhA6UKjw7Pm1aCbQLPj6wIs1n4BcZhH+Mz/ZBdIuPqXT/HPfEfFfsND65m
         hxgJ8qW6QrA29b9Rqj6COACbFjzNUM1m/keqJVyaM7e7jH5nvk5uNODWKfAOSOFbU6E8
         odGqYolFYuBcqErdRfwX4EeiHYjlobCt1szX8jiL7UKOUio5DN1TAo9qOSS9rHq9vIIN
         w2Jscx3w8Vp1B1bZo6xGb6XPXneP4v+SXp2zNizREQ8Sz0/e+cGyM1+EmPlMGe6wTj1/
         gyJKsYaZc3hWSRX35Mi5WqEGdYZ592O1mi0jx/0FQWSfNHwq3zb9X5ZQHKDyd6/frHSJ
         3A2g==
X-Forwarded-Encrypted: i=1; AJvYcCV43SII7AVMhN4ce1IGyxj91JbjD/eD6rAz13+yanAVlBux2rRheZmC9SebkRewNlx3HfPRKAcCg+SK7gCb8p/VYkuIE3TS
X-Gm-Message-State: AOJu0YzVwKw/mmLjXwxOZT0+FmGqYhTK/OF4wzNH0ypK7x/ADAs946mT
	4XlykUwIAdFa5c+wltpkKo9K3W2hCmsvOlF5PLqRuXfEY7dv5z3CgJk/WXAlKNM=
X-Google-Smtp-Source: AGHT+IFpNlHQPtEvHqooZtQ6BAQGe7ztmpjEWgH7FYjZvPLEMUouEn2bE+kgr4uXJ0VYMrYcFt7DzA==
X-Received: by 2002:a05:600c:1991:b0:41b:e4dd:e320 with SMTP id t17-20020a05600c199100b0041be4dde320mr6712864wmq.26.1714993181269;
        Mon, 06 May 2024 03:59:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0041a1fee2854sm19434867wmq.17.2024.05.06.03.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 03:59:40 -0700 (PDT)
Date: Mon, 6 May 2024 12:59:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v2 0/4] ice: prepare representor for SF support
Message-ID: <Zji4GfZnj8-Vn2U7@nanopsycho.orion>
References: <20240506084653.532111-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506084653.532111-1-michal.swiatkowski@linux.intel.com>

Mon, May 06, 2024 at 10:46:49AM CEST, michal.swiatkowski@linux.intel.com wrote:
>Hi,
>
>This is a series to prepare port representor for supporting also
>subfunctions. We need correct devlink locking and the possibility to
>update parent VSI after port representor is created.
>
>Refactor how devlink lock is taken to suite the subfunction use case.
>
>VSI configuration needs to be done after port representor is created.
>Port representor needs only allocated VSI. It doesn't need to be
>configured before.
>
>VSI needs to be reconfigured when update function is called.
>
>The code for this patchset was split from (too big) patchset [1].
>
>v1 --> v2 [2]:
> * add returns for kdoc in ice_eswitch_cfg_vsi

Looks ok.

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

