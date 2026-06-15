Return-Path: <netdev+bounces-299471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Xi/I9cEMGptLwUAu9opvQ
	(envelope-from <netdev+bounces-299471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:57:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E684686E33
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:57:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=THrEkg6c;
	dkim=pass header.d=redhat.com header.s=google header.b=OSzjgiGh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299471-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E447300B0A9
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3323F4DCC;
	Mon, 15 Jun 2026 13:56:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE953ECBEE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:56:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531780; cv=none; b=onTeeh0J0bwMyJpitwP2McSAYRJjX5Zucvksa+/Rfh8t3mbXs7ERxTSnc0JtWwLtuNw4eTl5OEyJfqtzHdI8xssuV2hFNNYC4nAUxFFrGGQ4MMBskUm72tXXByttHyxyCmadZPw+92WEip9YN5z1MOPbzKJgKOipHmUmIdosFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531780; c=relaxed/simple;
	bh=x4PEUoA0DN3j5N3eH9Wsgw5xaMxOXCWOUupe3lXDsAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je5ypYXKiuCOPDSYwXYVt7I4Vs6y4wYkt4elqNc80pl5APPHnG+lNI0X/p84lewWXmG0K/ksY04OQf0/9qt6wQHjbJ8QDORA6w76YHumAAgDR142HIRLKq1owilubxalpH4RPpbugM1h1OepsPFOjV1vNvlGjacX6hYUPI9ajkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THrEkg6c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSzjgiGh; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781531778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMEiDWgl1uTHxhtX/yfV1uxzTjBC9QcJlXWombZLJFM=;
	b=THrEkg6cFBq/Z5Uv93veeHHI5C+fcwh1pVwzB6DaZZ5VKdGeL+LhlZV8/bOR8W70CPYZVm
	l5NnxOizzswEdv2gx5ex3XBkiUpYQiPqCv1SqIgvcg9lqkrzIItYjVoPYXOQ4+vsP78SuK
	37xjL3y9TfrlPyiMkkZlz1asGQaY/so=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-CKLtZ1BZMxGxWR509SmrcQ-1; Mon, 15 Jun 2026 09:56:01 -0400
X-MC-Unique: CKLtZ1BZMxGxWR509SmrcQ-1
X-Mimecast-MFC-AGG-ID: CKLtZ1BZMxGxWR509SmrcQ_1781531760
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6933e58a1bbso3647672a12.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781531760; x=1782136560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMEiDWgl1uTHxhtX/yfV1uxzTjBC9QcJlXWombZLJFM=;
        b=OSzjgiGh8x7d5CF87DTgk2dD8CvXdUYua3dYxd+BHW4EsdDjC36MxQEF0lWJfpvSs+
         nMjZnt6TqbwoPm/CVGNv5euHyW9wEQQv25cnxkU9xD9LxYAxsxJ9LGWB/lx4sOQGmDMb
         F3j8qT8uzoBb24XRmZRHBScOCMafc1O7KTlFqub/+tDp1soIfZ44Q2LLYF8zHMlJG8lb
         dx7Ep+pYf6zo6FPb/UJQtsizcboKedthnpnIdbfoi8Gy73t8ezGdzBKmvUyv66oOMws0
         eitSYcK0TIB3Ggzh+kuIq30HFlVM9UG7q1ulIV/e/RY67xZKBpYtsB6xEamCYCYSi8DM
         qhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781531760; x=1782136560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HMEiDWgl1uTHxhtX/yfV1uxzTjBC9QcJlXWombZLJFM=;
        b=e198GKDadiBZZUUVGiMqaQEnSyczmZJLgldnaG1bqECfv7CKkYoFmJ1QXNREr0MiYR
         B1QmX8ADkYvGtqgaT0kYHHIdTnMIHNCCIwGF8ggx2D25ZBdS3hqstM7NS8FuyiFOmHdo
         OLAzC8hqQrO/lwqCj1JOcC6aV/m9KD0jojC/5fhQ32ECC6hM/gtJIhUu6BgEASYwOrdk
         ST0Niz0fqyZz1TRgq7FFsAXA9AiDHHyqEIxGNU+ai7/AS1Ro445ELyJEKOIB54jlSDdN
         o1PicJ4sBsxnXGvchSYG2P7Xdujzp5Ir4s28JGgsMAUHJXUPj12Lob6LofM3gBcc/hoN
         PZgQ==
X-Gm-Message-State: AOJu0Yy5U/kOt4uOmLr94J0alJYFMS2Jtb3C8YEddUcs1ptxZ17SEQIk
	ociNrL4iQg2gjFJedDMt1PIjF6J3kO13cw4BkrkyhI+xeC+v80MQOJG7r21qcOjwIBVl+yWOZlx
	qcaeDnK1m1Mo0YLtdDk+SjunF1XBAwFbSS3clyduhOdrgOjJDheHdVtn3PA==
X-Gm-Gg: Acq92OEgM/hNgZbqKNIG+VpDiCLsMZqp2OhlAsuV0O080K4otI4IxpNh8KQ9TIEVc92
	ydJ+tkvSKykXws55MNH+/KwGiBjbtMXT3zZ6OCehg46QU2j/ayYqMjYb8miCVHK0tNF1shTXSsF
	jtE8v0rqTXdHorEIDJ5QLmSOAVqibJ6PyO+UChze7tx4k7IqRR6KaKBz0H0a+0b4ssw+6g5juy1
	OA0DrvFiJ/wGLgr4iq9dtFeAtuXhrXRyQB2jmCgPK61kDjUtlp59eBBcQ/DB4CwL0Ku9s7FBTCp
	IZx9oGLN428Jk3R7dm30lboj8QOBIlr3xFyx189JEFV7Lu37vkVhAuTpQ0bwUqEao2R0MS1FAsJ
	0fMlK/Kvfl7nHLNWINlrMFwykHjwa18tia9hBOmrkhE0Qm6ApDb2ywC8QgseLuQ3jw5ALHA==
X-Received: by 2002:a05:6402:434b:b0:68b:d10a:a48a with SMTP id 4fb4d7f45d1cf-693784fb02dmr6472057a12.11.1781531760084;
        Mon, 15 Jun 2026 06:56:00 -0700 (PDT)
X-Received: by 2002:a05:6402:434b:b0:68b:d10a:a48a with SMTP id 4fb4d7f45d1cf-693784fb02dmr6472024a12.11.1781531759609;
        Mon, 15 Jun 2026 06:55:59 -0700 (PDT)
Received: from [10.44.33.51] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693ab54e6e5sm2952596a12.1.2026.06.15.06.55.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 06:55:59 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, pabeni@redhat.com,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 "open list:OPENVSWITCH" <dev@openvswitch.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] net: openvswitch: decouple flow_table
 from ovs_mutex
