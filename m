Return-Path: <netdev+bounces-199287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34957ADFABA
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 03:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892F518957F1
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2D199EAD;
	Thu, 19 Jun 2025 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjg4Rqlz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79397191F91;
	Thu, 19 Jun 2025 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750296909; cv=none; b=XaVv7X9qMwve9TmlXdo21VUB2wHkjVh21OmVBa4p7IZKF5ZTgMp5vbsqSAp7KKNc3hzWpq21ldk2gdmwQC3KpTm3JmKtWTldYaIMDOVZCE6wrehxt8DcdYLDw9ZRw45DoUMkqhEs1H0EGIs2sYQWqRlg+nXQ6nvDhMmHzbm863A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750296909; c=relaxed/simple;
	bh=B4qe92RWiDJShMCHmxOj5yRAE1bEW5Fo7kjKCRJ7HYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaLkXbAqKqU4gM0xZhCuUsiLKwyXf0v0iSAz3IjtwCjzQmxEnODxcfcYNVNRVN5sNygE39BKUpTEcGT5VvWTIne8G9p8IMdUn2PJhP1ZDXMczzP4eJ3VAHponWSguaLrjmMWMswiemN69M/iz4CfqUEEQAlcLbwubjQFE9upIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjg4Rqlz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso191349a91.3;
        Wed, 18 Jun 2025 18:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750296907; x=1750901707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNw9ysipdpiqhc3psPSgAI9TjtSHXl8iuoxkHYIGdW4=;
        b=mjg4RqlzuknmZYFee1HdJ+0KQf/mIbFuPBre9czg+T1wvQeR8aHoik6+ww7xFFBid4
         3yzc6gjTY6586Y59yYXbdCInfQcYF1DckseT+nWgVJFjChUrXL1I4E8duUs5EcWfKB83
         wApWKVefSGFDr0X4H0dl1RZxCihWPnxCIWD0cwNo8HS66WbX/7fxpT5P78Cld+/GC039
         AxTMrHay70hE7O5oOePfLoU11LQjpuPRx5eOJ82yZIfiEjL7LSb3XfHOeLeo7QDhihT+
         CAQRWqC57Y8E7v8JazykX1DGOelF9IfxlkR33kCUiFlF4nuR6FvyKcbiaiSODrwVqSFU
         ZRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750296907; x=1750901707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNw9ysipdpiqhc3psPSgAI9TjtSHXl8iuoxkHYIGdW4=;
        b=GAx3dT3BrBOgNMKSQ9G3brrRXEBYVFSFLIOxcKIotpUGmbSsLXJLo3yUsA+5QFLXZZ
         3S3YEbJ4KsYVB3oGDEUErIwMsz8MAJBnfKoq8QsqlNDRe0xk0+3NbeW7IPrs+kTibcDk
         mlHEAaiFhnGEyvS2RI9VtBf2ecQj4BEPy6RhOUVpaGQmfgWl0ehxxWZcwHVMYBzqUR4J
         f3TlhNp9roM9bHLI0tmkvXGvTZ6CEzdEaaXlsKd3oaU1e6FrM15XEToZRVshuYM8qG6V
         jpwgEmd5XBAy+Tk8ut7SLAlM1TK3YDh0uKSW42feM0I+HIu+XwCtLV8gnMwmA6TtMmoT
         XFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbzlHl6dmgccT3CNltWMYB49fwe2RT4ppiAd+k6v+YpZjBmmp9hC1YfoT+J6NAqbPJFMRY+Z3H@vger.kernel.org, AJvYcCXvomFUL0/4tbQAPxU+F6POqRPxaqTbg8oE97Y12cAEUnaCrZ9U4MfnHS2/jesLdqiyxTONvl4EyafjxMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7qf/MLrN4Vej8zJ6Khp1zySThMMqbu1mY+vzWVBpWzgRowMp/
	IGQCEIsfcgKRQbVIisloNQvoa2jhCM5yzMtjBxeknIGX47hvigLP7WUa
X-Gm-Gg: ASbGncuD1V9Owld1429gqH73vCrapTPRjEVnS/hfUVFkJ9resJeBkLhz89wOYKnRRm/
	Ne0ZrHpNi1J/Ig6Dpcz4bCOt6il8WFmt18m+X9qZVkJynq7KcuvAFkYPgKBLnWcz5eoGNDU4YAc
	1uuBppBD8KxM+HgwYvn8Fg/cgS7rwX7xgNZnFmmdSn30lRmY4NLqWF2JbCB4IiAy2jGufQ/DHto
	NHxSavBayUaxifvviFgS9aMYnqE5ul/R67he34ucWROCwShMrjwk3WZT2tI/0UAL+3HEXnCwRPA
	8HjF5tq6LlxsjjIGK36nj4ch0wpy/hj1yyXrlhfMcX9cHdijiEsj6gtvCWG/wNnriADWH8Xkgg4
	QqX6oqmsjsH4RRTFExfBtbe94CPMzm5ol
