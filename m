Return-Path: <netdev+bounces-197495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F801AD8CDA
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBE27AB7E6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551A1624D5;
	Fri, 13 Jun 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBOEsTq6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6A15A87C;
	Fri, 13 Jun 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820255; cv=none; b=Hda4jzw+Cc1bOgZVmHdLC6lZepIrp0t+Z8xEu4wakYrHWP/eefizHtiGPErNvdP7ndpk5M3BgdZ21wSvTCktsMEsmVKsNGIfWBE+5lyv2w65qsbI9bdlnPuWdPsu23Xa2NUARSVbPalTuhbWCSWzX+7E67FhZK5As4vqriLBcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820255; c=relaxed/simple;
	bh=6rp7eAnv7jydJiNj1mOqYkTX3fDMNGW8f61mmdX4yIM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=vCS6iMYLeLNu3gtqj3wRiXaYwufJPFjlSo5NnYO0/9ttmKrIfHMYnjMJcYvbgRKOxHCTj7Phj3w/Y8JxDYUwemf6dzPlA3YnGowrF7WSt1XZHQVPr4RNfZK0VzOGlt1/WiqnehuNIUxzzfYpLCggqNWPTpsKZx5+emZ0L1JBzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBOEsTq6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so11739175e9.2;
        Fri, 13 Jun 2025 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749820252; x=1750425052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qkrgZn1Te7Sj9IIaDIwy8pfNXIJhrotxZavh7kLndew=;
        b=kBOEsTq6T2E2knzEjuLXNC0Iq43S1zO7Qnr7YO9S2rFmM9Gh5XEK69OCyuNFc9q6rh
         xGyhq0h047TIK4HGo+I3jWs0BNnSFcu+x+7IiZRVPGWKGatu60vLFz/mqNI59xetsamb
         EI3y9VSEGleGPv/7CxA0yzp9uEVjA6VZMRZhueg0UHAbao3UJarNGNirIFSZpMAgL/lT
         WLOP01OQFV5jCee+P0sjLIu654VFGlObu/M6iaMrI6Ry1N5yMITOr7quzheJuVNMJ71m
         AoZ7A8zLm35uh0r2Mj338f5iJeKiLHgZWmTkdLnRE2CyuW/oGfO98z3SpzWdX+daCXWb
         8+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749820252; x=1750425052;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkrgZn1Te7Sj9IIaDIwy8pfNXIJhrotxZavh7kLndew=;
        b=i0yIlRTL/JcVny3Fjb2fhcM2oR2VPnyjDmY6KjdRvcz3xqhXNcTp32xRQHw8bozQYx
         bGLSnDlX+XJb21YZauKHYiFNMAlaeqetdkDvPiT0M0NZG5w9q0TOChZbKcf72DytKR2D
         XJI985L5jUkrO9PNtIt3jRW9aIACElHTevXWTqoCyXzpJckvRtT1XVZSQW/x9lyxIwlT
         agFdQ0QLL98CMPglgyaLGxubNIBnIB4chDvZG5cXqLKBwZOKzVsDbZsuhs3PNAFBnMX2
         zervQin2VlQomZl5RBoKvrXBTLi5bdHVUK7ZeQLPoABR94VyVzjO1CkUxbRSlkN2BpVC
         GwAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlloFFuubMbxwNvaH/1cA14BA6Nu483rJUoOG6DLxuakm2nwrA62e5o5KUsDniASpMxW2WDBkAmCKLj/Y=@vger.kernel.org, AJvYcCXMpHP5mN5v1rbBqF8AWL26mw4QjtOK8+O9kviDFYJ79EU6d/nxem4UDEM27RBhq3/LVeOnBAFV@vger.kernel.org
X-Gm-Message-State: AOJu0YzwoWrG718zScAyNcQnky1Z0P+/GjeCuEgBug/uu9AVN7qiYATV
	cYwTyt0u9Aoog0ednK4MTcdzJZmjfDchrFE+EmiGFXdL280KRpoDwWxq
X-Gm-Gg: ASbGncv4jtbImgA5e9lv2QLWfhUWp/6s4KAizMmsO2UKUCfyGMqPA7MxM1xub/jxDfL
	ovQNizY3juWqpzXYLyGfauHjideNj73evTGPOdz6qOtG4oUf4QOABgzUr/T/LjSENRqK37xjhg2
	O23r0WcstFhqVPtu+irA9fWAiNaZ2C8wLQoi6G+a6NOUd4//4dYuoHgltI+i7uN+VyYxyOJjDrp
	+lEyferrjkvLt5WZ9EN4BtB2MUbEmmc8R/Zn5DHCQApBnnWqeHzxS56ro1ILMWOIb+72Sgl6qss
	xGV5NKWpWg0ObHT3oFLRPTZ/+NCy3g07hOSZDmxeTU+uvBD+pr1R4pKqRr/Pcq2/PK1nTzCR7cK
	sZKzIfu1Szg==
X-Google-Smtp-Source: AGHT+IHgXB8AXL/nBv92iI8+cZmWTMu3M9SVVTLKyCQOyvG2PJJtoDlsBbfj+n5MGh8yOcyLVZGdKg==
X-Received: by 2002:a05:600c:8b2d:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-45334b19469mr33212305e9.15.1749820252233;
        Fri, 13 Jun 2025 06:10:52 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c4e8sm51884785e9.3.2025.06.13.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:10:50 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v3 12/16] docs: conf.py: don't handle yaml files outside
 Netlink specs
In-Reply-To: <d4b8d090ce728fce9ff06557565409539a8b936b.1749812870.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 14:06:24 +0100
Message-ID: <m2ecvnlrjj.fsf@gmail.com>
References: <cover.1749812870.git.mchehab+huawei@kernel.org>
	<d4b8d090ce728fce9ff06557565409539a8b936b.1749812870.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The parser_yaml extension already has a logic to prevent
> handing all yaml documents. However, if we don't also exclude
> the patterns at conf.py, the build time would increase a lot,
> and warnings like those would be generated:
>
>     Documentation/netlink/genetlink.yaml: WARNING: o documento n=C3=A3o e=
st=C3=A1 inclu=C3=ADdo em nenhum toctree
>     Documentation/netlink/genetlink-c.yaml: WARNING: o documento n=C3=A3o=
 est=C3=A1 inclu=C3=ADdo em nenhum toctree
>     Documentation/netlink/genetlink-legacy.yaml: WARNING: o documento n=
=C3=A3o est=C3=A1 inclu=C3=ADdo em nenhum toctree
>     Documentation/netlink/index.rst: WARNING: o documento n=C3=A3o est=C3=
=A1 inclu=C3=ADdo em nenhum toctree
>     Documentation/netlink/netlink-raw.yaml: WARNING: o documento n=C3=A3o=
 est=C3=A1 inclu=C3=ADdo em nenhum toctree
>
> Add some exclusion rules to prevent that.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/conf.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index add6ce78dd80..b8668bcaf090 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -222,7 +222,11 @@ language =3D 'en'
>=20=20
>  # List of patterns, relative to source directory, that match files and
>  # directories to ignore when looking for source files.
> -exclude_patterns =3D ['output']
> +exclude_patterns =3D [
> +	'output',
> +	'devicetree/bindings/**.yaml',
> +	'netlink/*.yaml',
> +]

Please drop this patch from the series.

>  # The reST default role (used for this markup: `text`) to use for all
>  # documents.

