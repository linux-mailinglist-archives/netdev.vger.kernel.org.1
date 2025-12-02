Return-Path: <netdev+bounces-243263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51445C9C5DD
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 228CE4E05AC
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA9A287503;
	Tue,  2 Dec 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqUCqN0M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7805E220687
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695947; cv=none; b=HnENqLf8Tx15MQ1QSZ1t9ECKDoEd0hREqCDatYOIf8Uckt/qaNf1JBD2PchW5ofiTDGtPbihm5nwn1digynR0LZuTAUZm3xlvvOHqWCQJCBQAyLXpFN6P0pWMk/fplxfelEFDFugNN3n+S3F7NKbf3m0ULMFsK6jhayQH7qQzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695947; c=relaxed/simple;
	bh=3L2X0wj1HI7FNqAbeyc392uRVEygWnjK0lNxLfNjAcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko506TDL4KIxsWxzouuqyUd5NWTOePEl1BIIfAP1/yV/VmE0gJ7rvzo8WOEBLnfKKlkYhGFEUSfjCCpPTkfi7DJTfLWkMFfxvE1zqj32ZhZHnzC6ZCPn4sqUYyhkz4AI3QIJkRt9gJtcHsGB/j8HcejTHGe/lxZ71Y8UxECpfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqUCqN0M; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477aa218f20so40018895e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764695944; x=1765300744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONQiAUNbq1B7VjfKoxmMpF78LuEt7AN3CQNku7TFZ5A=;
        b=JqUCqN0M8vsakTkoftFjlC4o17x6yusYJMHj+ZG+hgyP88hy1WtKBRcLWoJYo6ze19
         TlzHPqH6jZVsyi1zDQeKnKU3JeG+bo7aqKWRGnd2bGTsYM6k8t2816IJCP+azoENMVQH
         JuSE3ZUm140bC19rIWmUHumsxNq3nMWl8f53ESsUugVJIlbH3QD/jrKy6tZNST1WISxU
         OpxPbwmvPQZc+AVE1MYBB15QF90FIMY/UoX6PYHZyRl27/BNET3Jgk5vFHLT8UJM/qcj
         3zojb2abFhfI1SPfuL33CExj4RAePiGr4Lz5GOPm0FFjvqlT4BFI5NKyVWcpghQjGyMG
         sztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695944; x=1765300744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONQiAUNbq1B7VjfKoxmMpF78LuEt7AN3CQNku7TFZ5A=;
        b=DVSsUVkEGl8hbaFLFM2uvtIKLwGPBH/FZBjie4Pc8guh7VyMr1Sk71DG+mAepxSp0+
         sfgc8YkyDlskPlR95TiRuT1LcxLNChB80JTAYpmONhH0CFrclei3hA4E+JAVFxtHFzX+
         vVcwkG6jgNg+JwpH6LEZbvVDSZancECYt45SNUW/y6zp65lzCFb9ult9gCRMawQ6L1JQ
         X4VYu5TERkZ1Wg90wcHRUTytRX+uwK66oC6GlPjcRQzHr1BBXEY4GL8o8sf6lcPW7xns
         bgYDligF4vb+YCIoCAXZZKlUfj87qcCAiYFjwWQ+q76znVsNdufTWBCvehbFoVKyZ4QF
         NFQg==
X-Forwarded-Encrypted: i=1; AJvYcCXLuRKAsnZ/YJ7yF2nNN+Yq9/IGZC3BLEiItrFqrTUOh2A6pgW+m7Y9YiKDc8K9jB6zWuOX7p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyAn/UKTVIXiScL0mdkl8vccRLv35t1EU7OUJWwWrdmWSuzu59
	amcI7ru0XAWoAn6gy6Rm0O9PwC6L5GBf5BhTm4lOdQDjDIhGuItqxL0c
