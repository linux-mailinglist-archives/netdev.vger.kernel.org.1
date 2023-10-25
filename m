Return-Path: <netdev+bounces-44286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 422DA7D76D7
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F70B20DA6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E0339BB;
	Wed, 25 Oct 2023 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V03LB5AG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED37848B
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF330C433C7;
	Wed, 25 Oct 2023 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698269453;
	bh=866yJ6QEGke94UXkLijvdFJbDhsr/QcS04165KyCsiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V03LB5AGmTa2S0gwTGLR0QsbNNE4fsKEyw5CvM/d1G0lUP33AwaYenDUmklzr06hf
	 uxgOr9Z7MlDyakRq/IX8/UMl5/P8kWUaBgHiUmcJeuPAzJx9mHISNIknW2a+jR255X
	 QrJwkF34lLPGmMXyOkEufZY5iara7NWfC+9WzEQltCvtphdMYyy6Zot5SLmpEiVz8V
	 If+lG5KnGVXoIqs9iKltg1WfD3+3QPpjri58IwFSlQRG5Xb5/T+hSbiU4C1bpFQSiD
	 48icvZKTp2nVv4n15RGZ4/QNc39JFK5uO4FcGn9rVtRGOhpDZiUL14sivxNlrJXISW
	 8g4Ly4+WKKprw==
Date: Wed, 25 Oct 2023 14:30:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Hangyu Hua <hbh25y@gmail.com>, borisp@nvidia.com,
 john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
Message-ID: <20231025143051.6cfe4fc5@kernel.org>
In-Reply-To: <ZTmGl1BFr0NQtJRn@hog>
References: <20231023080611.19244-1-hbh25y@gmail.com>
	<ZTZ9H4aDB45RzrFD@hog>
	<120e6c2c-6122-41db-8c46-7753e9659c70@gmail.com>
	<ZTjteQgXWKXDqnos@hog>
	<20231025071408.3b33f733@kernel.org>
	<ZTmGl1BFr0NQtJRn@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 23:20:23 +0200 Sabrina Dubroca wrote:
> There's already a comment above tls_decrypt_sg that (pretty much) says
> out_iov is only used in zero-copy mode.
> 
>  *          [...]            The input parameter 'darg->zc' indicates if
>  * zero-copy mode needs to be tried or not. With zero-copy mode, either
>  * out_iov or out_sg must be non-NULL.
> 
> Do we need another just above the call to tls_decrypt_sg?

Sounds good. Right next to a line of code that people will try to
modify when whatever static checker they have tells them this is
buggy :S  Call site of tls_decrypt_sg() seems like a good bet.

