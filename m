Return-Path: <netdev+bounces-218651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E8B3DC55
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66705174220
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8172F39BC;
	Mon,  1 Sep 2025 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="jRM9AHAH"
X-Original-To: netdev@vger.kernel.org
Received: from gallant-hafgan.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.219.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7C270553;
	Mon,  1 Sep 2025 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.219.209.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715266; cv=none; b=XMSN86H5Jzp9vBxA5rcyMtPbvFTXOAHC/yCL6yn44tp+p4CJBGnVAO29BtLYWSvZ+JqcEH4sV1Tj8gn7y7Lo1t03uMbWO/Ges/y+BSAzOTNf+V/ZzahZz66NzlRcUU8KIlsxa0UPnoIip45YYIrxzex8Z7czCa3NtHBm9I3vLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715266; c=relaxed/simple;
	bh=9P9+FyI8xq/2ozOIpwXHRDObXjdq2VmTxdKGBYuWN4A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PU9b8vZcx8T/SkFQNwlP/O75wfqvvyuuGA/FQ860yr8eQJqT4VJufS3FJz0YO5X4h5h+jnlQX1c6CYs1zNLjRQ2xXAvIthIzeKI3+qq3oXse1FaZQNafelgzvlEhNVlytklHpZGWOMbHWwRxUdNDCno18NCF4asdObEgGf6HaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=jRM9AHAH; arc=none smtp.client-ip=18.219.209.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: from sizable-crocotta.authn-relay.a.mail.umich.edu (ip-10-0-73-123.us-east-2.compute.internal [10.0.73.123])
	by gallant-hafgan.relay-egress.a.mail.umich.edu with ESMTPS
	id 68B55870.24BB71E9.678B814A.35136;
	Mon, 01 Sep 2025 04:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
	s=relay-1; t=1756715115;
	bh=RZ3wqzNBJwv9fBwOlExW+J4uoepVcPqX6Z4vI7NvJiA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=jRM9AHAH1zG121BBZRMcl32CDkAVErDEUIFFOCP3qjgfgCg5QKQ8kM9y+geuX6Bjt
	 BqengFOs3GyTV0LdkjqmkwR1wJmshKaF5Q40mmfPeYFBgF6pnyydoTGuP3jbQyWrsB
	 WRQoLGe7iqwuJhBaxqcNu80lJZYtEOBPZaUvIdekXOgL4Dkbr42bnCy2lEZMQDPdD1
	 xlL+x9RwpeROp3JJPNle9p4XMZp5S2oYCCzPgzN6o53qVupWT1R6Y++Afjp9IiG35S
	 JpYq7yc91HikpS1DTV2zUFQblhxWCj+8mB9vV1bAgMDpmLQDq+CcptZKZWWDkY1nv8
	 PSC/0Tst8UwPg==
Authentication-Results: sizable-crocotta.authn-relay.a.mail.umich.edu; 
	iprev=fail policy.iprev=73.110.187.65 (Mismatch);
	auth=pass smtp.auth=tmgross
Received: from localhost (Mismatch [73.110.187.65])
	by sizable-crocotta.authn-relay.a.mail.umich.edu with ESMTPSA
	id 68B5586A.3089EBF7.6A2A8015.1374137;
	Mon, 01 Sep 2025 04:25:15 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Sep 2025 03:25:10 -0500
Message-Id: <DCHBJ8PJ79FK.B4J91QH6FC7B@umich.edu>
Cc: <fujita.tomonori@gmail.com>, <tmgross@umich.edu>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <dakr@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: phy: use to_result for error handling
From: "Trevor Gross" <tmgross@umich.edu>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20250821091235.800-1-work@onurozkan.dev>
In-Reply-To: <20250821091235.800-1-work@onurozkan.dev>

On Thu Aug 21, 2025 at 4:12 AM CDT, Onur =C3=96zkan wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

> ---
>  rust/kernel/net/phy.rs | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 7de5cc7a0eee..c895582cd624 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -196,11 +196,8 @@ pub fn read_paged(&mut self, page: u16, regnum: u16)=
 -> Result<u16> {
>          // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
>          // So it's just an FFI call.
>          let ret =3D unsafe { bindings::phy_read_paged(phydev, page.into(=
), regnum.into()) };
> -        if ret < 0 {
> -            Err(Error::from_errno(ret))
> -        } else {
> -            Ok(ret as u16)
> -        }
> +
> +        to_result(ret).map(|()| ret as u16)
>      }
>
>      /// Resolves the advertisements into PHY settings.
> --
> 2.50.0


