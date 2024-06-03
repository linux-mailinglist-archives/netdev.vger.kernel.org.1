Return-Path: <netdev+bounces-100215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE73F8D82AF
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61B31C2169A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EDF12C47D;
	Mon,  3 Jun 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="g3+XNBuz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D721126F1A
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418827; cv=none; b=rK/HiuvhTCxRB4eV4KKS/xVaashG5CEA9dvvkQrYKF5qzy1Qv1oDdzDQoqqZckJanygPjE3iH1ZMeNQy85ZNQ188ZW9O/6gcRw5SveHhc/dqRhuR2ItBu5RCfDLmSQF76F0YWJwLZ/O4/t56+oGeh0ay4c7nkV3JpJa1MCTt+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418827; c=relaxed/simple;
	bh=8rzxrBuaT9uCUeYvlL1cIBanvAVdK8Uy8/hC8Fi/esE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/OsbBqbOOPSXFrqWsOKlyFfIj8hh0BXYF4H8Odfrtd2yAIe1q/hdqrwaIdKDpqnfOpNtL6/nPmR4qUQ4C75YeprD6KilfiItKRcjORi8GUHowd2romfeicAq6/dsxeu1+Etl7P0XJ+WT8hGQUrqRLiZv3BDnBUJjAwRct0p+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=g3+XNBuz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42139c66027so10104105e9.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717418824; x=1718023624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNpD+hHTMFWI7U+mq2gErMhYo7h8tLmeifk0ewKOvm0=;
        b=g3+XNBuzCbSp7nnAdIFzYbqRyhzTej1jxz6VTYhbKK+2ohVWIsgs0Z6Gi7qfSa2Oh3
         5GLJ76ktOm6FFTN2qqaGx2nUno8FGFqzqJKKsDymmVlo/sotGjR2INl4WRuaWd5/rutZ
         BJuhB4f3eHCoCjARXqzuMF5HAuqR8Ua9sby1namVC1M7xqoFtbA+2ICRna8dC6+KGA+e
         HPfJIvlulvbWdBclqgv4emMGnyQJnul1MEE55q2dLWh+ljwl5mVP2uzNqIsXuXa2UMTs
         YqNGA2xp6zkj+5UTUCxf6ASkPXCpUPqJDH2zLK0XpPn6G3VBJX//DXZ2vzDSYIEtfEUB
         At8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717418824; x=1718023624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNpD+hHTMFWI7U+mq2gErMhYo7h8tLmeifk0ewKOvm0=;
        b=GcEDDmJiMvn5onnuabtqriPls7JA9uQNXd5Yh0nJwQU1rGSOz6oTw7kcxqZABa8lYB
         SGo+mu+mVHmZkmWBQjUoED3OBY39++9yGZ6uX1+a8gtp2KFbBA2zMgYGztgP9RS0cc0G
         R468aUl/XPJeHqRvxI0arouTX/miDXbb1zZMS7bud9jigVEzX1EqrxfIjpiazcIrgEYo
         fGIlhp2Wv0dtWeqgGBhSDiiIrRZ5y7hC4UpTEIIrQNSWqbGz/eCFGJXRfbdLRdtl5DLJ
         nx/WF3rShh/AbLWsNrtZrKIQLb5Lqt56jaqu6ASA7gTP+lr8MMkKTCbDT9NzB5g6HliP
         L48Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxz1h2mqZfPwsb36ml7COWfQpAGNNrPP7USzZ+O0u0aETHeXW0NV3tdEkwZhLRSBcDDgg/HkYNSo/EOrykA0MBc6an6T2z
X-Gm-Message-State: AOJu0YykFaqVT4stynytRHKPc0eTbEglICEv/Se9qhFTP/l+R4TG7wWk
	trWSYDPe5L/mLUJC8B2TZDULvBPirCe61ZenAb47Zpsqyj8R+dwukVI6HlpfB+8=
X-Google-Smtp-Source: AGHT+IEsOzIuklCyugaxK7FG0ztwJGvAO7VIwURTBe4cCiL2gDYbFLm+E/bk1RNjA7FGajo81wIWzQ==
X-Received: by 2002:a05:600c:4314:b0:421:2ddf:aec4 with SMTP id 5b1f17b1804b1-4212e09b9b9mr70764925e9.30.1717418824534;
        Mon, 03 Jun 2024 05:47:04 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8b8c79sm114367645e9.48.2024.06.03.05.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:47:04 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:47:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: idosch@nvidia.com, petrm@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2 net-next] devlink: Constify struct
 devlink_dpipe_table_ops
Message-ID: <Zl27RT29aHxmjAjV@nanopsycho.orion>
References: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>

Sun, Jun 02, 2024 at 04:18:51PM CEST, christophe.jaillet@wanadoo.fr wrote:
>Patch 1 updates devl_dpipe_table_register() and struct
>devlink_dpipe_table to accept "const struct devlink_dpipe_table_ops".
>
>Then patch 2 updates the only user of this function.
>
>This is compile tested only.
>
>Christophe JAILLET (2):
>  devlink: Constify the 'table_ops' parameter of
>    devl_dpipe_table_register()
>  mlxsw: spectrum_router: Constify struct devlink_dpipe_table_ops

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

