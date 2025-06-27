Return-Path: <netdev+bounces-201895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A21BAEB5F5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6485648AD
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30FF2DE1E7;
	Fri, 27 Jun 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcdyu3sY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8F2DD612;
	Fri, 27 Jun 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022308; cv=none; b=cScC9beggc2Gkdf6ijHj1rqx5ATeUKtOoHDhkmcDTloQ60ao93r7sa9IEeuZyVI1uF8eDwKU2WE80z+RsM9Xbf/xB3V038G3z2oGbUqAkZaKXald02P6Mn+5K/vVx30EaoFu+b5CeYvpLdD5R7lCdqA3zTlMjSVmUE/8hvNX/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022308; c=relaxed/simple;
	bh=ppQn+qQ90LPpJSTEWumnr97tAFSmfMRRb9BDUUMwjN8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=lb8gVALNZ8fg+vcgJ2vnXtadUe3tHuo/l3mSZyEC0+u3cr3tcqfO2DqQIwnmGg9/0pP5wvvSGN2ZuDgjrHSTDzIMHXSEOrvbZG4aZzkHaKUDgDvmO7D1i+tsHtUWfGVUsRpEdUWfIcxOLhJvM/41XtJwBH000lFJkCC9zjuz7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcdyu3sY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453643020bdso17888495e9.1;
        Fri, 27 Jun 2025 04:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751022305; x=1751627105; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNpoYqb/6Tu0KuIF/3Z4TcTfvMcxACyRbx3GldGRXxM=;
        b=Tcdyu3sYkDCcUp8Zw9d6jK6QNLM4tbHQQ905gfHNCylUL3b6/q9UKjfE6SxzWq8vKv
         7hZizKaGO+VawtHGYXYaevv0AG1cthkmli81vSHqSbgAg5oe9x3F901Z+WeYSNZ/dIwn
         j7Y28IZVgdwsxezjiGqvQ3bIURdZVu+3p7i9pIatiAq3dRcCC52vPrvmOJEA7hmCy5RG
         t8q5H6gOuuLiFWalDS9nIFa+SKRc9q0QiZDgfUnyeAojAjTv7f2DI67+P3PxVE9bzDW4
         2IFBRPBfZAyd3a6zqllNELfcGeZup9uOQFmyEO7AX/sHjB5wEYorM7YQlWUMWrYWjZSL
         Uvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022305; x=1751627105;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNpoYqb/6Tu0KuIF/3Z4TcTfvMcxACyRbx3GldGRXxM=;
        b=kpDOK6JKKWSNl261WJ24471sMYz5dAMgLMaUzeF3IF52dlriMPGSeHml9QdBl/hiha
         dMY59CRiylDKgTxtcVJKMtFjbX9STyDsWV2/bCTkLZzpwmK70n9ul3vVd0hFYFgrY0lg
         Pjv5VeWI/8NEj5a/kHDQxLK4GBdP9TQZlR8h7Cy4yqu7nWyITARG0MOkYkNP+bneaCBT
         +ubDMlIvxtZCqEjuqg0OQJJ3PS/PF5t+5jEgJF01rBFRGtMyx2eXi3yXwioYymYxx8G0
         C79b2TmJCeCCfVZ8Fm61jrSfE083HyY3o5aDEuHwfBiaBsywUBcYPrENuUK9k9ICpBgv
         Kp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMAErUxQ1SfKEdcy7BtCbKTOnosK+d/s7pmn1poAb3WQNsC19ZB7OjXAK8eSm/Xj7wNhwDNu6383hey0c=@vger.kernel.org, AJvYcCXypXv2WiXYvo81edRrLaPZQ//W6a+F1qqjnLDresEmkCY3y/3gagzEiALANw6UMh6ldneuuF8B@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKwojzVBGy+Gpes2rONAlypo3gJb4SgxmBHA9IOUqbcWtd6VK
	/YYPqboxXkLjC3HWu/oDxmjydkxJWKiYWFn4hOWc4SuQUABHnmC8avMy
