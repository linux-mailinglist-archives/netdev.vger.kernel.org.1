Return-Path: <netdev+bounces-299811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wuePJHsuMWq7dQUAu9opvQ
	(envelope-from <netdev+bounces-299811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:07:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 250B668EA42
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:07:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KhrT5NOh;
	dkim=pass header.d=redhat.com header.s=google header.b=gmYlZ9eY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299811-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299811-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A16403109485
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAC2436352;
	Tue, 16 Jun 2026 11:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25C3624D4
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 11:03:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607801; cv=none; b=rEgOEb9WpLnTBC/zAylZDnJ9GecZjCygbxu6/cSRWA4DYCc8Xtf4nR3jLiemDJC8sbb8dSAQLnbUTlR4hRNJkdujylLjM9SpeFIvbbzQ0rSoiVCQH7mCqQ5wKGFI7e+zRsKUBH3ekiXb8oZRsNBwV7Z9/rDdi7JNh4xVOJksHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607801; c=relaxed/simple;
	bh=h44iuyI4FuYlCOwUiWXT4MYuNgCnjn67zk6F09ME1Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMZ5fioXY24uRtAz7Ft5UaGshWkcvTw0JQXLTCt+RoP9Zd4RXJ30HwER8rBm72KP09sYWWNrKdmLnbY0CgnoJ8QRt5xyq522QOubx3+4iF2JYr9GwMykT4dT8mK4/nkFACumtMTDcjl5PFs0q63hKbtTD7zhXVCUsUa/zIm2q3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhrT5NOh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmYlZ9eY; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781607799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tm5qA4bByar3MWTXjpvE4+fTboSmxNHbQF0mM/91USI=;
	b=KhrT5NOhrTAkFBgMpCyUuQhVM4kLYezCbNAqMyri5H0e5a7o13qabEAgs6WVZx/MRt3CVe
	CFSn6Ud5Elwo3XUNESgW4NexO7IEn40ksPYv1ELajCSxwbB7+eH/cZfmcugYZHfjcyDNPM
	sCG1wVDVuVFoMyh56oFUdVgE0ecvtzI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-EMjeBDYlPzu4zNuh98DcyA-1; Tue, 16 Jun 2026 07:03:18 -0400
X-MC-Unique: EMjeBDYlPzu4zNuh98DcyA-1
X-Mimecast-MFC-AGG-ID: EMjeBDYlPzu4zNuh98DcyA_1781607797
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-461a15b1062so440103f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781607797; x=1782212597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tm5qA4bByar3MWTXjpvE4+fTboSmxNHbQF0mM/91USI=;
        b=gmYlZ9eYeDs8k54fmHW/FsnVa/UFIHdVoT6YYmR8gkBXO93GJXsW1AzWHIw+wKW35i
         3AYtL3IjaNQ4kiy/fMeiWJUw2gNOdIYO+2NyuKmpksHZVsDpY8hpCIgSa43Z4jJXoWIj
         8BgKM10+t5gX9FBLzdyV7SP96TP19xW/UcqMmvyQzHhs571odbL14C9+bxqS8OkdA1bh
         NksCjcf9VsL/TnJbg2JRGflzSPYdctPluPVhNl6R7Xdx5QOOuktKncKk7w64YiPEWGBy
         Pr4Q0Eva55O5eqItjG4LdM6B+xyFO6Gn+zgF7HTJxLzqA1BCtWAGQJ61cyTuPMmJ/k6i
         nNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607797; x=1782212597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm5qA4bByar3MWTXjpvE4+fTboSmxNHbQF0mM/91USI=;
        b=nMd4g8ZpR5f8nX80m0bqLrTb1tu2fkgNKYtVR41HthmmtQGzfYzm1klL+KmJ7bmgd2
         PFAD7cKeIl2IU3BqAAMNoGhwUQv0TKxldljiqa6n+Iet8qKjE24VZBaj1zFZhBa/OE36
         9Cdq6v/3gjgCAeAnTF0WNxQs/k7mb4D/c14/J7cVw9NxRhKoVO0fzy1+YDziVZ8Aa+I6
         biyLC4JHfRpESrek1JTfMSFt/AKNoSiyRiRQbuoXu/qomXKfYwe8RYDEZVpsGGZh9uli
         mymz//VJCwtz8L/MWreZiofPpTCEWyqQDh9zu0edxkkXSfHyv02j9ynsveVPJQsFjPs7
         /Wkg==
X-Gm-Message-State: AOJu0Ywhq2g1JJYecpG2q452apDM3hgrlQIVXnmKwEQ1y4JDhBc1/jbC
	ZNtCsofl/DLQcKMrVweG46qud7loySiGupipDg8nI3gYDiVK/f2RoYFo+8j78mWqJ+3Xd8fPXH4
	TI1ufO/Ob9Mp6Nthd2KduTQQf3VqazEz0VJ19E1wQRzx9W8S8IzVpYYZUfg==
X-Gm-Gg: Acq92OHRRwUjOg1LANXPeyn6eVQPjx3Q/k031KlKTHyLGeYrZZuL/E9tgVfOfIJInw6
	e8xvJoFRcaY1MRGBcTam23VX45Bb2MFfLRSrvYxvNy76nEFNptH226RyUeX40esZ5skQJ1O1vka
	x3Yog1SPYCwVPiC7jx0TLv11znIIGi+MMqNbkl0JKvtCAOghJv3cYh/NSidhPWA7hkYzt/rlUNx
	OhSpxy3zkRKHKCmAtNmop2HMwWfc+88FaNEMbQrY3D+dXesrYJty9XmJyEOVpz779XIOLhwUiUB
	i1hno42o/LK/ntWxdDt7iD4jJP9zw3PLHV0wUC90P8+nQp0ZDFQpp9VbxrA2B5vDxi9uboJPkdV
	nldSis3gwBKUillxtgJ6rlyGeJWvUy6AetjlNjNNqZ1yi60yD34Z8tKQ3L4jat4Ob1Yw=
X-Received: by 2002:a05:600c:4ec6:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-4922ffb6836mr46074875e9.22.1781607795586;
        Tue, 16 Jun 2026 04:03:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec6:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-4922ffb6836mr46073585e9.22.1781607794799;
        Tue, 16 Jun 2026 04:03:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:17d1:b608:8e5:8aea:ed86:b36b? ([2a0d:3344:17d1:b608:8e5:8aea:ed86:b36b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a58becsm50581875e9.7.2026.06.16.04.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 04:03:13 -0700 (PDT)
Message-ID: <283859f6-8a60-49be-8439-146f8c2a6bb5@redhat.com>
Date: Tue, 16 Jun 2026 14:03:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] i40e: add devlink parameter for Flow Director
 ATR sample rate
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch
References: <20260614161131.192068-1-mheib@redhat.com>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <20260614161131.192068-1-mheib@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[mheib@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299811-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheib@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 250B668EA42



On 6/14/26 7:11 PM, mheib@redhat.com wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> The i40e driver uses Flow Director ATR to periodically update flow
> steering information for active TCP flows. The update frequency is
> currently controlled by I40E_DEFAULT_ATR_SAMPLE_RATE and is fixed at
> driver build time.
> 
> On systems with a large number of queues and high-rate TCP workloads,
> the default sampling interval can result in frequent Flow Director
> reprogramming for long-lived flows.
> 
> The amount of TCP packet reordering observed on some systems is
> sensitive to the ATR sampling interval. Increasing the interval reduces
> Flow Director programming activity and can significantly reduce the
> associated reordering.
> 
> Since the optimal sampling interval depends on the workload and system
> configuration, a single fixed value is not suitable for all deployments.
> 
> Add a devlink parameter to allow administrators to tune the ATR sample
> rate at runtime without rebuilding the driver or disabling ATR
> functionality entirely.
> 
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>   Documentation/networking/devlink/i40e.rst     | 19 ++++++
>   drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>   .../net/ethernet/intel/i40e/i40e_devlink.c    | 65 +++++++++++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 +-
>   drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  4 +-
>   5 files changed, 90 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
> index 51c887f0dc83..704469aa9acf 100644
> --- a/Documentation/networking/devlink/i40e.rst
> +++ b/Documentation/networking/devlink/i40e.rst
> @@ -40,6 +40,25 @@ Parameters
>   
>           The default value is ``0`` (internal calculation is used).
>   
> +.. list-table:: Driver specific parameters implemented
> +    :widths: 5 5 90
> +
> +    * - Name
> +      - Mode
> +      - Description
> +    * - ``atr_sample_rate``
> +      - runtime
> +      - Controls how frequently Flow Director ATR updates flow steering
> +        information for active TCP flows.
> +
> +        ATR programs Flow Director entries based on sampled transmitted
> +        packets. The sampling interval is specified as the number of
> +        transmitted packets between ATR updates.
> +
> +        Lower values increase Flow Director programming activity, while
> +        higher values reduce the update frequency.
> +
> +        The default value is ``20``.
>   
>   Info versions
>   =============
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 1b6a8fbaa648..88eb40ee45f0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -487,6 +487,7 @@ struct i40e_pf {
>   	u16 rss_size_max;          /* HW defined max RSS queues */
>   	u16 fdir_pf_filter_count;  /* num of guaranteed filters for this PF */
>   	u16 num_alloc_vsi;         /* num VSIs this driver supports */
> +	u32 atr_sample_rate;
>   	bool wol_en;
>   
>   	struct hlist_head fdir_filter_list;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> index 229179ccc131..16e51762db45 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> @@ -33,12 +33,77 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
>   	return 0;
>   }
>   
> +static int i40e_atr_sample_rate_set(struct devlink *devlink,
> +				    u32 id,
> +				    struct devlink_param_gset_ctx *ctx,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct i40e_pf *pf = devlink_priv(devlink);
> +	struct i40e_vsi *vsi;
> +	u32 sample_rate = ctx->val.vu32;
> +	int i;
> +
> +	pf->atr_sample_rate = sample_rate;
> +
> +	if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
> +		return 0;
> +
> +	vsi = i40e_pf_get_main_vsi(pf);
> +	if (!vsi)
> +		return 0;
> +
> +	for (i = 0; i < vsi->num_queue_pairs; i++) {
> +		if (!vsi->tx_rings[i])
> +			continue;
> +		vsi->tx_rings[i]->atr_sample_rate = sample_rate;
> +		vsi->tx_rings[i]->atr_count = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int i40e_atr_sample_rate_get(struct devlink *devlink,
> +				    u32 id,
> +				    struct devlink_param_gset_ctx *ctx,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct i40e_pf *pf = devlink_priv(devlink);
> +
> +	ctx->val.vu32 = pf->atr_sample_rate;
> +
> +	return 0;
> +}
> +
> +static int i40e_atr_sample_rate_validate(struct devlink *devlink, u32 id,
> +					 union devlink_param_value val,
> +					 struct netlink_ext_ack *extack)
> +{
> +	if (!val.vu32) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "ATR sample rate must be greater than 0");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +enum i40e_dl_param_id {
> +	I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
> +	I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
> +};
> +
>   static const struct devlink_param i40e_dl_params[] = {
>   	DEVLINK_PARAM_GENERIC(MAX_MAC_PER_VF,
>   			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>   			      i40e_max_mac_per_vf_get,
>   			      i40e_max_mac_per_vf_set,
>   			      NULL),
> +	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
> +			     "atr_sample_rate",
> +			     DEVLINK_PARAM_TYPE_U32,
> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> +			     i40e_atr_sample_rate_get,
> +			     i40e_atr_sample_rate_set,
> +			     i40e_atr_sample_rate_validate),
>   };
>   
>   static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index d59750c490f4..9c8144970a34 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3458,7 +3458,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>   
>   	/* some ATR related tx ring init */
>   	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
> -		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> +		ring->atr_sample_rate = vsi->back->atr_sample_rate;
>   		ring->atr_count = 0;
>   	} else {
>   		ring->atr_sample_rate = 0;
> @@ -12745,6 +12745,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
>   		}
>   	}
>   
> +	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> +
>   	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
>   	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
>   		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index bb741ff3e5f2..7e29e9244c3a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -372,8 +372,8 @@ struct i40e_ring {
>   	u16 next_to_clean;
>   	u16 xdp_tx_active;
>   
> -	u8 atr_sample_rate;
> -	u8 atr_count;
> +	u32 atr_sample_rate;
> +	u32 atr_count;
>   
>   	bool ring_active;		/* is ring online or not */
>   	bool arm_wb;		/* do something to arm write back */

Hi Aleksandr,

Your concern is indeed valid. I'm not 100% sure whether devlink 
callbacks are still protected by rtnl_lock after the large locking 
changes that recently went into net/core.

That said, I'm wondering whether we need to store the ATR sample rate 
per ring at all. As far as I can tell, there is no option to configure 
the sample rate independently for individual rings, so maintaining a 
copy in every ring may not be necessary.

Would it make sense to remove the per-ring copy entirely and keep the 
sample rate only at the PF level? That would avoid the need to walk the 
rings from the devlink callback and would eliminate the race you pointed 
out.

Thanks Piotr for the review. I'll address your comment in v2.


