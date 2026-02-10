Return-Path: <netdev+bounces-258083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M5qAZEsi2lEQgAAu9opvQ
	(envelope-from <netdev+bounces-258083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:03:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6111B151
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D694C3032985
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A131984E;
	Tue, 10 Feb 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV3VHHnx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1F1F8691
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728556; cv=none; b=IpViXSObP7r8Vz3hlRZzOHwRwPnqYCFHLkJcLtYSe8D7fz639M9hpqUyxw+EG6gOj1/KicTZwLP6LiHp6OSpb+wNoCU8xf+TVbqRGycXpzkLgHbo3wEIXqyoRmgX0fQzqOFTMQLOyq//YgjrzDv45VMznZXARVL03L3jtdYKNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728556; c=relaxed/simple;
	bh=V7fUiJDd3AnJgcfW721dkEeiJ/kzLUWBbvUMK9axaX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rj/2BDWnZ7KSFFyea8l9h4L7eeSZDexRc62aacj/B+EPjhzOy27rHFqgwu63+311iRqMFvHVeSkVu3Qt3vLOV2qg3YgnnZaHrPT1a5GFq5k3PQWA7z2X1CAZHkXTjpfM4y01khbUEPbZMffaA5JyICEUb+GgQyb5N+ZJF6Ui/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RV3VHHnx; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79427f739b0so57478647b3.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 05:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770728554; x=1771333354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9twf8HTDEWo43eoq1A8d9Q1foTmzz8XHqbwK5xn5O4=;
        b=RV3VHHnxKmIM9Sv2EraLKB9MoIWc0SOJTxunz0oEExJYXtCmTIoo93PKOsZzwTW8RD
         MtVpr4czXV51CFovKy2PsnU6Di4nzK//XGQ9bj/QularIkv5LqcdDGwEDHLra2aZT+tl
         TwzdznUqEkgslpoqBUVqhOq2ZHiEZ63Sh//tLvKZE6hdmU2u53/ifPXqCxtb66DkTyRW
         eDCIZK5zTsohYorGia587YMvv5xD6e6VoJXsEckQII44IGaLB6CcfvWXYerFE4cULhCK
         W5ezQjfed7xvkif3aGRiFohewJiwKkI3FLgzoAy8S/MjSBrmjyi8rwEeMsA5Sxx/pmzb
         6lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728554; x=1771333354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9twf8HTDEWo43eoq1A8d9Q1foTmzz8XHqbwK5xn5O4=;
        b=j0KcsIpr/fHn5Ppl5VqsHEZr8tcIwZQKJ3r6MoAmchfXpNOyCy+KSvRCVl83oTrvtT
         GO8/uzyh2ZL3HCWVD5uTVoAMReLCPindKD2HVcFoEXYXuBFOeZpfcrmWMdHm4/lBDATH
         5YjHGup/8vdSX66XZsU1tQ3inYj9FMt3xS4r9BGSK/tN1g+8tJLcYzZMp7QBP1dYTHu/
         RmtQXRd75fwQkI+1SVSwfLc6dylGs8oi9HCK1UBbDqihKUA+wt3U1zI+rlRPrqyyAFge
         N+4+9Q8PtiZgtG+s50vSq4Wvt33GVYb384ilms8Wmby2s9kkR2cp2zxO0+h27AG+Y9fp
         fgHA==
X-Forwarded-Encrypted: i=1; AJvYcCXUSo4t2ywwcCudq3w1oW+ns9XmTsJd6TpStmBMYqZ3pDRJylJg3Z6BOB0A+OvMaElA+t1AkWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMWa6dkqllq3cRQLzmT3Ymn1v5055km8B1Q8+im4g/vsJwMMM
	X7Ou7DzawYdwbrnblwmbtGUtGqNEGFzskmM90+MAHgkhfLevJ+fx5zYM
X-Gm-Gg: AZuq6aLHqWDa+mDCjPTEFsWO660+h3PGGIlWMSUSY03IqS8ryxFGNcyulNEjy86wV2Q
	EgrNaQ6wFVxCyflvAXTeIoya+JI5V3UWpAqFmFari/t0RDX5hs4ww6YmQMOXPGP0hcNfjMC+n2a
	eK4xFB11QXmHZjoVU4l+4pqbSpIoX3D0IJr8+dvkeWVeygb6Q92Zcc/9IqnKx5c+kzbO6pZWbwa
	L/5GeIGtgoYJwquIseBQxhWQm7THY5wHONHmTOU/hfKASqFaU+P1w5RyQ0Bxkj9o+pgKR6A9luX
	hMbMoOsBC0i1r0ZL25FeQjHr/9O+zXED1k8S+HjzyCDFlyajdRKGvVatzTgXNxNwrq5XVtxF3yC
	2HgQ/oBYpkS1btE/AlpMAWKR2nfTaKeuu7kvsZ0qkli9P4QXAdfjA8rNFheunEPsjlrsmH9lYgy
	ysmNQWsfXAJPl+tc2fDemstiiLsQM2zU02CGAGhB7aNSq0f+gE57y0t8qrggsq7AYxFcioOaAL1
	aPDWUR7JSujSO8=
X-Received: by 2002:a81:b813:0:b0:792:725c:a373 with SMTP id 00721157ae682-7952aa92fe6mr111355697b3.19.1770728554024;
        Tue, 10 Feb 2026 05:02:34 -0800 (PST)
Received: from zenbox.prizrak.me (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79529e45621sm120060957b3.0.2026.02.10.05.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 05:02:33 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: mic@digikod.net
Cc: brauner@kernel.org,
	demiobenour@gmail.com,
	fahimitahera@gmail.com,
	gnoack3000@gmail.com,
	hi@alyssa.is,
	horms@kernel.org,
	ivanov.mikhail1@huawei-partners.com,
	jannh@google.com,
	jmorris@namei.org,
	john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	matthieu@buffet.re,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	samasth.norway.ananda@oracle.com,
	serge@hallyn.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 1/6] lsm: Add LSM hook security_unix_find
Date: Tue, 10 Feb 2026 08:02:28 -0500
Message-ID: <20260210130232.212260-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209.yeeh3ieDuz9u@digikod.net>
References: <20260209.yeeh3ieDuz9u@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,paul-moore.com,oracle.com,hallyn.com,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-258083-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[utilityemal77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maowtm.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4B6111B151
X-Rspamd-Action: no action

> On Mon, Feb 09, 2026 at 12:10:11AM +0100, Günther Noack wrote:
> > From: Justin Suess <utilityemal77@gmail.com>
> > 
> > Add a LSM hook security_unix_find.
> > 
> > This hook is called to check the path of a named unix socket before a
> > connection is initiated. The peer socket may be inspected as well.
> > 
> > Why existing hooks are unsuitable:
> > 
> > Existing socket hooks, security_unix_stream_connect(),
> > security_unix_may_send(), and security_socket_connect() don't provide
> > TOCTOU-free / namespace independent access to the paths of sockets.
> > 
> > (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> > This requires another path lookup. A change in the path between the
> > two lookups will cause a TOCTOU bug.
> > 
> > (2) We cannot use the struct path from the listening socket, because it
> > may be bound to a path in a different namespace than the caller,
> > resulting in a path that cannot be referenced at policy creation time.
> > 
> > Cc: Günther Noack <gnoack3000@gmail.com>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  5 +++++
> >  include/linux/security.h      | 11 +++++++++++
> >  net/unix/af_unix.c            |  9 +++++++++
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 45 insertions(+)
> > 
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 8c42b4bde09c..7a0fd3dbfa29 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -317,6 +317,11 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
> >  LSM_HOOK(int, 0, watch_key, struct key *key)
> >  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
> >  
> > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> > +LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
> > +	 int flags)
> > +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> > +
> >  #ifdef CONFIG_SECURITY_NETWORK
> >  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
> >  	 struct sock *newsk)
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 83a646d72f6f..99a33d8eb28d 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> >  }
> >  #endif	/* CONFIG_SECURITY_NETWORK */
> >  
> > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> > +
> > +int security_unix_find(const struct path *path, struct sock *other, int flags);
> > +
> > +#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> > +static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
> > +{
> > +	return 0;
> > +}
> > +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> > +
> >  #ifdef CONFIG_SECURITY_INFINIBAND
> >  int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
> >  int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index d0511225799b..db9d279b3883 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1226,10 +1226,19 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
> >  	if (!S_ISSOCK(inode->i_mode))
> >  		goto path_put;
> >  
> > +	err = -ECONNREFUSED;
> 
> We don't see it in this patch but err is already set to -ECONNREFUSED.
> This line might be confusing, and unrelated to the goal of this patch,
> so we should remove it.

