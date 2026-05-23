Return-Path: <netdev+bounces-291118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMzaFiPAEWoNpgYAu9opvQ
	(envelope-from <netdev+bounces-291118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:56:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB095BF7E5
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59ACF300DF54
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973AD2F290A;
	Sat, 23 May 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j2DJuBbB"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636D15A86D
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548189; cv=none; b=sOtRHGv2Ae82QPj+QofEtjp60Qt/aYFWE4lbNJf3Y1F1V675Anrbp2b32QlvYhKd3ZAWs2ACv1YrpUmPDxs1a8s0O2RL/DvJvYYa2eDwsM/07IGATwINcAi2MQPN+OWWWFUvEWOubTcSvHXk+12Z02EA/USf2j0lwJRlSneoUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548189; c=relaxed/simple;
	bh=b73p98gcBBc9m4nhQ1fSwmeEobiYJ/k7nkZgtgkrWo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgGDJc9ld1Do8tpq/v0K2XBuqP+7e+a5EI0QVkNFJj8mYnWDJV/4v4ehWptszFRVDE4z3pc3jOyb+WPcUCgonnfYwlDYJQiJDUJC3F/Msg5x661KK2UMeMkqdT2YYGpPun8k2A+ISuTT9pFO4WAa+mLdV5Jf/VKLPE5GWUyYA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j2DJuBbB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 36A9B1A368B;
	Sat, 23 May 2026 14:56:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED77660733;
	Sat, 23 May 2026 14:56:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C44B610811D8A;
	Sat, 23 May 2026 16:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779548178; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=E5cA7KTyZDFFqu6OGoHX86CrIK6JuL74zX4RisJNYe4=;
	b=j2DJuBbB7abYhLk/SwwwZXQ/cu7tlGydbvUShn2Bd1MWpdM3oy8pApiInfRfdJ0D0pJETl
	ENkY3cC4eWqHvpsfF8Yy3HSR0CEp7YWW/iic8wnf748N8gpbmXl1p0slun+mrjIYOFXTlM
	1H3Iw2/FPOJVExMGU1XpkCCYKJMw/i7NsZaxAkvYmQyXXeBvVF5yKPdzjGkLAyRTgLrzEV
	Ah+GNHl2SvfYAgj4qEgcll7Is42RBcZyObUH4jGfYF/uCbAjbK1WgkliWyLz+eWMWBeMCj
	s9k8ETvS+n4K/I1MnSqBaNWe9t752sRnhn/n6TQ2NRevEhDT7TXCXAC1zQGQvg==
Message-ID: <3dfb895c-9356-46d6-b580-ec14eaba56b7@bootlin.com>
Date: Sat, 23 May 2026 16:56:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 8/9] ethtool: cmis: validate start_cmd_payload_size
 from module
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, danieller@nvidia.com,
 petrm@nvidia.com, o.rempel@pengutronix.de, idosch@nvidia.com, andrew@lunn.ch
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-9-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260522231312.1710836-9-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291118-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: BBB095BF7E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/23/26 01:13, Jakub Kicinski wrote:
> The CMIS firmware update code reads start_cmd_payload_size from
> the module's FW Management Features CDB reply and uses it directly
> as the byte count for memcpy. The destination buffer is 112 bytes
> (ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH - 8). So a malicious
> module (or corrupted response) can cause a OOB write later on in
> cmis_fw_update_start_download().
> 
> Let's error out. If modules that expect longer LPL writes actually
> exist we should revisit.
> 
> struct cmis_cdb_start_fw_download_pl's definition has to move,
> no change there.
> 
> Fixes: c4f78134d45c ("ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: petrm@nvidia.com
> CC: danieller@nvidia.com
> ---
>   net/ethtool/cmis_fw_update.c | 36 ++++++++++++++++++++++--------------
>   1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
> index df5f344209c4..16190c97e1f7 100644
> --- a/net/ethtool/cmis_fw_update.c
> +++ b/net/ethtool/cmis_fw_update.c
> @@ -44,6 +44,20 @@ enum cmis_cdb_fw_write_mechanism {
>   	CMIS_CDB_FW_WRITE_MECHANISM_BOTH	= 0x11,
>   };
>   
> +/* See section 9.7.2 "CMD 0101h: Start Firmware Download" in CMIS standard
> + * revision 5.2.
> + * struct cmis_cdb_start_fw_download_pl is a structured layout of the
> + * flat array, ethtool_cmis_cdb_request::payload.
> + */
> +struct cmis_cdb_start_fw_download_pl {
> +	__struct_group(cmis_cdb_start_fw_download_pl_h, head, /* no attrs */,
> +			__be32	image_size;
> +			__be32	resv1;
> +	);
> +	u8 vendor_data[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH -
> +		sizeof(struct cmis_cdb_start_fw_download_pl_h)];
> +};
> +
>   static int
>   cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
>   				   struct net_device *dev,
> @@ -86,6 +100,14 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
>   	 */
>   	cdb->read_write_len_ext = rpl->read_write_len_ext;
>   	fw_mng->start_cmd_payload_size = rpl->start_cmd_payload_size;
> +	if (fw_mng->start_cmd_payload_size >
> +	    sizeof_field(struct cmis_cdb_start_fw_download_pl, vendor_data)) {
> +		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
> +					      "Start cmd payload size exceeds max LPL payload",
> +					      NULL);
> +		return -EINVAL;
> +	}
> +
>   	fw_mng->write_mechanism =
>   		rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL ?
>   		CMIS_CDB_FW_WRITE_MECHANISM_LPL :
> @@ -97,20 +119,6 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
>   	return 0;
>   }
>   
> -/* See section 9.7.2 "CMD 0101h: Start Firmware Download" in CMIS standard
> - * revision 5.2.
> - * struct cmis_cdb_start_fw_download_pl is a structured layout of the
> - * flat array, ethtool_cmis_cdb_request::payload.
> - */
> -struct cmis_cdb_start_fw_download_pl {
> -	__struct_group(cmis_cdb_start_fw_download_pl_h, head, /* no attrs */,
> -			__be32	image_size;
> -			__be32	resv1;
> -	);
> -	u8 vendor_data[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH -
> -		sizeof(struct cmis_cdb_start_fw_download_pl_h)];
> -};
> -
>   static int
>   cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
>   			      struct ethtool_cmis_fw_update_params *fw_update,


