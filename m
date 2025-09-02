Return-Path: <netdev+bounces-219238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0DB40A21
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133D816AE92
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF132A81A;
	Tue,  2 Sep 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="YNtik/+H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2gYLi7I"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689830AADA;
	Tue,  2 Sep 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829248; cv=none; b=gnvuAXgOsbg9ly1B7e9hcEaWm5mgbnOOpFLYPyTHLMSR6N4owFbLHU+sIsc+Xq3hV8csuT2pNdrdlp+ByFNNm+bfAQlERMKvYhqqHNCA/fD09eoU9X1IIw9mQb6V94JnZ9nFZdxddEwdgvcwMSW0i2OzsFPYic/ynsxGSM0glxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829248; c=relaxed/simple;
	bh=lIjfgrx3Mu52sr/JreVOOyKmQ7jZ1llITlSmdQTUAdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVFLkDTcKnODUmYgpaH7dTS8PI0SqXEiR9WSkyAGPj5+VkguxF88AI6kDSn6Aii2OgQFQenO4Su8K8Q1LhD2rylLYK5Hkp6HCWK/1sL52Meu2UDFV+9H5ik6jRbrWXfhZFLKmPiLzGKcj3/QVfqCp+BXaK+Md5s+3vQd3Mk8Lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=YNtik/+H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2gYLi7I; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A2567A035C;
	Tue,  2 Sep 2025 12:07:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 02 Sep 2025 12:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756829243; x=
	1756915643; bh=MMMydyiupTyTrdnZAHQqofe4YZyztrqKLKJLG/fici8=; b=Y
	Ntik/+HKI3YB8hHhuSHZNLj2b8/i9KZkZw1xmg+Yo5VWSNlSMwHuq2NDuoWnnfbr
	tXM1TWR4CnLK8tPj5ktYv0ubGr1OhmsrxUNNieKZqQ0Husr3O+yyjH9h/NI0bTHj
	LjlVt3sVBH1pRb10D1Nhgy1HDHXiwJJ9hGEOpVz1IGyDXvlNBuD1zHzfjt+F9F8Z
	1q1xlMAuFiILw1M9T1ht+r6Nj+ohwWin4WiKA4EPSYm2j7Tm+Xb2K80yJvE4cKbU
	DthP63JMgVziK8KFRBDNkMpZfIrWl9gZLvK3m6UPnv7AuNsjdgCnVwZThqpt4Qdn
	C1FvdSDXFOeUPzvPF6wUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756829243; x=1756915643; bh=MMMydyiupTyTrdnZAHQqofe4YZyztrqKLKJ
	LG/fici8=; b=D2gYLi7Iti7EThu3RgHhc+PKr7RKAd+352zw+nPAhM4tf49ogNm
	2LDJeoQpxjJu8ArvDqMQS+cV90nviLIl3lmjRJ0m+J4IRuGUkM7CIxVzwlw9siah
	+neeCbNgvgnHG66h/BCY3Gm/l9beo5b5FqM+Y69jzZFJCpoFgF8AnF+CP3QVXnMD
	CAou8HvlI/34iYdjvN86pxq9LynKJvpHSroENYozCiYNFPLRduV2BtgKW5hmPWlI
	ukcDJcT3mmVjtHyDJxhGA+/YIabuoPP45bZphwcU0dO8ODZmUU9z5UVdYpSdoIrM
	01hOEhDxBONS1rPRNAisxMK90NRwQKdX35A==
X-ME-Sender: <xms:Oxa3aNVRhOBw3UQMXbRLKRxv-eNKtr5eD_TcFvjvJcAkWwxK1E8t1w>
    <xme:Oxa3aJ-1GOFTEG4dyn8XZQVDOKJPqVQo5DFgwMa0CvTJfKPurF3dKV0CUrcyzvEPT
    Z1qWHaTYkmHWxRyIRQ>
