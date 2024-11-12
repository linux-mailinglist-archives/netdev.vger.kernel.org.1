Return-Path: <netdev+bounces-144082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51B9C5809
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2935E2818A4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23561F779E;
	Tue, 12 Nov 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfsL4YhW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544B1F7555
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415327; cv=none; b=Fbsod6qfLS16BKsr9v526k+Pej5UUd1xVG7xY+dyRIeibpaNtHk68+1CqS0eYLtex0d29WmQocl8La8yxHvezIUql94ctojg7GdUljLUfWi24OqseG/XegKNuKhmF+hF26t+wlAk08XRL1/XToUS+76jTA2lG5wZu4RyepFG4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415327; c=relaxed/simple;
	bh=chn0Og9dknh9NFD1+hug6TJ2cJiq2gS7K5SjC3tf5F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d3GuSI0XPxxRNngPlsLl3eYzKra0XMX5xdYdsQ2sGKaVn3R5DxsANcmagWmlENhx5cq6SaLT3D1awXxqCukOOHTUzuKmo9x/7WLriYy/WPYPvYKyhwwOAM5p0qF2VRF8mqmjbXEb7ksSFTVGYDG9+yRAdMM59CaDlNG1w8SCHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfsL4YhW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731415324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDLehEjuNsFPCSJ4jDeCsWR7/ytRVPGdGFIf0zIq5Rk=;
	b=ZfsL4YhWmzl4jVIKx1IILf+J5s8bx/VMtZzxGwqWsm4LMytl1QtyutFaH6wl19tTaxxoZS
	2sIejTNwCyiEw02Wb5cpjAowGdIgOeEiyIDT61guIH7SasX/0qE+ailyFbgxStV2EYWa1o
	7QZKXvxA+a8jzEz4Tbdzgxub7W85xT4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-necpeGrFNdGMYAOLbq4mYA-1; Tue, 12 Nov 2024 07:42:03 -0500
X-MC-Unique: necpeGrFNdGMYAOLbq4mYA-1
X-Mimecast-MFC-AGG-ID: necpeGrFNdGMYAOLbq4mYA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbd2cb2f78so110522346d6.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 04:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415323; x=1732020123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDLehEjuNsFPCSJ4jDeCsWR7/ytRVPGdGFIf0zIq5Rk=;
        b=Drl49KgSZgPBW+iT/91al9PvvSc3Fjv372OB/IbBkVy5hEmTA+OTA2iBw7Xgv7dums
         q75O+qexEgUI5XqTH8vAreuqFDPGNL/QUnhbsn8JIcwOPClz9n3mJ3TRnbDDUnjjB3zT
         URkMtAOzv85q6zMArtgHwQK59EdxzqkUa0RVcqZKWa62r+4cCXKBmYzlkx77wkfRgb39
         jEKZK07mQ0ueor+/qJz17J6c1ldC+KPlxffxkbWJy24aO7rFFtyYtKB/pIzy9oGoHQ+f
         IR+4Yw7KU1E/NzpEAMVHfHqk867ZAytHZAHSLXpcYpd9voY6/5x6g7mHGRBoAW9GMi3p
         PdEA==
X-Forwarded-Encrypted: i=1; AJvYcCUntkIjqUrNzbSNfY/MBP9PcNfrSGx/fpydU8mfjQ1WNxmGG4RqYEooUOtOUgTwPTlBFNZWPw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuQLUqL9zlHj2tZr7IdLFf3DhwKc0aOmuIHWG46TTkc3TRRIy
	T2q+6UbmSz2ieOZQivYPxIBXBGgn1FObeVbyF9ZoYLvWsExW61uQf10x3lQfjxMG34O9M8nOY+V
	e9Z4qdPGIbzR0oEFmTNMc0CsHNE7riQ9SL0hkcwEmvYukB91Ymlq/0Q==
X-Received: by 2002:a05:6214:469c:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6d39e239cc4mr278418076d6.0.1731415323025;
        Tue, 12 Nov 2024 04:42:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWKpKe63uXm6m6ge9fO7av9h0wMJ5vFHEYuk+a846d4GvgyTt2A4xoaqDo6lq2M33RyfUSrg==
X-Received: by 2002:a05:6214:469c:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6d39e239cc4mr278417706d6.0.1731415322679;
        Tue, 12 Nov 2024 04:42:02 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3983445f0sm69184166d6.83.2024.11.12.04.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:42:02 -0800 (PST)
