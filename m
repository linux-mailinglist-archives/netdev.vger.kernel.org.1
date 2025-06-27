Return-Path: <netdev+bounces-201891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F2AEB5E1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5723AF509
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288002D97A6;
	Fri, 27 Jun 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQw6iH+u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B72BF017;
	Fri, 27 Jun 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022301; cv=none; b=YUkmdb0iYnGBXJePYrnk63ScM4s4WD6fyDHSJGQznk0xjar2I54et01G0sRM6HTIF9KmwYHMXa5lkZl7XvIYoxoPR95WTudakXpQEPjVrs76aztCTo2zS0iNQdOyt0RQhUE1E5EIhGnIkT8NvbDwqTZZJ+d0KBsgOgA7kbDt8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022301; c=relaxed/simple;
	bh=Gab9HlTdevtNeTDMwimxTwHY16y/zKL0OdzGVNj+iY0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=b5AqN3VfqB+ikWSJNIODMLgBT1vT1YPlSwmvYuKrquvdX/F0zWhJIDnQO15phTwe7n0czKcQjM8Y9y90y7Mw309YhuoAEgW+bAwu4FBJWxmVQHsOBCp8F7Hd1kp8m7S9S24pr09SKGtdvp4VWPN5qou1rw4Ax8DnRWhZftYYu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQw6iH+u; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a582e09144so1306514f8f.1;
        Fri, 27 Jun 2025 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751022298; x=1751627098; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe9OQkLMXpO2IZiw3ZWA9BPKAW+1uGPTqT4qLkMzqak=;
        b=XQw6iH+uPUnpy+0w+VVQ6WrzgO5BJyO3Q3k0VOPpUo/vUfnfIE36djEqd94/rHK/Fm
         7bBJPkBvDYdN/rL9dUMSJPd8ciNWmoFSRKaSMseLqGmTCGYFCdolDEt0z5kKTklucLsd
         hYVf6G7lfI0CJnXKLjAaGuENL9u05Z6GKw4orfVpllb3PaIEqAXtqOX6iW19J/iNOPcO
         FdWwCskX3hpVK67cJ1mCYIaotQmvJiJURMYQ5AioJnb8z8S2U55Eds/EOwmOcYizR2fQ
         X35rQxS9E+oNqCagkE5fWtCgCPdCAT4VAFlodGvyMrPh+2aGNaqCcfwdJhLysolg8QCc
         4BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022298; x=1751627098;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fe9OQkLMXpO2IZiw3ZWA9BPKAW+1uGPTqT4qLkMzqak=;
        b=qD2/gApJ2e5Xfxa0YiT8JBy0RppyXWMaCm4A5x/7wEU5NOQHHbokBvkGMxfd/xpmYC
         povVmy2TmsByIbf4mP2TYRKGBIXTRmjEtmLhFACvWu0iAZRvBmIzqKd+tHI1NJPKxWY3
         eoTh4y63ru1UF4DPI9NzZMNZNZkXnNOzCGbTBpYiG+i07wrK6zmqVv5vvZ1tbAH5pSV9
         ide3TT/5wcsEOUoS6AOK9j4xIzgOAUwNEvz3738v6Jg1cEHH6sveVKXmJWcYywWRHJZe
         YdYiM/UpEuPpqOvYin5FVWhR1deiitoR9l6eQfgwVYdOf3rT6bh2jvYtWKeN6dn+e7Zu
         Jcmg==
X-Forwarded-Encrypted: i=1; AJvYcCVi1iu4iPlyAPq1Ywk0q2SkQh3plByJNgfZYyArZ8cefruDpKxknzPGzwjvZ/nh2Woz+mvjfhUt@vger.kernel.org, AJvYcCWLDjyOi5VEPU9NGT2u41jUWS55nrJoOk/qnAee/IvKFMdMoea0hg+EFIGdL3oymHGyptlZbYxAWQiK4W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQp2fCLgXXsuc78k4yv7rWfQ+GMt0gFJqbFfKRUk80qaJd3cm
	s3IFR2yh9hcEnkmRBI9n9OSdnFluk+iAvvDhWhuV35tCIckfq2P5u2wL
X-Gm-Gg: ASbGncuALWL2XV9nnEMmpFIlNHAJKOF1Tw21QKf6XRwRQvml6ItHl6DMmBhCr6K0Luv
	/9TGHRcLF4lBpSVvNuv5zfpfnwsMzKjG5hYqRYhTUdNYUrh7e6QNRZvg3yyIohkprecpOcO9G29
	S8m3L4HfTNAggVXZaoc2KQYczRCNVfs8erGpZIp/r34epgFMGr7PiDETBIgUwULcIqaefKTF4W7
	UXzAyPFv0fUarPxl28Po5heDsssDEOFIr024JMPHP1V3CXH2nF5Fpjw3ZDDd0RXAL7ki4L3qN1g
	CrurKx67qPDxrF45ENofXtxdwOpA7VfpigvY86zs2JHv1PZC9k4dSw0qarvEgGox/qFaytXxjg=
	=
X-Google-Smtp-Source: AGHT+IFVcMpR0rLM6VYkpxbugODonjletnVYfb7gUIKV7lAQ+3Nt5KGTvKv9ehhSsIEGXJogIF2sYg==
X-Received: by 2002:adf:9d91:0:b0:3a4:f744:e00c with SMTP id ffacd0b85a97d-3a8ff51fcc6mr2124588f8f.29.1751022297497;
        Fri, 27 Jun 2025 04:04:57 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:40b8:18e0:8ac6:da0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8absm2432679f8f.95.2025.06.27.04.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:04:57 -0700 (PDT)
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
Subject: Re: [PATCH v8 02/13] tools: ynl_gen_rst.py: Split library from
 command line tool
In-Reply-To: <bf7908e3b23ff85e245e4ea151d8b5be69de0814.1750925410.git.mchehab+huawei@kernel.org>
Date: Fri, 27 Jun 2025 11:29:39 +0100
Message-ID: <m2sejl8oks.fsf@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<bf7908e3b23ff85e245e4ea151d8b5be69de0814.1750925410.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As we'll be using the Netlink specs parser inside a Sphinx
> extension, move the library part from the command line parser.
>
> While here, change the code which generates an index file
> to parse inputs from both .rst and .yaml extensions. With
> that, the tool can easily be tested with:
>
> 	tools/net/ynl/pyynl/ynl_gen_rst.py -x -o Documentation/netlink/specs/foo.rst
>
> Without needing to first generate a temp directory with the
> rst files.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

