Return-Path: <netdev+bounces-283298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJWtKmQZ9Wm+IQIAu9opvQ
	(envelope-from <netdev+bounces-283298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 23:21:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 487944AFC93
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 23:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D47430056EC
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3481736C9ED;
	Fri,  1 May 2026 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfdHCQeN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4936C0CF
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670470; cv=none; b=ud7m1itD80waj22RHTbilIf4QjTgCAKlXa/lOUjnGcnMyBcM2MYX7nNiXV+H5YZSSjh/2qDlSJGnPyiGnbV+IVfCT8LQk2xpy2depQSjh3h5RDW8U1nLxy10sHHHdhb5btAkGTHsy/vMF/aDa18Ynqlw9Hwb5byk2FvKUw/2sMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670470; c=relaxed/simple;
	bh=gbYFLTANvKgL0YLaobKU6Pf+SimnzpTiv2B12KmDMck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0tBfyUwVyhZyKeeu3OfS1ueQXN2Nhddh1uH0OZylJ6qmv+Q+evuZF3tsORo0uOdYead0VwRZ2ob14rPKTnFXJEhR1GHc4fZwarMjoFr4Il70ZALypIwY3XsrmDcOSxtUPRHdFr+tgUezEWXMCv86OFTAcKwgzFTSA1PGXYwvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfdHCQeN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-448528f4e69so1320665f8f.3
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777670467; x=1778275267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3Cu+Df2v8gmiZwpX0nD5Z+6tJtgNGySMwqyhPLW2dM=;
        b=hfdHCQeNUln6gHwi1iBuwm14cFds+HdQDBOtrNoYNcD+kxhnUbEzJBWjnEvmGjHR0Y
         yAlRWd8V0TM/DY5MU7upUq9oS68W1u8MztcoIk5yTXM2qpBdOLihOyfwUUXMorC8Isqf
         YavOHcuYz22bGxMj6jStImcOjvmr4GDbJeHd6DlPPNMehYZBklbgKS+AZ8oy9c/qg5N2
         sAgczoppa60yf5RPsdKadsakqR6DXtYzzwd9B5nOSo637ZhdRgtKEVkesBRt6mMaTqmM
         jVAxizVSm1YjmLNIkk4y8Z3I3hv/YWtKTGIsaleDK7vVFoNND8vh3a/I7y6UPFkj/72t
         A9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777670467; x=1778275267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E3Cu+Df2v8gmiZwpX0nD5Z+6tJtgNGySMwqyhPLW2dM=;
        b=XKb9u6esczsmvG6a3eRHrHgL63zWfruK32ggMiywnAm3oVH7MIl/K/Ct7Jb7Q6MKmo
         z+bjoprS4t+DL6qHt770ge+uQSFFoOVAaa1RZTLYbrBJg9nHpNRCFpxsI53n5BrzNXsE
         +MNo3vYm47huNLGAnnUbMaq/tnVk3QUNFdLpLHXeebFK4kRboPl79XPCVvmqO2NPkSig
         YihFI0TgMRMVtMw/hvO9/k6vstHiygFT8JFo9m2goMfzcVqfoMq3ps0kT7nm4lz0+vQC
         L7uKFr+s5uMJ+vl0J+sDOAnrEofdI8MRMj741uKHuSZVYr6BxMU+oBeMxN0vp/xDvFYg
         pYsw==
X-Forwarded-Encrypted: i=1; AFNElJ+w081F+HlOHOVrJUR4LWjAnpK6lhoKhHF5JN2b//MBn6iug1KJJfPIdYwqDCQhGgBLbxpwlSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbuwhUTCQgxELAmE2vw0nDTNR5YE0b0lgQKr2AZNUvRIyTLhK
	j2VLf1cfsCJnbCN2A0oDjH0/k3EB6DNcd4I3bxdNrU1rOT4z62yXx5PJ
X-Gm-Gg: AeBDiesE7AGDyTUvu4O5jx+8CzBGKfZQVyt8YXEwpAEz9bH/Kt18BLXBn03SQgWF9CM
	XpICLe7Z038oRVJBvoj3YApO9RaOe3DkST5CcFJS679/CoSOcIgDXcpZRf2rqpZUd+M98Q0ZuOQ
	KGaP9zOiqJP6Y05qKT+Zi9GFVjfIzFx98lUF8KkLTPWtqrNqHZDFAaonKSNQQKoMVBWYRTlid7Z
	5KyogGNcV99DFXceck6aloyVNqJ/QzXnM9+E7wErV2Avkf3ZGUJ1REfUY6GYuCqjp8Jmd7ym9G+
	LuX3P+J9XyBASaZcpaLuQsn4qAIsZRxY5NX4cq4BHdL3x80YNi7Fa3wAyBeK3KucM6tmhmJs0Kj
	rSmJSIJ1ttML1L/FlWScLQchNU2bkehDOFaLAgZ4UT0LYH2L6CAb5My/pumH3hkF1vHYsi+3IAu
	NDFUSr8Zwuao/8MWT7e7Ge7N7ZZLQaEAb5rmYSzjg0AMTR3ZgfwUAEN2K48R2CFqbITFP7usBjC
	oI=
X-Received: by 2002:a05:6000:288b:b0:43d:7a97:78b5 with SMTP id ffacd0b85a97d-44bb5e2deb9mr1495268f8f.33.1777670466885;
        Fri, 01 May 2026 14:21:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8f51bac8sm7514313f8f.16.2026.05.01.14.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 14:21:06 -0700 (PDT)
Date: Fri, 1 May 2026 22:21:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan
 <shuah@kernel.org>, sdf.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/3] vsock: convert to getsockopt_iter
