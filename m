Return-Path: <netdev+bounces-299470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ykBAGMUEMGpmLwUAu9opvQ
	(envelope-from <netdev+bounces-299470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:57:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E58686E30
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:57:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=N29j0vYL;
	dkim=pass header.d=redhat.com header.s=google header.b=AStNdejO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299470-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299470-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11AC7300BE9E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE893F5BD8;
	Mon, 15 Jun 2026 13:56:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FF1990C7
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:56:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531770; cv=none; b=S5kvWoDsIXoTNaY/woaxcpOZHDN7087iYxRnvl8bWEjNOT9h+NaSgRR5+p1pwOzRf2xfYau8jf0OvBaF0mQ3qnKAoqy5QcvSqQsVoTOhb1P0ktXh4YfVLUr1Tjp296LDuSwmjP9DhmcwkA5MTIm5q4b/6jrCtuE6V3bKoDKSogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531770; c=relaxed/simple;
	bh=y75oEhy1DRi4U4yG7RuJWtWzbps1+v/W9t3iBPgp+UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kp3KIXg3Gg8zZtRJF9gtzrDCb58bCvh0Qr8T7UDaaqUNNaJruYzfkO/wGpMYJEKJWbPrh+Wn/LyEXIk1aPXB0CgSu2ZW8jMAcp61fUW2eP+kTo9CgP5aUonCVWVXzFyCXopNPYP5K//aP931a2xz3CPX3/Xe1W1/Gz1KiOb5UPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N29j0vYL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AStNdejO; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781531768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TW1Wrsk+zaA+ammSTMdEakEIIxxSSupjdSwowRTMk9g=;
	b=N29j0vYL1bAJR/4INweMC6JutXkvP2+z581UZS0rTHqysIGKnf7fFcXrD+6f1tnuet/bIz
	UEAhQw900AOb4220ufOHHxLFNBUM0MREl7E4ysc7SuzLXDDumdUiGkQ+oshJILpDTFKl+6
	Zj7TjV7zRlk15Ad3nc0TtW3PJ/9y4ug=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-Rf8mkMMTN2uUw_IGzjNTsQ-1; Mon, 15 Jun 2026 09:56:05 -0400
X-MC-Unique: Rf8mkMMTN2uUw_IGzjNTsQ-1
X-Mimecast-MFC-AGG-ID: Rf8mkMMTN2uUw_IGzjNTsQ_1781531764
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bdad545342aso451132066b.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781531764; x=1782136564; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TW1Wrsk+zaA+ammSTMdEakEIIxxSSupjdSwowRTMk9g=;
        b=AStNdejOINK1iu/TfARNMaoV0pF8Wo7JUed7gf10FDRxVoYrfWcBCJ/qviRmF+E7SA
         7O6fnTMOq7FNDIjy7cvfkGjFhTD5cFkaWWBqxBtSu2dMcW90w8BbcUPLCoMxUppE4HbA
         VWVgKTtLQIZdV89AhlbffVRHeukjLft+XeANOGq5xduaEDaR4N2/fgoQUXsYeoJp301d
         G5ZBXAuHxOXdgoYftGzxgxM+qZgShG1uYdh5q8xktJkLoostppncfR1AWQuW0NhzkFPm
         DXxc5HClC4smffosSkoDZ7Jjvk58W3ktzwqhNdbPa7GFcVKc8QYE/NOZBkbqDS7E05NZ
         I9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781531764; x=1782136564;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW1Wrsk+zaA+ammSTMdEakEIIxxSSupjdSwowRTMk9g=;
        b=M3NBsY5Nr6OX8WDn8YkySVKb2iNdWv8euEhY4+z/y674PpWExWHNrvuabO0/A8Dq20
         auU3P+Q2cXYyzyjXcAl88cLZCfh7Knyt9W/FFCSQqXZT5zJorK/cDSpcYe4NcHDxtLbL
         eAtrqiHjWvjF6vh9DdPz628OhjW91uHJT/3YXVCWAMRvnp/Wdhid9THFJ9HKGxNNtXxC
         ZPQr/hnMKVOesDgw0cx8BuBWJuniBngn8bfjrn88BgCsYsTTWMRE35co/t3z0ecRCuyx
         bydXp0OW8vJChlttvHtKVPVMt1zCkcOSnSt8GfSyOnUsG+8jJk2mhS0gbL9PqVRLBypT
         v3zQ==
X-Gm-Message-State: AOJu0YxKNbFut9TMN5ujDQGRo5bDc8ij6SFIonETYIze103JIGoV5kvQ
	tCsxPBBiFDidUa7C1w30lKLoBPAIaj7BCXf1ASmLP4zVBPfwt8IBnGVD2Ob6cfUzPgPN7DpaG2F
	6cB+yqJmTE8JLwnCOt9s1MYvt8H4IWM/xsVYbdZSRhzNIx6LtQDAt3eKK5Q==
X-Gm-Gg: Acq92OEn9kCP52G44btdrIDEQG4RQrcC7MPvfYULUNXMtiyqm+oyS9xz1JVl2pitvof
	x7w6kRKjSUvwbW3kKACYVj03lR4NGB6Wn51wNWvXM3GKDiRY9/FRGvk1zUpRSF4v3uCbOio6Mk1
	ixR1/PvQj+FSoezZ26+dw4m9dSSqq+msZDzH6qs/++f9Y4G/T0ME92OyzJv1VrCesHWrcxWlhgi
	AGkpGAPF0i7rJ3oMb75J70j+XFNCv4Les0aetg7MgPisf7H9UYNH4ap/hdpHcmmqYVliAx+Ynrm
	oBJZfZBZRm/QBknI17PGi4J86BOpEk3KFuswEgLwXM+dpwVUj36fCsEX8sRcLtD2OuG0OLdRN9G
	SPXrCBOZsOcPYHGLfrggE2Q/6pjlxngMwQXWtU2aCtfZtLIyLVRdEgLBKKmrzroD5TqgEXw==
X-Received: by 2002:a17:906:5193:10b0:bec:64d4:3872 with SMTP id a640c23a62f3a-bff4c6fb2b3mr325818866b.24.1781531763914;
        Mon, 15 Jun 2026 06:56:03 -0700 (PDT)
X-Received: by 2002:a17:906:5193:10b0:bec:64d4:3872 with SMTP id a640c23a62f3a-bff4c6fb2b3mr325815466b.24.1781531763379;
        Mon, 15 Jun 2026 06:56:03 -0700 (PDT)
Received: from [10.44.33.51] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693ab54e6e5sm2952596a12.1.2026.06.15.06.56.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 06:56:02 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, pabeni@redhat.com,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 "open list:OPENVSWITCH" <dev@openvswitch.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/4] net: openvswitch: avoid double-rcu wait
 period
