Return-Path: <netdev+bounces-116540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E9A94AD27
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A5C1C21029
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264C084DE4;
	Wed,  7 Aug 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="x1/f3K1b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483384D29
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045433; cv=none; b=b74eZ5Cs0Gl6qj+TwASmI5EcKbteFvWoAZudjPGLWO8/vRfLvBlRLsymToDzrt7S26oVAg6xHWkJ59r2g+w5iUd5YxkyzpK6s2LrfIsapbXOMgKlU+iLlTqW3eznfmDX7pqKpOIj+tQPYqwvGGdpaycxFP+w8jXRM0cdxkQUqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045433; c=relaxed/simple;
	bh=pHXtrTBCPQsDofVJo02mGL2Yi/QqBz4kAQFC+dJvJcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9y0DWmHHWsohMviuRpU12TslTdRJ/+QV0NmxBIlRhklSTkjH77of0iYFNk11iPNEY8rjM1GVkCs2QKNaphx6fS+So4V9ppvCo4tmpzJxFq97Il4XL1PhXN1DNO5owOFav9I0sV3/qcU93wioPTFnd8JHmuD7ftWXWUKemTEL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=x1/f3K1b; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3687fb526b9so972014f8f.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723045429; x=1723650229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=128lpRqlEc1f/80iTPJiNIxISMGz0+4F83L7vE5vmBs=;
        b=x1/f3K1bXX+0PvGnw+qC/GNTJDhIwPrkG5oXwBT7qSpmqB/I5NRAIqLN3ZixPaKXku
         Wqaf2+y6e5N/kNa3ZqiRDFzRQ3WWaB8A7bio3+RAuN2C9KHr4Uu6zJzAkRAv7w4Izt1d
         wUNWfyvzO1AdGhQ7/NIHV8LdJEsmwnSIfy6Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045429; x=1723650229;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=128lpRqlEc1f/80iTPJiNIxISMGz0+4F83L7vE5vmBs=;
        b=PsJUK/Nyi3K7pkbPCVALO7fmm3uA9bTmalCZF6nupmANB8rJS0mkQ8iasD1lydZr8e
         Y0OCwAdsKSDBB91L7dhpQqLyRnqFPxieV94QOPo1UVL1IZwNpnLibXORob2BRdYZczK+
         AdhAsVGlT858v8lSt9n63g8uQljReHEDfRXHi7d1EqF0l1sn/DgRdOF2P2KKPHGBB8Fy
         maM1ow6IWdVhFJMLMiPLVJs1I6W7PAeVo/HVgsm9W9ycZCZ2Zts9g8B8vM98bAWtXM7a
         qFUG1VnbquF93dOOMGr9KRYmOuuCXxXyd2H1JXdkCjKCw4BKAtz6pBzr1MP+pPBznOrS
         nhHw==
X-Forwarded-Encrypted: i=1; AJvYcCUbRUhAVcFdQ2LTnrXKlA+N3k7xPpMJtddrQ5LZcl/NyDy2x8D9RsSf4Awq0mICylHD7vBGILvweQOpdvPtcntUVBDEgn2d
X-Gm-Message-State: AOJu0YzRS0ecIowDiOhRSs8efREhHFlW5O83vCoyCt9SIDBAk+dTToCR
	jo5UJSPp/QrIxpLMVZ+taKgZQJ09XQ4ud+sli2wyt68YtM13mjJpy0CLHfdcSdE=
X-Google-Smtp-Source: AGHT+IFPamZ3L0xYhxBHSUx2C9+ElY9gbLqY9wjVYiAVx6ddfZ4KYK4qIfTenT8g/O3fLKDNK9RE5w==
X-Received: by 2002:a5d:4f0e:0:b0:368:6911:6758 with SMTP id ffacd0b85a97d-36bbc1bcc03mr10603734f8f.40.1723045429348;
        Wed, 07 Aug 2024 08:43:49 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcd02563sm16543628f8f.0.2024.08.07.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:43:49 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:43:47 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com
Subject: Re: [PATCH net-next 1/2] eth: fbnic: add basic rtnl stats
Message-ID: <ZrOWM_F-BZRJEAAV@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	alexanderduyck@fb.com
References: <20240807022631.1664327-1-kuba@kernel.org>
 <20240807022631.1664327-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807022631.1664327-2-kuba@kernel.org>

On Tue, Aug 06, 2024 at 07:26:30PM -0700, Jakub Kicinski wrote:
> Count packets, bytes and drop on the datapath, and report
> to the user. Since queues are completely freed when the
> device is down - accumulate the stats in the main netdev struct.
> This means that per-queue stats will only report values since
> last reset (per qstat recommendation).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 69 +++++++++++++++++++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 56 ++++++++++++++-
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  | 10 +++
>  4 files changed, 137 insertions(+), 1 deletion(-)
>
[...]
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 0ed4c9fff5d8..88aaa08b4fe9 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
[...]
> +static void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
> +					     struct fbnic_ring *rxr)
> +{
> +	struct fbnic_queue_stats *stats = &rxr->stats;
> +
> +	if (!(rxr->flags & FBNIC_RING_F_STATS))
> +		return;
> +

Nit: I noticed this check is in both aggregate functions and just
before where the functions are called below. I'm sure you have
better folks internally to review this than me, but: maybe the extra
flags check isn't necessary?

Could be good if you are trying to be defensive, though.

[...]

> +static void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
> +					     struct fbnic_ring *txr)
> +{
> +	struct fbnic_queue_stats *stats = &txr->stats;
> +
> +	if (!(txr->flags & FBNIC_RING_F_STATS))
> +		return;
> +

[...]

>  static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
>  				 struct fbnic_ring *txr)
>  {
>  	if (!(txr->flags & FBNIC_RING_F_STATS))
>  		return;
>  
> +	fbnic_aggregate_ring_tx_counters(fbn, txr);
> +
>  	/* Remove pointer to the Tx ring */
>  	WARN_ON(fbn->tx[txr->q_idx] && fbn->tx[txr->q_idx] != txr);
>  	fbn->tx[txr->q_idx] = NULL;
> @@ -882,6 +934,8 @@ static void fbnic_remove_rx_ring(struct fbnic_net *fbn,
>  	if (!(rxr->flags & FBNIC_RING_F_STATS))
>  		return;
>  
> +	fbnic_aggregate_ring_rx_counters(fbn, rxr);
> +

Note the flags checks above the
fbnic_aggregate_ring_{rt}x_counters() call sites.

Probably fine to do the check twice, though, and otherwise the code
seems fine to me.

Reviewed-by: Joe Damato <jdamato@fastly.com>

