Return-Path: <netdev+bounces-224228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4456B82897
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED661C20FA4
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63597238D32;
	Thu, 18 Sep 2025 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4BA4DyD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA9230D14
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159752; cv=none; b=uicNg04SREjHYXwTQCZ2MZX1QVyplqA9IOpBi0hYvyxKdlYuGE3AeKRsUrXfpk2mBTGdffQwYV7pckhc0BFDQgdpr4PqsxK2a4RSqdo9bfuaVB5XhS10OdGbiiO7ONpr5BaCMwlorJs4ekyCpLqxK36zdyLYTA1eq2KLPxldQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159752; c=relaxed/simple;
	bh=c+zrwLe7+HLxrcq4q+hBHCEgF0dl/Nyc5R6TtdQ3zzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWPtwMWE1sQgnFRi7awzupMCAansm3m1YQk6Rgtim7NTTOZbisYsQG7zQW8pN+1B1JK1ic+XlmfW8abnnP8n04pCDlmiN4BAGxFH6MPaKrtB4YwycewxCIJ43Davte9oYRocBir6cTZlX2AFLGg3dwziZ2xuy4BxMSVw03Cjzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4BA4DyD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso447544b3a.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758159749; x=1758764549; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ulvs7K3ydlDyEpWR5MQzG7rfwOArTPkkxrt2MdB42Is=;
        b=H4BA4DyDAL4QofPATXA1vU2N2K/Fmcnvjk+5s8l9MIAojPzWBwSOB+nqZ5ns2Nbj3J
         j/RLiNfiQ8R/DVi7HAmlR9UjAtTdanmfKa3kMIdGgY7MwAchZqnE6Iu0OrR8Lscp126F
         tj0/B54dfkWo/sXeg3nNCfiwpF+6llxZ/euW8ofwEg86BYlQUNpIjssNS9dKHBfXQN/c
         L55TFvGqIxTY4EDx8r8Hmz0cTOgxrEhIrTv1IiCzzb/1wnrP18SPt0T4zxxVqdVma2KB
         YfgUxH07fMG2KRuemVzEwPnMmrgbBOxnhwp3k8tiulCQ9yYgorEen5IRnACpDPtvGWxr
         rztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758159749; x=1758764549;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ulvs7K3ydlDyEpWR5MQzG7rfwOArTPkkxrt2MdB42Is=;
        b=HTf2KJVDRGNtYxNC8logL0tWofIrzJ1fZiFHZbY8oN3aWOvScoaJ5YIvNPXw3vFkAY
         cv+hKZnVRbKPkEm99nSrNAgJT+jVmxQGbt0U5hZiQSEJdQM+lzsP7lyapPS8TzPZr3kJ
         JRwX4tIK+2vn9dLqmj4S3S9fGYRd1a3G8h1AAu3am3+2VdR9ABFod9RV/KJCkOgGWe49
         VatQDMTZW/cFgrY9uvnBjEW6EuvOHQRsdSW9ZY+9+TdfJEOFYZfdMaHvnbIqElg2WMjM
         36jCJJq6RP1TtttWQeXuYyuXDtMYVCqQfOSDwuph+LhHd10pjhyko1CoIPdJ9qOltdSy
         xHsg==
X-Forwarded-Encrypted: i=1; AJvYcCUdA8kSCGNz3vwlhK9CVZ/mowVlnSZrw+K2UhjZ95OEEGd/ORuXgeDPGA4efI0gzJyeLxqHkik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZNnuTpTje6DrsX4skbkJlbqBZ+5CogAX/m48xCrwpIgFNFK2
	LHwNwU6z0Bkx2oLh1+zsqJ9vJQs/MTtkOEk2SslPqsNmxjwT6lyheiku
X-Gm-Gg: ASbGnctDjDKCBib9fWQK9Nch3B7x43LkTLg9FlCZ7kE9c/xjWvz0TfnDfBdgHaMxvQ4
	IvhF7dbQyWhXaIy24Frs0FiKe+P71h7pMotF5aPXF8BpH6g6pwPM5J4qWTZzaKPXWmZvRTa6Fem
	nE+Ugj7viTsxoX8I5JqJ+EryuvQHxPyUwnYdtHTaVP4uYcPbgtrcAorgnJsDXcFaX9GzeaPDC9o
	CGfM+X3ev4Duxj4TObRaO9h9YpoOupbrA4ig62xyXaaJla2yK0knsrgYCDaMsYsxFbXda7ku2U3
	QX8wNzSXOBjNqaz+jZwMh8ww9Ao6YfiPWbnqg6k9/QKmvBC5N0/n/7aCqF/T+w4DDX3oW9w88X3
	K891gsoMF9iUZ53eW2f7rdmVXmR9msKl5coTNcBS9UMbpny7CKx1rw7mxMSQub3ybDHs=