X-Gm-Gg: ASbGnctCUC3MniWQhU+/kjEG+Z1BWxmLjYmNcS/AyCu5YbXYgTmeFBnkxFWZWsqQX+Z
	IXKkMHDWy7gjibH1uZkMiBENFC8Zbyuuuyd9F3IoVd5YT2LGF1g4VXvulxQy+bFshMv2KqT0z89
	uONVh3UG+YrJZxe2oa0Zl4W06KAjL5sSMJ9G9ZoTNWmaVe0ghDPJ5luVUZmdVSmosURe02BTF3N
	buFljujiRH2PidTGkPMBDv8AQ8qsoIbCdfEcHB8LagYLFwBFxqipyaVIKidw1ci3EOrocBHTQn2
	vPr/3yIUvzaKuBMqS/UB6dbYHie+SIQwKTpzDnrwBuOMZIuomHrTVwJYaQrs7+jcVdRyYIKbnw=
	=
X-Google-Smtp-Source: AGHT+IEW+VyfbzB5QN/NRNUa99sM0LvI8L4cDy6ynoPn7Q4Ru6gR/EqZ673FUOrLyastEjFoWeHGDw==
X-Received: by 2002:adf:9ccf:0:b0:3a5:67d5:a400 with SMTP id ffacd0b85a97d-3a8ffcc9da8mr1892347f8f.33.1751022304411;
        Fri, 27 Jun 2025 04:05:04 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:40b8:18e0:8ac6:da0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52b9esm2405966f8f.61.2025.06.27.04.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:05:04 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Randy
 Dunlap" <rdunlap@infradead.org>,  "Ruben Wauters" <rubenru09@aol.com>,
  "Shuah Khan" <skhan@linuxfoundation.org>,  joel@joelfernandes.org,
  linux-kernel-mentees@lists.linux.dev,  linux-kernel@vger.kernel.org,
  lkmm@lists.linux.dev,  netdev@vger.kernel.org,  peterz@infradead.org,
  stern@rowland.harvard.edu
Subject: Re: [PATCH v8 11/13] tools: netlink_yml_parser.py: add line numbers
 to parsed data
In-Reply-To: <549be41405b5ddb6b78ead71f26c33fd6ce8e190.1750925410.git.mchehab+huawei@kernel.org>
Date: Fri, 27 Jun 2025 12:03:07 +0100
Message-ID: <m2bjq98n10.fsf@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<549be41405b5ddb6b78ead71f26c33fd6ce8e190.1750925410.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> When something goes wrong, we want Sphinx error to point to the
> right line number from the original source, not from the
> processed ReST data.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/net/ynl/pyynl/lib/doc_generator.py | 34 ++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
> index 866551726723..a9d8ab6f2639 100644
> --- a/tools/net/ynl/pyynl/lib/doc_generator.py
> +++ b/tools/net/ynl/pyynl/lib/doc_generator.py
> @@ -20,6 +20,16 @@
>  from typing import Any, Dict, List
>  import yaml
>  
> +LINE_STR = '__lineno__'
> +
> +class NumberedSafeLoader(yaml.SafeLoader):
> +    """Override the SafeLoader class to add line number to parsed data"""
> +
> +    def construct_mapping(self, node):
> +        mapping = super().construct_mapping(node)
> +        mapping[LINE_STR] = node.start_mark.line
> +
> +        return mapping

pylint gives these 2 warnings:

tools/net/ynl/pyynl/lib/doc_generator.py:25:0: R0901: Too many ancestors (9/7) (too-many-ancestors)
tools/net/ynl/pyynl/lib/doc_generator.py:28:4: W0221: Number of parameters was 3 in 'SafeConstructor.construct_mapping' and is now 2 in overriding 'NumberedSafeLoader.construct_mapping' method (arguments-differ)


