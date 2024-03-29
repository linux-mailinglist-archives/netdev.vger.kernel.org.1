Return-Path: <netdev+bounces-83151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE26891144
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873E028CCF2
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449FD32182;
	Fri, 29 Mar 2024 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DryBTpe1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203991EB45
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677519; cv=none; b=g3j3BKv8hSuMt1RWYD/XDHoIeeT6E04IZAGBtfZUnp9hRBV9YVlC3mtOfoRiTnv0hQh8v3L8IIl0hegvQzFvLDetTrK4OVfYrvQcj7sZ4m/fdBclzVbtz2sR+qk/wgXs3fd3fF0RiHUUsvyrZA6nbJa8Sy5gDV9WhLxt0vTPESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677519; c=relaxed/simple;
	bh=T2nvSUGYjIecHliGDe2EQrht6TyQlkneeh6w/opFOGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAO2BuEXpy9zSBgmLKjzeyBA1bN/b/0vXRGpv4f7hcrroS71mXrAt2KpJ2w8jxIXlj8B2Ck5jU/gKu88sJ10G6+HcD1TbwBbk6bZwvkJ+7v5uO4BmcQBt4lFMHkp5on0xqA7xStKMZhcHBD/lNLd8VM+J4MQiviaN0WI4zEi/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DryBTpe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48783C433F1;
	Fri, 29 Mar 2024 01:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711677518;
	bh=T2nvSUGYjIecHliGDe2EQrht6TyQlkneeh6w/opFOGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DryBTpe1ewL5EUzbibF/87/HjS2gI2CwlUDWmobqeO8uN6pxyxlyac3K7363anacG
	 NNsJTgYk8frMTvX7FR682ErBlHgZrMzgidxYVUBNXiP2mrS3nS/DDR1VHuCyg8+QoZ
	 gAM3jk12FpaJeytgvnIJEhIAZlcelfQ1Yel8c6iYGxGC8CoNQ4XXOAb0l7utKBXjgS
	 ym6JziGjZCFaPttexNfEB/1PlbE2hfT1DoBMgxMBjEhTiJhnHILjIhU//X7soUrrwK
	 jUoeY2BkVPK+hZYwZIcD7xLly/GGI6udQeniI4JUqLLOr0SkwRIVyBg9kEM1sXhs4h
	 iXuiM6FHNnpRg==
Date: Thu, 28 Mar 2024 18:58:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next -v6] net: enable timestamp static key if CPU
 isolation is configured
Message-ID: <20240328185837.2cc5c557@kernel.org>
In-Reply-To: <ZgSzhZBJSUyme1Lk@tpad>
References: <ZgSzhZBJSUyme1Lk@tpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 21:02:13 -0300 Marcelo Tosatti wrote:
>  #include <net/page_pool/types.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/rps.h>
> +#include <linux/sched/isolation.h>

Sorry for a late nit, could you put this include next to the other two
linux/sched* includes earlier in the file?
-- 
pw-bot: cr

