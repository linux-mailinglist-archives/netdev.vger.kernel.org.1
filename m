Return-Path: <netdev+bounces-53236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D6801B7D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 09:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1159F1C20A19
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540415A2;
	Sat,  2 Dec 2023 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="pxoYcgmX"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C73D196;
	Sat,  2 Dec 2023 00:29:58 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66A9820003;
	Sat,  2 Dec 2023 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1701505797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AepG7Sxs6UrlTw5J0jcbOX6uiYe5pZuBTrOV1pLs6ME=;
	b=pxoYcgmX8xvCrfbGL5CbcvRtmQg/u+oFGkflBsXi9pLvQTIIG0gWUnkW2jkVsUrZkfJWwN
	4beX9Ut7AitIw+I8urbjgmi5GKJkVnrsV1maxEkEmgJf/wPwIxVEsk/1WnA/3vrvgRRgH4
	mq5oiyFl0Nkj8rzNV3P9tGuUqUi7LsaO9WrBgT7vFr+YpokyaCRPr2Bahk86afTvRhTul4
	CAbwb9Etd/0PwIpIdu60zlzgb01rOS65pSi/Q8ldn0bc44iLgdAuYN31RVJY0EVV8ZWv0v
	BQ4aVE20Ueyo2mwhDdrV2y7dDT90s/DgFONEJ2OEo0/G567/3tPnYYNstmtE6A==
Message-ID: <ffaa26b3-eb25-47cc-8891-fe3cbcc724da@arinc9.com>
Date: Sat, 2 Dec 2023 11:29:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] net: dsa: mt7530: always trap frames to
 active CPU port on MT7530
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-2-arinc.unal@arinc9.com>
 <ZVjLj6/iCL/muzmH@shell.armlinux.org.uk>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZVjLj6/iCL/muzmH@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 18.11.2023 17:34, Russell King (Oracle) wrote:
> On Sat, Nov 18, 2023 at 03:31:51PM +0300, Arınç ÜNAL wrote:
>> +	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
>> +	 * forwarded to the numerically smallest CPU port which the DSA conduit
>> +	 * interface its affine to is up.
>> +	 */
>> +	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
>> +		return;
>> +
>> +	if (operational)
>> +		priv->active_cpu_ports |= BIT(cpu_dp->index);
>> +	else
>> +		priv->active_cpu_ports &= ~BIT(cpu_dp->index);
>> +
>> +	if (priv->active_cpu_ports)
>> +		mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, CPU_EN |
>> +			   CPU_PORT(__ffs(priv->active_cpu_ports)));
> 
> I would be tempted to write this as:
> 
> 	mask = BIT(cpu_dp->index);
> 
> 	if (operational)
> 		priv->active_cpu_ports |= mask;
> 	else
> 		priv->active_cpu_ports &= ~mask;
> 
> Now, what happens when active_cpu_ports is zero? Doesn't that mean there
> is no active CPU port? In which case, wouldn't disabling the CPU port
> direction be appropriate, such as:
> 
> 	if (priv->active_cpu_ports)
> 		val = CPU_EN | CPU_PORT(__ffs(priv->active_cpu_ports));
> 	else
> 		val = 0;
> 
> 	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);	
> 
> ?

In practice, it doesn't seem to matter. The CPU_EN bit enables the CPU port
defined on CPU_PORT_MASK which is used for trapping frames. No active CPU
ports would mean that all the DSA conduits are down. In that case, all the
user ports will be down also. So there won't be any traffic. But disabling
it is of course more appropriate here.

> 
>>   struct mt7530_priv {
>>   	struct device		*dev;
>> @@ -786,6 +787,7 @@ struct mt7530_priv {
>>   	struct irq_domain *irq_domain;
>>   	u32 irq_enable;
>>   	int (*create_sgmii)(struct mt7530_priv *priv, bool dual_sgmii);
>> +	unsigned long active_cpu_ports;
> 
> So this will be 32 or 64 bit in size. Presumably you know how many CPU
> ports there can be, which looking at this code must be less than 8 as
> CPU_PORT_MASK is only 3 bits in size. So, maybe use a u8, and check
> that cpu_dp->index <= 7 ?

Aren't there other mechanisms to check that cpu_dp->index is a valid port?
At least with phylink_get_caps(), only ports lower than 7 will have proper
interface modes allowed.

Here's the code after you and Vladimir's review:

static void
mt753x_conduit_state_change(struct dsa_switch *ds,
			    const struct net_device *conduit,
			    bool operational)
{
	struct dsa_port *cpu_dp = conduit->dsa_ptr;
	struct mt7530_priv *priv = ds->priv;
	u8 mask;
	int val;

	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
	 * forwarded to the numerically smallest CPU port which the DSA conduit
	 * interface its affine to is up.
	 */
	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
		return;

	mask = BIT(cpu_dp->index);

	if (operational)
		priv->active_cpu_ports |= mask;
	else
		priv->active_cpu_ports &= ~mask;

	if (priv->active_cpu_ports)
		val = CPU_EN | CPU_PORT(__ffs(priv->active_cpu_ports));
	else
		val = 0;

	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);
}

struct mt7530_priv {
	[...]
	u8 active_cpu_ports;
};

> 
> I would also suggest moving irq_enable after create_sgmii, to avoid
> holes in the struct.

Sorry, I've got no idea about this. Could you explain why would there
possibly be holes in the struct with the current ordering of the members of
the mt7530_priv structure?

Arınç

