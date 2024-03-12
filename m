Return-Path: <netdev+bounces-79441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34128793DE
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 13:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B040B212AC
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FC479B92;
	Tue, 12 Mar 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XsIkcYpm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC679DBB
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245607; cv=none; b=YtXJezt8NcrqbJIAbFMg6p1b6Q4uFKw+Dx1kW+6I+jb/dWEPs8ypapG3Uen81GedhN3Jwh1M8nDmnTYgVWdRaYMTEbsv1m912X/jXa3QQnULDs4Z2wFYtxMPKRgu7suqtOGpWb1ytgiHdzpY8uUtV/vjZqKoRNwlJStH97GQbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245607; c=relaxed/simple;
	bh=NtXlbKnL5euhiw52oyQxA4wkkiqfbzjgbCHftvNmB6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8FLm25GxoxmcCfm7J5kBOyFjeAn6FYzsFZgsPvjR4KSHcsbkHq1A/Ti1ApLSg96vd9hlhE6HQVeq0z3ujuG5IYVhYr8Kmus0LFypdLTXztY7wDRtjPvtPpWdYIuHkMYjwJQeVnI0XKgriLG0ttIJvN8Nw77p23QGrsrAAC1sGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XsIkcYpm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so6054631a12.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 05:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710245604; x=1710850404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtXlbKnL5euhiw52oyQxA4wkkiqfbzjgbCHftvNmB6s=;
        b=XsIkcYpmAB74HJN8LsYIXHJg/B3a8pwyDYnciKdbMKFpUIj3+SbujzFlVHyQiJV2fi
         7EniJnKPPr6aKtzTzMZKHp5WtTso24nmQhtpl0qBM5vVU4kk3YcoHNZduogoOcs6CiBx
         jEV2rHevJTQMHIJWAiz6VPRBLEZPVcOx0oPjTvQ+L2hWPqU2aki5qBRPng35kmYoanoJ
         R0xd2iqdHHiX/EleX0gHe34J1P/pbazsy2FGk6H/rXH2c/hsITriCqX2BhRXNpl2jtL4
         Yq0mho72gsKjGoTqQ+3i/2YUJ48XNgWCV+Ob7qiBNJ4ipIIhR0PosTMrOfY9wG/nh4C7
         T15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710245604; x=1710850404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtXlbKnL5euhiw52oyQxA4wkkiqfbzjgbCHftvNmB6s=;
        b=nSJHIMCxIUM1QTmETrWysZtcI+1/TU7jKhwtSaQF0kq2BfKZcXHAh83qyAQEmHLb0u
         kOv7cn1py8//hYz/iaTY14KJcuUyIn3BLZxLhkQA4cVeZcMSopAcKIdixxH75okGt+1+
         RlJZO+DRfl5cxwcEUWCwetdCdID+kcYmJAhKAqXFKY3oXsXzWIdPNy5NWQU7reO8Ocl5
         rVRc/WY/BlLUs5pSeUWfJY6V9flZaD9xPECgujkv3RhqrfXCHA/yI8zADPCTL41fB6hS
         j4ii2Vm7PVs4b8oNFKKcGOFhcxpEUAp0inIxak5eLqIFNXQCeY09X3e80SS9IRX0Dpuv
         ylAQ==
X-Gm-Message-State: AOJu0YyhwMNwtLM4bKqdh0AwV6jLmi02nj3R9NsJCs8/r9BKzvOXnfRt
	a8tZmoQ3ZIgVVpTbkfTSMPKOa4tCFtTzPJsJqVfAxAXn0Tbw/CjXNLYPp+nY7wg=
X-Google-Smtp-Source: AGHT+IF/p6JnFr8eUGfWti58rQ1XC4/IDWOdST/E6IMJoTZDitucNFt2DifeeGEmhFfYxXInhd5HtQ==
X-Received: by 2002:a50:955e:0:b0:568:1b18:1d11 with SMTP id v30-20020a50955e000000b005681b181d11mr5543751eda.41.1710245603495;
        Tue, 12 Mar 2024 05:13:23 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id et3-20020a056402378300b005687a473947sm293645edb.28.2024.03.12.05.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 05:13:23 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:13:21 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, jiri@nvidia.com
Subject: Re: [PATCH net v2] devlink: Fix devlink parallel commands processing
Message-ID: <ZfBG4Z8Jd54QJl0G@nanopsycho>
References: <20240312105238.296278-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312105238.296278-1-shayd@nvidia.com>

Tue, Mar 12, 2024 at 11:52:38AM CET, shayd@nvidia.com wrote:
>Commit 870c7ad4a52b ("devlink: protect devlink->dev by the instance
>lock") added devlink instance locking inside a loop that iterates over
>all the registered devlink instances on the machine in the pre-doit
>phase. This can lead to serialization of devlink commands over
>different devlink instances.
>
>For example: While the first devlink instance is executing firmware
>flash, all commands to other devlink instances on the machine are
>forced to wait until the first devlink finishes.
>
>Therefore, in the pre-doit phase, take the devlink instance lock only
>for the devlink instance the command is targeting. Devlink layer is
>taking a reference on the devlink instance, ensuring the devlink->dev
>pointer is valid. This reference taking was introduced by commit
>a380687200e0 ("devlink: take device reference for devlink object").
>Without this commit, it would not be safe to access devlink->dev
>lockless.
>
>Fixes: 870c7ad4a52b ("devlink: protect devlink->dev by the instance lock")
>Signed-off-by: Shay Drory <shayd@nvidia.com>
>---
>v1->v2:
> - Simplify the code by removing the goto

Indeed nicer. Thanks!

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


