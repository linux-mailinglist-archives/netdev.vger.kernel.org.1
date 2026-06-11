Return-Path: <netdev+bounces-298220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vnE4IXnmKmo5zAMAu9opvQ
	(envelope-from <netdev+bounces-298220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:46:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC20673AB3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:46:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XPwrEJuq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298220-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298220-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09B633371841
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C00425CD6;
	Thu, 11 Jun 2026 16:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5540BCD0
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:27:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195226; cv=none; b=aVcxNVdYXvtoRjxpSJnPlIvAtZFryrqSy98tpUMyzmh2f8EWV7+6u5bSbt+kR6eje4If/P6sNWouZG3nWg2GXRSBNuaRNAhe/ZUwLJ3NxnlPrUOT1Ss5p5Zo5N2Ov31Xnsk4+VPLrT+eqWUzKKMWGAwha7PJboyWVQNc/bfhdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195226; c=relaxed/simple;
	bh=cAbqpXtpBfIChkS2icEuZxRztc3RLiCrmte818eDwgQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=J0a1HHTVT6f6ZRhwenhsjD+/lZgZ1pbiSvQWPUjGRv2eLEdV2wf7/Ja4oZ+3I5NxZAd8xzhht92bn9xauZwW6xgacqdnhyqeeLJdKwgknlXJ0D97MfuD1wtFWuo0lV36ekZ4RsFDjuM40f8f4qSoroNBgBidZAWJSoTPWIcUPOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPwrEJuq; arc=none smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13807d2f898so5843c88.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195224; x=1781800024; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIQ0zMQkILDWGcn93CGMgKvcLA3VvTscsfQrUNo9JBI=;
        b=XPwrEJuqu8by+5Qd5ei1ZDQwCmKRjusfSFtBVvubpEfrBtSB5NZz0PymgQlW2hlZPx
         0wH2Bm9oLudfcJAkTjVxuy2Ee0L5nUMadpv9p2AhTj3140u2oEqs8P9R3+zKC6b37bU0
         xLNelLPBJeEM4G7ZlU04/0yXZv7mScvd6gbVof+Bqz0WYuG1UZeUm2Iu54V0basueBcr
         +gp17KwVB93h2zFnvwtFDYeFWlJxWN5tR5rSFQvxv6O9rSYEsospZc9iKH6BfGFZ1dTm
         kyy5PWBbIU433ydMqUxkz1rK91dbX8TX66oF6efBXTVU7oHKcBAcySAWQ1lFlDdM+vZ+
         rjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195224; x=1781800024;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIQ0zMQkILDWGcn93CGMgKvcLA3VvTscsfQrUNo9JBI=;
        b=EFofPM2uZil5SS3TFVMysQWOqpMi6avU1QR8W6rVxAadJC0AcUQSPmOz/JjJQSKFNl
         l22oEAxEg7kO3K5vRL+z4+KTEamuNQg7rB10g1UYELEa/+u/kqpTBnU4RHtLmuOUltRL
         +qL1dgxwPS1K+wRR+8usagGYXgzpzcbBVd4O6JYWJaagM5xgE0A+8XfbvCX5aZIqFqSF
         4B15fj5MAJfvp+dcB5hQF7QcHZznbxzybopuSisRkqxq6nahp4Zc3J4gNHg9CBBuP3VX
         O1F4lQMz5EoP1exLMcQN46v1wCNAOucnYnREqH3jIo9yFXIuEIUnxOc+xau8j3zpBjH2
         ISxg==
X-Forwarded-Encrypted: i=1; AFNElJ9TtqTBgAPGixu12UpDknnyZXgspebLp7zAppDS1irwOxpVknpiBXlAIgRymRVE2m+54Iguy74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8ON08A4+gpwpIgNZMImIzUuDuRDjMMquIYCHRIx5knFpyWDW
	acdeP/AbMy/arEwZfKS3UIZk29DLjY7wOr4KaK5Psygn0U9GdxXI7iVG
X-Gm-Gg: Acq92OH0VSHHtXr7WfNpwB8gmkFV+JfnMJ0Ag3V1Fg1p9Z37H8NM7iRe0Dv+4RaR+aS
	RjQCv7/vUlo7WLFheyHJfR08OzQqp0zyuFttGZhy0YaCn4OAye5e2c5uFULzVJeTkVSP7UUYQ0p
	E/93UaM2hFXk/2ZnZ9EgHh9RzsZdZE7pJQ/nxRTn5iO5xwBDIaeoF35yezNbbFLf5sfzUyjwNbu
	xqSvHTlYI3lJTWB2qSuD1404/XiFT8fqv0JY7GoqdiPAIvBhAwxvh/9fw310FekrkS2itvt7FNt
	ueYo45WRDE+tk/zNmKr+/BILcgo9TgKQWgkbeRYH0VZxgCY/ttNOd8RdqEPR7AIRyWVmFPJOvT0
	5wEvrfSwVBoNvTZM7K/F475jKa7hrk7rJz2Mgc8XvNNw9fRzfhTQxqZVCV4j0gOofGvC+QkQSaM
	fE2mu4XjHI0ST8jjk09QI6rL/AjiUVzS1MyRN8XvTIZ9KPkc1ZS5Y=
X-Received: by 2002:a05:7022:fd08:b0:130:7246:10aa with SMTP id a92af1059eb24-1384218087fmr1769445c88.12.1781195223900;
        Thu, 11 Jun 2026 09:27:03 -0700 (PDT)
Received: from localhost ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138430452a2sm2275834c88.14.2026.06.11.09.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 00:26:58 +0800
Message-Id: <DJ6D0B3KSMYU.1KE7UIQCA7K2N@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>,
 <linux-atm-general@lists.sourceforge.net>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH v2] atm: fix use-after-free in sigd_put_skb()
