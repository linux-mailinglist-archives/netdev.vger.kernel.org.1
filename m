Return-Path: <netdev+bounces-197469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A0AD8B6F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40322188DB20
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD8A2E7636;
	Fri, 13 Jun 2025 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3Ct2zNx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E842E7621;
	Fri, 13 Jun 2025 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815753; cv=none; b=m4JM3yCYYXyHUc9ZHj/OEvrin3R4j0hIIMXR7u10ChBlUGCP0U1HvyCg/kolHLujfj7AoC10kfXdK/gqQmAzJT1/aOzX7p7WmmGDBQ4VEfUmgx1EGAACBYF4DvqAn42bJEUlnBw4tiyZKnCkitXDELHur4TksJzqAvWTWiiSzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815753; c=relaxed/simple;
	bh=kDHzDpgYMT9BX3ib7Jt5mtCoGJdm2oP5AXFagcKzZpI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=u7Qr4PurAZM5bBMRni+qJjuWVPNufnCmxZGNurLOGC2NFABAj//4teOvBR6tikQ8huzuewV72tAxaBcFkhaOkVZ6pmcejJC0PLGq5Hai4IlYst/QeXsxlCkUvKXK/qeFphfwwHx0xIUcWQFcQ+pFGr3yzU4THJk6A90fmTO4t18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3Ct2zNx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1277396f8f.0;
        Fri, 13 Jun 2025 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749815750; x=1750420550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hj+Kuj4ajGUXyFsALB4EF9wgie9c+yJaBbr7r88UdqI=;
        b=X3Ct2zNx3dE8l0W6UQGDGZsKurORFhoVtr2ptXleK2zvMTQ+pver6f7lozst7bOzmL
         LaXc0PPtf0OYjfw+FPtg/ipabsoB7GzR0efiwZFIQt3s3G5B94iffBqLCQtPX7WqX/7N
         REoUzRX41DvSyYIKbfhuET8bGWxnc9kGM1rjbP8XbQB0i+FIVNnOdxZdvq/eLX9FezN1
         Vu7cKI5A2BVMcyzTInrgATPuXqUiYQcpDLtnZZjBwMjFTgw2LKvNrrDQx+YHurhnZsI7
         fLe0DqXtELVCuKhdOXIDrDzje3ZgWVH7+WgfvenzqlGFurS2zYL9G6InSmUC92juITVD
         wa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749815750; x=1750420550;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hj+Kuj4ajGUXyFsALB4EF9wgie9c+yJaBbr7r88UdqI=;
        b=Lec9pf8/o7En/RsjjWrdOCWnhX9eOEjf6optxIhbmabj7V4bQ3+gTRkcERjGjqvBnl
         1nJA5V74ZX4xole/9cp6yEOGmtPFa48wyZmo7ti108iDiBKONjZbkMqZyxCGdVu7IOZb
         JYp778FqrdnPekLO7RWRV2FsUQztn1IUj0FLAs1qaKbXvcHECyQOsNpQ4bLO5YSBK821
         vY5RRrHP4DYDX/i508fcpt1PPyJVu0yqZreLoRAF7buzF99fCljVTslMiDIYIJmKqOxi
         tALL32UsxItRXnWRGhX87dUe90Xn2mKZQqi/rsX7nUUQf/yFsSwzEBFPzV5HVDAWDaXq
         chMg==
X-Forwarded-Encrypted: i=1; AJvYcCVk9g9fVDquf4d26u500M3fww/Yse0XTaCtyVSINtM4PDC2/vYeUQCUL+GUAFe2eK0fG1u+b2rWpB3ZjeQ=@vger.kernel.org, AJvYcCW6bWMeUlYUyvWJiQhvyK6zegRxGmAJfHg1SNshPxOzpF70g2uwt3XFVndDTHeFl+WMIY/vleD9@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPM9eVp129sfpMtDRWz3lC5EM33UiGRQntTybApdzJI7Wp1Aa
	9HQ99AzKeGd7+VvNsqDRLMmu2KLt/rJ7Qq+NQ2HLlzgEnN78wxVkoedk
X-Gm-Gg: ASbGncvNtjLIQQDa/yjLwZL+dGVTwrtgipnBP8k4Tk1Zagjvvp9eT5vmu/N6nCqarFc
	Q85mZ/k9rX7Ew2c5TnUYisBTcIwUh7hClL5UggRIEiLnJCsNEwenEjC+Tg5386DcZ4PBQevw9Sj
	9alLaLPTcjHJid5ZtKefZu8f6rqsGh0DMOJnKnOwmhE4MKqDl/sVtosOypu2VCt9xBCoA/uVJo0
	6wHL27WyJkmw2o0qVeC7eUPkGodYw+Tg3euFPC1NPb9ZP2tBCvgQmbf5dzOC7liCb7aNsc/neYm
	+VZ1cb9oOPD6ai1iQF05v3ksAXjxqAVGqD3+W4iWnyHtr8ZXdnDt1P1B3LVRchsJKgRtxIZTq9M
	=
X-Google-Smtp-Source: AGHT+IGbaooFKQ20QFU1kZYymRa3Ue0gA9srqwzYyuAtJsiw7seBWEUCQrPm6Zfl385iai6WGcQtdA==
X-Received: by 2002:a05:6000:1ac6:b0:3a5:2beb:7493 with SMTP id ffacd0b85a97d-3a568656099mr2747920f8f.9.1749815749896;
        Fri, 13 Jun 2025 04:55:49 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087f8sm2177157f8f.53.2025.06.13.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:55:47 -0700 (PDT)
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
Subject: Re: [PATCH v2 12/12] docs: conf.py: don't handle yaml files outside
 Netlink specs
In-Reply-To: <d4b8d090ce728fce9ff06557565409539a8b936b.1749723671.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 12:52:35 +0100
Message-ID: <m2h60jn9j0.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<d4b8d090ce728fce9ff06557565409539a8b936b.1749723671.git.mchehab+huawei@kernel.org>
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

Please merge this with the earlier patch that changes these lines so
that the series doesn't contain unnecessary intermediate steps.

>  # The reST default role (used for this markup: `text`) to use for all
>  # documents.

