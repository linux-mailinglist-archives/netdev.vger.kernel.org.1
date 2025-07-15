Return-Path: <netdev+bounces-207159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B0B060F5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7948E506CC8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51548291C14;
	Tue, 15 Jul 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEIk0b2W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29254290092;
	Tue, 15 Jul 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588545; cv=none; b=A5PCsRYTG466NUqbOcrkBR2Na+s8FKWL6b/Tj2YL/0d1ldgcr3gQGrb2/2a9Anijk7Fcgd7+GYl6Db+GRwCqu6BMAB8EqeecYqb5ZnPbXPn+NmgbsAIu8j4x4YOXhIKiCU/dqm22XUvqcegCX2IXco6T0D1vCjfJlewDu8fFuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588545; c=relaxed/simple;
	bh=PEvule4Jhg4VNmsXzb7OFu5Fx/Vc1DjJYLGDHWfvyFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si+AhwT0d8X2dIvwhEnujPD/qK978OyqrKMbZYytUiOJaInmPxaxjQ5m3nBiwP7RKbzmgYDhR9u4PpHyB4e3h419ZUq7onDJ0uoT+mAdNWD38ibl2eHK51bsERulScaIMPkL7IUMMCVwsp7n1I2P89fpWy4+07nSiTCUqpxBaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEIk0b2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A2CC4CEE3;
	Tue, 15 Jul 2025 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752588544;
	bh=PEvule4Jhg4VNmsXzb7OFu5Fx/Vc1DjJYLGDHWfvyFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEIk0b2WBrutCdS8G/kYUTKOHVnd1V+dmDG4IKomL8NG3gKuOpTE/UXG6OM4NA6GP
	 RQhBpjOgnU0NOdO4wkZPoj8TexK/coROWDTAfV+11KYCuOBKneEyy3meE1CDklOhco
	 slyVIO5jlDLBUJC1sx8jEA2bI5/ZyMm2va1m68pjvxRm6xfVaM+MHk31EcFiENmXM5
	 4VOROeXep5kvXxkvMafMHcxZwqclis8qOUFuFpPoRjVHQBCyKBEcjrZtsrfV2YyccI
	 rujNLevAIels18NDBIwtz0jLJ2Lnw9vujyZQhEbJLTVM+Tb972cqvw6OO31TFS7FN9
	 GoWECU1/zLnQw==
Date: Tue, 15 Jul 2025 15:08:59 +0100
From: Simon Horman <horms@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
Message-ID: <20250715140859.GB721198@horms.kernel.org>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715001011.90534-2-admiyo@os.amperecomputing.com>

On Mon, Jul 14, 2025 at 08:10:07PM -0400, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Define a new, optional, callback that allows the driver to
> specify how the return data buffer is allocated.  If that callback
> is set,  mailbox/pcc.c is now responsible for reading from and
> writing to the PCC shared buffer.
> 
> This also allows for proper checks of the Commnand complete flag
> between the PCC sender and receiver.

Command

> 
> For Type 4 channels, initialize the command complete flag prior
> to accepting messages.
> 
> Since the mailbox does not know what memory allocation scheme
> to use for response messages, the client now has an optional
> callback that allows it to allocate the buffer for a response
> message.
> 
> When an outbound message is written to the buffer, the mailbox
> checks for the flag indicating the client wants an tx complete
> notification via IRQ.  Upon receipt of the interrupt It will
> pair it with the outgoing message. The expected use is to
> free the kernel memory buffer for the previous outgoing message.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

...

