Return-Path: <netdev+bounces-116493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24794A919
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CF9B26807
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A711EA0DC;
	Wed,  7 Aug 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW9FVzWO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767A1EA0A3;
	Wed,  7 Aug 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038866; cv=none; b=mqYdXhSt7oghbZhSsMB+FfqOQyuW7ZTU+tTUzEvbKYOPzhCKxC6iaCBrPJwYoRIlE1308kWwOrJ5XmIt4JmNEtHb8B09pj7NTRBY8nelQI3bhgBNYcpp5Ei8Myldpxqpd836BhCa7VaD8KkYosmZ2FRz7RL891L/mCxa3U9dx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038866; c=relaxed/simple;
	bh=Y3Jln2FXeS4RHFr4Y7Hq3gtr0jmcdBCBNZeEaBt0e5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdZMMgBUthjpo5Cw9Mlzjx0wg6grMZCtBfjVKJqkBqYO2R5q7bszX/7EpSyjOB+OFKu/M1+Pi8Gv9EXiClpf7Mt3UE/+V8AWXyIvkVxCmrbtJFVDFo2LJuB11Gh4jIOngY1veo58GLBynA6CWW+7cEe5P3IwwPgMNNHUlI3+8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW9FVzWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6F7C32781;
	Wed,  7 Aug 2024 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723038865;
	bh=Y3Jln2FXeS4RHFr4Y7Hq3gtr0jmcdBCBNZeEaBt0e5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MW9FVzWOLVb22Ijaj8B4gBro5uZ4TYXQFI+YYbsvYQc4G79BV+IDy7h6t2uMEagcX
	 Bb6qjnSfibJWOLoPsFMlXbRpM1m6hD7S5AsZbisi90kETvBIO0BBWD3SEfIrlX36qj
	 irJnh7+6+7L455raE+gCINKk6yKIYxGMOqkk2te7/53Ij+r9XgkbjrUJJRDfLe/qu0
	 j7dT8DJpakktFCO3BGLiF8g7Iv67oisZibHnqSd8fbmg2cZBL7juZNdWcZt9degvit
	 MXUmXubF+2Awjk1FwBopUEUjzeJevKa/5j6tY6GWJZd+RSqPZuV0iFEYTkOeiILkMX
	 LfLD6fNv0M99w==
Date: Wed, 7 Aug 2024 06:54:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 thevlad@fb.com, thepacketgeek@gmail.com, riel@surriel.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 paulmck@kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next v2 5/5] net: netconsole: Defer netpoll cleanup
 to avoid lock release during list traversal
Message-ID: <20240807065424.74dad331@kernel.org>
In-Reply-To: <20240807091657.4191542-6-leitao@debian.org>
References: <20240807091657.4191542-1-leitao@debian.org>
	<20240807091657.4191542-6-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  7 Aug 2024 02:16:51 -0700 Breno Leitao wrote:
> Current issue:
> - The `target_list_lock` spinlock is held while iterating over
>   target_list() entries.
> - Mid-loop, the lock is released to call __netpoll_cleanup(), then
>   reacquired.
> - This practice compromises the protection provided by
>   `target_list_lock`.
>=20
> Reason for current design:
> 1. __netpoll_cleanup() may sleep, incompatible with holding a spinlock.
> 2. target_list_lock must be a spinlock because write_msg() cannot sleep.
>    (See commit b5427c27173e ("[NET] netconsole: Support multiple logging
>     targets"))
>=20
> Defer the cleanup of the netpoll structure to outside the
> target_list_lock() protected area. Create another list
> (target_cleanup_list) to hold the entries that need to be cleaned up,
> and clean them using a mutex (target_cleanup_list_lock).

Haven't looked closely but in the configs CI uses this breaks the build:

drivers/net/netconsole.c:251:13: error: =E2=80=98netconsole_process_cleanup=
s=E2=80=99 defined but not used [-Werror=3Dunused-function]
  251 | static void netconsole_process_cleanups(void)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--=20
pw-bot: cr

