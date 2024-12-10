Return-Path: <netdev+bounces-150721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4809EB418
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D070C18816CD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5B1A9B25;
	Tue, 10 Dec 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8IkJ6Ep"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF11A0B15
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842663; cv=none; b=C1OaBiQhTVCdc1EXKxe2lTsWFerIquP1Co8wqu3xN/mYCf5mm76nQsnzgUepNobYqMEQP3bzclq/NIQ7HgmVuHkkfd352ocdzoXfESytOje7jyhtua7lCT39xXvorCS4qZszccgDigOspkrVSEC5OLV+BIPsNdw2ZVATMANWNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842663; c=relaxed/simple;
	bh=fDX5RNoVRjU4BcnqQdRaApxIr9nCwL29OAJ3hLNdKCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+g0J7Xktzo5O38VSEV0yJ14f5WbkaQ5PHjUHbXlTZP9hj2voNQke2YwR2VQ8ZsngOdoX3vmP34eCA3AkE8p2j52Jt1kpceXrVHppDvuqnWVmc4E5/xyjh1DS7eBjkFP3z8+n1j/wE9BKkPR/Uq5s3VqC3ntHU63xEJks+Ckqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8IkJ6Ep; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733842661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ay8NfcUY0T/d/3vklaeP1VfwpDuNBfY2af1Jw8w5ZUI=;
	b=U8IkJ6Ep8wpY0Oe7hBRf2+TGAXpsTCXNJT7kYktntctU7+BPYFk4PJfbCAhJfHl403cM2a
	BxJMBrdgZzlNkEn3wxyc7agnWIookMTFyldVvlAO7NTg+SmbP4imb5iCgNqDNBBeOs91Et
	HLqRzIAat+V0gWU06mFYk9krL/z0Hjk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-6RnjeSj8NxSQCSKFShjHYQ-1; Tue, 10 Dec 2024 09:57:39 -0500
X-MC-Unique: 6RnjeSj8NxSQCSKFShjHYQ-1
X-Mimecast-MFC-AGG-ID: 6RnjeSj8NxSQCSKFShjHYQ
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46686a1565bso107356191cf.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842659; x=1734447459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay8NfcUY0T/d/3vklaeP1VfwpDuNBfY2af1Jw8w5ZUI=;
        b=RChUcyhNFnE42rJBvgQLjerMezRe4rIajJ+yaEjAP0x0FN4LpRJlF5JsG02OyMrF4/
         U0RozlP6GDIoBxBdzAim6/5FC56sTtvlHZY/zoo/y7V6ACknneuCFk/+nkbBPwVls3Wr
         W5/k12KPeLJBsiRicKbEeeh9DIn83ilmEZpSMktwUYCN7Ua8+dGA/nBZGFUYdf7PdJkY
         uNIKZ9gdGkbp0zsRjQxehgyi+fSqC3CPrwoMfMZp7CPoNqDhvq9UJiUv/4TTbsL6Gdw9
         IWqvXghXnoJQncCNXTtX4QbqIqgzzehcoKmlZa4ffGMl6T7f3oNN9iehpz47r4zNHs8s
         j1rA==
X-Forwarded-Encrypted: i=1; AJvYcCUtrWbtzaCz2vBYNfXqS6rmVBfVe82zfSYbtUXDcKj80z6FX68dSx6tzt4A0ZstiJBCT5258SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx948I0OJa9umYVkNas1prQ3iLWhVlDVe3+t6TsgXBlebJRrvh
	ucV8qDeYwQFwz6a0PX5Mor/fsZYyxj8lnvDh2ykCRlkN5RI93/yjSVVVWnHMOH9ipF/WivRMY1e
	EBkTEB+COGvDq3NHiyUL7W4NpDRUWRVU3912dAdlZ1nUY5Ixnzxobqg==
X-Gm-Gg: ASbGnctsh0PAfMAIYoeJd8VJLGdkQkpVd3fgLmcon3FuI7TOItZ8AFB2OL3jELdNow0
	oC8lprkPsWn63uWP5oBLRmZpRl8Rj0j3K3dMoFJW3pCHGzC7DA20/nHadBRPsiOmiQ8GIveaCUB
	k04Cu9F/sjpkb1Z6dLVj1tiBhzmBjQylh4FonI2ZrsGNU2PLB2P4NTpgkCsUqZ+6esqtkQ9aHHf
	vN8xOTblOhs/akCxk5Ia6iv9u5Y22/oEd/4fznZhxYd3yLm9iTdWqyUZusPT39FVxtJ38dqkZ1n
	QL+d+rGVsq2Z6tyHdxVWTMLbVQ==
X-Received: by 2002:a05:622a:5588:b0:467:54f4:737b with SMTP id d75a77b69052e-46754f47fcfmr184716961cf.25.1733842659426;
        Tue, 10 Dec 2024 06:57:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG7cnNqoBiMvJLT/w4nsM1TFhqWSEwBKOd94h1uXgd+rgELynEhjwIX13vVuBdHIAhy0EDIg==
X-Received: by 2002:a05:622a:5588:b0:467:54f4:737b with SMTP id d75a77b69052e-46754f47fcfmr184716511cf.25.1733842659102;
        Tue, 10 Dec 2024 06:57:39 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4677006d143sm14016401cf.19.2024.12.10.06.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 06:57:38 -0800 (PST)
Message-ID: <6f5b5241-2b08-4332-9268-fde890f0ae52@redhat.com>
Date: Tue, 10 Dec 2024 15:57:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] ice: Fix quad registers read on E825
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>, richardcochran@gmail.com,
 przemyslaw.kitszel@intel.com, horms@kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
 <20241206193542.4121545-3-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206193542.4121545-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 20:35, Tony Nguyen wrote:
> @@ -1988,50 +2045,48 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
>   */
>  int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port)
>  {
> -	u8 port_blk = port & ~(ICE_PORTS_PER_QUAD - 1);
> -	u8 blk_port = port & (ICE_PORTS_PER_QUAD - 1);
> +	u8 quad_lane = port % ICE_PORTS_PER_QUAD;
> +	u32 addr, val, peer_delay;
>  	bool enable, sfd_ena;
> -	u32 val, peer_delay;
>  	int err;
>  
>  	enable = hw->ptp.phy.eth56g.onestep_ena;
>  	peer_delay = hw->ptp.phy.eth56g.peer_delay;
>  	sfd_ena = hw->ptp.phy.eth56g.sfd_ena;
>  
> -	/* PHY_PTP_1STEP_CONFIG */
> -	err = ice_read_ptp_reg_eth56g(hw, port_blk, PHY_PTP_1STEP_CONFIG, &val);
> +	addr = PHY_PTP_1STEP_CONFIG;
> +	err = ice_read_quad_ptp_reg_eth56g(hw, port, addr, &val);
>  	if (err)
>  		return err;
>  
>  	if (enable)
> -		val |= blk_port;
> +		val |= BIT(quad_lane);
>  	else
> -		val &= ~blk_port;
> +		val &= ~BIT(quad_lane);
>  
> -	val &= ~(PHY_PTP_1STEP_T1S_UP64_M | PHY_PTP_1STEP_T1S_DELTA_M);
> +	val &= ~PHY_PTP_1STEP_T1S_UP64_M;
> +	val &= ~PHY_PTP_1STEP_T1S_DELTA_M;

Minor nit: please don't mix 'cosmetic' changes like the above one in a
fix, that makes the patch harder to read.

Thanks,

Paolo


