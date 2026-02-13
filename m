Return-Path: <netdev+bounces-258618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGmGAVg2j2n2MgEAu9opvQ
	(envelope-from <netdev+bounces-258618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:34:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D426137174
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 615633033A9A
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03D23559C4;
	Fri, 13 Feb 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lkun1P3Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5E3164DF
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993211; cv=none; b=HyM3jKLvx8Zutad590Q5b6PzQI4vOGbPrKjHjWYfbufPcptu+q1vAaenvEOVkn9OxBGjEgdWKP8Chezkbf/QsrTxHg2Blo6LT1D16wKeMDjcN/CAjDT4dc5Kx+Imv1KbbtTDlrpxYjaa3IDE7YryutLGPBBFZlPtU1MyiKi46nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993211; c=relaxed/simple;
	bh=QYqD5bgd2RQGEGggtbxroJoBc6/l1hIGt+AlrTiNGJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IthHHbFPUKDbC6imP69WrIBwMhdXliRvGJRB0gcvQ85MKCmTeouYHKFtfj/O0Dg5ZLCWZ8ghoQYnCXll2Q/EHPmEaISl+5hpv2SsoF3C2H+dehZL3xl3R7tgRJca/VecXNPSO4SRNwZDAXKM3gACz123AEGQgp7oor2Ll+Vv8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lkun1P3Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770993209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytG744b5Dhodj11DiTuJr7fqu/kRmAxdFKmScJYjHYE=;
	b=Lkun1P3YuBei6DcM+k21a6JArc3Br2Rlf0vIirULEEHcDmStge1+Pdu5zS3lpYM3Mes7VJ
	RYB4EvD2hkDuQgZShEZVfCA+8KZBDnr/sLbcrSEkrhvWXwqBAMKNWqDn0jR02BSKXA12at
	uXzu1ATyIG5mZFk6kE4PZlRywAvGzKw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-PVpj45DJOme1pwf8ZYn2MQ-1; Fri,
 13 Feb 2026 09:33:26 -0500
X-MC-Unique: PVpj45DJOme1pwf8ZYn2MQ-1
X-Mimecast-MFC-AGG-ID: PVpj45DJOme1pwf8ZYn2MQ_1770993204
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2E9518005AD;
	Fri, 13 Feb 2026 14:33:24 +0000 (UTC)
Received: from [10.45.226.100] (unknown [10.45.226.100])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAC7E1800465;
	Fri, 13 Feb 2026 14:33:19 +0000 (UTC)
Message-ID: <72743efe-6f9c-46ba-ab68-87fe988ecb2c@redhat.com>
Date: Fri, 13 Feb 2026 15:33:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix missing SMA pin initialization in DPLL
 subsystem
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, Liang Li <liali@redhat.com>
References: <20260213141651.2231124-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260213141651.2231124-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-258618-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D426137174
X-Rspamd-Action: no action

On 2/13/26 3:16 PM, Petr Oros wrote:
> The DPLL SMA/U.FL pin redesign introduced ice_dpll_sw_pin_frequency_get()
> which gates frequency reporting on the pin's active flag. This flag is
> determined by ice_dpll_sw_pins_update() from the PCA9575 GPIO expander
> state. Before the redesign, SMA pins were exposed as direct HW
> input/output pins and ice_dpll_frequency_get() returned the CGU
> frequency unconditionally — the PCA9575 state was never consulted.
> 
> The PCA9575 powers on with all outputs high, setting ICE_SMA1_DIR_EN,
> ICE_SMA1_TX_EN, ICE_SMA2_DIR_EN and ICE_SMA2_TX_EN. Nothing in the
> driver writes the register during initialization, so
> ice_dpll_sw_pins_update() sees all pins as inactive and
> ice_dpll_sw_pin_frequency_get() permanently returns 0 Hz for every
> SW pin.
> 
> Fix this by writing a default SMA configuration in
> ice_dpll_init_info_sw_pins(): clear all SMA bits, then set SMA1 and
> SMA2 as active inputs (DIR_EN=0) with U.FL1 output and U.FL2 input
> disabled. Each SMA/U.FL pair shares a physical signal path so only
> one pin per pair can be active at a time. U.FL pins still report
> frequency 0 after this fix: U.FL1 (output-only) is disabled by
> ICE_SMA1_TX_EN which keeps the TX output buffer off, and U.FL2
> (input-only) is disabled by ICE_SMA2_UFL2_RX_DIS. They can be
> activated by changing the corresponding SMA pin direction via dpll
> netlink.
> 
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 53b54e395a2ed8..c2ad39bfe177db 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -3545,6 +3545,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
>   	struct ice_dpll_pin *pin;
>   	u32 phase_adj_max, caps;
>   	int i, ret;
> +	u8 data;
>   
>   	if (pf->hw.device_id == ICE_DEV_ID_E810C_QSFP)
>   		input_idx_offset = ICE_E810_RCLK_PINS_NUM;
> @@ -3604,6 +3605,22 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
>   		}
>   		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
>   	}
> +
> +	/* Initialize the SMA control register to a known-good default state.
> +	 * Without this write the PCA9575 GPIO expander retains its power-on
> +	 * default (all outputs high) which makes all SW pins appear inactive.
> +	 * Set SMA1 and SMA2 as active inputs, disable U.FL1 output and
> +	 * U.FL2 input.
> +	 */
> +	ret = ice_read_sma_ctrl(&pf->hw, &data);
> +	if (ret)
> +		return ret;
> +	data &= ~ICE_ALL_SMA_MASK;
> +	data |= ICE_SMA1_TX_EN | ICE_SMA2_TX_EN | ICE_SMA2_UFL2_RX_DIS;
> +	ret = ice_write_sma_ctrl(&pf->hw, data);
> +	if (ret)
> +		return ret;
> +
>   	ret = ice_dpll_pin_state_update(pf, pin, ICE_DPLL_PIN_TYPE_SOFTWARE,
>   					NULL);
>   	if (ret)

Good catch... thanks for the quick fix.

Reported-by: Liang Li <liali@redhat.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>


