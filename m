Return-Path: <netdev+bounces-40550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F107C7A6C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408AF282B5E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB272B5D7;
	Thu, 12 Oct 2023 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbEckeNT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A113D03E
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 23:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207B5C433C8;
	Thu, 12 Oct 2023 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697153405;
	bh=y/FkUr/MyNlRX1DbU8ygsuC1i4kJtlBIup5GFvsNN7o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FbEckeNT8863IDZcMhJEvoKu4qKnHW9uHgJgKAsxiaDLTh1rJGi6NZkaLacieVXSs
	 vM6bgM0ct4LBwaCiKEIdJZ4m7lVM5iUqFQ15/cGEtblSA3fPAvQDEl+smVp4mxaRqO
	 rQlzaxVszZQYWQ6gw4wvXbGz29Tr0ZNSUDseyQii4UHwUj01uE525Gjp+bzTjV/HoP
	 yb+5UqFcw7ojUGr/fKRjeKV5y4OMOiLtdp+c9Af+XLsEylOOrjCaPBXguo8f0wfC+w
	 8igvMVRLD+j4BH/GB/lOBgzoKMVT/bzzFGL64QCkKeFuRMoUzMBzpgADHmWJak070k
	 SvltBycBwV1+g==
Message-ID: <4be60c499a39fcca374bc8f8574a952e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231003120402.4186270-1-niravkumar.l.rabara@intel.com>
References: <20231003120402.4186270-1-niravkumar.l.rabara@intel.com>
Subject: Re: [PATCH v3] clk: socfpga: agilex: add support for the Intel Agilex5
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, netdev@vger.kernel.org, Niravkumar L Rabara <niravkumar.l.rabara@intel.com>, Teh Wen Ping <wen.ping.teh@intel.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Michael Turquette <mturquette@baylibre.com>, niravkumar.l.rabara@intel.com
Date: Thu, 12 Oct 2023 16:30:02 -0700
User-Agent: alot/0.10

Quoting niravkumar.l.rabara@intel.com (2023-10-03 05:04:02)
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>=20
> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
> driver for the Agilex5 is very similar to the Agilex platform, so
> it is reusing most of the Agilex clock driver code.
>=20
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>=20
> Changes in v3:
> - Used different name for stratix10_clock_data pointer.
> - Used a single function call, devm_platform_ioremap_resource().
> - Used only .name in clk_parent_data.
>=20
> Stephen suggested to use .fw_name or .index, But since the changes are on=
 top
> of existing driver and current driver code is not using clk_hw and removi=
ng
> .name and using .fw_name and/or .index resulting in parent clock_rate &
> recalc_rate to 0.
>=20
> In order to use .index, I would need to refactor the common code that is =
shared
> by a few Intel SoCFPGA platforms (S10, Agilex and N5x). So, if using .nam=
e for
> this patch is acceptable then I will upgrade clk-agilex.c in future submi=
ssion.

It is not acceptable. We don't want there to only be a name member set
in a clk_parent_data structure. In fact, this driver is simply wrong
because it has many clk_parent_data structures with .fw_name =3D=3D .name
and I don't see any 'clock-names' property in the DT bindings. The
driver looks like it should simply use clk_hw pointers directly and stop
using clk_parent_data structures entirely.

> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-a=
gilex.c
> index 6b65a74aefa6..38ea7e7f600b 100644
> --- a/drivers/clk/socfpga/clk-agilex.c
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2019, Intel Corporation
> + * Copyright (C) 2019-2023, Intel Corporation
>   */
>  #include <linux/slab.h>
>  #include <linux/clk-provider.h>
> @@ -8,6 +8,7 @@
>  #include <linux/platform_device.h>
> =20
>  #include <dt-bindings/clock/agilex-clock.h>
> +#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
> =20
>  #include "stratix10-clk.h"
> =20
> @@ -40,6 +41,44 @@ static const struct clk_parent_data mpu_free_mux[] =3D=
 {
>           .name =3D "f2s-free-clk", },
>  };
> =20
> +static const struct clk_parent_data core0_free_mux[] =3D {
> +       { .name =3D "main_pll_c1" },

This is equivalent to the above.

	{ .name =3D "main_pll_c1", .index =3D 0 },

and thus the index will be used. Luckily there's no clocks property in
DT? But it also means that you're trying to lookup a clk from DT and
falling back to the name field eventually, i.e. we're wasting time
during parent discovery.

> +       { .name =3D "peri_pll_c0" },
> +       { .name =3D "osc1" },
> +       { .name =3D "cb-intosc-hs-div2-clk" },
> +       { .name =3D "f2s-free-clk" },
> +};
> +

