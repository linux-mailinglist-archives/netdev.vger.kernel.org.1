Return-Path: <netdev+bounces-106709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BAC91754F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F931F2216A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103879CE;
	Wed, 26 Jun 2024 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZr+u1mw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31E53AD
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362600; cv=none; b=g6JKFzvqYs0MxgOemcBF5KDutI/L0gT/fyYBKJ610T2bLrmguIKepJojwZ1xVL0MQFVUdKvgnQBHyACIz0b2N5L07qtDgmi7g8LdKwe5Mpdt2/xfAWtE11gmA6JORXu2pHXwc3TPr8UVp55FUp2kWskn5TMjoL+IVv1zLsH2HnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362600; c=relaxed/simple;
	bh=6Si5gznrl1TBB/UR9O/vHFJ/6vjoWHGW2q4AHOPR3/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8mJKNTxi+7MkxHIhRqkQURZfFgjHkhLajOPjjRUlDHIX8G9JgwzHzDpCXAyUA+ZFMQwAs9MGOoLKbYe8ngRReBq6tFDIAMKycX9fP59RiOQp4OULSe0sSrfJfIS7gnXxpND1dfwTaWuXdu3jzxC0mLTEQYyq9OWvhyomeS7FMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZr+u1mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5398C32781;
	Wed, 26 Jun 2024 00:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719362600;
	bh=6Si5gznrl1TBB/UR9O/vHFJ/6vjoWHGW2q4AHOPR3/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZr+u1mw6jH9c04/NnApiBLYAnVImI6e1QtddFN1O8+UTF7OxmZFR/AELS/yqv3RE
	 iUp78CfWbdA7V/xkd92ZKFu/h/6x2TJBI+JnqJLQClofhnSL4VhLiBvHAJvJsDvyEF
	 B67aVXr9OVQJkB0XHF6JaxwtPjI+WCW2Z8281Vlq9zHJUcFVHlErvzF5f1ng1nGnvO
	 ntMtK0JBqhx/Ey1/lNeO7QqmnSgDaxfILPaYE62gSckfr7wvWzEckGnlnzBZgjmqaA
	 49Xk48MJ58qF6Aqi3k5ZGvf3hn/il3Fc/z3SSwSxITul+w2zwUgnwHqVIu1XEKAJaT
	 9MOj1u/IvL1+w==
Date: Tue, 25 Jun 2024 17:43:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rao Shoaib
 <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net 00/11] af_unix: Fix bunch of MSG_OOB bugs and add
 new tests.
Message-ID: <20240625174318.76c8a57d@kernel.org>
In-Reply-To: <20240625013645.45034-1-kuniyu@amazon.com>
References: <20240625013645.45034-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 18:36:34 -0700 Kuniyuki Iwashima wrote:
> This series rewrites the selftest for AF_UNIX MSG_OOB and fixes
> bunch of bugs that AF_UNIX behaves differently compared to TCP.

I like pairing the fix with the selftest, but at the same time
"let's rewrite the selftest first" gives me pause. We have 40 LoC
of actual changes here and 1000 LoC of test churn.

I guess we'll find out on Thursday if we went too far :)

>  net/unix/af_unix.c                            |  37 +-
>  tools/testing/selftests/net/.gitignore        |   1 -
>  tools/testing/selftests/net/af_unix/Makefile  |   2 +-
>  tools/testing/selftests/net/af_unix/msg_oob.c | 734 ++++++++++++++++++
>  .../selftests/net/af_unix/test_unix_oob.c     | 436 -----------
>  5 files changed, 766 insertions(+), 444 deletions(-)
>  create mode 100644 tools/testing/selftests/net/af_unix/msg_oob.c
>  delete mode 100644 tools/testing/selftests/net/af_unix/test_unix_oob.c

