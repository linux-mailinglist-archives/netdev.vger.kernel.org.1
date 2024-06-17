Return-Path: <netdev+bounces-104279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2590990BD75
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 00:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC951C215B7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88FA198E9E;
	Mon, 17 Jun 2024 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ocDojUDg"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7B19146C;
	Mon, 17 Jun 2024 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663062; cv=none; b=FldcUW/XIKPKlYk5duP+64q0qmkbCgPh+/HaPmyytGw3osgDApb1KZ7JruGzuYK2nXmQdFA/bnqmz3GVbZD+Fk3iEXtMyqDkuS0/+Wb6h3qQrxssybJckWSyK+DWhnIA+PPQCZjarwkEzOf6CVSbFU8X9bdZCWytMdyCtwpQVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663062; c=relaxed/simple;
	bh=6KaD+c/VP360n0v2uzvhS5vL9pb25MdxJFy7eHW8OBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FLn+Khli8T5VpefDwitSThLaWQX9p3zbENxHacvWu/7iL/D8eVZIkbJgJskpGT9hMpCoBTPYRvqF5jfaNi49G22xGlMptjBqGy64D885Wk90HA/JoLguiObNMhHysiaedEY5ytEVoop/gerQg54sKDzoowHTI/p8x0Mpi7+M3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ocDojUDg; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A9BF645E2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718663060; bh=HPYLTSFUH5oZfQxR9MgPiJfzXvdf8Ci3riP4ABtTYJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ocDojUDgNwiI+LMYiI1BdrILN2gQ5TFJkzqDJ8Vgel4+QQts6kWcQaSwiFfQYrHx+
	 R8fWUid5TaVYBUgP+55YMtivrQtw22vMvWfjFEaU1LubGJaX+cn9QbFvr1EqhUgf6T
	 Te3foxHxkrMxlEzbkvGmU524k/lZ93f3lDB5Cl5n1TzzLmkpNrDt2dEuvl9y9HAP1/
	 CHHZv3H1I7D5BDg+I0NIBhRpo0Xq7QXJ6g1g8qVvofzCvDV8GRnkrJ2mjplFtLeSH5
	 Dg4aFvR+2e3pLOWWEP46zo9f38Wwl7q7v2KSjrFpWb7v0JshUNYQm7SLGK7Fjz9kHM
	 s5X/8lKlq8w1A==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A9BF645E2A;
	Mon, 17 Jun 2024 22:24:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Remove the "rhash_entries=" from
 kernel-parameters.txt
In-Reply-To: <20240614092134.563082-1-thuth@redhat.com>
References: <20240614092134.563082-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 16:24:19 -0600
Message-ID: <87y173gqcs.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

> "rhash_entries" belonged to the routing cache that has been removed in
> commit 89aef8921bfb ("ipv4: Delete routing cache.").
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 756ac1e22813..87d5bee924fe 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5781,9 +5781,6 @@
>  		2	The "airplane mode" button toggles between everything
>  			blocked and everything unblocked.
>  
> -	rhash_entries=	[KNL,NET]
> -			Set number of hash buckets for route cache
> -

Applied, thanks.

jon

