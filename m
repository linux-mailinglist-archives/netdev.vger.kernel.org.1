Return-Path: <netdev+bounces-80541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB8387FBBA
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB33B21965
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA37E7E10C;
	Tue, 19 Mar 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VXhS4Gkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EFF7D096
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843928; cv=none; b=VxNaoM+qeuGvIzz9Xbnh2fopRu2Ws42U2fwtIb9iJqOMfXeENmD4A9I8sZS19OeonMM8EZbfP0lwoBCL6Z9UGYjAqrXj7fEKF/rYltxMtoYaflFys6uk/MjRw70NQ8Q+D7R65iBDMI5CHwgwabDy5I+nTh2mDu5qcwrXpTsT+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843928; c=relaxed/simple;
	bh=OnBNIG4DWvyES4WjoqSTtsh1i7tgE0uwjYJgRmeTR+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg6NHi4UW28oG/oFBzFZK5DX8rpHU30uHtijJthhLHnfC41s7wWu2AR7QJdSpvDWmNV6ZV3I9Fu76l1WjSxh77r0/vgugQsIhMctdWc9mRBnihgfNEwki6k1xIE8wQ8tjbNlCQHo+1DtHOvqy3AY58l0ILjvwLiKyQFTkuCZvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VXhS4Gkv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41467d697a2so985485e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710843924; x=1711448724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnBNIG4DWvyES4WjoqSTtsh1i7tgE0uwjYJgRmeTR+M=;
        b=VXhS4Gkv3JpVyE0Jn3EMieo4GTcl8/33vRiFMufkr0q4oyPW/uxeH/AMhHNYYhpRLn
         40+WYzrxLHPL62UpHmVgTulielRsx/vdEIbuhbSa3ZZmCNqNKYuUQ/BJTnsLS0LpU0Mt
         vgfZBJ6Sch90t9/DMEzA7/vmuyA3S0zWmBGOEGphGLZkZg7NLlbG+6YTzf1ky/HIiumZ
         nT8lj6BjT+sojDywhI87dz0gFg4dHJ7bZqbfOWZ9BUexvOjAwFF48jRVEs65wvwCEN+Q
         f+AqgvwrBwnh5r7ImVDkRHoEfzPA3uNfZb7o8LLaN43kCqN3UAUz6oe3hWrFt/i6cJqi
         Ckaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843924; x=1711448724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnBNIG4DWvyES4WjoqSTtsh1i7tgE0uwjYJgRmeTR+M=;
        b=bpxTX4xsKXjEd+L6qEpNa9NZjZPo6+2D7knfeHZq7+9LLmkgoa/hqGNf4DFwJtNRm5
         lNgxoCH+AEcyiutVbsYOAicHXLNQC5ggW1sIW8bJdocAZ7koB2HT7Uf0oV0SBGm/dO+v
         CkK7bSd7PwNjwdN+575yLuXw/s1mcRTRTRCLjxtBjMstKzr5R3EZYXIskJ9I7spBbun/
         pxnK+KueEFPzpiQUtlLep6fof3CSA1QmHhrk7liUXvHyBtwP5FN6doGqGVAflBcrkysq
         /7JiVm0hjv3cXc/Vjgcb/uf3iyVXP6dP9LVu0pBFM8xxfg1MhvitR46ba2WJXqgCqc1V
         CzGg==
X-Forwarded-Encrypted: i=1; AJvYcCWO3555JRcfcugPNn9KDlk70hIsPdI1ZucHoy/NoEDjcsOmS3EB+U7who7vHA/nwzBLgOs2pVJTNx4E+5nSyq88t/aCulV6
X-Gm-Message-State: AOJu0YyVz1lj+mBAtrPaeEkt/yBFtVHtTSMwWo63I7xxwz2cM4LT0NnY
	qBkHBHSZCtxrJ2hbNkBINwTXCTJ39Uy6YxdGAtbh++h1ILsV/b4HrQ6Qzb5XteI=
X-Google-Smtp-Source: AGHT+IHotenhFWM7P6vIUURB0jw7q6bTdPsEpzEoM54hT5u8Tjrs6OMB9+Q8kc7xsi832O6gONs24w==
X-Received: by 2002:a05:600c:4e89:b0:414:1fc:1081 with SMTP id f9-20020a05600c4e8900b0041401fc1081mr7799276wmq.36.1710843923987;
        Tue, 19 Mar 2024 03:25:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b004132901d73asm17626214wmb.46.2024.03.19.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:25:23 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:25:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
Message-ID: <ZfloDwb0XMI7KryR@nanopsycho>
References: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>

Mon, Mar 18, 2024 at 08:34:10PM CET, andriy.shevchenko@linux.intel.com wrote:
>This driver is including the legacy GPIO header <linux/gpio.h>
>but the only thing it is using from that header is the wrong
>define for GPIOF_DIR_OUT.
>
>Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

net-next is closed, send again next week.

