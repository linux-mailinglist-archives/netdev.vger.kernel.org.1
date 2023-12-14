Return-Path: <netdev+bounces-57329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922B812E44
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FF42826EE
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C25A3FB3D;
	Thu, 14 Dec 2023 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAqtB8Yr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676C1CF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:39 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c236624edso78999225e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552358; x=1703157158; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFTydzo7bM7H6NP0u8Qs394FXodgFucpjQcRAhdEirM=;
        b=TAqtB8YrKrz+mrKAUpmZkOAOs0gM1VcGgxb+dcbKTbc10ZqNnP+yxZffm6EwNWB+PC
         WeICrVoGz52iItLHyhMnCNUy/X5zjVvTYu6y0Qa2XfFR44lwn5JQffSXd8dadp90rwjc
         qGsI7b6uk1IoEjrPAK08WcIplc+P9Wg8u8SKNgFWHdWUfWazy+a6B9KotaaSbM0j9AUM
         KhVJN7CbHxqQrnoR5Do2klHaMSfKHgkaB0+0PEnuFXAZHmSPuH/rxcLSzj3AjpWBgufU
         HClEoxBVi94VbB+s0bXUgwSAy+vygNS7/XIt76ZHPfTE1kZbjcnUx3HBaEPAsIP6mUyr
         yDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552358; x=1703157158;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFTydzo7bM7H6NP0u8Qs394FXodgFucpjQcRAhdEirM=;
        b=S6YwWC4uxpeIDcec6uux3HOXezgIiZIZNSD0IQqLIv8zoAKbnrSH1QonNlxMnstFMz
         hZtHq11KMl8WX9AKylBchCarXCWYr03hvy6hayw8xAKRtgRqlxIBdC/NCd/kyBzTtTYB
         fFRvhqerOeD1X2jDVOa5UgP+Od/wGQx+5f8Fn1qTI8BZSFOlANnKA4Tda1RkZbJ2oeOS
         ET9nNmfXiOCv43bUDW75YIDUs+ZjqYylXL5tTtUPhwiO7GMzTFvEo9hWseIStS8UYPW8
         ufc4VIk70S53hkahPQwc0mtN6jK6TmA6CWIBEW09ZR8eBJMp0xXTeQMCZ7rzBA5G+IXp
         KzZw==
X-Gm-Message-State: AOJu0YzCPnAs4FVRhsVHKSb6LAbMMYZAfUJ1JTOn+Di5UjCSqegPaPOH
	qJ2jYgDohq/dfBMMzkGmlrI=
X-Google-Smtp-Source: AGHT+IElpJCkbsxftEE5LZQCSuqz21vlc8Dvy09nV5mFfWZGrWyHzWKIMBswgFnThcRbZGRSuWQ8aQ==
X-Received: by 2002:a05:600c:4b1a:b0:40c:31e5:49da with SMTP id i26-20020a05600c4b1a00b0040c31e549damr4772576wmp.136.1702552357692;
        Thu, 14 Dec 2023 03:12:37 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id s5-20020a05600c384500b0040b632f31d2sm24554610wmr.5.2023.12.14.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:36 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 2/8] tools: ynl-gen: use enum user type for
 members and args
In-Reply-To: <20231213231432.2944749-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:14:26 -0800")
Date: Thu, 14 Dec 2023 10:26:32 +0000
Message-ID: <m2bkat5bc7.fsf@gmail.com>
References: <20231213231432.2944749-1-kuba@kernel.org>
	<20231213231432.2944749-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Commit 30c902001534 ("tools: ynl-gen: use enum name from the spec")
> added pre-cooked user type for enums. Use it to fix ignoring
> enum-name provided in the spec.
>
> This changes a type in struct ethtool_tunnel_udp_entry but is
> generally inconsequential for current families.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

