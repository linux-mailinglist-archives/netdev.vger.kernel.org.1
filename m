Return-Path: <netdev+bounces-280346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IJWC4mH6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:32:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7434437AE
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2490D3017BC9
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253A3BF66E;
	Wed, 22 Apr 2026 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJxjl+37"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D953BF673
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846717; cv=none; b=NIzoFg9QKAuNxt2GKIKO37irVra5AzG378xDuysuzxR+RAcreVvXc0NnDixMbe7NrIBln9DAAZFOHLwNxnzF7Q+liHLPlRePQsazVP2P4lQ3/+yx8c2PqifC1sTy7Ck5gVAQLftkCb95EUw3xHgAsLyeKsMUF5UK3L0A87VZ3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846717; c=relaxed/simple;
	bh=zE9Fc5nWpkJfPNYZAFf95RUtVnUaWl/whe5X/cGa6fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UddsCi7LD9mJvJDPTu7EwjMeWocAPdJr7LZYfl4xJNDez2m73bK6z+3l24fzoCQpdr3CHzF8hhiWjJddlWxaTfCxCdm6WdBqqL8YZo8ilWllnWfufAUngR34liIKHGm044dWW7JroWsfuczpbopAfI+jwbbIGqdDnVwwgEf2DKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJxjl+37; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776846715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OqgEsxzzthxZgE+ry6Kd2ShGZ2jDRQ5MG5BCDLqxp88=;
	b=JJxjl+37dreZC3ZVMk3r4K3IoiD3NqT4lAfcZIUlOJ1AJTnwuFZHZjE1/iXqKHehkMP59q
	E2MJ83XoKNTbm/oPvIXA6ZC+3RfewOZkaUM8fXv+3qdQb4LpIHYN5eHEnR72s2fCVhIBph
	doE7tff8g55hLKrc0CgZkCvGB0KCClE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-PP2LIxIgP_yTzG8t813a6w-1; Wed,
 22 Apr 2026 04:31:50 -0400
X-MC-Unique: PP2LIxIgP_yTzG8t813a6w-1
X-Mimecast-MFC-AGG-ID: PP2LIxIgP_yTzG8t813a6w_1776846708
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 592611956055;
	Wed, 22 Apr 2026 08:31:47 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 607BB180047F;
	Wed, 22 Apr 2026 08:31:42 +0000 (UTC)
Date: Wed, 22 Apr 2026 10:31:39 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kees@kernel.org,
	kexinsun@smail.nju.edu.cn, luka.gejak@linux.dev,
	Arvid.Brodin@xdin.com, m-karicheri2@ti.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	xuyuqiabc@gmail.com, royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: hsr: limit node table growth
Message-ID: <aeiHa7rzmSqzMIaJ@thinkpad>
References: <3bdbe54e81bd89c1443b05500368fb45bddc3191.1776754203.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdbe54e81bd89c1443b05500368fb45bddc3191.1776754203.git.royenheart@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280346-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,davemloft.net,google.com,kernel.org,redhat.com,smail.nju.edu.cn,linux.dev,xdin.com,ti.com,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB7434437AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:50:01PM +0800, Ren Wei wrote:
> From: Haoze Xie <royenheart@gmail.com>
>
> The HSR/PRP node learning paths allocate one persistent entry per
> previously unseen source MAC. Since learned entries stay alive until the
> prune timer catches up, the node tables can otherwise grow without a
> bound under high churn of learned senders.
>
> Limit the number of learned entries in each node table and stop adding
> new ones once the configured limit is reached. This keeps node-table
> resource use bounded across the affected learning paths.
Hi,

thank you for giving this approach a try!

[snip]
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index d09875b33588..8a5a2a54a81f 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -14,12 +14,18 @@
>  #include <kunit/visibility.h>
>  #include <linux/if_ether.h>
>  #include <linux/etherdevice.h>
> +#include <linux/moduleparam.h>
>  #include <linux/slab.h>
>  #include <linux/rculist.h>
>  #include "hsr_main.h"
>  #include "hsr_framereg.h"
>  #include "hsr_netlink.h"
>
> +static unsigned int hsr_node_table_size = 1024;
> +module_param_named(node_table_size, hsr_node_table_size, uint, 0644);
> +MODULE_PARM_DESC(node_table_size,
> +		 "Maximum number of learned entries in each HSR/PRP node table (0 = unlimited)");
> +
>  bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
>  {
>  	if (!hsr->redbox || !is_valid_ether_addr(hsr->macaddress_redbox))
> @@ -189,6 +195,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
>  				     enum hsr_port_type rx_port)
>  {
>  	struct hsr_node *new_node, *node = NULL;
> +	unsigned int node_count = 0;
>  	unsigned long now;
>  	size_t block_sz;
>  	int i;
> @@ -226,20 +233,31 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
>  	spin_lock_bh(&hsr->list_lock);
>  	list_for_each_entry_rcu(node, node_db, mac_list,
>  				lockdep_is_held(&hsr->list_lock)) {
> +		node_count++;

I'm not sure if this on-the-fly node counting is the best solution here.
My concern is that it comes quite late in the process, i.e., after we
already allocated a bunch of memory, etc. As we are discussing a
scenario where a lot of entries are created, maybe we shouldn't even
allocate a new_node if the table is already full? For example by storing
the node_count in hsr_priv and checking it early in the function?

>  		if (ether_addr_equal(node->macaddress_A, addr))
> -			goto out;
> +			goto out_found;
>  		if (ether_addr_equal(node->macaddress_B, addr))
> -			goto out;
> +			goto out_found;
>  	}
> +
> +	if (hsr_node_table_size && node_count >= hsr_node_table_size)
> +		goto out_drop;

I think it would be good to somehow make this situation transparent to
the user, so they can react if this an undesired behavior (for example,
because they simply have a large network and need a large node table).

>  	list_add_tail_rcu(&new_node->mac_list, node_db);
>  	spin_unlock_bh(&hsr->list_lock);
>  	return new_node;
> -out:
> +out_found:
>  	spin_unlock_bh(&hsr->list_lock);
> +	xa_destroy(&new_node->seq_blocks);
>  	kfree(new_node->block_buf);
> -free:
>  	kfree(new_node);
>  	return node;
> +out_drop:
> +	spin_unlock_bh(&hsr->list_lock);
> +	xa_destroy(&new_node->seq_blocks);
> +	kfree(new_node->block_buf);
> +free:
> +	kfree(new_node);
> +	return NULL;
>  }

The two cleanup paths are almost the same now. We usually attempt to
keep them unified to make sure that we do the correct cleanup steps in
all situations. So please keep them unified here as well.

Thanks,
   Felix


