Return-Path: <netdev+bounces-130150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01467988AA2
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 20:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D26B21CB8
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 18:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7C1C2DB6;
	Fri, 27 Sep 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ0y+UUP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12F21C2444;
	Fri, 27 Sep 2024 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463384; cv=none; b=HoeCpLuAXyGfbhupX2cgRy0zIRo9mXG7wZz0pAkNnHtse1Uv2WSV4366VlQ6wZEUHpQe7OJhaXuBdlWh/2VNupsMazMk8e8ge6TB4EHi3dd5V+hj1c6b6wLdDX1Kj2vTHVFLFASywWM1HbNtUXANlMrAcsF7cVLbpfipFrQ5NUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463384; c=relaxed/simple;
	bh=57UfqbKak0MuDn5v35SpDlQoLJzb6ja81y08Z0VmtB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJbND/RFNU6iUEeRD1+ra7T/0YptCBgzPeSfj8OcRdeOBg+qVLdP1Urdhrh2+ZQB/670BZwBu7F8MSDgkWb8kHlAensSL1+f/Qd6ps56spa7pPMAMr+OidYLU93Z2qDQ1Hapk3w6YlRpdeezPrAEPrp+cUwQq5In1RcbF82Fn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ0y+UUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3209DC4CEC4;
	Fri, 27 Sep 2024 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727463383;
	bh=57UfqbKak0MuDn5v35SpDlQoLJzb6ja81y08Z0VmtB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJ0y+UUP743BQag0pLdQe7PMQAGG7hbpp89GtkchAi2M9krgw0N5KirXj7QQNxiAu
	 w7bU6wc5T+jaEl66Ir6I2N5ws55QBYRSrbJqAdWxGp7RFtKyXGzX5uJhzmluGGg4Ln
	 HwrES4W8GTB8S9TQ4/lIim1u2M5WAKkIXvKxC9AMxBtCVNo90fdg2vbGy3L+JvYUrx
	 5aLnZJvcXRyVIapREz+VfSLU+r7WP+QFEeMKB7Wx4O3oQZXJN4D2Z3p2izm8ryd9yr
	 +FRu6q3EDfW9Ss9f4whiPzkkas4vof+F3BPVQlV7bmIooDAMiOGpkY0BOXMwjB2vQO
	 kcFBUK2zVWp3Q==
Date: Fri, 27 Sep 2024 19:56:19 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/2] gve: Map IRQs to NAPI instances
Message-ID: <20240927185619.GN4029621@kernel.org>
References: <20240926030025.226221-1-jdamato@fastly.com>
 <20240926030025.226221-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926030025.226221-2-jdamato@fastly.com>

On Thu, Sep 26, 2024 at 03:00:21AM +0000, Joe Damato wrote:
> Use netdev-genl interface to map IRQs to NAPI instances so that this
> information is accesible by user apps via netlink.

nit: accessible

Flagged by checkpatch.pl --codespell

...

