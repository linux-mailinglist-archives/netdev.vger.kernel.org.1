Return-Path: <netdev+bounces-53237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E5801B87
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 09:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D90281E1D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E32BA31;
	Sat,  2 Dec 2023 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="pCSuWAI9"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0711C196;
	Sat,  2 Dec 2023 00:36:41 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6476F240003;
	Sat,  2 Dec 2023 08:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1701506200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2wLMvIIVt4NNTdGsFG3SPBRcTEOfz3PdLa/GlA7GzU=;
	b=pCSuWAI9D8zF/hQO2V4ig9tFsgd/ew1diFvWU/0pjWH64JXKoxcouGA+Mzja+/yl4zDoov
	dZF4PpQQKhIXp3LNwFSJGwiHwdRNE7yZs8buTVxP+k7oTs/212WKhDvPKSFzNsn0ALf0oL
	q68fPW3eq2W9Db7kqa7QDVT6YQPyFgz7AstIXWbpDUCmHorRjocpPgjfmee9962uKVqPfn
	R9v1QZxORbOLzp1WoB71qxsDqJeFLkW2OYmpzw/YWXZvhxXoOBJ1PX/7dW+/B1ZIpoY+Jv
	mpVGOWeakcUTBSIRkNJA/4MjvH1fKxC0GmD4coHpvGPYI5Tb00JUT2hfNN4H+A==
Message-ID: <5e95a436-189f-412e-b409-89a003003292@arinc9.com>
Date: Sat, 2 Dec 2023 11:36:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/15] net: dsa: mt7530: improve code path for
 setting up port 5
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
 <20231118123205.266819-6-arinc.unal@arinc9.com>
 <ZVjNJ0nf7Mp0kHzH@shell.armlinux.org.uk>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZVjNJ0nf7Mp0kHzH@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 18.11.2023 17:41, Russell King (Oracle) wrote:
> On Sat, Nov 18, 2023 at 03:31:55PM +0300, Arınç ÜNAL wrote:
>> There're two code paths for setting up port 5:
>>
>> mt7530_setup()
>> -> mt7530_setup_port5()
>>
>> mt753x_phylink_mac_config()
>> -> mt753x_mac_config()
>>     -> mt7530_mac_config()
>>        -> mt7530_setup_port5()
>>
>> Currently mt7530_setup_port5() from mt7530_setup() always runs. If port 5
>> is used as a CPU, DSA, or user port, mt7530_setup_port5() from
>> mt753x_phylink_mac_config() won't run. That is because priv->p5_interface
>> set on mt7530_setup_port5() will match state->interface on
>> mt753x_phylink_mac_config() which will stop running mt7530_setup_port5()
>> again.
>>
>> Therefore, mt7530_setup_port5() will never run from
>> mt753x_phylink_mac_config().
>>
>> Address this by not running mt7530_setup_port5() from mt7530_setup() if
>> port 5 is used as a CPU, DSA, or user port. This driver isn't in the
>> dsa_switches_apply_workarounds[] array so phylink will always be present.
>>
>> For the cases of PHY muxing or the port being disabled, call
>> mt7530_setup_port5() from mt7530_setup(). mt7530_setup_port5() from
>> mt753x_phylink_mac_config() won't run when port 5 is disabled or used for
>> PHY muxing as port 5 won't be defined on the devicetree.
> 
> ... and this should state why this needs to happen - in other words,
> the commit message should state why is it critical that port 5 is
> always setup.

Actually, port 5 must not always be setup. With patch 7, I explain this
while preventing mt7530_setup_port5() from running if port 5 is disabled.

Arınç

