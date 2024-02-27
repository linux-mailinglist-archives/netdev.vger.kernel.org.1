Return-Path: <netdev+bounces-75306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980EB869124
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C34285CA7
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28813AA28;
	Tue, 27 Feb 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Bs9bXVnZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9513A892
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038801; cv=none; b=WidzQ7jHZ2W6KgBPVDZnVdnPOhjBTwEQ7WeyVlUBuU5/ZqPmCq5iulIu27ndnjiZFNM0PY77LnezecX9c1/R/rIv9E7YLv9YWG7ueJs5HO1st7ltTi3njOEENJaQtc6kPRv9CwDUNq+ig3VB99PczyUXfa0LQS7kd4VdCm5pfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038801; c=relaxed/simple;
	bh=ovaRdX4Ft/nqA8QgoTs7FgTPj1fesS+2IsaHjXHeIeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPW9Uj+/r0Pa0ggac+gz/oSWLtOBbnvpca/vje/0rhbWhjBlRFcl8IvJXarNXb9WmQQfdQ9Laae3VXQDnZ2lrH/ALBZzKh4o2UZglZ0crG6+rmMY335c38lteas7ptYe+7vwY0DUU1749//gP33Z7oSqaFkCrc0pPmNI636I4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Bs9bXVnZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4129ed6f514so20121855e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 04:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709038798; x=1709643598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovaRdX4Ft/nqA8QgoTs7FgTPj1fesS+2IsaHjXHeIeQ=;
        b=Bs9bXVnZ64jzw8RbuovUcnoMUl5GSxeOdWFyOjM1P8FV3WxdHrSoOB40J9cVUu7+UQ
         QsfGInK2SqhjRHWdW6zMxu1iEOYLnaT75qm0cXFQn49COhPJk9ENduAWlBXbMcgVds+K
         ByLw+O7nWOnH1eLh9KMfcruqhl/ODUg6ZlO3wjaQKCyVNvm5EsNo9+oGIpd5qvQUs/IA
         utgqQDqwStEv4UExTxuN6GA5PrwqI0U45GOVkiYNztfeD8MCBieEpbNTEQpFrYUBjxmW
         KU8GIM2101UEsjE+aZuC27M215iX2rZ8ipbm1VvUreia7TNLkkLz+qJbsc+FI+8Djlez
         PeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038798; x=1709643598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovaRdX4Ft/nqA8QgoTs7FgTPj1fesS+2IsaHjXHeIeQ=;
        b=lexLGLQFNv4u7gGsRkmGxbnu4y32VGuVwMLJTfruVoliAHeC/oxRGDIdC4aTBaRGtA
         XgqP8+aWNP0tF6S0oXwagSOERm+0DnUABVDHPBKLrlWPFe4hqPdX8fsy/4dCtk9GtW31
         xmkPKDQIQIdX9kwzA2Bhs9etg4rkAeuMw1KnplEYaxQPwhETypTrO/SlHYOrq7E4egck
         J6OfvG0EYhQIVvykdoC+IjtwnE03d5JtYSxajIUviVMbhFixfHIs6PWbETYm+Bn2qP59
         AyyWRDJvRR9eVxMXYr3Fn8WP9Q8n7Tq6qFQnGs2KtWOi6IqoF7raFs/G8MVgU0b9H0/0
         sRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW25017fHx4UJorhnaptwfnAarujq1/YM4wUV72Ur8VI1zsjpi4PaCCiEn5j9bjF8JkejuhXrZoSXbpHeZYITkM1lsrOoVf
X-Gm-Message-State: AOJu0Yxr0VC/CJSeW6iG9gbhE9hnZiMjbMzk1PRyW299UEI7Jd9yzJAA
	YMuGmi+j6R2joLCbEJIwdQNAA5AbKj6vBlik6UjDF3DdF00lG433VM6PF8BwNOU=
X-Google-Smtp-Source: AGHT+IFpfTs1S0z8gP+JBVqFIKvOQn5tAhHTfAEc7lTJ0aDLS5mtBPqKmd1ZAoaHPbN1GoYT9Sml0g==
X-Received: by 2002:adf:ec49:0:b0:33d:47c6:8f3e with SMTP id w9-20020adfec49000000b0033d47c68f3emr7069913wrn.41.1709038798246;
        Tue, 27 Feb 2024 04:59:58 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q11-20020adff94b000000b0033dec836ea6sm2034001wrr.99.2024.02.27.04.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:59:57 -0800 (PST)
Date: Tue, 27 Feb 2024 13:59:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/3] inet: annotate devconf data-races
Message-ID: <Zd3cyle6THMPQb6f@nanopsycho>
References: <20240227092411.2315725-1-edumazet@google.com>
 <20240227092411.2315725-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227092411.2315725-2-edumazet@google.com>

Tue, Feb 27, 2024 at 10:24:09AM CET, edumazet@google.com wrote:
>Add READ_ONCE() in ipv4_devconf_get() and corresponding
>WRITE_ONCE() in ipv4_devconf_set()
>
>Add IPV4_DEVCONF_RO() and IPV4_DEVCONF_ALL_RO() macros,
>and use them when reading devconf fields.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

