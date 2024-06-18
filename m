Return-Path: <netdev+bounces-104364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058F90C4C0
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20641F2279C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F0F14D28A;
	Tue, 18 Jun 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="P/xbJ8il"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666A7FF
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694959; cv=none; b=QZLBgRfVTHv/syzV3osky0HISt68uQBkToPgiQPHaSNrKK8slJNq3xsvuBg5bbWSBUhAN9mVjBhJQe7x/51XTHUtkHV8YFycbm3RwoaCFBFlziCfX36a5LdmBa9gw1LBt8f9vBEtxk6mWQdF3sGsc3nUkEhM1VGN9vQV1/Lt73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694959; c=relaxed/simple;
	bh=LR46fvPDXRAFJZnUi2eG8g8frewMaWshY5Et6iXXzuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0DE0ffwMb7rLRfGXqx6XvwCDCVu2D7tCR8pTchxaqiVhGl9WhTqHQks7X5TscVind6lSGn2IUalPi45ZY0e+m8Y5IctDS8jfqXckSM9CBGfdwtw6pZg+7AgCoreoJFEqd6lfixGzZ+xmJGVm669rDfUFRVQsu3B1ZwN+z1t1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=P/xbJ8il; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so36306795e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718694954; x=1719299754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LR46fvPDXRAFJZnUi2eG8g8frewMaWshY5Et6iXXzuQ=;
        b=P/xbJ8ilkc5mu29lOYI4YuYtalZqO/1ixkN5YXzOWBqbX+RloPTZCupYUrpHA9MH22
         wOnGyMhFJNl7rRlHp9qduawYywx9X8L9Wbl2P0MDL+ZnvGbypqxKrtYkl/LxEihsYHKy
         2biwdZ/a5+f29jrhoNK2BDiRkVD7eXK0xKYRcBKupJj/xyqJtFw8xS8Nwk62G2TWAGX5
         2mi+d7j/+Cn//fLGYsYv2dUWG8M3dV+M7/tbevV1fRVcmGDT7gp17MpMRCPu/z9OohMr
         ienfre13eQdQBkjZ6dWDpMBfTiAjNGPpIPDqUKlH4SYS73UJpT8Y1GUpBxCqfYNnKzHE
         v1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718694954; x=1719299754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR46fvPDXRAFJZnUi2eG8g8frewMaWshY5Et6iXXzuQ=;
        b=JU7BJVcPc3mWqbmlrmsHn6kN+z4TqDWgIVLGqLN5MYwOsg64+6gqXvy73DkiJJzCn3
         1PKP/IRzF+Yk/tYdejWTjjOuHgZun8Iz8O20a/bbADAYArfQ0BYZMDS+MCKwBMgfYBVz
         pQN2urKnnD2OJjBxjmqYQPn+B7cGkE/arHNXTjQ/kineJc3cbE+/AMg7bbYppyPNm4on
         +iT3bmxdlLZYSf5yyYOnUystpfneDAOjIEqeSutnwyNcWfLNjJuT0WfnOijEzC1FVtMA
         qIUtqdTIyJY+pGw1OWRl6u+PMny/x6QNeZfHDwSqN5pr/mXkkv99QhnvWbIOjxj3spNN
         iQJQ==
X-Gm-Message-State: AOJu0YykikkrxmrHwZ/nAv36QIKcYXwscxYYUeC/TLU5UzdF7R7qHTn7
	ZdcqivLEyV1dq/rMYJHfnCU0nYdQtpNmrk8l7x+Upp72aKz3NPvcU5b9yx0jnfFAsGfyLctVk5x
	cCFqtXQ==
X-Google-Smtp-Source: AGHT+IGgvYf8B2Q8SDyi6A0PS2z5dLnqGsNqC9ZdPEqFXXjuxu26rZ0EcHJSx2tOqx8ugmql2+Zcmg==
X-Received: by 2002:a05:600c:1608:b0:421:bb51:d633 with SMTP id 5b1f17b1804b1-42304828e55mr102119325e9.20.1718694954090;
        Tue, 18 Jun 2024 00:15:54 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c70sm179816995e9.30.2024.06.18.00.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:15:53 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:15:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] virtio tests need veth?
Message-ID: <ZnE0JaJgxw1Mw1aE@nanopsycho.orion>
References: <20240617072614.75fe79e7@kernel.org>
 <ZnEq3YxtVuwHdFqn@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnEq3YxtVuwHdFqn@nanopsycho.orion>

Tue, Jun 18, 2024 at 08:36:13AM CEST, jiri@resnulli.us wrote:
>Mon, Jun 17, 2024 at 04:26:14PM CEST, kuba@kernel.org wrote:
>>Hi Jiri!
>>
>>I finally hooked up the virtio tests to NIPA.
>>Looks like they are missing CONFIG options?
>>
>>https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/1-basic-features-sh/stdout
>
>Checking that out. Apparently sole config is really missing.
>Also, looks like for some reason veth is used instead of virtio_net.
>Where do you run this command? Do you have 2 virtio_net interfaces
>looped back together on the system?

I guess you have custom
tools/testing/selftests/net/forwarding/forwarding.config.
Can you send it here?

>

