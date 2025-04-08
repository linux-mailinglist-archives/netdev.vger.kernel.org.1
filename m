Return-Path: <netdev+bounces-180035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25995A7F2C4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23BE188BC45
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7305218AAF;
	Tue,  8 Apr 2025 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Y0QWzAZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8979CF
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744080084; cv=none; b=K6lchZ7IzXwzRJyi7ia21f02uDB6TpvScavc9PHcBhGTY/gR5Slve05eqwdEUhbFWRNXfhRp2molLS2bVg2gmSufn2kyqJl6n0QW2vJ8yy8QNMuqgN0oUxq8pqKkkJIXu78hZsY8PahfvX/rtuGRu+EJPAvWmVPDQJGo8O3lrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744080084; c=relaxed/simple;
	bh=rmrmRUwQIgmYCf313zDoOoipGKaTMK95AonqTUp1Ajk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tabZJPVd00uWhDSeKaRA0rrqNeTBVzBfCxE6oDwEH71HZA1i/K4/tIqcwwnzDbpvhwmsq9y8OhTF8M4lvO9XHx2LFyqF0YqobwH7Iz/UK1Ju/ymi1kuDabGFtokBHSU1zKNw6FSzvfDasK2GvD5S9kJTGahOiyqlAbmNvPO0tMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Y0QWzAZZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73972a54919so4664804b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744080082; x=1744684882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXeKBl8lggk6RXhBxDbRTJI6KlWNU/afweugmLsKh3k=;
        b=Y0QWzAZZ3PktKIjVRG0JOq9kBcVLiAQP9nscKknMLL7rpbxPmGs8mPdFrzEYM1e6NV
         ZGSMQcPpOa8YB2TSKXkspNsgalGTWBFiX58HOEwhs8cec7F0Riyjs5Dd3Bqbf8OL3PP6
         hfC1K4AXSmcGFs4yPfGZ0mxlnHLMlwahpBU7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744080082; x=1744684882;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXeKBl8lggk6RXhBxDbRTJI6KlWNU/afweugmLsKh3k=;
        b=lAJ32qwa+INAxWRNsMXcyBPUXc2NU6CVyORvnN06cymmb0v06op0+yFOjf/0AlDFCy
         BcBTAhk0U15E5Oza3GB5cgo4hIs+oN8ZT3PjMenUf8kKo0AoMp9UMSuRRBATAF36ZO9Y
         WtVoOlMUEyExNMX/0OlRx2+1XhYfc8jZn0HBP4pV7HMUQUCOFhcAwXHrAsUznMDw0tlP
         urFbDCJzdVxzutMJ2p1w7OJ2zvXx4Hsg+TWiyX6S1QkZSwSphofy/6BhfRIsLOw6cyk5
         QvmV2//z6lUyAfjDYoocgIaqjswbBpN0hQesjnZHeW+imqPafz8NIyeSJI3cnZNxlF3D
         8neg==
X-Forwarded-Encrypted: i=1; AJvYcCWD9+D4xpSAqy1MLTYT4t/Osbp5erhL8Eu3czzJJ/9t5EPyE1/pWj4UmP0OAEDEyCyielQgwFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6i/0mDCf43/Qs6b1nvZu/812w3jhjoUhHRuK4gAJm3bFIWP4P
	uL6LclvfG8pTsocz0A/GyyS1NoxaWm9yNKOMTB7CbJaQsv/C8eaN6WntG/v5sdY=
X-Gm-Gg: ASbGncvCfLK5PmcalYlxkNVqbKKLVJ/SHF57DIWapN/TDmuapnGxFeEww+Wc7YWhk+m
	9Y1wIfRY1VmBrAR5Abn6sUvIGgSOFGlcw9B5BCPnj/O8FZGYEmN262SfoVSoPLDYmeH3O9SFovH
	el6M0GCTu/5rdkpmgv/L3LnE9gfV5Y5u1hv/oxnRjxKiystCsGDmwonFbNUXFmX+Z1jjzbtcxUm
	LhQ0yWsk8xVJHK6hOwf0lWsbnz9A79qjGsy5U0/m2l3UeQEgxxRe5rGs2cR7Bz4yxRU44/J4o+9
	7WGyLiHtw9oE2GWYRBZz3yCVOkHr5lcRmDwJO3H+3z0V3xu0nU5IrkPXb9DlBqPGh9ZFpR676dT
	a8pLiJWwjReY=
X-Google-Smtp-Source: AGHT+IEXI4b72o21BYgK8iJF4pr8NmDS2EzngAaTIXa1W5qvSqBMyr/pH984lpxrt6Uz/BZyOxj7ow==
X-Received: by 2002:a05:6a00:1acc:b0:736:fff2:9ac with SMTP id d2e1a72fcca58-739e7167605mr20148440b3a.23.1744080082213;
        Mon, 07 Apr 2025 19:41:22 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0dee45sm9329745b3a.164.2025.04.07.19.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:41:21 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:41:19 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 3/8] netdev: add "ops compat locking" helpers
Message-ID: <Z_SMzyR0SaS2J2kT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	hramamurthy@google.com, kuniyu@amazon.com
References: <20250407190117.16528-1-kuba@kernel.org>
 <20250407190117.16528-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407190117.16528-4-kuba@kernel.org>

On Mon, Apr 07, 2025 at 12:01:12PM -0700, Jakub Kicinski wrote:
> Add helpers to "lock a netdev in a backward-compatible way",
> which for ops-locked netdevs will mean take the instance lock.
> For drivers which haven't opted into the ops locking we'll take
> rtnl_lock.
> 
> The scoped foreach is dropping and re-taking the lock for each
> device, even if prev and next are both under rtnl_lock.
> I hope that's fine since we expect that netdev nl to be mostly
> supported by modern drivers, and modern drivers should also
> opt into the instance locking.
> 
> Note that these helpers are mostly needed for queue related state,
> because drivers modify queue config in their ops in a non-atomic
> way. Or differently put, queue changes don't have a clear-cut API
> like NAPI configuration. Any state that can should just use the
> instance lock directly, not the "compat" hacks.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/netdev_lock.h | 16 ++++++++++++
>  net/core/dev.h            | 15 ++++++++++++
>  net/core/dev.c            | 51 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

