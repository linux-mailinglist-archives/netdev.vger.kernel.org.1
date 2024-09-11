Return-Path: <netdev+bounces-127199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683039748B0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA428765A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8D237708;
	Wed, 11 Sep 2024 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECG9+eYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66BF4ED
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025653; cv=none; b=KgvdwHL9NDOxOyIZp1rfwPXS9+bet6SWkF2Eeh2AR2JX5y/vcY+fAYCKyH2ChLA+wyR1punqMFXQfYOC9E3a43HjCPKumVJszxzyGxAJ4V+Dmq58ls1EYGe6ieVkT44I/y/6RZs1IvBCu78ibLSqyo3aELSM/LmbGvWMwsceNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025653; c=relaxed/simple;
	bh=HHeYKyQ6fspnFYEPiocFqOqD2LHxRVcf60fOmRJcJSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnIX6C7eKqK4txqz/1Cr6qqcTK5L9Y+u1xES5SP1qHhkQmV4On/O3380pzO/qHrsVyFg5G2a4CbNIL7OSCOwXUYTwfv3Gp22oSXCQTEqIg0viiYoD3lPxCj8jc9gL7piV6z919MMiy2CKQaUOphIsgPxdGQPGNGcKyg+Fuaunjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECG9+eYg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7191f58054aso10763b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726025651; x=1726630451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUVoHKGlPio5WpGlEQsdtYcRALopvDTSYpm/OJHaHec=;
        b=ECG9+eYgz8kKAJaD0Ln74MMiqxKlfnyGmxLmSlPclKF3CkXZC3mrTSHs/ZnNH3JENx
         UWPRnvwCCjofwRN2vJAqknzDyNkDtp/ANOdhM/eNLic7nVleDWB280z02sm/hbZ3jwMF
         GLNOWmCokLf8p5z3LFXjC5/62qSSgftNbgDf86Ws7BKgvnk40W2iMNAyIkgiaxe8ISOx
         3Ufw5IitQ5Bng2LQkBcg/SL2TCGGqfInSPU/GFOWmnIOnioo0nMYg+hegN49FRuxDOqt
         TXw7eB7skmjok47fIClmAZAhbhws77Ck5BOSyb8lAiCwAvapE/tEa0y6d5mOg4BDwsgq
         816g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726025651; x=1726630451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUVoHKGlPio5WpGlEQsdtYcRALopvDTSYpm/OJHaHec=;
        b=CIp2PgocLznMjnbNQXiA1JBBRU7+eNWPeACpEGKMdX9MkVia4ygXEsWiRDOCFCHQ6n
         VlZHWOmfbvJ9Ik6G7tf4j5cAGsHkW9q3opeELpdiLJJdxvet9TggoJRWQazqqn+2wlYi
         jPTOhWzzcmb0JC+TZIGuiQRw+Mr12jGs+YXtn6khc13Da81w8eogUMYhxOihI5RWEwTP
         otaDtckk9Nl7xIg9MSZ3iqkBnW1w1ib7YtpenGabwE8SSdwjg6lzMewwUuGgv0s46Kpd
         toef6a2qiVbuLkdnPGCkitE6XlHGZC8a/xoXZZBD173AqeD5i++D0OYHz88R6o4AkHQn
         fGkQ==
X-Gm-Message-State: AOJu0YzsdjBo1+htKUbjOnRyHI6CMr89Lbtp+VYhreUHDh2ruArtIgb3
	0oqeaewA1OJ68qXtLWG+B9u+KiEJl8kc05B46Q6jwbSiQufw6B7o
X-Google-Smtp-Source: AGHT+IFqsXw5JhcsGFJE6xUk1B3NgiBxoHWYgm7ulIwzopxLQtwKLx+I+Ih2tZiTQwMf2s5u9RIhxA==
X-Received: by 2002:a05:6a20:d521:b0:1cf:4572:867 with SMTP id adf61e73a8af0-1cf62d5734bmr2527010637.33.1726025651066;
        Tue, 10 Sep 2024 20:34:11 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:7cb4:335c:8e84:436f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8255dc167sm5467891a12.71.2024.09.10.20.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 20:34:10 -0700 (PDT)
