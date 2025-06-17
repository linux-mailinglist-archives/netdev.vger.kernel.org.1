Return-Path: <netdev+bounces-198591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66583ADCC7A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD77A17C95D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D632E9748;
	Tue, 17 Jun 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4bE92Kx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42B42E264B;
	Tue, 17 Jun 2025 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165221; cv=none; b=drTUv/NenOz4Kt6ml49rh9XoxLr09Zd3GTUBIjgVUSW9Y8KW0w/HhueRU9fyhmRA41zrr4ltYNy8DqgIvgfbzxq5QaOHu4wFjjaIlyzKkFsBuSaYCKbwU05MFtodtYGUEOke0TwLpfBSdxDAikEtMhs85q6bL1t3ipsWHnZj+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165221; c=relaxed/simple;
	bh=x5Wrb85DRWbVNOvnfzFdGgHoRKBrMPTvOnwfQ5uCOG4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=bu7SxGmSXY5jOh78ZTzc3UFkmWr4mS5vKPWDQv2ApwSsGkpEnfyDPiTXYiJ3u8KQnMp4yao39EZWhnmEd2rh84qgL67Ejqo91F0HH7HWFZ6sPFkI2RknfigEdHqrGBfY5SFXErutwKWWzeC2L3J7cSZX7y59+thM7D2UeMGRrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4bE92Kx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4530921461aso49077485e9.0;
        Tue, 17 Jun 2025 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165217; x=1750770017; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCBsAUdKLlXHFAS2dv9cOixZKTFpwiXbiHVQbvH0Ze8=;
        b=h4bE92KxAdOXyBEKrY5gB5XgkzGk8Eph8KqhITj9Tb1e3oTkaqlP7PQuYUydP8OW9/
         wG6ayXjrPYsrJYIzEKzOiQjVFbEheHQa2Zik3eQBX0Rr4o76DjwLNzs1Rq+zVsuGqkBB
         xyOBAY+kWKOhr2b86R9CVgypu4GbiB+11+NISwEUS6I/bt9x2zeCQclgDtX1evpNpyFJ
         7vt5bJ7MoEHA2MCPihfqT2V0gseKKrqSXHF4xYyh3gvVOb/AEsad65wfvCaURmioR4Zo
         W58b8DYIbstHz+YLReFr+zNWAveFs2WOGS+f3xiNQOyxOYN2kDAleimI4r1jLqCKn8/s
         SP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165217; x=1750770017;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCBsAUdKLlXHFAS2dv9cOixZKTFpwiXbiHVQbvH0Ze8=;
        b=i9F9tRiZxfpujeIwLoyOrhYlcE2ftGNmPt6fZ31e+7nQdUqWs7UPkJu59PF/LUjamZ
         hAnDY84+W7Hxt74/RsRx8Jt47I3EvSXZDYZT4rBBjkGpcJAitDdHVCSfjrV4wwuyGIHO
         W4tV3VDyt/Kx7hHTiwjHLOiMTf1RThCRpts9MvMi+YZFkvg43p+4Tu6GtvEF4guUZ9n8
         axhOKywGJ33mfyk4Mm1/rSsNOfqzlql5FxeICMX5IISevbn5nbpPHgR2nRJ/xT/3FIOJ
         dABRXyiYp1GlQw0pzRpZUmQYo0tSmg/ZMnNSONLTH6M5f5nepLVpzoxo5gn6+EGhsOPh
         NLIw==
X-Forwarded-Encrypted: i=1; AJvYcCUOKl8+VquoLbDuOIFovN07USfDVJJp65K/VfqsXh2Y8Djc8D3k3Wh8fPTNEdNtVoreu+Zy4wch@vger.kernel.org, AJvYcCVfzDA9Imm+pWL1btdSUq67lJaRVmLJKDviWFknwLdv6bGnK26sVpLCrGOMfoqNRcZqIMrkBSnIKXU3zFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLG5Ogrru2TT2bN0iO29Q+U54N8s5J2YixpyVDa+glSHwOzYsR
	PgwsGB9MLyG6k4GwJLkWlVkHL9Q+1l2VI2RSi3S36bHETg6fSfvKzdeOYOz0Moa+
