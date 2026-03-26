Return-Path: <netdev+bounces-272095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJtGAyBFxWnc8wQAu9opvQ
	(envelope-from <netdev+bounces-272095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:39:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44D336E9A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FB083098FE0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC13876D8;
	Thu, 26 Mar 2026 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vyi5S/l3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21434845C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535383; cv=none; b=NasPpj1E/YclNVt3CJpzxJABDn+8ZoU4HRPsHtia43/7B3FcGCCvsOY8cmQXUQdK1LVHLaWGOzWVRvHZvmueq+0b4lo8DzztwTT9WzyJz0QCYpstrSFqXxiwnZ2vSNwhMKTYNXsoFlS8Hb5AzgqouKmMlqBM0MJk45mJcEaPwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535383; c=relaxed/simple;
	bh=jfZ8ZlnRwCnYjNOVIyGZsfGLtcMHCMZM2YeO8/smBgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuWiVHDbRvQO3il//56upCgEOY0kpmpdaV6fXiX3KxqeqFNVwdUjZzm+sRrJLiDjXq37RaOiUaNCz4IBTLFInYiwj01M7QPg1QQNDbEN2LCxeMLp0WhgasQsZnjpmOKy88Q6l4AqjqyeGV/rDqy2iXGBUXlWncN7AXhMU8f1kn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vyi5S/l3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774535381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odmYkm2Zte+excZgXkjK+KkdHD4Q+Da928IfKwDZ/Zk=;
	b=Vyi5S/l3LzBLRP3/pyLZjZFmPjCjGMhkMe5A+/MBIppVBt8d8ODfiLAOSFYagsFWBXjzq0
	YuGQYlAqxOB+GK1uXrynjFQkqGKTL0ceVNWQd4qru1LM/5dpEaiwRWhMpr7pgNqch5pE29
	Fzw4A8KKDNMD+lsK15U8LOJf6wL3AC0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-7NqEDJiQOs-idVIHF-lLuQ-1; Thu,
 26 Mar 2026 10:29:34 -0400
X-MC-Unique: 7NqEDJiQOs-idVIHF-lLuQ-1
X-Mimecast-MFC-AGG-ID: 7NqEDJiQOs-idVIHF-lLuQ_1774535373
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0DC61800464;
	Thu, 26 Mar 2026 14:29:32 +0000 (UTC)
Received: from thinkpad (dhcp-64-111.muc.redhat.com [10.32.64.111])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9221D180035F;
	Thu, 26 Mar 2026 14:29:30 +0000 (UTC)
Date: Thu, 26 Mar 2026 15:29:27 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	liuhangbin@gmail.com, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/4] net: hsr: fix VLAN add unwind on slave
 errors
Message-ID: <acVCxzF7Btn0EShl@thinkpad>
References: <20260324143503.187642-1-luka.gejak@linux.dev>
 <20260324143503.187642-3-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324143503.187642-3-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272095-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB44D336E9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:35:01PM +0100, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> When vlan_vid_add() fails for a secondary slave, the error path calls
> vlan_vid_del() on the failing port instead of the peer slave that had
> already succeeded. This results in asymmetric VLAN state across the HSR
> pair.
>
> Fix this by ensuring the cleanup path targets the previously
> programmed slave device when the second slave fails to add the VID.

The cross-dev cleanup is already complex enough and I don't think this
makes it much better. How about having a central cleanup at the end that
cleans whatever ports have the VID added?

> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  net/hsr/hsr_device.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 5c3eca2235ce..6185f9f2630f 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -534,6 +534,8 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
>  {
>  	bool is_slave_a_added = false;
>  	bool is_slave_b_added = false;
> +	struct net_device *slave_a_dev = NULL;
> +	struct net_device *slave_b_dev = NULL;

No matter if my previous comment, the is_slave_{a,b}_added bools are not
necessary with your changes but just duplicate state. Testing
slave_{a,b}_dev == NULL serves the same purpose.

>  	struct hsr_port *port;
>  	struct hsr_priv *hsr;
>  	int ret = 0;
> @@ -552,11 +554,12 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
>  				/* clean up Slave-B */
>  				netdev_err(dev, "add vid failed for Slave-A\n");
>  				if (is_slave_b_added)
> -					vlan_vid_del(port->dev, proto, vid);
> +					vlan_vid_del(slave_b_dev, proto, vid);
>  				return ret;
>  			}
>
>  			is_slave_a_added = true;
> +			slave_a_dev = port->dev;
>  			break;
>
>  		case HSR_PT_SLAVE_B:
> @@ -564,11 +567,12 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
>  				/* clean up Slave-A */
>  				netdev_err(dev, "add vid failed for Slave-B\n");
>  				if (is_slave_a_added)
> -					vlan_vid_del(port->dev, proto, vid);
> +					vlan_vid_del(slave_a_dev, proto, vid);
>  				return ret;
>  			}
>
>  			is_slave_b_added = true;
> +			slave_b_dev = port->dev;
>  			break;
>  		default:
>  			break;
> --
> 2.53.0
>


