Return-Path: <netdev+bounces-42464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6E77CECC5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 02:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A343B20DA5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24A18E;
	Thu, 19 Oct 2023 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8jNVxjw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87049361;
	Thu, 19 Oct 2023 00:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2589C433C9;
	Thu, 19 Oct 2023 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697675275;
	bh=2nh52jDJ6PylCe2C2NgD1C26nReaVji3095976lKB7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F8jNVxjwwNREaqtRMYhgWQLYcGrhhAcFqAvHSRLvDEMXpLEpQc5vcEyuuBIlaLBCc
	 8eYPCv/oKbh9BlkdyIo0MoAgFO+EVrmwbn8hPcy5+rAmK6c+Th3k3zd6r48xwfnMOC
	 npMX7cw86HSBBrcNGpXgmUSlyjScWsxfCRIcDMtF52OzyVtZZsdDRJm3NQOwMcWrfY
	 H/5Uy8uNIG7mc8qcgS5ZZOwjFMoy4r5jNBWCoc4fIHcO/NDB7C3gJOuOQ66wFZpkU+
	 2q2A4H6YDDL2cuC9g+fEzYj4Y/XKBwus5qeGAG/hbsj/6EszF8rXcnfkDo//f0fQ5j
	 6MCqABy3D2JfA==
Date: Wed, 18 Oct 2023 17:27:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Alexander Potapenko <glider@google.com>, Eric
 Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Simon Horman
 <simon.horman@corigine.com>, netdev@vger.kernel.org,
 linux-btrfs@vger.kernel.org, dm-devel@redhat.com, ntfs3@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] linkmode: convert
 linkmode_{test,set,clear,mod}_bit() to macros
Message-ID: <20231018172754.3eec4885@kernel.org>
In-Reply-To: <20231016165247.14212-5-aleksander.lobakin@intel.com>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
	<20231016165247.14212-5-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 18:52:38 +0200 Alexander Lobakin wrote:
> Since commit b03fc1173c0c ("bitops: let optimize out non-atomic bitops
> on compile-time constants"), the non-atomic bitops are macros which can
> be expanded by the compilers into compile-time expressions, which will
> result in better optimized object code. Unfortunately, turned out that
> passing `volatile` to those macros discards any possibility of
> optimization, as the compilers then don't even try to look whether
> the passed bitmap is known at compilation time. In addition to that,
> the mentioned linkmode helpers are marked with `inline`, not
> `__always_inline`, meaning that it's not guaranteed some compiler won't
> uninline them for no reason, which will also effectively prevent them
> from being optimized (it's a well-known thing the compilers sometimes
> uninline `2 + 2`).
> Convert linkmode_*_bit() from inlines to macros. Their calling
> convention are 1:1 with the corresponding bitops, so that it's not even
> needed to enumerate and map the arguments, only the names. No changes in
> vmlinux' object code (compiled by LLVM for x86_64) whatsoever, but that
> doesn't necessarily means the change is meaningless.

Acked-by: Jakub Kicinski <kuba@kernel.org>

This one can go in with the rest, it's trivial enough.