Message-ID: <c9d61267-4bc8-4c1e-a3a2-ff1cbd46f7a5@redhat.com>
Date: Tue, 12 Nov 2024 13:41:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v9 5/8] cn10k-ipsec: Add SA add/del support for
 outb ipsec crypto offload
To: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jerinj@marvell.com,
 lcherian@marvell.com, ndabilpuram@marvell.com, sd@queasysnail.net
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-6-bbhushan2@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241108045708.1205994-6-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/8/24 05:57, Bharat Bhushan wrote:
> This patch adds support to add and delete Security Association
> (SA) xfrm ops. Hardware maintains SA context in memory allocated
> by software. Each SA context is 128 byte aligned and size of
> each context is multiple of 128-byte. Add support for transport
> and tunnel ipsec mode, ESP protocol, aead aes-gcm-icv16, key size
> 128/192/256-bits with 32bit salt.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v8->v9:
>  - Previous versions were supporting only 64 SAs and a bitmap was
>    used for same. That limitation is removed from this version.
>  - Replaced netdev_err with NL_SET_ERR_MSG_MOD in state add flow
>    as per comment in previous version 
>  - Changes related to mutex lock removal 
> 
> v5->v6:
>  - In ethtool flow, so not cleanup cptlf if SA are installed and
>    call netdev_update_features() when all SA's are un-installed.
>  - Description and comment re-word to replace "inline ipsec"
>    with "ipsec crypto offload"
> 
> v3->v4:
>  - Added check for crypto offload (XFRM_DEV_OFFLOAD_CRYPTO)
>    Thanks "Leon Romanovsky" for pointing out
> 
> v2->v3:
>  - Removed memset to zero wherever possible
>   (comment from Kalesh Anakkur Purayil)
>  - Corrected error handling when setting SA for inbound
>    (comment from Kalesh Anakkur Purayil)
>  - Move "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to this patch
>    This fix build error with W=1
> 
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 415 ++++++++++++++++++
>  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 113 +++++
>  2 files changed, 528 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> index e09ce42075c7..ccbcc5001431 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> @@ -375,6 +375,391 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
>  	return ret;
>  }
>  
> +static void cn10k_cpt_inst_flush(struct otx2_nic *pf, struct cpt_inst_s *inst,
> +				 u64 size)
> +{
> +	struct otx2_lmt_info *lmt_info;
> +	u64 val = 0, tar_addr = 0;
> +
> +	lmt_info = per_cpu_ptr(pf->hw.lmt_info, smp_processor_id());
> +	/* FIXME: val[0:10] LMT_ID.
> +	 * [12:15] no of LMTST - 1 in the burst.
> +	 * [19:63] data size of each LMTST in the burst except first.
> +	 */
> +	val = (lmt_info->lmt_id & 0x7FF);
> +	/* Target address for LMTST flush tells HW how many 128bit
> +	 * words are present.
> +	 * tar_addr[6:4] size of first LMTST - 1 in units of 128b.
> +	 */
> +	tar_addr |= pf->ipsec.io_addr | (((size / 16) - 1) & 0x7) << 4;
> +	dma_wmb();
> +	memcpy((u64 *)lmt_info->lmt_addr, inst, size);
> +	cn10k_lmt_flush(val, tar_addr);
> +}
> +
> +static int cn10k_wait_for_cpt_respose(struct otx2_nic *pf,
> +				      struct cpt_res_s *res)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(10000);
> +
> +	do {
> +		if (time_after(jiffies, timeout)) {
> +			netdev_err(pf->netdev, "CPT response timeout\n");
> +			return -EBUSY;
> +		}
> +	} while (res->compcode == CN10K_CPT_COMP_E_NOTDONE);

Why a READ_ONCE() annotation is not needed around the 'res->compcode'
access?

Possibly more relevant: it looks like this code is busy polling the H/W
for at most 10s, is that correct? If so that timeout is way too high my
several order of magnitude. You should likely use usleep_range() or
sleep_interruptible()

[...]
> +static int cn10k_ipsec_validate_state(struct xfrm_state *x,
> +				      struct netlink_ext_ack *extack)
> +{
> +	if (x->props.aalgo != SADB_AALG_NONE) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot offload authenticated xfrm states\n");

No '\n' at the end of extack messages.

(many cases below)

Thanks,

Paolo


