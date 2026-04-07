Return-Path: <netdev+bounces-276180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLzoGSx51Wn16gcAu9opvQ
	(envelope-from <netdev+bounces-276180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:37:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B03763B5171
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08C213018AE4
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39261379ECC;
	Tue,  7 Apr 2026 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXBoREGl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446233BBCF
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597865; cv=none; b=GB+YRCY/mT3LLPh3hNvl1xeNAKXU21DXimwQotP6xJfZUs4gpRavbCkltmFm6joY9KtuR0tQ8L5mGZxBTBSp95NUPZOZ7OhjyoEczNUlE0aFWPQ63YXA9e9oq3KbsHMw5sSCRht4YLmbXOjcXy9Sr2BLY52a38xlk+pANHYqcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597865; c=relaxed/simple;
	bh=UeNFG+Tu9jFaFzkC+ipiHKDkx0firXoegqt01H54q1c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=M7qHn94bLBX3R4hz5JRhclsz8UaXzw9wReXboo88LnQjNDbc3I2F7vZ78MtJ0sOzpw9Nie7J5Om8SG9NcZqGGCtdbe0Q/iP81v982hSqqKWXeKMc/62Kuju8rF9JFYFMCkEOad66Sv/Pm3Eu29OC7GFtcX9o8GBCF6ESbPUrixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXBoREGl; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fc4425b6bso53565727b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775597863; x=1776202663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc7+9XCeyeN5Dv6i/fTJTuMKR8I3qaOdvbrUp9zvwY0=;
        b=gXBoREGlGZJQBlGhSIB0hgjNlORvAhssvse4Gx2ILWjHSuIxd1ifLt4ur73iLEl/CN
         gJX8ALc1W7ydlmmzX1eIsY2RZT/JqHevwUEiXrPYzThBSvMuOAQIZ3m7gBEvYsaPRTGZ
         tPOvYjgA+5Wi/7DYciMj/zdCSCY5p09mBDVPjOyvw7x3qxR09tJxrQ8P+aneaMh3vDj8
         tdcDb9NsUGebfpyKPrPd7BKt4jhTd2B4AldLGgW4YolTmUg3BdIwpocDhNgeANUqrXQR
         DlsQFAKAvJaUoA/5pRQ2nFBIGbSCbqHhjyOv6sVOj3JDZdrepipM+3ZJQDHUxl+sVfrR
         5eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775597863; x=1776202663;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lc7+9XCeyeN5Dv6i/fTJTuMKR8I3qaOdvbrUp9zvwY0=;
        b=YoKWiHgwqN4729URtx4TnIpPKs6zrUiRjbUExt+qLQpORf/8h8wz9mxKY1AzXXAmBd
         atkO7LoJWxzoOFofu3Eyyyic+P+soGoYIbVQlLNaRiiiq9KhtWDGsXycjJKp4Tdjxh4i
         G9yRFnLQeVpQdg2n3tz8DaazTQDSgtER4aPDV0fliPnqlOxbVqf3/9gGEvVDElj2Zmve
         hGz4lN0IVRN4FkcWMXuDwGNd09bPPYAIh0O07gvewIp260L6KwU5OP4XPW+fkeN0jSQY
         3La3hZvw6m8E7ogiOdtOPx+E+IJrfmCIDhjrmhrQx6hWOzt0yQnA9zfV8SwYFhPVVtON
         HABA==
X-Gm-Message-State: AOJu0YwM4ac/qz/3QxvHFnryOM7NlruS/L4oCCiAqz0quWRBHLLYfTe8
	HDG6WcZUZP8jTlg27z9TQE8wB01k5vQxCObU9KgIS2mTo5fZ1pLwAdfV
X-Gm-Gg: AeBDietJ3tYUom2rWvX5swetbowdoSE+KX0Jy/JTrfAPEuzd2Ps0hNhxEjOjG9R4p98
	1XhtC8koqah8YCh3EP36AxvmXhF2OU15ypQsVjvPa/khG06916px3ZJ6DecgviOl63P3GW6J2BS
	weqgMwfMHSftPTmQIhAm3Z1lWGHp7bCTVUrFTzTATiU4XVxoDo3UxeR0C1ar7mR9m/SCyInx1Nx
	8AxSdOionSX2WDt9W/9xnSur0WfXM96LS75Z3luxNyH9P8+hLDUttzHfKDpfz0BnixtC4JHjItb
	c1zhAYf1YcJM3ele0f9h5v9CknpcHW6Wq0e6vOcd5HzS+RAkQ90ddSernlMCPjZAhBI6yVEq9DX
	p0R2C+HhDEjBv++YmBPxzoh/VnDXmcAEXl5IldkC/20DVuD6gkpqDJEQmXUMpXyMBhY4e3LAAjK
	ir44Sl14B8G5kYTaY/J88IT0cRFRQztgYQeiNagzGpQYozkwbC5tNW2LFZelBPONmbHYxqSa0xT
	8Tf
X-Received: by 2002:a05:690c:1d:b0:79a:2f38:9a8c with SMTP id 00721157ae682-7a4d3bd417bmr199677657b3.15.1775597862701;
        Tue, 07 Apr 2026 14:37:42 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e8329dbsm76175167b3.15.2026.04.07.14.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:37:41 -0700 (PDT)
Date: Tue, 07 Apr 2026 17:37:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 kiran.kella@broadcom.com, 
 akhilesh.samineni@broadcom.com, 
 sachin.suman@broadcom.com
Message-ID: <willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
In-Reply-To: <20260406222305.4111170-2-akhilesh.samineni@broadcom.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-2-akhilesh.samineni@broadcom.com>
Subject: Re: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold
 get/set attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276180-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[broadcom.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: B03763B5171
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Akhilesh Samineni wrote:
> crypt-offset (Crypt Offset)
> ----------------------------------
> The crypt-offset attribute specifies the byte offset within a packet
> from which encryption begins. This is a per-device attribute that
> allows a portion of the packet header to remain in plaintext while
> the rest of the payload is encrypted. This is useful in scenarios
> where intermediate nodes need to inspect or process a fixed-size
> header before the encrypted payload.
> 
> The default value is 0, meaning encryption starts from the beginning
> of the payload following the PSP header.
> 
> spi-threshold (SPI Threshold)
> ------------------------------
> The SPI (Security Parameter Index) is a 32-bit per-device identifier
> used to distinguish security associations. As SPI values are allocated
> monotonically, a threshold is needed to trigger timely SPI rotation
> before the space is exhausted.
> 
> The spi-threshold attribute allows userspace to configure the value at
> which an SPI rotation should be initiated. The default is set to
> PSP_SPI_THRESHOLD_DEFAULT (~90% of 0x7FFFFFFF), providing a comfortable
> margin to perform rotation without racing to exhaustion.
> 
> NOTE: A follow-up series will add notification support to alert
> subscribed users when the configured spi-threshold is reached, enabling
> timely SPI rotation.
> 
> Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
> Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> ---
>  Documentation/netlink/specs/psp.yaml | 13 +++++++++++++
>  include/net/psp/types.h              |  7 +++++++
>  include/uapi/linux/psp.h             |  2 ++
>  net/psp/psp-nl-gen.c                 |  6 ++++--
>  net/psp/psp_main.c                   |  3 +++
>  net/psp/psp_nl.c                     | 27 +++++++++++++++++++++++----
>  6 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
> index f3a57782d2cf..b22869be91cf 100644
> --- a/Documentation/netlink/specs/psp.yaml
> +++ b/Documentation/netlink/specs/psp.yaml
> @@ -38,6 +38,15 @@ attribute-sets:
>          type: u32
>          enum: version
>          enum-as-flags: true
> +      -
> +        name: crypt-offset
> +        doc: The offset from the end of the PSP header to the start of the encrypted payload.

In 4 octet units?

> +        type: u8
> +      -
> +        name: spi-threshold
> +        doc: Threshold for the SPI to trigger notification to the user for appropriate rotate action.
> +        type: u32
> +
>    -
>      name: assoc
>      attributes:
> @@ -170,6 +179,8 @@ operations:
>              - ifindex
>              - psp-versions-cap
>              - psp-versions-ena
> +            - crypt-offset
> +            - spi-threshold
>          pre: psp-device-get-locked
>          post: psp-device-unlock
>        dump:
> @@ -193,6 +204,8 @@ operations:
>            attributes:
>              - id
>              - psp-versions-ena
> +            - crypt-offset
> +            - spi-threshold
>          reply:
>            attributes: []
>          pre: psp-device-get-locked
> diff --git a/include/net/psp/types.h b/include/net/psp/types.h
> index 25a9096d4e7d..875f7822557f 100644
> --- a/include/net/psp/types.h
> +++ b/include/net/psp/types.h
> @@ -25,6 +25,9 @@ struct psphdr {
>  #define PSP_SPI_KEY_ID		GENMASK(30, 0)
>  #define PSP_SPI_KEY_PHASE	BIT(31)
>  
> +/* Default SPI threshold: ~90% of max SPI (0x7FFFFFFF) to allow rotation before exhaustion */
> +#define PSP_SPI_THRESHOLD_DEFAULT	0x73333333

Do you want to choose a more round number, in either hex or dec?

> +
>  #define PSPHDR_CRYPT_OFFSET	GENMASK(5, 0)
>  
>  #define PSPHDR_VERFL_SAMPLE	BIT(7)
> @@ -38,9 +41,13 @@ struct psphdr {
>  /**
>   * struct psp_dev_config - PSP device configuration
>   * @versions: PSP versions enabled on the device
> + * @crypt_offset: crypto offset configured on the device
> + * @spi_threshold: SPI threshold value on the device
>   */
>  struct psp_dev_config {
>  	u32 versions;
> +	u8 crypt_offset;
> +	u32 spi_threshold;
>  };
>  
>  /**
> diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
> index a3a336488dc3..bb390159dc72 100644
> --- a/include/uapi/linux/psp.h
> +++ b/include/uapi/linux/psp.h
> @@ -22,6 +22,8 @@ enum {
>  	PSP_A_DEV_IFINDEX,
>  	PSP_A_DEV_PSP_VERSIONS_CAP,
>  	PSP_A_DEV_PSP_VERSIONS_ENA,
> +	PSP_A_DEV_CRYPT_OFFSET,
> +	PSP_A_DEV_SPI_THRESHOLD,
>  
>  	__PSP_A_DEV_MAX,
>  	PSP_A_DEV_MAX = (__PSP_A_DEV_MAX - 1)
> diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
> index 22a48d0fa378..e50b8b80955c 100644
> --- a/net/psp/psp-nl-gen.c
> +++ b/net/psp/psp-nl-gen.c
> @@ -23,9 +23,11 @@ static const struct nla_policy psp_dev_get_nl_policy[PSP_A_DEV_ID + 1] = {
>  };
>  
>  /* PSP_CMD_DEV_SET - do */
> -static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_PSP_VERSIONS_ENA + 1] = {
> +static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_SPI_THRESHOLD + 1] = {
>  	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
>  	[PSP_A_DEV_PSP_VERSIONS_ENA] = NLA_POLICY_MASK(NLA_U32, 0xf),
> +	[PSP_A_DEV_CRYPT_OFFSET] = { .type = NLA_U8, },
> +	[PSP_A_DEV_SPI_THRESHOLD] = { .type = NLA_U32, },
>  };
>  
>  /* PSP_CMD_KEY_ROTATE - do */
> @@ -75,7 +77,7 @@ static const struct genl_split_ops psp_nl_ops[] = {
>  		.doit		= psp_nl_dev_set_doit,
>  		.post_doit	= psp_device_unlock,
>  		.policy		= psp_dev_set_nl_policy,
> -		.maxattr	= PSP_A_DEV_PSP_VERSIONS_ENA,
> +		.maxattr	= PSP_A_DEV_SPI_THRESHOLD,
>  		.flags		= GENL_CMD_CAP_DO,
>  	},
>  	{
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 9508b6c38003..536ee44db09d 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -79,6 +79,9 @@ psp_dev_create(struct net_device *netdev,
>  	INIT_LIST_HEAD(&psd->stale_assocs);
>  	refcount_set(&psd->refcnt, 1);
>  
> +	/* ~90% of 0x7FFFFFFF; allows SPI rotation well before space is exhausted */

Repeat comment. Not needed here.

> +	psd->config.spi_threshold = PSP_SPI_THRESHOLD_DEFAULT;
> +
>  	mutex_lock(&psp_devs_lock);
>  	err = xa_alloc_cyclic(&psp_devs, &psd->id, psd, xa_limit_16b,
>  			      &last_id, GFP_KERNEL);
> diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> index 6afd7707ec12..fbb77460a24b 100644
> --- a/net/psp/psp_nl.c
> +++ b/net/psp/psp_nl.c
> @@ -101,7 +101,9 @@ psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
>  	if (nla_put_u32(rsp, PSP_A_DEV_ID, psd->id) ||
>  	    nla_put_u32(rsp, PSP_A_DEV_IFINDEX, psd->main_netdev->ifindex) ||
>  	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_CAP, psd->caps->versions) ||
> -	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.versions))
> +	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.versions) ||
> +	    nla_put_u8(rsp, PSP_A_DEV_CRYPT_OFFSET, psd->config.crypt_offset) ||
> +	    nla_put_u32(rsp, PSP_A_DEV_SPI_THRESHOLD, psd->config.spi_threshold))
>  		goto err_cancel_msg;
>  
>  	genlmsg_end(rsp, hdr);
> @@ -193,6 +195,13 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	memcpy(&new_config, &psd->config, sizeof(new_config));
>  
> +	if (!info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA] &&
> +	    !info->attrs[PSP_A_DEV_CRYPT_OFFSET] &&
> +	    !info->attrs[PSP_A_DEV_SPI_THRESHOLD]) {
> +		NL_SET_ERR_MSG(info->extack, "No settings present");
> +		return -EINVAL;
> +	}
> +
>  	if (info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA]) {
>  		new_config.versions =
>  			nla_get_u32(info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA]);
> @@ -200,9 +209,19 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info)
>  			NL_SET_ERR_MSG(info->extack, "Requested PSP versions not supported by the device");
>  			return -EINVAL;
>  		}
> -	} else {
> -		NL_SET_ERR_MSG(info->extack, "No settings present");
> -		return -EINVAL;
> +	}
> +
> +	if (info->attrs[PSP_A_DEV_CRYPT_OFFSET])
> +		new_config.crypt_offset =
> +			nla_get_u8(info->attrs[PSP_A_DEV_CRYPT_OFFSET]);

PSP defines a 6-bit field in 4 octet units. Does this need bounds checking?

> +
> +	if (info->attrs[PSP_A_DEV_SPI_THRESHOLD]) {
> +		new_config.spi_threshold =
> +			nla_get_u32(info->attrs[PSP_A_DEV_SPI_THRESHOLD]);
> +		if (new_config.spi_threshold & PSP_SPI_KEY_PHASE) {
> +			NL_SET_ERR_MSG(info->extack, "SPI threshold must not have bit 31 set");
> +			return -EINVAL;
> +		}
>  	}
>  
>  	rsp = psp_nl_reply_new(info);
> -- 
> 2.45.4
> 



