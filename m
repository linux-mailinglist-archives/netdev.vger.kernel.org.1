Return-Path: <netdev+bounces-146067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4347F9D1E5A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40C9B24ADE
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616FA13AD05;
	Tue, 19 Nov 2024 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA1SyeV6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376721384BF;
	Tue, 19 Nov 2024 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983874; cv=none; b=bBunYNgpm8fHNpdpxTUPVZZ8KDew6ejWGRTxefcUn4k5YcN8GogLBuh7pUplZM36cGaSL7Bg7sBLx37qoekL3Cr+9ihDOlaDvyfq8S3hPA3SYRphKQwHgks9dO1EVWu8DSSDdAqy1Pfv4fcpYlHQ0O+94LX0a9QadVhJuZoDcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983874; c=relaxed/simple;
	bh=YHJ2SUXafE6/gT6PfhPNG7UtEg908N6mmveYhYbbA3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaFD8UzEVkjc22N9y1nYbFuP8WZMCv4DiGnTh5dPao9SEqfR0MuI/grcrywve4zwpQiCW28BTu4GNLN3H4BTqwWDKAkcq/QUFpOWb+Lm3VdLPEW8PVnyfY54d6ugYkiUCeBtec6XuJOOvCULiRJnXv80n9SuiDxzIGmwvot5SB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA1SyeV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55348C4CECC;
	Tue, 19 Nov 2024 02:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983873;
	bh=YHJ2SUXafE6/gT6PfhPNG7UtEg908N6mmveYhYbbA3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UA1SyeV6pioCQxSNtgeS0CIv/p5wtml1yuiM3ihT0x94pqRKSgX42W0KhkRWhvaXM
	 gQrSVk62XxdyYb9TF3Aasu0Ay/C8NRN9ywKLViFMzHkPLwMgxmd97awchYza+yADwE
	 HtxRiboG6+NHyxtf/IXWPMfetx3X5L591golU0zstRC6qtkeAwr3yQR6P+BNI70HEK
	 Ko1+NfDdpQbQvgOIacmZyR7OHfJ5aSEMqc9CqAi18JAge5+T7PNKEq/ikRyfnmp6BV
	 UH8agGW+/cjgO4/99cUuhd6tdvmMlEcBSCIfUlsBt/fhD37IcmBqLWe17IXsxLS9Cs
	 xQgVeuXoC2hTg==
Date: Mon, 18 Nov 2024 18:37:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
 cmllamas@google.com, surenb@google.com, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com
Subject: Re: [PATCH net-next v8 0/2] binder: report txn errors via generic
 netlink
Message-ID: <20241118183751.77c7b0b8@kernel.org>
In-Reply-To: <20241113193239.2113577-1-dualli@chromium.org>
References: <20241113193239.2113577-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 11:32:37 -0800 Li Li wrote:
> Jakub Kicinski (1):
>   tools: ynl-gen: allow uapi headers in sub-dirs

I'll take a look at your code later in the week (the merge window 
has started), but I'll apply patch 1 (AKA my own patch) already.
Fewer potential cross-tree conflicts.

