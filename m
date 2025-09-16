Return-Path: <netdev+bounces-223393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38BB59007
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C082D1BC2878
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEFF28134C;
	Tue, 16 Sep 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lGPYHXI1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1221771B
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010091; cv=none; b=smWRWkXtrdrVK6O2v3bhvNJz+NlYe5gMXokj481PfgSSKfo5mzg3pP+gQnl5iRGdy4KGLvcdEvnCnlaR88eMeaQJ2P6Pp3P0cf+wK/XFHDwOcWj9SugTqMBZlX8R9MnYmAgSbz+1DMwmJVmW1BHxmnqyhULMil0AKOc9pU+2zrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010091; c=relaxed/simple;
	bh=MKTbJcLjCW/fqxMN70uHFxtQsKlUBxG66gfkmkYNLMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccE9ezxBlt6tJo/vX2pYkAB6DR/1I/lwj1FzeHaRWKcAvBuTLuwDNZ5TRCjqw4fhfHCOYkfYKv3FxFeCPyBJCfCqyAFMLGglr4AuNr21ZesU2Jjq1/wqppWArkWkW1nJQNgNeEHHwTvuH17FcyMNOASxr8MsYeoG9ER3EsJgfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lGPYHXI1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so2238086a12.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1758010088; x=1758614888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKTbJcLjCW/fqxMN70uHFxtQsKlUBxG66gfkmkYNLMo=;
        b=lGPYHXI1A35HI4A9UNAwec3VE2P0dy+WJYFqvDAiKmH2qokbm11YUi2swPmd9V06e0
         F3ydnEL4v7MyEvw/kVAJdPupn2YILz+5l5SzCL+tkUM3qdcXa8r9jAFFgmzk9PeiKOgA
         AFA7OiXlDJuoWu5BMKqLpMVgzGI6hRIUQGqPhzgA8Q2ytczHbJtnjsduxcTJbij718sm
         kp7ypm3TL9zab8A/fkXVhfIDmaWtCB++mlK/afoM8vT0/lfmhme8ZZgDl9k29faeCWOC
         i3KP3KlLm7nRLLgMcPPx7BW09aqoLRxF8srj3fNFczPQvngJ1TS5WQ8hsqBJ4OP/dFqx
         c9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010088; x=1758614888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKTbJcLjCW/fqxMN70uHFxtQsKlUBxG66gfkmkYNLMo=;
        b=H1e+510QYRG3oXTZN8BsvDZoC7rhryfX8ywj5WHPfU0yzvNNTcLZgW3OOver9KFuk+
         xr5dw85zYATNKN06wa0ZZ8RKXXq9jsUqRxbSlvJpLnOezkOzWvEX3qgOEHB8x9DdJwMe
         Rp/LFl0SCvHa6FVlWn3TgM+AXLXv/bKpmYfyho4OCSvZ75t54SdX9SRIaL9gK+kVudVX
         SPbn/JB7vXzwGjEjlYXVcV43S8c8bcYYvO73a1+/i8uRhq4mEme+mD9Tw0VHXt1z2W2V
         Ggj7DziSAjq+gjpIbFgxLaSEWNb2JyyCG8mfMcLFrYUtlOHi4qj5lfUVmvFOj17l98Jo
         SYIw==
X-Forwarded-Encrypted: i=1; AJvYcCVfh76edbYFqbQUizudHxbG9Fn0G2/O+eou7eQLGtuG3MVWgpsJuP4t/ggUj5SCJwG7p6gH0l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwl6sB3xKw/+j/z7SEqDmjctQfQqDt/E24J34LwEjYpH0sjq2u
	bRneYCGtf3/l2H3ibeSB0FNy9A0H5jBuUVsgXRgIgfs7Q4rWPFATQYi5vKvB5GfM6no=
X-Gm-Gg: ASbGncscMqQ9QjFUcNAghVS1kqs4eYjKodlLHOoHPk7tkvcgcPp5s2YOfxqBTfNjOsG
	bAAhf783ZT6wn37kYeyJErci+sQ4OQZCANlxKgRhS9GEalOpI6y91j8GmvleJuAlBczM27Bm8Xs
	kltBjz2VlHHFrfJ5VLWTCg1kEgNyeUqKCRhfX13TXtq6kIhZqFG62aXznTyKNM6IHvcvuq3aC6f
	IeD2m4nwtzyRIe0X6JteUDocwfdlMQXkWfBaJr9P+vYJSuX8aJ4hwwRATFuaIqobz5wNXvN0Ite
	LSKH3fvTDDyjb76R/932QhprEdyCeIvhlQiyJKsnduU1snyhxFtpVB7pqzmEWDiChriUNDOiMi2
	koAE8c8dzA37LPqDwbcKo/Gc=
X-Google-Smtp-Source: AGHT+IHiA7pzhRGLyXgIXCLENujiL8QEpIiWV80zYUtRJoUbdl+04OsaBCFNoanpg5Y9cxK04kHKVA==
X-Received: by 2002:a05:6402:4603:b0:62f:6068:db4e with SMTP id 4fb4d7f45d1cf-62f6068df80mr2032807a12.32.1758010084796;
        Tue, 16 Sep 2025 01:08:04 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f2b2a8c38sm4957713a12.31.2025.09.16.01.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:08:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:08:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH net] MAINTAINERS: make the DPLL entry cover drivers
Message-ID: <i5nxymuun6x5nahiqcs2dcjk4je7b35ve4jbhoyk2tcxquutze@emtogwrmgc6f>
References: <20250915234255.1306612-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915234255.1306612-1-kuba@kernel.org>

Tue, Sep 16, 2025 at 01:42:55AM +0200, kuba@kernel.org wrote:
>DPLL maintainers should probably be CCed on driver patches, too.
>Remove the *, which makes the pattern only match files directly
>under drivers/dpll but not its sub-directories.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Jiri Pirko <jiri@nvidia.com>

