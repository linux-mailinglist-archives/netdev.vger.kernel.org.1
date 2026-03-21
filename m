Return-Path: <netdev+bounces-270197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJluEZtzvmmYPwMAu9opvQ
	(envelope-from <netdev+bounces-270197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 11:31:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE72B2E4C12
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 11:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DBA8300C312
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DD530C62E;
	Sat, 21 Mar 2026 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNSzpnqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16523A9BD
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089113; cv=none; b=ZZ6esBP2T8S3VAZVUQ2f1bNHD7OsY/jtlSYZUQsJ1qnmLDdd98GAa51EtxBzXWNwHAjIVH0+XTGv7G6Pd34FBNqfkHX2nM8FnFc27/qrmUVvs1BwnKXVfDyBQQ5BkOo8uCmdA796JtRjccWU1mOIWLE3DIhrLTq+rMoz7xx5a+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089113; c=relaxed/simple;
	bh=8sNKUwqX/OrIg5gaDz0kzFK6SYsk+ySYRe6i4JQPW7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2IrON5NElZNSV6lEi2KmmhbYwXbuLcllt6iHpjSlL10R1ipuziTFOIAjFwjvtc1ostv1OFYBTJR7Rsom30ABtQ8D+jaF1UXfYGluUejWPHoRmlZlPAtYIHOKSja5gSD0iGEOM+rEdjeAxt4a5K+/73oRTRNY2Eqsj+BLoyzys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNSzpnqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6C2C19421;
	Sat, 21 Mar 2026 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774089112;
	bh=8sNKUwqX/OrIg5gaDz0kzFK6SYsk+ySYRe6i4JQPW7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNSzpnqCFdDHTMGkVM9zj6lFCyfYjNB1CeU8GOlSl/u3B2RQKU0Pw+b9iB8DMdQh8
	 FQXOP4kC1NoXhrFB3YcjcplfDyGGzuv7tW2ISbjbgGHYn35HaExvPeLNzMGXV2zJz8
	 BIfMV9Khz/wB7wnPzB6Ire9m6naf++uaU4ynXN1HbjPauy9Jp48B4o6qxqg1atwuWI
	 lj/HVzPklsX9ZYOFNLPWhomZ+SWHRt7h5nnJWHGMDdPZIQ84j9aii9XcEMHsSQstoY
	 vS6gAQX7RO6fX3Yh0u9aznuUFXvvWjkWBMCrkJm7GjuqxRZJdWslWJI/Op94fk/p9i
	 au8aZvKN6P6rA==
Date: Sat, 21 Mar 2026 10:31:48 +0000
From: Simon Horman <horms@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: fix use-after-free of CPPI
 descriptor in RX path
Message-ID: <20260321103148.GZ74886@horms.kernel.org>
References: <20260319181236.14526-1-devnexen@gmail.com>
 <20260320174439.41080-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320174439.41080-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270197-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: DE72B2E4C12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 05:44:39PM +0000, David Carlier wrote:
> cppi5_hdesc_get_psdata() returns a pointer into the CPPI descriptor.
> In both emac_rx_packet() and emac_rx_packet_zc(), the descriptor is
> freed via k3_cppi_desc_pool_free() before the psdata pointer is used
> by emac_rx_timestamp(), which dereferences psdata[0] and psdata[1].
> This constitutes a use-after-free on every received packet that goes
> through the timestamp path.
> 
> Defer the descriptor free until after all accesses through the psdata
> pointer are complete. For emac_rx_packet(), move the free into the
> requeue label so both early-exit and success paths free the descriptor
> after all accesses are done. For emac_rx_packet_zc(), move the free to
> the end of the loop body after emac_dispatch_skb_zc() (which calls
> emac_rx_timestamp()) has returned.
> 
> Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


