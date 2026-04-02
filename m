Return-Path: <netdev+bounces-274302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBgFDkK9zWlmgQYAu9opvQ
	(envelope-from <netdev+bounces-274302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:50:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C917B382157
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5181C3022579
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0CD233704;
	Thu,  2 Apr 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKtyrqwL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A541891A9;
	Thu,  2 Apr 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090999; cv=none; b=ecYzDWVNhRIwqkihcEsTBhl9nfrn3Z8iDEdn+5i/72DSwRrrfLyVZMaatFeX8PeUyX7aHbVXePvvHObAhDIGjWASUxZYxtlGeuv3wr3zXMIyOqBLKIXEWPvbN1f6eV8ko/yVm33vfQez3bKU9psbkGVUukVybTIXwlMec6SU0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090999; c=relaxed/simple;
	bh=jjc/fLoZs5Ki0ribTW+wFhCq+oTJbcdiP+szOIm3u14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuFpj1V9poL67vefDRg12gGflBGSSD7SQKVb65XPMacFUwhQpGP1Egd4mQxoGkntOV3auNFZVICIiN39na3BtRHvKCwq6f3ujke4pVS3XRxspSZJM0mGzi2ti4TvvWx39K/a3ba5XO5swhj7Q3I3PJmCqtOPAQUOiJgnkwyzzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKtyrqwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F97C4CEF7;
	Thu,  2 Apr 2026 00:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775090999;
	bh=jjc/fLoZs5Ki0ribTW+wFhCq+oTJbcdiP+szOIm3u14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VKtyrqwLu9c+418UDa9Nizrr35Mvvx1oZQUMC+dAFUXX1mE5ER8GLh8/xh5UM0utj
	 l2ZtLSpNQx1Dd77/iv/qW7A2TSbxC4KixLAG8r+RDmlcLMl9BiycSncchTCVM7aC3D
	 E/NJG+wUVuHkINFWScspI2TBJ4HMgnIsTiRZZmUJ4wy95aJySrc2AdUaeG/2lamj6q
	 MKb7HyKU3r7e9+EgboSVgOR7m6ghujSvJfWG72sgFz6lbvtwLh2/j1ZnFazjx+LcJc
	 o88hJ7XiFrGeZdswYlbxzk5slsaE0HicbAIUKsDl67NvQrWymoepyu/O24jVJsrrJ0
	 ZMjqIHdKLQXRA==
Date: Wed, 1 Apr 2026 17:49:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] ethtool: strset: check nla_len overflow
 before nla_nest_end
Message-ID: <20260401174956.1e526940@kernel.org>
In-Reply-To: <aczI7FfIScrKhBGQ@fedora>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
	<20260331-b4-ynl_ethtool-v1-3-dda2a9b55df8@gmail.com>
	<20260331184637.58b968ef@kernel.org>
	<aczI7FfIScrKhBGQ@fedora>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274302-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C917B382157
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 07:27:40 +0000 Hangbin Liu wrote:
> On Tue, Mar 31, 2026 at 06:46:37PM -0700, Jakub Kicinski wrote:
> > On Tue, 31 Mar 2026 11:56:13 +0800 Hangbin Liu wrote:  
> > > +		if (skb_tail_pointer(skb) - (unsigned char *)strings_attr > U16_MAX)
> > > +			goto nla_put_failure;  
> > 
> > bit ugly, let's add a variant of nla_nest_end() which can return 
> > an error on overflow (without the warning from patch 4) ?  
> 
> I was tried to not touch nla_nest_end() as it is used everywhere. But it makes
> sense to me to add a new function to check this. I'm not very good at naming,
> maybe `nla_nest_end_validate()` ? Or any other name if you have?

I was thinking nla_nest_end_check() to match the __must_check
attribute. But I also like nla_nest_end_safe()
_validate() is a little long but anything <=5 chars is fine.

