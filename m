Return-Path: <netdev+bounces-294943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tq9uIDmnIGpX6QAAu9opvQ
	(envelope-from <netdev+bounces-294943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:14:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BAF63B84C
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:14:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HvPqMmr3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294943-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294943-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77C2E300EF77
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B8943CEDB;
	Wed,  3 Jun 2026 22:11:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB243CEC3
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:11:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524716; cv=none; b=biFom6e7k/+i3f2+TZQXBbazU67B5vL95veRRCazF+gKz27e2qIMeOY516cF4aprbiImVKbvasxJbfKJqZKOQrtDZZSgGfuADKlS4++Pga0raUujFVszY8ePMlZZKJqHLgCPxcHTs0n3Jj6II+xyHw8blZ7ic7zUw8zUl4CwrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524716; c=relaxed/simple;
	bh=Xog4Xy52QjZzRWpbCRX/asCqFS/9YWYMh1wtSA2ILgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omG6QksaUmdR4/48X9PWCUMB5Lg5ySSxzZQLqduSAkR5uO+4JMsGk5OVrtEroQ5t+XvK3YIcuT2qrV7nPVGh9XNufo/usgWS4jjcFBPdDVBCRTan6UdBlXm2qoc/OzUAEAoHEQmHfHX51x0vi9YpJHdNN/DnJslqTNlpxbXPBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvPqMmr3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA671F00893;
	Wed,  3 Jun 2026 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780524715;
	bh=UzKeV94F2AnXXTeiKTzeYdMnsxBLzgzrW53K73uvhm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HvPqMmr3d85PrETDjpVRoF7bLHs/PcQB2vW6IG+dLWIOxscePMDMBBYIhvhdRGu0G
	 a5IfgJ8setNs2QfXuZ1aRAXsozcomDb2PHGLePHs739cOtpCEef2hz4da0PJfAkRkF
	 YDODA4Eo6/BtVspNzg0m9ALTL7369J+Inohu6N2ZQwysxAZIS/1zh0+SA0rOjoCoMO
	 yX32FRZfKuH7NS8mryNT+z9xjuCApxtT7TmQQnIR0QDo+pJe+iUw9d/wiZWAdEt9uI
	 Litcy6b5wc40nBp0I8Y74OPH+4zPsKLVTwKYZDYQABS4vFfVHv35OORF0sX/YR13+F
	 rGqKBU52BDaUg==
Date: Wed, 3 Jun 2026 15:11:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 1/3] net: ensure SCM_TXTIME delivery time is no
 older than system boot
Message-ID: <20260603151154.433c1c55@kernel.org>
In-Reply-To: <20260603190243.2789335-2-willemdebruijn.kernel@gmail.com>
References: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
	<20260603190243.2789335-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294943-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2BAF63B84C

On Wed,  3 Jun 2026 15:01:28 -0400 Willem de Bruijn wrote:
> +		switch (sk->sk_clockid) {
> +		case CLOCK_MONOTONIC:
> +			tmin = 1;
> +			break;
> +		case CLOCK_REALTIME:
> +			tmin = max(ktime_mono_to_real(0), 1);
> +			break;
> +		case CLOCK_TAI:
> +			tmin = max(ktime_mono_to_any(0, TK_OFFS_TAI), 1);
> +			break;
> +		default:
> +			tmin = 1;
> +			WARN_ON_ONCE(1);
> +			break;
> +		};

net/core/sock.c:3079:3-4: Unneeded semicolon
-- 
pw-bot: cr

