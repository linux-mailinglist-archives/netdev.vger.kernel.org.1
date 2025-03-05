Return-Path: <netdev+bounces-171885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D04A4F32D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09D03AAD4D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3CD5D8F0;
	Wed,  5 Mar 2025 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acqDHfGd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4051E50B
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136445; cv=none; b=eOpltt10+1Pt6TvOtLVCwv1GyJAA83jcL3K0zeoNMj+odl5J63f96w6TW5LT+CkWtibvYAwmST66Swt7/hr8V8XFMxPT2QTnRRRZTr29/bP+P15US37oPHcGIzKeEF+iJfgdGZYcAlsu9dyX1XF/B+cwiQSdVttbXZ22+aoRh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136445; c=relaxed/simple;
	bh=3By8JQnrBjDoTNl5JgoeIQFyoAYdxF1qri4pDmrCnU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmvRAsTTBw/udKxnv9fLm0t8dzXyoOSws1XCBgAOhNnv2m5m242eA8yzBETLRzX91oySj8EGDlkeK4SS1YnDNGOlj4RXawYkxwnqZ+8HlOi6XuDIN1oev7JmlgTfzS7gbLoWp4HH+EkEVqVD+0MYsNf/Guz7d7WINtp0aVVdeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acqDHfGd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741136442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCLcZgAdPbV9c8xzn8OONYQ4nQE6q6ilPqrbzWxJ/FQ=;
	b=acqDHfGdyqqYuNXbuBrqT3W+2oc9/WkR1eGzNb7q3AhUuNyfn/2mWGeUtKvSdJ1hkGB+dl
	ZAnXkLs7kUgq8m42cJtLp4ktUWO2wiA7Ru6N7xNz0JHBhLJiui+10IW7lH/7L/FqGfjUwk
	WSePNf1axCDYvHgE5OUhgDGM8h7S/tE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-iJYvRsvkNbGmv7P5FvjDQw-1; Tue,
 04 Mar 2025 20:00:29 -0500
X-MC-Unique: iJYvRsvkNbGmv7P5FvjDQw-1
X-Mimecast-MFC-AGG-ID: iJYvRsvkNbGmv7P5FvjDQw_1741136427
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49E63190ECDF;
	Wed,  5 Mar 2025 01:00:27 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69B8A180035F;
	Wed,  5 Mar 2025 01:00:24 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>,  dev@openvswitch.org,
  ovs-dev@openvswitch.org,  Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>,  Jianbo Liu <jianbol@nvidia.com>,  Florian
 Westphal <fw@strlen.de>,  Ilya Maximets <i.maximets@ovn.org>,  Eric
 Dumazet <edumazet@google.com>,  kuba@kernel.org,  Paolo Abeni
 <pabeni@redhat.com>,  davem@davemloft.net
Subject: Re: [ovs-dev] [PATCH net] openvswitch: avoid allocating labels_ext
 in ovs_ct_set_labels
In-Reply-To: <b7c05496f8ead33582eb561b55d3e2fcf25bcf36.1741108507.git.lucien.xin@gmail.com>
	(Xin Long's message of "Tue, 4 Mar 2025 12:15:08 -0500")
References: <b7c05496f8ead33582eb561b55d3e2fcf25bcf36.1741108507.git.lucien.xin@gmail.com>
Date: Tue, 04 Mar 2025 20:00:22 -0500
Message-ID: <f7teczc70m1.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Xin Long <lucien.xin@gmail.com> writes:

> Currently, ovs_ct_set_labels() is only called for *confirmed* conntrack
> entries (ct) within ovs_ct_commit(). However, if the conntrack entry
> does not have the labels_ext extension, attempting to allocate it in
> ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
> nf_ct_ext_add():
>
>   WARN_ON(nf_ct_is_confirmed(ct));
>
> This happens when the conntrack entry is created externally before OVS
> increases net->ct.labels_used. The issue has become more likely since
> commit fcb1aa5163b1 ("openvswitch: switch to per-action label counting
> in conntrack"), which switched to per-action label counting.
>
> To prevent this warning, this patch modifies ovs_ct_set_labels() to
> call nf_ct_labels_find() instead of ovs_ct_get_conn_labels() where
> it allocates the labels_ext if it does not exist, aligning its
> behavior with tcf_ct_act_set_labels().
>
> Fixes: fcb1aa5163b1 ("openvswitch: switch to per-action label counting in conntrack")
> Reported-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---

Just a nit, but after this change, the only user of the
ovs_ct_get_conn_labels function is in the init path.  I think it might
make sense to also rename it to something like 'ovs_ct_init_labels_ext'.
Then hopefully it would be clear not to use it outside of the
initialization path.

>  net/openvswitch/conntrack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 3bb4810234aa..f13fbab4c942 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct, struct sw_flow_key *key,
>  	struct nf_conn_labels *cl;
>  	int err;
>  
> -	cl = ovs_ct_get_conn_labels(ct);
> +	cl = nf_ct_labels_find(ct);
>  	if (!cl)
>  		return -ENOSPC;


