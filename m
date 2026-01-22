Return-Path: <netdev+bounces-252206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IXpXDompcWm2LAAAu9opvQ
	(envelope-from <netdev+bounces-252206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:37:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D20E461BFB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D681B3C49F2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7973563D5;
	Thu, 22 Jan 2026 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V24f70Qf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B2A358D31
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056399; cv=none; b=DsIkihB+XRp6B+1dv+Nbc5XE0F9nXsjXEjYHuhS7cEmQZ6pOm6Ipkm/AiksVKn4Jo5vdPeZGiYq61AKFbZidl/nCzAOl6p+lZUkOgxBCzRbGL2X8tcg7w5cbLVbXsSPBSwuYFiF88nk9u6Qxmk6UhzxTHp89CtBQyEreDer13LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056399; c=relaxed/simple;
	bh=dFSeVF4LSScqfGaORLLcxu7Ha+bpefktNPuAeE8SzuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kce5CBGjXm76h9TyG2TdSW9L79+SGYElNur0BB6KG7Czw+D0YJ103Gn3HFty0h+8YxSFkSI+Dq5Bh/2REbEToW5T7TmtqZ9nGvyqsVrdZwrxx6wKkYBnuymcfkJyuri00bt12pZ7aUHekYRsYPt52ESmInUO1s31Q2BA5NJcRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V24f70Qf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bde0f62464cso165239a12.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 20:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769056397; x=1769661197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EzTp247lCzxMAtPgX+31ixqLPopkDFGUgJvbj/OIYMo=;
        b=V24f70QfPjsRcAKdym0wi/SnVPcHTN4+HPEbCR9iU8Q45H0f238aSom6pcfgclwyMv
         5T5vuTdtxTNY4MvB+4pU2rmiHPzsKwQ/Aeedepp17cC4X2xVMBV9ZBD3lBho4dME0YLQ
         tCs+WOWKS8tgGJps1d+ouwxrwB3y1NxUvfu7qDaXo5cR8gbEtUalDH0hMpZXHjW4o9J+
         +Ae2lgHkUAzqnTPU1mJGXaZECi9/lqPilNtQM40IO62MFazcr1/oybA08aChF/on+GvO
         KNFf4QL19fim/mH5iMng33O35/yXwIi6BAwWHMSx3YBGqaIZ/n57wMl8Adsh/webOaD9
         VQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769056397; x=1769661197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzTp247lCzxMAtPgX+31ixqLPopkDFGUgJvbj/OIYMo=;
        b=ioweKRnjMjL+ngYJPvh0xQf9q+dRvUDiXj2HNYZlnQh5nGrBphvK0527d7lBBlocoA
         pTqFEhHwAn7lxv1weR8kqzffjdTNSJNSMRULOX9RuExOZbOzh79rTMOJ7zkPTU4XsfLk
         +B1Bu6SqXWEn99vLR4PPzKF1fwOG/hI3FYMCWlzc6RXz59mzKaWqLG2sNgV3DQDj0h6Y
         gIoyQpNPcqmC4ChvrNkUELgA43Vlm3EeKCVIeBFB8navmkoZJjBWg2bkwAGlG5u+oCVC
         J/JbaNgNFYbPUBjNMTakCOWW0t+ryNc2Cq3tJ9jSuY3Wb9FaULdQN7r388kOtLBQ+nAy
         Jzfg==
X-Gm-Message-State: AOJu0Yx9adFPTXeaEj3g2FWNs07AmbRn35hHwLN+JhYGwWLLJe7fiV6U
	ek9Vuduyv99sXthEoguvY+QVZrV/kjJFh+5wvVRYY9frN/7FoHxKahDP
X-Gm-Gg: AZuq6aJl0MbSeoDqrZ5VZWg1vGQSrqreBd5ilGS63wLP/vWmdN3Q59RZ/fOwmAfzHZQ
	VVTniH+TjFccJhip08rxna4OfyYI6EyJcXr8RHWKwZKVemaj3kb7szTs7bFTreIaj1pvbIF+lKd
	9J0C8jLUhdFl6hDpkq4xG+E09sN6JUly6+CoXzqTujRHlKfmM97YxZ9ox3qwMTwfNOWNybVK3El
	GeDXyfEhYp0vN95PBs4G7KTyUAgk2HCquUJsUHY36vGHv1JTFTFGfeuuUD9hb1xKyY8hMIwGRLK
	OdD2Oc+BCiGk1fYkzo+RCtSwqGR0RdgCM0it/jknJWFj1PgylvI5iAum+1aD6aa2tV4S9H3AOzJ
	J8u9A1EGjjsjd16/zllqzzr4xEIrap5Gq+ioX3Lkp/687ZN49bJExht81gbicpYBcCgLpAlVtme
	D9ZWcksUVun3dW5fEh7AfXXPQT/g==
X-Received: by 2002:a05:6a21:6da8:b0:38b:e759:c2ba with SMTP id adf61e73a8af0-38e00d1b92fmr17325081637.41.1769056396880;
        Wed, 21 Jan 2026 20:33:16 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf251a6csm15849994a12.13.2026.01.21.20.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 20:33:16 -0800 (PST)
Date: Thu, 22 Jan 2026 04:33:09 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v5 1/4] net: bonding: use workqueue to make sure
 peer notify updated in lacp mode
