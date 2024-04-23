Return-Path: <netdev+bounces-90569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403C8AE88F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431D71C21D2F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377261369A8;
	Tue, 23 Apr 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="h2+doOeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004955E45
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880058; cv=none; b=beecgwKC0f1dCtgJBzia/HRUldcPtSICR88uHJc1VJ3o7CZLaWe0N4NfkeM/SRsEd1PxFa/yoGy9yRyOMPbaoZJHtzvz5jlRZa1Uo9Q9hfcwyTHQgbl7yAXCeowx1iL7nB2Q/ePDl/9Z/yiWoItR6L/fMBRW7kY9NORMMH4Tt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880058; c=relaxed/simple;
	bh=ek1NU8hrGDrmxGRlPD4P/fwgYhXWeLLURy07zsikdE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAWvXQ5TC6EK3YBES8i+alsDuqlwPM7VL4MpOHmDzDM6BzRAfZVN7kAOtS8JpdDXzYD+PgPnnLL/iAyK37HtHQBkM1CWOXPatZ/rugDh5cl6MSXXTl3BnvRvmqpHKhcqhIeDbyjH6J6t0qzEvQMFXkYg7TQ8KmAFFxNkRfW+Ayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=h2+doOeD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a0979b999so19007755e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713880054; x=1714484854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ek1NU8hrGDrmxGRlPD4P/fwgYhXWeLLURy07zsikdE0=;
        b=h2+doOeD1iCFWBxtH3tJsKtmdFBKrh7BLS+QuTd31uicq2Mr+sbfXW+Xk34RwNObgw
         2VPXqFHrQsh6A8Ppc7YKQsrM1cuc34ac1wOTq1/7ZtN0FdFr5TGjg1yXpVDXirlqFeou
         BcQfJRYZv/4PfCLm5zGCw+juzJnGbmbFPLUErMg5VJwZLFPmOfffmJN2c0sJuKGhuyru
         mz5tz4+JnX4wGLm0LQcjHsiXx76XKsGnE02Yh6/mJnMmdlLjHcUMznGIkJueY0KsZbEW
         JOgfZ32Z+LgZ/PPEoQpnBM7fNB76kYmKqDMPi7UtQnwi5DWDrkokAJUYGhG+am80850J
         MIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713880054; x=1714484854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek1NU8hrGDrmxGRlPD4P/fwgYhXWeLLURy07zsikdE0=;
        b=qETdsF/YHhMg170i2KBr9vlzfxSq68KZfgA9GHgbmDgQvz6MKmyQgU/Q4eI8fE5m60
         t7Rm4HdXn+Ie69Q9lKJ/2m3DulUn8ZQLTrVE7ZozXnyKAqDo0jziIUHb786M71nu1o7h
         bwZrN28Y85YjAkKw+ENWr4Ql7z8mNQAa5FPSpLh7OnO5uUQDtakNRRheRYaF6lam8wNy
         MMwraw0RJ/XSp3W6HftqADG4CbwgVHO2bxRjZIxKmYYxH1v4S6XGfDTyUUR0MqU/MzN1
         WiVsDrdg+sq399bkfVOzHOvbwVorkYbi8zgYBemRQDuPSfMZlNvmLW+nPD6jiQd0up/8
         tkbA==
X-Forwarded-Encrypted: i=1; AJvYcCXSmFwNIAnBqBrdInW3DhypVibOwNAnzagfyA7r5/D5UnRwSTlez5FUkcGOuOzu4DKdYjG2fjkZghPEOpu3bvculWwHAlmL
X-Gm-Message-State: AOJu0YxQFjRZ3wAyd6J+MNwi9+Q3/x2unEysTXVfTD6GB99bBrb0n4ek
	a9fhThAcMqQJRgNIO9ctGLaYsuKz3bfD2gXnRtgyWtH6T8FPsOb4WO75YGp0mFk=
X-Google-Smtp-Source: AGHT+IH5KS9jxvdp3RsDAsvuCZc0N0fgTdsdZg3QY/86f6UP0gzoD1ZV6mr8LDNb/OGbu3UuCFwwBg==
X-Received: by 2002:a05:600c:310f:b0:41a:9fc2:aab7 with SMTP id g15-20020a05600c310f00b0041a9fc2aab7mr2423775wmo.38.1713880053916;
        Tue, 23 Apr 2024 06:47:33 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm24325730wmo.5.2024.04.23.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:47:33 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:47:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] neighbour: fix neigh_master_filtered()
Message-ID: <Zie78Ie6iyIQb0JX@nanopsycho>
References: <20240421185753.1808077-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421185753.1808077-1-edumazet@google.com>

Sun, Apr 21, 2024 at 08:57:53PM CEST, edumazet@google.com wrote:
>If we no longer hold RTNL, we must use netdev_master_upper_dev_get_rcu()
>instead of netdev_master_upper_dev_get().
>
>Fixes: ba0f78069423 ("neighbour: no longer hold RTNL in neigh_dump_info()")
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

