Return-Path: <netdev+bounces-52560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FDE7FF348
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749941C20D35
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAB51C3B;
	Thu, 30 Nov 2023 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIt114rq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62B1B3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:16:00 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b3f55e1bbbso588500b6e.2
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701357359; x=1701962159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfI8FXRvZEdls/OEw4QY+jI4dB3/RzHHv1MmQpiqi+8=;
        b=LIt114rqpIFDGmB+kEEqlyoJ+J/y4ngCSR5N/BI17ctW0e4H6la8MTwSKnW/JEC8f7
         hLfzu0TcHaPkppsfT9YmpSFawx9eLtoXFazK4DGl4dtop2/2ZAK5oj64SENvd3p0wCC2
         n3pDjRd0TWJjeaEf5vYKpMM7xjCeh5R7FsscrwUzen64da/mXN7qXQwcExtOtuEyiyqX
         61PNoaDFNAQxBtwI0ghIAjDhsgopNFjQsmuhuJ1dlgCIcfw/Myshvrh10nfu9RbqK+I6
         nNfqHMBNIyl7PfrJUYEzbnnzW0NQ+/xX/3gljzxDo4xNlSVLPSyfVYf+xnwJfDv1fvqt
         f68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357359; x=1701962159;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mfI8FXRvZEdls/OEw4QY+jI4dB3/RzHHv1MmQpiqi+8=;
        b=evQmEwzNeIl3hF4HCcJo7ESeIkqFBn39KgVhguScuwp04y9m3lLU5qefEncIZXKYAr
         6bcnj44JBU+iA8XHc6nFh4eNugAznX78rBwluQpijloYXeLSnY5iVBNSviJnSS9VcX6i
         EQTAdUs4skPz/jw9Vglf04aOkGmIeEnKBtG65MbH7b50wKfFrd15IYuq8lhvpqwZJLPB
         Lki0t3pX0D/6vopeEnUqI+BDpTsas5lev2yb6eG+uT+zfjwQryhVLzorj7lHb5XzfPl8
         T0ppw1Jjkq+78ubdclg76uzdM5KxFKGdA+z7K4mX3NJneTsv6NzAp4wXNcXIyKwYQio0
         hU8w==
X-Gm-Message-State: AOJu0Yxui/lKNwImWHVz7GKoX3kCjce2UNQMLGYqQOGSUZ5cPyUGkfm1
	Nv/DZZfTooP6XpPicg/jZcE=
X-Google-Smtp-Source: AGHT+IG7S6zwmgwehDyYaO3Ejt0g/UUqerZxOJOnw3YWeNnWFzix86hSCYWENS81B3OaWga7HQwIlA==
X-Received: by 2002:a05:6808:bcc:b0:3b6:d617:a719 with SMTP id o12-20020a0568080bcc00b003b6d617a719mr29859230oik.41.1701357359451;
        Thu, 30 Nov 2023 07:15:59 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id n18-20020a0ce492000000b0067a35c1d10csm571455qvl.114.2023.11.30.07.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:15:59 -0800 (PST)
Date: Thu, 30 Nov 2023 10:15:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 netdev@vger.kernel.org
Cc: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>, 
 stable <stable@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <6568a72eab745_f2ed0294ad@willemb.c.googlers.com.notmuch>
In-Reply-To: <37d84da7-12d2-7646-d4fb-240d1023fe7a@iogearbox.net>
References: <2023113042-unfazed-dioxide-f854@gregkh>
 <37d84da7-12d2-7646-d4fb-240d1023fe7a@iogearbox.net>
Subject: Re: [PATCH net] net/packet: move reference count in packet_sock to 64
 bits
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Borkmann wrote:
> On 11/30/23 3:20 PM, Greg Kroah-Hartman wrote:
> > In some potential instances the reference count on struct packet_sock
> > could be saturated and cause overflows which gets the kernel a bit
> > confused.  To prevent this, move to a 64bit atomic reference count to
> > prevent the possibility of this type of overflow.
> > 
> > Because we can not handle saturation, using refcount_t is not possible
> > in this place.  Maybe someday in the future if it changes could it be
> > used.
> > 
> > Original version from Daniel after I did it wrong, I've provided a
> > changelog.
> > 
> > Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
> > Cc: stable <stable@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks!
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Willem de Bruijn <willemb@google.com>

