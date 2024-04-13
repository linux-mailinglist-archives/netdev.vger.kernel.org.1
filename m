Return-Path: <netdev+bounces-87583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 876548A3A55
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 094B2B20968
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A995BE40;
	Sat, 13 Apr 2024 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKNsB5G2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE64C65
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973924; cv=none; b=Aa9td+UgIOMjY23fwtM5pt8ilwvX82yx9pdyc2ygC+XMAvtlyauSYyyju5/lmKACoYY6WL+VMpuqCMnksYb6lnlNWTGkINEs1KV1afI5pQbmAgUHV5xKwm9s9sQl9wWZi1n0HDhC2R5Usfb8eLWfyNkp8DAcUZ5R6xHELkzYNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973924; c=relaxed/simple;
	bh=JyY037Ca3pzq/a9cKQIyCZPtAKZQJeoY1D+t5tAioM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1wRjoeBaI9ND3YyRITac6/s0eLWPNL1AxaMEgB31evO5Pp7HuirIPoasK/aSoKDmG2GjjoXiZ9hXpzr4HL1YB45rmjYgL9xTPCLzX8e299xFRpSTbjUY7h4OVVUDaDO/fYqO5pUHH7FYyKLI50m6NW2xCEut3NmBN6BPuVy5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKNsB5G2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F44C113CC;
	Sat, 13 Apr 2024 02:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712973923;
	bh=JyY037Ca3pzq/a9cKQIyCZPtAKZQJeoY1D+t5tAioM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKNsB5G2yPySFIT2rqkyjoBRCYD6XS4aEVusGgyZel4+gdz1SM3nOC4fsqviwm+4g
	 f7GSxA85cY0mkonNQKhi6+JAFhUfaA1qB1TnmzOd05abHcqzylSoJ81iJgBxcqVM0A
	 V7swLO4gWxK82cQ9kdFwMKQko7o8tj1Orubi5xJHLUDbjvH8sWn9Xx6FDsTWzFuIIt
	 XQWQMXlvBJgAx5ouJEzSyA7yWwmqUjkIyM6cue3JbGqw+FlQLn1gCQgdS8u2Pcsm8A
	 kg0IdDGPqy4g0ZsE6htBOFsRhPYmiA7XInTwavwFb45EIacjbEgPJ296LABo7v2WPS
	 dne3EH3IS+Rfg==
Date: Fri, 12 Apr 2024 19:05:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>, kernel test robot
 <oliver.sang@intel.com>
Subject: Re: [PATCH v1 net-next] af_unix: Try not to hold unix_gc_lock
 during accept().
Message-ID: <20240412190522.3a157f00@kernel.org>
In-Reply-To: <20240410201929.34716-1-kuniyu@amazon.com>
References: <20240410201929.34716-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 13:19:29 -0700 Kuniyuki Iwashima wrote:
>  void unix_update_edges(struct unix_sock *receiver)
>  {
> -	spin_lock(&unix_gc_lock);
> -	unix_update_graph(unix_sk(receiver->listener)->vertex);
> +	/* nr_unix_fds is only updated under unix_state_lock().
> +	 * If it's 0 here, the embryo socket is not part of the
> +	 * inflight graph, and GC will not see it.
> +	 */
> +	bool need_lock = !!receiver->scm_stat.nr_unix_fds;
> +
> +	if (need_lock) {
> +		spin_lock(&unix_gc_lock);
> +		unix_update_graph(unix_sk(receiver->listener)->vertex);
> +	}
> +
>  	receiver->listener = NULL;
> -	spin_unlock(&unix_gc_lock);
> +
> +	if (need_lock)
> +		spin_unlock(&unix_gc_lock);
>  }

Are you planning to add more code here? I feel like the sharing of 
a single line is outweighted by the conditionals.. I mean:

	/* ...
	 */
	if (!receiver->scm_stat.nr_unix_fd) {
		receiver->listener = NULL;
	} else {
		spin_lock(&unix_gc_lock);
		unix_update_graph(unix_sk(receiver->listener)->vertex);
		receiver->listener = NULL;
		spin_unlock(&unix_gc_lock);
	}

no?

