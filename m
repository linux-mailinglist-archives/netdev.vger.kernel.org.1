Return-Path: <netdev+bounces-110884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DA592EBDC
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1619D283580
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB928FF;
	Thu, 11 Jul 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUQ3wVti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB316A93F
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712503; cv=none; b=b72KRWFMog4ArYJJt80OOazhnJ0nFLwBS5m6NE7ybEogH7P8wGJ3RZsqtBFXzEj4vY5/Pq5O91jiQH/i6JhRbgyo05pyOAr6GXrRTjolWHKKcgvcGhcPQqnGM4NwKotEVaE8NFkpKiD/V8V3rkr0z5AP7RBbs9ECukbDxwJpt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712503; c=relaxed/simple;
	bh=h74SYtaDurtWVMNe12MxjW2lrtvwlW5PQSKC1xWTX6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWu7CWNYsK0xsUDsew/WfmQ0zoo3AdWPMBJinswHrMezEyVUVEk/E792NijjP8OmhpqQ+ASES4lV2+9X7gl3sioj6TY64CZ1VqJrTJYD46iPbgyd6B5j8dQ/2YWq/5F0pkxCCs8tgfg87UWIuDHRdfws9rLQXtOWxFZtZcEsmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUQ3wVti; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42666b89057so87995e9.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720712500; x=1721317300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h74SYtaDurtWVMNe12MxjW2lrtvwlW5PQSKC1xWTX6k=;
        b=VUQ3wVtiYP0mYPVz9HNMXMf7W9Arq4HyHkS1ubZ8YlFQegOhkRSOmB8m8hDE15AP/V
         4PblXdOcr/3c8txVSDjf6DA1KWe0dm7xxI/UrlUQ7d8lHBAGfaIuXthhdD8gkCIp5F4E
         1X162925nuasdpWSkrhKNSNQI+VGbC28z5UPR598RwC/v5VMwk1GmXX5A+pMBOYF5z7M
         Hqs6YkfyEmhSul57jBY2ahdKVhD/r2be7VCEj7Iz1nwBVpYkByAADW7kbzDrYUTge8Rf
         OX3mxVG+F3NhaX3SXS70CnspbtcFhF+IJHqlsSkf+R8cGcM3Bbji9gQZQ65EPIuMQ57w
         w3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720712500; x=1721317300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h74SYtaDurtWVMNe12MxjW2lrtvwlW5PQSKC1xWTX6k=;
        b=hJjMkRSVLiQ6nUxTP5oCfdtEk3slSqPgt5M2L2C+50fz6rMPTLiDKZAgqljOzSCrFf
         HVuducCvgC7UuFKdxKDOY3OjLrqRUDGp38o3lERhicmKzLCGm7SjzYu+Hjhm/maB7zaz
         XCDKfedyIgY1LScSj8QREYEI7aXpOxiCIyJYeH+/332XmJZJvqRbyA8JVBZmfwB9iF6j
         b1JfBfPjMJe5EV2hfcXyD5pw0gFZHygdk458eabYfOP33YNiDJFHZ76zx3mx3qY1vdFZ
         VzfeJFf6dr+w6dwCyrZa+n0rRNANxEabtKpMwS8haKq9dDekzVATpij+q8UKulpb4imw
         Sz6w==
X-Forwarded-Encrypted: i=1; AJvYcCXLsSgUYwhlMOtYKio0pSIShC0/EouDlO3FwWczLcXIsNM4rTNHSP4FDv2819aQOboceZ4OfIZLA7zQMJt0iuMI1UpnJd1e
X-Gm-Message-State: AOJu0Yz7Eqxr0p9amLvKFHfut0kZmeBBZNfpGbWzS18laUNtvns01Jhx
	Dga1x6w0MyKWnawNOdaWQV9MMxZe9j4qpN6n4CrgMhUkWqEwFVXOnUS7ShSCOxM7uH/ckkC+BCB
	+DRD+YAd78bfB10SkhfEIecVH1jvgCepCqeFu
X-Google-Smtp-Source: AGHT+IHqsH8u6qwFJLBhhqu6nDqLgqH34jJy4y2QgSKBLi1LsZ+No2szVtZGkUHRDFSFjzp+JHcGZ7kloKTfhDAvrLU=
X-Received: by 2002:a05:600c:4f08:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-4279976a51bmr1709895e9.1.1720712498599; Thu, 11 Jul 2024
 08:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709125433.4026177-1-leitao@debian.org> <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
 <Zo5uRR8tOswuMhq0@gmail.com> <CANn89iLssOFT2JDfjk9LYh8SVzWZv8tRGS_6ziTLcUTqvqTwYQ@mail.gmail.com>
 <279c95ad-a716-415b-a050-b323e21bec31@intel.com>
In-Reply-To: <279c95ad-a716-415b-a050-b323e21bec31@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jul 2024 08:41:27 -0700
Message-ID: <CANn89iLfpHam2pcha0R3Y8OBZiwsevDEM-kbhzB2Vv5UYgC7xw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device _properly_
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, keescook@chromium.org, horms@kernel.org, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:54=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 10 Jul 2024 10:04:39 -0700
>
> > This is because of the =E2=80=98const=E2=80=99 qualifier of the paramet=
er.
> >
> > This could be solved with _Generic() later, if we want to keep the
> > const qualifier.
>
> I tried _Generic() when I was working on this patch and it seems like
> lots of drivers need to be fixed first. They pass a const &net_device,
> but assign the result to a non-const variable and modify fields there.
> That's why I bet up on this and just casted to (void *) for now.

Right, I will clean things up in the next cycle.

