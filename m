Return-Path: <netdev+bounces-256025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIbnDWkogWnsEQMAu9opvQ
	(envelope-from <netdev+bounces-256025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:42:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA57D258F
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 452B63100A3D
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC2838551C;
	Mon,  2 Feb 2026 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLTnF6Cv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0A3563E8
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071497; cv=none; b=IS8WG0VqLACaDFQNLVUR/6MpO9S0UWmVVeifE5D8HE+YhyCEVw8KGhrLKoLzeBEEAAhA57UoDLWEwFux7/AiKItPAru1Sa0Lmfo10VMLAYr0pGtDcIMeBQaULTnUzC0EoLo1cImAxv4kP9hzCXN5GG8a/7IOI/u/O1jR48+xvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071497; c=relaxed/simple;
	bh=FKtoDRTtb+4i7v/qjEwG2Xg2B/SIBUBqdJA1PVVs8mU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHapJeDvkQZHbqExLpFt+Rn/duPS9kUrMeSXAAdljtyCNWel4EfCYNm4NsNqEtIZIk1IKYZdQoe1RJnkUXS+nvGmZnYwmYeMLXxVpfv+nHoPMXkuMJNPTCVWWkElzfnl4r1e5TLbLNF0tFy9DkXV/3+kozR35D0NyW/3z5zqYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLTnF6Cv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480142406b3so36962225e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770071494; x=1770676294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIZUSELiXp+s9+KpMxQDKTA6DmNxb624EHaq2wV6J20=;
        b=hLTnF6CvvwEYLHacUBpRKRDcOFKxz+c5YDRbqFyQJHGxjggfEdXhb5HALhEHITN1/q
         oa8y1n1bv4B4xe1Nd3xjxZQueIRnpJRqYnsONW6RasHTvjPqHYiQRwrF3k7MQ4MCRFiF
         fPpO0pptW3T098QMQM9upnZMloxQtgbpstpwET/j0QOdU+QrNJ2goleiHYMCcPGKIU0X
         5z52JGEgkSpmlzxXl82dgyGM/F1PSiFtS8eFb7mzZmpe9k2lEpdZ9yeK8EFd5NvxT/Wj
         o/v7Av4DO4wwrKc+O+ebSZR09VJSkNBPJGCYCl0MjRwAoSRP6O/PIP6LoitWN/QI3kir
         HxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071494; x=1770676294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIZUSELiXp+s9+KpMxQDKTA6DmNxb624EHaq2wV6J20=;
        b=lFx7z2Pe/XzBBxzzChrSy5CSpFaf3xmT1gYaX+98RB0vW5UX4b4tjW3tBxlx1KJgz+
         EihEPc0qh8aLjoWF1sVfBIgFYIPZvFY/IHY1rH3HPYdr0833j7j7JjoDa+tOYvaocUUj
         0tmRoekySYop4hHWPnWOgng7ViH9KhjQ0LC2nHpsjTPWVatwNYfXA/SQ+x9i3GIdavrJ
         5EbebkHn/ELQX70XKzlxb9Ong3UKxMJNatXgIdJddXTJwNBsr01ic+dHMC6n5rulRLvY
         ud4JYnbB3Qir+xHX7NUWTaseiVYnFQd7hOZqUAFIZGWdP7/L4/D0FN42Q3wyeSmESvmu
         iqqg==
X-Forwarded-Encrypted: i=1; AJvYcCUJOPkIj+C8NoacCihzs9/GQan2KjG9Jr2Ma8MZPBUDCGOp0k+CjJuvbUxBIVkFE9xy3AcZm8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmd+G+rrirO+LKndbthVMFfBcdvwUwsWWOAXH1qs3foH8ULbu7
	iZz3krHX0ncL7T0OwWW/DpHzhuIy6yyycYgUFhDSwgE+kLCQSc6UYPAx
X-Gm-Gg: AZuq6aIrRsIWypSr9BMH+WGpHZHRUrjCFueGC6H5DupRDy4ILCU8qisBdvlTKGwO0sz
	Lj+TLmJaGUkyVFVvebc71ifljewLo/wsJ+d++yZOhWwOenW5htqdhT0ZTsJDpUThNFSGqxlMVpm
	LV8YkoEq8C5f1+lfb7TfgapUL6csLdFChrkgWF3lW90W4ret0NQk+lHf4c+jiTccVkcD8WgSLWN
	HsEX2J0FYmOTuUjuoj9S8WrQeLNDJKKDy3k+BuDZZ5gndXiqFY2zHTC3BEWre5bHMRJ6pXzgAP9
	Z56WRA2Jd9+4lmLlNoPJf3ZLvtdX/c8UuSt4XO0WQE+mxH7nurZumCwT7/Mda8doR3UW4oOs1ZD
	rlMijCjrjjrdacyXkt/p5yopPRN5r/rVMBqdR9MwPhmewuYiew3xAobN1H3evbvJk7tmxXqfXzP
	oSJfFPcQUcuNpDKBq/G7qH2eGnzpqMd5QV/joEO/cBYQQlMhYBcwJB
X-Received: by 2002:a05:600c:c16b:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-482db47d849mr161092965e9.19.1770071493556;
        Mon, 02 Feb 2026 14:31:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051539ddsm17861575e9.9.2026.02.02.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 14:31:33 -0800 (PST)
Date: Mon, 2 Feb 2026 22:31:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 metze@samba.org, axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
 io-uring@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next RFC 0/3] net: move .getsockopt away from __user
 buffers
