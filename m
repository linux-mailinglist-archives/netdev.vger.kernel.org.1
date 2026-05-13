Return-Path: <netdev+bounces-287523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNucCmhXBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F9531A27
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84790300E6A8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432FB3EF678;
	Wed, 13 May 2026 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU94EwOb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4gH3l9S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0037206D
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669357; cv=pass; b=fj/9mZj5ZNSYEpFRc6+AGSc4lS3CT13OdajX4QohONAT9RU8MQ+Y3kUFdxg6Fewgnv2eP5VDZtcHHBIgqeDclEffAUebjvaTaG/r4CEW1fkWki1kwxARBzQ7IBUHH60WfVXYJYOkfveqGIDR7H6YYZpUhmG7e4bIl6072JWs5Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669357; c=relaxed/simple;
	bh=nk9gRKgZ4ygjLzTRcFYzb4Ab7c1f/0vyHhWeSg93DRk=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKqe+mqF6CrB0c8bR8WyZYbJkNiT3P+pVmRvh0RNVF26BmS9J5wIeCzpOxNwEGLs4O6Q8cHRMblYMMMglq7Vcd+Cek5eDmAJ/e0WT9yZhDkqSX3t71dRfexmejxrTpqQkprXoTQr5mABBFWONZ8dhmdzUgX8X3QQGk3ehNFd3dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YU94EwOb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4gH3l9S; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DjDs87dmBBxM+X98oHq93kX30esB4qco5qSjYkhRk6o=;
	b=YU94EwObhxYxbh7SRbX+TXy0G8cIX/MR91bCtlZH7pxnzDRbzb2CfXMhW3r4TOhQbghxOL
	y3giQg/MIMq4/kH4dRyBuAXJ7qcYeOW4roEKr60RwnQkcR6Iq8y101TvEH/17ACLyYIwVE
	QYqFw5q6Ivm8llSPC/c59Zhri8BSPIA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-ShnfZuyxM6-jLZlsSeuyVg-1; Wed, 13 May 2026 06:49:12 -0400