Date: Mon, 15 Jun 2026 15:56:01 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <1913A0FD-1B8B-408B-8F5A-0612854DB5C6@redhat.com>
In-Reply-To: <20260611045817.1302665-5-amorenoz@redhat.com>
References: <20260611045817.1302665-1-amorenoz@redhat.com>
 <20260611045817.1302665-5-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299470-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67E58686E30

On 11 Jun 2026, at 6:58, Adrian Moreno wrote:

> Avoid waiting for two rcu periods by scheduling the deletion of the
> flow_table and all of its referenced structs at the same time.

Hi Adrian,

One small nit below; the code itself looks fine to me.

Cheers,

Eelco

> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/openvswitch/flow_table.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
> index 3934873a44c3..35232e1af8aa 100644
> --- a/net/openvswitch/flow_table.c
> +++ b/net/openvswitch/flow_table.c
> @@ -527,30 +527,33 @@ static void table_instance_destroy(struct table_instance *ti,
>  	call_rcu(&ufid_ti->rcu, flow_tbl_destroy_rcu_cb);
>  }
>
> -/* No need for locking this function is called from RCU callback. */
>  static void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
>  {
>  	struct flow_table *table = container_of(rcu, struct flow_table, rcu);
>
> -	struct table_instance *ti = rcu_dereference_raw(table->ti);
> -	struct table_instance *ufid_ti = rcu_dereference_raw(table->ufid_ti);
> -	struct mask_cache *mc = rcu_dereference_raw(table->mask_cache);
> -	struct mask_array *ma = rcu_dereference_raw(table->mask_array);
> -
> -	call_rcu(&mc->rcu, mask_cache_rcu_cb);
> -	call_rcu(&ma->rcu, mask_array_rcu_cb);
> -	table_instance_destroy(ti, ufid_ti);
>  	mutex_destroy(&table->lock);
>  	kfree(table);
>  }
>
>  void ovs_flow_tbl_put(struct flow_table *table)
>  {
> +	struct table_instance *ufid_ti;
> +	struct table_instance *ti;
> +	struct mask_cache *mc;
> +	struct mask_array *ma;
> +
>  	if (refcount_dec_and_test(&table->refcnt)) {
>  		mutex_lock(&table->lock);
> -		table_instance_flow_flush(table,
> -					  ovs_tbl_dereference(table->ti, table),
> -					  ovs_tbl_dereference(table->ufid_ti, table));
> +		ufid_ti = ovs_tbl_dereference(table->ufid_ti, table);
> +		ti = ovs_tbl_dereference(table->ti, table);
> +		table_instance_flow_flush(table, ti, ufid_ti);
> +		table_instance_destroy(ti, ufid_ti);
> +
> +		mc = ovs_tbl_dereference(table->mask_cache, table);
> +		ma = ovs_tbl_dereference(table->mask_array, table);
> +		call_rcu(&mc->rcu, mask_cache_rcu_cb);
> +		call_rcu(&ma->rcu, mask_array_rcu_cb);

nit: Would it be cleaner to extract the destruction logic in
ovs_flow_tbl_put() into a separate static function, e.g.
ovs_flow_tbl_destroy(), to separate the refcount handling
from the actual cleanup?

>  		mutex_unlock(&table->lock);
>  		call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
>  	}


