Return-Path: <netdev+bounces-159996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED43A17A8C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E3A3A38BB
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD91E0B75;
	Tue, 21 Jan 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyKQoLHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5D1DFE03;
	Tue, 21 Jan 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453236; cv=none; b=ch6tf8nQsu87WhNe5uxVWvyVXPUpqiLAgwFHc6i6hDFJpFoJemIaDe6kRjXldANIPfmR8HxFGgD+QyRfz3CZbVH3ODTHQ4pg0DVc1seqs62erbib+I5nbYm6HUZ19oYimoepxnNxkkUfg2b+/WIiq1w82TsQweX2w5aQbmRAaGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453236; c=relaxed/simple;
	bh=oGS9GEqPghY+726sGroWzZWD5BHnYXMejKnND18DKfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS09UG47NKlnMhyrm2G9kwcpTRj0qwkcRVNVEzed8JTwXVCK9Iq1M24eNcl8s4HHKXY4XlMF7baAabMgsKiuKAb8OXUp8iMF7GsfMcVte6Jm23CqQ8XOz8H8RT3puUz6ZtIY9oToOODc9c8Q4fJhMvKrxpbAdfrwjm3yIA9mLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyKQoLHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47E4C4CEDF;
	Tue, 21 Jan 2025 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737453236;
	bh=oGS9GEqPghY+726sGroWzZWD5BHnYXMejKnND18DKfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyKQoLHxsPQs8coAiqEX7CPlPIEepc3N3l7ZKTzLqS9C1vPGLLFBFZfDaIoWJ6z1U
	 1fq5KCzIzH0BBltVR3YvzvdXGnDZaLqb69US3AWOl79HvgfdCbhtptkHwKiByUIxv5
	 6XklNIlwVBfbIXetUMH0LED8T5QT0yQDcVbyiNQUDoh5KDF+BIfNCZobBSSvcYNrHZ
	 Q1oLD5HRu7xhyLPWe8MZip7zkcHV331Jlm+AYWGjPn6eWx5cDCCo0EEqo3DHlOk7TE
	 iDVIJcUQkVwzdFpOe+Z+2nRJPDYL9CY7b1CNrtLp4Pb2m/GmD08qen54onQjY+EtpZ
	 fHI9L4XbZv02A==
Date: Tue, 21 Jan 2025 09:53:51 +0000
From: Simon Horman <horms@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] net: mvneta: fix locking in mvneta_cpu_online()
Message-ID: <20250121095351.GA324367@kernel.org>
References: <20250121005002.3938236-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121005002.3938236-1-harshit.m.mogalapalli@oracle.com>

On Mon, Jan 20, 2025 at 04:50:02PM -0800, Harshit Mogalapalli wrote:
> When port is stopped, unlock before returning
> 
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis, only compile tested

Thanks Harshit,

I agree that this is correct.

FWIIW, I would have used the idiomatic approach of a goto to jump to nearly
the end of the function, but the effect is the same either way.

Reviewed-by: Simon Horman <horms@kernel.org>

