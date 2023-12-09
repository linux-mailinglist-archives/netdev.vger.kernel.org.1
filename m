Return-Path: <netdev+bounces-55498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C132D80B0D9
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7871A2815C7
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F22386;
	Sat,  9 Dec 2023 00:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0D1723;
	Fri,  8 Dec 2023 16:10:40 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rBkvE-00054i-1y;
	Sat, 09 Dec 2023 00:10:21 +0000
Date: Sat, 9 Dec 2023 00:10:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	"Garmin.Chang" <Garmin.Chang@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	James Liao <jamesjj.liao@mediatek.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/4] clk: mediatek: Add pcw_chg_shift control
Message-ID: <ZXOwZdyAJoyLRbk5@makrotopia.org>
References: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
 <40981d0bb722eb509628bcf82c31f632e4cf747a.1701823757.git.daniel@makrotopia.org>
 <0ebce75d-0074-4128-b35e-e86ee3ee546b@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ebce75d-0074-4128-b35e-e86ee3ee546b@collabora.com>

Hi Angelo,

thank you for taking the time to review and for the helpful comments.

On Wed, Dec 06, 2023 at 11:38:36AM +0100, AngeloGioacchino Del Regno wrote:
> Il 06/12/23 01:57, Daniel Golle ha scritto:
> > From: Sam Shih <sam.shih@mediatek.com>
> > 
> > Introduce pcw_chg_shfit control to optionally use that instead of the
> > hardcoded PCW_CHG_MASK macro.
> > This will needed for clocks on the MT7988 SoC.
> > 
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v3: use git --from ...
> > v2: no changes
> > 
> >   drivers/clk/mediatek/clk-pll.c | 5 ++++-
> >   drivers/clk/mediatek/clk-pll.h | 1 +
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > index 513ab6b1b3229..9f08bc5d2a8a2 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> > @@ -114,7 +114,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >   			pll->data->pcw_shift);
> >   	val |= pcw << pll->data->pcw_shift;
> >   	writel(val, pll->pcw_addr);
> > -	chg = readl(pll->pcw_chg_addr) | PCW_CHG_MASK;
> > +	if (pll->data->pcw_chg_shift)
> > +		chg = readl(pll->pcw_chg_addr) | BIT(pll->data->pcw_chg_shift);
> > +	else
> > +		chg = readl(pll->pcw_chg_addr) | PCW_CHG_MASK;
> >   	writel(chg, pll->pcw_chg_addr);
> >   	if (pll->tuner_addr)
> >   		writel(val + 1, pll->tuner_addr);
> > diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> > index f17278ff15d78..d28d317e84377 100644
> > --- a/drivers/clk/mediatek/clk-pll.h
> > +++ b/drivers/clk/mediatek/clk-pll.h
> > @@ -44,6 +44,7 @@ struct mtk_pll_data {
> >   	u32 pcw_reg;
> >   	int pcw_shift;
> >   	u32 pcw_chg_reg;
> > +	int pcw_chg_shift;
> >   	const struct mtk_pll_div_table *div_table;
> >   	const char *parent_name;
> >   	u32 en_reg;
> 
> Hmm... no, this is not the best at all and can be improved.
> 
> Okay, so, the situation here is that one or some PLL(s) on MT7988 have a different
> PCW_CHG_MASK as far as I understand.

Correct. *All* clocks of MT7988 have a different PCW_CHG_MASK, BIT(2)
instead of BIT(31).

> 
> Situation here is:
>  - Each PLL must be registered to clk-pll
>  - Each driver declaring a PLL does exactly so
>    - There's a function to register the PLL
> 
> You definitely don't want to add a conditional in pll_set_rate(): even though
> this is technically not a performance path on the current SoCs (and will probably
> never be), it's simply useless to have this (very small) overhead there.
> 
> The solution is to:
>  - Change that pcw_chg_shift to an unsigned short int type (or u8, your call):
>    you don't need 32 bits for this number, as the expected range of this member
>    is [0-31], and this can be expressed in just 4 bits (u8 is the smallest though)

Ack will use u8 instead, despite the struct not being packed, so I
wonder if it actually makes a difference.

>  - Add that to function mtk_clk_register_pll_ops()
>  - Change mtk_pll_set_rate_regs() to always do
>    chg = readl(pll->pcw_chg_addr) | BIT(pll->data->pcw_chg_shift);

As mtk_pll_data is a read-only member of the mtk_pll struct, we can't
set pcw_chg_shift to 31 in mtk_clk_register_pll_ops() in case it
is set to 0.
The only (much more intrusive change) would be to explicitely declare
.pcw_chg_shift = 31 in all current drivers setting .pcs_chg_reg != 0.
Should I do that instead?

