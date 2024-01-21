Return-Path: <netdev+bounces-64517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D6835815
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 23:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57B91F2163F
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 22:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DEC38DF5;
	Sun, 21 Jan 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SC6CHsCi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DBE38DE6
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875421; cv=none; b=rCH+onMKeRvoQtqWve9TUgUh3aTlDAAz3FJIqs/hPKDLvfrOnvl5K7wuoaTTzv7VE3sI2JRHq9PIhNMKYXWOiYGY65zSL1wOh5zxBUrUHVRwUoBo8OEQATGVZLXEgVih0zTlIWQJUnCm4iikycG/eh7R9a2awoXcm+r2QNTm9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875421; c=relaxed/simple;
	bh=B0aQ/Z3BdFp74NHrTsOEvpzGwjqlREVQELwn4ohctHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0Rgjj8arjGhJnxnL/Pg3NSM5nlSLqygLfjKV3jsZm3zTrI128QbtaYJiVa4VGAJSk0hQqMoSRsavzWUgbavl4rGVvaWFFElsL/wA4apFrCey+4fgVqizRVcmniZhI+I+f0+tiSpluW98ocZqbToYgQMdgkRXIJK5TGmDmTVQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SC6CHsCi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705875418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OP4r9Ek2wXjl//V6jfDaPiJ6sJbyRWNqxCJqUjnFuqA=;
	b=SC6CHsCigl8f44Y7ueYNlU5iyLzn9I7jUiRb2e8sMrhIlTcqMI6xRfianvNbKwU18WPNKl
	Tm72q3Lo6c3pY2/p7MleSKxCZc4xyqysTSZJHtHIfLKu5aoHf6SUOXLPBEDdz9GY7nl8uw
	UjPfqNYJ1k5kH5+DhefTrpSDrx8/7Yg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-6MJPQmASNe2WddOKZ3atJA-1; Sun, 21 Jan 2024 17:16:56 -0500
X-MC-Unique: 6MJPQmASNe2WddOKZ3atJA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a301f12fc5dso26128766b.0
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 14:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705875415; x=1706480215;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OP4r9Ek2wXjl//V6jfDaPiJ6sJbyRWNqxCJqUjnFuqA=;
        b=n562vKqMC829Lif9c+ayJYiZ3s9KhFz0CSdQWvUFnGXj4kA0n0T4QHZW8LSBw/kAhx
         1lIT11oiEwL/wS/PDAV9T4VCqJrP3zm41JG4J/YogxQ3zfjSdAg+SI+S71WKaRdi0o0u
         XH1+m6s0B8xuO1Ak0SM3rg43fWixeQNfZnjdFj0A2SBWTmZIfQdEB/srrypVqmDVH69e
         nkD6svQX8lxfHQysLVIRr111ItXWX3SHKf6ZKzzTBMPZgGjHYjC0j3WYx1tEO9wDI2zc
         gx9qxjNM6KDlQaqDLGWhhSWHaiEZz2uk4d2UzZ1qAX/xJIKUjfIJQfMOaKuXj6XLYIRc
         jrcA==
X-Gm-Message-State: AOJu0YzoZ5CPv3/AWayXXP2wdgjYYCnRHoRHXxfyGw10SFdPdSfJ5PGi
	dTskeMW4AKhr4f3OIfF/lG8IXe8HHOIy9eFCeZJb8G5J/sX8EPU7OOmOJ36WnlGnTVSNFpz02aW
	wrVenljhsgVt95UQoKDSo4z0M7p5rDPgaLhkbHdPhlDbdRXY1RA/x/Q==
X-Received: by 2002:a17:906:a213:b0:a2f:2000:5d4a with SMTP id r19-20020a170906a21300b00a2f20005d4amr1695717ejy.69.1705875415081;
        Sun, 21 Jan 2024 14:16:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5PkOhyR/6C0Q8XkgYGRUn88ocVdJWEVes6l9rN/LAqdV/dfmwMiw1hYOCJ5ElP6s8nbIKFw==
