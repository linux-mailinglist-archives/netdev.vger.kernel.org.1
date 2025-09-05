Return-Path: <netdev+bounces-220302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB74B45562
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144105A85BA
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B864320CB3;
	Fri,  5 Sep 2025 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwX9lgg7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB531CA54;
	Fri,  5 Sep 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069650; cv=none; b=FAdHgv9yGfTb623Sj1335oUDqmRzzdxDzjg4xuIZmURFifD7TsgUe1O1IRu3yqtvSgBE6r6O8T4o2gxrpUjGhyHenDzOAI/UlhOtaInS1mmaW7T+WDSe92fW8xhSQAxihD2VaE/VqoJ1P6mVFYqikKUjJ4X+nxk070SI3grGHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069650; c=relaxed/simple;
	bh=pmX595AS4mI8XNILM1iPT1ftCXpIEPFe0EE/FB9od80=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=UKT9Cuq3hqvHZqaCV2miKfJLXJzmpHYmBEpq8ZU5uBxycfgE8SkKOy/w4MRnqwH7i71/PGteU2vO2ApLBANuXZV7RGw3qVVqscXUWhqBPGKgceR33EA7Ihw5qYCDq4IuPnPkJHVjLzMSi7xnfzbBiw0CbPJd1/DtMZkyxPmci0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwX9lgg7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b79ec2fbeso14068555e9.3;
        Fri, 05 Sep 2025 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069646; x=1757674446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ae2pZGeOxUWNnhVB6ytgG1+LzEott/yDmnkqH6AHVYU=;
        b=DwX9lgg753ND7L7fv2Ml9zFbkdlnRgjGj+joPAkl488+PVUZPbkcFjdK+7l446ay5e
         zSaEw0NhrqrYtIvest76FnDZBjQYXOh+Vm65lp5QNdsYTfnzkvmfZo6kNqJ0OlDrBeb4
         WMtU1wbzdBTdcl4Ikrz6VOBj7oddj+43Jn/6g/QXLRf6u5iEwji1q/P6z2Kmj5puW3q/
         /YNPKpo6yjWmn6ZDze+ze2oAezKL8MIE9/IOAxomSGgIkQcjc1BWtNk45iFmHetyqFh4
         CjXVTzSqRukDKIl4OssTcmh+2W4eiiDc0qM62zsps4NtEOY5WthnSGk0ygKGN5cLBL29
         08UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069646; x=1757674446;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ae2pZGeOxUWNnhVB6ytgG1+LzEott/yDmnkqH6AHVYU=;
        b=qXyfStozqFkC5aqc+iJtcmvOjAQkIF0YEQG1RDhR3GzDRDrHNw9O/OsFjEwKz3I2Bp
         Wz69LTE7BGb5L9KPXyrsIB1sOWCWh6CeN7f2qulRwv82gHVo9zHcyeC339QsmDnmpBJQ
         BElTu0tL1JRZb2Yz4nWwEWDqhu6hPEPZOHsNUwCpzo3hUWmcYNFqPj8TkndE0qzprdVF
         fXSt+xj9lNyDt382V6BxjOAKJPCCw94Bky0N8hrU69lDANGoWFkdTIgB+bxn+kHieaYa
         CR+WGCvJMaGy2xrc7sT8DT7FdsFQJeWDuuFWtCg1FLiBYbKJ0msL7Qrd4Xo+NNMLEzfZ
         0TnA==
X-Forwarded-Encrypted: i=1; AJvYcCUZqp4b5d/4O8FLD/hktYzNAyqSQG1h3pP2mNMbakJWk8NpG7isNUk8S2/x6nne5/8QyXPOGKUi@vger.kernel.org, AJvYcCWvvPnqKyU6pjCRa2O31IBlBtqX/VXJChjMKMUbau7F339n7K1BAGjow+Yk5nKzSUtW9WNSzHXao/9iJAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww074h1A4BrkG8pr2ye9Q03vbXkDvS/8bGjMXpe/GD4TBk6nYL
	b8t6QYh7qhANuOwOVyuxB1dsa5wOCUGLQ5owCmyJooxTVdUVf82Bm9SDQuC2s51P
