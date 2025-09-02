Return-Path: <netdev+bounces-219109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4149B3FDF6
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190BA1898FCE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87F32F6564;
	Tue,  2 Sep 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUj9IxHj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3281A08DB;
	Tue,  2 Sep 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813234; cv=none; b=Y2u7czQhO4/jur2SEYOi7C7q3nkjYBuhuVzz1NxyBsN1XFYr1Y/szdO7+q2kPtFJNjsxxO6b11dH6wllDS5+UTYMrumh2MK2gZMuy4sEPS5H5o0MTpmpLvn2iyEYZeWuXcR/qqfUwSkU0WKlpEEy1Wh807z/TpVDjyXiJmuUv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813234; c=relaxed/simple;
	bh=wPSaH7cjW+NldJZ1SPTIET9Tf1SoUAdrI/uEh3a0nTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBy4FXGTw3HZByEpxSQp7J2VVmBFzByBDjKg+EdzKsDhDbDf0/FShLqcl5slKDevZd1VtfAyY9nTLN7CL4hBrL9eLi5pjR2O5aFq5eaV6b7d7sQKknYnscpl/RGuUDCw33sEYFlTOvKAj3Fi3EpQ/PkQIBCYh6zF1qaEHOOWzfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUj9IxHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE74C4CEED;
	Tue,  2 Sep 2025 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813234;
	bh=wPSaH7cjW+NldJZ1SPTIET9Tf1SoUAdrI/uEh3a0nTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUj9IxHjDKnLpou31B+i5MNND3MCnio/527nPeG6gqRYhVSY1S70j7jhIEhUirTWx
	 Bg8tZoM3xDUymFY4YaPfj4h3s42nZGqiTKQW1MWv1EE6MHRDb9431jP5D2ilKi9x37
	 79pN/8k38vHHbOucIkP6Fd9kuLTpLyXHyqgItartg/sJepj7jziVwoc9AZ0dRRbCY0
	 BERICBhSiZH11LxJ0iSjI07FvdgOT5qROIJkbtsF6BBr+nPMHFpT/1VV0/J0iNFhjv
	 K9xt2gRxub4Ns1Xq2HVsN8Sx3K5OHv7sGK92pVrQ8ME+capTKxh5CIugZX3eHDP8ZY
	 NuVLhWU/0m6fg==
Date: Tue, 2 Sep 2025 12:40:27 +0100
From: Simon Horman <horms@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2] net/tls: support maximum record size limit
Message-ID: <20250902114027.GD15473@horms.kernel.org>
References: <20250902033809.177182-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902033809.177182-2-wilfred.opensource@gmail.com>

On Tue, Sep 02, 2025 at 01:38:10PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
> maximum record size. Meaning that, the outgoing records from the kernel
> can exceed a lower size negotiated during the handshake. In such a case,
> the TLS endpoint must send a fatal "record_overflow" alert [1], and
> thus the record is discarded.
> 
> Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
> support. For these devices, supporting TLS record size negotiation is
> necessary because the maximum TLS record size supported by the controller
> is less than the default 16KB currently used by the kernel.
> 
> This patch adds support for retrieving the negotiated record size limit
> during a handshake, and enforcing it at the TLS layer such that outgoing
> records are no larger than the size negotiated. This patch depends on
> the respective userspace support in tlshd and GnuTLS [2].
> 
> [1] https://www.rfc-editor.org/rfc/rfc8449
> [2] https://gitlab.com/gnutls/gnutls/-/merge_requests/2005
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Hi Wilfred,

I'll leave review of this approach to others.
But in the meantime I wanted to pass on a minor problem I noticed in the code

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index bac65d0d4e3e..9f9359f591d3 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1033,6 +1033,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  	unsigned char record_type = TLS_RECORD_TYPE_DATA;
>  	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
>  	bool eor = !(msg->msg_flags & MSG_MORE);
> +	u16 record_size_limit;
>  	size_t try_to_copy;
>  	ssize_t copied = 0;
>  	struct sk_msg *msg_pl, *msg_en;
> @@ -1058,6 +1059,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  		}
>  	}
>  
> +	record_size_limit = tls_ctx->record_size_limit ?
> +			    tls_ctx->record_size_limit : TLS_MAX_PAYLOAD_SIZE;
> +
>  	while (msg_data_left(msg)) {
>  		if (sk->sk_err) {
>  			ret = -sk->sk_err;

record_size_limit is set but otherwise unused.
Did you forget to add something here?

If not, please remove record_size_limit from this function.

-- 
pw-bot: changes-requested

