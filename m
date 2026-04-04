Return-Path: <netdev+bounces-275310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O33LfRa0Gnd6wYAu9opvQ
	(envelope-from <netdev+bounces-275310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:27:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 429A0399531
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10D503031B17
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F50238C0D;
	Sat,  4 Apr 2026 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLmY284H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BEE625
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262428; cv=none; b=UX1F1q+4iRUTlURKx1pprUv5Gl2QTV9e2W4Iap/86NNV6W0ulGg2I0C/w7BG79iUHxg9HsfdPEoZT7HDHkXT16o5Znzojsj7KVSwxRTBZjMWTt+0Ml72PCemxzeMTS160E3d8pBIzT3Twv/R7kd4tN2USfHvB38uJ7UN2Y3cDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262428; c=relaxed/simple;
	bh=bRHjq1ptMfBOG0iKkym5PXhmrMb8RlP8drv2S4vjej0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKNqTL1fyQimeuiTYp0cKJsXpx1LYMTaWROC9jtqdXPdG3nhSL67evPOJol1QfvgECtbSMxW7bj9oMOcj1W5y3a3VyXfGWLxUUDFP8HyaaeKsHSbF1+9rUphl9hNC4fUb26z/3nJWWpdck/vzHmzArOX5kzyS/2DwTGUXCU212s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLmY284H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317D7C4CEF7;
	Sat,  4 Apr 2026 00:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775262428;
	bh=bRHjq1ptMfBOG0iKkym5PXhmrMb8RlP8drv2S4vjej0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLmY284HZT+YgOOhHuQQJmZMAIA9p29FQFNzL1kP6LEck3g+017ZdSYrfAsLGUusX
	 hpQcVniqXxrd+bdM2YetR2O/639Np3EW9CM6SKbjcLT0rnQ9lc04oDKhdCAiVE7OqZ
	 oS97HBNj2S486Ov+nS2muqbOC0TbEyEj3t1+qC02D36MgrEHXhGhtRQu8LTTVoqjpj
	 VsWJi+vliqP9QT/DJSJoTBpMPauOCWQrkybbgOeyAGR/vUVBZt7LqmKdwNmul+x6N0
	 40joOUKgAws6h0XJexuQ9an3hTlEKPN7DLWWzdttDiANjVsy0+dg1pQprryAsk8FKT
	 m+RkX1fLzmzRw==
Date: Fri, 3 Apr 2026 17:27:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v5 02/14] net: introduce ndo_set_rx_mode_async
 and netdev_rx_mode_work
Message-ID: <20260403172707.28e71a27@kernel.org>
In-Reply-To: <20260402225535.4124525-3-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
	<20260402225535.4124525-3-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275310-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 429A0399531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 15:55:23 -0700 Stanislav Fomichev wrote:
> +	if (netif_rx_mode_clean(dev))
> +		dev_put(dev);

let's toss a netdev_tracker into this reference counting
but overall the work stealing is looking cleaner than I expected,
nicely done!