Date: Mon, 15 Jun 2026 15:55:58 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <5386BD36-679E-4525-AB75-C536BD572150@redhat.com>
In-Reply-To: <20260611045817.1302665-4-amorenoz@redhat.com>
References: <20260611045817.1302665-1-amorenoz@redhat.com>
 <20260611045817.1302665-4-amorenoz@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299471-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8E684686E33

On 11 Jun 2026, at 6:58, Adrian Moreno wrote:

> In order to protect flow operations from RTNL contention, this patch
> decouples flow_table modifications from ovs_mutex by means of the
> following:
>
> 1 - Create a new mutex inside the flow_table that protects it from
> concurrent modifications.
> Putting the mutex inside flow_table makes it easier to consume for
> functions inside flow_table.c that do not currently take pointers to th=
e
> datapath.
> Some function signatures need to be changed to accept flow_table so tha=
t
> lockdep checks can be performed.
>
> 2 - Create a reference count to temporarily extend rcu protection from
> the datapath to the flow_table.
> One reference is held by the datapath, the other is temporarily
> increased during flow modifications.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Hi Adrian,

Thanks for this patch. I did spend quite some time analyzing
the implications of decoupling the table from ovs_mutex, and
I think all the concerns I had are covered. I did not do any
extensive traffic-based testing, but if time allows I will do
so with your next revision.

