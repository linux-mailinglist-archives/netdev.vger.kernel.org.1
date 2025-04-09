Return-Path: <netdev+bounces-180754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D83A82554
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647718C0F76
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB34264618;
	Wed,  9 Apr 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/hutj7J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AA26463A
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203083; cv=none; b=WZAxjMq9L6BmNZhZ7hhTJd208eQBq03ab8ZAFOH/nBCgSaR8mZEfRYnSMRMqZnQlJ7ugze75lbg7GWJtwjXfxzceidcMMptLAmB2nM0wOUCt1xeX7alw+VvPltdz08w0+TgG9aao5VN696q6zXD+x3y7bEGIiezEFdfQXFyp6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203083; c=relaxed/simple;
	bh=il8nxCFoUUWxgYdSB3y7DH39tKjYz+ZfWcK97OTnymE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=DzqgdE2vi2889uX6KLZAiC2JQOHJusYUySglLnLH8szwdtVrRooddPYIhFxmoyRxgaiZtA7jIc9T1fngDszAXgTXBi/lLuX+5M0IJr/V41su+ZCuCxlbzgfOmSIf3IfHdQzzHeZy6sMgPreYxGvcLffap/VH9jO8QheUmS79MIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/hutj7J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso4678285e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203078; x=1744807878; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw7ZmEwBb6sWnJEJ69LrWnhaknRWOluDAJ8rp+2etQg=;
        b=a/hutj7J8pmhyL1jzwba8eR6dEzTRrXj9Q31DW3k73B1qmozPmdhmgA38p//ukj7kN
         hU+eOB8iDgIj72OaghIGV8EaA1RYAlyMt0IPg1tQq+4Z6iLFsiGfKJ9Q8TZeEGSo+Fw4
         P5wBMI1krV+3Xk1C/1aBaim3XicQYFUVILy4URCe3FxeHrOd/7ueiUZ/DVbt0C4Ul93U
         9tBg1xYdGmeB0ut/23H7qVYVDSjzLA7Ib3MtYnainnAzFGuPyMr2zCcvP53y8bYwU8OY
         QQgMj0VBrTtIgsmBzDa7w7AkP/833fl2k7lhjM/apj9qn87wPD1Q0uLjoKMaQh29uQXb
         Z2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203078; x=1744807878;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw7ZmEwBb6sWnJEJ69LrWnhaknRWOluDAJ8rp+2etQg=;
        b=YRnyh+crSkUhE6/6Q12vb/2zp952jMVyI6L1DT8o0xbE/0Y46gkhCO4N4cD+L5lPuH
         KT7O8aq7/VczXQO0n6pdnrpNK4NKjOFewuAx2fR6qgcOemd4bsglg4mxkcbiT526dxl5
         rRXfRrIO/E8Lra7DPxQznBcQZnlfWewHDXKsgQpJt7PxwVLuWeh48FQlcq+qw1xgdm6N
         JaYqxtxYBbakT2yus9V1ZjFM26H0+uMBC45lbHDNVfG/abIKsfDiUKnwc9OlocCjRmfu
         9mQjmb3HgKdAssarcs5ay0vWAw836CHtcWqddrh81b/N3pOSZyf8hVcLieyYcZ9qakz4
         rJfg==
X-Forwarded-Encrypted: i=1; AJvYcCUpkolbrvBWdXI1aVA4aHBkhNg1oVi3z1x/cVaGKcdDjyVxXVNfGNI80L3CpBLkNBMgJXMvKUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylP/SWlXvXbXL8zIH9Xbkc2DB661WSgF7804B01twDNWQqeQSn
	8yh6TX9TOqn9jZzzigU5w2SLRJyiCbNJTECqBiduiaG+BGrYtvyT
X-Gm-Gg: ASbGncumf4HopWOq18QGEx2NE7m1ZauVBelNqZ+hPLv2mV9B5T6j9raUtqfYfGF4VHr
	MSueb9YhlenPzr61TDUiWw2ezvIUMLDI45tTrbgHfwabica0pTBacyPchFGf8Zxbh1gck6ZtZg6
	wnCuDGuO7iU1hm34EDs2wXWMsJKAE//ZMA+s2Tmew3MdLlKK87Qsp9NlUC0ggWAeJ7yKNUOJBe2
	r0A9pFSJSANLin15xfo79e5AcQyK8tnfhbJj36Bofzk7yRTc24ZxOwLLZ8PsaWBOdJcyJqtttmQ
	qDw5MkrwApolz+4ED5+X1weaZ9NIe2ruRwG10tQ3s9nnVhLy6/IWLA==
X-Google-Smtp-Source: AGHT+IESQNoVbNtfKGdINn9Mdeq0OY2E2N7aVSEmXqei4AMk4YRu1Wb/cFd9laUBR/VYUBi8VD/71g==
X-Received: by 2002:a05:600c:3592:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-43f0e5600b1mr75852905e9.6.1744203078161;
        Wed, 09 Apr 2025 05:51:18 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d0fcsm19008645e9.19.2025.04.09.05.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:17 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 10/13] tools: ynl-gen: consider dump ops
 without a do "type-consistent"
In-Reply-To: <20250409000400.492371-11-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:57 -0700")
Date: Wed, 09 Apr 2025 13:38:01 +0100
Message-ID: <m27c3t33yu.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-11-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> If the type for the response to do and dump are the same we don't
> generate it twice. This is called "type_consistent" in the generator.
> Consider operations which only have dump to also be consistent.
> This removes unnecessary "_dump" from the names. There's a number
> of GET ops in classic Netlink which only have dump handlers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index b0b47a493a86..c97cda43a604 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -1212,6 +1212,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>  
>          # 'do' and 'dump' response parsing is identical
>          self.type_consistent = True
> +        self.type_onside = False

I'm not understanding what type_onside is meant to mean.

