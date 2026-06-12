Return-Path: <netdev+bounces-298574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s7NwF2XbK2oYGgQAu9opvQ
	(envelope-from <netdev+bounces-298574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:11:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C22226789D3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:11:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298574-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298574-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C326B3017BD3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87238228A;
	Fri, 12 Jun 2026 10:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1329E10B
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:11:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259106; cv=none; b=RErtzw/EdT8r0PM4VKB7Eom+fGntesxXUmCQz7E8sgiSlL0CyBjfPtdZeBRlcrr6oG6ADW4SsCzgWvodLHWZm7QseXxCmScEWMOJPGOZJYl+ErsR/GIySRhHoBGk/hMEEHI6R6BaI17slXNWRZ89Q/CwTJRJjP2Gp4CWPJX3A4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259106; c=relaxed/simple;
	bh=OS/a38wPwu2CZuiLDSjpOnSFIDOgby2Z6O0lK0fR6Tk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=HUl/pvgUgmcSyeD5p34IU1yN7I1z7au7ZrPauSMpPjFRceWwKktQYvY1FpgAvS0n+xufxUDlIqIgnBmfLI2UTbezjPoy1Dqra3X0iZWO8D3P4uAWekeRsaqe8YrlyAItA4eGFV/aI6Mz89oZp1LVM183JQU1+4tqjUKg5dUIpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 273D645DCC;
	Fri, 12 Jun 2026 12:11:36 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 net] virtio_net: do not allow tunnel csum offload
 for non GSO packets
From: Gabriel Goller <g.goller@proxmox.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
 Gabriel Goller <g.goller@proxmox.com>, Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <6c3b6c47fb05c100f384630dc48f3975cf37b67a.1781195144.git.pabeni@redhat.com>
References: <6c3b6c47fb05c100f384630dc48f3975cf37b67a.1781195144.git.pabeni@redhat.com>
Date: Fri, 12 Jun 2026 12:11:28 +0200
Message-Id: <178125908823.12688.1056224435757971178.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1781259045904
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[proxmox.com];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:virtualization@lists.linux.dev,m:g.goller@proxmox.com,m:f.ebner@proxmox.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[g.goller@proxmox.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[g.goller@proxmox.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298574-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,proxmox.com:email,proxmox.com:url,proxmox.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C22226789D3

> Fiona reports broken connectivity for virtio net setup using UDP tunnel
> inside the guest and NIC with not UDP tunnel TSO support in the host.
> 
> Currently the virtio_net driver exposes csum offload for UDP-tunneled,
> TCP non GSO packets. Such packet reach the host as CSUM_PARTIAL ones
> with the 'encapsulation' flag cleared, as the virtio specification do
> not support this specific kind of offload.
> 
> HW NICs with UDP tunnel TSO support - and those drivers directly
> accessing skb->csum_start/csum_offset - are still capable of computing
> the needed csum correctly, but otherwise the packets reach the wire with
> bad csum on both the inner and outer transport header.
> 
> Address the issue explicitly disabling csum offload for UDP tunneled,
> non GSO packets via the ndo_features_check op.
> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Gabriel Goller <g.goller@proxmox.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Tested it on our testbench, consider:

Reviewed-by: Gabriel Goller <g.goller@proxmox.com>
Tested-by: Gabriel Goller <g.goller@proxmox.com>

-- 
Gabriel Goller <g.goller@proxmox.com>


