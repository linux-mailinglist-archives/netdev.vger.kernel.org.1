Return-Path: <netdev+bounces-231440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1898BF93E5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 748144E5CEB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0914248F77;
	Tue, 21 Oct 2025 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAy9lZLH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7A292938
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089520; cv=none; b=nMa1s0/JxnALhcHqd8nzwepTlVhn6BJyq7RVO+C1kudEQJpxSB2jV6JYiBVI6JaGdHhX7yxUnlklu3SzR6zEn7+lzy+f+zVvDcsvWDpTxu/EZChkgGD2GIPbbI8TDr5Oo3g/4Q5Z72cMMkrXfw8YvPxQjDYNFml4WFWZ0fim9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089520; c=relaxed/simple;
	bh=pqqWmzw7DjJdnFf8r+/KCbFt0dIYwNLmYz8AmwYgSR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBioZ2LKFeUEBggCVP9Tdr7st1KpyM2PsI6GEI2BNuDsO9XEqyChDMj2JhPSeLWed3FREt78OFVoPkexBSORxa/4QHjerAIvB9YlNAFJY/q3S2pxAU85WX2hqgsP93Ava8NWwA4mhvSthG6SHR9jvdlw1bXFbAOA+GaehnNhxJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAy9lZLH; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so4869350a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761089518; x=1761694318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vcxIn3xS1W1KdT5lDY1lIR5M97MqhUxp9HDJPsXzhq4=;
        b=bAy9lZLHPzNYzadbzUzir1Mm5vQm8mGhLBFWFOFTj8yHGO4/1OiUckqDaKRUpGhdrV
         e/nIgScgstUUUIxES9i8Mb7kd6B6TbfKCOKVpucHtw9zt04mGRMUAkb4JgcOQg7db5vm
         qOeadvu074q6gqFNkpCHyUIfi/CtH1eoodYPaWd6gLqmaDCyfqvyFu7xBDIo9NoppqgB
         wCIDzMlnwxKqfkG3V6Dq/okyPCiwC9ELEUXLPjU7CeVaHnnElFzghKFqEZHSPV8mSSTP
         gom+3Bh+XiFlTB14dozJNnRzP/YHhpXHj3OGPpE3CFni6YhnCIqnREev6IEAfl7wF9v8
         zdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761089518; x=1761694318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcxIn3xS1W1KdT5lDY1lIR5M97MqhUxp9HDJPsXzhq4=;
        b=KIy0pvXWC+KIk0U2iMz+gWBXzRINFTOMkFT7V8DJQ+8GOsMJUmQCeeo0i9Y6zrK9wE
         W+bJXyo+pyVpqs70zhuYlrQpCbIrv5lAzHPWOZNAeFv6EmGyf+IqnMyJ7WhBzBBBN/1O
         5DLQD5YjDzzv40eIjxZJSKS/j0J6Ns2SD2gRJGOmMnslbvAZUVUfprHP/zrZaCqumRVY
         nn4faqi+BsrAfOOMYKTttuyuknzQB2/5JKzz+cE27tFPGAUggX6mkEUDMNuep8QcJIPl
         1tLVO23CI5gVUtIvfsb/Y4Q2RNVNJnqA5oxidicAwRRZ7Kvd3FpDfyHJBWK/xvg5PgVQ
         twdw==
X-Gm-Message-State: AOJu0Yw5KYyJhiaMUzmkPZS5OeTOdlh14agiqwznp25Q9Tc73A0cu1ER
	5VHP2CnpZycg3oQEwJ2G0IWDDcGtLi0tL+ZQSJl1byjXrzu7vXZIy2as
X-Gm-Gg: ASbGncvJoMOobKkwbHG21IRXm8/TEVqWFgsbMMyiqQ7UPRMzHHu4rAFW0aEG7hM7+P+
	2Dh97Rg7hW//UQ/e7n43ydaTbOqR+HYLItWaxdV25OvOGUfThs53T45/WpSncwoxKnk3du739fG
	o7eYW+iieoJ5Ky1TOzw7hYWKomLlSDX6pWwsSnTxjtYmoF4tbIxCW8oehOQ8ohAVnJ5QRbe71Hd
	gBbloE8WSUcwsifWuJA7U8C66Z1xlkjUOwajFqcAj2yXWyiYDTOUZ7Iq3tUweKggnWbipJMcQI5
	5VCoGIWsH3WDN1l2zkcNORb7JKSbSu2ddSVh/6L40TbjXaMG0ScvSTkp7I2xOczBv4D/Ocf0Qxt
	MIClMh/iQCuXb4ylk30e5iC8TH2kVbtV64GuAk4gakCDix+i4mt2/5cBwGQHOqmTS/+CuEYz9gM
	nFh/f//UM3Tuxew4u39hXMltbuprJJcw==
X-Google-Smtp-Source: AGHT+IGzAsvapfQPwXxI8Qn0+WUuZk0fpYv0ATQ3QcqzMDCO7tvMff3/oU84M5k7fByuu6Mv1I4JIQ==
X-Received: by 2002:a17:90b:48c8:b0:33b:ba55:f5dd with SMTP id 98e67ed59e1d1-33bcf93ab88mr20368837a91.37.1761089518516;
        Tue, 21 Oct 2025 16:31:58 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a359sm678229a91.12.2025.10.21.16.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:31:57 -0700 (PDT)
Message-ID: <ba52cb688c9fd3209feefc5f7927d929190626fc.camel@gmail.com>
Subject: Re: [PATCH net-next v7 1/2] net/tls: support setting the maximum
 payload size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>
Date: Wed, 22 Oct 2025 09:31:51 +1000
In-Reply-To: <aPeASl1RRAKMmuhC@krikkit>
References: <20251021092917.386645-2-wilfred.opensource@gmail.com>
	 <aPeASl1RRAKMmuhC@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 14:44 +0200, Sabrina Dubroca wrote:
> 2025-10-21, 19:29:17 +1000, Wilfred Mallawa wrote:
> > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > index 39a2ab47fe72..b234d44bd789 100644
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> > @@ -541,6 +541,32 @@ static int do_tls_getsockopt_no_pad(struct
> > sock *sk, char __user *optval,
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static int do_tls_getsockopt_tx_payload_len(struct sock *sk, char
> > __user *optval,
> > +					=C2=A0=C2=A0=C2=A0 int __user *optlen)
> > +{
> > +	struct tls_context *ctx =3D tls_get_ctx(sk);
> > +	u16 payload_len =3D ctx->tx_max_payload_len;
> > +	int len;
> > +
> > +	if (get_user(len, optlen))
> > +		return -EFAULT;
> > +
> > +	/* For TLS 1.3 payload length includes ContentType */
> > +	if (ctx->prot_info.version =3D=3D TLS_1_3_VERSION)
> > +		payload_len++;
>=20
> I'm not sure why you introduced this compared to v6?
>=20
> The ContentType isn't really payload (stuff passed to send() by
> userspace), so I think the setsockopt behavior (ignoring the extra
> 1B)
> makes more sense.
>=20
> Either way, we should really avoid this asymmetry between getsockopt
> and setsockopt. Whatever value is fed through setsockopt should be
> what we get back with getsockopt. Otherwise, the API gets quite
> confusing for users.
>=20
Ah I see, okay I will revert this change :)

Thanks,
Wilfred=20
>=20
> The rest of the patch looks ok.

