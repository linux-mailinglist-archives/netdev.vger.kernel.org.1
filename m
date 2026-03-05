Return-Path: <netdev+bounces-264169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNhSCKv3qGktzwAAu9opvQ
	(envelope-from <netdev+bounces-264169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:25:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2520A818
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F1843044BA8
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3182741A0;
	Thu,  5 Mar 2026 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtuOuPXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943E270540
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681127; cv=none; b=htyy+5xDKaTO0avjJYbQwpOTMa2gzrpNVQIRZIRa0GyWGYI6IXHyz86acaKSitk2mTEJfDtpRD5tmPcf2hLtQMgdAxyMmVxW7jVWUGTe7r3CtGb69f6vaMgAP3fLlK/XAwJLHnOH2dUNalQnOGpcN9akhXYvB69a3HgEfKrOGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681127; c=relaxed/simple;
	bh=8cdCwzcIZiM0RhwEFVpTwVIxqlCZ8nO9R/03FJa2cw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZFiNCW0GmJnLFEjRFmpvbPYdh+94X2N9YVKmKEZASK5i+/M/5htmviqETbImLsFzCVy/WZfBZzRWdeDDQ+BNGhKwxZKyCIszxgA0TBTehpb3ZSdI7AEATybwue68Pf41GPWqPTN+KsYOm2bERolhfjy9pXd2W5F+ugkOkUeKQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtuOuPXp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae3badc00dso52499895ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 19:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772681126; x=1773285926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRSnHe4WXc8o31JrOkZ13HKREi6iZmJPPXA9ncj7Loc=;
        b=vtuOuPXp9/KvI5vE4BXBAGeKX7uuCoJSerZydzG+3003sGmR3yI3cqnWR2NuJAgekl
         airMPJ2FFweSNFK1Kf32qMsj65ThvwDdHP9Txjj6/UeOPh0KxE3QBkiyuZ/KPp7b73W8
         C0daqXfkVo9d4Ux7SJ32mKCbghgcsRXyZWfiBkiVmLTC2oz7Ac3pGT1cr4ic/gvzDvHf
         Kn8Un8Lop54RZoksfV9aTeO1xaSp23oTBxGPmEQ8T2/OMnHMGSqtNYpLo1CAwKO+SsXq
         C0UuhhXbsAm8XUDZpsmCob0n3GKG7h/Rx+fQL05TrsD8PeDEnPozbx8hw7zEFhuUr67p
         Q9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772681126; x=1773285926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRSnHe4WXc8o31JrOkZ13HKREi6iZmJPPXA9ncj7Loc=;
        b=kDj6HaomjzK9lYubp2adds6u5nUh5fqDoLMx4cc/E1DFriHe65M04Zdd+W3lHnEJGE
         wXx0RCEufl+HLP2x2aGEQBr9O85aXVaUlAtwTWO/W/CYGW9DYLod+DkyzIr0BN7dg1dq
         QcA+Sr420zs/4mVnvB3FL83jdWjD1SbntsWjzELtKC9L+TBhS+N0mlvAT0Np6uezEOav
         FSrIbLL+4CtbKjV7yNtGgg0Aa8HhfP3WKk7E0rbmhBCWGNwpQbxWtn27CDsLJbD9WNaO
         fw7//7wnQjsVhhhX+bqNJZPcz3VIZJk1CPJT74BLgfu6Z8X9z5KIi5qfMRisauS9OsmT
         537A==
X-Forwarded-Encrypted: i=1; AJvYcCVhuxnXjxoShO0boJ2w8pCGiqMSeGcEtq9CU8XiXdJaMxuhm0r0FeKY6byGtfHqAOKI8X/tzkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkEKLnNY1OpMssSR7t76w/gC/s/rAMIJLlsbJOOffthdQyllT
	3Ed+7yxh++C+G1L7GrS4rxTEqZ7UzHxtLzFxW4ERDqsFeKiv+aNkl/KIhxt4qkbWAxnB6+f6EF7
	DxcCHEw==
X-Received: from pgc6.prod.google.com ([2002:a05:6a02:2f86:b0:c73:7d8e:b5d6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf07:b0:2ae:6192:8da4
 with SMTP id d9443c01a7336-2ae6aa0fd9bmr46707585ad.2.1772681125409; Wed, 04
 Mar 2026 19:25:25 -0800 (PST)
Date: Thu,  5 Mar 2026 03:25:21 +0000
In-Reply-To: <skxd6uimyxzi4x5nfmz24ez3d45qiubdnwkqawtbomjfzy5qrs@yb724ykvvkec>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <skxd6uimyxzi4x5nfmz24ez3d45qiubdnwkqawtbomjfzy5qrs@yb724ykvvkec>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305032524.2176479-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on abort
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jrife@google.com
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	edumazet@google.com, kuba@kernel.org, kuniyu@google.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, willemdebruijn.kernel@gmail.com, 
	yusuke.suzuki@isovalent.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 74C2520A818
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,google.com,linux.dev,fomichev.me,gmail.com,isovalent.com];
	TAGGED_FROM(0.00)[bounces-264169-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,isovalent.com:email]
X-Rspamd-Action: no action

From: Jordan Rife <jrife@google.com>
Date: Wed, 4 Mar 2026 23:52:22 +0000
> On Wed, Mar 04, 2026 at 09:21:03PM +0000, Kuniyuki Iwashima wrote:
> > From: Jordan Rife <jrife@google.com>
> > Date: Tue,  3 Mar 2026 17:01:02 +0000
> > > Currently, udp_abort() invokes __udp_disconnect() which clears out
> > > socket fields like inet_daddr and inet_dport. This makes fields like
> > > dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
> > > hooks following an abort on a connected UDP socket, since they'll always
> > > equal zero. This differs from the behavior for TCP sockets where a
> > > cgroup/sock_release hook will see the address and port that the socket
> > > was connected to at the time it was aborted. This causes issues in
> > > Cilium where a sock_release hook is used to perform map maintenance when
> > > sockets are released, since Cilium actively destroys connected UDP
> > > sockets in some cases.
> > 
> > Just curious why Cilium does not unregister the socket just
> > after aborting it ?
> > 
> > At least Cilium should know the key at that moment.
> 
> Originally, socket aborts in Cilium were handled with sock_diag (and
> still are on older kernels), so you'd need to do some map maintenance in
> userspace directly before or after aborting the socket. I suppose it was
> just cleaner to put common cleanup code in a sock_release hook.
> 
> > > 
> > > Make the behavior consistent between TCP and UDP sockets by not clearing
> > 
> > This patch makes another inconsistency with TCP.
> > 
> > As you mentioned in the cover letter, before the patch, even if
> > aborted, a bound socket still reserves a port, but it does not now.
> > 
> > This might be surprising for non-reuseaddr/port sockets.
> 
> Yeah, true. I'm curious if this behavior is something that is useful at
> all or simply an accident of the current implementation? If I'm
> aborting/destroying a socket, why should it hold onto bound ports until
> the socket is closed? I wasn't quite sure about this.

Digging into the first (long) thread of SOCK_DESTROY (TCP),
the motivation was to kill sockets bound to an IP address
that Android/laptop removes when it switches networks.
https://lore.kernel.org/netdev/1447811024-8553-1-git-send-email-lorenzo@google.com/

In that sense, holding a port seems unnecessary.

But there are a few concerns like

  * someone could use the feature for server and reuse port
    too quickly.
    https://lore.kernel.org/netdev/1447879416.562854.443622857.62708268@webmail.messagingengine.com/

  * it's a bit worrisome if this feature is viewed as a way for
    resouce management.
    https://lore.kernel.org/netdev/CALx6S35Q_pc-vBNpA0hipn5K-vSmPDsV-V=D13sODESNO7Htdw@mail.gmail.com/

Considering these, it seems fair to only notify an error
via epoll or blocked syscall and let the application to
close() sockets.

In a thread, the author mentioned this :

---8<---
Its purpose is to interrupt
blocked userspace socket calls, not to release resources.
---8<---
https://lore.kernel.org/netdev/CAKD1Yr0Gpr6Ex2i1TXEWyETn48P4g5vBvFZ9=_g+Lz_7-PqBDQ@mail.gmail.com/

Also, there was an assumption that a sane application will
close() sockets after receiving errors.
https://lore.kernel.org/netdev/1447972381.22599.278.camel@edumazet-glaptop2.roam.corp.google.com/

And yes, this does not apply to UDP, and sadly UDP patch's
thread has no such context nor discussion.
https://lore.kernel.org/netdev/?q=udp_abort&o=-1

But anyway, now I think we can solve your problem more
easily, see below.


> 
> > > out these fields in udp_abort(). Instead, just unhash the socket, mark
> > > its state as TCP_CLOSE, and preserve the state of the other fields.
> > > 
> > > Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
> > > Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> > > Signed-off-by: Jordan Rife <jrife@google.com>
> > > ---
> > >  net/ipv4/udp.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index b96e47f1c8a2..01a0a0fbcd56 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
> > >  
> > >  	sk->sk_err = err;
> > >  	sk_error_report(sk);
> > > -	__udp_disconnect(sk, 0);
> > 
> > How about passing another flag and avoid unwanted init only for
> > bpf iterator ?  This will need another layer of __udp_disconnect()
> > like ____udp_disconnect() (I'm not good at naming), or must make
> > sure the flag is never used in uAPI.
> 
> To make sure we're on the same page about what you're describing, I'm
> imagining:
> 
> static int ___udp_disconnect(struct sock *sk, int flags, bool reinit)
> {                                                 
> 	same as before, but if reinit == false then avoid reinitializing
> 	fields like daddr/dport while holding onto reserved ports
> }
> 
> int __udp_disconnect(struct sock *sk, int flags)
> {
> 	___udp_disconnect(sk, flags, true);
> }
> 
> ...
> 
> int udp_abort(struct sock *sk, int err)
> {
> 	...
> 	___udp_disconnect(sk, flags, false); <--- set reinit arg to false
> 	...
> }
> 
> This would have the same behavior with regards to reserved ports
> following udp_abort() while preserving fields like daddr. I was
> considering something like this initially, but it wasn't clear to me why
> you'd want to hold onto reserved ports if the socket was destroyed as I
> mentioned above. If it's important to maintain that aspect of the
> behavior, then I'm OK with this approach.

This was what's in my mind, but probably we could just avoid
the initialisation:

---8<---
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ce49ed2bd36f..d44be0020446 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2213,21 +2213,21 @@ int __udp_disconnect(struct sock *sk, int flags)
 	 */
 
 	sk->sk_state = TCP_CLOSE;
-	inet->inet_daddr = 0;
-	inet->inet_dport = 0;
 	sock_rps_reset_rxhash(sk);
 	sk->sk_bound_dev_if = 0;
-	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
-		inet_reset_saddr(sk);
-		if (sk->sk_prot->rehash &&
-		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK))
-			sk->sk_prot->rehash(sk);
-	}
 
 	if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
 		sk->sk_prot->unhash(sk);
-		inet->inet_sport = 0;
+	} else if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
+		if (sk->sk_prot->rehash &&
+		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
+			inet_reset_saddr(sk);
+			inet->inet_daddr = 0;
+			inet->inet_dport = 0;
+			sk->sk_prot->rehash(sk);
+		}
 	}
+
 	sk_dst_reset(sk);
 	return 0;
 }
---8<---

When we need to rehash(), of course we have to clear
saddr/daddr/dport, but otherwise, we don't, even sport.

When ->unhash()ed, only thing we need to do is to clear
inet_sk(sk)->inet_num.

Then, even if bind() and connect() are called later, it
works because each syscall does not care about the old
saddr/sport/daddr/dport and just assign a new value if
inet->inet_num == 0.

This seems a bit fragile, but TCP already relies on it and
it's unlikely that we change the behaviour in __inet_bind(),
inet_autobind(), and inet_dgram_connect().

And all the other users of __udp_disconnect() are also
AF_INET or AF_INET6, l2tp, ping, raw.


> 
> > 
> > 
> > 
> > > +	sk->sk_state = TCP_CLOSE;
> > > +	sk->sk_prot->unhash(sk);
> > > +	sk_dst_reset(sk);
> > >  
> > >  out:
> > >  	if (!has_current_bpf_ctx())
> > > -- 
> > > 2.53.0.473.g4a7958ca14-goog
> > > 
> 
> Thanks!
> 
> Jordan

