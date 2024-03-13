Return-Path: <netdev+bounces-79633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22887A4F2
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB241C203E6
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD631CF87;
	Wed, 13 Mar 2024 09:25:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D021CD25
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321901; cv=none; b=DfHClQlrwUQJBc8Ey7p2sZ85iV4pzBSqSCVEEC0QSed4QVjKW3smoXS2FB34kZDQblqQPyxDy3HR4qwnrz1p3ulapB5lWY9yzojBGVOA1m6sdaw+VCQepqe2202YjL6kQIRRwVSjAU0i3YeBk2z4eZ7HR7bilzbo6pDMuuPef0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321901; c=relaxed/simple;
	bh=B6ZVuySuWmWmfk2+sAYxjA4U8Z4sGibF1ppV+9iIIzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cnwg5jYHGrg3nNaqIfGMQ9ihDnuiqN/tBfRHrWIndasF0jMAUc5bE8UDWRbjD5JyiF9olnap/D3nRTv0oJ6aBvxV/nbTrBjkMzVIj5INNhheiwWKDtSFsqnx7vHHzw1iRKQyPcg4LJkVxmQ44/knzrrVIAAXwpHtSLd046OzGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8DxdfHocPFlU1wYAA--.59424S3;
	Wed, 13 Mar 2024 17:24:56 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxVMzkcPFlSWVYAA--.39737S3;
	Wed, 13 Mar 2024 17:24:53 +0800 (CST)
Message-ID: <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
Date: Wed, 13 Mar 2024 17:24:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxVMzkcPFlSWVYAA--.39737S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF43CFW5uFy3ZFWkZr18Zwc_yoWfJryxpw
	48Aa4UuryUJr18Jw4kJr4UZFy5JFyUtw4UGF4xJFy3tF1qyryjqryjgrWj9r17Cr4kWF1a
	qr1UCr1UuFn8JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==


