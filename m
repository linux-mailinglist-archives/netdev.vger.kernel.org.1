Return-Path: <netdev+bounces-174236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE65EA5DEEC
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8447AD0FB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8251F24C668;
	Wed, 12 Mar 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOwC0GFP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A5A24DFFD
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789566; cv=none; b=nYYKP3GaU7looAnqrDq5ZOysjY8DKENj/ySlRUdmGQ9aDnppNk2mNqR2O78QfBQw4DOKyHRukKI78Gibd3El8foNZ2fOe9j0aSnfqdA9DOmrPfIyrnJYZiDorq3/i2Ecq0om1yr1DrWEWR3bL1++uWFyaWH48TYkdrRz9Ao4Y0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789566; c=relaxed/simple;
	bh=x5yBdybcVQvGwM608pIjXqOjtnhzFuRtgN4KG0mnw1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQyHbwHlLmqT8PO9vi0oMLk1kLymFYWdnYIgXhswKBpX+JUkB2WOZUEno1a7LMVo03QRTRdC+7zSZHqHb9DbQyQjqrxLYZ6O9+fJqg70gV4ZM3PQ1bT2yMY8Laigy793cOYKLpBlF7XaUcjT+xYIYrTA61usW43LQP7yk69xR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOwC0GFP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741789563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=368AMI5AhK7lFz4Mrz0Jc27Xh/nF3FwCami4rTVwz/k=;
	b=bOwC0GFPD8hKCWp4yrGBFcVVm5Ml1DzqTe6cCsS3Z6CNrGzQiTLUZERZb3lSUia6pOsjpv
	YNPy+tZk0ogtUz/Yf4s9FcCRl+fbOHFts1nBGP9m73/L+FrXLAd6VTRNr9pjv3NA8jq9W1
	z1gK5gEdzVcY7EMNbBvA45BQPf1Qt8U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-nHmoc7D7O8ONKLmJzmNtMQ-1; Wed,
 12 Mar 2025 10:25:58 -0400
X-MC-Unique: nHmoc7D7O8ONKLmJzmNtMQ-1
X-Mimecast-MFC-AGG-ID: nHmoc7D7O8ONKLmJzmNtMQ_1741789556
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9226118001F6;
	Wed, 12 Mar 2025 14:25:56 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.90.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DB441801752;
	Wed, 12 Mar 2025 14:25:53 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>,  dev@openvswitch.org,
  ovs-dev@openvswitch.org,  Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>,  Jianbo Liu <jianbol@nvidia.com>,  Florian
 Westphal <fw@strlen.de>,  Ilya Maximets <i.maximets@ovn.org>,  Eric
 Dumazet <edumazet@google.com>,  kuba@kernel.org,  Paolo Abeni
 <pabeni@redhat.com>,  davem@davemloft.net
Subject: Re: [ovs-dev] [PATCH net] Revert "openvswitch: switch to per-action
 label counting in conntrack"
