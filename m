Return-Path: <netdev+bounces-299469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kcg3B+AEMGp0LwUAu9opvQ
	(envelope-from <netdev+bounces-299469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:57:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C0686E3C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:57:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=JnKqJ564;
	dkim=pass header.d=redhat.com header.s=google header.b=DllrCIKz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299469-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299469-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F04D0303FB74
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B6E3F4DCC;
	Mon, 15 Jun 2026 13:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A21990C7
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:56:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531762; cv=none; b=EKYLeKDoveO307TlT4Ulefm8A+VES/SmlBXGHi68CoEJ6fSn+jPfITF5Ip/Ijmxnl92KGkJ5uHmk7pLTT0HgbfBbHfC4L7SFDmgxZYwjXByVvJbdKSyXtDLzirCQAVXbaxYHENqhnGD5tIZZM83DL43Oi3pTWmE4Mfl4EgZ2wVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531762; c=relaxed/simple;
	bh=azPHeJ6RdZ6MYg3yN5YCdVKMCdOR3cGIJZpIxCTg1u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c23ptFp/9CKO9Gnifirw8OqTk2dBuFpvHHlXwTsdjWt1Ysz3fLe0S4XMyHyfTLZOOzD9y+XYFgAjSXB2ltA7NpLtbyUU+TtRPmbCawHeleVm8ITtYuYXMWBbbNldaQ46DzmO6PkgNi83hfRp/8SlH10c4sc9OQx+QF5C7E1OW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnKqJ564; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DllrCIKz; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781531760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPckBN/w9iQXsyyujFhuNAKZOopC9y7aQZ4NPid9/sA=;
	b=JnKqJ564gx0Df2+o3vRwN31TJcQyKWINNRCN9cuy0dX6fP8YCw1rNdWg4ia5CX8xgRHKu8
	00hpZxqnucs+vhExIQPdUM1V7/lWMgvL6g1rqOh1jO/0aH22FyqZfuTR+BamXnJ2JG1odW
	C41xexfTiBTUOiaEag/xa/ORMRIOrtw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ZjG0nHOINFiiBKbGntW4vg-1; Mon, 15 Jun 2026 09:55:58 -0400
X-MC-Unique: ZjG0nHOINFiiBKbGntW4vg-1
X-Mimecast-MFC-AGG-ID: ZjG0nHOINFiiBKbGntW4vg_1781531758
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-68b3e28267dso3683943a12.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781531757; x=1782136557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPckBN/w9iQXsyyujFhuNAKZOopC9y7aQZ4NPid9/sA=;
        b=DllrCIKz4+C6GWqfdsAPxm12vPFHmLsu5gAHu+DQfnESa/FmSJ+ukAKCpw1BSTD2kT
         UPc+FLgkkicj8lajnPOx3jTsBxRDgb1ypVFCAaoFI2yGp6bsw1RZlq0JUfI+KtH5I02/
         QsPG9CS+gvhjsfoB+PZGcEsWBpcIK2jZZ02SBWAP34IqZkw2j3RU5nEJWQiaInvqD+EX
         fHxns0vQD8iTFrqDItYv8e0mrYHgdqf8rcbOIPO6kTko/Enq+YMAyZs4rrjzOTewu5sg
         9Vordw3+VGH6vb5cFxinnViqQNaOi1Uv6IObtR1aqdTsJPgMPpcPM6PcZGtiTbzTbwxI
         PIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781531757; x=1782136557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPckBN/w9iQXsyyujFhuNAKZOopC9y7aQZ4NPid9/sA=;
        b=MatAE4t/xcm1sNTK2yYb2pRK2WyEF7VV+KCzAoiiRI6EABLeT9K2NOrVIk+b7qPEPW
         Lwx2M/w8rF7lneUd5K4l2coda3tK0BuEVZDopbG+NwojcC9Fi27lA9J1xEaLkXbY1yHu
         C1aoSEi67QgbUnAKaWu1GD7S6fbULGGW38Jc7D75iElebaaEM3ahUnt8FVF6TtIInTsR
         qP/TeHL1HPOSWddFNXKCmnKWi0B9w8EYLPc/tEZnraignD5rtiBKXmBND9Awwk/HvClL
         mfIVT0HlIDvRwylUvYbFiJDFScAjUzoO8S8fSCt/9pZbn6y9I8V1Ll6dcbzypkzYdG+A
         Hvsg==
X-Gm-Message-State: AOJu0Yyo3RSZOBFX1siK1Mz0G9H+mFMI4Z7qD7Dzg/IHbQ19MYA1v1XA
	eCjC0pgFUFjXfpoKC+L/NUs46vQbhUMcf8xsc3sqVJb/6p8xj+l+Nfr5TuLZMEfcQ+BIYaiHBLE
	wA1ZsmqYswuTvZPKjRw4QNLxKYPLUkQ/3KYrR4LiZJ7jkDVeVNcxtsTBtIQ==
X-Gm-Gg: Acq92OHrR4AAh3BTuD+Ica57K85E6PntxUDIxy0Vw9TdXW+g6k4H6Bc2jqpc8MXdJjE
	knfO2b32ZZy1frC4gR8bZRXZYNbq6zGGL46x/U9zd+ZE6hllOKgeqL7X8uejusTJCV9B6b9jXmz
	vK6VEkKypOFYwP0Kns2146J9gupYDzL/D+pT6j67n35/6nN8YJmM3LDffKOusU9t539I7gef/bW
	atpKcQAyxHVD7zdL2pEJpSUVun3bPU1vAnsJGGrqQagSjJ081/SzIIFWBDlfmEF3ZXv1WxpuhzB
	9jjHy22J0ZQbjzEN/GUamsyFB0bZC//sBJJ4TKZKOeQPdhwt13cJARRokSKXH0qh6r8gyvvDlgA
	YMCtwASellpCOR4nTjbu2ciz+LvO8bk5dI+xavD7Qo7IFCLdTwAxNdU2af6gWdvNtNk5Mxg==
X-Received: by 2002:a05:6402:350c:b0:687:9c0f:5897 with SMTP id 4fb4d7f45d1cf-693c6a16992mr4050531a12.9.1781531757562;
        Mon, 15 Jun 2026 06:55:57 -0700 (PDT)
X-Received: by 2002:a05:6402:350c:b0:687:9c0f:5897 with SMTP id 4fb4d7f45d1cf-693c6a16992mr4050500a12.9.1781531757036;
        Mon, 15 Jun 2026 06:55:57 -0700 (PDT)
Received: from [10.44.33.51] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693ab54e6e5sm2952596a12.1.2026.06.15.06.55.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 06:55:56 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, pabeni@redhat.com,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 "open list:OPENVSWITCH" <dev@openvswitch.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/4] net: openvswitch: add per-flow_table
 lockdep checks
