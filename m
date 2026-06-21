Return-Path: <netdev+bounces-300880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s2c6GdTfN2ojVAcAu9opvQ
	(envelope-from <netdev+bounces-300880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 14:57:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED86AAC8C
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 14:57:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eW+4ekZt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300880-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300880-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF8C930099A5
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC728366074;
	Sun, 21 Jun 2026 12:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266953655C2
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 12:57:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046671; cv=none; b=PLzLOUvUhZN+CsdJY4TEgrXYBDvXuxBLtfXV+dlWaIV4O9/joUvkT+1DRMOidX11G69wBFXZX9IP2czmvk2S0YSzWE1PfhZHzdKok9wj+D0d5gla98N71Fa2tO21OkbZlIH+VezKAxrKQbjq5x5KZkI4utxGIsgc6dXc+uVgiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046671; c=relaxed/simple;
	bh=DTx1JGjHiJOA7xSL0FFkS6DTE6JfRpUgcHjQWBQeKkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV7Z0lFy8pA5C2CPf7af6Le6oFVVmrMZ2IriX//UBeAvBnIUQt5PM0UsIKOhFvilp4R22nd12ciNWswSrwWBgToQHazOg6Oni0nR1LvUtx6BRhw45yjmlxjkGW+MVlwEH+mmYlAVoFsk6HXAJrzzMiqCiBkxD72/XZvzZbQV/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW+4ekZt; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b613a17bso27785005e9.3
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782046668; x=1782651468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTfFX8AhgJIDIIDkQTTlRUQxHBspdzZ+v0whf6RTaaw=;
        b=eW+4ekZt/nQYF1udvteXmiylNHsxIW2AUY2fSAy4bWmxUNMNupSBnlszar2li8Swd0
         ktOhqo5pBRb5to2Keu6XeAGRsV5bGGFotb80LNgGpwRi4TPSg0lb/jMWYsohIUa06lzN
         AeZCO35CEdXxVWmKh6GP2n5tJjIIY9VBm4I4/vK7mhNVCv4QdQgL9FZSeVLizXkCHlF4
         UF8SsJ4X0Pi8BpyuftTY2j07OaF0TKEtnHuMkyKJwlCSjYy7ZTunqkMaZZKyyzDl//Ex
         IiWL5GCqQFQw+rjkAMJ6HJNw/muC27MtmSzfUg1GJz/hGAQwTBZ7ofBHBm0T9PE5ZZCi
         mjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782046668; x=1782651468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xTfFX8AhgJIDIIDkQTTlRUQxHBspdzZ+v0whf6RTaaw=;
        b=pGUSy/QIVhfsn15mIlQQH1vei/eu8D5Fk5qLciclfjLJ5iR2gGYbMexa+NbHrPaHw+
         yX6Kdl14PWc1VNcbvR8EoybXR5og179rd4SICFGx0d58CU1DkWS/RiD2jpE1RtJuyK0u
         xd6/ZgpHukVPI54BfrLYgSNnjWwf60k6a4a9ozKlTDyOwwErYgQJE0IaNtTw9Q5InYwf
         OAUIMVz+MUrnFGPLHJROOFyIG75ykEZA6WvQkZBW+Rfuw6RTsjDP0SrvpFTpjIkvWAHg
         mda81dCNJRLIMHAHU3Bq1EZpT6dbrBoyYzUR5NGCIBXnjN5Qjdg54OKwHCoUCA/ffebd
         E/Uw==
X-Forwarded-Encrypted: i=1; AFNElJ/neSr9ufMXBHbLXtFH56lypi/ZHg+LrhZ46YH+9L9fueUKckj1F6H0AUmlmf7IzcF8XcqpPZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0GsqJXSxWerP/16M+q968G4kyusV4uPf+eLKpVKomeRGT1WdH
	TBqPbgMoxtRqpftUg/yvmVG0W4ZUzcaCmEbsmagfO1ckiTjkedXSJgEn
X-Gm-Gg: AfdE7cmtaJZoOJPQxaVgGiVROdTgZaa6IuObOn/oyRiqvY7E06szK3K5Ycr9OMhbB31
	1iTKZi6twVpheI4R0c0SSilWVl62fbhfv2oq5KwuaUlGSCqmbJbkWfTc8CJxZ3uldUBFtKSPByv
	yLBn1j0bO0LXKARZSo+CThW1b9J/S1BRi/8OWGDZmWh4FMWlVxzmh2W82SCpDzWmEd1diC2j948
	idmNiYCxmPVZbSj3LgaPhRByKhbQ8se5WLsJYgt0gWJpU+fbfw57fXfuSHP+9FcqOLJYa1+QJoC
	I40UxIh6uzaeIl2Vqb7oilGgG9vV+cMeNqhVA7LX+krZ6PT5AZfjGiwFczdT3SdhJVhqyQDhh86
	nznBVZCWQnmbtuhCC/0olAzU0ozXdVwLctafqnJ/1atVJbE0de46IOyRvVyQG528gbuLMGqClzz
	drtwz6UuBXIfcswiXTKbqOwmEbI1AOc2qh0f99M7SkWsPaW5anFQ==
X-Received: by 2002:a05:600c:4694:b0:492:4717:59fb with SMTP id 5b1f17b1804b1-492490a77a4mr99978575e9.17.1782046668224;
        Sun, 21 Jun 2026 05:57:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49245a69f81sm177754515e9.1.2026.06.21.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 05:57:47 -0700 (PDT)
Date: Sun, 21 Jun 2026 13:57:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alex Goltsev <sasha.goltsev777@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] net: add sock_open() with flags for socket creation
Message-ID: <20260621135746.067a93be@pumpkin>
In-Reply-To: <CAEKmD4K-v_srabQDJCfqaqA6vssk-Hg-mLHEdTsphTBLmQVjnw@mail.gmail.com>
References: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
	<CAEKmD4K-v_srabQDJCfqaqA6vssk-Hg-mLHEdTsphTBLmQVjnw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sasha.goltsev777@gmail.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:sashagoltsev777@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300880-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9ED86AAC8C

