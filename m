Return-Path: <netdev+bounces-80140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C350087D25E
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 18:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6CC284DC8
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0124CB41;
	Fri, 15 Mar 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYBQNYMY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380514CB3D
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522176; cv=none; b=mWo8Vwh+aznfGsfcF1y2FiibbiP3WdU8wXHiZ2KKoO5/+QQc7M2X9u8HG1/N808eHBx7EWVP5jwreOCLI3Sfl0e5GKC6rKLzsupnNHTQLRm7A/2R7+pxF7lwx9w/l6eT/hWbRtpjs+o59uJJFiay/9Io1/sAunNqfPhuimBJb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522176; c=relaxed/simple;
	bh=vZzetsUftfAAAXCYiQT8pzNgnbC6mGGUoLjZtsV00ZU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=cr+91Co/fLqlW7XTeNiy/b13Dkx3pOuYR11fO4FCEV1oKj9M9hvOS+Sg4q5RGvAwDOhESmGRs+G76ZD+Hv0XF5tSTNt16r4qsGGj44OgsXQxjNYx10LYfeQJSzBHaeMfcOn9XFK1K5ZWZwYu/8BH0DUShtY8AdSD9Q2XTuvSA8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYBQNYMY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41405d77c7bso704415e9.3
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710522173; x=1711126973; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZzetsUftfAAAXCYiQT8pzNgnbC6mGGUoLjZtsV00ZU=;
        b=jYBQNYMYWorIHoFH3pnUk0E9v66Qt1vBb6SXqAAg+brwtD3f3e9KqfS/SXKEJtax2J
         Tp4KU8ikPvECRJ3QgP3HrtX/A74TNXBJLjXYVCdB1idEyfPy/dJcqxFYwz39A73cV/7A
         r8jaIeTR+H5J/BJwsIs5tiMdB7TePgshSVMfY/w4hV4esSjFzM2dmtrIb/IlHcNSv2c0
         4zOgmNu8jEHlBJ4LuCt/s5bfUZSemYCB0I7hvrS0c87Gs1TQkdI1E65ckuhA97PG2jht
         PkDar+fU525BIn27zhIaYP3Cl7z3/5CUP5Wi8/lWDdcxje+vBInOJEn7c3gSiqAHwdHw
         0JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710522173; x=1711126973;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZzetsUftfAAAXCYiQT8pzNgnbC6mGGUoLjZtsV00ZU=;
        b=G+HNBOfSceV1hjCPnrSyBiN3f74bp3IK1bGknbXhyJI8hRlw2YJVBQMFNDKwLVP9dx
         NZj9HOREtU9o+/cLvrZ8z0cPaGgqgRQN44DVewNhH/g777DF/KUIXB0pgRk5czRD1psy
         qH9gAeXmZyh3EVjwA7K5oi3DWCGC4RFwBzcfhIdo90/laDMW3lbSj/eNSqKG//NWotkO
         2KxC4eMv4Hhy3BzfCbWLe+beIa1Ou6SMMWoYyQXRsHnCmxAbBSlElV9WrTKPtYpMeQBF
         lFaAhB8PWyS82WEOp4y6B/bzIl71KoIeTHgqIiGhs35ZxiLldiW92NLVByfo2UT3T5Cc
         4slA==
X-Forwarded-Encrypted: i=1; AJvYcCW6d+Efq/LMu07KSq7XX2JWAdRdnhCS+umQEJj68yzp7NcGidipSjrqtAM7jIR/LY9K5FN+WW2r8fh9/gvcUXnvZexHu0wP
X-Gm-Message-State: AOJu0Yz7fN/4+5gikaUYA1LoDLz9eNKMNmdqo7CrtPuFgEc+TTFjIRIP
	btK5IRm6mc3odKb4rJQh+QZvQYtIMZ1ZF4pc27qSHpKDpFwRrdxB
X-Google-Smtp-Source: AGHT+IEp7zUgChknNCZpLB4493mzhmpbVuGL94J+aTvBzuTWiLECi1moVDmmZQDcq9xDBWTLd800zA==
X-Received: by 2002:adf:f548:0:b0:33d:c5c7:459e with SMTP id j8-20020adff548000000b0033dc5c7459emr3996926wrp.12.1710522173274;
        Fri, 15 Mar 2024 10:02:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:f0a8:4bb1:6f3b:c650])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d42d2000000b0033e456f6e7csm3642684wrr.1.2024.03.15.10.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:02:52 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us,  chuck.lever@oracle.com
Subject: Re: [PATCH net] tools: ynl: add header guards for nlctrl
In-Reply-To: <20240315002108.523232-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 14 Mar 2024 17:21:08 -0700")
Date: Fri, 15 Mar 2024 17:02:24 +0000
Message-ID: <m2a5mz2ztr.fsf@gmail.com>
References: <20240315002108.523232-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> I "extracted" YNL C into a GitHub repo to make it easier
> to use in other projects: https://github.com/linux-netdev/ynl-c
>
> GitHub actions use Ubuntu by default, and the kernel headers
> there are missing f329a0ebeaba ("genetlink: correct uAPI defines").
> Add the direct include workaround for nlctrl.
>
> Fixes: 768e044a5fd4 ("doc/netlink/specs: Add spec for nlctrl netlink family")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