Message-ID: <20260501222105.747dea59@pumpkin>
In-Reply-To: <afTjvM1P4gjPSvW8@devvm29614.prn0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
	<20260501-getsock_one-v1-2-810ce23ea70e@debian.org>
	<afTjvM1P4gjPSvW8@devvm29614.prn0.facebook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 487944AFC93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[meta.com:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-283298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[debian.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,meta.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]

On Fri, 1 May 2026 10:32:44 -0700
Bobby Eshleman <bobbyeshleman@gmail.com> wrote:

> On Fri, May 01, 2026 at 08:52:52AM -0700, Breno Leitao wrote:
> > Convert AF_VSOCK's getsockopt implementation to use the new
> > getsockopt_iter callback with sockopt_t. The single
> > vsock_connectible_getsockopt() callback is shared by both
> > vsock_stream_ops and vsock_seqpacket_ops, so both proto_ops are
> > updated to use .getsockopt_iter.
> > 
> > Key changes:
> > - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> > - Use opt->optlen for buffer length (input) and returned size (output)
> > - Use copy_to_iter() instead of put_user()/copy_to_user()
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/vmw_vsock/af_vsock.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 44037b066a5ff..d4a97eeb596e6 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -155,6 +155,7 @@
> >  #include <linux/random.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/smp.h>
> > +#include <linux/uio.h>
> >  #include <linux/socket.h>
> >  #include <linux/stddef.h>
> >  #include <linux/sysctl.h>
> > @@ -2091,8 +2092,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> >  
> >  static int vsock_connectible_getsockopt(struct socket *sock,
> >  					int level, int optname,
> > -					char __user *optval,
> > -					int __user *optlen)
> > +					sockopt_t *opt)
> >  {
> >  	struct sock *sk = sock->sk;
> >  	struct vsock_sock *vsk = vsock_sk(sk);
> > @@ -2110,8 +2110,7 @@ static int vsock_connectible_getsockopt(struct socket *sock,
> >  	if (level != AF_VSOCK)
> >  		return -ENOPROTOOPT;
> >  
> > -	if (get_user(len, optlen))
> > -		return -EFAULT;
> > +	len = opt->optlen;
> >  
> >  	memset(&v, 0, sizeof(v));
> >  
> > @@ -2142,11 +2141,10 @@ static int vsock_connectible_getsockopt(struct socket *sock,
> >  		return -EINVAL;
> >  	if (len > lv)
> >  		len = lv;
> > -	if (copy_to_user(optval, &v, len))
> > +	if (copy_to_iter(&v, len, &opt->iter_out) != len)

I'd wrap that as copy_to_sockopt(&v, len, opt).
or to make the edits easier: copy_to_sockopt(opt, &v, len).
Then if someone decides to change the implementation none of the call
sites need changing.

-- David

> >  		return -EFAULT;
> >  
> > -	if (put_user(len, optlen))
> > -		return -EFAULT;
> > +	opt->optlen = len;
> >  
> >  	return 0;
> >  }
> > @@ -2631,7 +2629,7 @@ static const struct proto_ops vsock_stream_ops = {
> >  	.listen = vsock_listen,
> >  	.shutdown = vsock_shutdown,
> >  	.setsockopt = vsock_connectible_setsockopt,
> > -	.getsockopt = vsock_connectible_getsockopt,
> > +	.getsockopt_iter = vsock_connectible_getsockopt,
> >  	.sendmsg = vsock_connectible_sendmsg,
> >  	.recvmsg = vsock_connectible_recvmsg,
> >  	.mmap = sock_no_mmap,
> > @@ -2653,7 +2651,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
> >  	.listen = vsock_listen,
> >  	.shutdown = vsock_shutdown,
> >  	.setsockopt = vsock_connectible_setsockopt,
> > -	.getsockopt = vsock_connectible_getsockopt,
> > +	.getsockopt_iter = vsock_connectible_getsockopt,
> >  	.sendmsg = vsock_connectible_sendmsg,
> >  	.recvmsg = vsock_connectible_recvmsg,
> >  	.mmap = sock_no_mmap,
> > 
> > -- 
> > 2.52.0
> >   
> 
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 


