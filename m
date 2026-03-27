Return-Path: <netdev+bounces-272518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DG0FqZvxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:53:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E6866343D4D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D244304DF30
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4996E387368;
	Fri, 27 Mar 2026 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h54B5z6h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798C3803EB
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612337; cv=none; b=Sa4zOb4Zt2ARkYnjQw/IfLeuV11AcI0X5G12luSUyXLAWF/LcK2Wy0T1vt2QK4fD8DQSGO7V/wlTyplFzNZXC8jVdYpCPr4Lgd/gZYT84LsjLycfJGWsGQKHjUWQzG16m5nUfRe8IoNxe9fZoqF7x/0RuB1/Xx+NPQa9EAA/skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612337; c=relaxed/simple;
	bh=Bk22uo8F/Egi+gknvqKqeX7KwESPqCGlkuouHl7zNIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sckuRP3uyVv9HoxKtWAfX5/9O6QKRNs8xhqbOQ/mvbTifr4pWD/8kPZK8edhTtZcVB7c7RopYIrzYyzRMQXm4ZgDheIQ93Ah2JkMD735xitEupPlOAzUktTtqNOWkgh6/by5NSk8d7fEmomTGP9SYaOF4fAr0HrDEyNrX6lI1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h54B5z6h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774612334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8wF1bQAAVB9lEiUJRa0unp7pKMmUsagGzAN/jdisLU=;
	b=h54B5z6h8ePOyeh6WMnm3P8/3y05jI2gcGwDfxLrozI9zWGOarmRkkwEoL6KdcV+TbdeKC
	Nb0JtOqeWjgZD9+Ln6xMAbqmoxIre8d8ULEDgkIsYZuDu7Nz6lN0mUVFyDOzA9i56dQtGb
	ir0jONngan8T/NC5+fLmuaiR7B5GQ08=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-w7ZOAXulPrKdMi5LOhXGeQ-1; Fri,
 27 Mar 2026 07:52:10 -0400
X-MC-Unique: w7ZOAXulPrKdMi5LOhXGeQ-1
X-Mimecast-MFC-AGG-ID: w7ZOAXulPrKdMi5LOhXGeQ_1774612329
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8D6919560AF;
	Fri, 27 Mar 2026 11:52:08 +0000 (UTC)
Received: from thinkpad (unknown [10.44.33.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42C721800673;
	Fri, 27 Mar 2026 11:52:05 +0000 (UTC)
Date: Fri, 27 Mar 2026 12:52:02 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: hsr: fix VLAN add unwind on slave
 errors
Message-ID: <acZvYp_SYvypHWgk@thinkpad>
References: <20260326154715.38405-1-luka.gejak@linux.dev>
 <20260326154715.38405-3-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326154715.38405-3-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272518-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: E6866343D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for updating this patch!

On Thu, Mar 26, 2026 at 04:47:13PM +0100, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> When vlan_vid_add() fails for a secondary slave, the error path calls
> vlan_vid_del() on the failing port instead of the peer slave that had
> already succeeded. This results in asymmetric VLAN state across the HSR
> pair.
>
> Fix this by switching to a centralized unwind path that removes the VID
> from any slave device that was already programmed.
>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  net/hsr/hsr_device.c | 46 ++++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 5c3eca2235ce..75c491279df8 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -532,8 +532,8 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
>  static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
>  				   __be16 proto, u16 vid)
>  {
> -	bool is_slave_a_added = false;
> -	bool is_slave_b_added = false;
> +	struct net_device *slave_a_dev = NULL;
> +	struct net_device *slave_b_dev = NULL;
>  	struct hsr_port *port;
>  	struct hsr_priv *hsr;
>  	int ret = 0;
> @@ -546,29 +546,28 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
>  			continue;
>
>  		ret = vlan_vid_add(port->dev, proto, vid);
> -		switch (port->type) {
> -		case HSR_PT_SLAVE_A:
> -			if (ret) {
> -				/* clean up Slave-B */
> +		if (ret) {
> +			switch (port->type) {
> +			case HSR_PT_SLAVE_A:
>  				netdev_err(dev, "add vid failed for Slave-A\n");
> -				if (is_slave_b_added)
> -					vlan_vid_del(port->dev, proto, vid);
> -				return ret;
> +				break;
> +			case HSR_PT_SLAVE_B:
> +				netdev_err(dev, "add vid failed for Slave-B\n");
> +				break;
> +			default:
> +				break;
>  			}
>
> -			is_slave_a_added = true;
> +			goto unwind;
> +		}
> +
> +		switch (port->type) {
> +		case HSR_PT_SLAVE_A:
> +			slave_a_dev = port->dev;
>  			break;
>

nit: superflous empty line (it's inconsistent with the other case
blocks)

>  		case HSR_PT_SLAVE_B:
> -			if (ret) {
> -				/* clean up Slave-A */
> -				netdev_err(dev, "add vid failed for Slave-B\n");
> -				if (is_slave_a_added)
> -					vlan_vid_del(port->dev, proto, vid);
> -				return ret;
> -			}
> -
> -			is_slave_b_added = true;
> +			slave_b_dev = port->dev;
>  			break;
>  		default:
>  			break;

I think this would look cleaner with the good and the bad paths in the
same switch-case, but that may be a matter of (my) taste. What do you
think?

Thanks,
   Felix


