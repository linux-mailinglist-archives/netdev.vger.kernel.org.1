Return-Path: <netdev+bounces-160234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5549A18F50
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94E13A319A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612E2101A0;
	Wed, 22 Jan 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7K9KGlh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6216BE3A;
	Wed, 22 Jan 2025 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540669; cv=none; b=ikdHOe6hTPxtB+CpGiug+AWFEJI31jGmKmDB9nxL68rJFZ77JMF1Fw6y872GciyzHzRhhSvzQt6dgVfWTWBcLE0Eix0seIN8caj0mP1h8ssQ4+sEruBLaPgqHsWEgg3mhEPw83gOf6DTxaL87W7pPkCRruHhVPqOsY0H9YLMBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540669; c=relaxed/simple;
	bh=D9w/pMsns+WhsexWHwjgDMkbkMbWFRLCfpie+u/t+Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJkMP/Lweh8JtGWsv0xrWuCARUUXUUIyPRtWw1p0yHJF1/resQJvqKAxXMbtfmiMMhccfnxmjIZsDOemqMdJ+rvCxvaa4f+oqaWduw2MeY//TX0mnHSqtG1Z+rvAn4EnHLAXf3PxSWtwKVE/xS2DL2pNGrVVvCVXwNOyWeAPnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7K9KGlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EACC4CED6;
	Wed, 22 Jan 2025 10:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737540668;
	bh=D9w/pMsns+WhsexWHwjgDMkbkMbWFRLCfpie+u/t+Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7K9KGlhCcJDR+t52l4yjftsVH5j1vTfOmHKyudlc2hogYUPMChwsbUwjxpJeq6ff
	 fL2hUYMRG9Ztwf2KB2TUexzF8knuLjOzme9vWOpkmvXZcZzVlF9sCXCX2J11KEw6Ok
	 scFjXRspfHsoylw0tDKsqnPBI+WQ3OwC8yhKW5jIWYqRUPyqjlpJs/pjFMG8bQrFPL
	 nTnL8wGf2gUMc514aTCFQlnyRtE5N9kYkyivuH3/4ZQxa0Is95XxMoI5Hj/tKlXfME
	 QgbCTIUOAmI4QYYESH4d6qM9mEfNxy9d5doq+OhKU742vmlc3MREi23zLN/M4DtMYz
	 ewCvUPGmDlqhw==
Date: Wed, 22 Jan 2025 10:11:03 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christophe Ricard <christophe.ricard@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] NFC: nci: Add bounds checking in nci_hci_create_pipe()
Message-ID: <20250122101103.GD385045@kernel.org>
References: <bcf5453b-7204-4297-9c20-4d8c7dacf586@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf5453b-7204-4297-9c20-4d8c7dacf586@stanley.mountain>

On Fri, Jan 17, 2025 at 12:38:41PM +0300, Dan Carpenter wrote:
> The "pipe" variable is a u8 which comes from the network.  If it's more
> than 127, then it results in memory corruption in the caller,
> nci_hci_connect_gate().
> 
> Cc: stable@vger.kernel.org
> Fixes: a1b0b9415817 ("NFC: nci: Create pipe on specific gate in nci_hci_connect_gate")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Hi Dan,

Based on your analysis, which I agree with, this looks good.

Reviewed-by: Simon Horman <horms@kernel.org>

But this is a limited review, as I am not sufficiently familiar with NFC
to go by much more than your analysis. A review by Krzysztof would be great.

> ---
>  net/nfc/nci/hci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
> index de175318a3a0..082ab66f120b 100644
> --- a/net/nfc/nci/hci.c
> +++ b/net/nfc/nci/hci.c
> @@ -542,6 +542,8 @@ static u8 nci_hci_create_pipe(struct nci_dev *ndev, u8 dest_host,
>  
>  	pr_debug("pipe created=%d\n", pipe);
>  
> +	if (pipe >= NCI_HCI_MAX_PIPES)
> +		pipe = NCI_HCI_INVALID_PIPE;

Ceci n'est pas une pipe [1]

>  	return pipe;
>  }

[1] https://en.wikipedia.org/wiki/The_Treachery_of_Images

