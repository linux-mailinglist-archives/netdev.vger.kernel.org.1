Return-Path: <netdev+bounces-174848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F347DA60FFB
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3418C16F669
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF2A1F4288;
	Fri, 14 Mar 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSFJFj4u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67871F1818;
	Fri, 14 Mar 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952002; cv=none; b=EYyO5GKaQGRhQs4QNNCDU/I0GBko4mpoc/GyO76AmUAfkKLXyRjr27aTijyyZSkMNzRqtVQoNQigwty1R1GwMXv6UFk8fZ1WiCysbSgLEsOhh4lib6uBQw8lAYKrceJQXr+kZOXH7wyFAPDv47Olsb97VBXj+MP1WZEUd8LqPSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952002; c=relaxed/simple;
	bh=e2vbOHLt7ldmqEIZlKr3k/tQ8Ks5OMo8a0id0FE39iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbkwBG4zuMnVxoqOw8aNLaHGeVllTPaR4AX/Z+k3rOVmxxMusyBdrh6iqMWYRa3t84mLdYUyNnAN4pf7r3ky6n2WKZRQE/SwgLzIWy/0WTZ3Z2Qz3ORQWyUPbc/AhdlDRkqI8xwmH/17hVtY5vskvvqDhtm0igBwciQwxojDlLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSFJFj4u; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913fdd0120so1104582f8f.0;
        Fri, 14 Mar 2025 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741951999; x=1742556799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PVxcOvygfG8CHgKMUZuovi6TFAONrrhe9j6tvCE6gI0=;
        b=DSFJFj4upHDQO2wPca0hNySy2NRZVWIfm5fBEe4WM7Ac/NROIeOo1LX6+t1sJpOvAW
         7YCSuUfwXT0/s5jP9RI2txgDyd7sh+P/SrdO0BzKYvOpqrlu5fHBdRjPboU4VRoisbED
         54dvu9JzvXjqkQCSJYXLRmB9nirMQqUEyE5QsqbLozbQyZMFNwfqfvAvkQr1P1gfV1Fn
         Ss0wwqQ7wfvVOhTEQrxJ/eUuWNebMnIXqyq0eA+LjrzflcrpLCfHGZISJMcDQfmFnhS4
         xFZyGIkMmWboAA5XKi0kN4WhpAVD0is/uf7XquUeJS8M3Ra2Tb5jzCsuDCGRcpKHfoqy
         S84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741951999; x=1742556799;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVxcOvygfG8CHgKMUZuovi6TFAONrrhe9j6tvCE6gI0=;
        b=bYXq/uA54pSPH1cl3Ezs5LP3OeRernfLQtu9v2b6OLBeure+GnqbdoJ8zHmKnFtPbl
         owrqiyifjpt08nq+feW4AsUifAUozSQyYn0ypgP3VXc0O/2xNhcfQMHbXPcYk2IYI2/+
         wKtVKh/rbfu+pOGd3+5GxxiUQQbE+nJcW3OMkK+WK9H9bDgdi7OeQB3ikwrAY0yCG3//
         Bhx/NW54kzHxesSNHJ3IcsLSdqSMB4QmGjupOElGtmW7Gzkg7+hKaoEMP5GYqJ16OYFm
         09gvf2CCgP871I3ARu78qLjwoXO3f1zdKEKcM767JqJM1nR6e8RMmHb/IcvvyRChYIHl
         7H5w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8Ssidp7mtYmB6zYd+ZuIbqjX4syaXJsCzGjULNH6KXNPJ31PcoIL8o2lJtdTSOtLvQ/CVcMgiMBKL6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPjgTeEdRBlfQgxtuc8WZ6oGK1jfgQPVIlXeOJAyBQPEzcK4F3
	ptL0wm7aLNc0ubhIFtjTmhJuhxs8/h/rTbUyyy4T1H4NaSSmBGc3
