Return-Path: <netdev+bounces-108878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C44E926222
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B72285675
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657E17E46A;
	Wed,  3 Jul 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhZqQnIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF917DE0E
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014416; cv=none; b=fL40HKwDDEG+dl5kFkxA5kapn+6kEXRnNZm7edaHUgDM57t4ffHhvhP7et5DiQRFiloinu4Wyv80ItJ0NVGf4Lfgy04YXjEettzCvLa3kX7tYxc7X2N4PjLsair6nvE72TW2V7Bfb2FvoSfPId61fHHXL22QdoZk4QILr273qmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014416; c=relaxed/simple;
	bh=OHkW+z2KYh30J4aj3T1zTKjFAOgZWX9k3A5e2X0IPCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Drvb3yN4EogJBIfrJVP18nolC8x5ArjEHACIYXLzzjgDr6ePg0vEbDROu4uxYEktwPR5yoOY5gt77sBv9Y92kwx33MpVe0K74QG0IHu5fNdgeoqINYTAea9VPR/3T41K86LQ8ZJadeOS84f6mrJtBMU37XemaljWRtDethvg8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhZqQnIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8BFC2BD10;
	Wed,  3 Jul 2024 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014415;
	bh=OHkW+z2KYh30J4aj3T1zTKjFAOgZWX9k3A5e2X0IPCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhZqQnIpnrDkFobig/z/zs7SSNPguzokSsmEU2ica/0/fJZsGwgOsOUk55RH4EZyI
	 aaBr34Hr0X87mPyjoxoXzq2OnTa8jO+T2XeK0gTxaUUToc2av03eP9Xq6Z9fB0Q3II
	 jiLAy+gAuu+ChMcV0a10DJbS17csFyHS8A0MsQHuoKH/GxdG7mYMtwRCAYZ0SrSw8n
	 EAnZgchTnJ5N+rpL8g84L8aaPk4I/L7GVMBi8SpXEBrxxAbRoeavKmrsaO/1gNUY3v
	 piQgTx6KyY/wYCtvv3G9xiqUc4fyl3e3OdoJmndr6cn9vcIShU0M7X8SaJYpe7vHl8
	 f5bKd9ozl+8ew==
Date: Wed, 3 Jul 2024 06:46:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com
Subject: Re: [PATCH net-next 04/11] eth: bnxt: move from .set_rxfh to
 .create_rxfh_context and friends
Message-ID: <20240703064654.21d67f36@kernel.org>
In-Reply-To: <CALs4sv33AdVBNomJ-tnZCmn8BeoPvVsSx9s0VUhocHmbp-AE=w@mail.gmail.com>
References: <20240702234757.4188344-1-kuba@kernel.org>
	<20240702234757.4188344-6-kuba@kernel.org>
	<575edb3a-3c52-0bcf-4c19-b627dc99d2e5@gmail.com>
	<CALs4sv33AdVBNomJ-tnZCmn8BeoPvVsSx9s0VUhocHmbp-AE=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 18:19:18 +0530 Pavan Chebbi wrote:
> >  has any opportunity to say ENOMEM, or whether the driver needs to
> >  validate against the hardware limit itself.  Hopefully Pavan (CCed)
> >  can elaborate.  
> 
> Because the driver is not aware of the hardware limit, and the limit
> is dynamic, we can rely on FW to know if the resource request we made
> was honored (there is no direct ENOMEM mechanism)
> The driver already does this when we make a runtime check for
> resources using bnxt_rfs_capable() when an RSS ctx is being created.
> But for this version of the driver, I would prefer to keep a limit
> because we have some FW improvements coming in, in the area of
> resource management.
> Though removing the limit may not break anything, I'd prefer to have
> it removed once a FW with improvements (indicated by a query
> flag/caps) is available.

I like keeping the limit too, FWIW, it'd be great to give this info
to user space in due course to let it make more informed decisions.

