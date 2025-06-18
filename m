Return-Path: <netdev+bounces-199128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F4ADF19E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35F916C7DA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2972EFD90;
	Wed, 18 Jun 2025 15:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D652EE98F;
	Wed, 18 Jun 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261378; cv=none; b=o+AYRD0XJzlUXTUVq55HctnMqQf3yptDJIL+EUhxO11M7O1M41GRF9x/u8fa2fOyqhHQtdFKtBgqNN1EkNE15ZOlyJd2lG+uOYWzwbjANffGVZhtw/0Hl4MeGuLGtA8vssCyP6t9fuq5v+jZC0lHrvDYaURh3/7Dff5y5GKWYOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261378; c=relaxed/simple;
	bh=ZAdHHI1Qa6a7uSzz9G6krYI8Sdg7y2V5dKsM4QZVgG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc7xdly/EMjtfFCQZuPtNAWKpj8pJRfT3+XGPLMx74CG0dmCQi+2EYkZ2NGhBQJXqpAaAMX7CggdX/awImTyym6jLV7ebqGDXgYvdjtdsVsCQr6/3YeNQAyoYzCGGqTNL0QMA/x1mQW8ll96C1Ekkm99cGnFLo1HF3xVH3Hb1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so12001989a12.2;
        Wed, 18 Jun 2025 08:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750261375; x=1750866175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWYHbpP051s3adQYzbRj7oJpUnu9maWKCI8y343Rnlo=;
        b=akWtb8QeMhEfFBUq4Sjj4I18D/DjTjv9pIbZwBvgFEHHkZqNKsP1VO5xMyzrFv8riJ
         7gvN4GDnQkSBFcwibLBE8r3G0hwaRM88PxyqdND4hCM78JCjD6wDmPehHbi6silLDxDO
         FjeyMCxkL/j04ZKjMHbBZ1CM3J8HQ7SRsX5N/4mDWLBbqeKb/vZ7VOjuxTqKHzQXkMHR
         Bz8rQtmY3nHOO9C9/yT01IqlhNNj71KYBMzVyad3R7rTyYE7dnlArJ09E20upYJ3kHdt
         FnrX/XSm67qDHgkYPjM856u5J/axRwUaj+KUayUNAWZGedGojHb4pGxkBM+iDX9jStPM
         3XQw==
X-Forwarded-Encrypted: i=1; AJvYcCWCP1XJt4u+iCs3OQEgQSfD7LlLU3zHfNPFTsiXxoX8btb+5t+zQp3lBdJL0uCmAhbN86LEDsm7TkLM+NQ=@vger.kernel.org, AJvYcCWg9gVPpDnbnCRxuodH9bJ5lwlAMib/9/jXR46u1h1qZzFgYaBzSHkIiJbv3LlmFSptMQoLdSmI@vger.kernel.org
X-Gm-Message-State: AOJu0YydZP58XwjECssjK3GjPkkaxfpglqPJP9kaf2IvBrIbHdX8gogG
	XfguySoOOODtNqsLsDV8sQ1kCaCcW0KmR9eZFZDQuBTTDqJMsEJzOvxG
X-Gm-Gg: ASbGncsWLI6ufmuaFs6SuyFzN0lGYGVYQdktLN4+vm3jYj9Cb8YP/pjf++SbEPr1SWW
	/3OXFWYmrUNwt0kXV2HNmnsky2WTHL5b46hcrt8OEjAzPwDNQrGSHzRQwVndWcDEO2Q2vb4WhKH
	atWcTyJPAyTxzcVDos2kaoc/ohYUjyYYCiQ4lLEoC3hIt0YXZAqhrtTOK2pY7QezLNyXe1kK4kN
	hrX5ZraZM3EekfvztJ25dH2P7w87VX7/VB1pxgNxJy5d+EQMAonsNKCi8tXWjqYOA0z0Arh/pOh
	fkLZ3G/d5ie2pC/U9w0cAOJ3Fa8tFW+4qt0zElpYodPfOdla7nC3
X-Google-Smtp-Source: AGHT+IEZeb5BUZBwW+3X3Mghevtyvvv3qa+6/WQujzPyWQjQVnuNccvQjc/vqxVtBIzGQN0UTopzuA==
X-Received: by 2002:a17:907:3f07:b0:adb:2db9:b0b0 with SMTP id a640c23a62f3a-adfad415cafmr1729558966b.35.1750261374664;
        Wed, 18 Jun 2025 08:42:54 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5d3sm1104154566b.101.2025.06.18.08.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:42:54 -0700 (PDT)
Date: Wed, 18 Jun 2025 08:42:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Jan Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: Re: [PATCH v6 01/15] docs: conf.py: properly handle include and
 exclude patterns
Message-ID: <aFLee2PdbK+6SiA8@gmail.com>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
 <737b08e891765dc10bd944d4d42f8b1e37b80275.1750246291.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <737b08e891765dc10bd944d4d42f8b1e37b80275.1750246291.git.mchehab+huawei@kernel.org>

On Wed, Jun 18, 2025 at 01:46:28PM +0200, Mauro Carvalho Chehab wrote:
> When one does:
> 	make SPHINXDIRS="foo" htmldocs
> 
> All patterns would be relative to Documentation/foo, which
> causes the include/exclude patterns like:
> 
> 	include_patterns = [
> 		...
> 		f'foo/*.{ext}',
> 	]
> 
> to break. This is not what it is expected. Address it by
> adding a logic to dynamically adjust the pattern when
> SPHINXDIRS is used.
> 
> That allows adding parsers for other file types.
> 
> It should be noticed that include_patterns was added on
> Sphinx 5.1:
> 	https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-include_patterns
> 
> So, a backward-compatible code is needed when we start
> using it for real.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/conf.py | 67 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 12de52a2b17e..4ba4ee45e599 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -17,6 +17,66 @@ import os
>  import sphinx
>  import shutil
>  
> +# Get Sphinx version
> +major, minor, patch = sphinx.version_info[:3]
> +
> +# Include_patterns were added on Sphinx 5.1
> +if (major < 5) or (major == 5 and minor < 1):
> +    has_include_patterns = False
> +else:
> +    has_include_patterns = True
> +    # Include patterns that don't contain directory names, in glob format
> +    include_patterns = ['**.rst']
> +
> +# Location of Documentation/ directory
> +doctree = os.path.abspath('.')
> +
> +# Exclude of patterns that don't contain directory names, in glob format.
> +exclude_patterns = []
> +
> +# List of patterns that contain directory names in glob format.
> +dyn_include_patterns = []
> +dyn_exclude_patterns = ['output']
> +
> +# Properly handle include/exclude patterns
> +# ----------------------------------------
> +
> +def update_patterns(app):
> +

PEP-257 says we don't want a line before docstring:

https://peps.python.org/pep-0257/#multi-line-docstrings

