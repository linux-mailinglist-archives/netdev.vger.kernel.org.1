Return-Path: <netdev+bounces-94395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5C8BF539
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7C11F26317
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40E171A2;
	Wed,  8 May 2024 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XVp6Dpbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946F316419
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715142281; cv=none; b=LgAOHaDDgA0x5/Ntmxs+O7PR2vqzw2DM3B4Xm2QqFcR26oTfzju/LD6dwiKXkMGNKWIhbPrt6hLMbkhEq7tIegOUgUeASiQGNr2ZCktbl7yTXIBY5KBJUiA+tGhlyfwqvUQRyD25MQP2MTA9dOzRcJ60vhWCw2WzTpLsFy/pvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715142281; c=relaxed/simple;
	bh=yZblrGkqr5LcB9elRhAdTldqp9fyYiwQbN2zLZukHrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZxcP1UpLtcP3thLvlIs8gTbeQGSuZMfKAASMq4Ei5FTQ0QZrDS8o8ipmSyOtHXN9RgjwpoX/y9nR+OeELbKjCfQZLgDDiaIlyklGTDsv7CQSMJLCuTltGieyMTiRCWnhvdg71VppLEfgtrtIsaCnaP/Ss9fGDxj2Du9EnKBVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XVp6Dpbn; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f040769fc5so1805340a34.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1715142278; x=1715747078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcIw0jig48tYDj8u/gsNEL/K84UnssqPQZLNBzspeLc=;
        b=XVp6DpbnjZamJF+nDJiOYjUMrkwcXEcDiiwrvGbSjed6eob691gLJYRc8vA+VwdhHE
         2QlkiX7vhko/anqddDx2mD4AzO2apxw2YDB7DFS038Q4nzcgY9HCLxpHhEpljPxAd0Gg
         DI83XtAiGL9Y+tlXkqotas75uV5/rZD2H3+S3Ok4XItQA7stOc8ubvOAgM4zQyeSD0b8
         WavOH/6v9KWcfbI3EkJ1tsbI49nSWN1p+bj8bG+1Dbzm33rKvWlgcJJP5fAcjME2CVZi
         bv5IoY7EWrGkc5mq4p25ZiSyWrq8uioBAaps/FZNjUgKahFW/pS/n75BEP48pLQVaQqq
         x9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715142278; x=1715747078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcIw0jig48tYDj8u/gsNEL/K84UnssqPQZLNBzspeLc=;
        b=LwMnNNB/XThP6dqUofegARJsBGowVV/amuAkV2ZL8O0oZvX2zdGCpf0PVwos/+ILd4
         t9eP/wE4lQ31wnrvU5VuWJTdDZqaOPeAWDBmxMnEWKYgq9ej+CqWWMyojNvXqufmKR8X
         Q3fJVsTPuD0zTvLNA1KM+sYIpnNJsmD6bTA4M6cWq+5B3FSq0j5+ai9pJ1RIEKnqyAnD
         3xMENipsfwYRm6rBZNgXFJCZFS7cOYrekNsylE2UYlIZvOUnqo+ll3eqjSeZmON8swrh
         kX+N/p7tmZAoC5gUQhU0i3CZ0Cmq33uqhGwV33Vy9PXDZpcEO534LrbZbR+XPkzgPxVR
         wYFg==
X-Gm-Message-State: AOJu0Yz77oZi52nvT+8KqatRFXnMir6v/f+EEzlNfUIhEL0V2Y4o8k1f
	2yc+1w3+PLWCtNvURj9MmV4jFiN16EqlhG6pMCbYo4vXZx2FKSn8tpsaK/MjLSg=
X-Google-Smtp-Source: AGHT+IHXGu7N27I86DWoNweDyUroqsfh18eLfT4pqgN1q4v05wNI8OCrG24Q8iqkcXSQZ2IYGaVwFQ==
X-Received: by 2002:a05:6830:607:b0:6f0:37af:2b61 with SMTP id 46e09a7af769-6f0b7b7b325mr1560960a34.9.1715142278596;
        Tue, 07 May 2024 21:24:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id e7-20020a63e007000000b005dc8702f0a9sm10670858pgh.1.2024.05.07.21.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 21:24:38 -0700 (PDT)
Date: Tue, 7 May 2024 21:24:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Tu <witu@nvidia.com>
Cc: <netdev@vger.kernel.org>, <jiri@nvidia.com>, <bodong@nvidia.com>,
 <kuba@kernel.org>
Subject: Re: [PATCH RFC net-next] net: cache the __dev_alloc_name()
Message-ID: <20240507212436.75c799ad@hermes.local>
In-Reply-To: <20240506203207.1307971-1-witu@nvidia.com>
References: <20240506203207.1307971-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 20:32:07 +0000
William Tu <witu@nvidia.com> wrote:

> When a system has around 1000 netdevs, adding the 1001st device becomes
> very slow. The devlink command to create an SF
>   $ devlink port add pci/0000:03:00.0 flavour pcisf \
>     pfnum 0 sfnum 1001
> takes around 5 seconds, and Linux perf and flamegraph show 19% of time
> spent on __dev_alloc_name() [1].
> 
> The reason is that devlink first requests for next available "eth%d".
> And __dev_alloc_name will scan all existing netdev to match on "ethN",
> set N to a 'inuse' bitmap, and find/return next available number,
> in our case eth0.
> 
> And later on based on udev rule, we renamed it from eth0 to
> "en3f0pf0sf1001" and with altname below
>   14: en3f0pf0sf1001: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       altname enp3s0f0npf0sf1001
> 
> So eth0 is actually never being used, but as we have 1k "en3f0pf0sfN"
> devices + 1k altnames, the __dev_alloc_name spends lots of time goint
> through all existing netdev and try to build the 'inuse' bitmap of
> pattern 'eth%d'. And the bitmap barely has any bit set, and it rescanes
> every time.
> 
> I want to see if it makes sense to save/cache the result, or is there
> any way to not go through the 'eth%d' pattern search. The RFC patch
> adds name_pat (name pattern) hlist and saves the 'inuse' bitmap. It saves
> pattens, ex: "eth%d", "veth%d", with the bitmap, and lookup before
> scanning all existing netdevs.
> 
> Note: code is working just for quick performance benchmark, and still
> missing lots of stuff. Using hlist seems to overkill, as I think
> we only have few patterns
> $ git grep alloc_netdev drivers/ net/ | grep %d
> 
> 1. https://github.com/williamtu/net-next/issues/1
> 
> Signed-off-by: William Tu <witu@nvidia.com>

Actual patch is bit of a mess, with commented out code, leftover printks,
random whitespace changes. Please fix that.

The issue is that bitmap gets to be large and adds bloat to embedded devices.

Perhaps you could either force devlink to use the same device each time (eth0)
if it is going to be renamed anyway.

