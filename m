Return-Path: <netdev+bounces-216480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1487B34007
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F6F2006F6
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAA11EA7CE;
	Mon, 25 Aug 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fb/dQwQE"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9231E3DFE;
	Mon, 25 Aug 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126221; cv=none; b=oOJJBOQwIeKXD7336i4qznXGTi4NKVtJsfd3aZ7PnKciflfO4PFuV8dD9cqAxWRFzP/hQCqR8EMyca5M9XUtynv/LyzR+gaPYThszcnFEBlJFiIGlp1d0z+N546EZ5egIYc2UNZ2H0PKH6aQbUbfY2X52Bysi+IqX8pda52lSa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126221; c=relaxed/simple;
	bh=UVJPdiqJAwlNJSMs+WTVCoHBLtI29kqg/HsLe9G8lgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAT7QVRjmhIMhDOdtB7Kgis2F3guh6cWupBchtlGr/ipf9JW9lQGsta5hTSd1gqdys5wVxcpGpnAHkcJxYWwt/w4a4WeBq6hircSocjnVNKcU2bSq8HWPP1nBM2Fw07I82qpRYRjwljFWqDoPZOuYyS1w9dJ+TbbfEfkhK991Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fb/dQwQE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756126218;
	bh=UVJPdiqJAwlNJSMs+WTVCoHBLtI29kqg/HsLe9G8lgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fb/dQwQEQErrvatkebCZRMmRsZ9gWRIfTk/rSJvIMBEyKLGM/iLeiV9CMeQnf7VGS
	 quo5slxDPnXNxaIIhkYrs9GGWjuSuPKJ2BJfqj8VsEzNZkW+DQalvdvJSE6/yySxfb
	 clXVceBVCD07LsjoUfLY3S+0hRyn1s9ixkuTYdj42px8KxDReqPtw/E3L1eWFOs+ll
	 WTmcAi9YeiEvzSjZXSeXGBJBPQiujdxzNKYolhLIRNs3/AuTtnHL+KTTq3Vz5GIeY4
	 WoMuz3uZZXtIvqa+ndgImrQVhf1E5WN6SmFnrJR3cRv+vgT5fvvgsg+4AOT0N2hU8X
	 r8mWiW9xneSLw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:b1df:895a:e67b:5cd4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1FB9317E0478;
	Mon, 25 Aug 2025 14:50:17 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: wenst@chromium.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	guangjie.song@mediatek.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	netdev@vger.kernel.org,
	nfraprado@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com,
	robh@kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH v4 06/27] clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct
Date: Mon, 25 Aug 2025 14:49:00 +0200
Message-Id: <20250825124900.209515-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGXv+5GxJs03EcMt0jm-x_fDuy_RtCrnOmyJvVVgAP9O9R6E2Q@mail.gmail.com>
References: <CAGXv+5GxJs03EcMt0jm-x_fDuy_RtCrnOmyJvVVgAP9O9R6E2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/15/25 05:42, Chen-Yu Tsai wrote:
> On Tue, Aug 5, 2025 at 10:55 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> MT8196 uses a HW voter for gate enable/disable control, with
>> set/clr/sta registers located in a separate regmap. Refactor
>> mtk_clk_register_gate() to take a struct mtk_gate instead of individual
>> parameters, avoiding the need to add three extra arguments to support
>> HW voter register offsets.
>>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>  drivers/clk/mediatek/clk-gate.c | 35 ++++++++++++---------------------
>>  1 file changed, 13 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
>> index 67d9e741c5e7..0375ccad4be3 100644
>> --- a/drivers/clk/mediatek/clk-gate.c
>> +++ b/drivers/clk/mediatek/clk-gate.c
>> @@ -152,12 +152,9 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
>>  };
>>  EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
>>
>> -static struct clk_hw *mtk_clk_register_gate(struct device *dev, const char *name,
>> -                                        const char *parent_name,
>> -                                        struct regmap *regmap, int set_ofs,
>> -                                        int clr_ofs, int sta_ofs, u8 bit,
>> -                                        const struct clk_ops *ops,
>> -                                        unsigned long flags)
>> +static struct clk_hw *mtk_clk_register_gate(struct device *dev,
>> +                                               const struct mtk_gate *gate,
>> +                                               struct regmap *regmap)
>>  {
>>         struct mtk_clk_gate *cg;
>>         int ret;
>> @@ -167,17 +164,17 @@ static struct clk_hw *mtk_clk_register_gate(struct device *dev, const char *name
>>         if (!cg)
>>                 return ERR_PTR(-ENOMEM);
>>
>> -       init.name = name;
>> -       init.flags = flags | CLK_SET_RATE_PARENT;
>> -       init.parent_names = parent_name ? &parent_name : NULL;
>> -       init.num_parents = parent_name ? 1 : 0;
>> -       init.ops = ops;
>> +       init.name = gate->name;
>> +       init.flags = gate->flags | CLK_SET_RATE_PARENT;
>> +       init.parent_names = gate->parent_name ? &gate->parent_name : NULL;
>> +       init.num_parents = gate->parent_name ? 1 : 0;
>> +       init.ops = gate->ops;
>>
>>         cg->regmap = regmap;
>> -       cg->set_ofs = set_ofs;
>> -       cg->clr_ofs = clr_ofs;
>> -       cg->sta_ofs = sta_ofs;
>> -       cg->bit = bit;
>> +       cg->set_ofs = gate->regs->set_ofs;
>> +       cg->clr_ofs = gate->regs->clr_ofs;
>> +       cg->sta_ofs = gate->regs->sta_ofs;
>> +       cg->bit = gate->shift;
>
> I'd rather see |struct mtk_clk_gate| (the runtime data) gain a pointer
> to the static data |struct mtk_gate| instead of doing all the copying.
> This is just needless duplication.
>

Ack - I'll refactor this in the next revision.

Thanks,

Laura

> ChenYu
>
>>         cg->hw.init = &init;
>>
>> @@ -228,13 +225,7 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
>>                         continue;
>>                 }
>>
>> -               hw = mtk_clk_register_gate(dev, gate->name, gate->parent_name,
>> -                                           regmap,
>> -                                           gate->regs->set_ofs,
>> -                                           gate->regs->clr_ofs,
>> -                                           gate->regs->sta_ofs,
>> -                                           gate->shift, gate->ops,
>> -                                           gate->flags);
>> +               hw = mtk_clk_register_gate(dev, gate, regmap);
>>
>>                 if (IS_ERR(hw)) {
>>                         pr_err("Failed to register clk %s: %pe\n", gate->name,
>> --
>> 2.39.5
>>

