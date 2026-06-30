Return-Path: <netdev+bounces-303144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b5jGMNOzQ2rSfQoAu9opvQ
	(envelope-from <netdev+bounces-303144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:17:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E5F6E414A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:17:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=CX2oM8FO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303144-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303144-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12145301C6D4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3BF31E82A;
	Tue, 30 Jun 2026 12:17:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4250408633
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:17:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821840; cv=none; b=NtNks6KilCFdWVOKHL/ydZkOhLPuz1oZ2lRV7OZJW2QI2My/DUfquLsBej1sngyBec8GA8tF7VooDvuNGT9F+l2D6vVCeOR0QrJLU4leC/6LeTIwtd1fU/kqlVlGHx4S7jjYGifDZV+soLbWc2MEweDjq4CPNbXGrT/WV9lkJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821840; c=relaxed/simple;
	bh=pVFWRdmduSXd0EI7LOQGs6oToijJeU2YlwTDktUqB6Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NIsu7eJ3YTHSaSBTHptkcNw6RiaIJZrwehaQxOJYtlbXD17og/XTdYWxkQjonfslYaf8Zafi6QoAkqyAyqsX1Td7n1Rw2gmyrGU1QXDIvOAesUj4cczG2J8iRoXqW59u4OSLP0Zze/UXkPwsGcsxm2/4NYt40EaoS/4EN9x4Eyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=CX2oM8FO; arc=none smtp.client-ip=195.121.94.184
X-KPN-MessageId: a0bcb971-747d-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a0bcb971-747d-11f1-a59f-005056994fde;
	Tue, 30 Jun 2026 14:17:14 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id a0bb8d43-747d-11f1-9b04-00505699693e;
	Tue, 30 Jun 2026 14:17:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=HoaUdutcVjzwLlkWs3t1/fLAplllrYSdfUovTEYFf/Y=;
	b=CX2oM8FOasD0LfV3NG0GB1BEtOiD5etbHQ102TrTCs2sdn1v5oZjpYfgXP2K+8/RNa0KZSkqeiS7Z
	 C7cALcGK9hTBDTsedhZF8GJ1koenP1tpFwxr7Bw31ELas6lyKmycYiXwWKo0OHN7WbX3bVQoAYyTLJ
	 IlYGxzT5baFjdqPy8pewhUXe3twRzF4zWyT1mkxvI2B7BtKSjjarp0a3ABeDsHhq1d5sXvgeY0GUIv
	 5aS+kp1VdCZ5qTE0fLCQhY4DSmiOXSIlOzZR8qo4x/qAU0SOTd8HIe8VXW3Sf39BURsoleV0OYPZG8
	 T1vDwajXGn7LRj187TIRlJ1pVk3JNRQ==
X-KPN-MID: 33|OFYpm1P/Nt8SYcBlYsmaTYPF0qERzll8sV44nr1wrEwv67WCimJpjCHdRix9Bgq
 eFOVIbIJJTMgaVKU/aaBroU+a/AOj08YJYFo9cdM8Ec4=
X-CMASSUN: 33|OrooBAzrv2xmU0EZVbA0G0ujgPElX0jqUXaNl7wbv+rPuDBb+5DvFwarGO7uX0S
 M5qNHL3Z8Itq/9C6FeSXZog==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id a0abbb1e-747d-11f1-8edb-00505699eff2;
	Tue, 30 Jun 2026 14:17:14 +0200 (CEST)
Date: Tue, 30 Jun 2026 14:17:14 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <158151977.3525022.1782821834050@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260630-getoppt-granit-gekrochen-78244e8979d9@brauner>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
 <20260629194327.2270798-4-jkoolstra@xs4all.nl>
 <20260630-getoppt-granit-gekrochen-78244e8979d9@brauner>
Subject: Re: [PATCH net-next v3 3/5] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51E5F6E414A


> Op 30-06-2026 11:58 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> > Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> > receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> > that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> > highly problematic behaviour, because it leaves the receiver
> > wondering what happened. As per man page MSG_CTRUNC is supposed to
> > indicate that the control buffer was sized too short, but suddenly
> > a permission error might result in the exact same flag being set.
> > Moreover, the receiver has no chance to determine how many fds got
> > originally sent and how many were suppressed.[1]
> > 
> > Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> > handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> > truncating the message at the first blocked fd, keep every fd slot
> > and store the LSM errno in the blocked slot.
> > 
> > [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> >
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index 34f53dde65ce..bb1b3dee02e8 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -49,6 +49,7 @@ struct unix_sock {
> >  	struct scm_stat		scm_stat;
> >  	int			inq_len;
> >  	bool			recvmsg_inq;
> > +	bool			scm_rights_notrunc;
> >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> >  	struct sk_buff		*oob_skb;
> >  #endif
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index c52519669349..761cda0803fb 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -50,8 +50,8 @@ struct scm_cookie {
> >  #endif
> >  };
> >  
> > -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> > -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
> > +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
> > +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
> >  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
> >  void __scm_destroy(struct scm_cookie *scm);
> >  struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
> > @@ -108,11 +108,18 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
> >  		   struct scm_cookie *scm, int flags);
> >  
> >  static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> > -				  unsigned int flags)
> > +				  unsigned int flags, bool notrunc)
> >  {
> > +	bool filtered;
> > +	int error;
> > +
> >  	if (!ufd)
> >  		return -EFAULT;
> > -	return receive_fd(f, ufd, flags);
> > +
> > +	error = receive_fd_filtered(f, ufd, flags, &filtered);
> > +	if (filtered && notrunc)
> > +		return put_user(error, ufd);
> 
> This helper makes no sense to me. The boolean return argument is just
> really nasty and you need an additional put_user() as well. At this
> point, just drop receive_fd() and open-code it instead of using another
> custom helper. Something like the completely untested:
> 

It's not very pretty no. I thought about several different options but they
all kinda suck.

You could override the error returned from the LSM to -EACCES. Since nothing
else in receive_fd() produces this, if you get it you can be sure that you had
an LSM fd block. However, this masks the real returned error and is also a bit
fragile if receive_fd() does ever return -EACCES in another path (unlikely but still).
You can also signal blocking by setting the ufd to the security_file_receive() error
no matter the socket option. But this does change userspace.

But open-coding might be a better idea.

I also choose to not put -EPERM as sentinel as suggested first, but use the
actual LSM error. Agreed?


> diff --git a/include/net/scm.h b/include/net/scm.h
> index 761cda0803fb..171b5ccd0b77 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -116,10 +116,22 @@ static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
>         if (!ufd)
>                 return -EFAULT;
> 
> -       error = receive_fd_filtered(f, ufd, flags, &filtered);
> -       if (filtered && notrunc)
> -               return put_user(error, ufd);
> -       return error;
> +       error = security_file_receive(file);
> +       if (error)
> +               return notrunc ? put_user(error, ufd) : error;
> +
> +       FD_PREPARE(fdf, flags, f);
> +       if (fdf.err)
> +               return fdf.err;
> +       get_file(f);
> +
> +       error = put_user(fd_prepare_fd(fdf), ufd);
> +       if (error)
> +               return error;
> +
> +       __receive_sock(f);
> +       return fd_publish(fdf);
>  }
> 
> -- 
> Christian Brauner <brauner@kernel.org>

