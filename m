Return-Path: <netdev+bounces-68426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61FF846DD4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E292901B6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E627A70D;
	Fri,  2 Feb 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O2jZOXpC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961895FDD8
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869462; cv=none; b=gQPSNXQCgnackTxYD+x6GqzAlKLNn7pn4dMVsztSnlnDFmcvzejfZpraqSEx1wQPreOhT7JLZa2AtTiL9svBdQvvI0BNpIApIfMQNedZdX6NPncHgiJi0Rdb25SigSlYeW2+GsOQsyqJHGR/3tD7s5XRXfrtjVx6bXKeM8UR8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869462; c=relaxed/simple;
	bh=ul4MDZdUkPZs61RD/ImvWr1Ox5ZxT0jR5CzSomsFkWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT3btZ5Iz2LYK+qEA7vEviVBp0CBValPHd9GI6sDLqqi6uNJ0+qh4Ft28k3RrLqF0UXuaLEdZKzfq5hwNB9P3cBmQUHdY75roMAkYDY0NChZsTYqYx5PfvjQ5EPdCSIXUV61To5ZRmPSRhgAdwW3J6Hw9fPhwM0jyxoWuGu+DLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O2jZOXpC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso4843175e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 02:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706869459; x=1707474259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ul4MDZdUkPZs61RD/ImvWr1Ox5ZxT0jR5CzSomsFkWs=;
        b=O2jZOXpC5B97Aee/Yb6ELNYOvRdFaVY8LajBwT3sAi6prbli/aeWLkJmsc6WwZIRUM
         PcU4Z8s3Pi1/zxqTetz7acXndPKOjFXiVGKhGmuUJt7lpb0rAYuy4pTlbGZhukPqZc84
         uvNqGPQDAlHWBEii+ih8mGNlb8wzRuq1EzeKOoGv/5jUB6VDOgUdhOiW9PQICvfmEJvt
         IG97R6Ubu81JaXlZSnAHu85wOCepPTHx9/tYCMhDMGhXHDMiWqnaSbSJ6VFJN5cZ3k0W
         7cLRbW8AP+9uCWSCW0c/+++IHRx9RVxhuwf9rnjWF0IYtdt8I8WB/tiNQkIrQCgaZhvb
         4fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869459; x=1707474259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul4MDZdUkPZs61RD/ImvWr1Ox5ZxT0jR5CzSomsFkWs=;
        b=bgodCky5Z0/Abrjs0iTTw7qBvx5BQgmOFamFbMLfehX6L2+oD8AKzyfwPPmXfZ2Ufo
         8i4r5grMrn77ohrFwICoIX9mbpmE4C/2B5eCZCeCPLY9jVuqxHvO8H9KjXntsFgSspyd
         hzOO6FVj1ShBrU450K3TKFshqDKTXGqlQU1eTkn7Z/4laPcxS4xU1/assIJGrn0TVJ3y
         aqENDMs8pK/kKzHbdqZ/GNU/59zeakNDfOTCOX2UU77jHG0kMUUPaZ2Ynalb2a31agYm
         KH1wIjcHCVXt55ZlkVJSWzzX5E9cPtZ5zpgPqYhG/c8h2I969cmL0iGxYQIROk9ktdGs
         tfXQ==
X-Gm-Message-State: AOJu0Yz1p8eA1A0KKRdT/Na64kco617OwBimcaYLKdEUZyAyzFBZ9dez
	KiIwixcs46kZ2NviS12zAEz73WW+RCq2IMKoPnyEJax1b2088UV7Q6nfRg1ab3s=
X-Google-Smtp-Source: AGHT+IGEz82usaiTajChTXTEokmpra6MzWLSqCWqKRfjlTgN4joPjwEbCpUALCl6PTNjyNsdvTazBA==
X-Received: by 2002:a05:600c:511e:b0:40e:b93c:940f with SMTP id o30-20020a05600c511e00b0040eb93c940fmr1157300wms.28.1706869458705;
        Fri, 02 Feb 2024 02:24:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0jIn4Wu5TDY28WX50rBXC1Ju/COhCkTkHxGfVn5zdGO3kfCv6BsnvO6D/bX1Fmu+zvjZ3hOZltIpZje5o+Pef8ZYciM02jGFcuiKA6AVXiM/5lD7sGJwNxxtOKOwLWcFi1tHYmW+vCPXQGMHpC+7Str421d1hEe5+0YSd8c2WvKLVhmaZB3/vqlji2++RiNcbtuYjrvRveLEnHQ5dMPfW+8Lvkospiy+/
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c1c8f00b0040eea5dc778sm221405wms.1.2024.02.02.02.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:24:18 -0800 (PST)
Date: Fri, 2 Feb 2024 11:24:15 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com
Subject: Re: [PATCH net-next 2/3] tools: ynl: generate code for ovs families
Message-ID: <ZbzCz4RuiZh-2Z4k@nanopsycho>
References: <20240202004926.447803-1-kuba@kernel.org>
 <20240202004926.447803-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202004926.447803-3-kuba@kernel.org>

Fri, Feb 02, 2024 at 01:49:25AM CET, kuba@kernel.org wrote:
>Add ovs_flow, ovs_vport and ovs_datapath to the families supported
>in C. ovs-flow has some circular nesting which is fun to deal with,
>but the necessary support has been added already in the previous
>release cycle.
>
>Add a sample that proves that dealing with fixed headers does
>actually work correctly.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

