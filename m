Return-Path: <netdev+bounces-141360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505EB9BA949
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085081F20D3E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70718CBF6;
	Sun,  3 Nov 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbsuCkgu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407B18CBF0;
	Sun,  3 Nov 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730673422; cv=none; b=Ba/tq6xGVRMi7X8Zn6Vo/ACsFE/Q7hgLQtFIg5qYV6lmFqXLz72pVNYRW4OAPfP937qPOtWHOKUGKA1RHOti5WyVKDVAH6yytcDfqfGKeTHtGf6L/tBJpLydZwlCj+cbe8vrMFnf8hJBuNRqYvZ4+kUqIV2PHlqmopn5m8UL0MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730673422; c=relaxed/simple;
	bh=+AjUBFt5j6m3B0+mWVqTIMhl2EPw0N3fO6V9nqSUA60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qt6juXGXvy3hJd9rCS2KKiqMYE4I5XQ4jZY4PJ4bCN51QTd/ONQCtnc747bLZTI1KROd6Fhoq7i4mPhfiBgBDnCqktTIU9dCdT7dBV/ggF5rQcTy85c3igkdkkxnaMHqKBE9pEZh288m3xkrPj2g1iJQOWELlpErTZpM0QiTk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbsuCkgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9141AC4CECD;
	Sun,  3 Nov 2024 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730673422;
	bh=+AjUBFt5j6m3B0+mWVqTIMhl2EPw0N3fO6V9nqSUA60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MbsuCkgu9kr268BuJV+Zt2b4eKxqKdluo1s3J9P5rYyMtB7h77R2WjWvMY71VtQI1
	 sdXAKM+8MIuMItBGwc8QUUf2eQwTT/urbs8FN2eWTnAobMeVIoKxkjCoyy0pUEtiSD
	 /OOiUgtEzLCNUxI6glqFxPzMELSCD2R4pkrBZ3jMwkJ7eVr//X1UcBN8zW4QGvfp6X
	 RkP+UKL5WyMdmO9Fs2x6MdvoyJNaqvxUF1Q3FVWD5McPrGA2+WMTGAOGLXENEEkMjx
	 ZNPPBzLzNT12Q4Z34zNSY9EM6lMvbz/1UdqiMXJyisohRjTGRmnkvSfj6xDCZvoFYI
	 g2jzwy2Dg2mzg==
Date: Sun, 3 Nov 2024 14:37:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <michal.simek@amd.com>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, <harini.katakam@amd.com>
Subject: Re: [PATCH net 2/2] net: xilinx: axienet: Check if Tx queue enabled
Message-ID: <20241103143700.3ce70273@kernel.org>
In-Reply-To: <20241030062533.2527042-3-suraj.gupta2@amd.com>
References: <20241030062533.2527042-1-suraj.gupta2@amd.com>
	<20241030062533.2527042-3-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 11:55:33 +0530 Suraj Gupta wrote:
> Check return value of netif_txq_maybe_stop() in transmit
> direction and start dma engine only if queue is enabled.

The first patch makes sense, let me apply that one.
But this one I don't understand - what is the problem you're trying 
to fix? netif_txq_maybe_stop() tries to stop the queue if the *next*
packet may not fit in the queue. The currently processed packet is
assumed to have already been queued.

