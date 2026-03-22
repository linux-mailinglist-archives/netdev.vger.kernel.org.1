Return-Path: <netdev+bounces-270315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BApLUsdwGl/DwQAu9opvQ
	(envelope-from <netdev+bounces-270315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 17:48:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFB2EA0E0
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 17:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C164130087B2
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A186366DC4;
	Sun, 22 Mar 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Y3xLjkxJ";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="PMo7TDpH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7F1E49F
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774198089; cv=none; b=SIAidVnKHiqQDNi25Gt5ZojkfG2pZbSsJErDNE6w/dOYvTHpEYgQh1fT96UbNAbX5HbpGWZ5z5p9oTUSsABPUyAkZDulTKj7bt0nlNQj7+BcC95cpeTFXRCH7FGww9X/2JMcd3tN8PaRcbnkNMOfbf/Whhqrh9y2Fb6aRXCnAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774198089; c=relaxed/simple;
	bh=gOt4JHQnb3LVKG7DAxu1nGseONCIZzR0rjlwoU/480Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YRcw+RDGvc3bzlLITltSM8H6pI4NedfiCWUcWTgbAmJ+c2/2/v306OUj2fKIseGWbmR49VWremnI43Y5xZe70WLhH2681mycffkY1Ku9XZRqiVRQ5QiB2+pGRkv6akPc8p2Xa5p5VviSPzMSWuDPJ1lTxB7wmxQHQSoNmcSjxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Y3xLjkxJ; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=PMo7TDpH; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62MGlbtu006700;
	Sun, 22 Mar 2026 17:47:42 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 09A7C1208DB;
	Sun, 22 Mar 2026 17:47:33 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1774198054; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymUJjLwCu4pXhqynPTzf1gMncCj/JDOHgkPCE6HJiY8=;
	b=Y3xLjkxJIYnQdreDiG6z/cQcbfoNyolhQUAdsQuKF/efyKy50daeEDlGXtP7L8l3Ppz71b
	A6WVlFDJCU/TwgCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1774198054; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymUJjLwCu4pXhqynPTzf1gMncCj/JDOHgkPCE6HJiY8=;
	b=PMo7TDpHPERVgM6zcDjUqImKVp4HIOIkwKU/uin7dl5KL0mjf4TLhd0K2kVy3WFqLTjj6U
	hh47Nc9PnHT2W/3DCy4j721I3Dse5nNkX+TMVDAHWvzLgRjj+O9dj/8syBfLnbq+qoUHCE
	2i8NV8jXlwMbX0A+IW+DJV9OYw8Mwe+QHQxZJO+vkG2AyUqgd8tOzVPkCYsz0Pec7w0g62
	WgmzeGEgSRTo8+8iu+dCzF1Xw9lKB1R4M4HLUcDs49I2PXfI2Q1Hn+miNTFgqCurQcu4+K
	E+1hsf+bnja4wFRZgOVWSiGZ70xk7Spdd9S8UsZryhoZlXrz72j431WUPATVRg==
Date: Sun, 22 Mar 2026 17:47:32 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@6wind.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net,
        David Ahern
 <dsahern@kernel.org>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        justin.iurman@gmail.com, nicolas.dichtel@6wind.com,
        stefano.salsano@uniroma2.it, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v4 1/2] seg6: add per-route tunnel source
 address
Message-Id: <20260322174732.757e24ba076a08ec52df1223@uniroma2.it>
In-Reply-To: <20260320135909.1729313-2-justin.iurman@6wind.com>
References: <20260320135909.1729313-1-justin.iurman@6wind.com>
	<20260320135909.1729313-2-justin.iurman@6wind.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,6wind.com,uniroma2.it];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 16AFB2EA0E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 14:59:08 +0100
Justin Iurman <justin.iurman@6wind.com> wrote:

> Add SEG6_IPTUNNEL_SRC in the uapi for users to configure a specific
> tunnel source address. Make seg6_iptunnel handle the new attribute
> correctly. It has priority over the configured per-netns tunnel
> source address, if any.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> ---
>  include/uapi/linux/seg6_iptunnel.h |   1 +
>  net/ipv6/seg6_iptunnel.c           | 114 +++++++++++++++++++++--------
>  2 files changed, 84 insertions(+), 31 deletions(-)
> 

Thanks for the patch, Justin. The code looks good to me.

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

