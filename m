Return-Path: <netdev+bounces-65276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB4E839D94
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 01:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC221C21381
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 00:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACDD620;
	Wed, 24 Jan 2024 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt6z1yNf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676415A5;
	Wed, 24 Jan 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055486; cv=none; b=dJJ+T8gbcTQwv+RGF23gv1R6w8h0rEPGuj2fW+uJUHOL676Irx8JdfLN85Vq1XWmD/K58Z3RwN7FrwboBCDDLGc5hPRMKrfYezupisjmZ1G71tbjNBxrWT5GZWW6P5FfH0gFyyPfVnA7IfPvUw67+bG86Ku7CJrSHMeb1/Ifrwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055486; c=relaxed/simple;
	bh=f1fX9doNgbnxpiBvF1j0flta1iVc3gfQxW1hXOcLdZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWE0S50vXPh/7mUAjyTPUNgLjTsfBR4L7OKJEMNYsFQ59dGyd4wLrJ2bu8hQPoYniz6B9pRk/WzUeLNjQECXfKqdga+tbj3VTkZurmc7iNapx6IALSCrIiECTSjC332jNc3TpWr4/yNnYSs8Q3rFhRg3Yj7jy7B2FwZZZeL4U8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt6z1yNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE45C433F1;
	Wed, 24 Jan 2024 00:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706055485;
	bh=f1fX9doNgbnxpiBvF1j0flta1iVc3gfQxW1hXOcLdZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nt6z1yNfWZVWNHA3fTLyEGooReRxG9J58+EiSCpWG1Xl/TExigLcGfuFqcXcZ4Q9u
	 oE0HwGa/lPrHS0qN77g3xg1y6PdMoFvG3F2dxqkWTTrPQwyc1f30spn4ptpXNBw6nO
	 1JaOC7dpOlzOyXofDbFBglUnOTVgeADJPO3A39kROgaTQlbtMJvRdfCp7/f/EYxng1
	 FLuBdgwJBT7tKnmX7wbgjuW6NXL0dFsEZRIlifGj4Dg6P2gR8mjRCBzGHyRMZRAWDN
	 HFtoh2vcRMtje1NbEkTu8UIasArk2gEmABjLC7uoaRPHtcVykXcL3cyzhHh8PyJlhA
	 SQCwx5sdxzYQw==
Date: Tue, 23 Jan 2024 16:18:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Breno Leitao <leitao@debian.org>, Jiri Pirko
 <jiri@resnulli.us>, Alessandro Marcolini <alessandromarcolini99@gmail.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
Message-ID: <20240123161804.3573953d@kernel.org>
In-Reply-To: <20240123160538.172-3-donald.hunter@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 16:05:28 +0000 Donald Hunter wrote:
> Sub-message selectors could only be resolved using values from the
> current nest level. Enable value lookup in outer scopes by using
> collections.ChainMap to implement an ordered lookup from nested to
> outer scopes.

Meaning if the key is not found in current scope we'll silently and
recursively try outer scopes? Did we already document that?
I remember we discussed it, can you share a link to that discussion?

