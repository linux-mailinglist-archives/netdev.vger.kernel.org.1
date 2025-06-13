Return-Path: <netdev+bounces-197463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45875AD8B66
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51433B689C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1231E0DE8;
	Fri, 13 Jun 2025 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2ov20/T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5AF275B0D;
	Fri, 13 Jun 2025 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815732; cv=none; b=jdC9H+PAUbhVxEE4Cg3j21bRxKo2UiZhGZ0b/YWZiF9YhM4DhLAyoAYcBZQFVRPwwE43a27d//RNqbmrPAWRw9wRkHOgjlJRmiUaOBoqBRQk1NsCvgiyDiOheE5fOpN9PXVnAJJ0Sd7MQlns56TJBukag06JfQo3zr2KUnN74Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815732; c=relaxed/simple;
	bh=Sb5LOSkAwHk54c+c6zP3tGvl033zIanBvTqjdyRTILM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ORgr6wLWN1r472Usyl3td4l8NK34/fRkpoKS+U0kFxOfiO8YdCCE65TTccwOokBUdlkH7RMycZeAj3/27XC7xONsTUh/FKWMZddZm2rKyDqr1oNwEOwFfOpxiwCswXEESf4hNO7YPcDDLd0ivS922Ea71osUHrHIJEBI/h2UqCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2ov20/T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so17484075e9.1;
        Fri, 13 Jun 2025 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749815729; x=1750420529; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufE8HslboBgiS0ch8804+mkzD75VUbk5YRlVLPLoQRA=;
        b=k2ov20/T+cSy0umWVitQG+013KJvbv63xH44HZyXyYMwrHFPsPBn1DAXszsZVt2uxz
         LX2PLVb/daxktPoeXzMPD415tW2EGeZEUDd6thhWuUQoIh/CLSwh6Dz0N5jCP2BJ2Muf
         vB2LzfwJkoGb+WnBXq+t2hllNH6Xu7ysrXeuHLJlzhJcytrLF+8H7TVfTjPezo7WMZ4V
         +nwILPHcroEwtTAx4zI1ZrKwKT4/Vcx5pGQuxkPk6SRKzAgEXfhUr++bNzOf11WxFLXd
         aZFQNkwrFGw0V4yG1VzneLIw8LW0OhiR22WHol3V6JqNS78Hr3V7D0SjUIl0WhaLlzRv
         6PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749815729; x=1750420529;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufE8HslboBgiS0ch8804+mkzD75VUbk5YRlVLPLoQRA=;
        b=bJfDgDrZhMEXF8/Pb+1lfcwCHIalCbEJD+MzgLH5xxQ+YUQRTFa7EQgdmiRYIhAOyu
         DZfYPkQRkXQatlo8LLf1pAvo6ltZrQqgK31/xpNtbGvc5CwLmnJ5xe+p0A9BW+2FigN/
         z7z6ML+fCBbdkVqutsBsyzumg9zE22mRF2tcNlELHiiE4MnUn6mX1DNflMfoVeFO2zjR
         h3sBtQAZdpOmcyVGGlehbq63amHstRnFKBEqsu//ghYxC/R8g7CFifIpUm7TezMWG/5d
         4U5izYhthblVovegtuhPhcGAYN5vlSJ27nC07wc7ghvzj/X7vwhfmZmrxNhU3b0wn029
         0AbA==
X-Forwarded-Encrypted: i=1; AJvYcCWGazShPTTewCaJMAx1z0LQkyQM/6ZXSiHpkZsz7oUzG96TAs93BEVbyLIy5Me2CGUCM74pFEDvjJoPTHY=@vger.kernel.org, AJvYcCWMTOYQj3qB3CssPw54Z44kSKBH0rEqdGoPJfWisrvcgkt0xTzF9YYs0VXHqL8tPJMLrRkpLhIj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2dU+/rrFTzM6jE2xmJXKche2dzmUnAcHT9sx9PH4wQ9ktbdR
	o2f5ztc2D155xRCZSM1rogGwODdN87NXQzM0s8WlxegGVvrWWdFjitgufb754+s2
X-Gm-Gg: ASbGnctPyhbFQUJmJOMhM4gDqoYFdMdijkysmV7F9hoxLycCUxCariv+WCEBsWqKXtN
	loaei+wM9YyWMclYSUG3CKv+SKdEIglJdS6UFHGGP9z2t38/KGoqJebQZtnAt2nA0Z3t1TKJr8x
	w9bG84Mk7sRjnXBJImZWAH3y5PSZF15NkEiSCgnusF2Lx9A0AbPsnDxE5uBmabqs2EsyRG42vZB
	KduP2t2DMe+PjHiCAINdFeg5oAP4Lg6lj8T6g6wV4QXK31w+xkVZDLoES/fimIDHd2B4/UuYvfy
	yb70NUYxi9kwDQK/iQ3AqAuR7sbJvlqu98YmoEyf4mfLrOFvXp1Qedu8RarWBSXK38v0euHrPxs
	=
