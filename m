Return-Path: <netdev+bounces-127966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB49773CA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3912836C4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33BA1ACDE8;
	Thu, 12 Sep 2024 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6XLh57h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F81A5F
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177773; cv=none; b=Li1A6rwkkq6sLxuiqk0tMe25KrSB8DSBZuflAnpyjMR5zIWsCgmjwHDIAveCxHpJ33lPYW/GdVcd+Ct900TuLIy2wE2R7zjGTb1lnXOYthnY9bF0pJhODTQelIsLo00orlIDDcPlgJ2jKYEhvomMe3BNb0iwmuhG73MAgKftbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177773; c=relaxed/simple;
	bh=okHn4jO2CopvmI3B3YN/dcfyRYalvqUjcRs7l+mEffk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijv4V4H7kpMOhta+FBdUHepW8nuUkm8s4m2sgDql1gsN9kH2f3Eu7hmYNALT3EsOM2MVec9AWuTrh+F5a3Dq1UH9kud2JFZ6T/JZW267Iwgp0SMZWAXji2KpQyS0xrDHiGw5UIEkGq2TQ8SFrHvjEHrxjRL5z5upDClVJ+JgS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6XLh57h; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206bd1c6ccdso2339085ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726177771; x=1726782571; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3/+Zn9RYfbejd/vHg+oD6L2xyTe6Qu7GQBKxalBy+ls=;
        b=Y6XLh57hh1qGV+OcA+lXNZoaa31qzdEskbpxBMLo9SJPBQJPeZV4B6Tc7B3y7Hr2C5
         ELXjJyWDbz8MOplVQGsJ7hHyln9zh5j0N6FBAVwt2ftVIGMd4bkbszH8c4Uckw2kWeSY
         HObvSne3eh1U4GyLGiAkRMRJl8mDyC/fbJO6GouZyclGhYbp8i3Yg+PvYn0b7H/NgBLw
         BR+rkNt6b/mykPjvoOP5o7Rn5HPdZ5kM6kMWCaVbGAvmDZERQTq7h0I453rF5B/UNtU4
         Wl9y+poCpAR57o0cuW9SwIPWL7TWhcDWBeHaXx4KHVM/vPUmRucH08DwfflpqkgDOgwU
         kXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177771; x=1726782571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/+Zn9RYfbejd/vHg+oD6L2xyTe6Qu7GQBKxalBy+ls=;
        b=Rc8VxqBhQ9A6iDj0lxXcbrOaxuIm0rNtQFwZPRv/0oYtjf9nxrDe43uerIxs8vRj8g
         dGxVe1I3s9pVWJflcuuBh2W9WIZoPmO8d+lUypuxG/Td/O2+5qmd/CZbtEPW22WvglVt
         Ktl8p/0Xm22doUYltaYaxkejmEfOUyB8x1YOp+NVByichMZWuTr7x5qKbNzsn3SoiSgb
         4HmnSRJ+Ns/XwKnFjcI9RvdARg7VSHpHsAemDdCe7tNnnECD0BBnHeYiudTc3hGagJbX
         Lr6k3wd9ZCK/noIjPjoDAMUlJyn0VgVON4x7noV2gj2dMy4Ze6ZbFxC954/VNop07U9R
         wEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUixN7ie13TkMEMsNqOFnFsbfNas1TuLpHbJLr7zYDjSKHySas7BOHp+RkWv3pgDBgOxcE4MSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9aHiJC5+rDMCQLFr7VgWevgjpOLLKHdQfcii78W1bQZHhAK/x
	/ROBCSV1q3ty0aQxe+QlzQjTZWunEFLOhexpXKYmFN+UK+5NEZM=
X-Google-Smtp-Source: AGHT+IFMmw5DnQT/CefJSBASW8MEMsW95FahM6B1ZzfNA3KqTIyJLfcH5HsXYDF4T3OQLd5J+94BZw==
X-Received: by 2002:a17:902:e852:b0:203:a14d:ed0 with SMTP id d9443c01a7336-20781b42d61mr8816205ad.11.1726177770829;
        Thu, 12 Sep 2024 14:49:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b009742sm18237795ad.263.2024.09.12.14.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:49:30 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:49:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 05/13] selftests: ncdevmem: Unify error handling
Message-ID: <ZuNh6alWd1U1ZQLY@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <20240912171251.937743-6-sdf@fomichev.me>
 <CAHS8izP7MENG+q3y00LbAhzkP9yuLkC6NV3Bs77aQ5nw6YK4AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP7MENG+q3y00LbAhzkP9yuLkC6NV3Bs77aQ5nw6YK4AA@mail.gmail.com>

On 09/12, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 10:13 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > There is a bunch of places where error() calls look out of place.
> > Use the same error(1, errno, ...) pattern everywhere.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index a20f40adfde8..c0da2b2e077f 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -332,32 +332,32 @@ int do_server(struct memory_buffer *mem)
> >
> >         ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
> >         if (socket < 0)
> > -               error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> > +               error(1, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> >
> >         socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
> >         if (socket < 0)
> > -               error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> > +               error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> >
> 
> To be honest this was a bit intentional. For example here, I want to
> see what errno socket() failed with; it's a clue to why it failed.
> 
> I guess you're not actually removing that, right? You're making the
> return code of ncdevmem 1, but it will still print the errno of the
> subfailure? That sounds fine.
> 
> Isn't it a bit more standard for the sub errno to be the return of the
> parent process. But not opposed. If you think this is better we can go
> for it.

Yes, this will still print the correct errno.