在 2024/2/6 06:06, Serge Semin 写道:
> On Tue, Feb 06, 2024 at 12:58:17AM +0300, Serge Semin wrote:
>> On Tue, Jan 30, 2024 at 04:49:14PM +0800, Yanteng Si wrote:
>>> Current GNET does not support half duplex mode.
>>>
>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>> ---
>>>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 ++++++++++-
>>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  3 ++-
>>>   include/linux/stmmac.h                               |  1 +
>>>   3 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>> index 264c4c198d5a..1753a3c46b77 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>> @@ -432,8 +432,17 @@ static int loongson_gnet_config(struct pci_dev *pdev,
>>>   				struct stmmac_resources *res,
>>>   				struct device_node *np)
>>>   {
>>> -	if (pdev->revision == 0x00 || pdev->revision == 0x01)
>>> +	switch (pdev->revision) {
>>> +	case 0x00:
>>> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000 |
>>> +			       STMMAC_FLAG_DISABLE_HALF_DUPLEX;
>>> +		break;
>>> +	case 0x01:
>>>   		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	}
>> Move this change into the patch
>> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
>>
>>>   
>>>   	return 0;
>>>   }
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 5617b40abbe4..3aa862269eb0 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -1201,7 +1201,8 @@ static int stmmac_init_phy(struct net_device *dev)
>>>   static void stmmac_set_half_duplex(struct stmmac_priv *priv)
>>>   {
>>>   	/* Half-Duplex can only work with single tx queue */
>>> -	if (priv->plat->tx_queues_to_use > 1)
>>> +	if (priv->plat->tx_queues_to_use > 1 ||
>>> +	    (STMMAC_FLAG_DISABLE_HALF_DUPLEX & priv->plat->flags))
>>>   		priv->phylink_config.mac_capabilities &=
>>>   			~(MAC_10HD | MAC_100HD | MAC_1000HD);
>>>   	else
>>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>>> index 2810361e4048..197f6f914104 100644
>>> --- a/include/linux/stmmac.h
>>> +++ b/include/linux/stmmac.h
>>> @@ -222,6 +222,7 @@ struct dwmac4_addrs {
>>>   #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>>>   #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>>>   #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
>>> +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
>>>   
>> Place the patch with this change before
>> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
>> as a pre-requisite/preparation patch. Don't forget a thorough
>> description of what is wrong with the GNET Half-Duplex mode.
> BTW what about re-defining the stmmac_ops.phylink_get_caps() callback
> instead of adding fixup flags in this patch and in the next one?

ok.

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c 
b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index ac1b48ff7199..b57e1325ce62 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -238,6 +234,13 @@ static int loongson_gnet_get_hw_feature(void 
__iomem *ioaddr,
      return 0;
  }

+static void loongson_phylink_get_caps(struct stmmac_priv *priv)
+{
+    priv->phylink_config.mac_capabilities = (MAC_10FD |
+        MAC_100FD | MAC_1000FD) & ~(MAC_10HD | MAC_100HD | MAC_1000HD);
+
+}
+
  struct stmmac_pci_info {
      int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
      int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
@@ -403,10 +405,15 @@ static void loongson_gnet_fix_speed(void *priv, 
unsigned int speed, unsigned int

  static struct mac_device_info *loongson_setup(void *apriv)
  {
+    struct stmmac_ops *loongson_dwmac_ops;
      struct stmmac_priv *priv = apriv;
      struct mac_device_info *mac;
      struct stmmac_dma_ops *dma;

+    loongson_dwmac_ops = devm_kzalloc(priv->device, 
sizeof(*loongson_dwmac_ops), GFP_KERNEL);
+    if (!loongson_dwmac_ops)
+        return NULL;
+
      mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
      if (!mac)
          return NULL;
@@ -417,6 +424,10 @@ static struct mac_device_info *loongson_setup(void 
*apriv)

      priv->synopsys_id = 0x37;    /*Overwrite custom IP*/

+    *loongson_dwmac_ops = dwmac1000_ops;
+    loongson_dwmac_ops->phylink_get_caps = loongson_phylink_get_caps;
+    mac->mac = loongson_dwmac_ops;
+
      *dma = dwmac1000_dma_ops;
      dma->init_chan = loongson_gnet_dma_init_channel;
      dma->dma_interrupt = loongson_gnet_dma_interrupt;
@@ -375,8 +375,6 @@ static int loongson_gmac_config(struct pci_dev *pdev,
                                 struct stmmac_resources *res,
                                 struct device_node *np)
  {
-       plat->flags |= STMMAC_FLAG_DISABLE_FLOW_CONTROL;
-
         return 0;
  }

@@ -489,17 +487,7 @@ static int loongson_gnet_config(struct pci_dev *pdev,
                                 struct stmmac_resources *res,
                                 struct device_node *np)
  {
-       switch (pdev->revision) {
-       case 0x00:
-               plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000 |
-                              STMMAC_FLAG_DISABLE_HALF_DUPLEX;
-               break;
-       case 0x01:
-               plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
-               break;
-       default:
-               break;
-       }
+       plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;

         return 0;
  }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8705e04913d1..7c656f970575 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1201,8 +1201,7 @@ static int stmmac_init_phy(struct net_device *dev)
  static void stmmac_set_half_duplex(struct stmmac_priv *priv)
  {
      /* Half-Duplex can only work with single tx queue */
-    if (priv->plat->tx_queues_to_use > 1 ||
-        (STMMAC_FLAG_DISABLE_HALF_DUPLEX & priv->plat->flags))
+    if (priv->plat->tx_queues_to_use > 1)
          priv->phylink_config.mac_capabilities &=
              ~(MAC_10HD | MAC_100HD | MAC_1000HD);
      else
@@ -1237,9 +1236,9 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
          xpcs_get_interfaces(priv->hw->xpcs,
priv->phylink_config.supported_interfaces);

-    priv->phylink_config.mac_capabilities = MAC_10FD | MAC_100FD | 
MAC_1000FD;
-    if (!(priv->plat->flags & STMMAC_FLAG_DISABLE_FLOW_CONTROL))
-        priv->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | 
MAC_SYM_PAUSE;
+    priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | 
MAC_SYM_PAUSE |
+                        MAC_10FD | MAC_100FD |
+                        MAC_1000FD;

      stmmac_set_half_duplex(priv);
  -----


loongson_gmac/gnet_config()

I will try to remove these two functions according to your comment in 
another patch。


Thanks,

Yanteng

>
> -Serge()
>
>> -Serge(y)
>>
>>>   struct plat_stmmacenet_data {
>>>   	int bus_id;
>>> -- 
>>> 2.31.4
>>>


