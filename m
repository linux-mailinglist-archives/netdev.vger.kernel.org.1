Return-Path: <netdev+bounces-232322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB35C0417D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 04:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAB8C4E334A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F7223DF6;
	Fri, 24 Oct 2025 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHHH1mlM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01C2192F9
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271880; cv=none; b=e0OIQkZyMdNZrf4aGPxq0Fd6Cgoap0p1y+yl9iSvrf6f6rcSl7lehuf6VqohZ0zaWZF+e0UY0H+JgCVf6WYUH+Slehn3p3RsjS54kgG0FYh5gVPMTRIQ/z/i8q4pOP0ZkmgzZcGvxqJt9JOAxYMNiC7AOdXO6gfr+2EE++b/OFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271880; c=relaxed/simple;
	bh=2HKWTq9bYPI9IRNhEkPDZsu1MxYbn9ll23LkJz1BkFo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyK7+b5iq3mThi8llBBIhksGaL52km5q1q3ydX1ZJafYhbgEoV/5iLeQxw3L2mktMX/vYliF1e5yd3UeFiYNu4RpGG7FRL8k92WpQzcPZxN166z/6YPrXke69ZTlOZrEryJ/AC36xv8BHn2A5gH5AJuLv9m1nqz6TAgr/lDmkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHHH1mlM; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso1313043a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761271878; x=1761876678; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iIMtRFCdsmjJp3brOQhbUpPZt9mi1Wgypme0Ijm/Bxo=;
        b=JHHH1mlMK93oKmK/c2QjFixiw/SNyytCpGn1CPrKYnc9R18YwdcXSxN6cbtjN+QcdT
         SXjQvvn6WX4AFZcKE5g6CRIP7pIWcGwL28KXXYpz5ODyDCb4lB0bkXwRMPGfzMAKrB4U
         2wfSfHh5hHzBfFkmADn+Xsp9DT6oExnZzXvnwo+JUqeakS5l56rHP9UV8WuYnEwJziZl
         uxEtV7Z/peumHM3dF/+Qm0jSEmZ2P392CxU+eVRaKpS5N8gss2wCi6F9vp6QpcwTMTYg
         byhV/4Nod27m+0EMGpsFQ2nAkz22TQDFUh22HM2zqx3n7akN9fpXcxQtqxDmRcXuR8+R
         jZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271878; x=1761876678;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIMtRFCdsmjJp3brOQhbUpPZt9mi1Wgypme0Ijm/Bxo=;
        b=TH/f4rE08LcngbR2Aztib4QZJ1TOd81p0zksZzdnmy0/1oiJhVE4SIk6P6+BpAC3rR
         e+Aki57FF/3I+WtCPRrngJuNw8RVm1Gm2dvIbqXhWfiSVf8TGDHdDxnKzDKAGmNtqN8N
         2vmsklIFCBgv/RuK0RVk8YKyBfjOA7rTMRPFK6EA8zSVQ10dmeYkG7/hRUNHjldc7sZE
         XShFqmrvjALpAEoFqINDbud/EkQRENkJzWNmMMoLj5t3BvDZVCbfEEyoNnC3SzcZ0NmI
         BgNLVCw4bEFROV8AQlUBqChYNwltlGZuLz7u+K783GEox1vzfyjuunBLXOaOCihKShz6
         6D2g==
X-Gm-Message-State: AOJu0YzNVwlGjpljZU6Yckg2dnGSxCXXYitmgcatGBvoufMz7vxh1r5e
	RgQewzG8RvRRSnfuwaP7gm+boH0iUfVcaWy3DGNQiSXhm/5Lx3PDDL7r
