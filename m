Return-Path: <netdev+bounces-199443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CCCAE056F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8EA3BCD95
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6723B629;
	Thu, 19 Jun 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leQTnC7G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03121FF33;
	Thu, 19 Jun 2025 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335600; cv=none; b=Tu4dg0lXznfYz2iYR6VbfFZRCrK9HbnT5iyzhbtbJozJWqwteKqy/1fdyYSh5hRQcQJ1TgZwdnk/B4b0YXwPZT9TZyrJS3KNmvay4WZQiPH6mw7PAwZZ7w2BJZP6KCnMiWsUxxAy9w0WbriZYrNR0zWEq65hh9iqtt2fO/djR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335600; c=relaxed/simple;
	bh=XquW5ZV6oc/hCki+AgbKZYygFXjNvaYEnNIQqvtyoYk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=I1nRXQCHzvUur4OUdVX/5cYhdhf/giMYJHyJsSusAvrQyhcXA3FdieUDA0ShCpahra4sUrhM47Q5/NHChBly01knbpVjkv7t1xabhq2Y1ppm3PXak+1dLPHsKQNbuZtY0Q8URa/HiNdu4kgHwfTfnk2bukyu0JRu4Up7RIEmX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leQTnC7G; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54700a463so424749f8f.1;
        Thu, 19 Jun 2025 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335597; x=1750940397; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQfUHBUgL4FYDXO1aQtp+eVF7jpagDZr1s2Tf1cBE7o=;
        b=leQTnC7Gk6AuvxIxHedMbuGZB4dlQjMmsJ5+KvFFZ0nluhEJxxCtQck26vI+XY3lt4
         rHUdZj/EG66Z/xyJnnAoFn+D3WyKKKhlN33Rqy7N+5eHQNdFpBg7WnMe1MHw/XQIIQRr
         REeJLnUzfwnQtXfMaR2WNAoK0mgiMqo6zHKtTFrzPrZRpxKfZn8tpmRE7Rl7s0Hsr8iR
         v731wJ/qLTHZ6wexqh+ry2Gnf6msdm6dAvnn8Ag128T6V9v1mwk4SIlZNHiBAtwynGWc
         E7wGX+y4LbvrhdnlqyHRtM63+3jPyDsN7kvRfiprHdI/PmdyvAS5hW/Po5j0pVYibOuV
         fruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335597; x=1750940397;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQfUHBUgL4FYDXO1aQtp+eVF7jpagDZr1s2Tf1cBE7o=;
        b=o2p8Ni9OeLdLr0WlfrTSnwBbzsbyMeErR/PRfRiPwtQIN1sBwy9+Z9IBIHBUi0+/Mf
         1//CCE2cmy9y6ErTLuWo3XbQQomO9vtMhMfXf08ZoYVrViBn5DbChEvoQDQKqhJReL4S
         Xcr4iuqGEYTHtCXu9PRoXKThEfHVAYFkV2K6nL0kKdGJvmPZiTIEFsY21RgudTtpitNT
         0fTkZT1rotLkWClKPQx8Pr49w/0MhmKzqk7K3rkbXKQ6Np2234rXbiawKb1CsrkQQkhh
         csfm7gR4gwz01MU0CVe/qPKwum5+T7WsqLV/UEIdlVYZSSTAn2wmJbJ3N64wnVIyDu8F
         IKNw==
X-Forwarded-Encrypted: i=1; AJvYcCWnbxRAuaUy+4gDNAajN65r+2G/425f8kA9obsmNWR0Ovv47SiY9YCNkQF22wMdKwjKicSCUF+hltQZgcY=@vger.kernel.org, AJvYcCX7i/mtecdhSiB5XaNsHNwJcgJ1G8hsgky+LpdTKGqYegZKNvadEnnIXQbaPKwDDe81hB9dvyRu@vger.kernel.org
X-Gm-Message-State: AOJu0YyWRUDiEvKk1ZifL/rD1Q6graGWuefJti7/otxx8upEDVtgFK/J
	RD3siwZnlECUh246qn9mHuSWIptcbMlDJXPQO400HXhvaiDzpLU9uke7
X-Gm-Gg: ASbGncur7cGM912Lg/hi7CKjLGAG7c7rbHPLa23AIuW5betu0zt8feCtWpj25RdHTur
	9opWcwzFGTaunv4PtEVnlB/18CTNAcWrk3bu53HIxxZH1IzWvcC5Prr3magP43wgOGWjR2+xAJ7
	NKPa8JwlOwxXD0OO0POBjFnAG0HHxF8EvGTMIhZZL1oy/RodT8BGvrCHFUqF+68yv1xQUQt91NH
	+7VXGyi0s5f6wWe3QzzWnl4KZx7sSfykKqFmOzSJkgei/OgCJOwSOuCoJZe8oL0WhDFWIc82uem
	OlQqKqDJOaQfdgOfHpVVCukjJ6xq76izMe1EAGENIIZiZv+WKcr8MtUtlpNHpZcYGAiiEi1J
X-Google-Smtp-Source: AGHT+IFMDYQMfyO8NuzqQxoOHc8RZSPZIdd81fqB1a+VABhpS0urt+/BDcKR/TSjd1tmz0JMUrX5ag==
X-Received: by 2002:a05:6000:22c1:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3a6c96bde70mr3293996f8f.14.1750335597039;
        Thu, 19 Jun 2025 05:19:57 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:ad83:585e:86eb:3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b5c372sm18955330f8f.89.2025.06.19.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:19:56 -0700 (PDT)
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
  stern@rowland.harvard.edu,  Breno Leitao <leitao@debian.org>,  Randy
 Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Don't generate netlink .rst files inside
 $(srctree)
In-Reply-To: <cover.1750315578.git.mchehab+huawei@kernel.org>
Date: Thu, 19 Jun 2025 09:29:19 +0100
Message-ID: <m2y0tof82o.fsf@gmail.com>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>
> v7:

ETOOFAST

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

I didn't complete reviewing v6 yet :(

> - Added a patch to cleanup conf.py and address coding style issues;
> - Added a docutils version check logic to detect known issues when
>   building the docs with too old or too new docutils version.  The
>   actuall min/max vesion depends on Sphinx version.

It seems to me that patches 15-17 belong in a different series.

