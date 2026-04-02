Return-Path: <netdev+bounces-274298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB64H6y6zWnqgAYAu9opvQ
	(envelope-from <netdev+bounces-274298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:39:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A33820A5
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57CE4304BBA1
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C506C2288E3;
	Thu,  2 Apr 2026 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX4HxWjt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2FCA6F
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090324; cv=none; b=hxZKzUdYVraMz3KyU7tFI2V36LAhjsCTSm2GV2rmKUmhF4hweljcJnc2yq0gyYItlmEuVTORH3XEJz13C6GQaWas++DEj/7NlGW+sRrEwZo/pqvS8HY8p/8IsUbtRUqXEAM9lVpRMQNZjeMPHEYq5b2lU5uF5dViq8h59pbIZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090324; c=relaxed/simple;
	bh=yy629Hf89kRkCloYSbiQgvfX/GNhce78QZJyjjjFBQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0Blna9IIKqgiRB/TXtnzm6usRKvcrkoLFrI2PMK/06/zA005ocay0kfsl1Q6I2QrZCaqvJD0iiCsiYQMutn3vPxq8dEsL0G39EnLQhRmHbnp1BcpgNia6viTzjoTi9Dj+9rW06IN8uViDicZar61N6zAqNlE1nVUMQUl+vH0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX4HxWjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E35C4CEF7;
	Thu,  2 Apr 2026 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775090324;
	bh=yy629Hf89kRkCloYSbiQgvfX/GNhce78QZJyjjjFBQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sX4HxWjtFN/PMdnAve1yL6OuQr1tt4IB1GguN98L5DIrwgnxojcRbgU3shFiSS3ej
	 riBDZshIOzJpVTZTHZOhnHoHv0aguMqELKr7QV+ttjtLGItBHE0KoFHPryBWCc9jh9
	 KrFWaJ8TUkkfjF2cJl/BjymdWrKEyjx9uB9cf6e/JIW8R2wME/qYC7RpDMiz7W26+a
	 W564ICsD8d6/En4gBqPJsAAOgxQhCxjaW2qkzupdEqMdLxyxojqpU2VbuIxrghuQB4
	 aUVqqoCypxSBMlfqFIPbpCjbJCzMrpN1vYAlfcBKbv3xYBqly84diu/FXj6ON9haNO
	 cwSoMrbCh9AJg==
Date: Wed, 1 Apr 2026 17:38:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Arges <carges@cloudflare.com>
Cc: Weiming Shi <bestswngs@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, jgriege@cloudflare.com
Subject: Re: [REGRESSION] net: add xmit recursion limit to tunnel xmit
 functions
Message-ID: <20260401173843.7a2bb607@kernel.org>
In-Reply-To: <acwp_cVAflwTQCBh@20HS2G4>
References: <acwp_cVAflwTQCBh@20HS2G4>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-274298-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F3A33820A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 15:09:33 -0500 Chris Arges wrote:
> Commit 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
> introduces a regression in our systems using legitimate multi-level tunnel
> encapsulation stacks. Our testing was with stable 6.12.y and 6.18.y where this
> patch was backported.
> 
> One of the usecases we have are packets being sent to a GRE device, then
> MPLS/LWT route, then IPIP device, then SIT/FOU device. What we observed is that
> packets are getting dropped at the last device and we get the message "Dead
> loop on virtual device" sent from the iptunnel_xmit function.

Last device meaning limit of 5 would have worked for you?
I don't think there was any hard math behind the 4 so ++
on the limit may be simplest, but I defer to Paolo..

