Return-Path: <netdev+bounces-266103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG9oCAIVsGnRfAIAu9opvQ
	(envelope-from <netdev+bounces-266103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:56:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58D24F309
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6C7331C969
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E97407114;
	Tue, 10 Mar 2026 12:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2243F8E01
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144059; cv=none; b=Y9IA5kUG1o3SwJbbbJjr9B2DsJdr2RWnYBD3lzSAlSlfYIqMJkWf2zIILZt5U9QDHzpdExLJIvTy74+/+5K9gx9vudB9padYyVLCXI5x8Au3wI6krjZE7g7MJWMUv59Y4QHhWGz3VXlu+Q6g7gYzvANzI4C/wpvlRGkk2fL8PDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144059; c=relaxed/simple;
	bh=BWb2wQckPZgMXW3gmcEQQ5bVNsTCEOpCFDs3mI7OybM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyuUFZThRF9mBLpI5Q+cHfv1G5l3PyJ29CjNeQewEEd7lKd0pwTqeW9TQnrM51zc1uinqc2uIP7Ov8NllgDfwbeDkgocKpGl0x3RqFyoPmB4iAEk6zzIJA3ZMIceztSQ0MP3XU1CfQO/l9sTNQQqRvm9vd/PBKpLIinzxhXZFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6DA9E4C4431ED8;
	Tue, 10 Mar 2026 13:00:11 +0100 (CET)
Message-ID: <3ce98bb7-273e-4b90-ab28-8679c53d5c90@molgen.mpg.de>
Date: Tue, 10 Mar 2026 13:00:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM for
 GSO packets
To: Jakub Ramaseuski <jramaseu@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 przemyslaw.korba@intel.com
References: <20260310115556.1004263-1-jramaseu@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260310115556.1004263-1-jramaseu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7C58D24F309
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266103-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.588];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,molgen.mpg.de:mid]
X-Rspamd-Action: no action

Dear Jakub,


Thank you for your patch.

Am 10.03.26 um 12:55 schrieb Jakub Ramaseuski:
> IPv4 over IPv6 GRE currently fails on E810 with skb_warn_bad_offload,
> while IPv6 over IPv6 GRE falls back to software segmentation.
> This happens because the kernel's GSO engine requires the generic HW_CSUM
> flag to trust the hardware with complex encapsulation offloads.
> 
> Add NETIF_F_HW_CSUM to the device's csumo_features to satisfy the network
> stack and unlock full hardware segmentation for GRE tunnels.
> To prevent checksum corruption on standard traffic, evaluate the packet
> in ice_features_check() and dynamically clear the NETIF_F_HW_CSUM bit
> if it is not a GSO frame. This forces the driver to fall back to safe,
> protocol-specific checksum features for non-GSO packets
> while preserving the generic offload for tunnels.

Do you have a test case, you could document in the commit message?

> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e7308e381e2f..9b4ad03e1a32 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3565,6 +3565,7 @@ void ice_set_netdev_features(struct net_device *netdev)
>   
>   	csumo_features = NETIF_F_RXCSUM	  |
>   			 NETIF_F_IP_CSUM  |
> +			 NETIF_F_HW_CSUM  |

Should this be sorted?

>   			 NETIF_F_SCTP_CRC |
>   			 NETIF_F_IPV6_CSUM;
>   
> @@ -9789,6 +9790,14 @@ ice_features_check(struct sk_buff *skb,
>   	if (skb->ip_summed != CHECKSUM_PARTIAL)
>   		return features;
>   
> +	/* Hardware requires strictly-typed Tx descriptors for non-GSO frames.
> +	 * Leaving generic NETIF_F_HW_CSUM enabled corrupts checksums,
> +	 * causing TCP drops. We strip it here to force safe,
> +	 * protocol-specific IPv4/IPv6 offloads instead.
> +	 */
> +	if (!gso)
> +		features &= ~NETIF_F_HW_CSUM;
> +
>   	/* We cannot support GSO if the MSS is going to be less than
>   	 * 64 bytes. If it is then we need to drop support for GSO.
>   	 */

The diff looks good.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

