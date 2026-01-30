Return-Path: <netdev+bounces-255269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AqWDYIxfWntQgIAu9opvQ
	(envelope-from <netdev+bounces-255269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 23:32:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F0BF23E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 23:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2E793004DCD
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28E34A773;
	Fri, 30 Jan 2026 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpSEKBew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401C329C49
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812351; cv=none; b=NwPUZDlhC0fOasv5g8fdSQJpmXxBelJA0PW5ZVxIIYBhlutJHIAfDyymjGRNACvgoQpoeDI/IBh7obZmpo25Zuw+3THMb2UY4qnwPVD0IP9wqKUtS02vpZmde8uXn0K5Rd+TeLC+Os5sSkmbtPsjxvA/Iyde8EKvjtKc2W0MWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812351; c=relaxed/simple;
	bh=KcUQ1q2ALIp6GQbsuyiFX7GWULQTAiWrMXNKUDp6gDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6Ih79iuuL8ueoU7+zfIclLjjXcMBJbHG0TPFaN6o83ICFK8qnd2gZw8zcg8ahiRZyHOfHYuGToFYB7aUu94XVRG8fQKCV0kkGS5BBn3lbR3T8DlSiZ0njrBegm5oVt5RUp3QQ6gsd0N3fAYwCBxovgwZrsEtQ7kTlIqvXR39ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpSEKBew; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-382fa663249so21884771fa.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769812348; x=1770417148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkVCe2Fm0X1zwm2m79SvkIhPjHfte2ufPAVZoEONEas=;
        b=CpSEKBewH3kmVQ+C+lE78YDNsQejMpsP5lHO7JsnYNg5XRDxPqa7nRuZxLrhMo319B
         CHHyXClpWNt+dRyIh0KE2/r1iEKLW6LG/s1lOcbWAvbwPKZCvSAoT859ld04TRr605A2
         E3KBVVIqwyMMROQxY2BPT2sk1lcy77xmTehljVgY++RtrSH4dC8ncjOoISPvF1L7+FVs
         rAG8qJiP7/K5zkJ8WeLAaMbThdK2z3g754ZOG3FeQBnvMnqRYmUav5Qu9ylCuuUlyDCR
         EwwAbAus4zfgCaEH45v5Qv7O87svV8pVmuLEUt8fQBl5EDxbkae7HpzGePg71me2hN31
         +7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812348; x=1770417148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZkVCe2Fm0X1zwm2m79SvkIhPjHfte2ufPAVZoEONEas=;
        b=gFnPFryG/aI48DEh5VoGG671RHpA0Oty1oU2OtsnOhXKu5lzGo6tKynFXvumTR2Y5G
         OCXQPrElElsfJ0vadAlKoTGl4eJQXL1XV35YLVP3n1ulCAKJ7O+sYKxL75pve0Jcqghh
         dwJZX5pOwxgaEfVdiBWLqOs1anFPJ/O16ycbvOMnNTNspM8yjXUdnt8OXlkgMKPr6Hj2
         rFPB2NX4XtpLeM31v+9VHl9toAr+DwciHla8BuT4Q4j33tOrQ39wEJO5kHEvc0BYZhMi
         iPYlZw9olWEa2iIxWl/uJXuWLpopz6ZuljrnSRB5Dv0IPcjyW5KyfU3RZRjCtill82xk
         vt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWETDMHSwc/S9Z21/WkT0Yep6eADGAV1LogUhmRTpqYSGUz5hf1Pu498dnjJjx+fEBvZOqlNsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxja/D98cEvcuddXmOGR4D6Rd2POwc+iZUTYnhTi4K7YjFfJ7TD
	NMb3j37rNFDkZ/GksdFILzJXtHQnAADqX+4aV+JzaGH2Gh4wBQiWDJ5VMonmSw==
X-Gm-Gg: AZuq6aLzDlTUhsInbiC/Xtbr0Pa7PgSxOKFM42WWlIpYXAu1Wx/gOZ0FUTSyuLbpcwd
	04KL6lG5yubqx2iqAjPzgfU6WvcdCWbz3PXImsWeXrwnoRnoO+MAx0merMsaH+0qju/KIxd/GW9
	xN0xv+b+euLgvzhHr0pdm903dAI05pFFFq5yqs12Qi/X3owtzLwD+Ub4Fr7FiUHuV0VKuPjNdcT
	vUg13iTg8Xvg/M/TjaYdZFVSY6/M9k/B+AeBsRNdjT7EIJ61BWdtRBHzC6Btx+PqRY3GG3/8Puc
	VsYkxk8GaHMhYVVu2ncaK8Qg/uMgOuWv48dEKF0p/ydry4/wwSPMQgmA7J+5btG2Ov2iGocAt/H
	8DgZnQt84b39OrVPj3u4hi793O4QKW8UM2yOpwsDcQJZlB8SUU/ZyU4VFnYMP+fM2seZ3XzRAEZ
	LzsNH+ixb49Eift4zQQYsm5HjZPm3ZKXYpTNvY3PKm71eP0/yNEvGT
X-Received: by 2002:a05:6000:2004:b0:42f:b690:6788 with SMTP id ffacd0b85a97d-435f3a6baa6mr6239935f8f.10.1769806350269;
        Fri, 30 Jan 2026 12:52:30 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e267aad1sm21831845e9.15.2026.01.30.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 12:52:29 -0800 (PST)
Date: Fri, 30 Jan 2026 20:52:27 +0000
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
Message-ID: <20260130205227.6fb1d9ad@pumpkin>
In-Reply-To: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org>
References: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255269-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D75F0BF23E
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 10:46:16 -0800
Breno Leitao <leitao@debian.org> wrote:

> Currently, .getsockopt callback cannot be called with kernel buffers
> because it requires userspace addresses:
> 
>   int (*getsockopt)(struct socket *sock, int level,
> 		    int optname, char __user *optval, int __user *optlen);
> 
> This prevents kernel callers (io_uring, BPF, etc) from using getsockopt
> on levels other than SOL_SOCKET, since they pass kernel pointers rather
> than __user pointers.

I had thoughts about this as well.
I think using iov_iter is over the top and may have measurable performance
impact for some paths.

I think the first thing to do is sort out 'optlen'.
There is absolutely no reason for the user pointer being passed into
all the per-protocol functions.
(and the code that changes that use sockptr_t are just stupid...)
The system call wrapper can do the user copies, it can also suppress
the write if the value is unchanged (which matters with clac/slac).
The obvious change would be to pass the length itself and make the
return value -ERRNO or the size.

The annoyance is the few places that want to return an error and
change optlen.
That might be best addresses by something like:
#define GETSOCKOPT_RVAL(errval, size) (1 << 31 | (errval) << 20 | (size))
which would get picked in the rval < 0 path.
It would also let 'return 0' mean 'don't change the size' requiring
a special return for the one (or two?) places that want to set the
size to zero and return success.

The length passed should also be 'unsigned int' - with a check for
negative values in the system call wrapper.
(There are many broken drivers that treat negative lengths as 4.)

There is not much point making the 'optval' parameter more than
a structure of a user and kernel address - one of which will be NULL.
(This is safer than sockptr_t's discriminant union.)
You can't police the length because it is sometimes only the length
of a header (and in some recent code as well).

I have looked at some of this change - it is enormous.

	David


> 
> Following Linus' suggestion [0], this series introduces a wrapper
> around iov_iter (sockopt_t) and a temporary getsockopt_iter callback:
> 
>   typedef struct sockopt {
> 	  struct iov_iter iter;
> 	  int optlen;
>   } sockopt_t;
> 
> Note: optlen was not suggested by Linus' but I believe it is needed, given
> random values could be passed by protocols back to userspace.
> 
> And the callback becomes:
> 
>   int (*getsockopt_iter)(struct socket *sock, int level,
> 			 int optname, sockopt_t *opt);
> 
> The sockopt_t structure encapsulates:
> - An iov_iter for reading/writing option data (works with both user
>   and kernel buffers)
> - An optlen field for buffer size (input) and returned data size
>   (output)
> 
> The plan is to enable getsockopt to leverage kernel buffers initially,
> but then move .setsockopt from sockptr_t into this as well.
> 
> This series:
> 
>  1. Adds the sockopt_t type and getsockopt_iter callback to proto_ops
>  2. Adds do_sock_getsockopt_iter() helper that prefers getsockopt_iter
>  3. Converts one protocol (netlink) to use getsockopt_iter as a proof of
>     concept
> 
> This is what I have in mind for this work stream, to make it more
> digestible:
> 
>  * Keep the temporary getsockopt_iter callback allows protocols to
>    migrate gradually.
>  * Once all protocols have been converted, getsockopt can be removed and
>    getsockopt_iter renamed back to getsockopt with the new API.
>  * Once the protocols are converted, the SOL_SOCKET limitation in
>    io_uring_cmd_getsockopt() will be removed.
>  * Covert setsockopt() to also use a similar strategy, moving it away
>    from sockptr_t.
>  * Remove sockptr_t in the front end (do_sock_getsockopt(),
>    io_uring_cmd_getsockopt()) and start with sockopt_t (instead of
>    sockptr_t) in __sys_getsockopt() and io_uring_cmd_getsockopt()
> 
> Link: https://lore.kernel.org/all/CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com/ [0]
> ---
> Breno Leitao (3):
>       net: add getsockopt_iter callback to proto_ops
>       net: prefer getsockopt_iter in do_sock_getsockopt
>       netlink: convert to getsockopt_iter
> 
>  include/linux/net.h      | 19 +++++++++++++++++++
>  net/netlink/af_netlink.c | 22 ++++++++++++----------
>  net/socket.c             | 42 +++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 70 insertions(+), 13 deletions(-)
> ---
> base-commit: 4d310797262f0ddf129e76c2aad2b950adaf1fda
> change-id: 20260130-getsockopt-9f36625eedcb
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
> 


