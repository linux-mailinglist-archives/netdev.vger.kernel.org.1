Return-Path: <netdev+bounces-269438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GFOL8Ltu2liqQIAu9opvQ
	(envelope-from <netdev+bounces-269438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:36:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E882CB371
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5674A307C8BE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17773CC9E4;
	Thu, 19 Mar 2026 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U98ytpOt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817661397
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923634; cv=none; b=SkdWQc1Vgo4XGlB8daGAkadm38pk5sHvoTtbgD4pBPoUhDS2EvoUugVpcZeAz+b2L48l4h6Kt01HxZ1gk4sqp3qODalCWk9New8zIGBwzsZCxKZYFfhdrNgl9z2mnV0fo/F3asL/2p9TnACJpVxgpmgCVGoyF2lC/ODOeR6yLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923634; c=relaxed/simple;
	bh=SshscDcR5lQR5IiLRzYCnDgLo730PlrjpP4FhtdmosU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjmhQxNvHormqaUQBHSbz8fwho1xNEfISapDMwag3Cai7OCIqyf5fPi7Ob/FhK66hFxyA9ImNFd/XoUG/3yL6NRmgp1T/iI8cMf9IMKJh07fXLyENMH2zaxBDKPpQJlEd20BTQgfMnJ5roWfUvHgkgX5O58u41Ded00A3jGMZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U98ytpOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773923632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Maag+wM4WRDGnOZztSCrKbAYHGImFUTyGsx2SLDOSGE=;
	b=U98ytpOt4KVHumQrEXgZBqBk39gnxBBKCYHvMh0mxWGe6+xvuo3sbnCf2acYAwJ0Eu1aLz
	8PpGDVJ9ctK+CvntCBeyUPRQ0oJBZyZ3W7x7tU0+pgpSrZeAeyH5GZoGx17Wvov4KyxceI
	ZbWEFV6rHK3865E3ITR8Y8yImi0v5ZM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-GWaPKZp1ONW4WNVvEn_log-1; Thu,
 19 Mar 2026 08:33:49 -0400
X-MC-Unique: GWaPKZp1ONW4WNVvEn_log-1
X-Mimecast-MFC-AGG-ID: GWaPKZp1ONW4WNVvEn_log_1773923627
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05096180035C;
	Thu, 19 Mar 2026 12:33:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9BF4180035F;
	Thu, 19 Mar 2026 12:33:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jiayuan.chen@linux.dev
Cc: ap420073@gmail.com,
	dsahern@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	jiayuan.chen@shopee.com,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com
Subject: Re: [net,v1] net/ipv6: mcast: fix circular locking dependency in __ipv6_dev_mc_inc()
Date: Thu, 19 Mar 2026 13:33:36 +0100
Message-ID: <20260319123336.216876-1-pabeni@redhat.com>
In-Reply-To: <20260317111208.62667-1-jiayuan.chen@linux.dev>
References: <20260317111208.62667-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269438-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,shopee.com,google.com,redhat.com,vger.kernel.org,davemloft.net,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.776];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev,afbcf622635e98bf40d2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 33E882CB371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/ipv6: mcast: fix circular locking dependency in __ipv6_dev_mc_inc()

This commit fixes a circular locking dependency deadlock by moving the
GFP_KERNEL allocation outside the mc_lock critical section. The fix
splits mca_alloc() into allocation and initialization phases and also
moves inet6_ifmcaddr_notify() outside the lock.

Link: https://lore.kernel.org/all/69b7dc76.050a0220.248e02.0113.GAE@google.com/T/

> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c

[ ... ]

> @@ -953,25 +957,23 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
>  			mc->mca_users++;
>  			ip6_mc_add_src(idev, &mc->mca_addr, mode, 0, NULL, 0);
>  			mutex_unlock(&idev->mc_lock);
> +			kfree(mc_alloced);
>  			in6_dev_put(idev);
>  			return 0;
>  		}
>  	}
>
> -	mc = mca_alloc(idev, addr, mode);
> -	if (!mc) {
> -		mutex_unlock(&idev->mc_lock);
> -		in6_dev_put(idev);
> -		return -ENOMEM;
> -	}
> +	mca_init(idev, addr, mode, mc_alloced);
> +	mc = mc_alloced;
>
>  	rcu_assign_pointer(mc->next, idev->mc_list);
>  	rcu_assign_pointer(idev->mc_list, mc);
>
>  	mld_del_delrec(idev, mc);
>  	igmp6_group_added(mc);
> +	mutex_unlock(&idev->mc_lock);
> +
>  	inet6_ifmcaddr_notify(dev, mc, RTM_NEWMULTICAST);
> -	mutex_unlock(&idev->mc_lock);
                ^^^^

Can this lead to a use-after-free on mc?

After mutex_unlock(&idev->mc_lock), the mc object has been published to
idev->mc_list with mca_refcnt=1. At this point, a concurrent
ipv6_mc_destroy_dev() could acquire mc_lock, iterate mc_list, and call
ma_put() on mc:

net/ipv6/mcast.c:ipv6_mc_destroy_dev() {
    mutex_lock(&idev->mc_lock);
    while ((mc = rcu_dereference_protected(idev->mc_list, ...)) != NULL) {
        ...
        ma_put(mc);
    }
    mutex_unlock(&idev->mc_lock);
}

Since mca_refcnt starts at 1 (set by mca_init), ma_put() would decrement
it to 0 and call kfree_rcu(mc, rcu):

net/ipv6/mcast.c:ma_put() {
    if (refcount_dec_and_test(&mc->mca_refcnt)) {
        in6_dev_put(mc->idev);
        kfree_rcu(mc, rcu);
    }
}

Then inet6_ifmcaddr_notify() calls nlmsg_new(..., GFP_KERNEL) which can
sleep and create an RCU quiescent state, allowing the kfree_rcu callback
to execute and free mc before inet6_fill_ifmcaddr() accesses mc->idev,
mc->idev->dev->ifindex, and mc->mca_addr.

Should the fix take an additional refcount on mc (refcount_inc(&mc->mca_refcnt))
before releasing mc_lock, then drop it with ma_put(mc) after
inet6_ifmcaddr_notify() returns?

>
>  	return 0;
>  }


