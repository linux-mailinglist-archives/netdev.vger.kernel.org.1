Return-Path: <netdev+bounces-157805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF42A0BCC8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F709166BD7
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202C41FBBCE;
	Mon, 13 Jan 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6UNLdeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5314A0A3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784068; cv=none; b=qd731ITBo59pY7vBK5ELSg9MrrMIfsRRAX1kpT571hOPDV9R3ZJ1IV2pSQqCMDW7zbAv77fe/xxzDcPCwwFIPnQbia1Na03dnMepmav5CCiKyInR/lT391g/23L++rnAMB7vpRVUsFHfQuj7qoo/HduJ9xq6Vl3G8WFKpIPVhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784068; c=relaxed/simple;
	bh=WQ7M7LXL7bpX6VtWtK+NmePRtg5JA7Lifi4147tgL88=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M0zZ1635KsFJhjZvloL6uiuzM01q9vfMEg1KTR+5RhkecjvIwTY/Xb9r6hmtjhm5Y50AGCful9KN0xV/6ZTsGR3wXt8E65/IVq17oGnjgFiURZbSjAsymDniKgOjHF2sVFzYFHurxrgrweLSg2nL1FyUzCNoSaMk9UeBT5vJjIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6UNLdeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E89C4CED6;
	Mon, 13 Jan 2025 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736784067;
	bh=WQ7M7LXL7bpX6VtWtK+NmePRtg5JA7Lifi4147tgL88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=l6UNLdeYnt6DGRG+7E6QvOHvzcFRJzr4BtH4QA+npqvcMDpCLxpVibZmHeRCGkkW+
	 4w92N1r2zIkFt+oUT+ePc2zGFi+mZkdEwte5AIfw8wViFZkn/htfLT2qfWTKVYYt+3
	 qDh6JMWssIQdDwmtMQL1gO79STFw1C7uhm2S4Ekczqz+n1nVkdkExxafU6IL7cXzRB
	 +E21IqyXISYdwK9TG1yV1iDvCgIAlk+1y5WOkHp20/8ekVlYlR3rMFuNUwAYL7STZP
	 +J9eTBWqDke3uE4nHVFUnh5xhlJFEmHFZGqX0u19N+CfKO9/2dHGwPsETRUKjNXw5I
	 w3t+FTEbBMY9w==
Date: Mon, 13 Jan 2025 10:01:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 09/10] bnxt_en: Extend queue stop/start for Tx
 rings
Message-ID: <20250113160105.GA404075@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-10-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:26PM -0800, Michael Chan wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> In order to use queue_stop/queue_start to support the new Steering
> Tags, we need to free the TX ring and TX completion ring if it is a
> combined channel with TX/RX sharing the same NAPI.  Otherwise
> TX completions will not have the updated Steering Tag.  With that
> we can now add napi_disable() and napi_enable() during queue_stop()/
> queue_start().  This will guarantee that NAPI will stop processing
> the completion entries in case there are additional pending entries
> in the completion rings after queue_stop().
> 
> There could be some NQEs sitting unprocessed while NAPI is disabled
> thereby leaving the NQ unarmed.  Explictily Re-arm the NQ after
> napi_enable() in queue start so that NAPI will resume properly.

s/Explictily Re-arm/Explicitly re-arm/ (typo + capitalization)

There's a mix of "TX/RX" vs "Tx/Rx" styles in the subjects and commit
logs of this series.

