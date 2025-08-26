Return-Path: <netdev+bounces-216842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFEBB35735
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8198F1B62C4C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1042FD7D7;
	Tue, 26 Aug 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="msrcev8+"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE412FD7AA;
	Tue, 26 Aug 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197443; cv=none; b=O3W14fNyvqf5VHzorj7TANPtPHs3cW4A/wuTVJQMpUIyFotZ9tZqJyoQLv48/Go3QpTCksnzPOLEFTfSzLV0yvAFlODrwfC3drrkUUKd0+Q0ldT2O0yn1wDP97f/gfkmgQwGdfQvul+1MZyUI5/BoD0S06TH3yXMMYbHVCVO+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197443; c=relaxed/simple;
	bh=INN9sg5yobmoEiseoSRofMlthz3mHACZQ1QnQIT9W5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA5SVpjkq9b7FXoq0i//adKgAQZlBPHAkwYeQ2a7NRg3q5ReVL7fdQpAL68a3xCFDBoAYI8NFWevSRL4AG7/Q7oxMV5Up97guTPnNA6FBV6i2PN7YwjUwA771N23ywumkleaTWOMgXh8NvsYT6DIKoQ5fAAyP9FGrXUws9ElSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=msrcev8+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756197438;
	bh=INN9sg5yobmoEiseoSRofMlthz3mHACZQ1QnQIT9W5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msrcev8+mnukKssQ+3BQww3TdIuCeVQoa5alyFH82bRxGTZSTjakU6KXioV6/PRKr
	 CvOFQsGJs8c3TDHGR4TGvQ4ZzfaSJf0Z1of6XNutesPMhxc2Y8N/p3ApEkJVswX96D
	 2EcOb+YNYGXAbdAIADlFBvcGPkwy0rJASIV0rMyMtDA3MuPT3P/ByiKl/knL3xx/vC
	 trUoZwlX5W9vj+Yk57mRktiPFSOSJgGSKBY/4dhYtqNYSxgw51+Ylx8znGkrlgFNE5
	 5JBzT5+u4+9WTeUhtuvGtQK9lqVQNRbQav/DU03wndPE5vvJM/VcppF6RUpAL73nMJ
	 sG8VrDSkSwsEQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:3f5e:9a5c:2b70:3fc4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AC87517E0488;
	Tue, 26 Aug 2025 10:37:17 +0200 (CEST)
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
Subject: Re: [PATCH v4 07/27] clk: mediatek: clk-gate: Add ops for gates with HW voter
Date: Tue, 26 Aug 2025 10:36:16 +0200
Message-Id: <20250826083616.15558-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGXv+5HQrMY+osCZKVOq28fQi-Be-eZ=_-=5HcrkacivHekOTQ@mail.gmail.com>
References: <CAGXv+5HQrMY+osCZKVOq28fQi-Be-eZ=_-=5HcrkacivHekOTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/25 16:50, Chen-Yu Tsai wrote:
> On Mon, Aug 25, 2025 at 2:52 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> On 8/15/25 05:37, Chen-Yu Tsai wrote:
>>> On Tue, Aug 5, 2025 at 10:55 PM Laura Nao <laura.nao@collabora.com> wrote:
>>>>
>>>> MT8196 use a HW voter for gate enable/disable control. Voting is
>>>> performed using set/clr regs, with a status bit used to verify the vote
>>>> state. Add new set of gate clock operations with support for voting via
>>>> set/clr regs.
>>>>
>>>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>>> ---
>>>>  drivers/clk/mediatek/clk-gate.c | 77 +++++++++++++++++++++++++++++++--
>>>>  drivers/clk/mediatek/clk-gate.h |  3 ++
>>>>  2 files changed, 77 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
>>>> index 0375ccad4be3..426f3a25763d 100644
>>>> --- a/drivers/clk/mediatek/clk-gate.c
>>>> +++ b/drivers/clk/mediatek/clk-gate.c
>>>> @@ -5,6 +5,7 @@
>>>>   */
>>>>
>>>>  #include <linux/clk-provider.h>
>>>> +#include <linux/dev_printk.h>
>>>>  #include <linux/mfd/syscon.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/printk.h>
>>>> @@ -12,14 +13,19 @@
>>>>  #include <linux/slab.h>
>>>>  #include <linux/types.h>
>>>>
>>>> +#include "clk-mtk.h"
>>>>  #include "clk-gate.h"
>>>>
>>>>  struct mtk_clk_gate {
>>>>         struct clk_hw   hw;
>>>>         struct regmap   *regmap;
>>>> +       struct regmap   *regmap_hwv;
>>>>         int             set_ofs;
>>>>         int             clr_ofs;
>>>>         int             sta_ofs;
>>>> +       unsigned int    hwv_set_ofs;
>>>> +       unsigned int    hwv_clr_ofs;
>>>> +       unsigned int    hwv_sta_ofs;
>>>>         u8              bit;
>>>>  };
>>>>
>>>> @@ -100,6 +106,28 @@ static void mtk_cg_disable_inv(struct clk_hw *hw)
>>>>         mtk_cg_clr_bit(hw);
>>>>  }
>>>>
>>>> +static int mtk_cg_hwv_set_en(struct clk_hw *hw, bool enable)
>>>> +{
>>>> +       struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
>>>> +       u32 val;
>>>> +
>>>> +       regmap_write(cg->regmap_hwv, enable ? cg->hwv_set_ofs : cg->hwv_clr_ofs, BIT(cg->bit));
>>>> +
>>>> +       return regmap_read_poll_timeout_atomic(cg->regmap_hwv, cg->hwv_sta_ofs, val,
>>>> +                                              val & BIT(cg->bit),
>>>> +                                              0, MTK_WAIT_HWV_DONE_US);
>>>> +}
>>>> +
>>>> +static int mtk_cg_hwv_enable(struct clk_hw *hw)
>>>> +{
>>>> +       return mtk_cg_hwv_set_en(hw, true);
>>>> +}
>>>> +
>>>> +static void mtk_cg_hwv_disable(struct clk_hw *hw)
>>>> +{
>>>> +       mtk_cg_hwv_set_en(hw, false);
>>>> +}
>>>> +
>>>>  static int mtk_cg_enable_no_setclr(struct clk_hw *hw)
>>>>  {
>>>>         mtk_cg_clr_bit_no_setclr(hw);
>>>> @@ -124,6 +152,15 @@ static void mtk_cg_disable_inv_no_setclr(struct clk_hw *hw)
>>>>         mtk_cg_clr_bit_no_setclr(hw);
>>>>  }
>>>>
>>>> +static bool mtk_cg_uses_hwv(const struct clk_ops *ops)
>>>> +{
>>>> +       if (ops == &mtk_clk_gate_hwv_ops_setclr ||
>>>> +           ops == &mtk_clk_gate_hwv_ops_setclr_inv)
>>>> +               return true;
>>>> +
>>>> +       return false;
>>>> +}
>>>> +
>>>>  const struct clk_ops mtk_clk_gate_ops_setclr = {
>>>>         .is_enabled     = mtk_cg_bit_is_cleared,
>>>>         .enable         = mtk_cg_enable,
>>>> @@ -138,6 +175,20 @@ const struct clk_ops mtk_clk_gate_ops_setclr_inv = {
>>>>  };
>>>>  EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr_inv);
>>>>
>>>> +const struct clk_ops mtk_clk_gate_hwv_ops_setclr = {
>>>> +       .is_enabled     = mtk_cg_bit_is_cleared,
>>>> +       .enable         = mtk_cg_hwv_enable,
>>>> +       .disable        = mtk_cg_hwv_disable,
>>>> +};
>>>> +EXPORT_SYMBOL_GPL(mtk_clk_gate_hwv_ops_setclr);
>>>> +
>>>> +const struct clk_ops mtk_clk_gate_hwv_ops_setclr_inv = {
>>>> +       .is_enabled     = mtk_cg_bit_is_set,
>>>> +       .enable         = mtk_cg_hwv_enable,
>>>> +       .disable        = mtk_cg_hwv_disable,
>>>> +};
>>>> +EXPORT_SYMBOL_GPL(mtk_clk_gate_hwv_ops_setclr_inv);
>>>> +
>>>>  const struct clk_ops mtk_clk_gate_ops_no_setclr = {
>>>>         .is_enabled     = mtk_cg_bit_is_cleared,
>>>>         .enable         = mtk_cg_enable_no_setclr,
>>>> @@ -153,8 +204,9 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
>>>>  EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
>>>>
>>>>  static struct clk_hw *mtk_clk_register_gate(struct device *dev,
>>>> -                                               const struct mtk_gate *gate,
>>>> -                                               struct regmap *regmap)
>>>> +                                           const struct mtk_gate *gate,
>>>> +                                           struct regmap *regmap,
>>>> +                                           struct regmap *regmap_hwv)
>>>>  {
>>>>         struct mtk_clk_gate *cg;
>>>>         int ret;
>>>> @@ -169,11 +221,22 @@ static struct clk_hw *mtk_clk_register_gate(struct device *dev,
>>>>         init.parent_names = gate->parent_name ? &gate->parent_name : NULL;
>>>>         init.num_parents = gate->parent_name ? 1 : 0;
>>>>         init.ops = gate->ops;
>>>> +       if (mtk_cg_uses_hwv(init.ops) && !regmap_hwv) {
>>>> +               dev_err(dev, "regmap not found for hardware voter clocks\n");
>>>> +               return ERR_PTR(-ENXIO);
>>>
>>> return dev_err_probe()?
>>>
>>> I believe the same applies to the previous patch.
>>>
>>
>> mtk_clk_register_gate and mtk_clk_register_mux actually both return a
>> struct clk_hw *.
>
> Oops, you're right. If that case I believe dev_err_ptr_probe() could be
> used?

Indeed, thanks for the pointer. I'll fix it in the next revision.

Laura