Message-ID: <20260202223131.44e81ba1@pumpkin>
In-Reply-To: <aYCUpNyNihhR7no0@gmail.com>
References: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org>
	<20260130205227.6fb1d9ad@pumpkin>
	<aYCUpNyNihhR7no0@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256025-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CA57D258F
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 04:32:42 -0800
Breno Leitao <leitao@debian.org> wrote:

> Hello David,
> 
> On Fri, Jan 30, 2026 at 08:52:27PM +0000, David Laight wrote:
> 
> > The system call wrapper can do the user copies, it can also suppress
> > the write if the value is unchanged (which matters with clac/slac).  
> 
> This aligns with my proposal: using an in-kernel optlen that protocol
> functions can operate on directly:
> 
> 	typedef struct sockopt {
> 		struct iov_iter iter;
> 		int optlen;
> 	} sockopt_t;
> 
> > The obvious change would be to pass the length itself and make the
> > return value -ERRNO or the size.  
> 
> I explored this approach to avoid embedding optlen in sockopt (which was
> Linus' original suggestion). I attempted returning the length both via
> iov_iter and as a return value, but neither proved ideal.
> 
> > #define GETSOCKOPT_RVAL(errval, size) (1 << 31 | (errval) << 20 | (size))
> > which would get picked in the rval < 0 path.
> > It would also let 'return 0' mean 'don't change the size' requiring
> > a special return for the one (or two?) places that want to set the
> > size to zero and return success.  
> 
> My conclusion is that encoding both optlen and error in the return value
> requires pointer manipulation that isn't justified for this slow path.
> While technically feasible, the resulting "mixed pointer abomination"
> won't be worth it.

Not really, they are both just numbers.
99% of the protocol code can just do 'return -Exxxx' or 'return size'.
That is all simple and foolproof.
The calling code (not many copies) does:
	rval = foo->getsockopt(..., size_in);
	size_out = size_in;
	if (rval >= 0) {
		if (rval > 0)
			size_out = rval;
		rval = 0;
	} else {
		/* abnormal path */
		if ((rval & (1 << 30))) {
			size_out = rval & 0xffffff;
			rval = -((rval & ~(1 << 31)) >> 20);
		}
	}
	if (size_out != size_in)
		put_user(size_out);
	return rval;
(Or something similar depending on exactly how the values are merged.)

> 
> > There is not much point making the 'optval' parameter more than
> > a structure of a user and kernel address - one of which will be NULL.
> > (This is safer than sockptr_t's discriminant union.)  
> 
> This approach forces every protocol to distinguish between userspace and
> kernelspace, then perform the appropriate copy:
> 
>   static inline int mgetsockopt(void *kernel_optlen, void *user_optlen, ..)
>   {
> 	....
> 	if (kernel_optlen)
> 		memcpy(kernel_optlen, newoptlen, ...
> 	else
> 		copy_to_user(user_optlen, newoptlen, ...
>   }

That is a function provided by the implementation.
It is no different from using the ones that act on iov_iter.
The real difficultly is stopping the usual culprits (bpf an io_uring)
from cheating and looking inside the structures.

> Additionally, you'd need safeguards ensuring callers never pass both user
> and kernel pointers simultaneously. This seems significantly worse than
> using sockptr.

Sockptr has the real disadvantage that it is very easy to mix up the
kernel and user pointers (there is some horrid code that looks inside).
If you have separate pointers that can't happen.
You might access NULL, but you are never going to use the wrong address.
Remember some systems (s390?) use the same numbers for user and kernel
addresses - you have to get it right.
In any case, if both addresses are set you can just have a rule that
one is used by preference - it isn't a problem.

There might be legitimate reasons for setting both pointers.
Consider setsockopt, the wrapper could copy small user structures
into an on-stack buffer.
The structure would then need to contain the address/length of the
kernel buffer as well as the actual user address in case the code
wants to read more that the expected data length.
For a kernel caller you also want the actual length of the buffer
as a separate field from the length of the [sg]etsockopt().

I'm not sure what fields you need for the address buffer.
Probably 'user address', 'kernel address' and 'kernel length',
what you don't need is support for scatter-gather, page list,
pipes etc.


> 
> --breno
> 


