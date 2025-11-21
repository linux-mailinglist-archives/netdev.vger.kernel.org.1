Return-Path: <netdev+bounces-240750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA65C78F48
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E45B34ED90E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76775346785;
	Fri, 21 Nov 2025 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/BPqc2y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206B3176E1
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726992; cv=none; b=jxjCFDvrQXBHTMA93w62qeaxd+me6Uxzmmju9FxZl+R5oQDX3KQ5UdqpBJkza696JaOwcOt0dZ9mJDDFiwBmPVfYnoRPZ+UVE9FlQVUc6SQoKLFvoKU7MIaeW39OK9i9RNA28mim2qQj+APoINkHdoFiFvA1c0bi4+rwitEgBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726992; c=relaxed/simple;
	bh=gJ2JRo6SXwLf+9ulGbyK8L9kKPy5BDeC3fsCzHtzVM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FocJs2OZr4dLkaxEpooU9KdSYMf8c8cTsCmL8ruG7kqflAiGyL56ntsu874evDTFJ3whDoJRPU4RFipuAPZKIoSed8DPq/+/AoB+/j+L+04S9oS2T5uiVnnnjqeVGulEJokaRRfdiCc0bxa2p4+BU07uZIVdspM0prCqy9FECYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/BPqc2y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so1125969f8f.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763726989; x=1764331789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOhuD3FYN2lFcG6XYARt5Zef8vPJNg6JJcAtWMIQOK4=;
        b=L/BPqc2y7KdE7VWgXGaege02CJn6LVe58B8ZUhaFcIvuNUUQbq8XURaOnl7wO3HNjW
         t6bhtwMLCvMueZ3S3gLiM91/Ppoa6Sp0eqA42scpM3gjkI0MB01vSP6iXf1BdImW4Wv3
         as/vlvGKkFs6Sal5OZSHoOhZx7MGCBvmR28CxZ3Vxer5Za3j3LAXXNADGASHHdFLMpXp
         cWewvmNvP/SbYsUXXNL3R6mNRKX/EhGGH3ZbIzi9mbO2fte49nRkcsk7MZ0UHDtWSjdD
         Gz2XdMRmGa1/2zaFY4QW99tNtwR1ihlOki9/W/2DPwfOqynIhC5qNfwH0Cc+RhW/DcnM
         zBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763726989; x=1764331789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOhuD3FYN2lFcG6XYARt5Zef8vPJNg6JJcAtWMIQOK4=;
        b=Uv1c20Ec1om6FaowCBBptRIMeg9tBaSScnUlUCHg369vPE2qLiS8pIoqJNRhqS0l0D
         bKZ6nwrMZ3xhSG+VvKuztwkF2Yodu9Oa3ysbZyv7ZhsroTAdYX8tooCsASrrQVvF+Y4C
         XY+E8JowBBR2boBiOB0jdInfBeogN8GfkogoMGEZLCptW7VUkwBdNx0hG92L7ZF5jGjF
         SlLZhxnw5We0fTf4bSFOs7Adm9djLFUE+aFg9EfDmKQYs11BhbDhwWk8ZMghOtG6fhw/
         ogjq+yH2jgZ5BST/eO+Tuo4q8h0OjtVANlXTwVvcn71hONuVC390A5w3K03iw127eSIU
         W+VA==
X-Forwarded-Encrypted: i=1; AJvYcCVOwHGs3tmeplYsG/ZlM2HTsX2g5geU5GvKuzeD7Cs2CXD4X7vrI+sgJTzoEFN4a10O17XgTv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRNeZ3zunhs7p71Bqz5YjGZLwL7IPLXvpKIwzJ1aTJIXG9/Cs
	M60p3htT7oK3OncBL9jcJcFH8YhoePwASGrDdgN9PtBfKwHqvm6jysMk
