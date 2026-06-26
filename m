Return-Path: <netdev+bounces-302265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l0MYE97jPmqQMgkAu9opvQ
	(envelope-from <netdev+bounces-302265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA916D00BA
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=digikod.net header.s=20191114 header.b=vy+Tatby;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302265-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302265-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27EF1303CC09
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BD23BF660;
	Fri, 26 Jun 2026 20:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335E1F1534
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 20:40:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506422; cv=none; b=ZF9aFaHk3s8htIZokOa0jpLClk24BVW5Nu/uaCw2T4IQqraqGRk/vdfWp6jzyH7kRqJvbrPq0MJjxvqXIdKA6zvMT/j/oFL6DGKJfJ/SAZqBtZigZNomK6gNzw5PXPMS4i3VcbDLakLvvCd4hkc8bsYlCYyiuIl326klbsgqnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506422; c=relaxed/simple;
	bh=ANWck8WLbRAXZ361J9dhNik1il372xldklrcJQiz0+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3wW6LKtwy0qc0BmDE25R/+w6HybxSO422b30o9j5F005sKG4OdetFvGpRLWznhBLX87sM2DXN/xCgcAcPB31PVB7RzA6k+QwDu98jqSAxtulyr3pA3sq1SCRsIc2ZMaiIb0+Hg8QL2wTDjLYd9TTyld96/OmAOWSq6dXk4nZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vy+Tatby; arc=none smtp.client-ip=185.125.25.10
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gn6xQ3bn9zhBm;
	Fri, 26 Jun 2026 22:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1782506410;
	bh=+VmxfcqJWx2b/sUIHGbG0OEVcTdIR7OEfECFfcjnP4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vy+TatbysO9/4zv2ZAaEeC3RSyJfmSUEGS58qiVY7kOayCvk25FG0p2n3hCoZj/zT
	 r8bF6GwIcl16dMclkbNGdRf4vt33Gfcnch9q0Fc9+tFNZOEBKSSrDG2wn01QT226k/
	 D/09kwO0Qq6h9ViZq5Kb6DYpf9m9FeNAin24KsGQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gn6xP1qnLzRhj;
	Fri, 26 Jun 2026 22:40:09 +0200 (CEST)
Date: Fri, 26 Jun 2026 22:40:04 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
Message-ID: <20260626.taijohThood1@digikod.net>
References: <20260617.eemahv8ui7Ee@digikod.net>
 <20260617180526.15627-1-matthieu@buffet.re>
 <20260617180526.15627-2-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617180526.15627-2-matthieu@buffet.re>
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.99 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302265-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	FORGED_RECIPIENTS(0.00)[m:matthieu@buffet.re,m:hexlabsecurity@proton.me,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:paul@paul-moore.com,m:edumazet@google.com,m:ncardwell@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[digikod.net];
	FORGED_SENDER(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:dkim,digikod.net:mid,digikod.net:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,buffet.re:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AA916D00BA

Thanks Matthieu, could you please rebase this serise on the master
branch (especially on top of your UDP changes)?

This patch will be useful for backports though.

On Wed, Jun 17, 2026 at 08:05:23PM +0200, Matthieu Buffet wrote:
> The documentation of the socket_connect() LSM hook states that it
> controls connecting a socket to a remote address. It has not been the
> case since the addition of TCP Fast Open (RFC 7413) support, which allows
> opening a TCP connection (thus, setting a socket's destination address)
> via the MSG_FASTOPEN flag passed to sendto()/sendmsg()/sendmmsg(). The
> problem then got duplicated into MPTCP.
> 
> Landlock did not take it into account when its TCP support was added,
> leaving a bypass of TCP connect policy.
> 
> Ideally a call to the LSM hook would be added in the fastopen code path,
> in order to fix this generically. But connect() hooks are designed to run
> with the socket locked, unlike sendmsg() hooks.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/41
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  security/landlock/net.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 4ee4002a8f56..a2375762c18b 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -246,9 +246,26 @@ static int hook_socket_connect(struct socket *const sock,
>  					   access_request);
>  }
>  
> +static int hook_socket_sendmsg(struct socket *const sock,
> +			       struct msghdr *const msg, const int size)
> +{
> +	struct sockaddr *const address = msg->msg_name;
> +	const int addrlen = msg->msg_namelen;
> +
> +	if (sk_is_tcp(sock->sk) && address != NULL &&
> +	    (msg->msg_flags & MSG_FASTOPEN) != 0) {

This might be a bit better:

  if ((msg->msg_flags & MSG_FASTOPEN) && address && sk_is_tcp(sock->sk))

> +		return current_check_access_socket(
> +			sock, address, addrlen,
> +			LANDLOCK_ACCESS_NET_CONNECT_TCP);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
>  	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
> +	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
>  };
>  
>  __init void landlock_add_net_hooks(void)
> -- 
> 2.47.3
> 
> 

