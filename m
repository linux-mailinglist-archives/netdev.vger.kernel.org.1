Return-Path: <netdev+bounces-133680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE78996AC9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE0B1C22393
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22E19925A;
	Wed,  9 Oct 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Y/dgvD+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED3194C9E
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478215; cv=none; b=Zw3mxmg3XJzNu3QEGS7xsztYergXjrudCXLBtJJve2nwFzM0UUpOn4ZNXCSZCxc4pmDa5dmkaQtsaFxqFHnuCBBejwDidO7EGgTJ7eW/eh6MvoDjD6vl9lXAf4mw/3Mmc5Kt5ItvmVyFUNYgWQT3CBwAN7Phr91GdK3zGV6R358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478215; c=relaxed/simple;
	bh=zX2aN2bQfh9/eAKsXro4JaDIjxIsPjBrb1ugI0WsWNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k91Sde/WRLBYv3RQp0rfNaL73NoTJQSV0OQdQd1KZH4ZqRPujFJEjUW/QTMDKcIZu9j12q5vILU3QwSLCDhsWfI5uwZ9WQGWg5+jRJl0K43NA7kGB8BetY73+gkqEJB/7FONdtJGXpZhbb884RmEGwT/miWGN3JmjwTdyNOdKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Y/dgvD+2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1690332a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728478212; x=1729083012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLlwixd2E1dEO57pRbwIhWNBhZX7/WzKsg5lEJojxIA=;
        b=Y/dgvD+220OevZ3ScETfDdlXf2eCLGX5Jg0biuPqrcjJGxjVawbjuHr2aE6GGqF+Yg
         HKThBL2es6xm/Mb3+aWhC/5noKUphXqduOcsYgk+GKVuVF+MblU/FQiUCihSFRHgcVyL
         ZYXdZbHr47XXyFuci/XjdvSxSjHOPRmoR8eR4qARagYVOoAbxR/2Vo5o+jNMp58RWFxg
         ZVoapZcorYzgEwndCuDcPF9ALBk8Ri+yltDLJ4qHkD0pOLTcyVm6kG/rJ17tiW3WqAhb
         vnB7Hz3eVcsximv5d7mr15iR7xTD0jOdVDy7YMd92HH4wxzyZUzrPkkbjYvQBYhX2v8L
         n4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478212; x=1729083012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLlwixd2E1dEO57pRbwIhWNBhZX7/WzKsg5lEJojxIA=;
        b=Qf/Epgh3x//occqqFMt+4MV8EdlAfjqXhKTwPRgHW7r3CHYKLXoSYSn+ezrJchqqzS
         ayw5aCUqb/JRsL9rx+VvarZNFAXJVno9zdU38KWnkwJjvH+mNf0CpIvPlpe+UdJ9d4oE
         VhGadxkB+HOj+sYETBOPs2tUyRVHgrIIBoezsYJtid1NOS9cC1zGgbv7bfJJv/NDPpdg
         fsUys95BeakC1YO9VOopj08M6w/n4DSSsrO41nkaOvIFMfwPxFW9YGp44UImkPeipXAP
         y48K8kQz5usDC9YrAkakwQH3iaNXPRrRhbUMOr0ine+tMFbE6z4+wvVrk1Bs8KQiwiTw
         IzBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcoBW+PikbPvdOZXweYnPMwbdzdLCApCxcApdRDzGS9K7O6/eX6POwwSFO5y3Cs3vmTaCUcUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw64QpDhZdpIMSn/oc6hkUIRSLwrrZ7gUWrl+FbdL3Qshs5Zwl+
	PwZNLy6WIQ8QEtqiSpNbiVscuFPMhftJjDATYwkP/X/EzoAqk2ZH7fO8pzjOenM=
X-Google-Smtp-Source: AGHT+IHpG77I+g5t1o4fxYQA7i2pv5lko7+/zEvVY5PPpW0m/4rsUpwNSSqq3hkIzf9t4IhLWNWN9A==
X-Received: by 2002:a05:6402:278d:b0:5c8:8c16:3971 with SMTP id 4fb4d7f45d1cf-5c905d64345mr8372104a12.16.1728478211357;
        Wed, 09 Oct 2024 05:50:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f22a4sm5447662a12.79.2024.10.09.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:50:10 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:50:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Antonio Quartulli <a@unstable.cc>
Cc: kuba@kernel.org, netdev@vger.kernel.org, donald.hunter@gmail.com,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH] tools: ynl-gen: include auto-generated uAPI header only
 once
Message-ID: <ZwZ7_qjDH_y0JIcN@nanopsycho.orion>
References: <20241009121235.4967-1-a@unstable.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009121235.4967-1-a@unstable.cc>

Wed, Oct 09, 2024 at 02:12:35PM CEST, a@unstable.cc wrote:
>The auto-generated uAPI file is currently included in both the
>.h and .c netlink stub files.
>However, the .c file already includes its .h counterpart, thus
>leading to a double inclusion of the uAPI header.
>
>Prevent the double inclusion by including the uAPI header in the
>.h stub file only.
>
>Signed-off-by: Antonio Quartulli <a@unstable.cc>
>---
> drivers/dpll/dpll_nl.c     | 2 --
> drivers/net/team/team_nl.c | 2 --
> fs/nfsd/netlink.c          | 2 --
> net/core/netdev-genl-gen.c | 1 -
> net/devlink/netlink_gen.c  | 2 --
> net/handshake/genl.c       | 2 --
> net/ipv4/fou_nl.c          | 2 --
> net/mptcp/mptcp_pm_gen.c   | 2 --
> tools/net/ynl/ynl-gen-c.py | 4 +++-
> 9 files changed, 3 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
>index fe9b6893d261..9a739d9dcfbd 100644
>--- a/drivers/dpll/dpll_nl.c
>+++ b/drivers/dpll/dpll_nl.c
>@@ -8,8 +8,6 @@
> 
> #include "dpll_nl.h"
> 
>-#include <uapi/linux/dpll.h>

What seems to be the problem? The uapi headers are protected for double
inclusion, no?
#ifndef _UAPI_LINUX_DPLL_H
#define _UAPI_LINUX_DPLL_H

