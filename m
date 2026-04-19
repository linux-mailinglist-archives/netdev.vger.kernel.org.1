Return-Path: <netdev+bounces-279601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFrTEe/+5GkVdAEAu9opvQ
	(envelope-from <netdev+bounces-279601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 18:12:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32A84249C7
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 18:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3BB2300F142
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E11295DAC;
	Sun, 19 Apr 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch2Q8SHA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBFC2877F4
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615147; cv=none; b=LBdVKnDwvFOf3URUY1gfi91iJdQdKVLCoPplfc/j/XS3j8o+mtZaxmZmGq9Iao/WAHFzxzk/u+/zkEjwXRG055rdpvVSD7CXrp+0z8RMYwC0VyITrBBDdhZ35xDKjS1DcITNnye0z+i7NpdUXEkpbkrlL/gqZiHd9WWd+AHVJQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615147; c=relaxed/simple;
	bh=Ta2f/OBUfrlnMNY37PwVc6dm0L34NOXq5X2MMmQ/Pyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYwMWBIhK+1WxGi0ydA2YhsEAQ5jC0DPsPrh7Zla3QptU0y1/uxQOgKNOEzC7XWhpCKF49lBHndmSbWDvigYVrPuEhufON6UKpMcc32n6NaaYJmPVxYyi8JuKjKO09NjmPHzvDZapfwGzfJ8mHsPIZsUcUCqjjrNgRjzLQf3WBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch2Q8SHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4F0C2BCAF;
	Sun, 19 Apr 2026 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776615147;
	bh=Ta2f/OBUfrlnMNY37PwVc6dm0L34NOXq5X2MMmQ/Pyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ch2Q8SHAI0HNC5/+1WeMGVq0bNM2M1O14/ZCpUEMGAO9X4mfD2cESDEEx0WW9JLFN
	 HHRUwFaIXM6gZU6pMmvKEFL6b9PHu/c6GV/mcg1FRXuA4QO78gnief+NejpWAUVj45
	 b4PwrqL0Z71l0EeMOFNWmPNDscYoW8yxfMo/wBlW+9DoPwGcuszPAVKwzWkgdNTsot
	 k/zgXcCLN+8ZmM6H3jiG0isGMuWJPVQ/dHP5Y30Jv++SvvyWle+xt7f1IZC0ymC1R2
	 jo3CXQSzH3GzRQMldzGX7SsubtZ3Bm1wWQLj+/6yYCPPe4HvPOlvknf9xsi8G2VsFI
	 H6dvxGFZtzWtw==
Date: Sun, 19 Apr 2026 17:12:21 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Fix possible TX queue stall in
 airoha_qdma_tx_napi_poll()
Message-ID: <20260419161221.GO280379@horms.kernel.org>
References: <20260416-airoha-txq-potential-stall-v2-1-42c732074540@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-airoha-txq-potential-stall-v2-1-42c732074540@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279601-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B32A84249C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 12:30:12PM +0200, Lorenzo Bianconi wrote:
> Since multiple net_device TX queues can share the same hw QDMA TX queue,
> there is no guarantee we have inflight packets queued in hw belonging to a
> net_device TX queue stopped in the xmit path because hw QDMA TX queue
> can be full. In this corner case the net_device TX queue will never be
> re-activated. In order to avoid any potential net_device TX queue stall,
> we need to wake all the net_device TX queues feeding the same hw QDMA TX
> queue in airoha_qdma_tx_napi_poll routine.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Add txq_stopped parameter to avoid any possible corner cases where the
>   netdev queue stalls.
> - Link to v1: https://lore.kernel.org/r/20260413-airoha-txq-potential-stall-v1-1-7830363b1543@kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I believe Sashiko's review does not need to block progress of this
patch as it flags pre-existing conditions.


