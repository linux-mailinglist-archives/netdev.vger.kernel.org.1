Return-Path: <netdev+bounces-264133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BUUtFmLlqGk3ygAAu9opvQ
	(envelope-from <netdev+bounces-264133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:07:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F4520A17D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E8E43050D4D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB11A8F84;
	Thu,  5 Mar 2026 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu/vSVfj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D64DDCD
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676446; cv=none; b=fsAuv0Xi1CXHQEh/dvb/zTjmKWjYKJ9L60DTdUx/2+ci4z0yAa0C4mAXoMfFfPgws0At6gf+3s2o6SrtcYzkGcJTQP9zsZUVfV8RwkjufZrv/ngLuOZIR7fg8sezp+ELmZJHIkgHZ/BisZVosJp8Hf/g65C5ghpZeriUVNelaLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676446; c=relaxed/simple;
	bh=kIeMBm8JQY/tVg5Mu9eqWpnymN9wjg2e8dBFvrtDX5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/qR8B3S7V/49isSMU2JxrQO+5WghxEpfLsHi8nJAbLBUNV8ccPL341aQqEObQ3eNTUV9rVYPKmhv+/PPtyCiYxgTauR2F8C5H40DiQC11siXI7LYKN1PKBoCXkNuw3ul8/4uuIkBlVyU6D3IC3DDkz0co0B5ZUxWAmDq1sMALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu/vSVfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D70C4CEF7;
	Thu,  5 Mar 2026 02:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772676446;
	bh=kIeMBm8JQY/tVg5Mu9eqWpnymN9wjg2e8dBFvrtDX5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bu/vSVfj0+7wDE9lrPwHm6yQZVOtaReQKgZWJdtsn5w3yLKM6kaN4xW1KLCKrq5K2
	 BWAwiKlpl9YxQS4KXN6bbhKOdnet+yjR1NRTd1goHxe/nSvVwIQfIcTu6KhAmTwQKs
	 NQUoIaQJNJf66Bc1EW2E2AtRsGWY125lvskR4dW1siNx6wI4iBDaE/cOsKTMb1LHIv
	 87Ktga601y6IZwucuBi+MoAmbkAM92F9ZA0OGQdTtRf8qV30MCrGqoYkmIlldgRRW2
	 n0fUy23PEh/5j1R3jC9JnBAmHprI4uqd74AcrZo6yMKF8wWlj03VgCPsF6PZefA0MV
	 EY3fA97uMoxmw==
Date: Wed, 4 Mar 2026 18:07:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, davem@davemloft.net
Subject: Re: [PATCH net-next v3] ipv4: validate IPV4_DEVCONF attributes
 properly
Message-ID: <20260304180725.717a3f0d@kernel.org>
In-Reply-To: <20260303124038.5886-1-fmancera@suse.de>
References: <20260303124038.5886-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8F4520A17D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264133-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 13:40:38 +0100 Fernando Fernandez Mancera wrote:
> +	[IPV4_DEVCONF_MEDIUM_ID]	= { .type = NLA_S32, .min = -1 },

Don't we have to set validation type for this to take effect?
Why not use NLA_POLICY_MIN() ?

> +	[IPV4_DEVCONF_ARP_ACCEPT]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),

This one should accept 2 as well? 
-- 
pw-bot: cr

