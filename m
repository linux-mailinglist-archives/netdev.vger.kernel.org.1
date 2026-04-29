Return-Path: <netdev+bounces-282167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NrQHgBb8Wn/gAEAu9opvQ
	(envelope-from <netdev+bounces-282167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:12:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF97A48DE5B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B10233012CFF
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994F22F74A;
	Wed, 29 Apr 2026 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnbqo71N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469591CEAC2
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777425148; cv=none; b=evC1xto2lqcSuLtAD+rmcNCYvpY+Yo+Sqr6umQRh3mHDbvvmteWU4GIW2L1+hRqIEZoac9rQrdIWUyL+Y0gbRnQh8oEpeXSBsVZ6l+nhgOHl3VEeDtn5LxlPx1bXBnufrIJW/tvdPKp0w5qH86t679+8aXQhJm3o4OVruJ9yLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777425148; c=relaxed/simple;
	bh=x53b2NrR1Zgl/x9ZrvdzwVzZEyO8bTvt8OTMhuGfn1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f84qtFWpU5WzvThABLfc9XKWvW7BumM8WNJjGO0yfsq3KSflq8sA+FmvQKlDBYGblvKuRzVyLQYYOVuu4u9eMjrWDQFHUJyG0Z1GCVp6XubZsv0aUni5GsTz76MABWACgD4nB2DLs4FwydDXUa0RT3BRsM6nrkwgSHdlDDHhNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnbqo71N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F5FC2BCB7;
	Wed, 29 Apr 2026 01:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777425147;
	bh=x53b2NrR1Zgl/x9ZrvdzwVzZEyO8bTvt8OTMhuGfn1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnbqo71NeOuknNnhTCvsZHnzFxHvmBD3lum9F9RahurkufkgEgYNYmkOV8bZ7C7WC
	 SxO8HuQ64+vjX5wZZ9CRmeIqAOOYD+7+5kHIR0tv6Emkl5B8YhUaV7hk9Vdd9riJsK
	 mSU3j7k+J3lh/65Yp2BTdph2pr2HNOTz9k1hVrkNuDuY0JdaXs6B7VzStu6lT9YWAZ
	 vZjFXNZU7FZb309w88SnM0O2fLwkDZ9qC4Oc8yRaPH5uSSB6r/EaTcIJR/QxlXDfXP
	 vNel2sPBlmoSSw9JhzGu7KNGwVBq3ccK0/VyyPMhurxs7dE3QkF0DNiaFtzy2niJkl
	 mxkFFEsr6hHgA==
From: Jakub Kicinski <kuba@kernel.org>
To: mika.westerberg@linux.intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	YehezkelShB@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH 2/2] net: thunderbolt: Fix lockdep issue during tunnel tear down
Date: Tue, 28 Apr 2026 18:12:26 -0700
Message-ID: <20260429011226.1505821-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427081623.2338179-2-mika.westerberg@linux.intel.com>
References: <20260427081623.2338179-2-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF97A48DE5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282167-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.930];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    net: thunderbolt: Fix lockdep issue during tunnel tear down

This commit attempts to fix a circular locking dependency warning in
tbnet_tear_down() by dropping the connection lock earlier and returning if the
connection isn't fully established.

> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index 631af237998d..d8fcf18fc55c 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
[ ... ]
> @@ -372,48 +372,47 @@ static void tbnet_free_buffers(struct tbnet_ring *ring)
>  
>  static void tbnet_tear_down(struct tbnet *net, bool send_logout)
>  {
> +	int ret, retries = TBNET_LOGOUT_RETRIES;
> +
>  	netif_carrier_off(net->dev);
>  	netif_stop_queue(net->dev);
>  
>  	stop_login(net);
>  
>  	mutex_lock(&net->connection_lock);
> +	if (!net->login_sent || !net->login_received) {
> +		mutex_unlock(&net->connection_lock);
> +		return;
> +	}

If the connection is in a partially established state (e.g. login_sent is
true, but login_received is false), this early return skips clearing the
connection states.

Could this stall the connection if a new TBIP_LOGIN arrives later?
tbnet_handle_packet() would see net->login_sent as true and might fail to
queue the login_work to reply.

> +	net->login_sent = false;
> +	net->login_received = false;
> +	mutex_unlock(&net->connection_lock);

By releasing net->connection_lock here, the rest of the teardown process runs
without mutual exclusion. Since the network interface is still running, is it
possible for tbnet_handle_packet() to receive a new TBIP_LOGIN request right
after this lock is dropped?

If tbnet_handle_packet() acquires the lock, updates net->remote_transmit_path
and brings up a new connection concurrently:

CPU1
tbnet_tear_down()
   mutex_unlock(&net->connection_lock);

CPU2
tbnet_handle_packet()
   mutex_lock(&net->connection_lock);
   net->remote_transmit_path = pkg->transmit_path;
   mutex_unlock(&net->connection_lock);

CPU1
   tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);

Would CPU1 then erroneously release the newly established connection's hopid
and free active buffers?

>  
> -	if (net->login_sent && net->login_received) {
> -		int ret, retries = TBNET_LOGOUT_RETRIES;
[ ... ]
> -		tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
> -		net->remote_transmit_path = 0;
> -	}
> +	tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
> +	net->remote_transmit_path = 0;
>  
> -	net->login_retries = 0;

With the unconditional clearing of net->login_retries removed, does the
login_retries counter keep accumulating if tbnet_tear_down() returns early
above?

If it exceeds TBNET_LOGIN_RETRIES, could it permanently prevent new
connections until the module is reloaded?

> -	net->login_sent = false;
> -	net->login_received = false;
>  
>  	netdev_dbg(net->dev, "network traffic stopped\n");
> -
> -	mutex_unlock(&net->connection_lock);
>  }