X-Gm-Gg: ASbGncvRiRShn1pxr2/dDaFQRiRQ9opBxVNOA8vZN0iToKpebl9YYTkxQ7iDzLdEZDU
	RXa0wT1dwXfWJ3C4ODoUTO6V/CkBuZ8qYUkKRKazyS10vm/zUCWu1TfkMR5q6z8+j57+ktm+LCy
	dr+6NHWk0pp3vNZ5DlwWy1PzacgL+Pjt2FDqD7aWa3XBHFbe4vZX0UWxgvRIgVZEdW50AAEbrwW
	M/2l74ucrzayJdCkrtAHKalaMqyRZCn2fxulynT75YnpJqkVtX8zK65K3Vfl60cV29c4PMGLMbC
	KtZB+lp2+LdaI5BBjICwX8e6VNf5Snx41+hfLjNExukIEp9KaCncsn3PkZkbB+Zh024bPs7Rsh3
	LLU3BkC8pEjgssRnjs1lnN8rEEQntWL5HddfIJ+XhWRojcTCpf1A13zFoUP2QBEfteDx+DlRg8J
	wOMsnhPcgu22lNFB7H6PRSfLsY1oFPXpJVxfzF
X-Google-Smtp-Source: AGHT+IFD75N03XrwMjNRmyxSMWMxZp+UXCEbbO3kw9IuJAvapfBkWSQMRThlDmpY+YsYkZGyYzgU0Q==
X-Received: by 2002:a17:90b:48c8:b0:33b:ba55:f5dd with SMTP id 98e67ed59e1d1-33bcf93ab88mr29913628a91.37.1761271877829;
        Thu, 23 Oct 2025 19:11:17 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb0196831sm3967266a91.20.2025.10.23.19.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 19:11:17 -0700 (PDT)
Message-ID: <cd557c5b11b04da060f07d3849dc46e7b3625ed1.camel@gmail.com>
Subject: Re: [PATCH net-next v8 1/2] net/tls: support setting the maximum
 payload size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>,  Jonathan Corbet	 <corbet@lwn.net>, Simon Horman
 <horms@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>, Shuah Khan
 <shuah@kernel.org>
Date: Fri, 24 Oct 2025 12:11:11 +1000
In-Reply-To: <20251023184404.4dd617f0@kernel.org>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
	 <20251023184404.4dd617f0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 18:44 -0700, Jakub Kicinski wrote:
> On Wed, 22 Oct 2025 10:19:36 +1000 Wilfred Mallawa wrote:
> > +TLS_TX_MAX_PAYLOAD_LEN
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Specifies the maximum size of the plaintext payload for
> > transmitted TLS records.
> > +
> > +When this option is set, the kernel enforces the specified limit
> > on all outgoing
> > +TLS records. No plaintext fragment will exceed this size. This
> > option can be used
> > +to implement the TLS Record Size Limit extension [1].
> > +
> > +* For TLS 1.2, the value corresponds directly to the record size
> > limit.
> > +* For TLS 1.3, the value should be set to record_size_limit - 1,
> > since
> > +=C2=A0 the record size limit includes one additional byte for the
> > ContentType
> > +=C2=A0 field.
> > +
> > +The valid range for this option is 64 to 16384 bytes for TLS 1.2,
> > and 63 to
> > +16384 bytes for TLS 1.3. The lower minimum for TLS 1.3 accounts
> > for the
> > +extra byte used by the ContentType field.
> > +
> > +[1] https://datatracker.ietf.org/doc/html/rfc8449
>=20
> Sorry for not paying attention to the last few revisions.
>=20
> So we decided to go with the non-RFC definition of the sockopt
> parameter? Is there a reason for that? I like how the "per RFC"
> behavior shifts any blame away from us :)
>=20

Hey Jakub,

We've made the change from record_size_limit to max_payload_len mainly
because:

In the previous record_size_limit approach for TLS 1.3, we need to
account for the ContentType byte. Which complicates get/setsockopt()
and tls_get_info(), where in setsockopt() for TLS 1.3 we need to
subtract 1 to the user provided value and in getsockopt() we need add 1
to keep the symmetry between the two (similarly in tls_get_info()). The
underlying assumption was that userspace passes up directly what the
endpoint specified as the record_size_limit.

With this approach we don't need to worry about it and we can pass the
responsibility to user-space as documented, which I think makes the
kernel code simpler.

> > +	err =3D nla_put_u16(skb, TLS_INFO_TX_MAX_PAYLOAD_LEN,
> > +			=C2=A0 ctx->tx_max_payload_len);
> > +
>=20
> nit: unnecessary empty line

Ah! will fixup for V9

Regards,
Wilfred

>=20
> > +	if (err)
> > +		goto nla_failure;