Date: Mon, 15 Jun 2026 15:55:55 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <FE904B6B-A82F-4657-A323-2EDB59FA0979@redhat.com>
In-Reply-To: <20260611045817.1302665-3-amorenoz@redhat.com>
References: <20260611045817.1302665-1-amorenoz@redhat.com>
 <20260611045817.1302665-3-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299469-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:amorenoz@redhat.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:pabeni@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:dev@openvswitch.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A50C0686E3C

On 11 Jun 2026, at 6:58, Adrian Moreno wrote:

> A future patch will introduce a per-flow_table mutex that will protect
> flow operations independently. In preparation for that, this patch
> introduces a flow_table lockdep macro, and modifies some function
> signatures to allow lockdep assertions to run.
>
> For now, the actual lockdep check logic is a no-op, but adding the
> infrastructure helps reduce the size of the upcoming patch.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Hi Adrian,

See some comments below, and maybe address the Sashiko comment in the
commit message.

Cheers,

Eelco

[...]

> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index e78c28dd5d9d..72ad3ed12675 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -840,15 +840,16 @@ static size_t ovs_flow_cmd_msg_size(const struct =
sw_flow_actions *acts,
>  		+ nla_total_size_64bit(8); /* OVS_FLOW_ATTR_USED */
>  }
>
> -/* Called with ovs_mutex or RCU read lock. */
> +/* Called with table->lock or RCU read lock. */
>  static int ovs_flow_cmd_fill_stats(const struct sw_flow *flow,
> +				   const struct flow_table *table,

Should 'table' come before 'flow' to be consistent with
ovs_flow_tbl_insert() and ovs_flow_tbl_remove()? This applies
to all functions in this patch adding the 'table' parameter.

>  				   struct sk_buff *skb)
>  {
>  	struct ovs_flow_stats stats;
>  	__be16 tcp_flags;
>  	unsigned long used;

[...]

> diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.=
h
> index 6211bcc72655..3e5e9845c28a 100644
> --- a/net/openvswitch/flow_table.h
> +++ b/net/openvswitch/flow_table.h
> @@ -72,6 +72,22 @@ struct flow_table {
>
>  extern struct kmem_cache *flow_stats_cache;
>
> +static inline int lockdep_ovs_tbl_is_held(const struct flow_table *tab=
le
> +					  __always_unused)
> +{
> +	return 1;
> +}
> +
> +#define ASSERT_OVS_TBL(tbl)   WARN_ON(!lockdep_ovs_tbl_is_held(tbl))
> +
> +/* Lock-protected update-allowed dereferences.*/
> +#define ovs_tbl_dereference(p, tbl)	\
> +	rcu_dereference_protected(p, lockdep_ovs_tbl_is_held(tbl))
> +
> +/* Read dereferences can be protected by either RCU, table lock. */

nit; This comment reads odd, maybe;

/* Read dereferences can be protected by either RCU or table lock. */

> +#define rcu_dereference_ovs_tbl(p, tbl) \
> +	rcu_dereference_check(p, lockdep_ovs_tbl_is_held(tbl))
> +
>  int ovs_flow_init(void);
>  void ovs_flow_exit(void);


