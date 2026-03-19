Return-Path: <netdev+bounces-269244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPVXMd5Mu2kOigIAu9opvQ
	(envelope-from <netdev+bounces-269244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:09:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8032C4489
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8B17301CECE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218BA271476;
	Thu, 19 Mar 2026 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCOwA5cr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327512CDBE;
	Thu, 19 Mar 2026 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882583; cv=none; b=e6kq8tP8vHCCRhBxSYjGS/IkpE/WFg8X+cWCvCmsN220aNO4og7Bfla1MG9WhyDcbQFkYxFxA+6OiqrCSHCtR9yit2afsENAx9lZ6lsrNafkjAl2lI1OQ7gSl6EWQhTNaU5nZPlwMTByDWbBUJheZuti82RMthczbzevCewKuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882583; c=relaxed/simple;
	bh=RhMB3/fHMzbhw16EY3EgqZfIYShBpgY65aoZHTTgXnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSjKoSu9Rr6G6rW3ywKNtfkI8KJHolIK7Y3NaFIo7mlbEyveIVz2HiVeELICIpTCk2/PN03cEoWu179F2/0o37X/o0znzHRwqbTfZx02nHuY13DQTQRTv8IO7JYI9Xigk7BenCyHyl+rZHSDgLrhXZJq/ggonrsCiodnap0407A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCOwA5cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3D4C19421;
	Thu, 19 Mar 2026 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773882582;
	bh=RhMB3/fHMzbhw16EY3EgqZfIYShBpgY65aoZHTTgXnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SCOwA5crE2+APr3zQAzRsZEWEyOS87rwJOYBM46cKJIDXjAxrEse6ijIT8ExAsMeg
	 MaU99JIgcJ+XR1od/tkWvQssz+JAvhLzGCQgKHYF9gVgdoIWeQeP8ciVuScih5MGgG
	 +RrtaIWycmQt+Ft9neEObC7I8f/obI22CvddTw66nrYKFaL3MtGMK8OhKl28XUNHVg
	 VqbWwenR/6VAgBZXTU8xTUSNxM0ldGts24p6VdveH9q15R6ZFX1OgUEh2DpaZMZBsW
	 MNG3yo6dcfdK4b8Q1d8FdtHNjMKoVY1NTJy3Ig0ZdtgWnX//q57AXr7O6rHw6rIT0/
	 o3t6cjuYf3rnA==
Date: Wed, 18 Mar 2026 18:09:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: bonding: add test for stacked bond
 header_parse recursion
Message-ID: <20260318180941.40dcf453@kernel.org>
In-Reply-To: <20260317031435.364094-1-jiayuan.chen@linux.dev>
References: <20260317031435.364094-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269244-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF8032C4489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 11:14:30 +0800 Jiayuan Chen wrote:
>  CONFIG_NETCONSOLE_EXTENDED_LOG=y
> +CONFIG_NET_IPGRE=y
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_SCH_INGRESS=y
>  CONFIG_NLMON=y

Sorry this also has to be sorted and the special characters are a bit
tricky. As you can see from CONFIG_NET_SCH_INGRESS the sorting algo
considers _ to be after letters, so you need to move the new addition
down.

When you repost you can target net-next, FWIW.
If the selftest is part of the same series as the fix we let them go
together but standalone selftest postings should go to net-next.
-- 
pw-bot: cr