Date: Tue, 10 Sep 2024 20:34:09 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [Patch net] mptcp: initialize sock lock with its own lockdep keys
Message-ID: <ZuEPsZ3yrLqHNRUt@pop-os.localdomain>
References: <20240908180620.822579-1-xiyou.wangcong@gmail.com>
 <c332e3f8-3758-43ce-87a7-f1290d9692bc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c332e3f8-3758-43ce-87a7-f1290d9692bc@kernel.org>

On Mon, Sep 09, 2024 at 05:03:32PM +0200, Matthieu Baerts wrote:
> Hi Cong Wang,
> 
> On 08/09/2024 20:06, Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > In mptcp_pm_nl_create_listen_socket(), we already initialize mptcp sock
> > lock with mptcp_slock_keys and mptcp_keys. But that is not sufficient,
> > at least mptcp_init_sock() and mptcp_sk_clone_init() still miss it.
> > 
> > As reported by syzbot, mptcp_sk_clone_init() is challenging due to that
> > sk_clone_lock() immediately locks the new sock after preliminary
> > initialization. To fix that, introduce ->init_clone() for struct proto
> > and call it right after the sock_lock_init(), so now mptcp sock could
> > initialize the sock lock again with its own lockdep keys.
> 
> Thank you for this patch!
> 
> The fix looks good to me, but I need to double-check if we can avoid
> modifying the proto structure. Here is a first review.
> 
> 
> From what I understand, it looks like syzbot reported a lockdep false
> positive issue, right? In this case, can you clearly mention that in the
> commit message, to avoid misinterpretations?
> 
> > Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
> 
> checkpatch.pl reports that "Reported-by: should be immediately followed
> by Closes: with a URL to the report".

Sure, didn't know this is helpful.

> 
> Also, even if it is a false positive, it sounds better to consider this
> as a fix, to avoid having new bug reports about that. In this case, can
> you please add a "Fixes: <commit>" tag and a "Cc: stable" tag here please?

I intended not to provide one because I don't think this needs to go to
-stable, it only fixes a lockdep warning instead of a real deadlock.
Please let me know if you prefer to target -stable.

> 
> > Cc: Matthieu Baerts <matttbe@kernel.org>
> > Cc: Mat Martineau <martineau@kernel.org>
> > Cc: Geliang Tang <geliang@kernel.org>
> 
> (If a new version is needed here, feel free to remove the Netdev ML from
> the CC list, and only add the MPTCP ML: we can apply this patch on MPTCP
> side first, and send it to Netdev later, when it will be ready and
> validated)

OK.

> 
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > ---
> >  include/net/sock.h     |  1 +
> >  net/core/sock.c        |  2 ++
> >  net/mptcp/pm_netlink.c | 18 ++++++++++++------
> >  net/mptcp/protocol.c   |  7 +++++++
> >  net/mptcp/protocol.h   |  1 +
> >  5 files changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index cce23ac4d514..7032009c0a94 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1226,6 +1226,7 @@ struct proto {
> >  	int			(*ioctl)(struct sock *sk, int cmd,
> >  					 int *karg);
> >  	int			(*init)(struct sock *sk);
> > +	void			(*init_clone)(struct sock *sk);
> >  	void			(*destroy)(struct sock *sk);
> >  	void			(*shutdown)(struct sock *sk, int how);
> >  	int			(*setsockopt)(struct sock *sk, int level,
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 9abc4fe25953..747d7e479d69 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2325,6 +2325,8 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
> >  	}
> >  	sk_node_init(&newsk->sk_node);
> >  	sock_lock_init(newsk);
> > +	if (prot->init_clone)
> > +		prot->init_clone(newsk);
> 
> If the idea is to introduce a new ->init_clone(), should it not be
> called ->lock_init() (or ->init_lock()) and replace the call to
> sock_lock_init() when defined?

'lock_init' or 'init_lock' reads like we are initalizing a lock. :)

