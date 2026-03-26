Return-Path: <netdev+bounces-272133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LjNMlJhxWlM9wQAu9opvQ
	(envelope-from <netdev+bounces-272133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:39:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D73388C9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 410BB30D64F7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94334A3D2;
	Thu, 26 Mar 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LI0EgMkO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38186299AB1
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542348; cv=none; b=iQSyblRIaQRmTywuTCl4kBbnHm+o4t9tCpgT9HS1LzGGJMQea/Cg+JkSuuYK5qx3c6/nuvpdS0WU5hSwrO1KDScXbyaxb+dR+pvp8vqrV4nDmksd5SaHRLSp7HB51e0fjDzANjeNIy/zXM5QvQnaEUfaZZfBURJDmA8VQcmXY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542348; c=relaxed/simple;
	bh=KZ8/ahHAIdEi+IY8crDdZNeNnOeG3zwjSw1hrt2ZuWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK1TZL+GpQyKs2lBa6bkHc7r4TSlMMpXlTcvl8frmMTaNp4JwAcuakAkmb0bISJY3frBGr86GzwLuvFg9f+rMqMhzhd9bGH1MOrVbkHeS8tHSbNBvvemMqgMWuAcPZ/+vrWXT+5yGaqtu1LTgRCMOovUgNw/wVaFCCKeo75l8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LI0EgMkO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774542346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKZn4Lc753zayDca1KkQqWEAj5b0wm/cvMIKt+HOy1o=;
	b=LI0EgMkOSZoOGGtF1qAV19d7LQ+6Lnw65XUyFAst4d78/CRcaOGqenVOANoqZDKOpGikq1
	GIU4yMCNghtm+/DC/tLKFEkvzAj+sS7wbJa8h1P2tqH/UjUnijBD33UkYOUHNOxUnBh0Op
	rRoqX8A2ae6+0Hz8nBAqd+NPrMHB024=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-lwQk8uitP9es3Z-HJXsiBw-1; Thu,
 26 Mar 2026 12:25:43 -0400
X-MC-Unique: lwQk8uitP9es3Z-HJXsiBw-1
X-Mimecast-MFC-AGG-ID: lwQk8uitP9es3Z-HJXsiBw_1774542341
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B5241955DDB;
	Thu, 26 Mar 2026 16:25:41 +0000 (UTC)
Received: from thinkpad (dhcp-64-111.muc.redhat.com [10.32.64.111])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C0741955D84;
	Thu, 26 Mar 2026 16:25:38 +0000 (UTC)
Date: Thu, 26 Mar 2026 17:25:35 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/7] net: hsr: replace fallthrough comments
 with fallthrough macro
Message-ID: <acVd_-jLS2W1rcMz@thinkpad>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
 <20260324144630.189094-3-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324144630.189094-3-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272133-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 4B7D73388C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:46:25PM +0100, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> Replace two instances of the legacy '/* Fall through */' comment with the
> standardized 'fallthrough;' macro in hsr_get_node_status() and
> hsr_get_node_list(). The kernel has standardized on the fallthrough macro
> since the migration from comment-based annotations, which provides
> compiler-level verification of intentional case fall-throughs.

As the test robot message suggests: the fallthrough macro is only for
case statement blocks.

> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  net/hsr/hsr_netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
> index db0b0af7a692..32c1b77cf84b 100644
> --- a/net/hsr/hsr_netlink.c
> +++ b/net/hsr/hsr_netlink.c
> @@ -433,7 +433,7 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
>
>  nla_put_failure:
>  	kfree_skb(skb_out);
> -	/* Fall through */
> +	fallthrough;
>
>  fail:
>  	rcu_read_unlock();
> @@ -524,7 +524,7 @@ static int hsr_get_node_list(struct sk_buff *skb_in, struct genl_info *info)
>
>  nla_put_failure:
>  	nlmsg_free(skb_out);
> -	/* Fall through */
> +	fallthrough;
>
>  fail:
>  	rcu_read_unlock();
> --
> 2.53.0
>