Done. I debated keeping it, but it seems more appropriate to follow the
convention. Thanks for the catch.

> 
> 
> >  	sk = unix_find_socket_byinode(inode);
> >  	if (!sk)
> >  		goto path_put;
> >  
> > +	/*
> > +	 * We call the hook because we know that the inode is a socket
> > +	 * and we hold a valid reference to it via the path.
> 
> This comment can be alligned with 80 columns.

Done.

> > +	 */
> > +	err = security_unix_find(&path, sk, flags);
> 
> This hook makes sense and is quite generic.

Indeed, I suspect it will be useful for other path-based LSM.

> > +	if (err)
> > +		goto sock_put;
> > +
> >  	err = -EPROTOTYPE;
> >  	if (sk->sk_type == type)
> >  		touch_atime(&path);
> > diff --git a/security/security.c b/security/security.c
> > index 31a688650601..9e9515955098 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> >  
> >  #endif	/* CONFIG_SECURITY_NETWORK */
> >  
> > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> > +/*
> 
> This should be a docstring like other hooks: /**

Done.

> 
> > + * security_unix_find() - Check if a named AF_UNIX socket can connect
> > + * @path: path of the socket being connected to
> > + * @other: peer sock
> > + * @flags: flags associated with the socket
> > + *
> > + * This hook is called to check permissions before connecting to a named
> > + * AF_UNIX socket.
> > + *
> > + * Return: Returns 0 if permission is granted.
> > + */
> > +int security_unix_find(const struct path *path, struct sock *other, int flags)
> > +{
> > +	return call_int_hook(unix_find, path, other, flags);
> > +}
> > +EXPORT_SYMBOL(security_unix_find);
> > +
> > +#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> > +
> >  #ifdef CONFIG_SECURITY_INFINIBAND
> >  /**
> >   * security_ib_pkey_access() - Check if access to an IB pkey is allowed
> > -- 
> > 2.52.0
> > 
> > 
>

Below follows revised lsm hook patch based on feedback.

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..7a0fd3dbfa29 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -317,6 +317,11 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
 LSM_HOOK(int, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
+	 int flags)
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..99a33d8eb28d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+
+int security_unix_find(const struct path *path, struct sock *other, int flags);
+
+#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
 int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d0511225799b..369812b79dd8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1230,6 +1230,14 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	if (!sk)
 		goto path_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket and we
+	 * hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, sk, flags);
+	if (err)
+		goto sock_put;
+
 	err = -EPROTOTYPE;
 	if (sk->sk_type == type)
 		touch_atime(&path);
diff --git a/security/security.c b/security/security.c
index 31a688650601..eaf8f8fdf0c2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+/**
+ * security_unix_find() - Check if a named AF_UNIX socket can connect
+ * @path: path of the socket being connected to
+ * @other: peer sock
+ * @flags: flags associated with the socket
+ *
+ * This hook is called to check permissions before connecting to a named
+ * AF_UNIX socket.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_unix_find(const struct path *path, struct sock *other, int flags)
+{
+	return call_int_hook(unix_find, path, other, flags);
+}
+EXPORT_SYMBOL(security_unix_find);
+
+#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 /**
  * security_ib_pkey_access() - Check if access to an IB pkey is allowed

