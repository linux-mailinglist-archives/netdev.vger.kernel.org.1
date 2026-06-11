Return-Path: <netdev+bounces-298230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zSH0JHjmKmo4zAMAu9opvQ
	(envelope-from <netdev+bounces-298230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:46:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEBF673AB0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:46:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Cj1fokFh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298230-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298230-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D130309085C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3673A872B;
	Thu, 11 Jun 2026 16:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32134040E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:45:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196316; cv=none; b=tfSAB9x34ASb+Xfsj3/F4LUv2YJh/oLdrn9i/I8qw41m1r6dV8zRCp0zgzRLzvvG122pFy3qJMARwGma2ubcOUn5iedBwuKqz7AlcrxOnCCpzQljhrtC0dgSmk6IkmWuZ0exNhFtkl+ZCUADbWbiE/MXP2FvhEK7TUlnv5rNWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196316; c=relaxed/simple;
	bh=eoDaWDBXYJeLcDF9mSfKTCRaUJsOMqahefPGRT0/AGU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=V9bi1skgRPNW8E0m9xWAJVodrP94aeerHPuwrdDx1ZOJEp/T2ANh5sStGe9LtQF6adpwHmYyR7kfVCdAXTWBR76FvICpoT5nLdQ1RTPIk92hl2oCD6O2mvsqiaGYkol+S5Nxed0aiKG9OrxFt8VXP+oWBTTiDZn04goG8xC8dmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj1fokFh; arc=none smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137ec563a95so25795c88.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781196313; x=1781801113; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvWDNY3Gjw9OYKYBFLQFihLG0PJK2utsvZ3byDHLtuI=;
        b=Cj1fokFhVhgPQJ3RcWu5jnBJDmj1TApQnI28qnXEbJgWRVZvAZxVndqz2x+Tljsa4A
         Q2IW2rpe+rCCEf8+sZBFRBoQuSudzSfQJktD0X7fYp/V24l2riQIz+MZlrySR4BmKFOZ
         0iZfrJPzwdqOJqKZOzfh7PWOsD3S80opcKrW6a+kt8/xok2AjvljoSy2vcHydHK/TqkI
         /r9rIPTq6IRATerP1IVnISBP4R5/U0U7iPeJqLsTa2l7ITIupVjcpQlGfF79WH8UheC4
         SiWEZyIhoBaMCotyJD881qXTsDdIAQtB2VvVR6XdkGULINGklV+ZdLli5CmKwec6ho4K
         LGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196313; x=1781801113;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvWDNY3Gjw9OYKYBFLQFihLG0PJK2utsvZ3byDHLtuI=;
        b=eWKLlW7O9e4S+4o7U0AVXEtg91HLR6bE4M9Gi9sqdyxN8p5Mxh+9qGBpM4fPPvSK4i
         DsueCahiqWLuERl8hMeVDaJ7fP2M6LHEdY1EOQn+Lhsn89Zlc3RF+BSGVAdcGXsoPFVU
         t+QJLX0oZALGmRulCqBNf+8ZrKob4Krb2DDb+xYNoGuuTbxO78pLZCYtwqWzb7hJoJ8n
         jsDZpwWoLIHWJdhnTkTyG4KEa0WCjYd5+6OS0LDCpQxskjvaJK6mJoGQBa2yaStPs2wl
         8+FLSt1dBDxYeLbeR+KFSCtz+ekOWsQnHfzXqP084DePZOAZAZKfYNJ1wSdJeAIFdDCF
         wBHg==
X-Forwarded-Encrypted: i=1; AFNElJ8cbNFHuAfL4U6WJ0ySTpXVziqLnNUClZphNTERkku8Y3NDEvGXw3CYxUz0ez3uF94MnW9N/qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxYRRxPbFGCI33pfUvmW/0yU04FGQg0ReA5mEjM+ePo0hQoR1
	htuewUE7y8P0q2YapIcpThCc571hCYlGYEONZiBHDRimR7lW5VYPnTjP
X-Gm-Gg: Acq92OHJFCYlOFmSJd1QfizM5WpM1c8ZfTtzrcMMi43/v57Mx/KDVvjAWJiQr3X6mXg
	DkJr0JMrfTL48G/QRxqx3lWxhOFR8VJB/t8AmYOxboRVa8bXVWDHIbi77LmJlHL96BYpABHLUL0
	Z1uQPO0rLM/7gIWR2yePJ4fNDOzj8F8cwDGT4B8St6NCp5Ei0DYugQab+1YxVJxN+hWOkbhPEa6
	nzQphKSC1swuo7VmU9GGTCePWyPnQZQoCv+yU+uXWOUXtkITCcWcxR2nB1TahOYxeE2Q6ejYPNp
	yyba3bt+WnsT2svI0Uhp/A++lTwoaYexOzNW0MirDZfUMPbROYCVD8fKd7BUa4iRqzpR+qNL2ju
	28rLItTjEJpL+MwMqt+XUkc68h+4iczF7eWVMHCNV1CfEveawM8Y+5z4B3rMmQMsnksBt+I38Gj
	3WdlmF6PPwkW1gxcOm4TnqkIa+GKEej90QKFAV+36lIvhCcsBzBTs=
X-Received: by 2002:a05:7022:fd04:b0:138:1569:6f1 with SMTP id a92af1059eb24-13842164222mr2295767c88.11.1781196312961;
        Thu, 11 Jun 2026 09:45:12 -0700 (PDT)
Received: from localhost ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138430452a2sm2324929c88.14.2026.06.11.09.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 00:45:07 +0800
Message-Id: <DJ6DE76H4G9V.YMAE26Y0O3DM@gmail.com>
Subject: Re: [PATCH net] net: atm: fix use-after-free in sigd_put_skb()
From: "Weiming Shi" <bestswngs@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Paolo Abeni" <pabeni@redhat.com>
Cc: <3chas3@gmail.com>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <kuba@kernel.org>, <edumazet@google.com>, <horms@kernel.org>,
 <linux-atm-general@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
 <xmei5@asu.edu>
X-Mailer: aerc 0.21.0
References: <20260604164916.2681964-2-bestswngs@gmail.com>
 <20260609110615.196819-1-pabeni@redhat.com> <aigrk5B3VzaWgKIF@Air.local>
In-Reply-To: <aigrk5B3VzaWgKIF@Air.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298230-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:pabeni@redhat.com,m:3chas3@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com,lists.sourceforge.net,asu.edu];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FEBF673AB0