X-Google-Smtp-Source: AGHT+IFdcQcWFVUS1QCaJowNQlqmrKMadj3R+g3ibkhiKQd6PPuK1CiIPRFjs1gwggeFAwB+1AJwIA==
X-Received: by 2002:a05:6a00:228c:b0:771:e1bf:bddc with SMTP id d2e1a72fcca58-77bf75c1492mr4848577b3a.13.1758159749067;
        Wed, 17 Sep 2025 18:42:29 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc72b21csm687875b3a.44.2025.09.17.18.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:42:28 -0700 (PDT)
Message-ID: <c7104a0d58c674bb1fec1a6093be6085ad0be0e0.camel@gmail.com>
Subject: Re: [PATCH v3] net/tls: support maximum record size limit
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, 	corbet@lwn.net, john.fastabend@gmail.com,
 netdev@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	alistair.francis@wdc.com, dlemoal@kernel.org
Date: Thu, 18 Sep 2025 11:42:23 +1000
In-Reply-To: <aLllqGpa2gLVNRbw@krikkit>
References: <20250903014756.247106-2-wilfred.opensource@gmail.com>
	 <aLllqGpa2gLVNRbw@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-04 at 12:10 +0200, Sabrina Dubroca wrote:
> 2025-09-03, 11:47:57 +1000, Wilfred Mallawa wrote:
> > +static int do_tls_setsockopt_tx_record_size(struct sock *sk,
> > sockptr_t optval,
> > +					=C2=A0=C2=A0=C2=A0 unsigned int optlen)
> > +{
> > +	struct tls_context *ctx =3D tls_get_ctx(sk);
> > +	u16 value;
> > +
> > +	if (sockptr_is_null(optval) || optlen !=3D sizeof(value))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_sockptr(&value, optval, sizeof(value)))
> > +		return -EFAULT;
> > +
> > +	if (ctx->prot_info.version =3D=3D TLS_1_2_VERSION &&
> > +	=C2=A0=C2=A0=C2=A0 value > TLS_MAX_PAYLOAD_SIZE)
> > +		return -EINVAL;
> > +
> > +	if (ctx->prot_info.version =3D=3D TLS_1_3_VERSION &&
> > +	=C2=A0=C2=A0=C2=A0 value > TLS_MAX_PAYLOAD_SIZE + 1)
> > +		return -EINVAL;
>=20
> The RFC is not very explicit about this, but I think this +1 for
> TLS1.3 is to allow an actual payload of TLS_MAX_PAYLOAD_SIZE and save
> 1B of room for the content_type that gets appended.
>=20
> =C2=A0=C2=A0 This value is the length of the plaintext of a protected rec=
ord.=C2=A0
> The
> =C2=A0=C2=A0 value includes the content type and padding added in TLS 1.3=
 (that
> =C2=A0=C2=A0 is, the complete length of TLSInnerPlaintext).
>=20
> AFAIU we don't actually want to stuff TLS_MAX_PAYLOAD_SIZE+1 bytes of
> payload into a record.
>=20
> If we set tx_record_size_limit to TLS_MAX_PAYLOAD_SIZE+1, we'll end
> up
> sending a record with a plaintext of TLS_MAX_PAYLOAD_SIZE+2 bytes
> (TLS_MAX_PAYLOAD_SIZE+1 of payload, then 1B of content_type), and a
> "normal" implementation will reject the record since it's too big
> (ktls does that in net/tls/tls_sw.c:tls_rx_msg_size).
>=20
> So we should subtract 1 from the userspace-provided value for 1.3,
> and
> then add it back in getsockopt/tls_get_info.
Yeah good point. I will fix this up
>=20
> Or maybe userspace should provide the desired payload limit, instead
> of the raw record_size_limit it got from the extension (ie, do -1
> when
> needed before calling the setsockopt). Then we should rename this
> "tx_payload_size_limit" (and adjust the docs) to make it clear it's
> not the raw record_size_limit.
>=20
> The "tx_payload_size_limit" approach is maybe a little bit simpler
> (not having to add/subtract 1 in a few places - I think userspace
> would only have to do it in one place).
>=20
>=20
> Wilfred, Jakub, what do you think?
I'm in favour of keeping the RFC definition, as this would mean
userspace only has to worry about passing up the value received from
the record size limit extension.

For V4, I'll add a note in the docs regarding the TLS 1.3 ContentType,
and fixup tx_record_size_limit to account for ContentType.

Regards,
Wilfred
>=20
>=20
> > +	ctx->tx_record_size_limit =3D value;
> > +
> > +	return 0;
> > +}