Message-ID: <aXGohVBmvaYIYt2w@fedora>
References: <cover.1768709239.git.tonghao@bamaicloud.com>
 <f95accb5db0b10ce3ed2f834fc70f716c9abbb9c.1768709239.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95accb5db0b10ce3ed2f834fc70f716c9abbb9c.1768709239.git.tonghao@bamaicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252206-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,jvosburgh.net,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,lunn.ch,blackwall.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,blackwall.org:email,jvosburgh.net:email,lwn.net:email,lunn.ch:email]
X-Rspamd-Queue-Id: D20E461BFB
X-Rspamd-Action: no action

On Sun, Jan 18, 2026 at 12:21:11PM +0800, Tonghao Zhang wrote:
> The rtnl lock might be locked, preventing ad_cond_set_peer_notif() from
> acquiring the lock and updating send_peer_notif. This patch addresses
> the issue by using a workqueue. Since updating send_peer_notif does
> not require high real-time performance, such delayed updates are entirely
> acceptable.
> 
> In fact, checking this value and using it in multiple places, all operations
> are protected at the same time by rtnl lock, such as
> - read send_peer_notif
> - send_peer_notif--
> - bond_should_notify_peers
> 
> By the way, rtnl lock is still required, when accessing bond.params.* for
> updating send_peer_notif. In lacp mode, resetting send_peer_notif in
> workqueue is safe, simple and effective way.
> 
> Additionally, this patch introduces bond_peer_notify_may_events(), which
> is used to check whether an event should be sent. This function will be
> used in both patch 1 and 2.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
> v5:
> - introduce the common bond_peer_notify_may_events used in patch 1 and 2.
> v4:
> - keep the netdevice notifier order.
> v2/3:
> - no change
> v1:
> - This patch is actually version v3, https://patchwork.kernel.org/project/netdevbpf/patch/20251118090305.35558-1-tonghao@bamaicloud.com/
> - add a comment why we use the trylock.
> - add this patch to series
> ---
>  drivers/net/bonding/bond_3ad.c  |  7 +---
>  drivers/net/bonding/bond_main.c | 66 ++++++++++++++++++++++++++-------
>  include/net/bonding.h           |  2 +
>  3 files changed, 56 insertions(+), 19 deletions(-)

[...]

> 
> +/* Peer notify events post. Holds only RTNL */
> +static void bond_peer_notify_may_events(struct bonding *bond, bool force)
> +{
> +	bool notified = false;
> +
> +	if (bond_should_notify_peers(bond)) {
> +		notified = true;
> +		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
> +	}
> +
> +	if (notified || force)
> +		bond->send_peer_notif--;
> +}

If there is a new version, maybe change the logic to

static void bond_peer_notify_may_events(struct bonding *bond, bool force)
{
        bool do_notify = bond_should_notify_peers(bond);

        if (do_notify)
                call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);

        if (do_notify || force)
                bond->send_peer_notif--;
}


Others looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