On Tue Jun 9, 2026 at 11:49 PM CST, Weiming Shi wrote:
> On 26-06-09 13:06, Paolo Abeni wrote:
>> From: AI Reviewer <ai@example.com>
>>=20
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>> Full review at: https://sashiko.dev/
>> ---
>> net: atm: fix use-after-free in sigd_put_skb()
>>=20
>> This commit addresses a use-after-free in sigd_put_skb() by pinning the
>> socket with find_get_vcc() and checking if it is marked SOCK_DEAD under
>> the callback lock.
>>=20
>> > diff --git a/net/atm/signaling.c b/net/atm/signaling.c
>> > index b991d937205af..3dbe8e0fdc9af 100644
>> > --- a/net/atm/signaling.c
>> > +++ b/net/atm/signaling.c
>> > @@ -54,14 +54,31 @@ static struct atm_vcc *find_get_vcc(struct atm_vcc=
 *vcc)
>> > =20
>> >  static void sigd_put_skb(struct sk_buff *skb)
>> >  {
>> > -	if (!sigd) {
>> > +	struct atm_vcc *vcc;
>> > +	struct sock *sk;
>> > +
>> > +	vcc =3D find_get_vcc(READ_ONCE(sigd));
>>=20
>> [Severity: Critical]
>> Does this introduce a regression where an ABA vulnerability allows a KAS=
LR
>> bypass if the daemon socket is freed and reallocated?
>>=20
>> If the signaling daemon is closed, sigd is cleared and the socket freed,=
 but
>> an unprivileged thread in sigd_put_skb() might have already latched the =
old
>> sigd pointer.
>>=20
>> If an unprivileged user subsequently creates a new ATM socket, couldn't =
the
>> slab allocator reuse the exact same memory address? In this case, find_g=
et_vcc()
>> would match the raw pointer and return the attacker's new socket.
>>=20
>> Since the attacker's socket isn't marked SOCK_DEAD, sigd_put_skb() would=
 blindly
>> enqueue the signaling message to the attacker's receive queue.
>>=20
>> Because the message contains literal kernel pointers (vcc, listen_vcc),
>> wouldn't this allow an unprivileged KASLR bypass and message injection?
>>=20
>> [ ... ]
>>=20
>> [Severity: High]
>> This is a pre-existing issue, but does sigd_send() leak memory when queu=
ing
>> SKBs to a closing listening socket?
>>=20
>> When processing an as_indicate message, sigd_send() resolves the listeni=
ng
>> socket via msg->listen_vcc, acquires lock_sock(), and appends an SKB:
>>=20
>> net/atm/signaling.c:sigd_send() {
>>     ...
>>     lock_sock(sk);
>>     if (sk_acceptq_is_full(sk)) {
>>         ...
>>     }
>>     sk_acceptq_added(sk);
>>     skb_queue_tail(&sk->sk_receive_queue, skb);
>>     ...
>> }
>>=20
>> Does this code blindly queue an SKB without checking if the socket has b=
een
>> marked closed (ATM_VF_CLOSE) and already purged?
>>=20
>> If the listening socket is concurrently closed, vcc_release() will lock =
the
>> socket, purge its receive queue, mark it closed, and release the lock.
>>=20
>> Could sigd_send() then acquire the lock and append the new SKB to the de=
ad
>> socket's receive queue? Since sk_free() expects an empty queue and does =
not
>> purge it during memory free, would this permanently leak the SKB and all=
ow
>> an attacker to exhaust kernel memory?
>> --=20
>> This is an AI-generated review.
>>=20
>
> Thanks. The find_get_vcc() issue will be fixed in v2; the sigd_send()
> leak will be sent as a separate patch.

Hi Paolo,

This is the link to the fix for the above bug.

v2: https://lore.kernel.org/all/DJ6D0B3KSMYU.1KE7UIQCA7K2N@gmail.com/
leak memory fix: https://lore.kernel.org/all/20260611163805.2151734-2-bests=
wngs@gmail.com/

Best,
Weiming Shi