X-ME-Received: <xmr:Oxa3aN2_AZ4opQtTmicqlfUBm5D0EqJE5i9x-O0qYB7OB-Bj26g1s9B3UMda>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgrucff
    uhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeektdegfefhkeeghfeileegueejkeelkedutedtieegvedtvdekkeegjedtgeev
    feenucffohhmrghinheprhhftgdqvgguihhtohhrrdhorhhgpdhgihhtlhgrsgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsuges
    qhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopeifihhlfhhrvggurdhophgvnhhsohhurhgtvgesghhm
    rghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpd
    hrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrth
    drtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehj
    ohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehhohhrmh
    hssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:Oxa3aOdTEObWgs08vAYlbr0dIcijNDdF-t2h6WatLT_72O5xhxJ3gA>
    <xmx:Oxa3aEDjD_io-7GDTNCnKOtLAbOsa0P-bwe_ZSzSO5n7bKp_SUaSuA>
    <xmx:Oxa3aF9mVv952buaW3fo5-7A4EBPpqzXukDKxCRLmh5qTwURLdjjXw>
    <xmx:Oxa3aIr1ga1k-EbTMaNhx6AtNr9C8bhAekcNk3Vy2-gHPECyHeeD-Q>
    <xmx:Oxa3aIuAhm5GKGpL_aguIZUdPfew22dL4N58tY9ZEXL1VkQrmr87rzsA>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 12:07:22 -0400 (EDT)
Date: Tue, 2 Sep 2025 18:07:20 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2] net/tls: support maximum record size limit
Message-ID: <aLcWOJeAFeM6_U6w@krikkit>
References: <20250902033809.177182-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902033809.177182-2-wilfred.opensource@gmail.com>

2025-09-02, 13:38:10 +1000, Wilfred Mallawa wrote:
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
> ---
>  Documentation/networking/tls.rst |  7 ++++++
>  include/net/tls.h                |  1 +
>  include/uapi/linux/tls.h         |  2 ++
>  net/tls/tls_main.c               | 39 ++++++++++++++++++++++++++++++--
>  net/tls/tls_sw.c                 |  4 ++++
>  5 files changed, 51 insertions(+), 2 deletions(-)

A selftest would be nice (tools/testing/selftests/net/tls.c), but I'm
not sure what we could do on the "RX" side to check that we are
respecting the size restriction. Use a basic TCP socket and try to
parse (and then discard without decrypting) records manually out of
the stream and see if we got the length we wanted?


> diff --git a/include/net/tls.h b/include/net/tls.h
> index 857340338b69..c9a3759f27ca 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -226,6 +226,7 @@ struct tls_context {
>  	u8 rx_conf:3;
>  	u8 zerocopy_sendfile:1;
>  	u8 rx_no_pad:1;
> +	u16 record_size_limit;

Maybe "tx_record_size_limit", since it's not intended for RX?

I don't know if the kernel will ever have a need to enforce the RX
record size, but it would maybe avoid future head-scratching "why is
this not used on the RX path?"



> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index a3ccb3135e51..1098c01f2749 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -812,6 +812,31 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
>  	return rc;
>  }
>  
> +static int do_tls_setsockopt_record_size(struct sock *sk, sockptr_t optval,
> +					 unsigned int optlen)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	u16 value;
> +
> +	if (sockptr_is_null(optval) || optlen != sizeof(value))
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(&value, optval, sizeof(value)))
> +		return -EFAULT;
> +
> +	if (ctx->prot_info.version == TLS_1_2_VERSION &&
> +	    value > TLS_MAX_PAYLOAD_SIZE)
> +		return -EINVAL;
> +
> +	if (ctx->prot_info.version == TLS_1_3_VERSION &&
> +	    value > TLS_MAX_PAYLOAD_SIZE + 1)
> +		return -EINVAL;
> +
> +	ctx->record_size_limit = value;
> +
> +	return 0;
> +}
> +
>  static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  			     unsigned int optlen)
>  {
> @@ -833,6 +858,9 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  	case TLS_RX_EXPECT_NO_PAD:
>  		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
>  		break;
> +	case TLS_TX_RECORD_SIZE_LIM:
> +		rc = do_tls_setsockopt_record_size(sk, optval, optlen);
> +		break;

Adding the corresponding changes to do_tls_getsockopt would also be good.


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

As Simon said (good catch Simon :)), this isn't used anywhere. Are you
sure this patch works? The previous version had a hunk in
tls_sw_sendmsg_locked that looks like what I would expect.

And the the offloaded TX path (in net/tls/tls_device.c) would also
need similar changes.


I'm wondering if it's better to add this conditional, or just
initialize record_size_limit to TLS_MAX_PAYLOAD_SIZE as we set up the
tls_context. Then we only have to replace TLS_MAX_PAYLOAD_SIZE with
tls_ctx->record_size_limit in a few places?

-- 
Sabrina