In-Reply-To: <1bdeb2f3a812bca016a225d3de714427b2cd4772.1741457143.git.lucien.xin@gmail.com>
	(Xin Long's message of "Sat, 8 Mar 2025 13:05:43 -0500")
References: <1bdeb2f3a812bca016a225d3de714427b2cd4772.1741457143.git.lucien.xin@gmail.com>
Date: Wed, 12 Mar 2025 10:25:51 -0400
Message-ID: <f7tjz8uz5ow.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Xin Long <lucien.xin@gmail.com> writes:

> Currently, ovs_ct_set_labels() is only called for confirmed conntrack
> entries (ct) within ovs_ct_commit(). However, if the conntrack entry
> does not have the labels_ext extension, attempting to allocate it in
> ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
> nf_ct_ext_add():
>
>   WARN_ON(nf_ct_is_confirmed(ct));
>
> This happens when the conntrack entry is created externally before OVS
> increments net->ct.labels_used. The issue has become more likely since
> commit fcb1aa5163b1 ("openvswitch: switch to per-action label counting
> in conntrack"), which changed to use per-action label counting and
> increment net->ct.labels_used when a flow with ct action is added.
>
> Since there=E2=80=99s no straightforward way to fully resolve this issue =
at the
> moment, this reverts the commit to avoid breaking existing use cases.
>
> Fixes: fcb1aa5163b1 ("openvswitch: switch to per-action label counting in=
 conntrack")
> Reported-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---

I did a quick test using the case provided by Jianbo and I wasn't able
to generate the warning.  If possible, I'd like Jianbo to confirm that
it works as well.

Acked-by: Aaron Conole <aconole@redhat.com>

>  net/openvswitch/conntrack.c | 30 ++++++++++++++++++------------
>  net/openvswitch/datapath.h  |  3 +++
>  2 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 3bb4810234aa..e573e9221302 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -1368,8 +1368,11 @@ bool ovs_ct_verify(struct net *net, enum ovs_key_a=
ttr attr)
>  	    attr =3D=3D OVS_KEY_ATTR_CT_MARK)
>  		return true;
>  	if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
> -	    attr =3D=3D OVS_KEY_ATTR_CT_LABELS)
> -		return true;
> +	    attr =3D=3D OVS_KEY_ATTR_CT_LABELS) {
> +		struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> +
> +		return ovs_net->xt_label;
> +	}
>=20=20
>  	return false;
>  }
> @@ -1378,7 +1381,6 @@ int ovs_ct_copy_action(struct net *net, const struc=
t nlattr *attr,
>  		       const struct sw_flow_key *key,
>  		       struct sw_flow_actions **sfa,  bool log)
>  {
> -	unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * BITS_PER_BYT=
E;
>  	struct ovs_conntrack_info ct_info;
>  	const char *helper =3D NULL;
>  	u16 family;
> @@ -1407,12 +1409,6 @@ int ovs_ct_copy_action(struct net *net, const stru=
ct nlattr *attr,
>  		return -ENOMEM;
>  	}
>=20=20
> -	if (nf_connlabels_get(net, n_bits - 1)) {
> -		nf_ct_tmpl_free(ct_info.ct);
> -		OVS_NLERR(log, "Failed to set connlabel length");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	if (ct_info.timeout[0]) {
>  		if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
>  				      ct_info.timeout))
> @@ -1581,7 +1577,6 @@ static void __ovs_ct_free_action(struct ovs_conntra=
ck_info *ct_info)
>  	if (ct_info->ct) {
>  		if (ct_info->timeout[0])
>  			nf_ct_destroy_timeout(ct_info->ct);
> -		nf_connlabels_put(nf_ct_net(ct_info->ct));
>  		nf_ct_tmpl_free(ct_info->ct);
>  	}
>  }
> @@ -2006,9 +2001,17 @@ struct genl_family dp_ct_limit_genl_family __ro_af=
ter_init =3D {
>=20=20
>  int ovs_ct_init(struct net *net)
>  {
> -#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> +	unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * BITS_PER_BYT=
E;
>  	struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
>=20=20
> +	if (nf_connlabels_get(net, n_bits - 1)) {
> +		ovs_net->xt_label =3D false;
> +		OVS_NLERR(true, "Failed to set connlabel length");
> +	} else {
> +		ovs_net->xt_label =3D true;
> +	}
> +
> +#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>  	return ovs_ct_limit_init(net, ovs_net);
>  #else
>  	return 0;
> @@ -2017,9 +2020,12 @@ int ovs_ct_init(struct net *net)
>=20=20
>  void ovs_ct_exit(struct net *net)
>  {
> -#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>  	struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
>=20=20
> +#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>  	ovs_ct_limit_exit(net, ovs_net);
>  #endif
> +
> +	if (ovs_net->xt_label)
> +		nf_connlabels_put(net);
>  }
> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> index 365b9bb7f546..9ca6231ea647 100644
> --- a/net/openvswitch/datapath.h
> +++ b/net/openvswitch/datapath.h
> @@ -160,6 +160,9 @@ struct ovs_net {
>  #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>  	struct ovs_ct_limit_info *ct_limit_info;
>  #endif
> +
> +	/* Module reference for configuring conntrack. */
> +	bool xt_label;
>  };
>=20=20
>  /**


