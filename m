Return-Path: <netdev+bounces-272342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCgDF+H0xWnbEgUAu9opvQ
	(envelope-from <netdev+bounces-272342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:09:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B327B33EAF3
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34F3300B461
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4011734EEFD;
	Fri, 27 Mar 2026 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS+Bo1Lo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94334E74E;
	Fri, 27 Mar 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580629; cv=none; b=eWBNmNG+qVrrS3D0nm2L+ID2WxfAnwCqZc9rsXfSPUTZqXzNxRdz72vfe5Z++o9kjhZbdlnRu6a4Zol46bf6rDtRrjIa2AaO4J1TjNBPFBD+sQKaGDT5Giw8IItnP8tmQSRQlvOsi1IvCul0ludnSw5rMOPTnU8p9931OHkc09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580629; c=relaxed/simple;
	bh=MfCyollKECJrX9j3xlBSKTMWgYsxDOXIbX2f0zv66gM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZXBFlQB+UyWWjakR/dHEpfXYmIYLoxOMJcPnZMGCjfM9elw9DedkhJpY7baqSUnA3gi3NyN8SayLfNvoOJ2JuWQEuyOx5V2EqWrnk0ZxT74Odf5e5hSIR9F7vSGTnuklQ80SuxUU+aTGDJnlxka7SQyJmktKg/6UNgnR6BpGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS+Bo1Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05A1C116C6;
	Fri, 27 Mar 2026 03:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774580628;
	bh=MfCyollKECJrX9j3xlBSKTMWgYsxDOXIbX2f0zv66gM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pS+Bo1LoLlU/96jXU3wGeSFtVbdn+gl67o1g6/qlUoA0tWMPdt+Hbe3vgXkjllXc+
	 E5pDnNYlpuEkJ0SWayt8CggKsE/pkUhchxM0Sx1Ah+4oyiA/V31qh9jaC3SEX5QaAU
	 IkEBNry4C3KigevnohOfUUQX49ImoJkIAtRJncVxruhxa6x00iw/PT5ySXo+sGrFla
	 BlsdLSssYRkQ8ROlpBOfMmX5RlWb9opcyZ6ox0Eqoq+jbGsJpto/+qaSD07JaNsfwD
	 7Yo75GWZ/WGARKUoUPFO4mqTN/6iafA7syuoroz9uDPQLA2jl3y3YN7T8QXrlR6av0
	 ubIvCVAU1OWZg==
Date: Thu, 26 Mar 2026 20:03:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <mst@redhat.com>, <jasowang@redhat.com>
Cc: Di Zhu <zhud@hygon.cn>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <willemb@google.com>,
 <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: Re: [PATCH net-next v4] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Message-ID: <20260326200346.438702a6@kernel.org>
In-Reply-To: <20260323041730.986351-1-zhud@hygon.cn>
References: <20260323041730.986351-1-zhud@hygon.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272342-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B327B33EAF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 12:17:30 +0800 Di Zhu wrote:
> Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> allows control over offload support, but the offloads that can be
> controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
> nor GUEST_TSO6 is supported).
> 
> In such a setup, reporting NETIF_F_GRO_HW as available for the device
> is too optimistic and misleading to the user.
> 
> Improve the situation by masking off NETIF_F_GRO_HW unless the device
> possesses actual GRO-related offload capabilities. Out of an abundance
> of caution, this does not change the current behaviour for hardware with
> just v6 or just v4 GRO: current interfaces do not allow distinguishing
> between v6/v4 GRO, so we can't expose them to userspace precisely.

Michael, Jason, does this patch look good now?

https://lore.kernel.org/all/20260323041730.986351-1-zhud@hygon.cn/