X-MC-Unique: ShnfZuyxM6-jLZlsSeuyVg-1
X-Mimecast-MFC-AGG-ID: ShnfZuyxM6-jLZlsSeuyVg_1778669352
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8ff07df5e4so588482866b.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778669351; cv=none;
        d=google.com; s=arc-20240605;
        b=aqCq1gg8MYCuE4j59zlPR4i3rNA32XadtHvzaeQwiZs3ce2rgen4oOdbyhiP5kMwAm
         ZWRxM0kcSWcrJYV9rdYtFMU4eXYyjKT0Cjr6yfrqMZDj1plUvHLg10/NPuFizxRL8Yf+
         nAskfHvwdyrl1Rt4aFHJ5SHrxFF8Si5/B40R97uiO5OPGmo2btCeK4AWjjlddaW1IFnR
         64wbn1mMXUvaCJbtDW0feBTXk54gFQuyypPU35pt7/yLnhZbBQAsMAxzV8EbtiUGFKwK
         azkzVbZy3m8vZ5sp7aSkHnGVlZLwHVkCTYJlpbX4RvwwJ4Lb8PhfkUVVFDh8RM0f+M8k
         BhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=DjDs87dmBBxM+X98oHq93kX30esB4qco5qSjYkhRk6o=;
        fh=j5CqZHL5zV7C/kjSXjXGxR17zjEpontygbIJoR8m8+Q=;
        b=iFyqjD6zMg2UmgnAJmGb75gVh/QYyv3iKw25N5Y+YSsvxOrqBWbCHSyUm2w/l6NKCv
         vo2JltpCPnZSFsGwiFvXXnZgNAlOGGBawecMBsDtoAy/TdPdZuoxvZmsRulvtaqqrjwm
         eK8nYz/oMdhorh5g/Ujf/SmKpf5zhAQIqsMk7NjlAna3wtDOS01eJ6Spr8sE5GT/ysz3
         bQj+zkn67CbFbE8NmUu6g7aXE2d4ivY/l1sstrQ3eLbJeKMlSEr9xw3AzcWf83wY8py0
         fQtcqG0sVBB+LcyhWh1omBh3AHuFo0fDPPtdglLCURr77vUL0h0H7rpK8BuQS9n2UsdR
         iHSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778669351; x=1779274151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjDs87dmBBxM+X98oHq93kX30esB4qco5qSjYkhRk6o=;
        b=F4gH3l9SKlVbaNF/IE0QB3/tX2DSPrzjz9qPeeB/EOi8ExtUQsgF1chkqEMezMRiQz
         lt/A0Yu1NX9voI01wNpo1S6RcBJ1xD5Wwkvshskkwzs5BMUftJWgSjUTY+SS4ISYOz2j
         XU9ffvXbI6wC7zdzCimdyH/e10PPWLZJk1tCBm9G0CBNNTrpymFSPtLBVn/q9/AeS5bR
         L3sykpmj08uO7/H0ZwNsW7CumLGC5vSBNhfYw9/V/wUFxW6OcY8JNcgoCpYlGb7si5Rj
         UKd8f3E9of/LtY2WtJHZGME3lVpnhXJCfKFEuMUorQwofXom52xYS4rig5w8qQ6n1p0V
         cJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669351; x=1779274151;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjDs87dmBBxM+X98oHq93kX30esB4qco5qSjYkhRk6o=;
        b=sjGTZFklrUya0uQxe8mYgSaL2Ic9LRBGTE/ecjyH8LVEiKxPlEetICQyhVkzEhaHZr
         +uEb5Vx3ytCk83ZulQIDLGr2pyA8RZ91oq0zo2aqrQrqjD1eWgj5TljZCsL8JcNXvxuq
         b08oec6P+DiC4FOTJbfHpIeWaHxHvcnlft3nWrGnd+qGgIZ5g7Hz4Y0Lr84ziFRiTej2
         MS+EYMI5PsHZ4LUNzXfqPpi/yfL1DJb2nobiAhjMFn0diiiOZwYYWv5CS8Uwjqt/AvPH
         nNTJ3jyx+/sbUPrjrL/hlFOGVn9Pgg08rPXIIcCgwpA13LsGLTSa/4F1IkEjnwfbbeSc
         qsuA==
X-Gm-Message-State: AOJu0Yy2tli3ov4eMpoPOBP9mBPy2hIJozjdkj1i+rVXKXtL4ZW20DbK
	NVnzN4XCJtVsheGF8zG3B+ScYhOgc2skgh+5Wny+q0rAXt5biNw7TwFALWH+utiBzK4JomqxT5z
	WrSUXWwNeWmNuoZhGZQuUP3YrdLrlwhDQtpTXXbFoYRdV4QNUzbgxVlwW1oC2AZSKZv/zJXYSpm
	0h5F66BlWLHoch0m1Ud/HBotV9g6DB+igLAcZXcpn3
X-Gm-Gg: Acq92OFW2JHGgvFZBgUiz8fSexQh084po7+CiddXWy0gKcXo08lj2pIOX4MbMfHg6DO
	K3cupTS7NBHLAffJVWGCTno5j4bGZqsofjcXDn/i6ffolNMwKzaZhz2vSEqL38xYuCGMPN8114Q
	yiACLcX7NQ5CKuNiaZJnYBDYKM+jDYE1GJMl4MADSkTjm1/wPAuvq249QW1NPqLW86y4oG0NIqE
	EMaaw9w
X-Received: by 2002:a17:907:3f92:b0:bd2:27c4:f453 with SMTP id a640c23a62f3a-bd3df57e81dmr140694066b.9.1778669351564;
        Wed, 13 May 2026 03:49:11 -0700 (PDT)
X-Received: by 2002:a17:907:3f92:b0:bd2:27c4:f453 with SMTP id
 a640c23a62f3a-bd3df57e81dmr140691566b.9.1778669351086; Wed, 13 May 2026
 03:49:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 May 2026 03:49:08 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 May 2026 03:49:08 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260505084253.998548-1-amorenoz@redhat.com> <20260505084253.998548-3-amorenoz@redhat.com>
 <b1820863-fd30-45b5-b03e-28225ea80780@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b1820863-fd30-45b5-b03e-28225ea80780@redhat.com>
