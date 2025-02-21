Return-Path: <netdev+bounces-168614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F45A3FA9B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4211116659B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE71DED56;
	Fri, 21 Feb 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPyvOwl9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2F1DA612
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154041; cv=none; b=CoN2E/14bx56fF7gcc31C+UxD6fBCjo1ntiBaQSqgwzJ38g8+LSwhHA58XhPKKmEcbS6VyF/wAUTKVFp6yUSp8UQ4ICMAdijTGfTHJfRs3H2y6wHu6fexazqDuYl4/Cg+KdFFwDHYJT8lbjndP+KipbXDZqEf3kigXH61G+NYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154041; c=relaxed/simple;
	bh=q4l34qpZTx/9O5LB+D0uo4tPYFmZT8rgLfrdKXwreY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkjD9cUFCbs+QiHXYGDLD2AV6uIfDWsbGuC08aDmRBKeSrmTG48cMONoFokQ6IrwNnnK7DdOCoXsQtNVxR+Bx93OwSK5PmeETSLAA/F9Py4WUDH5uU18cD6PvnRlYB3o3xdexaCGY3q73r1klKymwZod3O2HZAxNCg3p1vjN6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPyvOwl9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c8cf98bbso50930345ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 08:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740154039; x=1740758839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zB9eQcerorxwkRD46pnTbR3ZyvJHq3Q31qAtEjpzsKQ=;
        b=FPyvOwl9ZxCdj0OPKmLkhRTP3da3j83KrpOsc9ETUxtjf6KqzhLqJkA6sO5ENRxpX0
         +rt4RjiVbSxpdtm0gbWSP61B8PP/inSIknuzukjixbjaca5I68xmKav23dV2Mm3MQm3F
         ALXGjyGB8stt+SlO/Kb4xs120gTNEVokuJr8RShdsufVt7JaC+yNaNXPjiHuF80g5m6s
         VHv8l7DzNWYw9VsikXqAqhz9V0Sp3dblMco25+k40mqRwKLiml/HgAFTtE6U39U++b1A
         i57ICH5jbWBc08QM3tH4Hqj+ZBqsTNTJ/CXAodY+y+EWhWsFljCH3xdTfIZ3lBnI0+V5
         FvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154039; x=1740758839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zB9eQcerorxwkRD46pnTbR3ZyvJHq3Q31qAtEjpzsKQ=;
        b=kkEosy0V2v0CSBhk+IVsM/JkzE8AuIiuC3Gca4gV6CV6dWSnV3SoLuooBWDAFE22Sx
         FBg7vWKyshwKT/ibOAjLTHJEZlqqSFHnhlBQat7NNnVIt4W2w4PlOkJhir0AE++EDYxe
         n1j8wk13Oyd0LXUa79gmX+VQhVkrfv8VgZ2ZZoUhOnW+TJ06hvRStyLMcsmH9fLjb1+o
         PyK6MV2/Jygrcmaxfhb287PGOHynqmvg0OG/E8UfDSpCxvDsKWHoqDztGlNfeaT6yna3
         Q54/cP352Wv+odkIEPAslG/DBBZWCWbK13YwvN+aegU+d0YqmSgme2iM/jMv/03y1bgt
         GfUg==
X-Forwarded-Encrypted: i=1; AJvYcCURu00WfS4NMoCTQshk6xzBxb85Srj8D0zCau9gvw7aMTsKC2GeQbV/jpv9Yh+WR++HBCZmN28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFORo2BF8BrPU+4PeWC5L7KpUEXjTSgWbXmjjYrhPpJO9CeER4
	QxNcCbMYL0Oo5hzBzthu/JF1/hYnuT+xTKRG8pGoKAkPhUtZjxg=
X-Gm-Gg: ASbGncsXEdkvyUBHAjLjjuGKNO7rmeye6sWisW0cM+ODc6V0P55GyaKXJu3cC2Akxtr
	/YfLcO4WX8/iqAr/bLWCY9YQPSOvzhbHWz6PVR9QB8gfH5bP4LqEZ3OpMXfPni4T9T0s53hBnoM
	FiWusmgisZGoJX0zJxtoes9Xjykr2p/UvsujpIbznDmb6mxRi+MPrNix+dnCa7z+rvAbJ0TsZy9
	oKmkw3OnkcGvs3eJa7YQYrhmydilfU7YksL3/XcBuq44UsZqqZp8QfddRKctkatshOuwD/yRkdA
	ZNNq3adC1PN75thhyd6oar1GSg==
X-Google-Smtp-Source: AGHT+IFSCUu8lpEO7R9DLl3Ue5JHm4VgMUU7R+vSDdHVAfJZ6pvyZBlGj61auGhzphiKnrHdaahIMg==
X-Received: by 2002:a17:902:d501:b0:21f:dbb:20a6 with SMTP id d9443c01a7336-221a1148f3amr43234135ad.33.1740154039030;
        Fri, 21 Feb 2025 08:07:19 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556d6a1sm136733065ad.179.2025.02.21.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:07:18 -0800 (PST)
Date: Fri, 21 Feb 2025 08:07:18 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dxu@dxuuu.xyz, michael.chan@broadcom.com, ap420073@gmail.com
Subject: Re: [PATCH net v2 1/2] net: ethtool: fix ioctl confusing drivers
 about desired HDS user config
Message-ID: <Z7ikttkCnaW_rajB@mini-arch>
References: <20250221025141.1132944-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221025141.1132944-1-kuba@kernel.org>

On 02/20, Jakub Kicinski wrote:
> The legacy ioctl path does not have support for extended attributes.
> So we issue a GET to fetch the current settings from the driver,
> in an attempt to keep them unchanged. HDS is a bit "special" as
> the GET only returns on/off while the SET takes a "ternary" argument
> (on/off/default). If the driver was in the "default" setting -
> executing the ioctl path binds it to on or off, even tho the user
> did not intend to change HDS config.
> 
> Factor the relevant logic out of the netlink code and reuse it.
> 
> Fixes: 87c8f8496a05 ("bnxt_en: add support for tcp-data-split ethtool command")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

