Return-Path: <netdev+bounces-206217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D03B02295
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E281C249D6
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034682EF2A2;
	Fri, 11 Jul 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL1iFA8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B61195811
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254750; cv=none; b=lNEmLLL6ANDv2ypu0DJODzDNylHeiPhI0l109tnalFW02Yddb5xPDGaDAM/PqpvCNVwE93MwS4WQ8CPzyrq7LvjzD8WP3ugbGRkT9HdDSJBgIR9fJs4R8TPFUt/th52bFyPKlNP7crj96xEFooZwfn3gS2rXvi2jYpDhE+ASCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254750; c=relaxed/simple;
	bh=24P/28F5W06ifiSCYjlsbSBK8TyIky4faXqbltszBo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fgn4v7BRPUI28wh4reQWWNOTPf2CZHLCdxFOAsyxmE4jesyE1KCGtQboNMNggbRxY2uLGKC/BLc9f0pwVP/+nYjG5M0faHpiVX6FtjFw4nAi7yK6xsiEu0sY1QlFWR63QHw/xh0jXLDFkg6T7+xeRvLjS35z1vpvP5jFGohz8A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL1iFA8w; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1543048f8f.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752254744; x=1752859544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfyUnchmurLz1khxJs7qXQs+Ki3xoGdfSQZZJx02gkE=;
        b=aL1iFA8wmhZxjS3ieU+Rg8keU/TUOk4kWAHJpne6oU9Q+N+MolAZf+/MdUUZSGVqsZ
         R828rpE2Z9KMitVjJwlFitQ+SY6w3Ed4UJjTkQ3+F2+XvctQId6KA/USVb86qSuAtbgR
         kLURVDsluHLU9z37Nqlvf1cq5o8tW2IvkmNLyuMQG+EFthC5lfCzenkgo4oBqewBVVep
         PtQDq6T1AV2zrFEVuSpB47PPmTvsLzF4y0EygW3+EAasxC/ea+DDiwJbg7kXW5K6/juz
         FIgJO+f1thUWqnGldkYX9f6k67LViwxG9sp3K64JiEk2moTb5M0Rv+M4hwqL3vnfMeM9
         Z2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254744; x=1752859544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfyUnchmurLz1khxJs7qXQs+Ki3xoGdfSQZZJx02gkE=;
        b=PdamMSG61BDAhedZmh7BNg40jrtwY4jGpXikPKLruUqhm5OSG1CM2l4f/S0ZlY/QTf
         2mPN4EdYsFxSag88ovPF7K+jvJ+LZHpkBeI9bTAVj+H0s6FvH1isO5uZJ1SJTh0HKQ8d
         icxzEGr99bdAC63cC2AeC0tL/Ae1rGVMjIEAxxGrhPmCGXh9rCH27kPiibsPK/q2vnPF
         ik8XwWVVE8k7jotboKz3KYGLs05OgHWod1aLgtvep3u4bjO9qs7e55j5EbpzeG5e9IIA
         u+4alJjdHDk7aXnTj1JV7IBPvHuFyE+qH1Y/aqASaLij9EV0bx6tiYaroseMvRGF3QDl
         0PkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhhZ98BILdeGRvgtHUm4c0ZAatloMU/Mv3eNNtaZmasbnXXd8XLFEAdJOWKgD0FcLCqbEj/VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH26RtzBlX/TOXcabPOq1oQ2AAJ7+iIAqVd+DP+IhBTxrPoLPq
	t5gu8EU+4jW4wq31bLH6U/59p9h3CssVQ2kvwaRfHb5s4euj495/+zPa