Date: Wed, 13 May 2026 03:49:08 -0700
X-Gm-Features: AVHnY4LeCIGgPZOPOoQ0nSC8s9eyriH2InSeJCv4SqBT7k7rJfE783F74HBVf_Y
Message-ID: <CAG=2xmOTW18Kr5rNp9NxPpDBjwQ3H0s62jp7MAy2Bcb8KVyUaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: openvswitch: decouple flow_table
 from ovs_mutex
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"open list:OPENVSWITCH" <dev@openvswitch.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0B3F9531A27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287523-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 01:31:24PM +0200, Paolo Abeni wrote:
> On 5/5/26 10:42 AM, Adrian Moreno wrote:
> > In order to protect flow operations from RTNL contention, this patch
> > decouples flow_table modifications from ovs_mutex by means of the
> > following:
> >
> > 1 - Create a new mutex inside the flow_table that protects it from
> > concurrent modifications.
> > Putting the mutex inside flow_table makes it easier to consume for
> > functions inside flow_table.c that do not currently take pointers to the
> > datapath.
> > Some function signatures need to be changed to accept flow_table so that
> > lockdep checks can be performed.
> >
> > 2 - Create a reference count to temporarily extend rcu protection from
> > the datapath to the flow_table.
> > One reference is held by the datapath, the other is temporarily
> > increased during flow modifications.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  net/openvswitch/datapath.c   | 230 ++++++++++++++++++++++-------------
> >  net/openvswitch/flow.c       |  13 +-
> >  net/openvswitch/flow.h       |   9 +-
> >  net/openvswitch/flow_table.c | 173 ++++++++++++++++----------
> >  net/openvswitch/flow_table.h |  53 +++++++-
> >  5 files changed, 318 insertions(+), 160 deletions(-)
>
> This is still considerably big. I'm wondering if introducing the
> lockdep_ovs_tbl_is_held/rcu_dereference_ovs_tbl annotations with a
> separate earlier patch would make it more palatable? Just a very wild
> guess; if the result is ugly (or you have string feeling that would be)
> please ignore.

I'll give it a try.

>
> > @@ -1112,7 +1132,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
> >  						       ufid_flags);
> >  			BUG_ON(error < 0);
> >  		}
> > -		ovs_unlock();
> > +		mutex_unlock(&table->lock);
> > +		ovs_flow_tbl_put(table);
>
> Minot nit: you can consolidate 2 ovs_flow_tbl_put() calls after the
> if/than/else statement.

Good point! I'll fix it.

>
> @@ -524,9 +540,22 @@ void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
> >  	call_rcu(&mc->rcu, mask_cache_rcu_cb);
> >  	call_rcu(&ma->rcu, mask_array_rcu_cb);
> >  	table_instance_destroy(ti, ufid_ti);
> > +	mutex_destroy(&table->lock);
> >  	kfree(table);
> >  }
> >
> > +void ovs_flow_tbl_put(struct flow_table *table)
> > +{
> > +	if (refcount_dec_and_test(&table->refcnt)) {
> > +		mutex_lock(&table->lock);
> > +		table_instance_flow_flush(table,
> > +					  ovs_tbl_dereference(table->ti, table),
> > +					  ovs_tbl_dereference(table->ufid_ti, table));
> > +		mutex_unlock(&table->lock);
>
> As mentioned in the previous patch you can follow-up moving here the
>
> 	call_rcu(&mc->rcu, mask_cache_rcu_cb);
>  	call_rcu(&ma->rcu, mask_array_rcu_cb);
>
> currently in ovs_flow_tbl_destroy_rcu.

OK. I'll consolidate it in an independent follow-up patch.

>
> > +/* Must be called with flow_table->lock held. */
> >  int ovs_flow_tbl_flush(struct flow_table *flow_table)
> >  {
> >  	struct table_instance *old_ti, *new_ti;
> >  	struct table_instance *old_ufid_ti, *new_ufid_ti;
> >
> > +	ASSERT_OVS_TBL(flow_table);
>
> Minor nit: adding the assert and the comment is redundant. I think the
> assert alone would be better. There are other similar later occurrences.
>
> /P
>


