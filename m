Return-Path: <netdev+bounces-76840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C983E86F1D4
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 19:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9F61C212A7
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA32C69A;
	Sat,  2 Mar 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bOKH6mt5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3251E50B
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709403561; cv=none; b=mXDxZygOrDEF5KpCzpqGF71pOx0Ar13oCp+LeSU95seya9upaVoNUYmDkLnxlegbTzsHLJxqsHIE0HkDs1WLAwssdpjYT4VOjFuB8s/YGZWesZAFtYA3F3sIhKTHnP+SDKOCt8T6m+lvxI2g38EfpNZCw3V0kf8OqOqjYKYljUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709403561; c=relaxed/simple;
	bh=UaTnZY8Awdcgt8ZW0ePFAWj+b5DkUlXvw9yVNGy7EKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWPvxbrxPicayFh7NHIE7uSOSJIwdBvcTw1FdYTOXaB54mAlttNxsI4waqDkq6yyeCrYUVkhizngU/ZEPRwD8rfmDbvXPd4jDLAxXx5evax71gJIXxIPez4NyNxykaucqcrMy+Q7becJUTT5SWoAjHtSePEA3xKAFe5IGM7bIYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bOKH6mt5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44ad785a44so186488366b.3
        for <netdev@vger.kernel.org>; Sat, 02 Mar 2024 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709403557; x=1710008357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mpxtfMFdGHdZ3KBLFHI8lmN/KThAgx7c0/ntlIOIqzY=;
        b=bOKH6mt5OJ0HrU/IfPOSr6BsK/eXndMwuMXrCAHR1lB/y0uhKKNuEdYyj8FCiAlhdJ
         MO5uWcMwlA58RU4WbvJGMEcJ7cXVPxxEffjfsJFT0oOTz23Hivu129UyXXAZSYK1YQoQ
         VRYlEfO9QWrIhezfN2ZdDSwSZpcBegh+nfdyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709403557; x=1710008357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpxtfMFdGHdZ3KBLFHI8lmN/KThAgx7c0/ntlIOIqzY=;
        b=cvfEURFl047QEYnL8fwxca5rYDYTbVnUPQADpq6GEGb4QxSMJ9veRhhv4GyS4O0CQx
         yggKlie1Xxh/30PFj+qv8oWAqTz3egrh9TAoBBuHvtKDnbi46vMRUUWLomhV+YsaitUB
         fyhQeIpNzsXQHZTCJB1prS3Axsm4YdcPJv9MibSfxeuKBeKj9G/Ir307viqZWrYQHSgr
         b6vCmVoOU4sIHTNQ6USh+CUoz/l3k6zUUv0zclbluGbLYDEfCvUplahc0OTK4RFSb2uG
         SCmtmny3WdlVeyT9M7Wb9GCbpCYEFLRN3uO8m0cKTxxRn5fnFGTFfWN96O+UVWahgyJ2
         7D3A==
X-Forwarded-Encrypted: i=1; AJvYcCVyreUElQmrD4tsEARWgLZCUcz/eq/ypM3RP9ho3JDgTM/u1FSXQwLMrP2R2PF6bipCe8LetURXZOmZN+oq56iafkrxW8KV
X-Gm-Message-State: AOJu0Yx6XebRsnkGprB2AjBzUy/DyIY+rzPg+0PkQrudNYu9XJDhzkgC
	wrqcs83NlXkG1IDlQMmWBl6X/ZUuDR7Pi239R5fGD8ohRx7ztxZ5JOR31old8gCdjaWxQxI9xbp
	IiloJIA==
X-Google-Smtp-Source: AGHT+IEW5BtBYnecOKCxNTn2OloY0BAN1ogQlJumAOldsLynGMeUed3/K3H78b7S6zWI1r4bYQAYCA==
X-Received: by 2002:a17:906:6bd0:b0:a44:e87b:c399 with SMTP id t16-20020a1709066bd000b00a44e87bc399mr1053606ejs.76.1709403557368;
        Sat, 02 Mar 2024 10:19:17 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id vu4-20020a170907a64400b00a4403563a9dsm2920206ejc.192.2024.03.02.10.19.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 10:19:17 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so497716366b.2
        for <netdev@vger.kernel.org>; Sat, 02 Mar 2024 10:19:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU02sN3ejOilkUy5bgcLAc1rG91Dq3rqWRvd4gUI8zruP0thLwWKFDtpxghG8DI2MPgfGgrRtOjyJ+PDZKeEuoUT2PKAGW1
X-Received: by 2002:a17:906:f190:b0:a44:2134:cba9 with SMTP id
 gs16-20020a170906f19000b00a442134cba9mr3296518ejb.69.1709403123040; Sat, 02
 Mar 2024 10:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
 <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com> <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
In-Reply-To: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 10:11:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvkP3P9+mAmkQTteRgeHOjxku4XEvZTSq6tAVPJSrOHg@mail.gmail.com>
Message-ID: <CAHk-=wjvkP3P9+mAmkQTteRgeHOjxku4XEvZTSq6tAVPJSrOHg@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Al Viro <viro@kernel.org>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 10:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In other words, it's the usual "Enterprise Hardware" situation. Looks
> fancy on paper, costs an arm and a leg, and the reality is just sad,
> sad, sad.

Don't get me wrong. I'm sure large companies are more than willing to
sell other large companies very expensive support contracts and have
engineers that they fly out to deal with the problems all these
enterprise solutions have.

The problem *will* get fixed somehow, it's just going to cost you. A lot.

Because THAT is what Enterprise Hardware is all about.

                  Linus

