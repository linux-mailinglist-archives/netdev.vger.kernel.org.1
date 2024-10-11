Return-Path: <netdev+bounces-134628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8042099A89D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9511C218B9
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A520198857;
	Fri, 11 Oct 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktzBHSN5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322C1974F4;
	Fri, 11 Oct 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662984; cv=none; b=a5q84l6wE5sAIFr/kI3WAvBY2dn/D7cKh6f0lVnGvgCaDWCGe+F/MA6+sbxzN+ESwF3r3Fkzn5l71xnkB8NOplR+wk4wcfc/SOxquMy3Hj1HsBNw2DY9PnVn/tYkv1t3PAZZcEprAPwIWG4AW3Ag3FZD/kWrzKX8RuzTodMhpBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662984; c=relaxed/simple;
	bh=D4sx2NyNQfPdLcxDUfkwiMuN3iPQBqYCDhL6Odna2es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyuWbsjoSTJlKTFywsynWM5Ai4r7h4zkMXC7wzK/dRkD4N9HLCirquExZc9UoT1bmv3xaV5W61/kt+DsQSnXzUMqAzX991wYk9u8fi972uUb94a4ae/aofN/QveaU5o1T7hp8dG22ieF6KTQxOAn72QJrgP4WP47PQyrHU5vY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktzBHSN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A84C4CEC3;
	Fri, 11 Oct 2024 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662983;
	bh=D4sx2NyNQfPdLcxDUfkwiMuN3iPQBqYCDhL6Odna2es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ktzBHSN55gta6zaAV0wiWKqiDD0zVyPtuRwoLKrPcM1LGr9dTpXHyKnvFoNG0lOVL
	 mToGgK2O4RT3Sv/mA0vSg0xMfUb3eP8mYEfh4x2S+6Wc6oL2H6doP1rdw7R3TtPrUF
	 wzTdW1nYBBQQoOdsfeHdnsVxekfg0rjvcL2FdHJ1h5HKmOs/cUnbEg0zmHpKrnl42k
	 aOnZqVfddUfmN9WBKK0jzy7tRgrig2aIn8mw+r1UzFI1AYKzZfHNi2NKLxlBWYAKAp
	 yrDzF4SYMjqixIUdtHTA0uZhY8Jub6ujUNKg3AskiHlMPPaUlU0KI9WCU1MzwOAhaE
	 /x3+GBXHGGPlw==
Date: Fri, 11 Oct 2024 09:09:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, gregkh@linuxfoundation.org,
 arve@android.com, tkjos@android.com, maco@android.com,
 joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
 surenb@google.com, arnd@arndb.de, masahiroy@kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v2 1/1] binder: report txn errors via generic netlink
Message-ID: <20241011090941.3494f1ef@kernel.org>
In-Reply-To: <20241011064427.1565287-2-dualli@chromium.org>
References: <20241011064427.1565287-1-dualli@chromium.org>
	<20241011064427.1565287-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 23:44:27 -0700 Li Li wrote:
> Frozen tasks can't process binder transactions, so sync binder
> transactions will fail with BR_FROZEN_REPLY and async binder
> transactions will be queued in the kernel async binder buffer.
> As these queued async transactions accumulates over time, the async
> buffer will eventually be running out, denying all new transactions
> after that with BR_FAILED_REPLY.
> 
> In addition to the above cases, different kinds of binder error codes
> might be returned to the sender. However, the core Linux, or Android,
> system administration process never knows what's actually happening.
> 
> This patch introduces the Linux generic netlink messages into the binder
> driver so that the Linux/Android system administration process can
> listen to important events and take corresponding actions, like stopping
> a broken app from attacking the OS by sending huge amount of spamming
> binder transactions.
> 
> To prevent making the already bloated binder.c even bigger, a new source
> file binder_genl.c is created to host those generic netlink code.

Please add a YNL spec for the new family, and use it to codegen 
the basics like policy and op tables:
https://docs.kernel.org/next/userspace-api/netlink/specs.html
Don't hesitate to ask if you have any questions.