X-Gm-Gg: ASbGncvqLLgGGx/adrjoUMSA0lIfQDAiBidWuMsiWalVYJGN/BC02N/WKqAanjcH6yA
	FyHEcyWeo3tUx4X6gpg4ZHEhzXnxa2e55ULJt6HqUjCBO0J7J2VE4PDcWtxvt9jzRxDUltz8WOw
	1wTXbzKu0C5Z9E6AITrulgWGbm8spulgox5ffc6GAi539GumkuTshxtjsJOW+jS+VMU/s1fXbR7
	c/iy+3ZYqYDKup+zO9sLIS8+lFpxxUHAGXI4pgQqfukHh8GuFsgOPFTCihnrwQWFfEvXTFpd1Kf
	9LU5XcP0MUh8fvc2y0zq6VtLS17POpy+JlZra6drnxHBSr90okMCVnohsx+uEpJ4jFrqiGLevQM
	=
X-Google-Smtp-Source: AGHT+IE47uR89T5Uem9MM2qCkm1YZX6jwmHcz73YYxvO/Jmwjj1PBFbbbUyCJLNhhaUZOFeMr0rGbg==
X-Received: by 2002:a05:600c:37c3:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-453561ce33bmr8920735e9.21.1750165217074;
        Tue, 17 Jun 2025 06:00:17 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e1838fasm173538455e9.38.2025.06.17.06.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:00:16 -0700 (PDT)
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
Subject: Re: [PATCH v5 00/15] Don't generate netlink .rst files inside
 $(srctree)
In-Reply-To: <cover.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 13:58:11 +0100
Message-ID: <m2msa6ikyk.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
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
> added a logic which generates *.rst files inside $(srctree). This is bad
> when O=<BUILDDIR> is used.
>
> A recent change renamed the yaml files used by Netlink, revealing a bad
> side effect: as "make cleandocs" don't clean the produced files and symbols
> appear duplicated for people that don't build the kernel from scratch.
>
> This series adds an yaml parser extension and uses an index file with glob for
> *. We opted to write such extension in a way that no actual yaml conversion
> code is inside it. This makes it flexible enough to handle other types of yaml
> files in the future. The actual yaml conversion logic were placed at 
> netlink_yml_parser.py. 
>
> As requested by YNL maintainers, this version has netlink_yml_parser.py
> inside tools/net/ynl/pyynl/ directory. I don't like mixing libraries with
> binaries, nor to have Python libraries spread all over the Kernel. IMO,
> the best is to put all of them on a common place (scripts/lib, python/lib,
> lib/python, ...) but, as this can be solved later, for now let's keep it this
> way.
>
> ---

Note that the series leaves the YNL build broken.

make -C tools/net/ynl/
make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
make[1]: Entering directory '/home/donaldh/net-next/tools/net/ynl/lib'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/donaldh/net-next/tools/net/ynl/lib'
make[1]: Entering directory '/home/donaldh/net-next/tools/net/ynl/generated'
	GEN_RST conntrack.rst
Traceback (most recent call last):
  File "/home/donaldh/net-next/tools/net/ynl/generated/../pyynl/ynl_gen_rst.py", line 90, in <module>
    main()
    ~~~~^^
  File "/home/donaldh/net-next/tools/net/ynl/generated/../pyynl/ynl_gen_rst.py", line 86, in main
    write_to_rstfile(content, args.output)
    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^
  File "/home/donaldh/net-next/tools/net/ynl/generated/../pyynl/ynl_gen_rst.py", line 64, in write_to_rstfile
    os.makedirs(directory, exist_ok=True)
    ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen os>", line 227, in makedirs
FileNotFoundError: [Errno 2] No such file or directory: ''
make[1]: *** [Makefile:56: conntrack.rst] Error 1
make[1]: Leaving directory '/home/donaldh/net-next/tools/net/ynl/generated'
make: *** [Makefile:25: generated] Error 2
make: Leaving directory '/home/donaldh/net-next/tools/net/ynl'

