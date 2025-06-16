Return-Path: <netdev+bounces-198207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB53ADB966
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD703B2516
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FBE1F473A;
	Mon, 16 Jun 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWOR9q/D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BB1C700D;
	Mon, 16 Jun 2025 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101476; cv=none; b=mEo/PiKxnpEP3Ck9Ol/p6q5CWJ+NMB2rUQ1yLgZ+JWe9ygtSVWJ0ct/23Hw4RygGddcbcN1Y931nxbAh3DY6mGaoKZmyuxN4l9nrLfMvdjhgSh7Rn9YhqXJ+aBiWfk8oLvvLe1JM9Dm02NGS7BGcZaQG7y1D+jItKZpcLLw9Oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101476; c=relaxed/simple;
	bh=CoAMun8R7pN+jZjFgrOl5n9fazsstR/Wnm3bSiQFnwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8DbTWVRhTnHOnrtwCQVd0nF4WHPCnW4dm+7Tj/m+BxRMC062CRU7dUDLYBHhPRtEATG2zLaI0aDSJfBE7k/BiaiiJTuCT9fWVizfsl7d1gsnvJjfs1v+97ZtizZUw96VnwsY0F1CTNKPhA7g4FN6d8zFoKnlCRUv6qjyUbPhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWOR9q/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F313DC4CEEA;
	Mon, 16 Jun 2025 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750101475;
	bh=CoAMun8R7pN+jZjFgrOl5n9fazsstR/Wnm3bSiQFnwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWOR9q/DL5dmtOWTs8z1Rd9159DcaIblk9pMRjbqtHX5ZX9p0/PUXEb+3xUHWhusN
	 HOiUJYoQmMuMl103MHhUNmczer3K8E02XylGXcD4Qoh7ubgy1irYoBq8BwYA77Tu/s
	 Lj11kLYuF/afpFA++39N+VzqnNDsdFP8dW2lN2kQnsSQdPzebkbleZK/SMhGsxTUD6
	 SQXrUmViyaqJGu5ZWkyXIGGoR3qRJiifQe5HnMI3lSiWDdS5tLj5/3XCY6W5Pla3zM
	 3odnsvfVcVr72qfze7Hc017uP6nc5vQaRWpRbsDrzVXxF9WcWCycv/8xqb1qZvIw/Q
	 YKWt/CreJQ30w==
Date: Mon, 16 Jun 2025 20:17:50 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: David Thompson <davthompson@nvidia.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, asmaa@nvidia.com, u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] mlxbf_gige: emit messages during open and
 probe failures
Message-ID: <20250616191750.GB5000@horms.kernel.org>
References: <20250613174228.1542237-1-davthompson@nvidia.com>
 <20250616135710.GA6918@horms.kernel.org>
 <ecadea91-7406-49ff-a931-00c425a9790a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecadea91-7406-49ff-a931-00c425a9790a@intel.com>

On Mon, Jun 16, 2025 at 04:06:49PM +0200, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Mon, 16 Jun 2025 14:57:10 +0100
> 
> > On Fri, Jun 13, 2025 at 05:42:28PM +0000, David Thompson wrote:
> >> The open() and probe() functions of the mlxbf_gige driver
> >> check for errors during initialization, but do not provide
> >> details regarding the errors. The mlxbf_gige driver should
> >> provide error details in the kernel log, noting what step
> >> of initialization failed.
> >>
> >> Signed-off-by: David Thompson <davthompson@nvidia.com>
> > 
> > Hi David,
> > 
> > I do have some reservations about the value of printing
> > out raw err values. But I also see that the logging added
> > by this patch is consistent with existing code in this driver.
> > So in that context I agree this is appropriate.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I still think it's better to encourage people to use %pe for printing
> error codes. The already existing messages could be improved later,
> but then at least no new places would sneak in.

Thanks, I agree that is reasonable.
And as a bonus the patch-set could update existing messages.

David, could you consider making this so?