X-Google-Smtp-Source: AGHT+IGUe7DjzHHSFplul/ar5RfAw7b4aYzc9kQ5lrIT8AkHKhhxkXNesyYzYlzEDkL2JyHmPvem9w==
X-Received: by 2002:a05:600c:a49:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4533499e98fmr33137635e9.0.1749815729086;
        Fri, 13 Jun 2025 04:55:29 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e195768sm50645645e9.0.2025.06.13.04.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:55:28 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  linux-kernel@vger.kernel.org,  Akira Yokosawa
 <akiyks@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  Ignacio
 Encinas Rubio <ignacio@iencinas.com>,  Marco Elver <elver@google.com>,
  Shuah Khan <skhan@linuxfoundation.org>,  Eric Dumazet
 <edumazet@google.com>,  Jan Stancek <jstancek@redhat.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Ruben Wauters <rubenru09@aol.com>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  lkmm@lists.linux.dev,  netdev@vger.kernel.org,  peterz@infradead.org,
  stern@rowland.harvard.edu,  Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v2 00/12] Don't generate netlink .rst files inside
 $(srctree)
In-Reply-To: <cover.1749723671.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 12:05:56 +0100
Message-ID: <m27c1foq97.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As discussed at:
>    https://lore.kernel.org/all/20250610101331.62ba466f@foz.lan/
>
> changeset f061c9f7d058 ("Documentation: Document each netlink family")
> added a logic which generates *.rst files inside $(srctree). This is bad when
> O=<BUILDDIR> is used.
>
> A recent change renamed the yaml files used by Netlink, revealing a bad
> side effect: as "make cleandocs" don't clean the produced files, symbols 
> appear duplicated for people that don't build the kernel from scratch.
>
> There are some possible solutions for that. The simplest one, which is what
> this series address, places the build files inside Documentation/output. 
> The changes to do that are simple enough, but has one drawback,
> as it requires a (simple) template file for every netlink family file from
> netlink/specs. The template is simple enough:
>
>         .. kernel-include:: $BUILDDIR/networking/netlink_spec/<family>.rst

I think we could skip describing this since it was an approach that has
now been dropped.

> Part of the issue is that sphinx-build only produces html files for sources
> inside the source tree (Documentation/). 
>
> To address that, add an yaml parser extension to Sphinx.
>
> It should be noticed that this version has one drawback: it increases the
> documentation build time. I suspect that the culprit is inside Sphinx
> glob logic and the way it handles exclude_patterns. What happens is that
> sphinx/project.py uses glob, which, on my own experiences, it is slow
> (due to that, I ended implementing my own glob logic for kernel-doc).
>
> On the plus side, the extension is flexible enough to handle other types
> of yaml files, as the actual yaml conversion logic is outside the extension.

I don't think the extension would handle anything other than the Netlink
yaml specs, and I don't think that should be a goal of this patchset.

> With this version, there's no need to add any template file per netlink/spec
> file. Yet, the Documentation/netlink/spec.index.rst require updates as
> spec files are added/renamed/removed. The already-existing script can
> handle it automatically by running:
>
>             tools/net/ynl/pyynl/ynl_gen_rst.py -x  -v -o Documentation/netlink/specs/index.rst

I think this can be avoided by using the toctree glob directive in the
index, like this:

=============================
Netlink Family Specifications
=============================

.. toctree::
   :maxdepth: 1
   :glob:

   *

This would let you have a static index file.

> ---
>
> v2:
> - Use a Sphinx extension to handle netlink files.
>
> v1:
> - Statically add template files to as networking/netlink_spec/<family>.rst
>
> Mauro Carvalho Chehab (12):
>   tools: ynl_gen_rst.py: create a top-level reference
>   docs: netlink: netlink-raw.rst: use :ref: instead of :doc:

I suggest combining the first 2 patches.

>   docs: netlink: don't ignore generated rst files

Maybe leave this patch to the end and change the description to be a
cleanup of the remants of the old approach.

Further comments on specific commits

>   tools: ynl_gen_rst.py: make the index parser more generic
>   tools: ynl_gen_rst.py: Split library from command line tool
>   scripts: lib: netlink_yml_parser.py: use classes
>   tools: ynl_gen_rst.py: do some coding style cleanups
>   scripts: netlink_yml_parser.py: improve index.rst generation
>   docs: sphinx: add a parser template for yaml files
>   docs: sphinx: parser_yaml.py: add Netlink specs parser

Please combine these 2 patches. The template patch just introduces noise
into the series and makes it harder to review.

>   docs: use parser_yaml extension to handle Netlink specs
>   docs: conf.py: don't handle yaml files outside Netlink specs
>
>  .pylintrc                                     |   2 +-
>  Documentation/Makefile                        |  17 -
>  Documentation/conf.py                         |  17 +-
>  Documentation/netlink/specs/index.rst         |  38 ++
>  Documentation/networking/index.rst            |   2 +-
>  .../networking/netlink_spec/.gitignore        |   1 -
>  .../networking/netlink_spec/readme.txt        |   4 -
>  Documentation/sphinx/parser_yaml.py           |  80 ++++
>  .../userspace-api/netlink/netlink-raw.rst     |   6 +-
>  scripts/lib/netlink_yml_parser.py             | 394 ++++++++++++++++++
>  tools/net/ynl/pyynl/ynl_gen_rst.py            | 378 +----------------
>  11 files changed, 544 insertions(+), 395 deletions(-)
>  create mode 100644 Documentation/netlink/specs/index.rst
>  delete mode 100644 Documentation/networking/netlink_spec/.gitignore
>  delete mode 100644 Documentation/networking/netlink_spec/readme.txt
>  create mode 100755 Documentation/sphinx/parser_yaml.py
>  create mode 100755 scripts/lib/netlink_yml_parser.py