X-Gm-Gg: ASbGncu0gNLjepJ+XtOFwlLKRzbJsbWFjeIEVPw40HZXvJfi/Lp2k217lwZfoaYJIam
	YpgVYNFT/DuNV2gf66c1d0qDjnVuF03PK2T7tQ5mpkEtt2HmogrbZtOMH3oz5b/GBrJq1j6xfTV
	9tr3NQvXOHdHdKyaIkqBbTJUE2/k1Oo8yjbhwxhgOpGhpFFIm9gb7Fgo4XnT+/4N6j5gf4yT8eW
	oVfpmc1SkveUzOO2/WfavdhyZzhqFJAvtqP1OjKbVBTJPEax2YCxLsw3S3n40LVtMUanT30MB8E
	er9AQOBY3gVwiQqZ5ePRNwkHMT09GaeAfHUIsGacuzao6xKbbVxCqtf9f0zj8u7ZSWas6nu7Z2m
	CaYuj44MSnb93oBOOU1akTDcS6aCe0VVeV/j6hM1Jc8ZiOLiqlbvwRw==
X-Google-Smtp-Source: AGHT+IG/hAmjRRBm8w4nMagkHAbq7WL27iYrMNEADPLc0KT2RVh3CY6J8usCAztKazfOKM2CUkv3DA==
X-Received: by 2002:a5d:648c:0:b0:3b4:9b82:d431 with SMTP id ffacd0b85a97d-3b5f188062dmr3604189f8f.13.1752254744070;
        Fri, 11 Jul 2025 10:25:44 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d5f5sm5038049f8f.56.2025.07.11.10.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:25:43 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:25:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 1/5] e1000: drop unnecessary constant casts
 to u16
Message-ID: <20250711182542.056ae1a0@pumpkin>
In-Reply-To: <e199da76-00d0-43d3-8f61-f433bc0352ad@jacekk.info>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
	<e199da76-00d0-43d3-8f61-f433bc0352ad@jacekk.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 10:16:52 +0200
Jacek Kowalski <jacek@jacekk.info> wrote:

> Remove unnecessary casts of constant values to u16.
> Let the C type system do it's job.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: David Laight <david.laight.linux@gmain.com>

For all the patches, perhaps changing 'unnecessary' to 'pointless'.
All the cast values are immediately promoted to 'signed int' and
then possibly promoted to 'unsigned int' depending of the type of
the other arithmetic operands.

> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
>  drivers/net/ethernet/intel/e1000/e1000_hw.c      | 4 ++--
>  drivers/net/ethernet/intel/e1000/e1000_main.c    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index d06d29c6c037..d152026a027b 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -806,7 +806,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
>  	}
>  
>  	/* If Checksum is not Correct return error else test passed */
> -	if ((checksum != (u16)EEPROM_SUM) && !(*data))
> +	if ((checksum != EEPROM_SUM) && !(*data))
>  		*data = 2;
>  
>  	return *data;
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> index f9328f2e669f..0e5de52b1067 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> @@ -3970,7 +3970,7 @@ s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
>  		return E1000_SUCCESS;
>  
>  #endif
> -	if (checksum == (u16)EEPROM_SUM)
> +	if (checksum == EEPROM_SUM)
>  		return E1000_SUCCESS;
>  	else {
>  		e_dbg("EEPROM Checksum Invalid\n");
> @@ -3997,7 +3997,7 @@ s32 e1000_update_eeprom_checksum(struct e1000_hw *hw)
>  		}
>  		checksum += eeprom_data;
>  	}
> -	checksum = (u16)EEPROM_SUM - checksum;
> +	checksum = EEPROM_SUM - checksum;
>  	if (e1000_write_eeprom(hw, EEPROM_CHECKSUM_REG, 1, &checksum) < 0) {
>  		e_dbg("EEPROM Write Error\n");
>  		return -E1000_ERR_EEPROM;
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d8595e84326d..09acba2ed483 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -313,7 +313,7 @@ static void e1000_update_mng_vlan(struct e1000_adapter *adapter)
>  		} else {
>  			adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
>  		}
> -		if ((old_vid != (u16)E1000_MNG_VLAN_NONE) &&
> +		if ((old_vid != E1000_MNG_VLAN_NONE) &&
>  		    (vid != old_vid) &&
>  		    !test_bit(old_vid, adapter->active_vlans))
>  			e1000_vlan_rx_kill_vid(netdev, htons(ETH_P_8021Q),


