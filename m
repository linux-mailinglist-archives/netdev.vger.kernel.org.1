Return-Path: <netdev+bounces-302201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SX3bHQCYPmrsIgkAu9opvQ
	(envelope-from <netdev+bounces-302201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:17:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8316CE67D
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:17:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EVjjbM26;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302201-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302201-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA3D4302E619
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E53839AE;
	Fri, 26 Jun 2026 15:15:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54A1A5B9E;
	Fri, 26 Jun 2026 15:15:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486938; cv=none; b=BNdzb35cLJGGJYK541ZJxvaO0UVZ4+d6WZlxuPrIfjI9XUUCB8winyth9TSDLjn3xiLOlOjE2WV0bN2COh3AM8z3Zdov0LaeVj5ER9VeQYKAm6/Sh/7wdeOLidHmA+lO/vSAktpxvlnEmlnQPZQZeAobbA6sWKtAP00OmG37fNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486938; c=relaxed/simple;
	bh=jA+LtT+w9ziFAv6SejZy4xHhQcaZUUtt+07+zT74GpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtbxPhdXd6+TLgHk/miOXJFxWS9Pb/MNbIGNuuoJAeYEzBNIJpuoxnPGOj418TzwYkN9By5187jR3C/5rFcZGeKNxTvfN9n8t5ovOPCFV/m/ARiF2ITAcb7JHFs7v56k+ff40UWycfRCbc+Pvzqrf8m75NfBGlZCeT/GN97waOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVjjbM26; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3081F000E9;
	Fri, 26 Jun 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486932;
	bh=xMY3o3jBD4b25D29n1Y1hcy2n0lXYQS1LYHlfhK/gYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EVjjbM26lfY86Z2EOtyBuaAUSZlbBDEVn8wyO0rAeKKowe7XE055BXKlqUgLhfaGe
	 0ATXsek9two9aM1KP+USC25qaYd5ShTQ/TpPiHBmpYVAkdndBPGi86rvG8kPT9Vxzo
	 DQ9Ntn6lLkKepCSOwAQV9YrM3Ti6BWqGeIKg4TUOas1d5crz70Zdyj4lsiMXMW80f9
	 9nleyzXTEDsdd9xrIWbZ8dbhsWvqyJIlmKWrm11ZWkf5CSfZomZ5/0QsnBLw91HQqb
	 cPjbAR99qtLBJOhzR6qequiNBP3qX9YI9meZkyeowhN/05ujj9Exo9iOL/NbDSlFu5
	 DANByD0lozLEg==
From: Simon Horman <horms@kernel.org>
To: lange_tang@163.com
Cc: Simon Horman <horms@kernel.org>,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	edumazet@google.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: Re: [PATCH v4] virtio_net: disable cb when NAPI is busy-polled
Date: Fri, 26 Jun 2026 16:15:08 +0100
Message-ID: <20260626151508.1319440-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625013733.29300-1-lange_tang@163.com>
References: <20260625013733.29300-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302201-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lange_tang@163.com,m:horms@kernel.org,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:jasowang@redhat.com,m:edumazet@google.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:tanglongjun@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D8316CE67D

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
virtio_net: disable cb when NAPI is busy-polled

This commit disables the virtqueue callback at the entry of virtnet_poll().
It aims to prevent a large number of spurious interrupts when busy-poll is
active by keeping the callback off while polling.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 26afa6341d161..c1e252400c0fc 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3011,6 +3011,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	unsigned int xdp_xmit = 0;
>  	bool napi_complete;
>  
> +	virtqueue_disable_cb(rq->vq);
> +

[Severity: High]
Can this unconditionally disable the RX callback and cause a permanent network
stall when polled by netpoll?

If the netpoll subsystem (e.g., used by netconsole) calls the NAPI poll
function directly with a budget of 0, virtqueue_disable_cb() is called
immediately. virtnet_receive() will then process 0 packets and return 0.

Later in virtnet_poll(), the completion condition is checked:

	if (received < budget) {
		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
        ...
	}

When both received and budget are 0, this condition evaluates to false. This
skips virtqueue_napi_complete(), leaving the RX callback permanently disabled
and preventing the device from raising further RX interrupts.

>  	virtnet_poll_cleantx(rq, budget);
>  
>  	received = virtnet_receive(rq, budget, &xdp_xmit);

