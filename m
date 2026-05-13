Return-Path: <netdev+bounces-287690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHA7KDmxBGriNAIAu9opvQ
	(envelope-from <netdev+bounces-287690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:13:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B45C537CB4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 241423005998
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5684D90AC;
	Wed, 13 May 2026 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maaDQCJ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE54DA553
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692405; cv=none; b=dR4PzhSRrxSZ3NcJnijqX+xsuGLKncANXOnl3GME+WM1cYgeMxQmPg+PgbxTL1tAx8YlJz3SudV52k0x8ow8KxnZP82Vz+nmLeuB22jGZlXKgEtDs/1ZSFSm7mFABLyMl9xeAHb6gR76KaJaB8l+Smcpl/FzxzY86i6x78XRp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692405; c=relaxed/simple;
	bh=dKiLkoWAT7De2hnO3RiTvBKsfFb8Z24RkD6rYLQg3ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWnVS+HUOPoEMNQaOb0rHOSL5UfgseR6G1e7NyytckNArpBF3IvdkYLE7nbZLe8BYt07Gqg8nDQpQ/WzzhY6+wj1Ie+/K5y3DmAMU5GpkiYuR8yO8Os20VicOd0reB47OzooEY6yncWu4cCu3E/N0IgQ8vxtRTrrBSz4ewCs+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maaDQCJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A107C19425;
	Wed, 13 May 2026 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778692405;
	bh=dKiLkoWAT7De2hnO3RiTvBKsfFb8Z24RkD6rYLQg3ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maaDQCJ2VPORMmckdKvd8mwCZUtreUZZlAGKAXbylLxToIElvh+SN+siim+eCvAeQ
	 XTw2RA1cbpede6lqrIWZgH2sNQZMhcjBE7tcNuARyaA2b4djyP5ywL60SgOV4zp0ie
	 ByoFfnVS4UKts8UdSHr4rVxCSPVpGvAl4XUuJJKBXVci/2vXap3YSLdg+jjd0rLCuc
	 OaFfgCoVHLtseQYdlYZtg4e7okXYCC9Ibf81pCORnvSwzOGxtTbs5mFk9+Tqc9PPdb
	 UGOiFcc79OzeUhmSBBTaaswRqhzgUCte8LrefrDuNwFgRf2RYhrRqs0QDHx5bEm5U6
	 nZQEHUzT4O5ww==
From: Simon Horman <horms@kernel.org>
To: dongchenchen2@huawei.com
Cc: 'Simon Horman' <horms@kernel.org>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tpluszz77@gmail.com,
	netdev@vger.kernel.org,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net] net: xfrm: Fix dev refcnt leak in async resumption
Date: Wed, 13 May 2026 18:07:56 +0100
Message-ID: <20260513170755.253159-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509074443.104163-1-dongchenchen2@huawei.com>
References: <20260509074443.104163-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B45C537CB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,secunet.com,gondor.apana.org.au,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,huawei.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287690-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: xfrm: Fix dev refcnt leak in async resumption

This commit adds a dev_put() to the return path of xfrm_input() when afinfo
is NULL during asynchronous resumption, aiming to prevent a device reference
leak.

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index f65291eba1f68..c98a29d80a534 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -765,6 +765,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  			return err;

This return is reached when xfrm_gro is true and gro_cells_receive() has
just consumed the skb.

If afinfo is NULL, err remains -EAFNOSUPPORT (-97).

When a negative error is returned back to the synchronous IPv4 input path
(ip_protocol_deliver_rcu), doesn't the IP stack typically resubmit the
packet using the negated error code (-err = 97) as the protocol number?

Could this cause a use-after-free when the IP stack attempts to dereference
the already-consumed skb?

Also, since transport_finish() was skipped, could this inject an skb with
unreset headers into the GRO engine?

Would it be safer to jump to the drop label immediately if !afinfo?

>  		}
>  
> +		if (unlikely(!afinfo) && async)
> +			dev_put(skb->dev);
>  		return err;

In the asynchronous path, callers like the bottom-half crypto completion
callbacks return void and ignore the return value of xfrm_input():

net/ipv4/esp4.c:esp_input_done2() {
    ...
    xfrm_input_resume(skb, err);
}

Does this code leak the skb memory?

Returning an error here drops the device reference but appears to leave the
skb un-freed, as it is never passed to the next protocol layer or explicitly
freed via kfree_skb() or by jumping to the drop label.

>  	}
>

