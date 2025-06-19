Return-Path: <netdev+bounces-199447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBAEAE057C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953D0189CB7A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D324EAB1;
	Thu, 19 Jun 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0dG+WWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D8248888;
	Thu, 19 Jun 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335607; cv=none; b=Fjuk6g68V0xQshgvj3ATU4Cco+Z9o70/i0wij0lBkqims6FuCtknh+FIc6+NrG28Ge7jY4SZb67usMvQO7Hy1pnlHGnW9579ug4f0pgFhz4Pwk7x9xW/18W9ufn0BTp9GInu5V3DFPEXFL17IE00Q76E0uwqxnYBzGH7heM5meI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335607; c=relaxed/simple;
	bh=+9UeE2l/NBrc6NHJHLM+SqBJwMqTtJPpRZcGfcKWndo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=QICM2JGDZ3snocuHfbgpDGlYpgUOLUJUpeEyXwhARqsBtQU/5yx5RNHhcvbz89qji6tg4lbh65vY8lTpiY/gb6mBE1t0Ku5wlWgPQtLxKwiJ1uek5V3/r80lWwjFyde8Nn0JithHwuJ738tr3SOfHirUjv3uzjA8Q8JMeZ3knJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0dG+WWs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cf214200so6602575e9.1;
        Thu, 19 Jun 2025 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335604; x=1750940404; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpuh9d9jSa1SnmPuObykoxa1W8u0W5/a2m7QmA4uxfc=;
        b=Z0dG+WWsUSSNkH3hoZnMIAocLt4VDyxl2U3qySxxEaKPavWrbOxg2vjeA0XueV7AtB
         VOq2zsRdHgt70cisIqZBUiSoq1EvF0jH3b06OUcxyMmVG9frDDw+nzBAVkklji1W/Ucl
         tnJwi6hS2QAoiI4WELAHKVL0hzoLmd4QKvjnNLIiquynQb5Itleu9ncnUUd2bkFiP4n4
         E/r9kuPCAhYEgbe1vu88UWTfcMLqiFCpISx3FxJymrfrD1bjPn1XQZ3uS2B+vjEVu1ZU
         xPeqxncHPSt7Xpt/MBMG+p3juS5Q2yxJBImmufTD4Qep467/0GYGEvD3NMIMs56Bn1Ix
         rihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335604; x=1750940404;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xpuh9d9jSa1SnmPuObykoxa1W8u0W5/a2m7QmA4uxfc=;
        b=csKFg14PneVMzJjdR+fbuBi1RTK5I2SyqGJWM3kShemuc/9t2pt8hPQu9E014cXihj
         t7CWMG1Rf09USKIPfQNGP9KLAH4wNmenk9t7nVVKOFPZBpM+EsNxge1TNth2xYNMT1uM
         8OuwxfAvsUof08tSy8F5Y4DziduYrC1mGbIws1qAf9vTvSPlqXZ9lj9Wpf2K2ZPXZdZw
         UM/+sq+D9TBW+lnNAyXpEhge3gQ1NE+pRzthuin1qh48487GeyTciZBW+B0UbPbWsby8
         tN4bEQfYzKNqZJisVr+L0+qyqPyENMcGjG11RIg4gADjPUoVUhmJn0oRSBBsLQ4Gq9tZ
         tgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQYBVp+jwNtvbqhAfQUeBsVd9ZXvqmUNYVDgcxXuQboHTwFIiQvZw7aRTCGyIrLVgwAk/7dkR6kvdgoew=@vger.kernel.org, AJvYcCXJL+7RTK2rvfcJoTAtjeKajqCwI/tu2FmAkNMvZKxRnOnNQ8Sw0J8husvFRlxuDkAAFb5Kh5Na@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9NgFTZzfW4xTA95LyhBFghYuS5FdhPd9N+ITTgr0tCV90rwF
	zKwiv12OsiX0pnha6mtW6w/8vszpBKMiZN76AxcdHEwgRgJ+dekS7SUZmj3MDHok
X-Gm-Gg: ASbGncvNCMO50gHEhSaW/NFx5mdLf8MwjM5PfyuEAjYi2i68aN2Vg7puyqZhsGMZUBk
	oiO+r/wrj8ndNANAFGX5CURU6WVn7BGqiunPeEcTv6/r5GPCHytYHDcGK2Ytc5sRoaiFMOXLSvY
	G/zbv4eGTXTU9015cCPzFkZ/QPr6mDQwrmKuvDjvVBRKIPzw6+3mPQdGYFW6q9gLRIR3MOquY+G
	GLLA++uHuyMIzIG9tADkqqR3OYWlHL+RqsDm3qOSx/OpSVEz580zdc8EmXdP8aRHG2oowOhmKR9
	RkgtzvttrRIzML3+/4QzLVdrufnuA2hnZOAbSMsE1OHrO9nxWJMpm02G6PJ9Ym7S3kkdSJUt
X-Google-Smtp-Source: AGHT+IFaiatrhl5qZ/OrmLM3fFIrH6qG4uVdCj3J3SdJMfbXJLfvEWhGu6oFTTau9oRt+9XtwRRbhw==
X-Received: by 2002:a05:600c:1e1d:b0:453:b44:eb69 with SMTP id 5b1f17b1804b1-4533ca7518dmr222070495e9.13.1750335603668;
        Thu, 19 Jun 2025 05:20:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:ad83:585e:86eb:3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97a908sm27074965e9.4.2025.06.19.05.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:20:03 -0700 (PDT)
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
Subject: Re: [PATCH v7 07/17] docs: sphinx: add a parser for yaml files for
 Netlink specs
In-Reply-To: <79fd88d84e63351d1156a343d697d9bbca8159c5.1750315578.git.mchehab+huawei@kernel.org>
Date: Thu, 19 Jun 2025 13:08:31 +0100
Message-ID: <m2h60cexxc.fsf@gmail.com>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
	<79fd88d84e63351d1156a343d697d9bbca8159c5.1750315578.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Add a simple sphinx.Parser to handle yaml files and add the
> the code to handle Netlink specs. All other yaml files are
> ignored.
>
> The code was written in a way that parsing yaml for different
> subsystems and even for different parts of Netlink are easy.
>
> All it takes to have a different parser is to add an
> import line similar to:
>
> 	from netlink_yml_parser import YnlDocGenerator
>
> adding the corresponding parser somewhere at the extension:
>
> 	netlink_parser = YnlDocGenerator()
>
> And then add a logic inside parse() to handle different
> doc outputs, depending on the file location, similar to:
>
>         if "/netlink/specs/" in fname:
>             msg = self.netlink_parser.parse_yaml_file(fname)
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Looks like you didn't address my comments from v5:

    > > +class YamlParser(Parser):
    > > +    """Custom parser for YAML files.""" 
    >
    > Would be good to say that this is a common YAML parser that calls
    > different subsystems, e.g. how you described it in the commit message.

    Makes sense. Will fix at the next version.

    >
    > > +
    > > +    # Need at least two elements on this set 
    >
    > I think you can drop this comment. It's not that it must be two
    > elements, it's that supported needs to be a list and the python syntax
    > to force parsing as a list would be ('item', )

    Ah, ok.

    > > +    supported = ('yaml', 'yml')
    > > +
    > > +    netlink_parser = YnlDocGenerator()
    > > +
    > > +    def do_parse(self, inputstring, document, msg): 
    >
    > Maybe a better name for this is parse_rst?

    Ok.

    >
    > > +        """Parse YAML and generate a document tree.""" 
    >
    > Also update comment.

    Ok.


