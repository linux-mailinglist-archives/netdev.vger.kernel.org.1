Return-Path: <netdev+bounces-67153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9366B842360
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2270C284E2D
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645E667A0F;
	Tue, 30 Jan 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N7haPUUa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73ED6773C
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614868; cv=none; b=HbMHEI4JdnCwbEqwzdoAKfKXvOh9GHk5RtWHFeZLc2n/j0NwjPRuRoqvQD2gAZ1hoPWHNtRi2/AC8TOowM6EgcvGNJtoH23o4pkLIjFouzgdSuqnO4ldwTIYiSXC8t8aiScbYlhHSBbvyjYaBkViYaiYP6p/hN8zqaMTmCDJnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614868; c=relaxed/simple;
	bh=YQMnC45etVyOp/+1y9LRInFeD+wNmoklMnXVu/v0U8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG5a+Isjrfj/auEUfz+gZ/yGZzs5jzcyosur2gLvKjx0h/LMsB0H8FCYnIvu0jNbYsvZJUi4crI6VLpXQbCBEsvvQwhrWSwGcAgs2uqDH5Wmf1oujfs97mbAYdlk9ZkjUD3gHgNtWY7yk4siZDd4lCjwPcx1QS5YOg6SqN2UDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=N7haPUUa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso52069955e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 03:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706614864; x=1707219664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQMnC45etVyOp/+1y9LRInFeD+wNmoklMnXVu/v0U8Y=;
        b=N7haPUUaGJuv1NK29hrijE6o/vOwSsyOLp3RAoWryJvVaAkXBSsZEcczMHnXY4dFBi
         deioju9qgYcXD0nrpf6bBzHZNAxfRCv+dhGQ0plGSKP62iHd4s2JCrhG8Vf/N8IkubMm
         kUrD4ECfwWhqgemmtFlsI2yMYBR+xc4RyZ5XIh5hQAINWVxfGL59YPi6UwfnAhTfPo15
         GZUQXur2kdWW/iwfZVKzZxbviBGOLRd6iDr7HUuFmzGqKobSK54Lx5pPwa6yHo1/fKRs
         SP7o7PHRaxug8ouUJnYMtXCEiWpM0cAvtnQU7NLqgbrwn2gqj9GvxT4e+iEAlBFCSShf
         CIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614864; x=1707219664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQMnC45etVyOp/+1y9LRInFeD+wNmoklMnXVu/v0U8Y=;
        b=MzIH/TRqnCqVqxk/b5ubRXpiCmtPSvRGyX8MbFlBBWuHuspMm9IEAn9u9I+macgqGU
         qUEMbsA4TKz7uf9dvYvP3/z4KpJ5Y+O/vi9btewDFEsGgOvRtX6FyV/TZ4wlpus4BuJf
         WONDl8vSmc5Q0UQ1iU/UQCr8VB1UDoXLZrt6kmzLC3tSVWj3h6T00hZ6vGQnQvVOXNi+
         jAnuvfdoQAWL01DZbliHFK6+cM/ALaaGt+yVH58BFNRpD7/f91BMw37dZomAqqjvbBlo
         6+j9Xszg6qeAPQgasQS/jbFdvBcnd12nTGHYAboK2uIcKdbfdjpGk6OXMvfC9PvUeUla
         Vs4w==
X-Gm-Message-State: AOJu0Yy7FkQqiIeKMtYMdkaCQVsYd6J8gHWs70gHIbnu2bHMjl3SJ7L1
	nxletLZeHNIRTNYAKpcYPOqa41yCU7UnwZ2BSOXhVHdlDm+Inj/uV7SWbViK2YU=
X-Google-Smtp-Source: AGHT+IEq+rc2lu8z8/jor2yI558tOBoPXjJBa1X8VGaNlCPwTCHXxNVcqFBdtHa1DVREdOGaVnBd5g==
X-Received: by 2002:a05:600c:3b04:b0:40f:afc8:bb00 with SMTP id m4-20020a05600c3b0400b0040fafc8bb00mr256811wms.13.1706614863848;
        Tue, 30 Jan 2024 03:41:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWiHvdismbsRWpfrYLIx862dQhzzMwd6NglAUOPOid9mohIFsa6t9lfcIEPJLufpGT/91r0ybQfDvahzeBeo0Eclq8MfRxD5fz+f/P6JD3jXT6S95ruII9jAe1YXs+Yhmc/xp9DcVDD
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b0040e541ddcb1sm12944948wmg.33.2024.01.30.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:41:03 -0800 (PST)
Date: Tue, 30 Jan 2024 12:41:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
	David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH] ip: remove non-existent amt subcommand from usage
Message-ID: <ZbjgTXmNErUEqjUB@nanopsycho>
References: <20240127164508.14394-1-yedaya.ka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127164508.14394-1-yedaya.ka@gmail.com>

Sat, Jan 27, 2024 at 05:45:08PM CET, yedaya.ka@gmail.com wrote:
>Commit 6e15d27aae94 ("ip: add AMT support") added "amt" to the list
>of "first level" commands list, which isn't correct, as it isn't present
>in the cmds list. remove it from the usage help.
>
>Fixes: 6e15d27aae94 ("ip: add AMT support")
>Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