> 
> >  	bh_lock_sock(newsk);
> >  	newsk->sk_backlog.head	= newsk->sk_backlog.tail = NULL;
> >  	newsk->sk_backlog.len = 0;
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index f891bc714668..5f9f06180c67 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -1052,10 +1052,20 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> >  static struct lock_class_key mptcp_slock_keys[2];
> >  static struct lock_class_key mptcp_keys[2];
> >  
> > +void mptcp_sock_lock_init(struct sock *sk)
> 
> If this helper is used by different parts in MPTCP, I think it would be
> better to move it (and the associated keys) to protocol.c: such helper
> is not specific to the Netlink path-manager, more to MPTCP in general.

Sure, if you don't mind more lines of changes.

> 
> > +{
> > +	bool is_ipv6 = sk->sk_family == AF_INET6;
> > +
> > +	sock_lock_init_class_and_name(sk,
> > +				is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> > +				&mptcp_slock_keys[is_ipv6],
> > +				is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> > +				&mptcp_keys[is_ipv6]);
> 
> The alignment is not OK, and checkpatch.pl is complaining about that.
> Can you keep the same indentation as it was before please?

Sure, sorry for missing this.

> 
> > +}
> > +
> >  static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> >  					    struct mptcp_pm_addr_entry *entry)
> >  {
> > -	bool is_ipv6 = sk->sk_family == AF_INET6;
> >  	int addrlen = sizeof(struct sockaddr_in);
> >  	struct sockaddr_storage addr;
> >  	struct sock *newsk, *ssk;
> > @@ -1077,11 +1087,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> >  	 * modifiers in several places, re-init the lock class for the msk
> >  	 * socket to an mptcp specific one.
> >  	 */
> 
> Please also move this comment above to the new mptcp_sock_lock_init()
> function.

OK.

> 
> > -	sock_lock_init_class_and_name(newsk,
> > -				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> > -				      &mptcp_slock_keys[is_ipv6],
> > -				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> > -				      &mptcp_keys[is_ipv6]);
> > +	mptcp_sock_lock_init(newsk);
> >  
> >  	lock_sock(newsk);
> >  	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 37ebcb7640eb..ce68ff4475d0 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2839,6 +2839,7 @@ static int mptcp_init_sock(struct sock *sk)
> >  	int ret;
> >  
> >  	__mptcp_init_sock(sk);
> > +	mptcp_sock_lock_init(sk);
> >  
> >  	if (!mptcp_is_enabled(net))
> >  		return -ENOPROTOOPT;
> > @@ -2865,6 +2866,11 @@ static int mptcp_init_sock(struct sock *sk)
> >  	return 0;
> >  }
> >  
> > +static void mptcp_init_clone(struct sock *sk)
> > +{
> > +	mptcp_sock_lock_init(sk);
> > +}
> > +
> >  static void __mptcp_clear_xmit(struct sock *sk)
> >  {
> >  	struct mptcp_sock *msk = mptcp_sk(sk);
> > @@ -3801,6 +3807,7 @@ static struct proto mptcp_prot = {
> >  	.name		= "MPTCP",
> >  	.owner		= THIS_MODULE,
> >  	.init		= mptcp_init_sock,
> > +	.init_clone	= mptcp_init_clone,
> 
> If 'mptcp_sock_lock_init()' is moved in this file, and 'init_clone' is
> renamed to 'lock_init', maybe directly use 'mptcp_sock_lock_init' here?

Sounds better.

> 
> >  	.connect	= mptcp_connect,
> >  	.disconnect	= mptcp_disconnect,
> >  	.close		= mptcp_close,
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 3b22313d1b86..457c01eac25f 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -1135,6 +1135,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
> >  
> >  void __init mptcp_pm_nl_init(void);
> >  void mptcp_pm_nl_work(struct mptcp_sock *msk);
> > +void mptcp_sock_lock_init(struct sock *sk);
> 
> (if the definition is moved to protocol.c, please also move it elsewhere
> here, e.g. around mptcp_sk_clone_init())

Got it.

Thanks.