X-Gm-Gg: ASbGncsI9DjBtue1vXk5BFpfiMBxAWKut4a/5qUBDwm8IKtXtm3mysMmv3j28WITzf5
	WegqwWZmghZN34w/CgMqIkY0U24LUfgk6NZgN/pwy97laD2KcMd5baVfbGTpez1PgNT5FqmDo5M
	AE2ZVFdFjLqKN65it6hACxj9dTpSYQgQubfvrVQe0GcMP1GJhRjs5K3vkLdU5H8YzyYNFbCrxN3
	KBOTAbF2Bq3BNqVKRRpMPSVtJQs9iFgaDjVgLjU4xi4skZv1F3tz2jO1dMWVZnta78n29PHkeKg
	TxKwqr2HdBdd2t5qJp1dbJddmATWRg79ZzcjdUZNn7kB5780Vx04VYt6MlnQVOAYUyQyW7Jy1NE
	VAD9jv1+r4iqIqvWwMMY7fb7QMfPD8PRZEhg=
X-Google-Smtp-Source: AGHT+IErKZNogTKW8vD9MH4j6VFAS9sssyaSu6xJlnSctBMhQvR4qqCnPzMGjDlbH+jJnp/0mbVdaw==
X-Received: by 2002:a05:600c:c0c3:20b0:45b:7699:f96c with SMTP id 5b1f17b1804b1-45b855fba81mr126256125e9.21.1757069646200;
        Fri, 05 Sep 2025 03:54:06 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm31345266f8f.27.2025.09.05.03.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:54:05 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/11] tools: ynl: encode indexed-array
In-Reply-To: <20250904220156.1006541-9-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:49:09 +0100
Message-ID: <m2ldmtxjh6.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-9-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> This patch adds support for encoding indexed-array
> attributes with sub-type nest in pyynl.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  tools/net/ynl/pyynl/lib/ynl.py | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl=
.py
> index 4928b41c636a..a37294a751da 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
> @@ -564,6 +564,11 @@ class YnlFamily(SpecFamily):
>              nl_type |=3D Netlink.NLA_F_NESTED
>              sub_space =3D attr['nested-attributes']
>              attr_payload =3D self._add_nest_attrs(value, sub_space, sear=
ch_attrs)
> +        elif attr['type'] =3D=3D 'indexed-array' and attr['sub-type'] =
=3D=3D 'nest':
> +            nl_type |=3D Netlink.NLA_F_NESTED
> +            sub_space =3D attr['nested-attributes']
> +            attr_payload =3D self._encode_indexed_array(value, sub_space,
> +                                                      search_attrs)
>          elif attr["type"] =3D=3D 'flag':
>              if not value:
>                  # If value is absent or false then skip attribute creati=
on.
> @@ -617,6 +622,9 @@ class YnlFamily(SpecFamily):
>          else:
>              raise Exception(f'Unknown type at {space} {name} {value} {at=
tr["type"]}')
>=20=20
> +        return self._add_attr_raw(nl_type, attr_payload)
> +
> +    def _add_attr_raw(self, nl_type, attr_payload):
>          pad =3D b'\x00' * ((4 - len(attr_payload) % 4) % 4)
>          return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_=
payload + pad
>=20=20
> @@ -628,6 +636,15 @@ class YnlFamily(SpecFamily):
>                                             sub_attrs)
>          return attr_payload
>=20=20
> +    def _encode_indexed_array(self, vals, sub_space, search_attrs):
> +        attr_payload =3D b''
> +        nested_flag =3D Netlink.NLA_F_NESTED

This line is not doing anything, right?

> +        for i, val in enumerate(vals):
> +            idx =3D i | Netlink.NLA_F_NESTED
> +            val_payload =3D self._add_nest_attrs(val, sub_space, search_=
attrs)
> +            attr_payload +=3D self._add_attr_raw(idx, val_payload)
> +        return attr_payload
> +
>      def _get_enum_or_unknown(self, enum, raw):
>          try:
>              name =3D enum.entries_by_val[raw].name