Find some comments below.

Cheers,

Eelco

[...]


> @@ -1678,8 +1722,12 @@ static int ovs_dp_cmd_fill_info(struct datapath =
*dp, struct sk_buff *skb,
>  	if (nla_put_u32(skb, OVS_DP_ATTR_USER_FEATURES, dp->user_features))
>  		goto nla_put_failure;
>
> -	if (nla_put_u32(skb, OVS_DP_ATTR_MASKS_CACHE_SIZE,
> -			ovs_flow_tbl_masks_cache_size(table)))
> +	rcu_read_lock();
> +	table =3D rcu_dereference(dp->table);
> +	err =3D table ? nla_put_u32(skb, OVS_DP_ATTR_MASKS_CACHE_SIZE,
> +				  ovs_flow_tbl_masks_cache_size(table)) : 0;
> +	rcu_read_unlock();
> +	if (err)
>  		goto nla_put_failure;
>
>  	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU && pids) {
> @@ -1817,7 +1865,9 @@ static int ovs_dp_change(struct datapath *dp, str=
uct nlattr *a[])
>  			return -ENODEV;
>
>  		cache_size =3D nla_get_u32(a[OVS_DP_ATTR_MASKS_CACHE_SIZE]);
> +		mutex_lock(&table->lock);
>  		err =3D ovs_flow_tbl_masks_cache_resize(table, cache_size);
> +		mutex_unlock(&table->lock);

The locking schema in flow_table.h does not document that
ovs_mutex-held writers may skip the refcount steps. Should
this either be documented as an exception, or should the
full 7-step protocol be followed here for consistency?

>  		if (err)
>  			return err;
>  	}

[...]

> @@ -2656,9 +2701,12 @@ static void ovs_dp_masks_rebalance(struct work_s=
truct *work)
>  	ovs_lock();
>  	list_for_each_entry(dp, &ovs_net->dps, list_node) {
>  		table =3D ovsl_dereference(dp->table);
> -		if (!table)
> +		if (!table || !ovs_flow_tbl_get(table))
>  			continue;
> +		mutex_lock(&table->lock);
>  		ovs_flow_masks_rebalance(table);
> +		mutex_unlock(&table->lock);

Same question as above, but here the RCU steps are skipped
instead of the refcount steps.

> +		ovs_flow_tbl_put(table);
>  	}
>  	ovs_unlock();
>
>

[...]

> @@ -513,7 +528,7 @@ static void table_instance_destroy(struct table_ins=
tance *ti,
>  }
>
>  /* No need for locking this function is called from RCU callback. */
> -void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
> +static void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
>  {
>  	struct flow_table *table =3D container_of(rcu, struct flow_table, rcu=
);
>
> @@ -525,9 +540,22 @@ void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu=
)
>  	call_rcu(&mc->rcu, mask_cache_rcu_cb);
>  	call_rcu(&ma->rcu, mask_array_rcu_cb);
>  	table_instance_destroy(ti, ufid_ti);
> +	mutex_destroy(&table->lock);
>  	kfree(table);
>  }
>
> +void ovs_flow_tbl_put(struct flow_table *table)
> +{
> +	if (refcount_dec_and_test(&table->refcnt)) {

Do we need a comment explaining why the 7-step protocol is not
followed here? Something like:

    /* Last reference dropped, no concurrent writers possible.
	 * Lock is only needed for lockdep assertions below.
	 */

> +		mutex_lock(&table->lock);
> +		table_instance_flow_flush(table,
> +					  ovs_tbl_dereference(table->ti, table),
> +					  ovs_tbl_dereference(table->ufid_ti, table));
> +		mutex_unlock(&table->lock);
> +		call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
> +	}
> +}
> +
>  struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
>  				       u32 *bucket, u32 *last)
>  {

[...]


