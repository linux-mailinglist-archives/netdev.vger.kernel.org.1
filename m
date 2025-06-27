Return-Path: <netdev+bounces-201890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E9AEB5F9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCC97B5756
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776972BEC32;
	Fri, 27 Jun 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4CTDk8G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F82BEC4A;
	Fri, 27 Jun 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022299; cv=none; b=bpiQ/I/7A91t9fzv44shmNjhYnSSikrpdtH1MASZYgBw7pgfDwz9J9eX0QtxOxRjj0mka52DTYY8oLnWr57EnIa/B+t2CXWO9skmfbS1KgZO/v2ztSzYvG5i8WKgtGhkg4KLjFvPVpIDYKfdl7bkf0L1I9Q0P/wmTi8lUVvHbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022299; c=relaxed/simple;
	bh=7OX2gmVdzbsDMuU5mDzT/dNOdFBH3pSx7pn8SHF3BpA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=BIYsXLL4SeSg6wp/a98jhlZ34X+XQP5lGVjQfulY7OmzarPjl/rsouM8NngKLDXjmZtXb8+i+uQ2bpnQJQWO4c9+ZK1hrypqJIdw1Bdzscep+CCwjWaGN1vyXfEwoOEhKC8QZW3wKcpnLK9kroZKs5Jmgwlw1hhew+p2g+3T36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4CTDk8G; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a575a988f9so1210973f8f.0;
        Fri, 27 Jun 2025 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751022296; x=1751627096; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+sVT4qtdvzplq7Tz7qyhzRU8mVdcqltow7utE3n3/o=;
        b=l4CTDk8GmRToQ799QQqTo96mNTCZUMRPIV8tzItUOkfsO1kzVStfO9S4MlQ22oWRIx
         TRjna+CyCjJxLFCQ3C8zKVEOY12+g7iMPhntIv27+3yPiqNWVjVugRe5YYiDbLG1KMzL
         N6lWZGUk8VmqmMAE/2COdl7cLREcixUutd9MokHGTNepUlXvwqIwnYkw+mxoUMl+Dk1w
         neRrPyUui4EZhccRnJ8sxdWlhBAN7gPZw90elkFTQ8sp1qdWjXYcNeWZJ6Y0eBs52+fl
         EJyVUrrfQVc060o+a7revA8Gw/2c1dUG6cpIIsrm8kALM3ZWX4MCYADkpMy0sHegGiRe
         OyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022296; x=1751627096;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+sVT4qtdvzplq7Tz7qyhzRU8mVdcqltow7utE3n3/o=;
        b=RDct0P6Z3D2lnm6euM1DVae1hWjY1DzUedhpT8+tiQ/edPMmGAxw4Gb4ohcQTW0lF/
         JtpxtWKbUoerXkLPUK0i+odbkVyiP7jUqS6kcsdPFmFdcrzYof/llhFF00PoGbMKO0mt
         RtcR/aSLErISIvlBrdfoocodVzki6C/o/ZtDa7FxuCl54zsnboDxTlNmUwFfuPhoFdxP
         CBOb8bbeuWQi0SqwUcSwMTPUL+GppLgaW0T2FSviK2a+MjnBa8pwZsN4RONorzpa1vuw
         42h43BzqonessZcq0oiFgLtqn1/NDEo8PDQ3yHs/FXOFYymPNhIBPxxi7PNDN8aYYJMV
         TSaA==
X-Forwarded-Encrypted: i=1; AJvYcCVKhYb7cis64B6EYSbXONcFBBn9CLlZIP8e+3pYvvzAcqtmhuFZYVanf7Lkbc/xGvGr8Hkqa7TKjMZf+lo=@vger.kernel.org, AJvYcCWbcDFpDQ68II9RY1C8VOOMGnvLCSSN9XNvgWHLlJFseB5e8tSF31d9YhvAykFk1T//k1pynXRZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8K6k1hAmxEaW702bxBZRSwI2ro8gJRvooizyrzbhyYr5L+Oj
	FMRhNFIMFXABLladvSR4zHZBFZrrHF+tfuwQwA4DzaHPE4b4eXKb/lSW
X-Gm-Gg: ASbGncuLDURyBdLO8cDTARSqkSmQkYX5+LPHARcew3iuEElT2CDpsVnCk8wkDSJvrEB
	BQdeDQ9W4q9FvihMnCtoZErbc4zwGQd8yJUoimW7C1joqCWJ2CQEydHN4JdM4PfDKqlcZxT486p
	4Ri4HwOdw6Soelv8M9YGyzcTdi6fHYHI3yQqpauUvYwrXYXE+PQy65eW62rkCgIq6NXeYUJ9fPJ
	jwCe4/K6syuKd1gIAm0dhBqtrLcvu0XSnuePByHyuNQskAQtVMLqkZWgIkCHBAt8cOO/d9e8TOq
	0Rcxoz8fdoPztTG81B5w2x912wXv9m42rtZYTPP4UXmwEI0bodln7E9L2EdWwmcqfkcm+PHkRw=
	=
X-Google-Smtp-Source: AGHT+IG5sOZtrZ/xkGKBtpPDwO9ulvETh61gbQZuRWutZTAPMm2RPvXbvSU+mZffShbCxp1x7KeuNg==
X-Received: by 2002:adf:ea49:0:b0:3a5:2cb5:6429 with SMTP id ffacd0b85a97d-3a9001a2429mr1995199f8f.43.1751022295630;
        Fri, 27 Jun 2025 04:04:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:40b8:18e0:8ac6:da0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa5easm2364868f8f.26.2025.06.27.04.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:04:55 -0700 (PDT)
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
Subject: Re: [PATCH v8 06/13] docs: use parser_yaml extension to handle
 Netlink specs
In-Reply-To: <34e491393347ca1ba6fd65e73a468752b1436a80.1750925410.git.mchehab+huawei@kernel.org>
Date: Fri, 27 Jun 2025 11:28:40 +0100
Message-ID: <m2wm8x8omf.fsf@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<34e491393347ca1ba6fd65e73a468752b1436a80.1750925410.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Instead of manually calling ynl_gen_rst.py, use a Sphinx extension.
> This way, no .rst files would be written to the Kernel source
> directories.
>
> We are using here a toctree with :glob: property. This way, there
> is no need to touch the netlink/specs/index.rst file every time
> a new Netlink spec is added/renamed/removed.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

This patch doesn't currently merge in the net-next tree because it
depends on a series in docs-next.

> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> index 585a7ec81ba0..fa2e6da17617 100755
> --- a/Documentation/sphinx/parser_yaml.py
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -18,9 +18,9 @@ from sphinx.util import logging
>  from sphinx.parsers import Parser
>  
>  srctree = os.path.abspath(os.environ["srctree"])
> -sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl"))
> +sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl/lib"))
>  
> -from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413
> +from doc_generator import YnlDocGenerator        # pylint: disable=C0413

Please fix up patch 5 so that this diff can be dropped.

