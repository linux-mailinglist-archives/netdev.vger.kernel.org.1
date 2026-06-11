Return-Path: <netdev+bounces-298380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YqVGJ9Y1K2pH4QMAu9opvQ
	(envelope-from <netdev+bounces-298380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:25:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A12326759AA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:25:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=VgTZxDPk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298380-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298380-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EAC1318D013
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23C3BE627;
	Thu, 11 Jun 2026 22:25:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E453BCD04
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:25:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216723; cv=none; b=cpm4OKK922TuCT3uD0F1sstXKTyA33SyNtXZo538rbbWRiiojB6TSxLmW5roDIyriP/26UnlJxIDTixfuyv5x4rkcuBSCpokeJakZgKxrkzExlYTMvvvm1Z0YXrLkW71ut/Hk9D8NzUXGhJ9Yp8+Rg2f/yFSmovwoswfH8CTeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216723; c=relaxed/simple;
	bh=odk/bFvTB4lIR9SUHDybKvQ/YDen+U/1RxCutkScQtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpDZ8TysdSu1fIIY59U8p7DL1k3GIqkPj69HMCsTZ+/rd3FHl8csHZ1nVV7ecq/oNHZ5mmdXLa0PwKqRIzbBib2cPChLv8JbPLDi5jgxE2KQ0aTAucRAV5E1HXrM+/6nP6qAvvVLRJNXdEM+RfGYOsWtVfC2cTUgcjrsUhrDR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VgTZxDPk; arc=none smtp.client-ip=91.218.175.189
Message-ID: <0b9a7503-f54e-458b-ab09-0fbc831d9f76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781216718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCp+OE7mny15IeXUvmwe/KO5UK6GV4r2lLfjbX143f0=;
	b=VgTZxDPkz1UzSd2PdaQ6DGSh5klpmqk2KTT9ozEZmQp8ebL2IRUrNDD3Mesx32R0jzAGee
	z77NUVV4C9q6arH2cZLBX7wnk/uckG/gSXNMPwOroXK4F47PJcpACh1bJEZGRiteREsnd0
	wEdrIFrX048JZ4wLj2U3LDz0NJjiLzM=
Date: Thu, 11 Jun 2026 23:25:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch, gal@nvidia.com,
 jacob.e.keller@intel.com, sdf@fomichev.me, kory.maincent@bootlin.com
References: <20260611200355.2020663-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260611200355.2020663-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298380-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:sdf@fomichev.me,m:kory.maincent@bootlin.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,intel.com:email,lunn.ch:email,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A12326759AA

On 11/06/2026 21:03, Jakub Kicinski wrote:
> mlx5 throws ASSERT_RTNL() warnings on timestamp config, because
> it tries to update features. mlx5e_hwtstamp_set() calls
> netdev_update_features().
> 
> I missed this while grepping the drivers because tsconfig goes
> through ndo_hwtstamp_set/get, not ethtool ops, even tho the new
> uAPI is in ethtool Netlink. We could add a dedicated opt out bit
> for mlx5, but NDOs were not supposed to be part of the ethtool locking
> conversion in the first place.
> 
> The mlx5 features update is related to the "compressed CQE" format
> which lacks timestamp, apparently. See commit c0194e2d0ef0 ("net/mlx5e:
> Disable rxhash when CQE compress is enabled").
> 
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: gal@nvidia.com
> CC: jacob.e.keller@intel.com
> CC: sdf@fomichev.me
> CC: kory.maincent@bootlin.com
> ---
>   net/ethtool/common.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/ethtool/common.h b/net/ethtool/common.h
> index e3052972f953..2b3847f00801 100644
> --- a/net/ethtool/common.h
> +++ b/net/ethtool/common.h
> @@ -113,6 +113,13 @@ ethtool_nl_msg_needs_rtnl(const struct net_device *dev, u8 cmd)
>   		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM;
>   	case ETHTOOL_MSG_RSS_SET:
>   		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
> +	case ETHTOOL_MSG_TSCONFIG_GET:
> +	case ETHTOOL_MSG_TSCONFIG_SET:
> +		/* tsconfig calls ndos (ndo_hwtstamp_set/get), not ethtool ops.
> +		 * Also, there is no corresponding ethtool ioctl, therefore
> +		 * these cases are Netlink-only.
> +		 */
> +		return true;
>   	}
>   	return false;
>   }

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

