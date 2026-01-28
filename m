Return-Path: <netdev+bounces-254376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJgEBIhEemkM5AEAu9opvQ
	(envelope-from <netdev+bounces-254376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:16:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1C3A6B05
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D40763015846
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C432E733;
	Wed, 28 Jan 2026 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUG/2ypF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA188265623
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620587; cv=none; b=go+L0iwDKMGsH8qdfBK7mQkGSBAetp3NpeqDhLi7jTRa811qRJnptBDipG4SJMvU89/g728xBRQ/2cnkcjvraWHJ1+FwssHeD2JDzdAnJYRDcWbFPViiqXVINBaIJAKojY48ZartrlshuXtn0pmAGnwURl46tkrVtipnmnWHXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620587; c=relaxed/simple;
	bh=nb2cuoEtrqZLiWRKS46/2C0NItVAXAwl9uQa/pCRroc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSEWr4k26A9UDAwJCLYlCumJ4fiVKZD2KFEShfK4HRBEQqXe4EavAUtMPc63r6NcFx0yPm7cwFqWFYMWt81BThNN1lF5rCa+jWyWb+UdsBW+YlhhUIEg59gpW+HJ+/m0tgMY2+GiZuA7Q5XfhK1qivBS0taeDwCBtLrFeiO5arM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUG/2ypF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7DFC4CEF1;
	Wed, 28 Jan 2026 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769620587;
	bh=nb2cuoEtrqZLiWRKS46/2C0NItVAXAwl9uQa/pCRroc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUG/2ypFM2oY+5jFc5Mcn4ZNieK7UZrgQgGIbai4RGkHZxyHxKFXKjgu5hivnloqV
	 W+1zYCBiV8KVQGb59AVwU83GkaqqvImG+XSMJQikwRdsHSwGpRue2fJUKlxUHze099
	 KoEYY7LCuRdg1CkfqDJaUayXRFt5NNGxB+/XdToT9qvEnSCIU6skGEAvDS98zg3yjA
	 K5jL4iRthxlLs//nRyPZ+Xq0pLglxO00ngEoWCufNhepfIL1RJTL8AtPst5YxmePuk
	 mOoq8nepwhKy3b4ErDnYulII37sraeVfZtmgxOAr72PkoI4sLfiJ1wjgsbGZ08dRrL
	 scFz/0uSuS3LA==
Date: Wed, 28 Jan 2026 17:16:23 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ilan Elias <ilane@ti.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	syzbot+f9c5fd1a0874f9069dce@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net] nfc: nci: Fix race between rfkill and
 nci_unregister_device().
Message-ID: <aXpEZ4F9341XjuBq@horms.kernel.org>
References: <20260127040411.494931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127040411.494931-1-kuniyu@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ti.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-254376-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,f9c5fd1a0874f9069dce];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 8D1C3A6B05
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:03:59AM +0000, Kuniyuki Iwashima wrote:
> syzbot reported the splat below [0] without a repro.
> 
> It indicates that struct nci_dev.cmd_wq had been destroyed before
> nci_close_device() was called via rfkill.
> 
> nci_dev.cmd_wq is only destroyed in nci_unregister_device(), which
> (I think) was called from virtual_ncidev_close() when syzbot close()d
> an fd of virtual_ncidev.
> 
> The problem is that nci_unregister_device() destroys nci_dev.cmd_wq
> first and then calls nfc_unregister_device(), which removes the
> device from rfkill by rfkill_unregister().
> 
> So, the device is still visible via rfkill even after nci_dev.cmd_wq
> is destroyed.
> 
> Let's unregister the device from rfkill first in nci_unregister_device().
> 
> Note that we cannot call nfc_unregister_device() before
> nci_close_device() because
> 
>   1) nfc_unregister_device() calls device_del() which frees
>      all memory allocated by devm_kzalloc() and linked to
>      ndev->conn_info_list
> 
>   2) nci_rx_work() could try to queue nci_conn_info to
>      ndev->conn_info_list which could be leaked
> 
> Thus, nfc_unregister_device() is split into two functions so we
> can remove rfkill interfaces only before nci_close_device().

...

> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-by: syzbot+f9c5fd1a0874f9069dce@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/695e7f56.050a0220.1c677c.036c.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2:
>   * Split nfc_unregister_device() and remove rfkill only
>     before nci_close_device()
> 
> v1: https://lore.kernel.org/netdev/20260126071359.2693214-1-kuniyu@google.com/

Reviewed-by: Simon Horman <horms@kernel.org>

...

