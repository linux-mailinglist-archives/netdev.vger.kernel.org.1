Return-Path: <netdev+bounces-277839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPgVL3LJ22nzGgkAu9opvQ
	(envelope-from <netdev+bounces-277839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:33:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ECA3E4D59
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD2DF3002311
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8542C0F6D;
	Sun, 12 Apr 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjbPiP12"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7D280CE5;
	Sun, 12 Apr 2026 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011630; cv=none; b=EX2GWo3V8JjSnrKVDrCXdg/lA6v5flr/FNW7eTmissnKoGGSK1XXfJI2OQoqxWzA+3pZUYdv+dtsbC/CL+3zqejiEsJMIVhT/ixJg24wnGVyJYTKatWAaF5+AD8qBlnMONk82qxz4BPsxBcmttEAOD+Mf5FkrXzGc66xJKfIbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011630; c=relaxed/simple;
	bh=9caTNklsKH5fwtpgjJv6ZfoD6CMjftVt24Y2Ka4Zvhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeQCC7aZBsOhK3NJjjGW067bP5zA+xATDu/MSoqKhRQgyRZbwFN5k4kx5Awj2eAFAovNMGGgrtIhvnxX9OWSq8SDJhjJ+RtWP+La4oKNGRNQvK2TWEmb4dkd4B/+K4EdCJ6urvBTykgf51zgo7WXyfUhwceU6u5o2/v4fO1EjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjbPiP12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531ECC19424;
	Sun, 12 Apr 2026 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776011629;
	bh=9caTNklsKH5fwtpgjJv6ZfoD6CMjftVt24Y2Ka4Zvhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gjbPiP12XtIgGGM/XVKBjv2XyIiTq2KjSPNxHQmxOVWgOSkiMxIQkqtFxYxe2HR1Z
	 FtQ95YwAn6wSapoXvfxOsZPbNFS9AzEQ9h//uZBIiPcwO184ITTUOyQgndaZdXjb+7
	 wmnXWaFfzlGkgFF2AgSmHI6uGlo+ZEuVH5sWnmZVeU81yT35U9Y1XWDe8JWepf8//O
	 SJlc5nubMiDa3aBJGPbp7jckyUFfYQAfU23QkWdm+y7i/ZZCppdImh7f8Lfzkk8t29
	 luGtD2rwtTPJMFdzBqCfmSGZIXkHGItotcHJTZ8PuWO0/nIAaoQghvhRc0FWQhLQly
	 ZPRBQV6NlhwJw==
Date: Sun, 12 Apr 2026 09:33:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet
 <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Weiming Shi <bestswngs@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: fix __this_cpu_add() in preemptible code in
 dev_xmit_recursion_inc/dec
Message-ID: <20260412093348.45ce45b0@kernel.org>
In-Reply-To: <20260410020631.191786-1-jiayuan.chen@linux.dev>
References: <20260410020631.191786-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-277839-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57ECA3E4D59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 10:06:30 +0800 Jiayuan Chen wrote:
> dev_xmit_recursion_{inc,dec}() use __this_cpu_{inc,dec}() which requires
> the caller to be non-preemptible in order to avoid cpu migration. However,
> some callers like SCTP's UDP encapsulation path invoke iptunnel_xmit()
> from process context without disabling BH or preemption:
> 
>   sctp_inet_connect -> __sctp_connect -> sctp_do_sm ->
>   sctp_outq_flush -> sctp_packet_transmit -> sctp_v4_xmit ->
>   udp_tunnel_xmit_skb -> iptunnel_xmit -> dev_xmit_recursion_inc

Eric, weren't there also a bunch of RCU reports because of this path?
Should we perhaps take the RCU read lock here?

> +	guard(migrate)();

Sorry but I detest the guard() usage. Please use migrate_disable()

Quoting documentation:

  Use of ``guard()`` is discouraged within any function longer than 20
  lines, ``scoped_guard()`` is considered more readable. Using normal
  lock/unlock is still (weakly) preferred.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