From: "Weiming Shi" <bestswngs@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Chas Williams" <3chas3@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260609162107.2865310-2-bestswngs@gmail.com>
In-Reply-To: <20260609162107.2865310-2-bestswngs@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298220-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:3chas3@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFC20673AB3

On Wed Jun 10, 2026 at 12:21 AM CST, Weiming Shi wrote:
> sigd_put_skb() delivers a signalling message to the daemon socket named
> by the global @sigd pointer, ending in a call to sk_data_ready(). It
> reads @sigd with no synchronisation, so it can race with a close of the
> daemon socket: sigd_close() clears @sigd and the socket is then torn
> down and freed.
>
> Holding a reference on the socket is not enough to make this safe. The
> daemon fd close runs __sock_release(), which frees the struct socket --
> and the wait queue that sk->sk_wq points at -- via iput() once
> ->release() has returned. sk_data_ready() (sock_def_readable()) then
> dereferences a freed sk_wq:
>
>  KASAN: null-ptr-deref in range [0x0000000000000188-0x000000000000018f]
>  RIP: 0010:sigd_put_skb (net/atm/signaling.c:65)
>   sigd_enq2 (net/atm/signaling.c:228)
>   sigd_enq (net/atm/signaling.c:237)
>   svc_bind (net/atm/svc.c:135)
>   __sys_bind
>   __x64_sys_bind
>   do_syscall_64
>
> Fix it on both sides. sigd_close() now calls sock_orphan(), which under
> sk_callback_lock sets SOCK_DEAD and clears sk_wq before the socket is
> freed. sigd_put_skb() latches @sigd with READ_ONCE(), pins the socket
> with find_get_vcc(), and then takes sk_callback_lock; it delivers only
> while the socket is still the signalling daemon and not yet SOCK_DEAD,
> otherwise it drops the skb. sk_callback_lock is used rather than
> lock_sock() because sigd_put_skb() can be reached from vcc_sendmsg() ->
> sigd_send(), which already holds lock_sock() on the daemon socket.
>
> The READ_ONCE(sigd) !=3D vcc check also rejects a reused VCC: a caller
> preempted between latching @sigd and validating it in find_get_vcc()
> could otherwise match a freed-and-reallocated, live (non-SOCK_DEAD) VCC.
> This needs a concurrent (privileged) daemon teardown, so it is hardening.
>
> Triggering the use-after-free requires CAP_NET_ADMIN and CAP_SYS_RAWIO
> to attach the daemon.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v2:
>  - Also bail when READ_ONCE(sigd) !=3D vcc, rejecting a reused VCC that a
>    preempted caller could match in find_get_vcc() (hardening, no stable).
>
>  net/atm/signaling.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/net/atm/signaling.c b/net/atm/signaling.c
> index 358fbe5e4d1d0..346fb969166e8 100644
> --- a/net/atm/signaling.c
> +++ b/net/atm/signaling.c
> @@ -54,14 +54,32 @@ static struct atm_vcc *find_get_vcc(struct atm_vcc *v=
cc)
> =20
>  static void sigd_put_skb(struct sk_buff *skb)
>  {
> -	if (!sigd) {
> +	struct atm_vcc *vcc;
> +	struct sock *sk;
> +
> +	vcc =3D find_get_vcc(READ_ONCE(sigd));
> +	if (!vcc) {
>  		pr_debug("atmsvc: no signaling daemon\n");
>  		kfree_skb(skb);
>  		return;
>  	}
> -	atm_force_charge(sigd, skb->truesize);
> -	skb_queue_tail(&sk_atm(sigd)->sk_receive_queue, skb);
> -	sk_atm(sigd)->sk_data_ready(sk_atm(sigd));
> +	sk =3D sk_atm(vcc);
> +
> +	/* Pairs with sock_orphan() in sigd_close(). */
> +	read_lock_bh(&sk->sk_callback_lock);
> +	/* Bail if torn down, or if the slot was reused by another VCC. */
> +	if (sock_flag(sk, SOCK_DEAD) || READ_ONCE(sigd) !=3D vcc) {
> +		read_unlock_bh(&sk->sk_callback_lock);
> +		sock_put(sk);
> +		kfree_skb(skb);
> +		return;
> +	}
> +	atm_force_charge(vcc, skb->truesize);
> +	skb_queue_tail(&sk->sk_receive_queue, skb);
> +	sk->sk_data_ready(sk);
> +	read_unlock_bh(&sk->sk_callback_lock);
> +
> +	sock_put(sk);
>  }
> =20
>  static void modify_qos(struct atm_vcc *vcc, struct atmsvc_msg *msg)
> @@ -257,6 +275,9 @@ static void sigd_close(struct atm_vcc *vcc)
>  		pr_err("closing with requests pending\n");
>  	skb_queue_purge(&sk_atm(vcc)->sk_receive_queue);
> =20
> +	/* Make a concurrent sigd_put_skb() observe SOCK_DEAD and bail. */
> +	sock_orphan(sk_atm(vcc));
> +
>  	read_lock(&vcc_sklist_lock);
>  	for (i =3D 0; i < VCC_HTABLE_SIZE; ++i) {
>  		struct hlist_head *head =3D &vcc_hash[i];


