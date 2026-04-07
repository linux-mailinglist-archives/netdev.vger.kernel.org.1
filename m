Return-Path: <netdev+bounces-276006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFuoEE0R1Wm30AcAu9opvQ
	(envelope-from <netdev+bounces-276006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:14:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A863AFD74
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D713A3096976
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5130B382364;
	Tue,  7 Apr 2026 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHSS3CBD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5225C80E
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570909; cv=none; b=qm7GqUK8yvxbK6ePZRtBsFwc9grCdN6lxSu1q/qUo3AT4n/e5CEX9WcVtjaxFypVUdDNVgbXcFTE1uJObJghOEqduRhz7+fesGiOKKYWi0sR8Zv+rz+8bxtnXXSYy+wKaSp6Ooqcq+3yGT1+LwcNpex33kJM4REDjtb6Dy39EfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570909; c=relaxed/simple;
	bh=5H928kRnyjZRutt1ytOB4ncT7Lnkk36jUleG4AJ4gcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfPaZ32jSJOyMCM2XBRmY34nudMmgz3QJq55FwHElWl+3oW+XLjXPlAl2lariAa7hJvFC+KBH5Wt3jTW59vUNZq14gyODyO3p1o8QVGWZ5Ki/M4omG+BaVdx1MKq8mWj24XE8HEB3oG61xYcHYg7w27C3ZxIZwvmwVALiFAN86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHSS3CBD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775570906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RaqeX4Y+POP3jGCoHiicCey3AXONN2snWgAP6Hp1pfo=;
	b=ZHSS3CBDaOzJZ9M/oMCP2NNvGJML9rHkQcdZuMlge+FB9tcAzCzI2x/8AT6pObbkX+6ORk
	zJjICp6XQvAE7Cd1/Z0aM5Fkc9LPVWncncqeOUw1v8FmXprjOeu4Inb7QgFq0yIkCc8SHl
	ANf2vFbXL35M4hdsUYvG+csu8zwggfU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-YlPPJo-jPwGrZ25rMTfMwQ-1; Tue,
 07 Apr 2026 10:08:23 -0400
X-MC-Unique: YlPPJo-jPwGrZ25rMTfMwQ-1
X-Mimecast-MFC-AGG-ID: YlPPJo-jPwGrZ25rMTfMwQ_1775570895
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 216C9195605B;
	Tue,  7 Apr 2026 14:08:15 +0000 (UTC)
Received: from thinkpad (unknown [10.44.50.90])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A29841955F2B;
	Tue,  7 Apr 2026 14:08:11 +0000 (UTC)
Date: Tue, 7 Apr 2026 16:08:08 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, acsjakub@amazon.de, liuhangbin@gmail.com,
	kees@kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	Luka Gejak <luka.gejak@linux.dev>
Subject: Re: [PATCH net-next] net: hsr: emit notification for PRP slave2
 changed hw addr on port deletion
Message-ID: <adUPyJ1-FDDezooG@thinkpad>
References: <20260403123928.4249-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403123928.4249-2-fmancera@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amazon.de,gmail.com,kernel.org,redhat.com,google.com,davemloft.net,linux.dev];
	TAGGED_FROM(0.00)[bounces-276006-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 84A863AFD74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 02:39:29PM +0200, Fernando Fernandez Mancera wrote:
> On PRP protocol, when deleting the port the MAC address change
> notification was missing. In addition to that, make sure to only perform
> the MAC address change on slave2 deletion and PRP protocol as the
> operation isn't necessary for HSR nor slave1.
>
> Note that the eth_hw_addr_set() is correct on PRP context as the slaves
> are either in promiscuous mode or forward offload enabled.
>
> Fixes: b65999e7238e ("net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP")
> Reported-by: Luka Gejak <luka.gejak@linux.dev>
> Closes: https://lore.kernel.org/netdev/DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

I don't have a preference for the tree, but:
Reviewed-by: Felix Maurer <fmaurer@redhat.com>

> ---
> Note: routed through net-next tree as the next net tree as rc6 batch is
> already out and I do not think this is worth to be included in a last
> call batch. Anyway, if maintainer thinks it is, feel free to apply it to
> net tree.
> ---
>  net/hsr/hsr_slave.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index 44f83c8c56a7..d9af9e65f72f 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -243,7 +243,11 @@ void hsr_del_port(struct hsr_port *port)
>  		if (!port->hsr->fwd_offloaded)
>  			dev_set_promiscuity(port->dev, -1);
>  		netdev_upper_dev_unlink(port->dev, master->dev);
> -		eth_hw_addr_set(port->dev, port->original_macaddress);
> +		if (hsr->prot_version == PRP_V1 &&
> +		    port->type == HSR_PT_SLAVE_B) {
> +			eth_hw_addr_set(port->dev, port->original_macaddress);
> +			call_netdevice_notifiers(NETDEV_CHANGEADDR, port->dev);
> +		}
>  	}
>
>  	kfree_rcu(port, rcu);
> --
> 2.53.0
>