X-Gm-Gg: ASbGncvWVL3stdqK41/4qfhrE8RonLNxiEKY1/VDwtXsaSFWk3fMb8HuDAulffNJBoa
	Ja4TEZJBODu7L1kvCLonqcIr9jf4f7D1FijKAW8Dct7mrAbWsAPdHnoG9qV5+lhYsG/C/ilMeMW
	uz9NddMP9mqohJOxBleBdMRwv5Yih3b/C+Yflq265cgTNwsnzXLRFTBsVXJ659NI6XLpmYMMySS
	Riw6qMgciskduSx8cWYd4OaXDQKKYk9s7kuxEDwV360yLP/q2kNdkQUQDkpndtMRJ2fj313GJhi
	HbqIp7OJVfCOaC7idYaYOYmwC8bdMn5pEJ4zb3olR/VT2AgPsEHIFIRM9qN8hCQjIZggyEgPuFe
	laZnP8qpjYs1+gbmo4Mbr2eVioIhrbfw/d3AhvZa9TbrGEjWf4E68wNGVu0LGYVz/dSlV/eD4Rx
	7nFeRUGV8/0Ay4o8wpHBUhL1HUAA==
X-Google-Smtp-Source: AGHT+IH8n/QkOXtXGlOicb4wsLtjqPV6gsrQePDU0F8CvJviDa7jL2c2AmKQvd/w+gkVUIyGcvOD9A==
X-Received: by 2002:a5d:5f96:0:b0:42b:30d4:e3f0 with SMTP id ffacd0b85a97d-42cc1cf0fa3mr2085273f8f.22.1763726988710;
        Fri, 21 Nov 2025 04:09:48 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8d97sm10293196f8f.42.2025.11.21.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:09:48 -0800 (PST)
Date: Fri, 21 Nov 2025 12:09:46 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
Message-ID: <aSBWiuivrPG8vNKw@google.com>
References: <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch>
 <aRxTk9wuRiH-9X6l@google.com>
 <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch>
 <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>
 <aRzVApYF_8loj8Uo@google.com>
 <CAN9vWDK4LggAGZ-to41yHq4xoduMQdKpj-B6qTpoXiy2fnB=5Q@mail.gmail.com>
 <aRzsxg_MEnGgu2lB@google.com>
 <CAN9vWDKEDFmDiTuPB6ZQF02NYy0QiW2Oo7v4Zcu6tSiMH5Kj9Q@mail.gmail.com>
 <aR2baZuFBuA7Mx_x@google.com>
 <22b15123-b134-467c-835c-c9e0f1e19e29@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b15123-b134-467c-835c-c9e0f1e19e29@gmail.com>

On Fri, Nov 21, 2025 at 12:17:33AM +0100, Heiner Kallweit wrote:
> Could you please test whether the following fixes the chip hang on suspend / shutdown?
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index de304d1eb..97dbe8f89 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1517,11 +1517,20 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  
>  static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
>  {
> -	if (tp->mac_version >= RTL_GIGA_MAC_VER_25 &&
> -	    tp->mac_version != RTL_GIGA_MAC_VER_28 &&
> -	    tp->mac_version != RTL_GIGA_MAC_VER_31 &&
> -	    tp->mac_version != RTL_GIGA_MAC_VER_38)
> -		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, !enable);
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_24:
> +	case RTL_GIGA_MAC_VER_28:
> +	case RTL_GIGA_MAC_VER_31:
> +	case RTL_GIGA_MAC_VER_38:
> +		break;
> +	case RTL_GIGA_MAC_VER_80:
> +		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, true);
> +		break;
> +	default:
> +		r8169_mod_reg8_cond(tp, PMCH, D3HOT_NO_PLL_DOWN, true);
> +		r8169_mod_reg8_cond(tp, PMCH, D3COLD_NO_PLL_DOWN, !enable);
> +		break;
> +	}
>  }
>  
>  static void rtl_reset_packet_filter(struct rtl8169_private *tp)

Yes, patched it in and tested on both suspend and reboot without
touching the wol flags, seems to be working correctly.

Thanks!

