Return-Path: <netdev+bounces-261092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEM0JFJun2mZbwQAu9opvQ
	(envelope-from <netdev+bounces-261092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:49:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D779A19E048
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB2F302296B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749673176E0;
	Wed, 25 Feb 2026 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3rJ+1vw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB5316918
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055870; cv=none; b=e8Bw8c2OfjQihsfm3A+f2H1MBTG4j39jyqN5x0WymsaJfVudTzInsgB0WdAlYXdc5to/IHVk4E5OUnEc47xltSmXMOXQtIrXyrNVZtlxS2XOkab3jpaT64et1KDzHejteN+ylm13ILjdEZwvt5+jesHC1ugAlHYi/CSPjQZMAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055870; c=relaxed/simple;
	bh=lXk1/42swGOfDW7fjXXb9ek/blLk3kgUND/8w0szjkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jj0Y+uIGV0fTiQgDI3DM6KD1SABvQ7u8WIea7lLxkkAs/UUrTDx2o0Ewru7FAAuaqBSe+fvRWbtAasbZPP23yd7eRC5+zPlDLDAXVFqbcZ85srD8aMe+tzee9vW9FAinmtkLk7c+j1mpEoO6ZKTPW7KU138o+sC8X3C3DzX80dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3rJ+1vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F20C116D0;
	Wed, 25 Feb 2026 21:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772055869;
	bh=lXk1/42swGOfDW7fjXXb9ek/blLk3kgUND/8w0szjkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R3rJ+1vwxwYZbqa9qil1CW9M8pH4ScaljgN75ICRuqGhQj6MzUvt9KZScU91OiEuj
	 pNSBiTQA4q9CiO9ZEg14Yb/pn7nNz0favNdLpQRzOl/KYQIEZVay6uuYoXa+dxesZY
	 nhExbrv2Sy3w+NKFU3YXWLR/xDY6/hpIPKgZer98qutr++5osNEm1GZX2X2mtyLGqy
	 YDQbtdi6SPiYAGiHTdB5cUa8fEnUHmQg5Byl2xkjwM7smWr9XJx+gQNrMLlajh8kF/
	 WdDZjiFiwn7NZDRx3ESqKz8LQJr0R1SyIIACgvlZbVMiJ1GZg233IlbDPtuJUFyNhM
	 Vo/J53FSCcRFQ==
Date: Wed, 25 Feb 2026 13:44:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Subject: Re: TCP OOM drops with the stricter rcvbuf checking
Message-ID: <20260225134428.570bfbfd@kernel.org>
In-Reply-To: <20260225122355.585fd57b@kernel.org>
References: <20260225122355.585fd57b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261092-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D779A19E048
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 12:23:55 -0800 Jakub Kicinski wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 326b58ff1118..9f7ed76a97aa 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3383,7 +3383,8 @@ u32 __tcp_select_window(struct sock *sk)
>                  * Import case: prevent zero window announcement if
>                  * 1<<rcv_wscale > mss.
>                  */
> -               window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
> +               if (window < (1 << tp->rx_opt.rcv_wscale))
> +                       window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
>         } else {
>                 window = tp->rcv_wnd;
>                 /* Get the largest window that is a nice multiple of mss.

Hm, reading thru __tcp_select_window() more carefully I guess there's
already an attempt to solve this:

	if (free_space < (full_space >> 1)) {
		...
		/* free_space might become our new window, make sure we don't
		 * increase it due to wscale.
		 */
		free_space = round_down(free_space, 1 << tp->rx_opt.rcv_wscale);

the problem is that over loopback we can receive rather large skbs,
so we don't hit this round_down(). The drops I see have < 64k inq,
and the incoming skb is > 64k.

Perhaps this condition should check if free_space < gro_ipv*_max_size
as well (modulo gro_*_max_size vs tso_max_size on loopback)?