X-Gm-Gg: ASbGnctSSak7pS04Zk56gPbmWxabdT3R9Hj+eU+W7HpZAMFi0y617IM4dHDGGRRzX3S
	cSZcivJU4SSvEosSR/eCRgzbJw9qliEh7YxpTOkSlS8dhTIuWrlphRSowloiNPUzpKEdHwJAJnt
	fnj14FBsANgeuyfna9ozNzsXC4ElL0Oiu0Jn1wiHhPpx8cO/MGaa0Cbxqw+0ZXBWWvdst341vRH
	klJOWjpfiwOSsbUSDuYHl0vbkGc72HDg/SMl5EsLAGCjhAqmSsQrBR93EkYy3KNwL15pLZFZXrS
	JCK78hIjdGFqjxawEuS3OKwui0ihWOZjDFT4AJo3kanQHrkV9CEW2nY/Kb8ayAsIHJ2FKw+QMUW
	qKvU/EQPHX5OpwG+++cCBZfnzBXjoK3nnQy77L6OWfsAgxdEvTNMY2Xia+gyxt8eE2t05y6bOk9
	fdzV2P1Diog4f/fZgBIobqBLsAFog5yFrfKg==
X-Google-Smtp-Source: AGHT+IFinYC2sZnzhAmOU9xmOX9dgX1rwM53QDrgbGAXrShy21SKX+QnCfot+G8dIqJWvF3Ge9ukNw==
X-Received: by 2002:a05:6000:381:b0:397:8ef9:a143 with SMTP id ffacd0b85a97d-3978ef9a95amr1143409f8f.23.1741951998898;
        Fri, 14 Mar 2025 04:33:18 -0700 (PDT)
Received: from ?IPV6:2a02:3100:acc2:9400:c68:8c54:c04c:f0e3? (dynamic-2a02-3100-acc2-9400-0c68-8c54-c04c-f0e3.310.pool.telefonica.de. [2a02:3100:acc2:9400:c68:8c54:c04c:f0e3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c8975b34sm5315454f8f.55.2025.03.14.04.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 04:33:18 -0700 (PDT)
Message-ID: <ecfc71d3-47b6-4f17-b081-69452e7884ac@gmail.com>
Date: Fri, 14 Mar 2025 12:33:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] r8169: disable RTL8126 ZRX-DC timeout
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250314075013.3391-1-hau@realtek.com>
 <20250314075013.3391-3-hau@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250314075013.3391-3-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.03.2025 08:50, ChunHao Lin wrote:
> Disable it due to it dose not meet ZRX-DC specification. If it is enabled,

dose -> does

> device will exit L1 substate every 100ms. Disable it for saving more power
> in L1 substate.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 3c663fca07d3..dfc96b09b85e 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2852,6 +2852,21 @@ static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
>  		RTL_R32(tp, CSIDR) : ~0;
>  }
>  
> +static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pci_dev;
> +	u8 val;
> +
> +	if (pdev->cfg_size > 0x0890 &&
> +	    pci_read_config_byte(pdev, 0x0890, &val) == PCIBIOS_SUCCESSFUL &&
> +	    pci_write_config_byte(pdev, 0x0890, val & ~BIT(0)) == PCIBIOS_SUCCESSFUL)
> +		return;
> +
> +	netdev_notice_once(tp->dev,
> +		"No native access to PCI extended config space, falling back to CSI\n");
> +	rtl_csi_write(tp, 0x0890, rtl_csi_read(tp, 0x0890) & ~BIT(0));
> +}
> +

Does the datasheet have a name for this extended config space register and bit 0?
This would be better than using magic numbers.

I think we can factor out the extended config space access to a helper. The same code
we have in another place already. But this can be done as a follow-up.

>  static void rtl_set_aspm_entry_latency(struct rtl8169_private *tp, u8 val)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -3824,6 +3839,7 @@ static void rtl_hw_start_8125d(struct rtl8169_private *tp)
>  
>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
>  {
> +	rtl_disable_zrxdc_timeout(tp);
>  	rtl_set_def_aspm_entry_latency(tp);
>  	rtl_hw_start_8125_common(tp);
>  }


