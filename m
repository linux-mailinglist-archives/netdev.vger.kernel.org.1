Return-Path: <netdev+bounces-263085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMGzKAmnpmkNSgAAu9opvQ
	(envelope-from <netdev+bounces-263085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:16:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5701EBB41
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 983253038297
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578B38228A;
	Tue,  3 Mar 2026 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE3Eeh7c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2chw8p9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAF1F4634
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529413; cv=pass; b=fp42dZ1VAmjdryuxFh6JSD7S9ldC/QcOAzBF1yahgaaNQ/FnCuuvtpc7LmA53NjpcsQc+mYbnWlxYFLGhPs9HWSA6WmgXBWzJ3oOnS/8bsoQjzF4Wc0rNisdjcqZSpz+C53XrSIWTm9I2YUOVnwvCbYKVP6COhIObsHeR73EBZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529413; c=relaxed/simple;
	bh=N9T9tK8lrPlBnjE46aPR6EPWJfEat41vQnH/NRbnpNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLC8udS31iblK1VvirFcEPrcaJd+LobZJNP/WFl7aJ/CO/vczyVPCb9cmBPCtqGtarwk3/4rC8vwQvrthzB+ID0Vf4LtFmia6InhqO2Nss8CPK6vb4IkmsAkZ5tT5itK1BxUoi5CFWqs2yZH8wYjceVVwx4FAci0qXFDlGRUOVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bE3Eeh7c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2chw8p9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772529410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=477xItCgA+po7bLgye1fu2Qz+J42vgm/OW+kOSIs1X8=;
	b=bE3Eeh7c8FiM13Y6hRTE7KuCuOQ3YschGlalWwtiAtdQtPmXBgwCk0OOWSIJFZBz1gaygA
	K/357UT/hdQZWCGuibKO/+75KzW5HrDmKNNIOBIdH4GmqQrJuApLzNNHMHJSM/uPEryUDZ
	A1WjhIG0r3gUaVZ4Ku7zJiHgLxGgXdo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-r8n2w5NUMO67WSoodB3_0w-1; Tue, 03 Mar 2026 04:16:49 -0500
X-MC-Unique: r8n2w5NUMO67WSoodB3_0w-1
X-Mimecast-MFC-AGG-ID: r8n2w5NUMO67WSoodB3_0w_1772529409
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-79881805767so56458687b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 01:16:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772529409; cv=none;
        d=google.com; s=arc-20240605;
        b=RzR/Ct6t+tYkd7LuxZUrBmILmguxF3PWqjNCjs3JbHAxX5GOy/fT/YriHc5THXzyHL
         9P7H+Q2zvW9Fp1g3HmfXBBu21FiWUVqzavWLnM+MUKUeDqgmMi+Hs6Be2cVpWJeBSAvO
         ybbFakJt9jpB8vaUEFoqEU4gH5S7y85bgeCmamsh/7rqHZGuGSV6NL/4bkrnS7QcnEoz
         ZBX210yQNURZpn58PguKJWh46OPmbNZaSvxt2WOs9l6fn4Ua81ZNb2E03fjGnkgB9Ray
         bXpg4edvOXu5Rkg66ZHQjhD76cTU068PgowTRRFjXIHT77InXYQYtyejZOyBuk0L73Cs
         Lpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=477xItCgA+po7bLgye1fu2Qz+J42vgm/OW+kOSIs1X8=;
        fh=bCrDXZIK7x1NAqV88LhzHqNJ1wVHI0rwxoy7g8kwK20=;
        b=DPhbWBqRJoyCTAJXVT7ToDA1ThEFJDdih27zJwqxBlWhNNKNJK+bEqaNIc3FaOqoct
         AwqMMz8R6mm3NlcM9MzV4NHynX6cE1XoKCpetWHE01Q4Cf6PETB6QHpu9kxPHwlwH+9B
         Zy8nEyRrFNyJUAcuuTDmR1NbyOYZysEYWP6pgkrdIw7pqucsQdJRAAJTWrfVDypXC+9V
         EGOx5eEPYYBWJLABFzm/XtdgzlSAhy8ffqMT3Z3YlmhjIeHRvjPX/xT2BIsOOTQdBvnT
         PhQ5LcA5G5LOIua+AmpShYsKATiZBIapKlxzUwQBEABCKt9wCBrr78NxM+6ExZlk1gPR
         LPRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772529409; x=1773134209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=477xItCgA+po7bLgye1fu2Qz+J42vgm/OW+kOSIs1X8=;
        b=K2chw8p9qpU9CyCplHrXlJMGQzOIgkMMrmkWNxaWjFX9MOxoZvlRfc2hJ9qezWHBy0
         W9f4ANTOCJ166qQKgQJWucdURhk9O7RWSDODAcznomuVbcNy+LvmL6G2Gsd7azqCzxBj
         zNzjm7VnjW6WTCfGIdAKW5qPMkrn7uGSIqzL9fc0lT1iJdQHCa6D/1MaU5LBv29nNGUw
         5/tu1Z+bnJ9jWI0LBChs2D+s1k4RriD51Vf6Zf0R/Ll6NJKnvzsCtgbnbxP9n/r/0NUW
         SsB1qJhiB9vbva/FbcQMd61KDx9XdfUjhrudnnb5J0IcdBWnqjDr+Y1wTWstAOb/3xg3
         KSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529409; x=1773134209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=477xItCgA+po7bLgye1fu2Qz+J42vgm/OW+kOSIs1X8=;
        b=XUwYce1Pav3Ez2cV4U4mXMaY3g015rnyd81xoIQEau+YjwYxeFXTscBFCLKFUzjkMF
         P8T+as9JYU7Kq4TGFMdV31daoRbr/tSMwKt/Go/maDJjAkk45bP4Aqgr/8DxiWqqjRl6
         EBrHkdi7zaVBqn7LEX+WJSLGZHMmtycwh3fKPe9jUGcmWoklFwOp2v0umVz2x/Z4DfuI
         S9+T45zyJc3mF/HcUt5RSaRZ29bvQtyTaej8Jhlieh2b3FImgFlO+gZQN8+/Sql1BHcn
         Ra98LTekkxyUFNuk4rqHmCDGMcWew8PovuPRzL0LqmO1iNuNJVEVg9PYwr7jYSYqtK8i
         0s9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdelQQWiD1sNtelCZvqoxxwgbktXKyWU7GQahxFPx43bnSD1YPRL+2fdHiolcth0YZYS8iv/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3G7vUK75P1QZSG1jSd5rpl/DE2mfRHG12puF9uHp4tRD8vPwz
	YaUXpcqULXYWudn7QCms1E9EXzt/OD7vARaID9vWbhsjPm8+bDhQ6P7cFUf2QIU9yy7s0cukIsV
	qEXVd3YP5Q8wgiUPkcjqQQB5EvuT8TmwPyCQJvuN7n1b2CVuRa+XRPC6XWpZKK32jIbiH408Xpq
	6ZbyPYC7y+OQaH5wOKQBMkWD3wOYKbcQuA
X-Gm-Gg: ATEYQzwFATi/uDu+RTyrZ+ekZwJhwg+NszbqcAjGf/eny915Lm9Q6HhekujbrqtVtPy
	E2ZKKKPohaJ/sOhsZI2pJ6W3QMpkVjYevrcKSBhcB23yE8y3W7IhM8KH07QkO2x5pqLCxcRPs5S
	HXIKm/xnLsQBXuWg2B50xL93O+888QWF0PxPV1HvB/zR5NXzhHtCIcJUZPkBvnI9PfsuF9ProSw
	To2C7U=
X-Received: by 2002:a05:690c:e373:b0:797:cd05:bcfa with SMTP id 00721157ae682-79885631b64mr135971677b3.56.1772529409197;
        Tue, 03 Mar 2026 01:16:49 -0800 (PST)
X-Received: by 2002:a05:690c:e373:b0:797:cd05:bcfa with SMTP id
 00721157ae682-79885631b64mr135971217b3.56.1772529408805; Tue, 03 Mar 2026
 01:16:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771986861.git.lucien.xin@gmail.com> <08a63705058aff77dd54fb388870f0bca6036c95.1771986861.git.lucien.xin@gmail.com>
In-Reply-To: <08a63705058aff77dd54fb388870f0bca6036c95.1771986861.git.lucien.xin@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 3 Mar 2026 10:16:37 +0100
X-Gm-Features: AaiRm51KQx9VYE8xMRhcvcGF5sOeXsvvCe5N0-c4bJqQWqxzxGk3Zy5J02q8C_U
Message-ID: <CAF6piCKOiwMz9Le2vBV4_W3R0NR3TW_je+ow4SCm5eX867awyg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 15/15] quic: add packet parser base
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>, quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, 
	Tyler Fanelli <tfanelli@redhat.com>, Pengtao He <hepengtao@xiaomi.com>, 
	Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	"Marc E . Fiuczynski" <marc@fiuczynski.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4D5701EBB41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263085-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2/25/26 3:34 AM, Xin Long wrote:
