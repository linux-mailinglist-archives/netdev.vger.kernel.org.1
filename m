Return-Path: <netdev+bounces-197465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E462DAD8B61
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06688162C2F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295DF2E2EED;
	Fri, 13 Jun 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMrA+9bE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D92E0B5B;
	Fri, 13 Jun 2025 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815737; cv=none; b=awc8o4apGSrHZwgLvbFAKJ4bE6PPg/TLUOnT33FSi0B9EugACj8f53Pe5ZAY0NYNAfvEa65tQGBOQexrwObUHdT8X4m3kF6epWBhrnQ+/2maRKUoHLY33XQ366cHDk65ySrkSRcPrHk1pC+FUhdZFuq6UwIE6QrVM6qysmHrN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815737; c=relaxed/simple;
	bh=Ci7710RjJSELOL+1/2aPBQoHM+FZu2LTyHSsddj27FE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ke77fxshc2L49XDm3dqgeVG6iXkU8DxJLipM+NFDAnuMblHHgfgXDqC521VSl4Fop9gBjUZfBrXMKy6xHD+nmJFZ4CR1CfGjwjh/a9arH+1FsZKRn+sLcHDF28mM3NJUCVv7dHbBjCKsBHjol4Eh808UbMqt7j9ptZ9q7PTL4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMrA+9bE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d3f72391so26536115e9.3;
        Fri, 13 Jun 2025 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749815734; x=1750420534; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uL5y/ewTTMQ7/ta7feOWe7CZOUk7g4FBbNi0PxftJG0=;
        b=GMrA+9bEWblntAdDLO/iRvlH4v0xDnbd0mfNh5/zC1NZKkWBQmjO0/QeHFnWiUsxm7
         hpyIqLXFT28+ZjhxEdP9sPI9Cbq/DuUSazSlzYO1xm5Sz0V6qy2+6omT6h+aPaC7Pu0+
         6gJW92Ny4bPhVJ18r+kBViYzGjJZyA/TikHv6n0kyFVF1Gps9eB/J3y2nSuFOIQ5UHL2
         7cLfU26vpSEyzNVojFg6oHS2yXe1ZnO+dyajo5asC6EhofIgQXXIis2o2g/Gm91IaW+h
         G3T/b3XfCLsbYJKzCTwux1xsoSm0wsPexTGZ3lP7xiIuJQG6mRZK7C8ejlx7pF3G/hJS
         0Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749815734; x=1750420534;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL5y/ewTTMQ7/ta7feOWe7CZOUk7g4FBbNi0PxftJG0=;
        b=H5GOFwK6nk0yx7GYNCElA+riSxSLveFjQlbfwoeiS9vMDOxzQ+vuDnY6m1B4tiwV4o
         yTL/kyqBlESeaE4IV64CWo1szVmvQPfT2mYbHoRdIuIdYGqzZpSBuK1oUYCEkU3ZLxIO
         pK+3RB32UjHbkByUfq5huwQEIoLZtKdn6kshr05I7/mLb3kRhEmQGqYTNiTTc8cU1E9Q
         zoP9XqisOJoxMnnNDDJ3hNf/Ofx3NkH7Mm9n3ReTkTEl0csuO0PkTMkmkOyfhRepTl6a
         7BYnlaqfeOHQ2oGQiYGEi0fELFO2J81JHG5D137U8X6oa1rinbDwpfQ62YY0nrY2VTDw
         pSiw==
X-Forwarded-Encrypted: i=1; AJvYcCVawf1p4AqFP52U1gZVaWLxxZU05SpAXzL3NVYNrkujIMuESbkgDHjjyQJ4NaAHCvwfzM4Bw2oUMlIBsdQ=@vger.kernel.org, AJvYcCXD4mWqPuagF3vl1Edy2cbxAzoT3AVqEi+qXA0oAywvSQKBUe4ZxIxNDjwVJx7qf0rOyU4P4kmD@vger.kernel.org
X-Gm-Message-State: AOJu0YxhE/W30Fch57bYJuHV0winEstw4AJb3Jzc4VB3LvygKQPhS0MO
	6gridwCe9lxIW5eGE0Mj3OAkOnx2SXbKiQ4AHMNbBL/AMcdiJDJcJvDp
X-Gm-Gg: ASbGnctDKXlGAGZBbwkgmVqJUTlBge6rq4D9H67cZk6DCSAfQGEEXoKy1ggB8MSFsq0
	CFPgAu5kkkhItzKhenxbo/6wO4moQyAtdmfCK8rWWLvbj4LosFnaO5asjz6TMslrrbakvKmj1FZ
	LXwhHtAHfhcO+A4wiejzMxHLkJh7x0rXYaDNJ1nAeRsPQSRqWvAwQXDwNheT6Hvsfsc81fL10gY
	oas1dJ9T2lrxM0UHaL6DrsNz6tsTc2ytfL4vYzXsWFUaZEwfnzNQlfEZ01/31Z90nJyCnur3fcx
	nimeUOjMAfREy2B2bUNcjyYd1AFbou5/8yJNIOydvLu9R8T/vKS5ZwY8vHghMOvs/qz2d+x0CF8
	=
X-Google-Smtp-Source: AGHT+IGMtOD0UDTm67fkmitVK21heePsVMtSrnMkraeiIzLg5EK6P4byBT359avt25zMBKAJPT5CUA==
X-Received: by 2002:a05:600c:34c7:b0:442:f8e7:25ef with SMTP id 5b1f17b1804b1-45334ad3f41mr27165075e9.11.1749815733431;
        Fri, 13 Jun 2025 04:55:33 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e261ebdsm52187085e9.39.2025.06.13.04.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:55:32 -0700 (PDT)
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
Subject: Re: [PATCH v2 06/12] scripts: lib: netlink_yml_parser.py: use classes
In-Reply-To: <08ac4b3457b99037c7ec91d7a2589d4c820fd63a.1749723671.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 12:20:33 +0100
Message-ID: <m2y0tvnb0e.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<08ac4b3457b99037c7ec91d7a2589d4c820fd63a.1749723671.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As we'll be importing netlink parser into a Sphinx extension,
> move all functions and global variables inside two classes:
>
> - RstFormatters, containing ReST formatter logic, which are
>   YAML independent;
> - NetlinkYamlParser: contains the actual parser classes. That's
>   the only class that needs to be imported by the script or by
>   a Sphinx extension.

I suggest a third class for the doc generator that is separate from the
yaml parsing. The yaml parsing should really be refactored to reuse
tools/net/ynl/pyynl/lib/nlspec.py at some point.

> With that, we won't pollute Sphinx namespace, avoiding any
> potential clashes.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

