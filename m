Return-Path: <netdev+bounces-262918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHbaEngIpmmRJAAAu9opvQ
	(envelope-from <netdev+bounces-262918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:00:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A3B1E47C4
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18D04303289B
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233331A680F;
	Mon,  2 Mar 2026 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBxylK4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0110390999
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488389; cv=none; b=I0SVAjVzUYtJwJEe4xTvGoUGvt0zfYmof38Hq0w78po73Zcc6caTh4WnG3HoFrEBU4Zd8SSmtO3TomwyggB6W9tab6BFOXWHROSyuFgAS81WkbLCSAE57gCPzwN/dk2wpXZnwz7Gzn0unqlVqW6Iqgm1QQDiS5tFfH0T0iFrnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488389; c=relaxed/simple;
	bh=bwEvxpAEm+X22Rl8nyLqVwxvx5dL7xamDWG+YAYGF6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEWRgvVss5UTl+aiMEPNhRC9R7iCT0E4N0LjdV9F1lQSR53uH8zIf6F08KWPd+BUbe1XDiTOf5ghkSD9h5+ctu3WFYJX+s1jIrzLRtbXG/7Pkw1emxpDZLWSiVlZLOQIjVCAn/popZFlohIihBkNpp4XLEevALUhzLn08wIMqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBxylK4k; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4398f8e2837so4280842f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 13:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772488385; x=1773093185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Lsx2ASJVieIDdeZ0KxP0L4PgMVY7vbiPkxWiKajNO8=;
        b=HBxylK4k+WoFSmszdVlk8/QsXwV0SMf4BlWM+mEtzmP5Qm37xrX5N8Ijsw8q8BWpNV
         ta6A8+xFs2lFXlaqCdCjO2BurE31uc+Uv/C9Omgl2xftmARRc4ylK8qWTRyIAkjGAuOq
         iMxBze2lVgcKXnh/Ndzb/SntSPG5Clj9Mf9Y2RxlK031jRLnPl5YWO8diHtoBB3H84pv
         OT2CRTmc6dPGHPxODtIH0swsKSu4CZe/U0OTJGWmvFuGxXBTW2/033Ze67FmKDHXDnuU
         ouyi55KZjpvJfZgS703+iunAUgRhKiYzHRTILi6kv6/6DTQo4RgsMgRxo2hITvamR2p0
         YE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772488385; x=1773093185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Lsx2ASJVieIDdeZ0KxP0L4PgMVY7vbiPkxWiKajNO8=;
        b=nXahixscX5Jeo/Yf9kSc7xCB+eC2bl38eNbFjMaPbWYcTZGGjK9/fUnmjFyrxeqENA
         53AgM+Jq4rNRXfq0wmM3PciSGPq0rlV5TCAicWtArX/H9o09izPPFK+VVpZTGcQaj4/w
         +LDwDMlRVtb356mRlLRg1ZAgwy7h13WMyNjw+WV5f/C5mVueMRu0mUt7rcxhHaDln7cN
         2nqK4M6JIG+mgbaN6TvieiYr8gIY30LfSS/Ae6TIHYPj+NR4Opwe482UzduS2LFQcaOO
         pOHRRPL0CV1giUzfriTytRjx5QcikM4L+uB5/NfDGVvE5jhUzm9DDc01taaMF3V8Jx1x
         OQUQ==
X-Gm-Message-State: AOJu0Yx+CJMAjW/tP2R7UnswrkYzUzLOl91HUhTfQFLCXWM1JuLqpLQV
	tL88dXwFf7eTKajnzUGuB/j0rK8IXrcTmP6U6R1sTkiDRyAJjn4qurES
X-Gm-Gg: ATEYQzyJRPMg6RwBlye4udCRKXiFRdcP09lywbqlnUS3KJan4tC6QNLBlOvPuMh74rK
	RCloQToJjplomHY8H+SoHymFVt7RoBon9TWi5CtykPUNkvxz4fAF1W+R4rZ3SPcIX1sACY8WiJn
	gONqPSDGdZsZo46iXfNiZN1PTlhyrGia27r/zI8Aqxahd0H8Mn1bcywb8sErsPyj7+HXFPr76FJ
	Gk5lVgXNkj6FAXh61Muq8Da8WKaerfHlYX1fVXocbStzLAWFsKUkE7OR9/U6ZDXtljckvcYhit1
	9feM57n+bZFH6ge/qSPphmW6ntDf1hp0mx+LN0nZeBiphCZ/cBCTmjxUwYSqtF4JffWcBkZPrAS
	9wsIEa5fdJS098k1YFjiN7tinVqGXj16O944A+YgOR68IyXiB2rIP73LSXmbop9bXKWh+IDrjBx
	jqMqT6TLbHO02E/cba+ypZ01sh48PHBx2c1n1YIWKiMulhOvzm71fsTEfqQGG+zfR6/YbdiLZ5t
	Ek8s/RinKsUsGzYen9ZKwwAgHg+CSoNomVvoZXODepo8awl7tyaiqYmVNK+FQH9Bg==
X-Received: by 2002:a05:6000:25c1:b0:435:94c1:3714 with SMTP id ffacd0b85a97d-4399dd6bd16mr24586323f8f.0.1772488384819;
        Mon, 02 Mar 2026 13:53:04 -0800 (PST)
Received: from ?IPV6:2003:ea:8f29:3b00:7d0b:dcf1:6608:9853? (p200300ea8f293b007d0bdcf166089853.dip0.t-ipconnect.de. [2003:ea:8f29:3b00:7d0b:dcf1:6608:9853])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b3cc2e65sm14237418f8f.2.2026.03.02.13.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 13:53:04 -0800 (PST)
Message-ID: <9b6aeead-4e60-4df4-8aaf-b07ab2c99d46@gmail.com>
Date: Mon, 2 Mar 2026 22:53:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 4/4] r8169: enable system enter c10 with
 RTL8116af
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-5-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260302063215.1790-5-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E5A3B1E47C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262918-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realsil.com.cn:email]
X-Rspamd-Action: no action

