Return-Path: <netdev+bounces-191922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3DABDE02
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71CD57A481B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622B24E016;
	Tue, 20 May 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Mmozjogk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC524E4A8
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753079; cv=none; b=TmM/GOwQEgnQV+IvSmdytqG18EtIggPxUOtaz/ncvf3Ksthvn0K7sShEqSy0vDZMc4dRt5/ocnLLZDevcFWdSSd1bjWPmU1m7T4/3rZCMLZZmtgXMd5O4i0QspUXKUmQpME/vExhrnoHxTWrlE5xR8RjDyfVpNIVr/dagjnR6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753079; c=relaxed/simple;
	bh=VISxHv4OsFTsoEUt5eNyegys5mmm4qPf/ppdXwiKktg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQDn210Y8yyPiqXQEnLxTo+gKp0cEc4CkIEu24H+b690RY4Yz4OIZFK4I/3dm+38+7fVCkEknaBj0khsL/i2CfEpRvoeAqOdOYv0yBOUgIW6cCFFKeFS8aOf/eIsy9S/uZjpBW3Hnb9QfTAmRTOeqxtSST4l4lvooUaUlNNJaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Mmozjogk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6016d401501so6683042a12.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1747753076; x=1748357876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Qtl97qHyAzb2uefJnsAL0gs4dhaHr+ud6o600xsqZw=;
        b=MmozjogkWoc4b5NOr9kWY7aVKSkE+iwHGGzv54GAsCSWNSF67XrgM0QU6Cib3F3x2A
         2AqlfPcH9aoFnyi3eEMx5v306trxAIttE/I0eUyhene1+XdHcnjwrA1uBZ1ofdD46O72
         Lip6C+9V+fhDE+lZgBcr6HBDZTwZaKHxtF5/0DQ5IKhy46RQZ356eIEHjTU9VNwVvSHF
         A48roedBDRlnE5KfbPUdBU96DOP+sGHPH4ubEpvU6TpVrfBB0sC0LV5QsSPzqryvh4OW
         7UdU9FeUwJtVlOJHhxB0yfY+XVN1tmJUN0EWvrVNVn0ux3X3bKyY0tPVT060DyIFk6DG
         dRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753076; x=1748357876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qtl97qHyAzb2uefJnsAL0gs4dhaHr+ud6o600xsqZw=;
        b=bQqn4EzA/EFBSPsMjwP47dcGOYqMPuxU4z/TftIibpKgCIhQHG+uFKL13ovMLo3x2j
         QTNdU6PCl5KywRN+aH9A23BCC8x/CMxEUM0LcRuY0ykcqjnBmkOEaNRZxpzSvP2Jwz7O
         j4SxsNg+ynkahmawYyHrW7QoFtXtZ0EHetVFLJzTe+v3cwGtymnRLhH7jHibkVsXJ8kA
         +XlJtnOLr9kMYXD2OCy6hr8p/Ct5sjC5Z4yyItFiR4k6art3C2HTGsE2WhFQVi/uZIip
         LQlmaIDvaXc2bZiKZodcyjWgxo5lbhk3J6Zki0oQ45lypf4DBC9UcBO4l5t+Fax87Vwz
         5zIg==
X-Gm-Message-State: AOJu0YwXOnd9Yab36Fg0w2OtcS0HrRhQLlwqy8zAcs7idzsL5YH68dks
	KdhAMmKd1kRM8jwXe6XuhUibrFuw3tvEEQ9rqCNWuL/D0nbyJcatxmwEX9AO1UaHl4k=
X-Gm-Gg: ASbGncu9dfWf/WKdJmU+UrIzshUso0UFPhA1yRZKUoWxr4btcEfMsuBLpiP0yZ5dajR
	FL4zeniqNACFBBba1VO3IcSlvjyiNMWxtofZd8tmAiL0aeoKxlRXmxErpVxmgG3Wlv7jKs3uD1O
	rwZ8qI4toXEYkXAuIkCHnuKukyOuca0Xbtrd8cSvhiT0nd6zKJ80PfpkZsGruvoRGeyF4JMcToY
	o/2VR8f4VE5E241jK01WVIW52iTgpyPc8HR6IDC1DIBtf/85OGIvUCWEFUreF/tZO92ugmB5eVj
	Ww6yUx2od0pGtlPsyh5ppAeVPwbXM5ho1HAMYCyDQk4eMYOsuS1H3h2NOU5JEXzvA+ZSnxntuEa
	058UPAIsXuIO+lWns5zLNd4h+IJJx
X-Google-Smtp-Source: AGHT+IHVWRmNINZ96DFZ1cfXeAt/3uTCvt4xtp79i2Bzh4mHaL04S0fexJCL73Vex+VmbK6o7r87pQ==
X-Received: by 2002:a05:6402:60b:b0:601:68ee:9644 with SMTP id 4fb4d7f45d1cf-60168ef1177mr11903937a12.17.1747753075624;
        Tue, 20 May 2025 07:57:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:cc1:c3d6:1a7c:1c1b? ([2620:10d:c092:500::4:4bc7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae39492sm7323508a12.70.2025.05.20.07.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 07:57:55 -0700 (PDT)
Message-ID: <f21ff7c0-9462-44f8-8212-00906698706f@davidwei.uk>
Date: Tue, 20 May 2025 15:57:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] bnxt_en: Add a helper function to configure MRU
 and RSS
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
 <20250519204130.3097027-3-michael.chan@broadcom.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250519204130.3097027-3-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/25 13:41, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Add a new helper function that will configure MRU and RSS table
> of a VNIC. This will be useful when we configure both on a VNIC
> when resetting an RX ring.  This function will be used again in
> the next bug fix patch where we have to reconfigure VNICs for RSS
> contexts.
> 
> Suggested-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: David Wei <dw@davidwei.uk>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++++++++-------
>   1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 6afc2ab6fad2..a45c5ce81111 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -10738,6 +10738,26 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
>   	bp->num_rss_ctx--;
>   }
>   
> +static int bnxt_set_vnic_mru_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic,
> +				u16 mru)
> +{
> +	int rc;
> +
> +	if (mru) {
> +		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
> +		if (rc) {
> +			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
> +				   vnic->vnic_id, rc);
> +			return rc;
> +		}
> +	}
> +	vnic->mru = mru;
> +	bnxt_hwrm_vnic_update(bp, vnic,
> +			      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
> +
> +	return 0;
> +}
> +
>   static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
>   {
>   	bool set_tpa = !!(bp->flags & BNXT_FLAG_TPA);
> @@ -15936,15 +15956,10 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>   	for (i = 0; i < bp->nr_vnics; i++) {
>   		vnic = &bp->vnic_info[i];
>   
> -		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
> -		if (rc) {
> -			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
> -				   vnic->vnic_id, rc);
> +		rc = bnxt_set_vnic_mru_p5(bp, vnic,
> +					  bp->dev->mtu + ETH_HLEN + VLAN_HLEN);

Pure mechanical change, LGTM.

Only nit is to calculate this mru once outside the loop, like patch 2.

Reviewed-by: David Wei <dw@davidwei.uk>

