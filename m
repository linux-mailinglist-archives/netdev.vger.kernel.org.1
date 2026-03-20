Return-Path: <netdev+bounces-269970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFC4EgJ1vWmt9wIAu9opvQ
	(envelope-from <netdev+bounces-269970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:25:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C652DD43F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 452C8304854E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EE93CEBA6;
	Fri, 20 Mar 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd4poCo5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C723CAE87;
	Fri, 20 Mar 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023717; cv=none; b=jDNH9fmpxtq+VsRphOCshMZTyylWDBFpx97g7sFGsZt1LY2ZhyDtpJ8dRlHlH52t+lEJsqpWwtdCBNfnJ2AqXUI/vd5jrFcrLKSfQdegtvkqZcG1zGK9+ZlyXBkEeq2aSoIWuViKzUx7OXSzg2ustb+fb56kw63Rr1boIpPbObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023717; c=relaxed/simple;
	bh=zmy6E3ZEz7O0Ry0kSSa8nMBddWSwjazWgQ9IjTZQnr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCwgcjNKqMiHsPPtj1koWBwHILX0jyBMN6BtFaxhBygdYxhQO58WAWQoOVwwusRRcC9MQj9fmFDAwbIRF7tPOspFkQ6aBwzK7gdumSml/YdCmmXgtmxwv6A+sgOURxgQvzYAET+I0uZ3OTABMvdEN4Le7CiPgIo5jMUfdEvciz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd4poCo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063C1C4CEF7;
	Fri, 20 Mar 2026 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774023717;
	bh=zmy6E3ZEz7O0Ry0kSSa8nMBddWSwjazWgQ9IjTZQnr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hd4poCo5lCD2Wrt8cdRSInpfgGb/s1fSopRcBA9k7nb+aEr6/ovaW6L8thQIAhKBd
	 LBdPJu8Cj3w4CemWMvr8xOYRUZDpos+R+1aZki/KpYOmc4qDwPUkfnPMMp8I8qGepN
	 Za+yuiICBd9ycpgOxXhR3/V6uVFamEDHQgfh3FcnQKjXNXH75nBaVCor4XvOXfWFcg
	 v4O9dTk60Xv0S5D59gXKPOusXk8H4xlxUtGHYzVeRNfVsFgwR41bd/isnmwYYPpg8x
	 mO6CAVt7aOPAEfs/RmzhhsT56I0dHg9QqYlJtSMPJS43SNMalleYcWM/S8RRay9zso
	 kYhHln9hG2NaQ==
Date: Fri, 20 Mar 2026 16:21:52 +0000
From: Simon Horman <horms@kernel.org>
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
	quan@os.amperecomputing.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH] net: xgene: fix signedness bug in xgene_enet_get_fpsel()
Message-ID: <20260320162152.GA79627@horms.kernel.org>
References: <20260319091106.1662-1-mohd.abd.6602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319091106.1662-1-mohd.abd.6602@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269970-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 92C652DD43F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:11:06AM +0000, Anas Iqbal wrote:
> xgene_enet_get_fpsel() returns a u8 but can compute a negative
> value when xgene_enet_ring_bufnum(id) is less than
> RING_BUFNUM_BUFPOOL. This leads to an implicit conversion of a
> negative value to u8, resulting in a large unintended value.
> 
> This can cause incorrect behavior when the result is used in
> bit operations such as BIT(), potentially leading to undefined
> behavior.
> 
> Fix this by validating the value before subtraction to avoid
> underflow.
> 
> Fixes: 2c839337520b ("drivers: net: xgene: Add helper function")
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
> ---
>  drivers/net/ethernet/apm/xgene/xgene_enet_hw.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
> index 2f534f9d4416..fe563c396773 100644
> --- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
> +++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
> @@ -405,10 +405,16 @@ static inline bool xgene_enet_is_bufpool(u16 id)
>  
>  static inline u8 xgene_enet_get_fpsel(u16 id)
>  {
> -	if (xgene_enet_is_bufpool(id))
> -		return xgene_enet_ring_bufnum(id) - RING_BUFNUM_BUFPOOL;

Hi,

It seems to me that the existing xgene_enet_is_bufpool() condition
protects against underflow. Am I missing something?

