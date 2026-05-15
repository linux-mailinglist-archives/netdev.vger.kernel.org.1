Return-Path: <netdev+bounces-288451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJihLfqFB2rR6wIAu9opvQ
	(envelope-from <netdev+bounces-288451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:45:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F249C557893
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29C20300A581
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1F3EB7F1;
	Fri, 15 May 2026 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/DPFY2q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7B30C174
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877932; cv=none; b=QImjYh2E283x6NkngSIFxBm6s38PNGRpiCatCbGHIZ53nSROe0leiBM9PZX3lDFjgFvCRKvCNPh5tSDCLJv9gg4LCULgOBoPDHEgMzaWoO2vPEcyDTWgqZtLytBf9b+NaE5SgsojF3SFuv76pvBefBHMLfcmA1Z6bB2PBaIYpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877932; c=relaxed/simple;
	bh=jYFCW0q2oH14t/Tdq68TImEf4QAJ0L7oEU4dKSkZpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KALkBhISp8SJcblNFTxDVIQpZBUHr2JgEfnzCSualaVJdPc2nFDJAzUWxyeJrm4jNzZaKdS28MHpZgUw+5QpHgS5NlhAVJWMi7TsFuBECiNsDggcGAlBm65oQ0kTQxeaGbo8n3NQOZxWzLo0EzMQjhk4QTguxEoO5XqZhuwF0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/DPFY2q; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-369576666d5so129515a91.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778877929; x=1779482729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jp3G/+8nHauE/XI0omIm5SsO4BbcTyQ1cU6IXSGwNU=;
        b=F/DPFY2qHcEADU66AoQ/HAiAUlJsUgix7K5w2KL/d345RfzWcZ6/PEzo+Y1thEIbVX
         D6pBggvaMQ4CeZvz4e+7UIecvaw/fDIZTZOkyf4rTCXp8iRSySBbW5Vno5f6XClfLy7Y
         sscb1UyDNZCvN4XOc4pZdW+IpC1S9opSJKuKSfZtVKazLuGgEpBJ2rL4274QDUb86avo
         elS6sVawMNeL20eBSkLQWSVJPwOQOeKdunhYEgARNhF1tAB1DyIDQv4PWfB89guc5O5g
         gcEfpJiN7Fy5RO8kI6D5jH+ss5UEHZ/1xjMKWg0S9lcPhQKlHmRuYKtZ37PYOKKX6rjq
         EE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778877929; x=1779482729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jp3G/+8nHauE/XI0omIm5SsO4BbcTyQ1cU6IXSGwNU=;
        b=LnSNVszpJEJqlgU0q9DaiQw0tAT1Wm4bGMGWwpSzX8IDGEKyxRWEDWcuohkVlbBe6V
         041gmp6iQgZja1/sBtQdXiNIE/1OdztdkWHChi+kOzYMW5QYXvfRBV3Z5cKVpTygNcco
         PmyvpW2vnPmAau1MeRCIRlx6mklt/cez5/kt4aSluPtc14I/idB6ReIGujR1NHh7coIz
         VMy/8qHH4MNZ13dPBfQu/RGHIbsgy1//owcKFgWXmwuAd+be51cvk+yoB9BdBQMBup8x
         t/AUcKYNLfpKWYq9ueexhtIK57S/BoFr+r06pCizTK+0rP44+jdgcbcQ1OFnyxr/RX1H
         zrYA==
X-Forwarded-Encrypted: i=1; AFNElJ8jI/gUD1l967VyjPzEynjON/0k1klq3ngEJDgwEJZqi5S73QeV8St38Od6gHx1peb4SJDBzZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86X9+8nM/Nh5Fan6Rw7ecMjDw23gyGIn4NdHvTrmvOI8c6inL
	cNkxO3epYoBhHGQJjth6kyjU/GKb6qZVkaSjPVOGrABQjbUy9xAAjeFm
X-Gm-Gg: Acq92OFBErL+hmvcLFHIQ2Ax2+rAswXWmBdfnOaGjnb8nROr3aCO2wUP1v+R8Ft8eUx
	4kP1VS0BLuoK0rgzNpM5KOgkahqMCDhfY/JgEqLBOtSsXWOUvu8bNV1srS7SW+sE7XCVelHwUsY
	KNJeK/WyVd0oSqOtAHBeqVWP4pwIoZF2F9L3TjBzL/SAJrHf3OPZHZI0uROK+t0S0yzgYQyth0x
	5/Bd01o4yVA5jbds90UCO+mKIZRa+xiXC6mRZQgEzO5w7BUeWg4bg64CV7/5JS8bhSw/pgm6okp
	hfNtg2+L52b3GvSOGNVju60TqrTWpGErw7Iw1I/0PaQxpiPyI/kWocmsLin/fnxSX1CoE/JoEoQ
	YEwXKWvD7eSqY7aL+Dv3lKKryzILaHbLpW4Lp4rJrctLJ1H+81KXlrZ4kr2k0vJKiPx+VkgxdrP
	mmeKURWbt35FKez7f5
X-Received: by 2002:a17:90b:1810:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-36951ca602amr5899046a91.22.1778877928785;
        Fri, 15 May 2026 13:45:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369703bcc91sm167683a91.3.2026.05.15.13.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:45:28 -0700 (PDT)
Date: Fri, 15 May 2026 13:45:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 1/7] af_iucv: take socket lock around
 SO_MSGSIZE getsockopt
Message-ID: <ageFn6UV-c-pOPBW@devvm7509.cco0.facebook.com>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
X-Rspamd-Queue-Id: F249C557893
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288451-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,intel.com,fomichev.me,iogearbox.net,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com,lists.sourceforge.net,vger.kernel.org,lists.infradead.org,lists.linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/15, Breno Leitao wrote:
> Mirror the locking used by the SO_MSGLIMIT case directly above: take
> lock_sock() before reading iucv->hs_dev and dereferencing hs_dev->mtu,
> and release it afterwards. This keeps the two adjacent getsockopt arms
> consistent and matches the lock held by iucv_sock_close() when it
> clears hs_dev.
> 
> This is not an exploitable bug. iucv_sock_close() is the only writer
> of iucv->hs_dev and only runs from the protocol release callback,
> which the socket layer invokes after the last file reference drops.
> The getsockopt() syscall holds an fd reference for its entire
> duration via fdget()/fdput(), so iucv_sock_close() cannot run
> concurrently with the SO_MSGSIZE read on the same socket. There is
> no other writer of hs_dev, and the aligned pointer load cannot tear
> on any architecture Linux supports, so the existing code cannot
> observe a NULL dereference or use-after-free in practice.
> 
> The change is purely defensive: making the locking pattern uniform
> across the function avoids surprising the next reader and removes a
> foot-gun should the close path ever grow a new caller that does not
> hold the fd reference.
> 
> Note: For the reason above, it doesn't contain a "Fixes" tag, and is
> aiming at net-next instead of net.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/iucv/af_iucv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 72dfccd4e3d58..3dd11d7a967c8 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1566,9 +1566,11 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
>  	case SO_MSGSIZE:
>  		if (sk->sk_state == IUCV_OPEN)
>  			return -EBADFD;
> +		lock_sock(sk);
>  		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
>  				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
>  				0x7fffffff;
> +		release_sock(sk);
>  		break;
>  	default:
>  		return -ENOPROTOOPT;
> 

SO_IPRMDATA_MSG also seems to be only reading the value set via setsockopt,
so maybe it's ok to just cover the whole switch with lock/unlock? (will
mirror what setsockopt does)

