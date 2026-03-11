Return-Path: <netdev+bounces-266397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB/1EQO8sGlXmgIAu9opvQ
	(envelope-from <netdev+bounces-266397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:49:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C664B25A271
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71AA030D0D14
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923815733E;
	Wed, 11 Mar 2026 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxYbw6WN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FF36C9CB;
	Wed, 11 Mar 2026 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190123; cv=none; b=EqeZkO1hjZiu9Py5276LSjVva6l3pK6EB4Rh+dXMzCxn/HGNzjxcmRhPN0TV7ibLgXbJqINUYtoKeS0+x6k3xHYFhj3GV4b1mcMSBa2Nbon016SEHkka6YA9g/be6C7oSWbJE/dPLrJoIoDkk5nk4Ki5XsjXXB9g8sLGUi6OYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190123; c=relaxed/simple;
	bh=j/Rn2lE3w1IWHyPgbBSp6VMEXCIsvCmZ/KsD2n07164=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8+Og0JkVXncEapuiY1/l7w3VpjwuQ/LNuuWlBDyXPW312OxXbcoqijx7x5eTFVBaSpNAXkqjL74sY9GFfXA5cB6U7d7fm6/gg9tz5MKP0+c3cYOs6YG9u0mGxUsiRPEGRsRcJdsrHPvZwgl5qi8ynWWlkOV1u9H7IPEBoMu1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxYbw6WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3EBC19423;
	Wed, 11 Mar 2026 00:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190122;
	bh=j/Rn2lE3w1IWHyPgbBSp6VMEXCIsvCmZ/KsD2n07164=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qxYbw6WNcLrNGIa22WjzEAa0BCZxopLsO67AqWP8LPA7fojIjoW7aiii8gAn4dRHs
	 KgCNUPxUqa0bU5vWNMpor0vdrxV01BGNLtitNjPfAcRNVmUEeAzMQBZf7qIax7sR3e
	 L3/mzQkGICPOvxgKBSumks/DG60JpXOykmCJtRhBJLLo/FZy1OAdN5Y6P32ISCGjO4
	 9DN79Fx/VsXs6zaSx/lU1eA+ZGHmg8dYidzDgeTvGa3Ln7eHtLjKWIUsOoutpi6LZs
	 hybDBMVwvCOvVdq7Krt4OGVO3ivpk0bxLFg2X86yw8+ZauDJ45WHDY6Pb4yARlIb/p
	 AL2wCV5EWEYQw==
Date: Tue, 10 Mar 2026 17:48:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guoyu Su <yss2813483011xxl@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: use skb_header_pointer() in
 gso_features_check() for TCPv4 GSO
Message-ID: <20260310174841.5f5671c5@kernel.org>
In-Reply-To: <20260308083319.1255118-1-yss2813483011xxl@gmail.com>
References: <20260307162905.3697050-1-yss2813483011xxl@gmail.com>
	<20260308083319.1255118-1-yss2813483011xxl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C664B25A271
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266397-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun,  8 Mar 2026 16:33:19 +0800 Guoyu Su wrote:
>  - Drop the SKB_GSO_DODGY shortcut.
>  - Use skb_header_pointer() for safe IPv4 header access.

Let's keep the DODGY check and directly compare skb->len to offset +
sizeof(*ip)? Some of the callers in the syz repro are probably buggy
(HSR?) so they should be fixed rather than ignored.