On 02.03.2026 07:32, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8116af is a multi function chip. Function 1 is load with r8169
> driver. Function 0 is bmc virual driver which is used for power
> management. This patch set Function 2 to 7 into d3 state when config
> hw_config. This helps the whole system enter c10.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 95 +++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 787859b0ab68..d8ffc76186b2 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1121,6 +1121,100 @@ DECLARE_RTL_COND(rtl_ocp_gphy_cond)
>  	return RTL_R32(tp, GPHY_OCP) & OCPAR_FLAG;
>  }
>  
> +static u32 rtl_other_csi_read(struct rtl8169_private *tp, u8 multi_fun_sel_bit, int addr)
> +{
> +	RTL_W32(tp, CSIAR, (addr & CSIAR_ADDR_MASK) | multi_fun_sel_bit << 16 |
> +		CSIAR_BYTE_ENABLE);
> +
> +	return rtl_loop_wait_high(tp, &rtl_csiar_cond, 10, 100) ?
> +		RTL_R32(tp, CSIDR) : ~0;
> +}
> +
> +static void rtl_other_csi_write(struct rtl8169_private *tp,
> +				u8 multi_fun_sel_bit,
> +				int addr,
> +				int value)
> +{
> +	RTL_W32(tp, CSIDR, value);
> +	RTL_W32(tp, CSIAR, CSIAR_WRITE_CMD | (addr & CSIAR_ADDR_MASK) |
> +		CSIAR_BYTE_ENABLE | multi_fun_sel_bit << 16);
> +
> +	rtl_loop_wait_low(tp, &rtl_csiar_cond, 10, 100);
> +}
> +
> +static void rtl8168_clear_and_set_other_fun_pci_bit(struct rtl8169_private *tp,
> +						    u8 multi_fun_sel_bit,
> +						    u32 addr,
> +						    u32 clearmask,
> +						    u32 setmask)
> +{
> +	u32 val;
> +
> +	val = rtl_other_csi_read(tp, multi_fun_sel_bit, addr);
> +	val &= ~clearmask;
> +	val |= setmask;
> +	rtl_other_csi_write(tp, multi_fun_sel_bit, addr, val);
> +}
> +
> +static void rtl8168_other_fun_dev_pci_setting(struct rtl8169_private *tp,
> +					      u32 addr,
> +					      u32 clearmask,
> +					      u32 setmask,
> +					      u8 multi_fun_sel_bit)
> +{
> +	u32 val;
> +	u8 i;
> +	u8 FunBit;
> +	/* 0: BMC, 1: NIC, 2: TCR, 3: VGA/PCIE_TO_USB, 4: EHCI, 5: WIFI, 6: WIFI, 7: KCS */
> +	for (i = 0; i < 8; i++) {
> +		FunBit = (1 << i);
> +		if (FunBit & multi_fun_sel_bit) {
> +			u8 set_other_fun = true;
> +
> +			if (i == 0) {
> +				set_other_fun = true;
> +			} else if (i == 5 || i == 6) {
> +				if (tp->dash_enabled) {
> +					val = rtl_eri_read(tp, 0x184);
> +					if (val & BIT(26))
> +						set_other_fun = false;
> +					else
> +						set_other_fun = true;
> +				}
> +			} else {
> +				val = rtl_other_csi_read(tp, i, 0x00);
> +				if (val == 0xffffffff)
> +					set_other_fun = true;
> +				else
> +					set_other_fun = false;
> +			}
> +			if (set_other_fun)
> +				rtl8168_clear_and_set_other_fun_pci_bit(tp, i, addr,
> +									clearmask, setmask);
> +		}
> +	}
> +}
> +
> +static void rtl8168_set_dash_other_fun_dev_state_change(struct rtl8169_private *tp,
> +							u8 dev_state,
> +							u8 multi_fun_sel_bit)
> +{
> +	u32 clearmask;
> +	u32 setmask;
> +
> +	if (dev_state == 0) {
> +		clearmask = (BIT(0) | BIT(1));
> +		setmask = 0;
> +		rtl8168_other_fun_dev_pci_setting(tp, 0x44, clearmask,
> +						  setmask, multi_fun_sel_bit);
> +	} else {
> +		clearmask = 0;
> +		setmask = (BIT(0) | BIT(1));
> +		rtl8168_other_fun_dev_pci_setting(tp, 0x44, clearmask,
> +						  setmask, multi_fun_sel_bit);
> +	}
> +}
> +
>  static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>  {
>  	if (rtl_ocp_reg_failure(reg))
> @@ -3785,6 +3879,7 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>  	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
>  
> +	rtl8168_set_dash_other_fun_dev_state_change(tp, 3, 0xfc);
>  	/* firmware is for MAC only */
>  	r8169_apply_firmware(tp);
>  }

This is the type of code that would make r8169 become an unmaintainable mess like
the vendor drivers. Why not use standard means like pci_bus_read_config_word() et al?


