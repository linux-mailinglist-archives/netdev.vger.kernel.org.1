Return-Path: <netdev+bounces-65789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017983BC11
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70651F270E8
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971010A1B;
	Thu, 25 Jan 2024 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgIueDrB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7471B965
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171649; cv=none; b=eCDVvEoQE3v6Q0XW1NLluzIf4J4qWNvUM0XVri1XfmvPTcSw6NcmjGV7DOfQMei5zahu/e6G++WUKuflDRyamvNPR9xXsF0Ni13fqzyLMcrPI08/KAD8Y1KPJduwAjiGieKS6z/NBT+p+ngdVORT3ZqF3r6NqhJU9Kg2mvLj2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171649; c=relaxed/simple;
	bh=Z10sD+UvLggRZfDkOlWu3LNW8BJNiCrU8i8VP9n/bvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vok5DA0CpeDd5iM9NgljCQ/qFAEz3Nqj/GV19JqI9LIDt9oHIicA0dbMejRVb0zdbxWk0b/90j5HW9hVM8mc77dfUMFu3O9ZJlQYBQYaf5iR4avMFiyBbL9HjJmhNRMc8EFTHRt2rmYSXusf7yHhUEpQ07jXs6831KN/SjUBR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LgIueDrB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so4957a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 00:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706171646; x=1706776446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JdJEAF+ssH6QG9iy2ulCeBMYfr8mpsgmjYagk3l7K8=;
        b=LgIueDrBmZMW0UjWbsm7FB+AWIKNdikGhliDrV7eIEARBfBL1fJZVl3yWc79F10s1p
         1gbQu8Be8UPDGJT6juGYrYOLdviShjvqWDC8qu9i0tgnr1SqqQTgrs/GdxCCuIepfYby
         e9XAdf2yY7u5j8bq6miy+cAwyivciceOmxruodfEZZ3MMz7pY/0q0fGylp6Wu6KgcNZD
         2DRbAY8r9CuLGu5NjAuUTElRQksQqBL0zgk/mGBFY4REmPgP8kMZbuyLcly3mhNa5pZG
         VhcDHNXRgupCFHbha+JKw3A2puYMO98hhS3OIMeTKv7M4JxQ96oDWKve9paK0m7TeXmh
         lITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171646; x=1706776446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JdJEAF+ssH6QG9iy2ulCeBMYfr8mpsgmjYagk3l7K8=;
        b=hkKNdpyBGCk/qeqkJEX3semdCxngjINqmaFdW3z+EJlgBVtvWvEQ5c+qdMnfRPH+9U
         8AjiB9eMEnPVmjwZtaNbRk5iXhsNR9MXWI2r7+se3LusNyJGO+uuWPLX/YsCMfg+IPfh
         0XHo5VdfeT8XRnaHblRp/60mG0NJWhFzsqqfNdrJc4MlcIoTQyUY2g+pGKbFOZvg2vcv
         RFg4f+JMm8sfokZsdbALwWu460Ub8XDlD9Jes+00l4b20Yi15ZJlV1jtIe/9cVloiLGI
         yB4d6/f49qB6jA0DK6o3ft7UVeBj+rYgeI9KLwXDupbMQ0SPVs6QwtO0RcevXkAC5W81
         na5g==
X-Gm-Message-State: AOJu0YyFTNYeUYMXewIoiNHdgFT9XV9YVMV+Gvoj0WyFRsJ74VIKttvY
	KcFmYq9oD2sjnzg4e9JmjDm6bmQbzZabI/MEFMKU6+MQXppMnWBYhW/7QAsRVZDZgwqfqXDMmdm
	+mDw5YoDK0Mw9Nw5RXNu6n8nyugWLssS1SRIMIJmj+xrCy8xIcw==
X-Google-Smtp-Source: AGHT+IHFCEAzt8pXqK2dabhpTRVFX6eoxU+54My0wpaO4uXTq61m1hZeQwQ3I3c/dy0n8TDW0tTPJGkzhpmmtBPJpBQ=
X-Received: by 2002:a05:6402:1d88:b0:55d:152:7d59 with SMTP id
 dk8-20020a0564021d8800b0055d01527d59mr55522edb.4.1706171646358; Thu, 25 Jan
 2024 00:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
In-Reply-To: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 25 Jan 2024 00:33:49 -0800
Message-ID: <CANP3RGcyMkgvxZEjuoD8azmVikibQ=xHokZ9oC_=zGMZg7X1DQ@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: add missing required classifier
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Lina Wang <lina.wang@mediatek.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> the udpgro_fraglist self-test uses the BPF classifiers, but the
> current net self-test configuration does not include it, causing
> CI failures:
>
>  # selftests: net: udpgro_frglist.sh
>  # ipv6
>  # tcp - over veth touching data
>  # -l 4 -6 -D 2001:db8::1 -t rx -4 -t
>  # Error: TC classifier not found.
>  # We have an error talking to the kernel
>  # Error: TC classifier not found.
>  # We have an error talking to the kernel
>
> Add the missing knob.
>
> Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-test=
s")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests=
/net/config
> index 8da562a9ae87..ca4423ee6dc9 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -42,6 +42,7 @@ CONFIG_MPLS_ROUTING=3Dm
>  CONFIG_MPLS_IPTUNNEL=3Dm
>  CONFIG_NET_SCH_INGRESS=3Dm
>  CONFIG_NET_CLS_FLOWER=3Dm
> +CONFIG_NET_CLS_BPF=3Dm
>  CONFIG_NET_ACT_TUNNEL_KEY=3Dm
>  CONFIG_NET_ACT_MIRRED=3Dm
>  CONFIG_BAREUDP=3Dm
> --
> 2.43.0
>

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

