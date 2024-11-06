Return-Path: <netdev+bounces-142145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB79BDA62
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F81E28279D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77BA1F16B;
	Wed,  6 Nov 2024 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZlHQFGR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F84F9F8
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853308; cv=none; b=of3ueq7uKObjaNyol+TBExPFA2/gMCsaIPt6/fxc5PTxKZqeQQk9ZdDymzBXGF6Jc8sfuz/D5gK8ftWaCOstTe2dVMlL2qAl+OppUZsNZss2+Eml+zabVydhPSUxoGg2rKY8pzuBG6zG+Stz1inRahK/2mbqLQJeUc1xYFeA4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853308; c=relaxed/simple;
	bh=abHsAM8OoFtNL7dY12AIpkGwRdYACW49sgl5d8uBnBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peoOCipGlafVQoqDGXjR1T5veXpdSYDmKEDKG/gXwom/PNlI9y7wIn3n+5+274an2mB0vYl/wkYgyDpomBmPy6vCW3YOlgrbIFLVme5ZIA/6IJoYmGZ8P4DkO1/dIh2YOvJtxG+6a4rYB4ch+Rcalidmo0MZfcxMq/MiwjJ44Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZlHQFGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A551FC4CECF;
	Wed,  6 Nov 2024 00:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730853308;
	bh=abHsAM8OoFtNL7dY12AIpkGwRdYACW49sgl5d8uBnBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DZlHQFGR9O65wR/UjmK8W1jACZt5PYLgoLGbVrqfSEMZkj4LJ0lF11nBg/2URKztl
	 eorWDxIzOp8Z/sJTw/qW6173cjuDFE6f4/WtH7ERciODWLGCGxGyFGsIlkbAecD7OG
	 ohPLYKegDyXFr9JjsxDZL6vlrV97COIxn/oh8VFtr9hu+kdxicKMGDQ5zOGLVDlewk
	 8shIuIkK0jK5B4zRqdR2CZlWTCe2+Oxl8mujJUJydu2NzoHbAQuWU4DuEzncBX+lCi
	 S5uXYk2RzyqARJjAsZFsiLYvuYLvm0K5HD4ncppnpMRsvaxQ5q2BpJh+Fi4TjU8NRU
	 niEA6+auWkgVQ==
Date: Tue, 5 Nov 2024 16:35:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov
 <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 1/8] rtnetlink: Introduce struct rtnl_nets
 and helpers.
Message-ID: <20241105163506.7491f5d3@kernel.org>
In-Reply-To: <20241105020514.41963-2-kuniyu@amazon.com>
References: <20241105020514.41963-1-kuniyu@amazon.com>
	<20241105020514.41963-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 18:05:07 -0800 Kuniyuki Iwashima wrote:
> +EXPORT_SYMBOL(rtnl_nets_add);

Will you need the export later?
Current series doesn't use it in modules.