On Sun, 21 Jun 2026 14:05:40 +0300
Alex Goltsev <sasha.goltsev777@gmail.com> wrote:

> From a9316957e594708dfb4258ad968fe88666c9b736 Mon Sep 17 00:00:00 2001
> From: 0-x-0-0 <sasha.goltsev777@gmail.com>
> Date: Sun, 21 Jun 2026 13:24:29 +0300
> Subject: [PATCH v2] net: add sock_open() with flags for socket creation

A) There is no info here.
B) You've not said why this is of any use.
C) It isn't a bug fix so would go into net-next
D) net-next is closed.

	David

> 
> ---
> Changes in V2:
> - Replaced the use of plain integer constants for flags with proper
> enums to improve readability and type safety.
> - `sock_open` is intentionally left as a regular exported symbol rather
> than being moved to a header as `static inline`. This is because it
> dereferences `current->nsproxy->net_ns`, which would require pulling
> in heavy headers like <linux/sched.h> and <linux/nsproxy.h> into the
> already widely-used <linux/net.h>, causing unnecessary header bloat
> and potential circular dependencies.
> - Introduced two new creation flags for specialized use cases within
> kernel modules:
> 
> * SOCK_CREATE_NOLSM: This flag allows a kernel module to bypass
> LSM hooks during socket creation. This
> enables a micro-optimization for kernel-internal sockets where
> the security check is known *a priori* to be a no-op (e.g., for
> specific configurations or high-performance paths).
> This is safe because the API is restricted to in-kernel (LKM)
> contexts only, and does not weaken the security boundary for
> user-triggered socket creation.
> 
> * SOCK_CREATE_NOWARN: This flag suppresses the standard warning
> messages on creation failure. This is useful for callers in the
> kernel that probe for protocol support and handle the error
> gracefully, without wanting to pollute the kernel log with
> misleading warnings.
> 
> Signed-off-by: Alexander Goltsev <sasha.goltsev777@gmail.com>
> ---
> include/linux/net.h | 22 ++++++++
> net/socket.c | 133 +++++++++++++++++++++++++++++++++++++-------
> 2 files changed, 134 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index f268f395c..6367c00db 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -116,6 +116,22 @@ enum sock_shutdown_cmd {
> SHUT_RDWR,
> };
> +/**
> + * enum sock_create_flags - socket creation flags
> + * @SOCK_CREATE_KERN: creates a kernel socket
> + * @SOCK_CREATE_USER: creates a regular socket
> + * @SOCK_CREATE_LITE: creates a lite socket
> + * @SOCK_CREATE_NOLSM: disables LSM
> + * @SOCK_CREATE_NOWARN: disables warning
> + */
> +enum sock_create_flags {
> + SOCK_CREATE_KERN = BIT(0),
> + SOCK_CREATE_USER = BIT(1),
> + SOCK_CREATE_LITE = BIT(2),
> + SOCK_CREATE_NOLSM = BIT(3),
> + SOCK_CREATE_NOWARN = BIT(4),
> +};
> +
> struct socket_wq {
> /* Note: wait MUST be first field of socket_wq */
> wait_queue_head_t wait;
> @@ -275,6 +291,12 @@ void sock_unregister(int family);
> bool sock_is_registered(int family);
> int __sock_create(struct net *net, int family, int type, int proto,
> struct socket **res, int kern);
> +int __sock_create_flags(struct net *net, int family, int type, int protocol,
> + struct socket **res, int kern, int flags);
> +int __sock_create_lite_flags(int family, int type, int protocol,
> + struct socket **res, int flags);
> +int sock_open(struct net *net, int family,
> + int type, int protocol, struct socket **res, int flags);
> int sock_create(int family, int type, int proto, struct socket **res);
> int sock_create_kern(struct net *net, int family, int type, int proto,
> struct socket **res);
> int sock_create_lite(int family, int type, int proto, struct socket **res);
> diff --git a/net/socket.c b/net/socket.c
> index 63c69a0fa..2359fd5bf 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1425,26 +1425,28 @@ static long sock_ioctl(struct file *file,
> unsigned cmd, unsigned long arg)
> }
> /**
> - * sock_create_lite - creates a socket
> + * __sock_create_lite_flags - creates a socket (with flags)
> * @family: protocol family (AF_INET, ...)
> * @type: communication type (SOCK_STREAM, ...)
> * @protocol: protocol (0, ...)
> * @res: new socket
> + * @flags: defines socket creation flags
> *
> * Creates a new socket and assigns it to @res, passing through LSM.
> * The new socket initialization is not complete, see kernel_accept().
> * Returns 0 or an error. On failure @res is set to %NULL.
> * This function internally uses GFP_KERNEL.
> */
> -
> -int sock_create_lite(int family, int type, int protocol, struct socket **res)
> +int __sock_create_lite_flags(int family, int type, int protocol,
> struct socket **res, int flags)
> {
> int err;
> struct socket *sock = NULL;
> - err = security_socket_create(family, type, protocol, 1);
> - if (err)
> - goto out;
> + if (!(flags & SOCK_CREATE_NOLSM)) {
> + err = security_socket_create(family, type, protocol, 1);
> + if (err)
> + goto out;
> + }
> sock = sock_alloc();
> if (!sock) {
> @@ -1453,9 +1455,11 @@ int sock_create_lite(int family, int type, int
> protocol, struct socket **res)
> }
> sock->type = type;
> - err = security_socket_post_create(sock, family, type, protocol, 1);
> - if (err)
> - goto out_release;
> + if (!(flags & SOCK_CREATE_NOLSM)) {
> + err = security_socket_post_create(sock, family, type, protocol, 1);
> + if (err)
> + goto out_release;
> + }
> out:
> *res = sock;
> @@ -1465,6 +1469,25 @@ int sock_create_lite(int family, int type, int
> protocol, struct socket **res)
> sock = NULL;
> goto out;
> }
> +EXPORT_SYMBOL(__sock_create_lite_flags);
> +
> +/**
> + * sock_create_lite - creates a socket
> + * @family: protocol family (AF_INET, ...)
> + * @type: communication type (SOCK_STREAM, ...)
> + * @protocol: protocol (0, ...)
> + * @res: new socket
> + *
> + * Creates a new socket and assigns it to @res, passing through LSM.
> + * The new socket initialization is not complete, see kernel_accept().
> + * Returns 0 or an error. On failure @res is set to %NULL.
> + * This function internally uses GFP_KERNEL.
> + */
> +
> +int sock_create_lite(int family, int type, int protocol, struct socket **res)
> +{
> + return __sock_create_lite_flags(family, type, protocol, res, 0);
> +}
> EXPORT_SYMBOL(sock_create_lite);
> /* No kernel lock held - perfect */
> @@ -1563,22 +1586,23 @@ int sock_wake_async(struct socket_wq *wq, int
> how, int band)
> EXPORT_SYMBOL(sock_wake_async);
> /**
> - * __sock_create - creates a socket
> + * __sock_create_flags - creates a socket (with flags)
> * @net: net namespace
> * @family: protocol family (AF_INET, ...)
> * @type: communication type (SOCK_STREAM, ...)
> * @protocol: protocol (0, ...)
> * @res: new socket
> * @kern: boolean for kernel space sockets
> + * @flags: defines socket creation flags
> *
> * Creates a new socket and assigns it to @res, passing through LSM.
> * Returns 0 or an error. On failure @res is set to %NULL. @kern must
> * be set to true if the socket resides in kernel space.
> * This function internally uses GFP_KERNEL.
> */
> -
> -int __sock_create(struct net *net, int family, int type, int protocol,
> - struct socket **res, int kern)
> +int __sock_create_flags(struct net *net, int family,
> + int type, int protocol, struct socket **res,
> + int kern, int flags)
> {
> int err;
> struct socket *sock;
> @@ -1598,14 +1622,18 @@ int __sock_create(struct net *net, int family,
> int type, int protocol,
> deadlock in module load.
> */
> if (family == PF_INET && type == SOCK_PACKET) {
> - pr_info_once("%s uses obsolete (PF_INET,SOCK_PACKET)\n",
> + if (!(flags & SOCK_CREATE_NOWARN)) {
> + pr_info_once("%s uses obsolete (PF_INET,SOCK_PACKET)\n",
> current->comm);
> + }
> family = PF_PACKET;
> }
> - err = security_socket_create(family, type, protocol, kern);
> - if (err)
> - return err;
> + if (!(flags & SOCK_CREATE_NOLSM)) {
> + err = security_socket_create(family, type, protocol, kern);
> + if (err)
> + return err;
> + }
> /*
> * Allocate the socket and allow the family to set things up. if
> @@ -1614,7 +1642,8 @@ int __sock_create(struct net *net, int family,
> int type, int protocol,
> */
> sock = sock_alloc();
> if (!sock) {
> - net_warn_ratelimited("socket: no more sockets\n");
> + if (!(flags & SOCK_CREATE_NOWARN))
> + net_warn_ratelimited("socket: no more sockets\n");
> return -ENFILE; /* Not exactly a match, but its the
> closest posix thing */
> }
> @@ -1671,9 +1700,12 @@ int __sock_create(struct net *net, int family,
> int type, int protocol,
> * module can have its refcnt decremented
> */
> module_put(pf->owner);
> - err = security_socket_post_create(sock, family, type, protocol, kern);
> - if (err)
> - goto out_sock_release;
> +
> + if (!(flags & SOCK_CREATE_NOLSM)) {
> + err = security_socket_post_create(sock, family, type, protocol, kern);
> + if (err)
> + goto out_sock_release;
> + }
> *res = sock;
> return 0;
> @@ -1691,6 +1723,28 @@ int __sock_create(struct net *net, int family,
> int type, int protocol,
> rcu_read_unlock();
> goto out_sock_release;
> }
> +EXPORT_SYMBOL(__sock_create_flags);
> +
> +/**
> + * __sock_create - creates a socket
> + * @net: net namespace
> + * @family: protocol family (AF_INET, ...)
> + * @type: communication type (SOCK_STREAM, ...)
> + * @protocol: protocol (0, ...)
> + * @res: new socket
> + * @kern: boolean for kernel space sockets
> + *
> + * Creates a new socket and assigns it to @res, passing through LSM.
> + * Returns 0 or an error. On failure @res is set to %NULL. @kern must
> + * be set to true if the socket resides in kernel space.
> + * This function internally uses GFP_KERNEL.
> + */
> +
> +int __sock_create(struct net *net, int family, int type, int protocol,
> + struct socket **res, int kern)
> +{
> + return __sock_create_flags(net, family, type, protocol, res, kern, 0);
> +}
> EXPORT_SYMBOL(__sock_create);
> /**
> @@ -1710,6 +1764,43 @@ int sock_create(int family, int type, int
> protocol, struct socket **res)
> }
> EXPORT_SYMBOL(sock_create);
> +/**
> + * sock_open - creates a socket (with flags)
> + * @net: net namespace (may be NULL in non-SOCK_CREATE_KERN modes)
> + * @family: protocol family (AF_INET, ...)
> + * @type: communication type (SOCK_STREAM, ...)
> + * @protocol: protocol (0, ...)
> + * @res: new socket
> + * @flags: socket creation flags
> + *
> + * Unified entry point for socket creation with flags.
> + * Returns 0 or an error. This function internally uses GFP_KERNEL.
> + */
> +int sock_open(struct net *net, int family,
> + int type, int protocol, struct socket **res,
> + int flags)
> +{
> + int type_bits = flags & (SOCK_CREATE_KERN | SOCK_CREATE_USER |
> SOCK_CREATE_LITE);
> + int optional_flags = flags & ~(SOCK_CREATE_KERN | SOCK_CREATE_USER |
> SOCK_CREATE_LITE);
> +
> + if (type_bits == 0 || (type_bits & (type_bits - 1)) != 0)
> + return -EINVAL;
> +
> + if (optional_flags & ~(SOCK_CREATE_NOLSM | SOCK_CREATE_NOWARN))
> + return -EINVAL;
> +
> + switch (type_bits) {
> + case SOCK_CREATE_KERN: return __sock_create_flags(net, family, type, protocol,
> + res, 1, optional_flags);
> + case SOCK_CREATE_USER: return __sock_create_flags(current->nsproxy->net_ns,
> + family, type, protocol, res, 0, optional_flags);
> + case SOCK_CREATE_LITE: return __sock_create_lite_flags(family,
> + type, protocol, res, optional_flags);
> + default: return -EINVAL;
> + }
> +}
> +EXPORT_SYMBOL(sock_open);
> +
> /**
> * sock_create_kern - creates a socket (kernel space)
> * @net: net namespace


