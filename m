Return-Path: <netdev+bounces-283520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PsQLn6u9mlDXgIAu9opvQ
	(envelope-from <netdev+bounces-283520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:10:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 297324B4189
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C439E3011842
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0423D7DF;
	Sun,  3 May 2026 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCLwFgCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A023A562;
	Sun,  3 May 2026 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774177; cv=none; b=XZ7knrWe+sp746+qWcUNNC9ORpO+wQzXsjEzf42RVzbeJQppimIAYrAoGkYTwWELr2VEu3Gs10tA7REPn9k1+8uNBjY9hBcW+3jfnmIzhqUGrx7QXemelK9+bLDvvnUChX2Kayq6id9DVYp7SJL5UTc8IaBuISkUwEZ3fz2OOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774177; c=relaxed/simple;
	bh=sTncP4UUY+Pjcqvafaa6QYR+TkZ0TJdzqL42V6tJFTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phj1DKdtqEU2EYRJAel1bgGZnuT5amEztkJlYRJ0+h6NqASQp/HUGjK3orkSufFb0s4/xFS4Yc4qU+w9BrHF+ihv82XKVR3JEIZpc7FffO9+mawcwzAOxgG61LIbGog70Gkj0/r0/8qsaoOEfmnNHPd48TwkQYKhCeV9h77MaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCLwFgCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEA5C2BCB3;
	Sun,  3 May 2026 02:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777774177;
	bh=sTncP4UUY+Pjcqvafaa6QYR+TkZ0TJdzqL42V6tJFTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCLwFgCss94WWrRrQBzvNlXvEKx3YrdMXRme/Eh/oq7JjMVqFvoTczp8AoUOoO/A+
	 vjD2wU3Neh6hBbrNGW3R+EJXygLJVRd9Z8uAHt5VlEX+dffKaRlWs+DEjleOeXdcZ4
	 pjaN/52/LfDJ2M7Lz7oRGnIjkXZIAWK4IACmcMWSkQubVWBPTx8dhGQctrBY3oq2WY
	 DGFS3t31uu02ZZqn3gUCCNJ2DXcZ4mEJk15sUoYqRGiYX15U1TKXQs+Da5WQK0cvIl
	 wGSu6UT/JdnoiDNPgqfaSiY/f5GNyRceyvmUxeNuRG8GuJOf+ytPfPQoxSGtCbQLvu
	 hAjFhHIwp/Lmw==
Date: Sat, 2 May 2026 19:09:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Ivan Vecera <ivecera@redhat.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, Sunitha
 Mekala <sunithax.d.mekala@intel.com>
Subject: Re: [PATCH net-next 15/15] ice: add support for unmanaged DPLL on
 E830 NIC
Message-ID: <20260502190934.087c9524@kernel.org>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-15-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
	<20260430-jk-iwl-net-next-2026-04-30-v1-15-6f27ae1cd073@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 297324B4189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283520-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 23:37:26 -0700 Jacob Keller wrote:
> +static const struct dpll_pin_ops ice_dpll_input_unmanaged_ops = {
> +	.frequency_get = ice_dpll_input_frequency_get,
> +	.direction_get = ice_dpll_input_direction,
> +	.state_on_dpll_get = ice_dpll_input_state_get,
> +#if defined(HAVE_DPLL_ESYNC)
> +	.esync_get = ice_dpll_input_esync_get,
> +#endif /* HAVE_DPLL_ESYNC */
> +};

Yes, we do HAVE_DPLL_ESYNC ..

