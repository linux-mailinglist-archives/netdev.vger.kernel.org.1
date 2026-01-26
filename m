Return-Path: <netdev+bounces-253521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOqBIKyJd2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:35:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30998A321
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 320CA3026A83
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F333891F;
	Mon, 26 Jan 2026 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL3XpXEo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A52459C5;
	Mon, 26 Jan 2026 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441442; cv=none; b=clpbwMyGhSOf7LiJImDWNEkWO3VUoFh8tyIEEgtgUX0Kc1Fcyj0nU4GFbRlKge3WJL0WSVP66OF2OMYga83OS225Ac3y/l+potm3pwEI46aSEQ4Hq2WdUU0GypMxAC9spsptB23ASoZmgF5GEVsju/dC92lIes3Fvz+qQQfPbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441442; c=relaxed/simple;
	bh=nQ/rDbIy+AZLKgwNbS/dXSS8LY0zFHstSR7UbJzJnvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0QkJ+v4ngMCgq7stKtchvqrF85GZSELPA/mcytLdq1jxsZP2ZsyoQAMaGhEuBnTNLLGa9Qx5V81kPLYwIDWNqXwVqMmkq4m1KvxtQd9X32grw8rYB6bchbgwGMNaVFayj7A8GbsDNfldD57mHhMzfLLLL9vsCBIaGFRDRDmCR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL3XpXEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F039FC116C6;
	Mon, 26 Jan 2026 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769441441;
	bh=nQ/rDbIy+AZLKgwNbS/dXSS8LY0zFHstSR7UbJzJnvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GL3XpXEo4JiD7OztPwdCgQYmKDoISQaPtdyNUzjl/skgTAd5OJStFM6aU2m0eoDRx
	 cO3AD+KWH1CbMGOH+51BCDbdkQIsG/VNtZ0+A8zOAmohIAhzVHJ0mLEqIN2P8dujqg
	 Yv/1H+ZZaG/QBvDqYUAEd12plRl12L3n9JeOx4+VMNzBy/x2DMDiLATm0jZB10RBwW
	 5gvVuqku1D6HnDVHQgJBOie0MFVL6bRnZAPl+b/y9TKAzAbPjyfilVBjZ6j3xlZGaE
	 I6tblghr0Nv5XfV2GDGpCemDLmdXvRr7asHX1unKfJujxVQnQPwYIz0KR4JSl1HrMw
	 tK/BH1F+RIfbA==
Date: Mon, 26 Jan 2026 15:30:37 +0000
From: Simon Horman <horms@kernel.org>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rocker: fix memory leak in rocker_world_port_post_fini()
Message-ID: <aXeInSbGB4KzpTHy@horms.kernel.org>
References: <20260123211030.2109-2-qikeyu2017@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123211030.2109-2-qikeyu2017@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-253521-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: D30998A321
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 05:10:31AM +0800, Kery Qi wrote:
> In rocker_world_port_pre_init(), rocker_port->wpriv is allocated with
> kzalloc(wops->port_priv_size, GFP_KERNEL). However, in
> rocker_world_port_post_fini(), the memory is only freed when
> wops->port_post_fini callback is set:
> 
>     if (!wops->port_post_fini)
>         return;
>     wops->port_post_fini(rocker_port);
>     kfree(rocker_port->wpriv);
> 
> Since rocker_ofdpa_ops does not implement port_post_fini callback
> (it is NULL), the wpriv memory allocated for each port is never freed
> when ports are removed. This leads to a memory leak of
> sizeof(struct ofdpa_port) bytes per port on every device removal.
> 
> Fix this by always calling kfree(rocker_port->wpriv) regardless of
> whether the port_post_fini callback exists.
> 
> Fixes: e420114eef4a ("rocker: introduce worlds infrastructure")
> Signed-off-by: Kery Qi <qikeyu2017@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


