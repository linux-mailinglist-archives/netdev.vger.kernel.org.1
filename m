Return-Path: <netdev+bounces-298784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AUDdIZBhLGrVQAQAu9opvQ
	(envelope-from <netdev+bounces-298784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:44:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 441CB67C22B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:44:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kITUZeWd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298784-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298784-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B63563054BAF
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA2738E8B2;
	Fri, 12 Jun 2026 19:43:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72730375F99
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:43:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293437; cv=pass; b=BMyrrtYanjDSqMJmKfysfry9lPYh71jJCRNP8D3ZvdnwOr6wlfM7LFZ3LZBVB3+feDIQIJHK0BLvv6+KOhDJctECMn5ctlkYVcURYirxdZQRj7hQaf1W1lTMrlRyu2Osm4G1pWTiYhyT6u8b2Fc2933AJRMWF+IRUuTzyGLygLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293437; c=relaxed/simple;
	bh=0MIzScJKL1xXmPrlbYULoUIxKe1BsiEaaVgILh54qWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fo85Lbp/p2sI4ywB72LM/yuTvpfHwproCGKaQ1idNbcepfN9WYFoB6aF/M5rbtsKTkAbmByyJ10yNpX6/og7hVYHCTaAjh64CRHMmdoWKYDO55pGXcowp6Z5mjETp9flDj8UsSkLNyUps61ezXMdngfAS21dOYuu/CSUKdyaDDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kITUZeWd; arc=pass smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-842cd900ee0so670680b3a.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781293436; cv=none;
        d=google.com; s=arc-20240605;
        b=jymIiNqjtb0YWA+BxTG7Qf0nIHYV9gS1GOZyqYmqZKu5RFw7FlckUf9O0i/1ffOnOl
         XQ0PCyQq/YjB0Gt7iJdSjojdEvgoU2Kt8jGn5kUQrXAMyqzAuU28HdMsgaYtQuu3sVGV
         X/cPedjUcSUSTRnltVU+eHBgbXF3Ua2f6BT2oPEWg3AHMRICgmT6LV2/9DuIAd6Nzpak
         3/N6gZrrS5aFoLgjmHdT1JjnnYhU+On59oJgYNxpNzZ8xBUNhowetwqT8F3VT2fOYBEX
         nFY72ySGiCWimoC1Gtp2a/XFy+lDhBmZlfMYDGa5R7IkAqYUw7oi2x+JoDM3QY7V+ZOK
         VYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0MIzScJKL1xXmPrlbYULoUIxKe1BsiEaaVgILh54qWo=;
        fh=pqM/IHKozT5n/ugnyQLDk4/nPc4DMMAsaO459tHppXU=;
        b=lgkSWE5ire+TDHW9JyfqUO2VCPh1cjmAHNQqHf2FvlQUNRwpHX2DFD8grz0YwsyE/2
         jL0S5TYJ/wdh0WMyuCuJy5VuYScHjJBSv6m1dZaBh8Z7sUFLeeoxI01paqbe3PTncOvy
         1nAzH+P+0HTDb55zQKSzojIx9sf2UrRBzRt5ealtsXJOcQ7+az6/GE1OqUA/nXLqOiHS
         yZN4+fuk/wIcL4JTTlLh3maV7pFjK/La6fCeta2jFp/TAp29jpjK0tR3b/wZs8DRX7mC
         hh4aBIXmkf0otgy08HIAupQY2urEOCVBRr/ImuNl3jvpey56RNkrRwTuHDedU+gl0N+t
         eI3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781293436; x=1781898236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0MIzScJKL1xXmPrlbYULoUIxKe1BsiEaaVgILh54qWo=;
        b=kITUZeWdVpjedNyETPsbAJ7v2e1K3lwI2V/i3EVdYF+qBFTP1R2x8cFsG2pDHn2yw9
         ty1xUsvm012C2+Kd929kkN9WWQzlZTCGui3Ruw15mcRUd53f4beSr2ze0M4TSkbs+o6Q
         9xRnngM4jZVRYzNDaGn8Tpc8c8dot8jvnSiGvpi0VO4/jJJ96ssHxxxtGg1LjxX+XvgO
         xapzdI5i3nrx8QkoK5/7LiWs+W2D2Yn+LI5XBN8L7WcFNDaQ1zJTS2ZKYpd0eHvfijDi
         eCbnZQNn30lzy9pAZZUBmO+o9Erj5RI0ZytfIUBY9MXjV7E3L63965pzpvZDHT/LuSwm
         iXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293436; x=1781898236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MIzScJKL1xXmPrlbYULoUIxKe1BsiEaaVgILh54qWo=;
        b=HVpaNxB15NnpBsj0v9jUCZhX/ZGkg5S84ToZbE2wP826C0W7dyobob3zZbLC4BV7oJ
         DNkgiLtIFbNpXVa1/6ojFi70+ORJsLrDROK/wvfi6BAbaApaJHAnToocyHycCbR/sMwM
         gQkVLD5MhhAs10jWXqQaoVs1q5K0rw9zqodEnaEMU9cs/RKwyD2+/JDTnAXAews5tklf
         MoRwbR1SmbeCXv0G8eKuoGPEahClkNBbXehZ/LDTVzVsr/6aYY+qdIa/q2nbyNxCBQiD
         ZTJbPm1no5EDuTVIp8G0Tu6cGt1Hoy5vcF5lAFyw6+Ip6cOzz3KJXSvU+PyPO4axEQBI
         pO1Q==
X-Gm-Message-State: AOJu0Yyg3AhzkIZ4/LxdpkW5wxJlCQlJvkW4N3MgnpsjyGbX5nyenpBO
	SleGDa3vtU8iptZVlCiWb4dnB2lcPsoImO597POz1+joq/k6YMvvcco+rlwt9qrFQok20OxbxAM
	/DdnMBM8gBtZbWn8h01oPDB8BKyM/29Bq1NG+FSru/w==
X-Gm-Gg: Acq92OHw8nQChQvpX5Wr7SsxCJi0ALHqNLuKAnQDYCDuJvzRtzP4MQO8vf3dytU/2v7
	n6m6Dq1BWhSKmPClWdWcGd6179XCUfReu8IyLXNud/00rogz5vC02yJ3X8/iZvVYmhQu1If6Ter
	aJsrJksJaDE6/J5N7axm0OM4VymNPYSNwEjHbR4v+cf+D8VS9eSKappNQQirInsOxYAzfbi2sHn
	mf5q+/+L2AAY+dK2Z60KQq+Cmh9g9iE9jz1eNXLtQ4BkKXl5v4YCOzOwupxiB9Hjk1srRp0ADuj
	rXahSoJz9w7S0sqY8hZfFVHWU8OS5Uf/0ry15IC1s7/G5CuHaQYtEzTvAUkMj3repQ4tE92yfu9
	XZy+RZQ==
X-Received: by 2002:a05:6a00:4146:b0:82f:1b1b:e166 with SMTP id
 d2e1a72fcca58-8434d0aeb79mr6315498b3a.33.1781293435882; Fri, 12 Jun 2026
 12:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780855296.git.lucien.xin@gmail.com> <1b5480358209643e574188ccba83bc9ef0a84aee.1780855297.git.lucien.xin@gmail.com>
In-Reply-To: <1b5480358209643e574188ccba83bc9ef0a84aee.1780855297.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 12 Jun 2026 15:43:44 -0400
X-Gm-Features: AVVi8CcosIZ2HodYXSoI2GurOTwt4JyXnbbeTIrOgwh_78ZtgEuE0FazxT7w2bQ
Message-ID: <CADvbK_cvO+EGvbzySPQc4DvN7GM-94gFZK+_pXMSkj8b9--DDA@mail.gmail.com>
Subject: Re: [PATCH net-next v13 06/15] quic: add stream management
To: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>, 
	kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,vger.kernel.org,gmail.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 441CB67C22B

[sashiko-claude]

> +/* Get or create a send or recv stream by ID. Requires sock lock held. */
> +struct quic_stream *quic_stream_get(struct quic_stream_table *streams,
> + s64 stream_id, u32 flags, bool is_serv,
> + bool send)
> +{
> + struct quic_stream *stream;
> +
> + if (!quic_stream_id_valid(stream_id, is_serv, send))
> + return ERR_PTR(-EINVAL);
> +
> + stream = quic_stream_find(streams, stream_id);
> + if (stream)
> + return stream;
> +
> + if (!send && quic_stream_id_local(stream_id, is_serv)) {
> + if (quic_stream_id_closed(streams, stream_id, !send))
> + return ERR_PTR(-ENOSTR);
> + return ERR_PTR(-EINVAL);
> + }
The recv path here rejects stream IDs whose initiator does not match the
caller's role (a server cannot accept a SERVER_BIDI on the recv path
without it being closed/already-open). Should the send path have the
symmetric guard for peer-initiated bidi stream IDs?
Walking through quic_stream_get() with is_serv=true, send=true,
stream_id=4 (CLIENT_BIDI), flags=MSG_QUIC_STREAM_NEW:
- quic_stream_id_valid(4, true, true) only rejects CLIENT_UNI on the
server send path, so CLIENT_BIDI passes.
- The !send && local block is skipped because send is true.
- quic_stream_id_closed() compares 4 < next_bidi_stream_id (initially
SERVER_BIDI = 1) and returns false.
- quic_stream_id_exceeds() can pass when the peer's max_streams_bidi
is non-trivial.
Control then reaches quic_stream_create():
> + stream_id = limits->next_bidi_stream_id;
> + if (quic_stream_id_uni(max_stream_id))
> + stream_id = limits->next_uni_stream_id;
For a non-uni max_stream_id, stream_id is initialised from
streams->send.next_bidi_stream_id (SERVER_BIDI = 1), so the loop creates
a stream with id=1 instead of the requested id=4, increments
streams->send.streams_bidi as if locally initiated, and advances
streams->send.next_bidi_stream_id past 4.


This is a good catch, will add quic_stream_id_local() for send.

Thanks.

