Return-Path: <netdev+bounces-202097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E5AEC37F
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6193B7554
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB70EEC0;
	Sat, 28 Jun 2025 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU6/7YSx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233BC10E4;
	Sat, 28 Jun 2025 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751070132; cv=none; b=ojBdM5bvhMffRL9ljczC0kwpWzzNeR2RKOwO7asHiAeSLNDqnyaG7H9vdEgn97Zs6BSgXGqA2egCLf5HyA3TliQ/PYYHPcs7iMwb17nyqxo1RqOAnCHa55IVMltP+FTPwbDLtjshkkuLCNR+x8eeuTQBrdZO9lJXWL/YUgU6YWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751070132; c=relaxed/simple;
	bh=WmVHHC6HaF0TCK/VuRNnvQYaYYTBrrtNy0po+eyvfgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uE6aOBgzm1AsVnxjJZhMX8UbzDz2kOAxWA9qJFQa+0JDzv6LjCH7xEwY6YtK+wev6+Fp2CuUs7IHXaPknhG1hLZAR8fHSZrSfb/CoG2G0/wsEGy7fadeCNzDEpnr3YWQmgrHQd/9/x6hTXknhwCRxFqoi/SG0ofhj5sQ2eSJmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU6/7YSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40152C4CEE3;
	Sat, 28 Jun 2025 00:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751070131;
	bh=WmVHHC6HaF0TCK/VuRNnvQYaYYTBrrtNy0po+eyvfgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZU6/7YSxRgBqLDozC/iSmO+QS+cURKPfENAAoI/GMqafvBDUu2T8CtFwVNzeiCLRX
	 7Wu5p9+rwUI930PHClFL+muxOMLw+1lf5SDmzFuVJ3FZ06RYvnOysVfL/s6yANs53Z
	 sopywFMhkhvReY2enmu1BAGWeGy09A9UMQVXYXTvRLpn7dtzmxNHUrpLT80VfCtlDY
	 dl9MmPgT22f7wEyOf6PDaoQRoEx01Blj/5utI9M3Js+cOi4b02IsQS/a4vu1Wcpx3d
	 yOcuiAsUn20dexjkBcTIpRMH5HpG0cpZGAwHQAqCYihw/XmCVUdB7cNlKGjdwbl5p7
	 bepLXcFEJ7MpA==
Date: Fri, 27 Jun 2025 17:22:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, Bhargava
 Chenna Marreddy <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next, v2 04/10] bng_en: Add initial interaction with
 firmware
Message-ID: <20250627172210.5d42e0f1@kernel.org>
In-Reply-To: <20250626140844.266456-5-vikas.gupta@broadcom.com>
References: <20250626140844.266456-1-vikas.gupta@broadcom.com>
	<20250626140844.266456-5-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 14:08:13 +0000 Vikas Gupta wrote:
> @@ -128,10 +175,26 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err_devl_unreg;
>  	}
>  
> +	rc = bnge_init_hwrm_resources(bd);
> +	if (rc)
> +		goto err_bar_unmap;
> +
> +	rc = bnge_fw_register_dev(bd);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to register with firmware rc = %d\n", rc);
> +		goto err_hwrm_cleanup;
> +	}

you're adding this _after_ devlink has been registered
users can access the devlink ops before you finished init
-- 
pw-bot: cr

