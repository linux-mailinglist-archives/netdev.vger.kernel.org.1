Return-Path: <netdev+bounces-166278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3389A35517
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CB03AC149
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 02:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5113DDAA;
	Fri, 14 Feb 2025 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5ost0CM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4D86333
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501738; cv=none; b=CWvZP4HQPs/0/JwCzyCmvOQuTGQD7z2ALD98QSQ+bOhtuDKcjKsG478q5iNY+BnVwyUxGGUj7davCIxybAFtE3JnBXVAgbxj37bRSB33vbjErkXnsXBHNHkpHCmo+ZD4BOy/cIRIJmZTMhwdmpm0ZYl0U3v7NgaEaboVkCi7uOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501738; c=relaxed/simple;
	bh=FpDmd9pOFLVioezoxgAITQ3iL6gaPmV3ciFFG/+pxZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD7SqY4yCjYDazsHwjmWRGAa5dlhwEEAyQiselWbsmBSEZeCSI6tNhogZP2L/BOxSfMvmyqGnXy/KInkHzc+T3wn03qtFxITNYVKDtZP1o6I3IiOunPdKpAvpGNF0DB8ARnSB3tnYn/cvMM7hZ1qqYesq6yW8EiLneHrs/nJqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5ost0CM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f48ebaadfso31762085ad.2
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 18:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739501736; x=1740106536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcDEbWjwE9UJ6btfqbQzccKeotR4xCBZDI0bydlEBV0=;
        b=W5ost0CMb7uAnJs9EX/12zvekhOEyeG/+kpAnhWZ9m73HlopDZdZIQHIX7VFQ9lBA3
         8EdRGnbAXY1N7bmRjKjAWtq2tiXYeZpgHhpid0Q1XJImxb9VuOafUIIbHr+VlrcaTxsy
         q54qrH8Xdgz4Qg920lCb+FS55CHN8Wgc0AMiP1zOli0S6sQFhlG8iqTAw5Db4/MUIrit
         hjafJIk2HZiy3RncApZUYEl4XYnmoeff2vWTXfb+sdo2CCx8eyl4yHukKp0CwANrqbIU
         6cHry4NrDn3G+qHKL20parhTpgTxMTgAjqHKOMlW8t+EaxMTEFA6KFICuX7BWXJaeAbP
         Nzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739501736; x=1740106536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcDEbWjwE9UJ6btfqbQzccKeotR4xCBZDI0bydlEBV0=;
        b=QLr9REXgHwh/4I7QBEAXCaGtX4nH87rNqodQC/ccuPyazNu4gV65eGFcEN57oU57pF
         f81f2PHKOMqOC+/bqt4nNjGOIV1BSPF9zsRD1QjImv80mZ/8p7XIPq7kHK9Io2A+QegV
         WjNyQWoDl6Qv57t0vnfFY1vImjZUrawPeeN1g58DrTyOFh2MUU/UH8OX4j4tq7O1x/gq
         cvo2Op7iT83g1FIsXH51mAmaHpyBKGunyfzCIH7BAR1SQRh3fztLHwQzEoBGsvYiAnhD
         TgrEJgfdSQKLsNav6aqsUGVV4Els/RobY7FHcQIVwXERKVPFpDKLvzikKqQmLAcXJHL3
         +N4g==
X-Forwarded-Encrypted: i=1; AJvYcCXZCgc0bczuj5/BQujYvVCOY3n1hd/iPN6oQITTY65Kn5pcBsrB2A9Vl0xTHfs7lF4AYRE0Woc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZABJqWzA0wr3I/tz4Ys6qNdbCwkJ6pA8yqpO9+vbBbeVYyQqI
	4Z+s3f9nKfOiKcYsgXjdreUYShoBNfSdjw/AF0rVyZXm+HuEqq0=
X-Gm-Gg: ASbGncseX9W/4+VkLhUoSCet3seC/MMuFtrFAIL4vCjz4LDu+L/vHNU7K67vMfZVtFD
	DjBduEN2MZK5gu8ZMI/nHhqHpOE8p40kzsPKU5cdnH8qxCiFdsSfKKzbe+LTiMBsJvtHBDfD6NH
	8xPJAwS/gkgOhQBgtfZ3NCbvlVcZzml2ieDMQyh0IvWP7ilf7TOhdHBdhOBDuP5OIZUBgrzKBse
	5zdInpBR2vttMUOGxcGl2Wsm7GmnWOZGemyjwtrL2QKwzzDaVLD4i0HMpRSoe1q9g2rrQHVZ89J
	TjhpOP2L5NzX00M=
X-Google-Smtp-Source: AGHT+IHhzfcslMNcKUviIx997Ui0He6OpBMKiLhtUxDaWdjUrTdjBe4JJQCDN3zUBhLorBU+AFsL5w==
X-Received: by 2002:a17:902:f601:b0:21f:4144:a06f with SMTP id d9443c01a7336-220bbad659cmr139124745ad.13.1739501735958;
        Thu, 13 Feb 2025 18:55:35 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d072sm19501325ad.107.2025.02.13.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 18:55:35 -0800 (PST)
Date: Thu, 13 Feb 2025 18:55:34 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [RFC net-next 0/4] net: Hold netdev instance lock during ndo
 operations
Message-ID: <Z66wpiW71N42uLSL@mini-arch>
References: <20250204230057.1270362-1-sdf@fomichev.me>
 <Z66mEzg1YU02mr43@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z66mEzg1YU02mr43@x130>

On 02/13, Saeed Mahameed wrote:
> On 04 Feb 15:00, Stanislav Fomichev wrote:
> > As the gradual purging of rtnl continues, start grabbing netdev
> > instance lock in more places so we can get to the state where
> > most paths are working without rtnl. Start with requiring the
> > drivers that use shaper api (and later queue mgmt api) to work
> > with both rtnl and netdev instance lock. Eventually we might
> > attempt to drop rtnl. This mostly affects iavf, gve, bnxt and
> > netdev sim (as the drivers that implement shaper/queue mgmt)
> > so those drivers are converted in the process.
> > 
> > This is part one of the process, the next step is to do similar locking
> > for the rest of ndo handlers that are being called from sysfs/ethtool/netlink.
> 
> Hi Stan, thanks for the patch, sorry I didn't have the time that week to
> look at it and it fill between the cracks, I've glanced through the patches
> quickly and they seem reasonable. but obviously we need much more, so what's
> the plan? currently I am not able to personally work on
> this.
> 
> Also the locking scheme is still not well define with this opt-in idea the
> locking shceme is actually still not clear to me?  for me it should be as easy
> as netdev_lock protects all paths including, ndos/ioctl/netlinks/etc .. paths
> that will access the netdev's underlying driver queues.

Hey Saeed,

There is a follow up which locks the other paths:
https://lore.kernel.org/netdev/20250210192043.439074-1-sdf@fomichev.me/

I'm gonna try to do a v2 tomorrow to address Jakub's feedback. There is no
opt-in currently; any driver that uses shaper/queue-mgmt API will have
its ndo running with the instance lock. Can you try to run your mlx5
queue-mgmt changes on top of it? (v1 should be good enough, no need to
wait for v2)

