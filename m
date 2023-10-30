Return-Path: <netdev+bounces-45286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697E7DBECB
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C666DB20C2B
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3473E19469;
	Mon, 30 Oct 2023 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwAJW0fy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19330199A0
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 17:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC9DC433C9;
	Mon, 30 Oct 2023 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698686663;
	bh=eV19Ockr7RUnS+W0KMjJyddBbTy1+ZUyx1ggv+j7BCk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EwAJW0fyV6Xbl704yYVp6NWmi/pVv+aEvMG8LaXGfy+QB5wTsBP1qxInZeIyLKsPr
	 oHEKiJEoBDxDFXs5v/CQsBIa0Tma81wlPmH4h5N+oDA9E0xtMwWvA4c3sHvJ0BQDz1
	 wZESaMXuATuGZwyMnqtsVvDbvbynkLUf6lLBKeoPQn7twCRhV5K67/bTO/bIr826dF
	 R/wBXIvuB3FM2wvvFn5VzCqhyU2A6cdjST/dnkiEkm4GvfuuN0F+jIvjL8g2V2KuPz
	 cNDTOzdSSnGzKCA9SSJxNRnyKIpLlIMVmzSALQcqkzkIDSarEuAzxkQENKPnFv4xKW
	 dBAcQ+lmWqKhA==
Message-ID: <2c3957f5-2a0a-41a0-a998-0c5eee7955d9@kernel.org>
Date: Mon, 30 Oct 2023 10:24:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] remove support for CBQ, RSVP and tc-index
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20231030165501.10596-1-stephen@networkplumber.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231030165501.10596-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/23 10:54 AM, Stephen Hemminger wrote:
> "Bring out your dead".
> The kernel removed support for CBQ, RSVP and tcindex because these
> features were causing lots of failing syszbot tests.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> Thanks to Jamal at TC workshop for suggestion.
>  bash-completion/tc           |  24 +-
>  man/man8/tc-cbq-details.8    | 423 -------------------------
>  man/man8/tc-cbq.8            | 351 ---------------------
>  man/man8/tc-tcindex.8        |  58 ----
>  man/man8/tc.8                |  19 +-
>  tc/Makefile                  |   4 -
>  tc/f_rsvp.c                  | 417 -------------------------
>  tc/f_tcindex.c               | 185 -----------
>  tc/q_cbq.c                   | 589 -----------------------------------
>  tc/tc_cbq.c                  |  53 ----
>  tc/tc_cbq.h                  |  10 -
>  tc/tc_class.c                |   2 +-
>  tc/tc_filter.c               |   2 +-
>  tc/tc_qdisc.c                |   2 +-
>  testsuite/tests/tc/cbq.t     |  10 -
>  testsuite/tests/tc/policer.t |  13 -
>  16 files changed, 7 insertions(+), 2155 deletions(-)
>  delete mode 100644 man/man8/tc-cbq-details.8
>  delete mode 100644 man/man8/tc-cbq.8
>  delete mode 100644 man/man8/tc-tcindex.8
>  delete mode 100644 tc/f_rsvp.c
>  delete mode 100644 tc/f_tcindex.c
>  delete mode 100644 tc/q_cbq.c
>  delete mode 100644 tc/tc_cbq.c
>  delete mode 100644 tc/tc_cbq.h
>  delete mode 100755 testsuite/tests/tc/cbq.t
>  delete mode 100755 testsuite/tests/tc/policer.t
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