X-Google-Smtp-Source: AGHT+IF3Vl4f6PedAqq/5vg30gEPk9+7i1apLb/Gckb9IptND6S77GoQsHuPfuiibIVLb7kvCDENXw==
X-Received: by 2002:a17:90b:5285:b0:311:ff18:b83e with SMTP id 98e67ed59e1d1-313f1c0b04fmr31071516a91.9.1750296906590;
        Wed, 18 Jun 2025 18:35:06 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3157a60781asm1471627a91.0.2025.06.18.18.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 18:35:06 -0700 (PDT)
Message-ID: <598b2cb7-2fd7-4388-96ba-2ddf0ab55d2a@gmail.com>
Date: Thu, 19 Jun 2025 10:34:59 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/15] Don't generate netlink .rst files inside
 $(srctree)
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Breno Leitao <leitao@debian.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco Elver
 <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jan Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Ruben Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, lkmm@lists.linux.dev,
 netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
 Randy Dunlap <rdunlap@infradead.org>, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
 <17f2a9ce-85ac-414a-b872-fbcd30354473@gmail.com>
 <20250618182032.03e7a727@sal.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250618182032.03e7a727@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 18:20:32 +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 19 Jun 2025 00:46:15 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> Quick tests against Sphinx 3.4.3 using container images based on
>> debian:bullseye and almalinux:9, both of which have 3.4.3 as their distro
>> packages, emits a *bunch* of warnings like the following:
>>
>> /<srcdir>/Documentation/netlink/specs/conntrack.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
>> /<srcdir>/Documentation/netlink/specs/devlink.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
>> /<srcdir>/Documentation/netlink/specs/dpll.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
>> /<srcdir>/Documentation/netlink/specs/ethtool.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
>> /<srcdir>/Documentation/netlink/specs/fou.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
>> [...]
>>
>> I suspect there should be a minimal required minimal version of PyYAML.
> 
> Likely yes. From my side, I didn't change anything related to PyYAML, 
> except by adding a loader at the latest patch to add line numbers.
> 
> The above warnings don't seem related. So, probably this was already
> an issue.
> 
> Funny enough, I did, on my venv:
> 
> 	$ pip install PyYAML==5.1
> 	$ tools/net/ynl/pyynl/ynl_gen_rst.py -i Documentation/netlink/specs/dpll.yaml -o Documentation/output/netlink/specs/dpll.rst -v
> 	...
> 	$ make clean; make SPHINXDIRS="netlink/specs" htmldocs
> 	...
> 
> but didn't get any issue (I have a later version installed outside
> venv - not sure it it will do the right thing).
> 
> That's what I have at venv:
> 
> ----------------------------- ---------
> Package                       Version
> ----------------------------- ---------
> alabaster                     0.7.13
> babel                         2.17.0
> certifi                       2025.6.15
> charset-normalizer            3.4.2
> docutils                      0.17.1
> idna                          3.10
> imagesize                     1.4.1
> Jinja2                        2.8.1
> MarkupSafe                    1.1.1
> packaging                     25.0
> pip                           25.1.1
> Pygments                      2.19.1
> PyYAML                        5.1
> requests                      2.32.4
> setuptools                    80.1.0
> snowballstemmer               3.0.1
> Sphinx                        3.4.3
> sphinxcontrib-applehelp       1.0.4
> sphinxcontrib-devhelp         1.0.2
> sphinxcontrib-htmlhelp        2.0.1
> sphinxcontrib-jsmath          1.0.1
> sphinxcontrib-qthelp          1.0.3
> sphinxcontrib-serializinghtml 1.1.5
> urllib3                       2.4.0
> ----------------------------- ---------
> 
[...]

> Please compare the versions that you're using on your test
> environment with the ones I used here.

It looks to me like the minimal required version of docutils is 0.17.1
for PyYAML integration.  Both almalinux:9 and debian:11 have 0.16.

Sphinx 4.3.2 of Ubuntu 22.04 comes with docutils 0.17.1, and it is
free of the warnings from PyYAML.

        Thanks, Akira


