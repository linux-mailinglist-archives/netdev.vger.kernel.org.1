Return-Path: <netdev+bounces-288670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDbBFczqCGpD/QMAu9opvQ
	(envelope-from <netdev+bounces-288670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:08:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF555E0C7
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBDAF3023D91
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6C388398;
	Sat, 16 May 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmT/1njS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC1389114
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969248; cv=none; b=H8wgtvp55HZM7bEMMl1En+1Mppbh5YsNQ38+DLf0qO40ODAMGKzHSsiko7OcSKigqYE+Ud8HcdUKYnGNNnCjOON277F+XzowyAz/7V6vryr60TK6LS/IwuKgIXwON+weg/acDeFP/7mCwohbOJVAMa8GpP7+XsNYOfOmS01nwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969248; c=relaxed/simple;
	bh=yhT95txJb1Cc9HZPGxDF285UONo14ejc5OBtMSTB+j4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BNJARksc1KiH5G/oq6LgTijq2wfVAijbOpa8z5e/cENxmrxmZj3JdwPuLKbb/6/Urf+y/M8UuV7t8+GTChPt7JjMvMNMcoBIR6gegjGaXPBI1JESDUMuZNZHULzui8QLr3+shmSrwxcJQaB1wd18TV+moBFPY+mYt0bMn3OTjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmT/1njS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so5037125e9.3
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778969245; x=1779574045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2MJj1hDHj+cAXEsL46l2qx+KCbappLncGLoqcMmWMrQ=;
        b=jmT/1njSK89IcyJRA9hwDPGmDjtCrlwzBWeQ8hQsloBmF0ezc4XJTcE6TsNKrPiAZG
         DK/8LVjWGuOgduWOG8KDePR73jbqtUMrAbrn/B0v3WzITxwbV2q28Cy/P5KfiXYqFCBl
         jkJujWg6Nf1PwIQFal3dnNY93zwHhS0DTCux7bQ5CaaQinNr/uG5433oZDMPmdA0Kpf9
         WFyV1awtDpFP9+wwfQov3h9iw+gFe1viOjHDeoUkK3Wq2eCICGHUyAe5UwtxsPSxKEXZ
         wE6/ZDI3smDM4KBIJDH/X70f4bj5C2eIkLaEBxXdPj7EUDHsifAovqFUIsagV7p0oZ/u
         i0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778969245; x=1779574045;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MJj1hDHj+cAXEsL46l2qx+KCbappLncGLoqcMmWMrQ=;
        b=qe6V+AaYKNY+7XCH3OVDWEmnga7gC9/eC39DHmgLOHlF7C6FvzvV3ZI1pYwLjqROn4
         9Suba5p0/Ub/fjA1SN/NDwyEuVY6CNKsedd1Oiw3ZZDCLBV3RJT7oq4yM6EQAOP+xf3H
         AhatQdjhkjzKOTeOl7Lx18q4DvIf5NwallGH3IZrBepF6LOcr9KXPyMpaHNGGcrw8Kc9
         YNHM5Jcx0M9SMDjt9oIKQerU0yEBEb897PKqGUcIZjWM3HgGZLTBpQxa1Qt+7tq2zMYH
         uJqJIBfvKuXxdfTZMmXhQunRj9l5YloMGt62BGjMkmgKUwB//vltKtNXyAUChsvGUZdt
         vEXQ==
X-Gm-Message-State: AOJu0YwybNAsN6mT7qmWsyIKQjjNEhsXacQ2eUIcEOIT6oHtzpLfc+8J
	a/njcac/IuIlnfHpGxjZbIIP6cGpP+yVbTzMEZknSsh4W+L/kPu6z9mlMvyldA==
X-Gm-Gg: Acq92OFWQ8tmSJX6Nvq/4TuDTPdGA8iVWlVbGUb3j9Vb537laCh43WQYO0Q2BfrzEWp
	g68w6KzGgjKnuWFW+7EToyM7jis6xjeA2IE+acApD5DgrCw7MwvCm4DLS9KOGHiXoKkRo9wzGT/
	07/BNe7Ab3pOX89GVWyPHU4CWd40zeUhwHUnsvNXdMa/TomZeBWw8fCSldTNgY26oGydES+kswY
	WA7mVQ5N9R0NphVp9rqKyA3jPP+23c/2l5Mfu/s9k/nBrnfC0X/Uxktp5er2iy9Tu/5ix4Mrvgo
	pQP39tEeV7bCZ9mbweliVwAk8Ms2xj6h9FTecyiergtfvO0yfgSekNdZvRpQ05nqVdIFqKCwnfK
	sk+2365qGpKQNndwWFOOARDwdJsELGsW/smBCMv6rdSp0w8maYg/llq7lvEf0WmxXUdhGUgHiAB
	GJBhQiKviGR+1xA6q8ZlcEOFuEIEvahtw04oEIyZIUNT0e9nO5hB65vL1VUhd2uP0QsiHWIeE8P
	oz7F/7m00VtM71BWVtPf3o9pocq34DUsM5gS/l9kmifQ4VzakfqJDFKVXgm8RoX86HtKuXzPA==
X-Received: by 2002:a05:600c:4fd4:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-48fe60ed7b7mr118220555e9.10.1778969244840;
        Sat, 16 May 2026 15:07:24 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2c:8500:bde1:c576:18ad:a53? (p200300ea8f2c8500bde1c57618ad0a53.dip0.t-ipconnect.de. [2003:ea:8f2c:8500:bde1:c576:18ad:a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm144690005e9.12.2026.05.16.15.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 15:07:24 -0700 (PDT)
Message-ID: <141ad2ec-95d5-46cc-ad6d-a36103f1a604@gmail.com>
Date: Sun, 17 May 2026 00:07:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v3 3/7] r8169: add support for new interrupt
 mapping
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513115543.1730-1-javen_xu@realsil.com.cn>
 <20260513115543.1730-4-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260513115543.1730-4-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C2DF555E0C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288670-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 13.05.2026 13:55, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support RSS, the number of hardware interrupt bits should match the
> interrupt of software. So we add support for new interrupt mapping here.
> ISR_VER_MAP_REG is the hardware register to indicate interrupt status.
> IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - no changes
> 
> Changes in v3:
>  - init index in napi_struct and get message_id from index
>  - move rtl8169_disable_hw_interrupt_msix directly before the call to
>    napi_schedule()
>  - change the condition in rtl8169_request_irq when RTL_VEC_MAP_ENABLE
>    enabled, use rtl8169_interrupt_msix
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 165 ++++++++++++++++++++--
>  1 file changed, 151 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9dab0fbcca61..f259cc0cee37 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -78,6 +78,7 @@
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
>  #define R8169_MAX_RX_QUEUES	8
> +#define R8127_MAX_TX_QUEUES	8
>  #define R8169_MAX_MSIX_VEC	32
>  #define R8127_MAX_RX_QUEUES	8
>  #define R8169_DEFAULT_RX_QUEUES	1
> @@ -451,8 +452,13 @@ enum rtl8125_registers {
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> +	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
> +	ISR_VEC_MAP_REG		= 0x0d04,
> +	IMR_SET_VEC_MAP_REG	= 0x0d0c,
>  };
>  
> +#define MSIX_ID_VEC_MAP_LINKCHG	29
> +#define RTL_VEC_MAP_ENABLE	BIT(0)
>  #define LEDSEL_MASK_8125	0x23f
>  
>  #define RX_VLAN_INNER_8125	BIT(22)
> @@ -583,6 +589,9 @@ enum rtl_register_content {
>  
>  	/* magic enable v2 */
>  	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
> +#define	ISRIMR_LINKCHG	BIT(29)
> +#define	ISRIMR_TOK_Q0	BIT(8)
> +#define	ISRIMR_ROK_Q0	BIT(0)
>  };
>  
>  enum rtl_isr_version {
> @@ -778,6 +787,7 @@ struct rtl8169_private {
>  	enum rtl_isr_version hw_curr_isr_ver;
>  	u8 irq_nvecs;
>  	bool recheck_desc_ownbit;
> +	unsigned int features;

Why do you add an extra bitmap here? Why not use bool xxx:1 like for other flags?

>  	int irq;
>  	struct clk *clk;
>  
> @@ -1676,26 +1686,36 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
>  
>  static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
>  {
> -	if (rtl_is_8125(tp))
> +	if (rtl_is_8125(tp)) {
>  		RTL_W32(tp, IntrStatus_8125, bits);
> -	else
> +		if (tp->features & RTL_VEC_MAP_ENABLE)

Looks to me like this check is equivalent to checking
hw_curr_isr_ver > RTL_ISR_VER_DEFAULT, or?
If yes, then this additional flag doesn't seem to be needed.

> +			RTL_W32(tp, ISR_VEC_MAP_REG, 0xffffffff);
> +	} else {
>  		RTL_W16(tp, IntrStatus, bits);
> +	}
>  }
>  
>  static void rtl_irq_disable(struct rtl8169_private *tp)
>  {
> -	if (rtl_is_8125(tp))
> +	if (rtl_is_8125(tp)) {
>  		RTL_W32(tp, IntrMask_8125, 0);
> -	else
> +		if (tp->features & RTL_VEC_MAP_ENABLE)
> +			RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, 0xffffffff);
> +	} else {
>  		RTL_W16(tp, IntrMask, 0);
> +	}
>  }
>  
>  static void rtl_irq_enable(struct rtl8169_private *tp)
>  {
> -	if (rtl_is_8125(tp))
> -		RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> -	else
> +	if (rtl_is_8125(tp)) {
> +		if (tp->features & RTL_VEC_MAP_ENABLE)
> +			RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
> +		else
> +			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> +	} else {
>  		RTL_W16(tp, IntrMask, tp->irq_mask);
> +	}
>  }
>  
>  static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
> @@ -5070,6 +5090,42 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, ISR_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, IMR_SET_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static irqreturn_t rtl8169_interrupt_msix(int irq, void *dev_instance)
> +{
> +	struct napi_struct *napi = dev_instance;
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +	int message_id = napi->index;
> +
> +	rtl8169_clear_hw_isr(tp, message_id);
> +
> +	if (message_id == MSIX_ID_VEC_MAP_LINKCHG) {
> +		phy_mac_interrupt(tp->phydev);
> +		return IRQ_HANDLED;
> +	}
> +
> +	tp->recheck_desc_ownbit = true;
> +	rtl8169_disable_hw_interrupt_msix(tp, message_id);
> +	napi_schedule(napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int rtl8169_request_irq(struct rtl8169_private *tp)
>  {
>  	struct net_device *dev = tp->dev;
> @@ -5078,8 +5134,12 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
>  
>  	for (int i = 0; i < tp->irq_nvecs; i++) {
>  		napi = &tp->rtl8169_napi[i];
> -		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> -				     NULL, napi, "%s-%d", dev->name, i);
> +		if (tp->features & RTL_VEC_MAP_ENABLE)
> +			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt_msix,
> +					     NULL, napi, "%s-%d", dev->name, i);
> +		else
> +			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> +					     NULL, napi, "%s-%d", dev->name, i);
>  		if (rc)
>  			break;
>  	}
> @@ -5523,10 +5583,16 @@ static const struct net_device_ops rtl_netdev_ops = {
>  
>  static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  {
> -	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> +	if (tp->features & RTL_VEC_MAP_ENABLE) {
> +		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;
> +		for (int i = 0; i < tp->num_rx_rings; i++)
> +			tp->irq_mask |= ISRIMR_ROK_Q0 << i;
> +	} else {
> +		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
>  
> -	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> -		tp->irq_mask |= SYSErr | RxFIFOOver;
> +		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> +			tp->irq_mask |= SYSErr | RxFIFOOver;
> +	}
>  }
>  
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
> @@ -5555,6 +5621,8 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		return nvecs;
>  
>  	tp->irq_nvecs = nvecs;
> +	if (nvecs > 1)
> +		tp->features |= RTL_VEC_MAP_ENABLE;
>  
>  	return 0;
>  }
> @@ -5822,10 +5890,79 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +	const int message_id = napi->index;
> +	int work_done = 0;
> +
> +	if (message_id < tp->num_rx_rings)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id], budget);
> +
> +	if (work_done < budget && napi_complete_done(napi, work_done))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return work_done;
> +}
> +
> +static int rtl8169_poll_msix_tx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +	const int message_id = napi->index;
> +	int tx_ring_idx = message_id - 8;
> +	unsigned int work_done = 0;
> +
> +	if (tx_ring_idx >= 0)
> +		rtl_tx(dev, tp, budget);
> +
> +	if (work_done < budget && napi_complete_done(napi, work_done))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return work_done;
> +}
> +
> +static int rtl8169_poll_msix_other(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +	const int message_id = napi - tp->rtl8169_napi;

Why not use napi->index here too?

> +
> +	napi_complete_done(napi, budget);
> +	rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return 1;
> +}
> +
>  static void r8169_init_napi(struct rtl8169_private *tp)
>  {
> -	for (int i = 0; i < tp->irq_nvecs; i++)
> -		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		if (tp->features & RTL_VEC_MAP_ENABLE) {
> +			switch (tp->hw_curr_isr_ver) {
> +			case RTL_ISR_VER_8127:

A comment describing the RTL8127 MSI-X vector layout would be helpful here.
Otherwise the following is hard to understand.

> +				if (i < R8127_MAX_RX_QUEUES)
> +					netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
> +						       rtl8169_poll_msix_rx);
> +				else if (i >= R8127_MAX_RX_QUEUES &&
> +					 i < (R8127_MAX_RX_QUEUES +
> +					 R8127_MAX_TX_QUEUES))
> +					netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
> +						       rtl8169_poll_msix_tx);
> +				else
> +					netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
> +						       rtl8169_poll_msix_other);
> +				break;
> +			default:
> +				netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
> +					       rtl8169_poll);
> +				break;
> +			}
> +		} else {
> +			netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +		}

This seems to be unnecessarily complex and can be simplified.

> +		tp->rtl8169_napi[i].index = i;
> +	}
>  }
>  
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)


