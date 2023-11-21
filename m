Return-Path: <netdev+bounces-49812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C60277F385A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F4DB21584
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE4584E5;
	Tue, 21 Nov 2023 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ5Nf5uZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3190100
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 13:33:26 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-778927f2dd3so304478085a.2
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 13:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700602406; x=1701207206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCi/l8j6UdK4B1jqFux90kS311v8IFW56CzMSuTNDDM=;
        b=BZ5Nf5uZ/Zf65za+a3EDoFhIAxqoGDb0+63PaNWciYgddxDU82Jea0SMgI9Iai1ZiT
         HZCRoZfZtMIHV35Spzo7pABY5hPU9lHqeNkpw4lwmRauizSkZ0LzCX4DWrjvAZ5IK29Y
         88ZKrDB+Yw99L9z+QreQYBnwnUEbVNPZFJk2X0VhNEOXsbiLdwPQtBEMvvD1+4gSci/G
         4/EMg4LGLhqawvWvRZu88fZAjDnVDz22+PUsdnzY0TG5q5AsOEptl98sf0YzHSW4w1B7
         X35iTvK6BvmUd4wAd2SpmZxFzXsDZyGkIDzFUAumOL7y/G9D+jcS/4n5qDIF455sPUpz
         lHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602406; x=1701207206;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LCi/l8j6UdK4B1jqFux90kS311v8IFW56CzMSuTNDDM=;
        b=JFRlmgqhG2yaS7aLn66VAIdktc6dJeeGVC2YtAsA4KnWWpOaS7oXCNeKDc6VmG97ck
         GK0Ui1v8epBUcHIdpV/ubupUITdTBtTpbxPH8D5SQpuYOn/LILsvsKvoQUBw4BLLoMRy
         F2QLSPi1wiUcNrvlFsPqVGkF/okwM9C6jbITmCpQjghXgjIGETc/rKF2jwPeyxBO/D4d
         /ahdXH+YB021b7aVy+ARaUo7TDZmK92I13zXMF+ZaHK37zlVGgEzlPc8IL3Hj9hEzGXW
         s13vNZIQzwVhsBh4RKisq84/D+df2MYYJ7sa7MjUnzqZuOi9Zq9jjejMwKMY73OJG6DL
         A+yQ==
X-Gm-Message-State: AOJu0YwdbCj0M3u0JL+GMsBYuXEl2Y187yBJpcQXM1JxC1rBbHIoiRw2
	7kd9pwoEU2wSKMKpFNAhjh0=
X-Google-Smtp-Source: AGHT+IEMPIRuxAf5nEM867y78UJBYPyKQFsSQkt/DsMpjLv2jJlH3JeCSWJHeKlWz1K80Jva2+hlkw==
X-Received: by 2002:a05:620a:370b:b0:779:d0a6:2e4c with SMTP id de11-20020a05620a370b00b00779d0a62e4cmr329233qkb.34.1700602405924;
        Tue, 21 Nov 2023 13:33:25 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id p3-20020a05620a22e300b00767d4a3f4d9sm1071347qki.29.2023.11.21.13.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:33:25 -0800 (PST)
Date: Tue, 21 Nov 2023 16:33:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 almasrymina@google.com, 
 hawk@kernel.org, 
 ilias.apalodimas@linaro.org, 
 dsahern@gmail.com, 
 dtatulea@nvidia.com
Message-ID: <655d22256ba8e_37e85c294c8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231121123721.03511a3d@kernel.org>
References: <20231121000048.789613-1-kuba@kernel.org>
 <20231121000048.789613-9-kuba@kernel.org>
 <655cf5c7874bd_378cc9294f4@willemb.c.googlers.com.notmuch>
 <20231121123721.03511a3d@kernel.org>
Subject: Re: [PATCH net-next v2 08/15] net: page_pool: add nlspec for basic
 access to page pools
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 21 Nov 2023 13:24:07 -0500 Willem de Bruijn wrote:
> > Do you want to introduce a separate ID for page pools? That brings some
> > issues regarding network namespace isolation.
> > 
> > As a user API, it is also possible (and intuitive?) to refer to a
> > page_pool by (namespacified) ifindex plus netdev_rx_queue index,
> > or napi_id.
> 
> That does not work for "destroyed" pools. In general, there is
> no natural key for a page pool I can think of.

Pools for destroyed devices are attached to the loopback device.
If the netns is also destroyed, would it make sense to attach
them to the loopback device in the init namespace?

> > In fairness, napi_id is also global, not per netns.
> > 
> > By iterating over "for_each_netdev(net, ..", dump already limits
> > output to pools in the same netns and get only reports pools that
> > match the netns.
> > 
> > So it's only a minor matter of visible numbering, and perhaps
> > superfluous new id.
> 
> The IDs are not stable. Any reconfiguration of a device will create
> a new page pool and therefore assign a new ID. So applications can't
> hold onto the ID long term.
> 
> That said the only use case for exposing the ID right now is to
> implement do/GET (since there is no other unique key). And manual debug
> with drgn, but that doesn't require uAPI. So if you prefer strongly
> I can drop the ID from the uAPI and do/GET support.

No, this is fine. I just wanted to make sure that the alternative api
and netns details were considered beforehand, since it's uapi.