> +/* Find the listening QUIC socket for an incoming packet.
> + *
> + * This function searches the QUIC socket table for a listening socket that matches the dest
> + * address and port, and the ALPN(s) if presented in the ClientHello.  If multiple listening
> + * sockets are bound to the same address, port, and ALPN(s) (e.g., via SO_REUSEPORT), this
> + * function selects a socket from the reuseport group.
> + *
> + * Return: A pointer to the matching listening socket, or NULL if no match is found.
> + */
> +struct sock *quic_listen_sock_lookup(struct sk_buff *skb, union quic_addr *sa, union quic_addr *da,
> +                                  struct quic_data *alpns)
> +{
> +     struct net *net = sock_net(skb->sk);
> +     struct hlist_nulls_node *node;
> +     struct sock *sk = NULL, *tmp;
> +     struct quic_shash_head *head;
> +     struct quic_data alpn;
> +     union quic_addr *a;
> +     u32 hash, len;
> +     u64 length;
> +     u8 *p;
> +
> +     hash = quic_listen_sock_hash(net, ntohs(sa->v4.sin_port));
> +     head = quic_listen_sock_head(hash);
> +
> +     rcu_read_lock();
> +begin:
> +     if (!alpns->len) { /* No ALPN entries present or failed to parse the ALPNs. */
> +             sk_nulls_for_each_rcu(tmp, node, &head->head) {
> +                     /* If alpns->data != NULL, TLS parsing succeeded but no ALPN was found.
> +                      * In this case, only match sockets that have no ALPN set.
> +                      */
> +                     a = quic_path_saddr(quic_paths(tmp), 0);
> +                     if (net == sock_net(tmp) && quic_cmp_sk_addr(tmp, a, sa) &&
> +                         quic_path_usock(quic_paths(tmp), 0) == skb->sk &&
> +                         (!alpns->data || !quic_alpn(tmp)->len)) {
> +                             sk = tmp;
> +                             if (!quic_is_any_addr(a)) /* Prefer specific address match. */
> +                                     break;
> +                     }
> +             }
> +             goto out;
> +     }
> +
> +     /* ALPN present: loop through each ALPN entry. */
> +     for (p = alpns->data, len = alpns->len; len; len -= length, p += length) {
> +             quic_get_int(&p, &len, &length, 1);
> +             quic_data(&alpn, p, length);
> +             sk_nulls_for_each_rcu(tmp, node, &head->head) {
> +                     a = quic_path_saddr(quic_paths(tmp), 0);
> +                     if (net == sock_net(tmp) && quic_cmp_sk_addr(tmp, a, sa) &&
> +                         quic_path_usock(quic_paths(tmp), 0) == skb->sk &&
> +                         quic_data_has(quic_alpn(tmp), &alpn)) {
> +                             sk = tmp;
> +                             if (!quic_is_any_addr(a))
> +                                     break;
> +                     }
> +             }
> +             if (sk)
> +                     break;
> +     }
> +out:
> +     /* If the nulls value we got at the end of the iteration is different from the expected
> +      * one, we must restart the lookup as the list was modified concurrently.
> +      */
> +     if (!sk && get_nulls_value(node) != hash)
> +             goto begin;
> +
> +     if (sk && sk->sk_reuseport)
> +             sk = reuseport_select_sock(sk, quic_addr_hash(net, da), skb, 1);
> +
> +     if (sk && unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +             sk = NULL;

Note that you could avoid the refcount if you keep using the sk in an
RCU critical section. i.e. plain UDP does that. Same consideration for
established lookup.


/P


