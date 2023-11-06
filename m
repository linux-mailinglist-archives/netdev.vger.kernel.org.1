Return-Path: <netdev+bounces-46273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817AF7E2FE9
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39055280D00
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC08E171D3;
	Mon,  6 Nov 2023 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLEuc1hk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5032FE07
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 22:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0757C433C8;
	Mon,  6 Nov 2023 22:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699310221;
	bh=KnWg66fiIqkuYC0T/uFVfOj96qkrkHSpP3jCOZgXqgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TLEuc1hkIODtMEb3BiwZxEdqxQNP2v/9+Vxrf9wO1ngAh2Y9Sh1qOna8RrRNd+nl0
	 Sl7vPPFM8PF5IvkFwHXWdS0URA4bjMwiAY32r4Hv4GgiYbKRqiefcu6nzpz9kXXph6
	 dAFD2AKiRFIwjLT78caEFOCL9/THb1cmSJnXMXB23XOtsffvaFemIP7RohRuXBYT1x
	 /fianyyDso/TKsa42ivVLRJShe5XenZ6araTmF1UXty05qjIU2QVTPH3yLCCXYGBsG
	 LAdsaEnxlVkS1jTGmAAPoAmUvD7Sq27ekga6JWMh9wQO1CLZsgqiapUU9zVryStzBi
	 mO0nCwIefHa5Q==
Date: Mon, 6 Nov 2023 14:36:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Dae R. Jeong" <threeearcat@gmail.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: Missing a write memory barrier in tls_init()
Message-ID: <20231106143659.12e0d126@kernel.org>
In-Reply-To: <ZUNLocdNkny6QPn8@dragonet>
References: <ZUNLocdNkny6QPn8@dragonet>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Nov 2023 16:11:29 +0900 Dae R. Jeong wrote:
> In addition, I believe the {tls_setsockopt, tls_getsockopt}
> implementation is fine because of the address dependency. I think
> load-load reordering is prohibited in this case so we don't need a
> read barrier.

Sounds plausible, could you send a patch?

The smb_wmb() would be better placed in tls_init(), IMHO.

