Return-Path: <netdev+bounces-209310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A12B0EFEE
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C64A1AA38B7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B2028466F;
	Wed, 23 Jul 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY6pKQq8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F027FB16;
	Wed, 23 Jul 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266957; cv=none; b=QAm3yowDBL78q8Ps3xCf+4UcpLo6Y23wJ4QYgO5a6rnaKrtnYnNHM4aoPgg0O4jRmNNAMcgh2rXoM1TuKTQFkLc+xqoC7HgwCOJunlKRXPnH8JWPyGrXlaePnU76IZu5plWvslk3ob4CVQm4VZbzoYjToIBfKqOlz3w6joL0pRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266957; c=relaxed/simple;
	bh=cJeftLriWrLbVNEaXDZWfCkVPaVSCfDT05EzFNVqUKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwtLits7vhdLeL14YekiHyxsG8udqwBYky1oBPDb+nwil3qs3+jp8YLDl3Vd9ZfwYG0P5Aw41McgEVBEakcH2te5CqjxtA7pYeerj11n+DmrbPnFcgbO4cwodSvVjGcFdzn7H4VgIW2EA6wajIxyqIHdh7+ilGkdLlAg78/r/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY6pKQq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEC9C4CEE7;
	Wed, 23 Jul 2025 10:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753266956;
	bh=cJeftLriWrLbVNEaXDZWfCkVPaVSCfDT05EzFNVqUKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FY6pKQq8oN0l6sVsEmuTeRmNQqpswc2aywTudkIVIcFBcHQsaqjbvfDVAQ33Ubw/F
	 gMS0SmR81MtFn+ZCiA7XhMVUpXrY+fAVytHk4k9qj0f8EPkZ3kdeoa6we3p/vQz4G6
	 7RaaYqStg+1PL2lS9SJJ6touGJUAWuZNSWbJNnxQc0LnaRGIkjEiti0yRo7V21uxjJ
	 F/qm6OahJ6xeIjZqp4tz7jjuUKAo2H6vOjlIB/OmNKBnKjEBYVeOxE+kxxIuw7u0Du
	 L3/uuquHeN0BsL3YIaSun2Iq22dedSMvg3yyg8ntgYadL29gsNFJ0jrkPjcWKgsTXu
	 SlgcpfPtfiPYg==
Date: Wed, 23 Jul 2025 11:35:49 +0100
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
Subject: Re: [PATCH net-next v10 6/8] hinic3: Mailbox framework
Message-ID: <20250723103549.GY2459@horms.kernel.org>
References: <cover.1753152592.git.zhuyikai1@h-partners.com>
 <6233841053851b93390df642f65b2bc4c4646abe.1753152592.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6233841053851b93390df642f65b2bc4c4646abe.1753152592.git.zhuyikai1@h-partners.com>

On Tue, Jul 22, 2025 at 03:18:45PM +0800, Fan Gong wrote:

...

> +static void recv_mbox_handler(struct hinic3_mbox *mbox,
> +			      u64 *header, struct hinic3_msg_desc *msg_desc)
> +{
> +	void *mbox_body = MBOX_BODY_FROM_HDR(((void *)header));
> +	u64 mbox_header = *header;
> +	u8 seq_id, seg_len;
> +	int pos;
> +
> +	if (!mbox_segment_valid(mbox, msg_desc, mbox_header)) {
> +		msg_desc->seq_id = MBOX_SEQ_ID_MAX_VAL;
> +		return;
> +	}
> +
> +	seq_id = MBOX_MSG_HEADER_GET(mbox_header, SEQID);
> +	seg_len = MBOX_MSG_HEADER_GET(mbox_header, SEG_LEN);
> +
> +	pos = seq_id * MBOX_SEG_LEN;
> +	memcpy((u8 *)msg_desc->msg + pos, mbox_body, seg_len);

It would be nice if msg_desc->msg and mbox_body had more meaningful types
than void *. If they are being treated as an array of bytes, then
maybe u8 *?

> +
> +	if (!MBOX_MSG_HEADER_GET(mbox_header, LAST))
> +		return;
> +
> +	msg_desc->msg_len = MBOX_MSG_HEADER_GET(mbox_header, MSG_LEN);
> +	msg_desc->msg_info.status = MBOX_MSG_HEADER_GET(mbox_header, STATUS);
> +
> +	if (MBOX_MSG_HEADER_GET(mbox_header, DIRECTION) == MBOX_MSG_RESP)
> +		resp_mbox_handler(mbox, msg_desc);
> +}
> +
> +void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
> +				   u8 size)
> +{
> +	u64 mbox_header = *((u64 *)header);
> +	enum mbox_msg_direction_type dir;
> +	struct hinic3_msg_desc *msg_desc;
> +	struct hinic3_mbox *mbox;
> +	u16 src_func_id;
> +
> +	mbox = hwdev->mbox;
> +	dir = MBOX_MSG_HEADER_GET(mbox_header, DIRECTION);
> +	src_func_id = MBOX_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
> +	msg_desc = get_mbox_msg_desc(mbox, dir, src_func_id);
> +	recv_mbox_handler(mbox, (u64 *)header, msg_desc);

I would suggest dropping the cast and changing recv_mbox_handler()
to expect header to be a u8 *. I think you can then drop the cast above,
the one at of the argument passed to MBOX_BODY_FROM_HDR()
and the one inside MBOX_BODY_FROM_HDR().

I'd also suggest that MBOX_BODY_FROM_HDR be changed to a
static function so there is some type checking of the argument.

> +}

...

