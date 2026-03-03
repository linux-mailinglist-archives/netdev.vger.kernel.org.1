Return-Path: <netdev+bounces-263045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGvQHIlqpmlRPgAAu9opvQ
	(envelope-from <netdev+bounces-263045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:58:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1811E9154
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83F9E3036051
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0574C363092;
	Tue,  3 Mar 2026 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSGIzdxy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CEA33D6E1
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 04:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513926; cv=none; b=QVMYq+m9KbMdmfxWN8kCd2j8dQrKdurYv0JtYt11I6OgCCZakZE5wAmeh/b4VZ2jyy+iSBjdjnT2lW3tbU8ZO8SVXMu9mf5k7cD4Zaui76J570o2y/ZYi/rYc0M/equ/iYB2vOZukQSVppDt4/zuHiMjGZFQJI+Eqh3TrCWZFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513926; c=relaxed/simple;
	bh=MLijZltdYn2qKLwdhHXsjHj0ESws9gHre3WVaIpQMYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kswZxhxr6ryLAtrHGxOQNzpiV1H999q3jI+E3mpPbG/eEcM9L18ORJ53dAjY0GTvd+i9GLNogccDOl6YH39e9D+HyGzCYvu85oGeW4qKbmBTKBhIFR/Ny1tjkJjoQF16igVEAk872csab57tTVf1ljsnln9tPInN1PRSjREUZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSGIzdxy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so20368784a12.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 20:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772513925; x=1773118725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRWOrF0OKB/6HzzweINABM3BRNNDLcqTVH4nz70RkNQ=;
        b=BSGIzdxyZy2AbMzKgxihkMXDgwLEwGr8bW1PIjL0KOYEMbr4HVzBhJimkHy/sxIzKv
         6b3WE7zCj23LfPHB8U2PKBxJ0L9jlSSaM7IZ0N2QG9JyeVSLmAta7cdiK5xoDGkVGlWy
         H1uwgom3vhldLzhPMwQ88pUjreKUthfmP02CL4A0EFedgYesuOsDa+Z2rLjapJlFmlDA
         3UDtEemuVVHHjzhRm4fZQ3M1AUTtichjUHZstXPHGRT1gxWmX0OOHHLzJPdQFS0aGmNp
         joeAvBYQKprJaa1wnsl24tA4Paj1nyAI0FhIAiVfd4w/O1N0fv7l6NDGHSgAe/1OBYX6
         xuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772513925; x=1773118725;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CRWOrF0OKB/6HzzweINABM3BRNNDLcqTVH4nz70RkNQ=;
        b=qfg2AYx+2djBGoh4Vw4t9kjWeLkaKS1g42gPd7tKsT54B6ogDZVGNdgF3H9sQbCgq4
         7bHV8PztcNYRGRRVwcP2lQHN8mtpDuPbLsIefWMYg8gQJ+QxE/O4UVrtn60a6wH6Bwj6
         gXrbe/j4dDjqg4Q/YM9Pv1q6/q0TaOTEh8F0ysZUCmGmeDTfXCyWwlKPljcqWLnM7jui
         aPibmLTC1zaG9dirTYuVeF9Xccb4BfO7BmWAFsuahQCy0HrVhSBGFhUfY42xepGx5N09
         i+kn6m8j+1aOtKVs4KOCYUXedH0SSZQ7qr15kAf5SyxUvVx1eJtZSND4OdjtAs2iWwY8
         TiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEvrNvibuSws5LQLs5gIgN4gzu175xxCPrA8mDV/1YO4Yb7wlaj8ctpXqwT84yiSbvOyCFmwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOt1V6+t9TifLwPTdfIdiPnBOzhRq0Pienc0YCqbDQLOLbadLm
	Mgem6tJRf3YSuz08tPWVBWpLelqPM9kXnB+e936KmP+qBWxrFfslUjld22dbZwgO3EFyJohK9z+
	yCR1fBw==
X-Received: from pgam6.prod.google.com ([2002:a05:6a02:2b46:b0:bc3:ac3:8769])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d703:b0:38d:fad1:cf36
 with SMTP id adf61e73a8af0-395c39eeba4mr13438541637.9.1772513924885; Mon, 02
 Mar 2026 20:58:44 -0800 (PST)
Date: Tue,  3 Mar 2026 04:58:29 +0000
In-Reply-To: <CANn89i+5gC3Wr2jAOG0=Sp1H2tJ7_ZufHcp1B7t7SdfgY+JmeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANn89i+5gC3Wr2jAOG0=Sp1H2tJ7_ZufHcp1B7t7SdfgY+JmeA@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303045843.1732769-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next] tcp: Initialise ehash secrets during
 connect() and listen().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: edumazet@google.com
