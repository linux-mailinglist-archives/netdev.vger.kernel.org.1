Return-Path: <netdev+bounces-289152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBfMKGJbC2oCGAUAu9opvQ
	(envelope-from <netdev+bounces-289152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:33:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 984B05724DB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 484FC300E926
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6538BF7A;
	Mon, 18 May 2026 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyhlgZov"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890038B7D6;
	Mon, 18 May 2026 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129164; cv=none; b=SYlwuIy4xVFClZckyzwwGqp/NldEb6V6QKW6QCDcZDHm/y8WcZ1AXqHf6cnkaolNC7n83Tv2pgVaWhiWMMhQ29XhM9l1iVHKHchuwRHgYvpC4H8Bx8RXj/Sn/aURBbAcskWmj2jIJLn0yQX2B27mS9ByM+fDgKGHVasJwfmsTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129164; c=relaxed/simple;
	bh=0RaJhtpEWtU3k0n7Y9j7Zkx9qNKgrBCTo8uIa101wog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJMLD23HO3DkUL7iKYUANe7N3AzewWdFHZ69eEBQXsM7L8jkiVPTpv4j2rZErRvSvrJJkPYWjkyZzKJqjiVYRsMYCxQ7SCDQ1eNgn52cTmJk1TbviOBS96mDuOyat7FVEE9UXpVdJdb7BxoNUZbXG7Zn7najjfQxDA0c7GXpMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyhlgZov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99763C2BCB7;
	Mon, 18 May 2026 18:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779129164;
	bh=0RaJhtpEWtU3k0n7Y9j7Zkx9qNKgrBCTo8uIa101wog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyhlgZovN73HWmKI3crtE6jK8YSJhJP+DNC3a1VBckhD1IKOpEmOM1s/YK5NN7B97
	 100R11BiJv5d6rHzoLNaEXlKwmi+hcwisSfLhkQJ7sX7m6qBgK9Lz/WmxrjBXaluxS
	 lCb+x1KubsFK3dJK7Q51n0ZMijfTS75+zhXQgBxmgbwuDZQ4Upn+DuC8uRxyAPqKQG
	 y79+ghnrAAg304oZh6quO0j4Vr7oBOBW17Y5AlWQ1NWYWLoqxq0mJhfjUpwQHyrv/v
	 cpxJwVojC4dBE88xdSIIMQ3pW4Vw3/uiN0Ywt9XOZ3trslPcVpi5cBwo3V/gIeAUWN
	 nfmQ2rBRZDJeA==
Date: Mon, 18 May 2026 19:32:38 +0100
From: Simon Horman <horms@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Blair Steven <blair.steven@alliedtelesis.co.nz>,
	Carl Smith <carl.smith@alliedtelesis.co.nz>
Subject: Re: [PATCH net-next] i40e: Avoid repeating RX filter warning
Message-ID: <20260518183238.GE98116@horms.kernel.org>
References: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289152-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,alliedtelesis.co.nz:email]
X-Rspamd-Queue-Id: 984B05724DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 14, 2026 at 12:37:33PM +1200, Chris Packham wrote:
> When the i40e runs out of space for RX filters the driver switches to
> promiscuous mode and warns that it has done so. In scenarios with a
> large number of these filters this can generate a lot of warnings. For
> example:
> 
>   $ dmesg -c > /dev/null
>   $ ip link add dev br0 type bridge vlan_filtering 1 vlan_default_pvid 1
>   $ ip link set dev eth7 master br0
>   $ bridge vlan add vid 1 dev eth7 pvid untagged self
>   $ bridge vlan add vid 2-4094 dev eth7 tagged
>   $ dmesg
>   [   25.601705] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.601833] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.601961] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.602088] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.602216] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.602344] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   ...
> 
> Use test_and_set_bit() so that the warning is only issued when the
> driver enables promiscuous mode and not on the addition of subsequent RX
> filters.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Resend with net-next tag

Reviewed-by: Simon Horman <horms@kernel.org>


