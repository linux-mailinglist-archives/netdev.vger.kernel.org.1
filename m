Return-Path: <netdev+bounces-269931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOa2On5avWkA9QIAu9opvQ
	(envelope-from <netdev+bounces-269931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:32:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6659E2DBD62
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0FE33026884
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5730F812;
	Fri, 20 Mar 2026 14:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBD3B27F6;
	Fri, 20 Mar 2026 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017123; cv=none; b=QtA1JuBiDvvZXkuFksVwCHVD8Ho7MmvJmvNhvDtVHn+Dr1UsoCngSuBTVVrz2BWqdM0nzD/YHbfg1/cLqa2YwzBFOqrfHlt3iHJqn0nDjRTwxqbI8VldyMmV9SXB329k4e6jhiRDuMssHVXoEcGue7OT6Y7PfcXMbKv9DugrGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017123; c=relaxed/simple;
	bh=YJoeI4MWB78LwS7XL71UYCE1MURj56ZO/Ym0YVp1R2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdQdvIRWYjsMsG7CloEPuq3POFsGaa+ruZNoKCyRLjJ6BhAePRzT+SgRwJBDWai4tc1/R2AH+GSKhXGXmSHVg2ZC0o/ZaVhRehysf0F6ZxOul6dfyUQ+5CqPr77ITUCbTAGisYEq4VQ4BydIHJOveoe+vAMkfYnX/03QIkEoriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 89E154C28871A7;
	Fri, 20 Mar 2026 15:29:11 +0100 (CET)
Message-ID: <310379eb-9b99-444d-bf02-2bde3bd79374@molgen.mpg.de>
Date: Fri, 20 Mar 2026 15:29:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] iavf: fix wrong VLAN mask for
 legacy Rx descriptors L2TAG2
To: Petr Oros <poros@redhat.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20260320135326.1171433-1-poros@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260320135326.1171433-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269931-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.760];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[molgen.mpg.de:mid,mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6659E2DBD62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Petr,


Thank you for your patch.

Am 20.03.26 um 14:53 schrieb Petr Oros:
> The IAVF_RXD_LEGACY_L2TAG2_M mask was incorrectly defined as
> GENMASK_ULL(63, 32), extracting 32 bits from qw2 instead of the
> 16-bit VLAN tag. In the legacy Rx descriptor layout, the 2nd L2TAG2
> (VLAN tag) occupies bits 63:48 of qw2, not 63:32.
> 
> The oversized mask causes FIELD_GET to return a 32-bit value where the
> actual VLAN tag sits in bits 31:16. When this value is passed to
> iavf_receive_skb() as a u16 parameter, it gets truncated to the lower
> 16 bits (which contain the 1st L2TAG2, typically zero). As a result,
> __vlan_hwaccel_put_tag() is never called and software VLAN interfaces
> on VFs receive no traffic.
> 
> This affects VFs behind ice PF (VIRTCHNL VLAN v2) when the PF
> advertises VLAN stripping into L2TAG2_2 and legacy descriptors are
> used.
> 
> The flex descriptor path already uses the correct mask
> (IAVF_RXD_FLEX_L2TAG2_2_M = GENMASK_ULL(63, 48)).

Do you have a reproducer to verify the fix?

> Fixes: 2dc8e7c36d80 ("iavf: refactor iavf_clean_rx_irq to support legacy and flex descriptors")

(That first entered Linux v6.15-rc1, and Linux 6.12 and 6.18 are LTS 
series.)

> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_type.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
> index 1d8cf29cb65ac5..5bb1de1cfd33b1 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_type.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
> @@ -277,7 +277,7 @@ struct iavf_rx_desc {
>   /* L2 Tag 2 Presence */
>   #define IAVF_RXD_LEGACY_L2TAG2P_M		BIT(0)
>   /* Stripped S-TAG VLAN from the receive packet */
> -#define IAVF_RXD_LEGACY_L2TAG2_M		GENMASK_ULL(63, 32)
> +#define IAVF_RXD_LEGACY_L2TAG2_M		GENMASK_ULL(63, 48)
>   /* Stripped S-TAG VLAN from the receive packet */
>   #define IAVF_RXD_FLEX_L2TAG2_2_M		GENMASK_ULL(63, 48)
>   /* The packet is a UDP tunneled packet */

Nice find.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

