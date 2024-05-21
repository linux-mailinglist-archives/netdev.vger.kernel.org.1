Return-Path: <netdev+bounces-97370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256E98CB1BE
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 17:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A8F1F23490
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8866148301;
	Tue, 21 May 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ficKUcQ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D31FBB;
	Tue, 21 May 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306891; cv=none; b=JELJqdoc/FGWIkdfxQjWaTzZGRSTIAuGDbdMO6Dx12FXFT31ILQLnpkVYzebe8AT+22u06H2Wyuc9vDTsl1ic4htH2z6wTx3MCtF4vJyLrTqcL6GR0NHmkbT7QUn73JFMZRikpqhO1Z1mZA9y4JZOdUaS31AAnlBymRZWofA/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306891; c=relaxed/simple;
	bh=ZiVylaIhpmU5Y8L5i/SnpTaX9nQlLaIxh9KusDNt/0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpINgXWYOrwsD4MBjA7rrIT5IaFQkjdXaOoJuuKS98nc7a/h+t0djrCSXzO3QUrUrDINJccndi6Yn89NuW6GR4BafSYpwOE1im6f5ZFpwHwBJM7h8q91JrZIwiWHixt8rAPK19sNQk4uklZysGdOknh2vJ1b9iB824e//KC5Dcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ficKUcQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA61C4AF0D;
	Tue, 21 May 2024 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716306891;
	bh=ZiVylaIhpmU5Y8L5i/SnpTaX9nQlLaIxh9KusDNt/0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ficKUcQ1Rlp3RRbru0nSthZ9Uzc2zECFLSArZF+Vf7KqkzQ7XxyWFHrpz7bZ9O1vz
	 7sLnUe+3scjTsJg4VHrQJy7gNszTmzQP0cNvYOTaCXHW68de3vyWnZUJZHBINmJuaD
	 J7pR5CmQBb6bFjzhsK4VRZUkRLE7QotGW7hWYC/0Hab7jQjS8XXvCUtpNvlZ7H8ADM
	 EpLPNdOiQZlrf5aUO0fS08ScQWeAR4Qm8/5EGVkPho8v0JedicM5EW3Ka3CQH1O7PH
	 L4EtClo2MfNqL66YJkSwfiwHpbiCHW9AkYwqAzZwB7w0hSnZMargpH7LoHndxuYVgx
	 QixH0o3hqqqVg==
Date: Tue, 21 May 2024 16:54:46 +0100
From: Simon Horman <horms@kernel.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com
Subject: Re: [PATCH net v3] nfc: nci: Fix handling of zero-length payload
 packets in nci_rx_work()
Message-ID: <20240521155446.GA839490@kernel.org>
References: <20240521153444.535399-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521153444.535399-1-ryasuoka@redhat.com>

On Wed, May 22, 2024 at 12:34:42AM +0900, Ryosuke Yasuoka wrote:
> When nci_rx_work() receives a zero-length payload packet, it should not
> discard the packet and exit the loop. Instead, it should continue
> processing subsequent packets.
> 
> Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> v3
> - Remove inappropriate Reported-by tag
> 
> v2
> - Fix commit msg to be clearer to say
> - Remove inappropriate Closes tag

Reviewed-by: Simon Horman <horms@kernel.org>

