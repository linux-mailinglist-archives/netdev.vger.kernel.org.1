Return-Path: <netdev+bounces-131210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B146D98D39D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A4C1C20FB7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07251CFED3;
	Wed,  2 Oct 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HunxoXgS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B751CFEAB;
	Wed,  2 Oct 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873272; cv=none; b=tTFqkx0emWQY1xi3ACZKHJjUc0Gbl7eNhKfhU6YB6EQK91Csp3Cz3kceLJima9B43wqpQgzWspjmgX6fP9K7Pey0+pQz7UPcbtRL42ie7ETSc8wqe1uwRGuw1WsYQrQdr/ZoE/10F8XdeyD6pBvLStCpsc1D1aHbYV48JopYq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873272; c=relaxed/simple;
	bh=q2M1UncY/ShMFeFvU9PA2GVWUuuVAbr/OxsWC3h12k0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5r8Mr8M+AOU8of/8SqJtfkLJ7NU3MTGyeACyKXx+XisctZLmouQNV7r6wMrehKSz/ENT91akNVduIXO+o8hH45ElFTkAoXO3hrJ2PWBI/0cT68fQ7+7wpp/zHIxxsRWObsKqZmnmDHuTLBIr/FmB+DlnEwcLXfRxM7s6cwheoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HunxoXgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A44FC4CEC5;
	Wed,  2 Oct 2024 12:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727873272;
	bh=q2M1UncY/ShMFeFvU9PA2GVWUuuVAbr/OxsWC3h12k0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HunxoXgSEFtPrezT/RdHFbl4G/1QU25Ngvu+mCicdZhdqIFy77PsIj9XHvXWMffZm
	 DdoNdZUUvyklPXQ+uQPSJblQxixt9XjZjH6OTWLjzcSL694/vIbX4WaFRrGQob3DWq
	 Qv0d4KCQwCY6WouTZE4mVaZCnNpBxgIthOTutswlNVFv+oO1JlNzRT2iPNSlQwDfwA
	 95YJgVgFv0krE7AlanUn13PPqKKOWbpcOQN4FhMiAuU/lHBVFpBLlStnR1AAl9Ulr6
	 cWMdKUDAtTtwbp+4srag8eG6bjeltwgKJK2buhaWnz86BgSrZylbYzI/Upu7/3UPIB
	 /QnJo1baz2hrA==
Date: Wed, 2 Oct 2024 05:47:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
 <lars.povlsen@microchip.com>, "Steen Hegelund"
 <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
 <jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
 <justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
 <jacob.e.keller@intel.com>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 06/15] net: sparx5: add constants to match data
Message-ID: <20241002054750.043ac565@kernel.org>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-6-8c6896fdce66@microchip.com>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
	<20241001-b4-sparx5-lan969x-switch-driver-v1-6-8c6896fdce66@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 15:50:36 +0200 Daniel Machon wrote:
> +#define SPX5_CONST(const) sparx5->data->consts->const

This is way too ugly too live.
Please type the code out, there's no prize for having low LoC count.

