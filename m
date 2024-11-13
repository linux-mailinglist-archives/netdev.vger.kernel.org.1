Return-Path: <netdev+bounces-144337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F639C6ADC
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF868B21CF3
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476CD17DFFC;
	Wed, 13 Nov 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWmgNVL5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF41175D38
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487729; cv=none; b=p8Ldu/4P4Xb+DI127L/dfh12NM6w+sg78CtL/oVDAgM3Nmq2kih/IN1BUwh3nhQbS+Vho1QiNG7Jdh6z9ukglPh/agM9x7biBxnuwMBZtuTafWe6hyz+hGVTTHTPvlwLMi0dCdKoOMDUjyAdx2x2Is3L+pVnn7WFQYyPW4kIyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487729; c=relaxed/simple;
	bh=2rD+35iIOMUTZkdmCB1B5ZFhapy6EXwywGqUU9ML1GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAeLchJv6gSMjpKsI2ZSkaqN4Dl+XnSJHx28OyIsrp84ryDYjlrSOIIhQvn3H1JFPClRAGHB3Iv5FBnapU6nfVrGTwgP4Aul+IGHAyyE1W0IObs+VBTUgnCIo6ybRB6aUMCgtMJGgY2gv8lHg4Qc7NvgCC1uDHIVuRq8zX9q9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWmgNVL5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731487726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EYg4VfynzwIiMrgokuYr8adCnrOyJM+ZuPcWT4xpSzI=;
	b=jWmgNVL5bocyqA3BUzTlj1geFeWRvERHCicVPh7F+ulacWQgRSP6FwW4RTKKAxDB+0+TrY
	1pB7VvzekxqkF1dREU37Bs+YZ3ON668vw+JPivcAPgt7WdWbL683CqdGP2yhjlMP0I5LRJ
	ZEo8ukqGqoNWsyjoa8mEhLQHVD4fFZ4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-GIFGXv9kO56t7fZWUwwcmQ-1; Wed, 13 Nov 2024 03:48:45 -0500
X-MC-Unique: GIFGXv9kO56t7fZWUwwcmQ-1
X-Mimecast-MFC-AGG-ID: GIFGXv9kO56t7fZWUwwcmQ
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so11048545276.1
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 00:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731487725; x=1732092525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYg4VfynzwIiMrgokuYr8adCnrOyJM+ZuPcWT4xpSzI=;
        b=Zmo6oBkhNEohxIqLIi3TLTuF9IzKpjrS/r5xWPR1bs9LRHZXfYpb+4ONyL4wrZPzge
         +51s7zMPq+aqv3xxbtRKyep7Ts69jRE6+t65iZuPyPOS1Fekaf06gIG7qv8+1xnCzV0G
         r6PxrcsOTHV3LFbYWQ3q8ZZVf9l/fTmEmJf0kknktugA5mownfiMjAJKzpMUAJegX4VD
         W6xM6f+yDk2o7/f/tdmgIbInFyETT+4onYEejtim4Xl6+WK9RAg+5aElayzgFMvwRe5Y
         P+fSS0W5xsQfvuE3fRZ1/GTTDwCJXnDjQH//7p2iJUVBWsbEbe8X9zXvAlnAxmEpO4s6
         5hNw==
X-Forwarded-Encrypted: i=1; AJvYcCUM5og69hkWQVmBuWXVAt+zgo8UdkzA9/YWDptqvP2b6z64moe+Zubi5drhl8otp+BiAfkJMj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0Y2Rwb8hUwBuk8v1BfhUVzOtnqbRsZXr9fZfiVpf409d4hyE
	j9Ln42sG/yP9aEiyDU9nDgyW+pdO/hSH5oBO+nrfJEmarOyTCdjU0dqd4s2lozAWMosSkGoQx3T
	lUWW82gMbOSQ9UQZ9H9xz58PlAf+9FogHA7ZNZ/6wJNujw8uoIoDnGzy1Z3V37sk/sOeG54qQVk
	uz2evOs3FuTT9PTu2LD0RPUTmecWRw
X-Received: by 2002:a05:6902:704:b0:e30:d910:e5c8 with SMTP id 3f1490d57ef6-e337f81ec34mr17149351276.6.1731487724710;
        Wed, 13 Nov 2024 00:48:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRwYx2NDKzd1FyvbGsn/DijngUPXjeEXugbCrGHCELRWnwDiqo5Zxxz30kUywtPEp7isgqCjCkNUAx2yLzdqQ=
X-Received: by 2002:a05:6902:704:b0:e30:d910:e5c8 with SMTP id
 3f1490d57ef6-e337f81ec34mr17149345276.6.1731487724442; Wed, 13 Nov 2024
 00:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112111727.91575-1-donald.hunter@gmail.com>
 <20241112111727.91575-3-donald.hunter@gmail.com> <20241112173843.2831e918@kernel.org>
In-Reply-To: <20241112173843.2831e918@kernel.org>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Wed, 13 Nov 2024 08:48:33 +0000
Message-ID: <CAAf2ycmc-GANpwaJgTc4tt29_rK0K6PLCz3g8FuffSauQOYMmA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] tools/net/ynl: add async notification handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 01:38, Jakub Kicinski <kuba@kernel.org> wrote:
>
> some comments for your consideration, if you prefer to keep as is:
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
>
> On Tue, 12 Nov 2024 11:17:27 +0000 Donald Hunter wrote:
> > +    def poll_ntf(self, duration=None):
> > +        endtime = time.time() + duration if duration is not None else None
>
> we can record starttime here, and avoid the complex logic..

Yes, of course. That's a lot clearer.

> > +        selector = selectors.DefaultSelector()
> > +        selector.register(self.sock, selectors.EVENT_READ)
> > +
> > +        while True:
> > +            try:
> > +                yield self.async_msg_queue.get_nowait()
> > +            except queue.Empty:
> > +                if endtime is not None:
> > +                    interval = endtime - time.time()
>
> then here:
>
>                 if duration is not None:
>                         timeout = time.time() - starttime + duration

That'd be starttime + duration - time.time().

I'll respin with these changes, thanks!


