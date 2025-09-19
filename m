Return-Path: <netdev+bounces-224877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2FB8B2DB
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C1E17F5E8
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FFC23B60A;
	Fri, 19 Sep 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtLcczMg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF821ABC9
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312969; cv=none; b=rumATVdLU5FAk1NDZslpz2mC2ie1zRvzmEAYyDf1jKlchZsAzZg/Du88dzUUmpnOw9bOv1iZYHyFLCds2813dTfzXJFeRZNbzOVLDzbkKgdZvCq+8p5lZWvCrIZauO5iQoTkX4D8IEAMrit6awWVua0nF7jX1x99vpWrdBYtJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312969; c=relaxed/simple;
	bh=nhT//gnvmkKq0rzoBriACH7Ook6fK34itGhdd/AQjds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2cnNtw4tXI0NnZQ8FRnFE65pgX267PQwEOInTUIN2CYvJUVYEP7Aa8tfXmDFh6+A9u8Td1j3FpGP5d4lioccRO91D28bKe0CoPyJ5OjxTcm2bkdwyzwI6JVzntI75u20jFDBiPhu4xjIqJeZk9VMpJDxc8xnYFp+S4lBSwqaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtLcczMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A6C4CEF0;
	Fri, 19 Sep 2025 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758312969;
	bh=nhT//gnvmkKq0rzoBriACH7Ook6fK34itGhdd/AQjds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YtLcczMgBxJZN33/n230mY/EklPgw+BlaeO8kPH3uMw+uCv5VTYkzjcM3MDNGk/ae
	 0PoHc23uDlslDsR6CFVkO/wlSUdDLZazQbycA9RfDFeyVn5ZCWaj5j23WNGSKU+zUv
	 lfgZ7imYuh1DaLzoefw/Eio6e/AkvXXlhGzKKOhJY1qe9mdo3Hx7E3/6o+RpivCTdc
	 iTQVPSHpeg18Z7kqvCcK65om8PjOgueazlXUbfgFLIqNZQEkAC9JJJkHe5mIKXLI/k
	 oPfRELnRvCtjvsH3fD4zLJoSRWE0pn9Tx/uaQv+bF9MrMR1qQStRbX8ze55VOPP54k
	 Orb3nMdaTj0/A==
Date: Fri, 19 Sep 2025 13:16:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] udp: remove busylock and add per NUMA queues
Message-ID: <20250919131607.66e74a10@kernel.org>
In-Reply-To: <20250919164308.2455564-1-edumazet@google.com>
References: <20250919164308.2455564-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 16:43:08 +0000 Eric Dumazet wrote:
> @@ -2906,6 +2912,7 @@ void udp_destroy_sock(struct sock *sk)
>  			udp_tunnel_cleanup_gro(sk);
>  		}
>  	}
> +	kfree(up->udp_prod_queue);
>  }

CI lit up with memory leaks. Looks like IPv6 destroy needs a copy of
the kfree()?

