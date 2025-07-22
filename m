Return-Path: <netdev+bounces-208985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CCB0DF0A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F6580A1A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3665A2EAB79;
	Tue, 22 Jul 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwyTjM1d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077CC2E9EDD;
	Tue, 22 Jul 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194999; cv=none; b=ERObxmD5MzknDjNC5PoqsGyheE8HfgZseGUcx8BGZ7myeEJMsW0NW+ww+aQpfCbms1dDyX1iWMGI3JjMtJ2rblSKyjdPqdVwr4UaWz/EhWNuTOH5OjYeu78wGLo3C1y5HvUwC9w6OdGn2WVlXyQwjz+HhTEKlYeMPQYiaN7pk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194999; c=relaxed/simple;
	bh=+ApfbUF4C1g9qVelTRSoYzfc82+4UY/mCCK/gvuLJOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArRVm+URejLNDMuM287iFmBfPd0YqTfQnQqul7ifl9rDf83tmuRePG8bb4DwJCBsCh/yH371sn8aZh7TJxGffthvYrFF1MaW/VtTEWPjuyY3Fo9s8CnNyeovjaDlBfQCrLWSiSCx/ebMoCwf5iq+XMxhK1Ml2ga8qINBM2Eqbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwyTjM1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07FCC4CEEB;
	Tue, 22 Jul 2025 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753194996;
	bh=+ApfbUF4C1g9qVelTRSoYzfc82+4UY/mCCK/gvuLJOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwyTjM1dtLDo9iQyvpQC+hYtmo8MTL3e+6d7SyewrlGGzrrNQR2iO3rF1vVT+lvbJ
	 lyzMuQz86mlDQWFSJlDXGIvuEESVMd5lW/jSBw5JpTHkq4da9PebH+HEtfKqsAkq02
	 yI3W43XztBK+O3yypRc95Ye5lr45aTc01jVsibPHt7Mu+5S4cHI1/LXdVVwcAutSOP
	 Ue/DDxAW8cjN1OPPNRvnrBcxUbIDlmTLewwhW43Cbg3zp7RDLVW1uK3Hr0d000FepE
	 QVzUGuMXlc5Vy+atXak0xmedRpXgumfNeC7l2h0xSilbnbn9kic5D8eNUmg4bEau5W
	 VmdvwX+1CmlFg==
Date: Tue, 22 Jul 2025 15:36:29 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Fu Guiming <fuguiming@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250722143629.GL2459@horms.kernel.org>
References: <cover.1753152592.git.zhuyikai1@h-partners.com>
 <bea50c6c329c5ffb77cfe059e07eeed187619346.1753152592.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea50c6c329c5ffb77cfe059e07eeed187619346.1753152592.git.zhuyikai1@h-partners.com>

On Tue, Jul 22, 2025 at 03:18:40PM +0800, Fan Gong wrote:
> Add async event queue interfaces initialization.
> It allows driver to handle async events reported by HW.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c

...

> +int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
> +			   enum hinic3_aeq_type event,
> +			   hinic3_aeq_event_cb hwe_cb)
> +{
> +	struct hinic3_aeqs *aeqs;
> +	unsigned long *cb_state;

cb_state is set but otherwise unused in this function.
Probably it should be removed.

Flagged by GCC 15.1.0 and Clang 20.1.8 builds with
KCFLAGS=-Wunused-but-set-variable

> +
> +	aeqs = hwdev->aeqs;
> +	cb_state = &aeqs->aeq_cb_state[event];
> +	aeqs->aeq_cb[event] = hwe_cb;
> +	spin_lock_init(&aeqs->aeq_lock);
> +
> +	return 0;
> +}
> +
> +void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
> +			      enum hinic3_aeq_type event)
> +{
> +	struct hinic3_aeqs *aeqs;
> +	unsigned long *cb_state;

Ditto.

> +
> +	aeqs = hwdev->aeqs;
> +	cb_state = &aeqs->aeq_cb_state[event];
> +
> +	spin_lock_bh(&aeqs->aeq_lock);
> +	aeqs->aeq_cb[event] = NULL;
> +	spin_unlock_bh(&aeqs->aeq_lock);
> +}

...

> +static void aeq_event_handler(struct hinic3_aeqs *aeqs, u32 aeqe,
> +			      const struct hinic3_aeq_elem *aeqe_pos)
> +{
> +	struct hinic3_hwdev *hwdev = aeqs->hwdev;
> +	u8 data[HINIC3_AEQE_DATA_SIZE], size;
> +	enum hinic3_aeq_type event;
> +	hinic3_aeq_event_cb hwe_cb;
> +	unsigned long *cb_state;

Ditto.

> +
> +	if (EQ_ELEM_DESC_GET(aeqe, SRC))
> +		return;
> +
> +	event = EQ_ELEM_DESC_GET(aeqe, TYPE);
> +	if (event >= HINIC3_MAX_AEQ_EVENTS) {
> +		dev_warn(hwdev->dev, "Aeq unknown event:%d\n", event);
> +		return;
> +	}
> +
> +	memcpy(data, aeqe_pos->aeqe_data, HINIC3_AEQE_DATA_SIZE);
> +	hinic3_cmdq_buf_swab32(data, HINIC3_AEQE_DATA_SIZE);
> +	size = EQ_ELEM_DESC_GET(aeqe, SIZE);
> +	cb_state = &aeqs->aeq_cb_state[event];
> +
> +	spin_lock_bh(&aeqs->aeq_lock);
> +	hwe_cb = aeqs->aeq_cb[event];
> +	if (hwe_cb)
> +		hwe_cb(aeqs->hwdev, data, size);
> +	spin_unlock_bh(&aeqs->aeq_lock);
> +}

...

> +static void eq_calc_page_size_and_num(struct hinic3_eq *eq, u32 elem_size)
> +{
> +	u32 max_pages, min_page_size, page_size, total_size;
> +
> +	/* No need for complicated arithmetics. All values must be power of 2.

arithmetic

> +	 * Multiplications give power of 2 and divisions give power of 2 without
> +	 * remainder.
> +	 */
> +	max_pages = HINIC3_EQ_MAX_PAGES;
> +	min_page_size = HINIC3_MIN_PAGE_SIZE;
> +	total_size = eq->eq_len * elem_size;
> +
> +	if (total_size <= max_pages * min_page_size)
> +		page_size = min_page_size;
> +	else
> +		page_size = total_size / max_pages;
> +
> +	hinic3_queue_pages_init(&eq->qpages, eq->eq_len, page_size, elem_size);
> +}

...

