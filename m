Return-Path: <netdev+bounces-236120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC80C38AAB
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34513B3CDF
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296131E32D6;
	Thu,  6 Nov 2025 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jigt7hQn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033F25771;
	Thu,  6 Nov 2025 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391504; cv=none; b=ambPfo+vqm2JR19VC05Lu1qZ84+A100IQt5f2qps0QloubEsiUdNpQNkwuTrPlmDU7QkQOj1FvQWymn3Ggz9P5ClL4XTZ+1e27meoa8YTHc/dTbBDT0wrnXApVGlxrFVz54gaVb3BRtyX9cXzVz5WEO91FbWzwIaPZXfqE6W7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391504; c=relaxed/simple;
	bh=rXfldVACt/gkpYlnhG6YdGv64PpVb80vtm91wnJSmNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rtqfbfvxng5mrW9mg5RJLNEW9UopjtGzFqfCC2tW+Kf06tuUjzpbNxAAFk1l8ntr4fPada6QRUYKvql66LItrS1O7Co155kxrkNU/5+YIO6v24+v0zLCSzqZlTkY9Cr1lWf50GG9m+UXavvnZVWSSakrpUsUDMWsetlV1OsA7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jigt7hQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0590DC4CEF5;
	Thu,  6 Nov 2025 01:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762391503;
	bh=rXfldVACt/gkpYlnhG6YdGv64PpVb80vtm91wnJSmNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jigt7hQncx+C/NC0ZcrjGP9G1O8wtvs4lbb6BL9w1NNnQlYEH2/iysPPlogl9hFsd
	 HDKyB1yHl2PAbvX6coXPGHhYQV7JNVdXmyj55BlgNIKnOKisUPyubRhTDOxCh9FmMY
	 +LfNmlxlw/G7MqPDARIfSswIWjsF79tElMykm3HY8Svskm8PYO5F7Z7MQQA4/A49y7
	 ezV0SO11i6aSJPRGFU2Fp/ZxTrPc/SX3NxyRUkxiXNIM0u9bZPE7Th2OIZMQbsVArx
	 HdcsrFz81Hd0yjWvQQcO1K5mzROApOqRnJuQmQfSAIFTUNMzL7E9Y42xBBIXTF2m5z
	 jITUzSH+DfJhg==
Date: Wed, 5 Nov 2025 17:11:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Joshua Washington
 <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, Vedant Mathur
 <vedantmathur@google.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC
 page_pools
Message-ID: <20251105171142.13095017@kernel.org>
In-Reply-To: <20251105200801.178381-2-almasrymina@google.com>
References: <20251105200801.178381-1-almasrymina@google.com>
	<20251105200801.178381-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 20:07:58 +0000 Mina Almasry wrote:
> NCCL workloads with NCCL_P2P_PXN_LEVEL=2 or 1 are very slow with the
> current gve devmem tcp configuration.

Hardcoding the ring size because some other attribute makes you think
that a specific application is running is rather unclean IMO..

Do you want me to respin the per-ring config series? Or you can take it over.
IDK where the buffer size config is after recent discussion but IIUC 
it will not drag in my config infra so it shouldn't conflict.


