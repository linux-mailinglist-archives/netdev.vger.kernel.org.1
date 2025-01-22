Return-Path: <netdev+bounces-160214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF094A18DD6
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98B83A04C6
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090E49659;
	Wed, 22 Jan 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jjlroJ0w"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19231C3C1F
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535830; cv=none; b=jO+xNwyabCICEkzb/TKbG/8eFj5g2I1y0+ktFSuqbzfQuDC+6YdvMY2WUtPmr6MDsYq6ua+/SpCjlm0r9kST/c+OwkCDV+bZiqynSKund5zBNrW0tkM0MiwvymwdvKqdls1VI8/lOnldjbc9cT3v6C5+B9JlXDUFZrhAmJ9BCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535830; c=relaxed/simple;
	bh=VbyzBrleis8WrenyAV2GFvuNZd1h0LbwEDatvhirSw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcA8IuJ/OzNIagYIxR6xfXrezGD2yBonngX4lsYfhv6/uf03km6Uc203BNbm3A5BPy3YTkq+reG2IxFsglVxTzQ0xh9gihRwbDz9GyANR4ARWeOkwsDtw5LJzfA++JdBo7zYwQb+coRgoDnQK9lNzZyywtcMm04aTxF8FP4WSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jjlroJ0w; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE753FF80C;
	Wed, 22 Jan 2025 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737535825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57PUd4P8GgIc+9m9Hd00tlph56vwPWKxUALSWw8SQFg=;
	b=jjlroJ0wEOprW+CW8j+fpTShgGNrNoC6xFNoQemz+erJFWV2fhtWEWRknkiDHbZ0pTYXO8
	YxEuTAi8ytodoIavNFrGeatev3vCO8spHHzsDqxFk/l36BTa4FqbzWTUhuPP/ERi7zrMhf
	Eq5clqSVIQB6pQ56kDicaKjerGCC/A0mCLLJW2KseDFviVXn7TNGntIFQ+WRnYdL09Apbj
	IMQ2fY9KF72BZ5pRXLeIYdvMDlOh3Olx7QqlR28tL7Qo3Lhs+6K9/przWIZKybWzqAUQFq
	Ejk7fYhM30V69GZPkQ2qqTlouOqAxIw6BwxaeKL0wCEsOYARUQgy3OtoK8pcmw==
Date: Wed, 22 Jan 2025 09:50:24 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, stephen@networkplumber.org,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH net-next 0/4] net-sysfs: remove the
 rtnl_trylock/restart_syscall construction
Message-ID: <20250122095024.35c78381@device-291.home>
In-Reply-To: <20250117102612.132644-1-atenart@kernel.org>
References: <20250117102612.132644-1-atenart@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Antoine,

On Fri, 17 Jan 2025 11:26:07 +0100
Antoine Tenart <atenart@kernel.org> wrote:

> Hi,
> 
> The series initially aimed at improving spins (and thus delays) while
> accessing net sysfs under rtnl lock contention[1]. The culprit was the
> trylock/restart_syscall constructions. There wasn't much interest at the
> time but it got traction recently for other reasons (lowering the rtnl
> lock pressure).
> 
> Since the RFC[1]:
> 
> - Limit the breaking of the sysfs protection to sysfs_rtnl_lock() only
>   as this is not needed in the whole rtnl locking section thanks to the
>   additional check on dev_isalive(). This simplifies error handling as
>   well as the unlocking path.
> - Used an interruptible version of rtnl_lock, as done by Jakub in
>   his experiments.
> - Removed a WARN_ONCE_ONCE call [Greg].
> - Removed explicit inline markers [Stephen].
> 
> Most of the reasoning is explained in comments added in patch 1. This
> was tested by stress-testing net sysfs attributes (read/write ops) while
> adding/removing queues and adding/removing veths, all in parallel. I
> also used an OCP single node cluster, spawning lots of pods.
> 
> Thanks,
> Antoine
> 
> [1] https://lore.kernel.org/all/20231018154804.420823-1-atenart@kernel.org/T/

Thanks for that work, it looks like this would address this problem
faced recently by Christophe (in CC) :

https://lore.kernel.org/netdev/d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu/

Thanks,

Maxime

