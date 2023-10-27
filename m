Return-Path: <netdev+bounces-44797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C867D9E26
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3948EB212A8
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682E2381C0;
	Fri, 27 Oct 2023 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFBAnA7V"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB437C8F;
	Fri, 27 Oct 2023 16:41:22 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F1211B;
	Fri, 27 Oct 2023 09:41:21 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a92782615dso18539727b3.2;
        Fri, 27 Oct 2023 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698424880; x=1699029680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxnZ+T+5SN/YE922vwomBOjqG7yt4+TEa8wiZdumpMY=;
        b=hFBAnA7V0VmF96qHH5J5gFyk9JB51W9sqgm86xEh5QFRR81N+gnsyptGXXJGZBqlmC
         +eow1jLem2BpIU84m4Dz0zOEJPjTYpdZU/PF00pt+XmOkgvJcHQE8Cbni3CAwXMtq03k
         phqc81TiimSS0J2GLYzjiYP/beciL89pSORn1yDvBz99GtJvDOEbRAHwIi25EBRWyCUg
         UGD+wMTrR1fPL2KOWLnGatzv//WQDik4lcIbNWrEz/upX72lYXpthLD6XWhKQSovwTYX
         l7bqkUq7b7obZcZ3bBbOzC7L98DhrtUiTp4W9LawgFPMSt3YUSkKIwEhmLqliYpdWuO7
         2uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698424880; x=1699029680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxnZ+T+5SN/YE922vwomBOjqG7yt4+TEa8wiZdumpMY=;
        b=CD1cGOyOh1VHu8MJ7fuveLMqiWIL18met0MvYd++rydjY3FuHK1ShQkA1FZ8jW6HaG
         kl7mmmtJDj5YwVpnqocLpD3iGSJmed7kN7YGHo+K+1HV4Aw2brCLx+FLU2GI+/8dAfc9
         c4twtvHR06DvY2UtZ2pn2TOtt6mlVrVhfvwHh4JqQhMIoGOBs0JieU1Wrt9Eg3NZiDef
         gkCY+IYR7FjAccTB38DuPJ0o2mWWkwDzczxuRK57y+edWEf7+3zrvPP7L9X6mroGgwWw
         w5IUR9wkp8xQtG5qwfgYt2CjVxls5qI1U4CHmk3H78bDQgpHJ/5KyRDCWM8tzuzOwV+y
         Ynxg==
X-Gm-Message-State: AOJu0YxH6S9/ZRvGH0XPHRvc9W2wMlgCQuwdTEL3AOX763oXeQXRgW4P
	Bfd7XafOWVxd8j0++dodEZ/YWjSn5a/XGL+wf54=
X-Google-Smtp-Source: AGHT+IGVdOAUt+gwepDHZmKyq/7a+7nBkhQS9SXsUuYYNyQS7u5mVdzRaxK67y1r15bK8dFhYL7xsrV/USM8DOnXHMc=
X-Received: by 2002:a05:690c:a:b0:59e:9a44:9db9 with SMTP id
 bc10-20020a05690c000a00b0059e9a449db9mr3677990ywb.26.1698424880661; Fri, 27
 Oct 2023 09:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch> <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>
 <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch> <ZTsqROr8s18aWwSY@boqun-archlinux>
 <ZTs73ZBgGZ-oHwF4@boqun-archlinux> <a378ced1-71f1-46f7-bbba-b5aacb9a66a6@lunn.ch>
In-Reply-To: <a378ced1-71f1-46f7-bbba-b5aacb9a66a6@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Oct 2023 18:41:09 +0200
Message-ID: <CANiq72k_=VRWDdZmai0BeN9PvoSXTrqv5CC9MgnCFV+rMMzLhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	benno.lossin@proton.me, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 4:26=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Without seeing the user, you cannot say if the API makes sense.

(snip)

We are aware of all that, thank you.

But I am not sure what you are trying to point out. If I understand
correctly, Boqun was just suggesting an idea to split the pace, not
disputing the value of the rule or asking why it is in place.

> But this API unstableness plays both ways. You don't need a perfect
> API before it is merged. You just need it good enough. You can keep
> working on it once its merged.

Indeed, but there is no rush to put things in either. And for us,
"good enough" so far (i.e. for the very first abstractions), means
"everyone is in on the same page, no known soundness issues,
well-designed API that can serve as an example, enough time to review,
etc.".

In other words, we are trying to build consensus, not just put code
into the kernel.

> If you missed something which makes is
> unsound, not a problem, its just a bug, fix it an move on, like any
> other bug.

Sure, as long as you consider them stable-worthy issues and are happy
taking patches that may need to substantially change an API to fix the
unsoundness in some cases, that is fine.

Cheers,
Miguel