Cc: davem@davemloft.net, horms@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CF1811E9154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,gmail.com,google.com,vger.kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263045-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 04:42:24 +0100
> On Mon, Mar 2, 2026 at 9:51=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > inet_ehashfn() and inet6_ehashfn() initialise random secrets
> > on the first call by net_get_random_once().
> >
> > While the init part is patched out using static keys, with
> > CONFIG_STACKPROTECTOR_STRONG=3Dy, this causes a compiler to
> > generate a stack canary due to an automatic variable,
> > unsigned long ___flags, in the DO_ONCE() macro being passed
> > to __do_once_start().
> >
> > With FDO, this is visible in __inet_lookup_established() and
> > __inet6_lookup_established() too.
> >
> > Let's move net_get_random_once() to the slow paths: inet_hash()
> > for listen(), and inet_hash_connect() and inet6_hash_connect()
> > for connect().
> >
> > Note that IPv6 listener will initialise both IPv4 & IPv6 secrets
> > in inet_hash() for IPv4-mapped IPv6 address.
> >
> > With the patch, the stack size is reduced by 16 bytes (___flags
> >  + a stack canary) and NOPs for the static key go away.
> >
> > Before: __inet6_lookup_established()
> >
> >
> >
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/inet6_hashtables.h |  2 ++
> >  net/ipv4/inet_hashtables.c     | 16 ++++++++++++++--
> >  net/ipv6/inet6_hashtables.c    | 11 ++++++++---
> >  3 files changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtab=
les.h
> > index 282e29237d93..c17e0d874808 100644
> > --- a/include/net/inet6_hashtables.h
> > +++ b/include/net/inet6_hashtables.h
> > @@ -24,6 +24,8 @@
> >
> >  struct inet_hashinfo;
> >
> > +void inet6_init_ehash_secret(void);
> > +
> >  static inline unsigned int __inet6_ehashfn(const u32 lhash,
> >                                     const u16 lport,
> >                                     const u32 fhash,
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index fca980772c81..2c2cac5b0f1a 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -30,12 +30,15 @@
> >  #include <net/sock_reuseport.h>
> >  #include <net/tcp.h>
> >
> > +static void inet_init_ehash_secret(void)
> > +{
> > +       net_get_random_once(&inet_ehash_secret, sizeof(inet_ehash_secre=
t));
> > +}
>=20
> Could this use get_random_sleepable_once()?
> We are running in process context here.
> Same remark for  inet6_init_ehash_secret()

Ah that's better !

I'll squash this to v2, thanks !

---8<---
diff --git a/include/linux/net.h b/include/linux/net.h
index f58b38ab37f8..a8e818de95b3 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -304,6 +304,8 @@ do {									\
=20
 #define net_get_random_once(buf, nbytes)			\
 	get_random_once((buf), (nbytes))
+#define net_get_random_sleepable_once(buf, nbytes)		\
+	get_random_sleepable_once((buf), (nbytes))
=20
 /*
  * E.g. XFS meta- & log-data is in slab pages, or bcache meta
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 2c2cac5b0f1a..e4c9a1590a74 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -32,7 +32,8 @@
=20
 static void inet_init_ehash_secret(void)
 {
-	net_get_random_once(&inet_ehash_secret, sizeof(inet_ehash_secret));
+	net_get_random_sleepable_once(&inet_ehash_secret,
+				      sizeof(inet_ehash_secret));
 }
=20
 u32 inet_ehashfn(const struct net *net, const __be32 laddr,
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 054f75d32381..a0e5a8812614 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -25,8 +25,10 @@
=20
 void inet6_init_ehash_secret(void)
 {
-	net_get_random_once(&inet6_ehash_secret, sizeof(inet6_ehash_secret));
-	net_get_random_once(&tcp_ipv6_hash_secret, sizeof(tcp_ipv6_hash_secret));
+	net_get_random_sleepable_once(&inet6_ehash_secret,
+				      sizeof(inet6_ehash_secret));
+	net_get_random_sleepable_once(&tcp_ipv6_hash_secret,
+				      sizeof(tcp_ipv6_hash_secret));
 }
=20
 u32 inet6_ehashfn(const struct net *net,
---8<---