X-Received: by 2002:a17:906:a213:b0:a2f:2000:5d4a with SMTP id r19-20020a170906a21300b00a2f20005d4amr1695705ejy.69.1705875414735;
        Sun, 21 Jan 2024 14:16:54 -0800 (PST)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906399900b00a29db9e8c84sm12730421eje.220.2024.01.21.14.16.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2024 14:16:54 -0800 (PST)
Date: Sun, 21 Jan 2024 23:16:15 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Jon Maloy <jmaloy@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, lvivier@redhat.com, dgibson@redhat.com
Subject: Re: [RFC net-next] tcp: add support for read with offset when using
 MSG_PEEK
Message-ID: <20240121231615.13029448@elisabeth>
In-Reply-To: <595d89f1-15b1-537d-f876-0ac4627db535@redhat.com>
References: <20240111230057.305672-1-jmaloy@redhat.com>
	<df3045c3ec7a4b3c417699ff4950d3d977a0a944.camel@redhat.com>
	<595d89f1-15b1-537d-f876-0ac4627db535@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 17:22:52 -0500
Jon Maloy <jmaloy@redhat.com> wrote:

> On 2024-01-16 05:49, Paolo Abeni wrote:
> > On Thu, 2024-01-11 at 18:00 -0500, jmaloy@redhat.com wrote:  
> >> From: Jon Maloy <jmaloy@redhat.com>
> >>
> >> When reading received messages from a socket with MSG_PEEK, we may want
> >> to read the contents with an offset, like we can do with pread/preadv()
> >> when reading files. Currently, it is not possible to do that.  
> [...]
> >> +				err = -EINVAL;
> >> +				goto out;
> >> +			}
> >> +			peek_offset = msg->msg_iter.__iov[0].iov_len;
> >> +			msg->msg_iter.__iov = &msg->msg_iter.__iov[1];
> >> +			msg->msg_iter.nr_segs -= 1;
> >> +			msg->msg_iter.count -= peek_offset;
> >> +			len -= peek_offset;
> >> +			*seq += peek_offset;
> >> +		}  
> > IMHO this does not look like the correct interface to expose such
> > functionality. Doing the same with a different protocol should cause a
> > SIGSEG or the like, right?  
>
> I would expect doing the same thing with a different protocol to cause 
> an EFAULT, as it should. But I haven't tried it.

So, out of curiosity, I actually tried: the current behaviour is
recvmsg() failing with EFAULT, only as data is received (!), for TCP
and UDP with AF_INET, and for AF_UNIX (both datagram and stream).

EFAULT, however, is not in the list of "shall fail", nor "may fail"
conditions described by POSIX.1-2008, so there isn't really anything
that mandates it API-wise.

Likewise, POSIX doesn't require any signal to be delivered (and no
signals are delivered on Linux in any case: note that iov_base is not
dereferenced).

For TCP sockets only, passing a NULL buffer is already supported by
recv() with MSG_TRUNC (same here, Linux extension). This change would
finally make recvmsg() consistent with that TCP-specific bit.

> This is a change to TCP only, at least until somebody decides to 
> implement it elsewhere (why not?)

Side note, I can't really think of a reasonable use case for UDP -- it
doesn't quite fit with the notion of message boundaries.

Even letting alone the fact that passt(1) and pasta(1) don't need this
for UDP (no acknowledgement means no need to keep unacknowledged data
anywhere), if another application wants to do something conceptually
similar, we should probably target recvmmsg().

> > What about using/implementing SO_PEEK_OFF support instead?
>
> I looked at SO_PEEK_OFF, and it honestly looks both awkward and limited.

I think it's rather intended to skip headers with fixed size or
suchlike.

> We would have to make frequent calls to setsockopt(), something that 
> would beat much of the purpose of this feature.

...right, we would need to reset the SO_PEEK_OFF value at every
recvmsg(), which is probably even worse than the current overhead.

> I stand by my opinion here.
> This feature is simple, non-intrusive, totally backwards compatible and 
> implies no changes to the API or BPI.

My thoughts as well, plus the advantage for our user-mode networking
case is quite remarkable given how simple the change is.

> I would love to hear other opinions on this, though.
> 
> Regards
> /jon
> 
> >
> > Cheers,
> >
> > Paolo

-- 
Stefano