X-Gm-Gg: ASbGncupOqneJk9aTd/qht59SxueTYrPHMORpzK0D4mvjkrzNlCceObNR1hZUttJ2yQ
	30IabC4/3dHSVuR2NPlQ0ozv7TBzYbNixDC9Zsb6wX6fnDNud41pPAABk9zM3MUaUf/s3DWhpdw
	HEVGqyT0ZXIpZFYtmdsQyUS8g0YviFzBViLtxEQadUFlOKWN5iIrT4WRRH276KSot+QR59aZPwF
	QYJS1HCycgwVYQlCYSzl4Jp8A+NHc1oR04bzT68sPcOypxTYXq85eTImMpMyC4zjQ6K5gKoyuwb
	iBneUPcUaJ8oMbzX4Fr6RD+Vm6c9tT5QfYASEAg+XuSj1JsR2IaQ5g3OX0k+/Y10TqzfpejCwpa
	p7tdNt35d+P68cj6A53Y1PxAILOnyxVJfZtfz3XRmtbLo6eTT4lZ8eWo1dugt9e71iQJesGC32q
	s8/qiVotyIuo0Hj51St8cSyxgt+sukn5CW5M3DOEmFvOK77+fEWpXlOL8d3v2fWyfGOrm26tNj+
	J0UX6cf/1rP48AOFhE9tG6WblVQAOpvCnAetGUzrG2g/uMdmEWscQ==
X-Google-Smtp-Source: AGHT+IH12Xi9h8YGsFoPdyrLJyBGsbekwWS9o0ZEXCMsh8eltZaGR+ioYmIu2Ia4X5EnwAqfcU+ASQ==
X-Received: by 2002:a05:600c:154c:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-477c0165a5cmr405613505e9.6.1764695943382;
        Tue, 02 Dec 2025 09:19:03 -0800 (PST)
Received: from ?IPV6:2003:ea:8f22:cb00:61e9:ed14:30da:92bc? (p200300ea8f22cb0061e9ed1430da92bc.dip0.t-ipconnect.de. [2003:ea:8f22:cb00:61e9:ed14:30da:92bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0cc39csm385515555e9.14.2025.12.02.09.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 09:19:02 -0800 (PST)
Message-ID: <8b3098e0-8908-46cc-8565-a28e071d77eb@gmail.com>
Date: Tue, 2 Dec 2025 18:19:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>, netdev@vger.kernel.org
Cc: nic_swsd@realtek.com
References: <20251202.161642.99138760036999555.rene@exactco.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251202.161642.99138760036999555.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/2/2025 4:16 PM, René Rebe wrote:
> Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro WS
> X570-ACE with RTL8168fp/RTL8117.
> 
> Fix by not returning early in rtl_prepare_power_down when dash_enabled.
> While this fixes WoL, it still kills the OOB RTL8117 remote management
> BMC connection. Fix by not calling rtl8168_driver_stop if WoL is enabled.
> 
> Fixes: 065c27c184d6 ("r8169: phy power ops")
> Signed-off-by: René Rebe <rene@exactco.de>
> ---
> V2; DASH WoL fix only
> Tested on ASUS Pro WS X570-ACE with RTL8168fp/RTL8117 running T2/Linux.
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 5 +----
>  1 file changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 853aabedb128..e2f9b9027fe2 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
>  
>  static void rtl_prepare_power_down(struct rtl8169_private *tp)
>  {
> -	if (tp->dash_enabled)
> -		return;
> -
>  	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
>  	    tp->mac_version == RTL_GIGA_MAC_VER_33)
>  		rtl_ephy_write(tp, 0x19, 0xff64);
> @@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  	rtl_disable_exit_l1(tp);
>  	rtl_prepare_power_down(tp);
>  
> -	if (tp->dash_type != RTL_DASH_NONE)
> +	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
>  		rtl8168_driver_stop(tp);
>  }
>  

Patch itself is fine with me. ToDo's:
- target net tree
- cc stable
- include all maintainers / blamed authors
  -> get_maintainer.pl

--
pw-bot: cr

