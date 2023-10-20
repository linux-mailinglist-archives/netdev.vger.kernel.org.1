Return-Path: <netdev+bounces-43090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA20D7D160E
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55F11C20A5B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F6208CC;
	Fri, 20 Oct 2023 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8FO8PL3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CAA208C2
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 19:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41AEC433C7;
	Fri, 20 Oct 2023 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697828678;
	bh=LCXmArATLRdEdMhrP5wy5aw0KH7d4QFffhPe4PUzoNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F8FO8PL381Q2eyz9tIjDV+u+8FLcqaI13wAjd0Mg84Cu0Jk/MJhVSjeKu9yw9muAZ
	 LWtewS/H8ptRf7I3hbcUd7yuku2hUtPN3Fz6LKzEH2u9SXHZDVMF61Rlq+494nFGHe
	 T7jrphph4iaUIWYP5uXHzL2FPtXBU6kLs/4WjKqw5vuYXh5Rbb/tKPxwMq/KLadv+O
	 BBhrwylnS4tuHJ/C7x0xjLg4/ZHrJweyreinL9XytmUzTgQX2rFN/W6k9+tMMUHy6w
	 V8tfCUTc6Snop5h2r2iLDdkNQEtKktOrv0bmQT7xbWMHEJSWB1YrQbOvE0K7u8mLJP
	 fN7HLeyEp10JA==
Date: Fri, 20 Oct 2023 12:04:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au, j@w1.fi
Subject: Re: [PATCH net-next 4/6] net: trust the bitmap in
 __dev_alloc_name()
Message-ID: <20231020120436.7fbed61c@kernel.org>
In-Reply-To: <ZTJYpx5dn4UPa2/j@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
	<20231020011856.3244410-5-kuba@kernel.org>
	<ZTJYpx5dn4UPa2/j@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 12:38:31 +0200 Jiri Pirko wrote:
> >+	if (i == max_netdevices)
> >+		return -ENFILE;  
> 
> Hmm, aren't you changeing functionality here? I mean, prior to this
> patch, the i of value "max_netdevices" was happily used, wan't it?
> In theory it may break things allowing n-1 netdevices of a name instead
> of n.

Good point, I should add that to the commit message.
But we don't care, right? Nobody is asking to increase
the limit, feel like chances that someone will care 
about 32k vs 32k - 1 devices are extremely low.

