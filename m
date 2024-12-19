Return-Path: <netdev+bounces-153395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB19F7D4F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1487116C40A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B5E225775;
	Thu, 19 Dec 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKIvtwyv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7541C79;
	Thu, 19 Dec 2024 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619535; cv=none; b=KimzroPHi3FqQCluOcK6bM1hIXBcb4V1S25NHjFWhh6UqFLo4Ddnc0U6n3jTi3xhcNBIITYh96L+8qFDeC2EKYdoFXUDgn5HWi/3RqbpRjMTqHBhklRUrbpgv1t47aQRNlR/Hd+wZUWE7t1xLiig1EAXdkHh88peBj6uDRtBh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619535; c=relaxed/simple;
	bh=6f8nqFn0DLcwByMUHHSmStBbq0eGOyRVrO+eVq/o75Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrxPZfG8qQ/fWekMIbVUPAayvDO8HcOyqB+4X8cpfZuz1mofgi+8kRgR58mxOtexWA+ZEiTjHGG8k2tddZuL+MeLUfOTwK80wVKUlsrAzY5zUHQZpFabP+ehIm77XJeAnRAVi2KRI1HLS0YUBokh2eSY+dQuxjoDkYXUgKcRlpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKIvtwyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C8BC4CED0;
	Thu, 19 Dec 2024 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734619534;
	bh=6f8nqFn0DLcwByMUHHSmStBbq0eGOyRVrO+eVq/o75Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vKIvtwyvfeCj5Ufr/H19zzXaqNRtYZweUOhLxxP9xXGkin6a1ks/l9IlBWt/LH1Ok
	 5BJPmw/yr4tdoFYyaJ8NqwmN4hLHcVoCqH62qmC/d/L0Nbipsw1ODel97Wk+quwWuQ
	 YsJBhS2PRI/r+ocd4ELx8mfhgS4QM6/MDVs9ft1eS+BmfPvYE/rY/wFEt+ebAMwRZU
	 zUfAaCI4MW+YHn4R0ZnYvDOVKOwGykrWuRTvQArMZVs55gODKUf9YYgSwzdsyustPs
	 xLNrSK1DIBpMzqp9j+BU3PIwYbabRBsdGhT+JXwUzIl+90nUDNI/i1YiL4QP9VDXw3
	 9F16IExEq+Sag==
Date: Thu, 19 Dec 2024 06:45:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v6 9/9] netdevsim: add HDS feature
Message-ID: <20241219064532.36dc07b6@kernel.org>
In-Reply-To: <CAMArcTWH=xuExBBxGjOL2OUCdkQiFm8PK4mBbyWcdrK282nS9w@mail.gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-10-ap420073@gmail.com>
	<20241218184917.288f0b29@kernel.org>
	<CAMArcTWH=xuExBBxGjOL2OUCdkQiFm8PK4mBbyWcdrK282nS9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 23:37:45 +0900 Taehee Yoo wrote:
> The example would be very helpful to me.

Just to make sure nothing gets lost in translation, are you saying that:
 - the examples of tests I listed are useful; or
 - you'd appreciate examples of how to code up HDS in netdevsim; or
 - you'd appreciate more suitable examples of the tests?

:)

