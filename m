Return-Path: <netdev+bounces-108830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F16A925D3C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B27A298E55
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663717D89A;
	Wed,  3 Jul 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM7TMBHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED213776F
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005413; cv=none; b=GBpvL7Iap9X1/OWK+492cWxc2b8o9uQdSreU6OQwTButvT1rzhq+HvrHArUXS+Digto4lILxOSteKlqzvAhTh3alSA0cQsGR9gH8qnHv0se47p47JvPrh5ueRUWPALVJkpSBIXCUb8PENcGw0grx/glxGLpjLH86LW98xtqI+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005413; c=relaxed/simple;
	bh=ukpiZRV7vl/3zhrgnKaEb14mimJQeFxwYl83UyoGH+o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eLTHf27JHrQ3PYZ6JPboTXHQVM8iqWXcUj15XfwqeUZC3xxyxIwnio+yX0H/qBIp439xOBi0O30b3EFC5c+nM6E0ZbZApsifeLv6KXUWQL5M7tPWkmXYoILCjbqbGVi0p0g+TIpf6qEaINfcwScBENG+MW6rTzFcKE91uqh5ZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM7TMBHe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36743a79dceso336857f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720005410; x=1720610210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Kd2RCFCJgBonbgau+UpTTKPwwLyhZJyKdZByPKrFdc=;
        b=QM7TMBHeepD/iczOFIAExXNJSuek7cUdD3PlDv9Zdr8UeT2HdaJSrZN2Hg3tf/1z3y
         aGRtX4KzPPPJGGmXgNNuKdyiL94VMMnnuxRggS+vNCt+BVVoTWSykvnvSPUsTH3D8tbc
         TDlxUWP7YYsU73AZsmDUj/plURmwhJqt0j38zBfSR/KDYzin+3Ij5HcnWY0B32MFwFgm
         Ui9PpYMoATcMwZx7VWsLVxfYvywIr1Klcp6UazOie/tYk/S1onypOc4VLe9duOs3MOKV
         +CtZ4DGhvSclOGIVakOsBfRcupP6QYaADT6lHN3Y7oDH06hdxVHYMhvNcl1Rujq3kbVN
         flwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720005410; x=1720610210;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Kd2RCFCJgBonbgau+UpTTKPwwLyhZJyKdZByPKrFdc=;
        b=LFDmGNcP6HczEuzse0h6aZZ9oHO8wgS+YZ0WrApnxE3t6H71YszHV7d45kCCI8yaN9
         YkFzb6E4RoM+7qtIX4y9jxadxKipG/F90oPJI5HG3feA6I8+Tf6RWZaUyxvJ6UpMuTT6
         pIYCTRxaqovdfaY/PRbO09GanUoiBvM38oO4ZM5JvYQrtKkFymRsHvmg9dsmv8GjmQhu
         u1W9562O34nySJXcC1OVjiGIysBhxkfYrgSOII5o82y/rhBW3TsWZjRg5vqAFNkC1xpB
         3bCIQTg6wUTJIga016efJqYuOxcmgIqH3OMhAv+afzS6zDzZZeWQ94tVXAI3E/+WaxKL
         pf+Q==
X-Gm-Message-State: AOJu0YzxvJlozDiyaddrq1rg9C3gGje5xGdfrHPb02Wz2RmMOcuLYkcW
	NYhXU32Q0RRah1kG8d+bkawPvGbIUXdHlCZiKEM8oneBxUORuR0TX1qV2PK5
X-Google-Smtp-Source: AGHT+IG0TeC9PZ8JKvhUexXzuDVESkV7fhCVJRUodTUMREHbgMkMhpEfSDQF6mIRbtjmC7Joab7/Gw==
X-Received: by 2002:adf:fed2:0:b0:367:8f89:f7c9 with SMTP id ffacd0b85a97d-367947bed8emr1030491f8f.33.1720005409835;
        Wed, 03 Jul 2024 04:16:49 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679814a276sm13097f8f.84.2024.07.03.04.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 04:16:49 -0700 (PDT)
Subject: Re: [PATCH net-next 02/11] net: ethtool: let drivers declare max size
 of RSS indir table and key
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com
References: <20240702234757.4188344-1-kuba@kernel.org>
 <20240702234757.4188344-4-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <377302f2-f081-9737-c0a8-8cffe2a5fcd0@gmail.com>
Date: Wed, 3 Jul 2024 12:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702234757.4188344-4-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/07/2024 00:47, Jakub Kicinski wrote:
> Some drivers (bnxt but I think also mlx5 from ML discussions) change
> the size of the indirection table depending on the number of Rx rings.
> Decouple the max table size from the size of the currently used table,
> so that we can reserve space in the context for table growth.
> 
> Static members in ethtool_ops are good enough for now, we can add
> callbacks to read the max size more dynamically if someone needs
> that.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/ethtool.h | 20 +++++++-----------
>  net/ethtool/ioctl.c     | 46 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 3ce5be0d168a..dc8ed93097c3 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -173,6 +173,7 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
>  struct ethtool_rxfh_context {
>  	u32 indir_size;
>  	u32 key_size;
> +	u32 key_off;

kdoc needed.
Other than that LGTM.

