Return-Path: <netdev+bounces-225028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB344B8D6F0
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 09:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D1E3BB175
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD12BFC73;
	Sun, 21 Sep 2025 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="USIka42/"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BA282EE
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758440935; cv=none; b=qAzy/2KVMTrPy6HNHjEIfmXH94YT3yOwZfrzrEpNNCdhdxrbXfFwY7Lsq5nbM0Vw2Lp+UkEfxa2uXNdiyRGQyoNgxY6fBJeRLEH7Xc07Yatz+w8GOBQ0u/ssD/Mg3oScDt4Pq+d9/SAOAPR3NULqsjmEg/0KE2mdrp3EEOxsC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758440935; c=relaxed/simple;
	bh=96Di8PQJOj4vx5UF7p0CFZOAI172EzoeJ2de97raCDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYXvVNiyKnwp2zeA2o9j6Mj/ryBxfYUWNj5UFGfX8rPWStnixkDpfwlZ/vhGj+NkyN2nWSm8t7clwpEHfbx6hVHVZD8oJrvzae8pDRPKl0+FxSXilKjJyJ435XAKuFtNvZh4bEY7fiu8xfSqDv7vsVZoK+7TMOWfqX/tiTRAC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=USIka42/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB8AA1400100;
	Sun, 21 Sep 2025 03:48:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 21 Sep 2025 03:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758440931; x=1758527331; bh=Hc6QtXDJ7tlzrwjnSj3V03XbZUuZrtAq1cO
	xm/cxBTo=; b=USIka42/AhhxDPzvpHd1jyzSX05ksdql6hWI1U45MoF+vuY5Rkt
	YQyRfiwldmmWEN1Enodhd1pbJOI2yQ5R7V0i9YNnljb+2WNNetsZgbtNJE9vfws2
	csQcpo6Nf2eub7lhK/PM5hnpTxDFKI8q0q4BtNaC8AopMiuhIkEh6eCpZ6uLh7Md
	N7Hc2hgWCXXD/OnWUqCOH/1/w8816YmE9W4eF+Xc2eBQ3OV/pdehGWyyjrtQ84No
	sa0ULwX021tBaGojX59eZQduqgXimIkMa1p+ZSYSK6I+KDhHaVwBXF0C4/vzr5w2
	qo1A3a4HffnaFfo70eKULyhhNSVILcNJrIQ==
X-ME-Sender: <xms:4q3PaMG0klJDU7aJkWdaqJiTnZGR8i9IWBjz6dh15zWsGNr-nlgslA>
    <xme:4q3PaG34qbnKvdbOmLsOCqmK_xvwdX4c9Zxw94KOjgS5PTsDjIZizTt8kbQKhvy2d
    yPElGjt1r_UJ9g>
X-ME-Received: <xmr:4q3PaDyNsm_N0xPVIJs6w-qB2X6rH3xVgv2J3NYexTQFhFOZi_r87SHa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehgeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgt
    hhdrohhrgheqnecuggftrfgrthhtvghrnhepledtgeeviefftdekuedvudehleeuhfduje
    fggefhtddtkedvhffgheeftddvvdejnecuffhomhgrihhnpehqshhfphdrphgrghgvpdhq
    shhfphdrsggrnhhkpdhqshhfphdruggrthgrnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgs
    pghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmohhhsh
    hinhdrsggrshhhrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgigrnhguvghrughuhigtkh
    esfhgsrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvh
    gvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepghhushhtrghvohgrrhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4q3PaFi9-UHWUf0wtE9t-J_jtOpRQ-EA8zDxM__B87oz3UGJBmJRUA>
    <xmx:4q3PaCxKu_EOwzSFSfpsnLpXsMAVw6CFPfKMsy2mAnUU3A2JTgaENg>
    <xmx:4q3PaDw8kQTv6Igv4Mq6y4eNdu-ihSD680u7DxAr_56NDa5d9u4uKA>
    <xmx:4q3PaMokX19nLtRS2Nn5pHMJZy0PiGal_SO-jz8F1OH1tKLw5R6A7Q>
    <xmx:463PaMzjj3YYbRmBupCBCsu1w1cCprrlJ4zRUw6w8ykNR2LgNQqCKt80>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 03:48:50 -0400 (EDT)
Date: Sun, 21 Sep 2025 10:48:48 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	gustavoars@kernel.org, horms@kernel.org, jacob.e.keller@intel.com,
	kees@kernel.org, kernel-team@meta.com, lee@trager.us,
	linux@armlinux.org.uk, pabeni@redhat.com, sanman.p211993@gmail.com,
	suhui@nfschina.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next] eth: fbnic: Read module EEPROM
Message-ID: <aM-t4IBZFFHE9f-V@shredder>
References: <20250919191624.1239810-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919191624.1239810-1-mohsin.bashr@gmail.com>

On Fri, Sep 19, 2025 at 12:16:24PM -0700, Mohsin Bashir wrote:
> Add support to read module EEPROM for fbnic. Towards this, add required
> support to issue a new command to the firmware and to receive the response
> to the corresponding command.
> 
> Create a local copy of the data in the completion struct before writing to
> ethtool_module_eeprom to avoid writing to data in case it is freed. Given
> that EEPROM pages are small, the overhead of additional copy is
> negligible.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

See a few questions below

> ---
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  66 +++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 135 ++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  22 +++
>  3 files changed, 223 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index b4ff98ee2051..f6069cddffa5 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -1635,6 +1635,71 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
>  	}
>  }
>  
> +static int
> +fbnic_get_module_eeprom_by_page(struct net_device *netdev,
> +				const struct ethtool_module_eeprom *page_data,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	struct fbnic_fw_completion *fw_cmpl;
> +	struct fbnic_dev *fbd = fbn->fbd;
> +	int err;
> +
> +	if (page_data->i2c_address != 0x50) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid i2c address. Only 0x50 is supported");
> +		return -EINVAL;
> +	}
> +
> +	if (page_data->bank != 0) {

What is the reason for this check?

I understand that it's very unlikely to have a transceiver with banked
pages connected to this NIC (requires more than 8 lanes), but it's
generally better to not restrict this ethtool operation unless you have
a good reason to, especially when the firmware seems to support banked
pages.

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid bank. Only 0 is supported");
> +		return -EINVAL;
> +	}
> +
> +	fw_cmpl = __fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_QSFP_READ_RESP,

QSFP is not the most accurate term, but I assume it's named that way to
be consistent with the HW/FW data sheet.

> +					page_data->length);
> +	if (!fw_cmpl)
> +		return -ENOMEM;
> +
> +	/* Initialize completion and queue it for FW to process */
> +	fw_cmpl->u.qsfp.length = page_data->length;
> +	fw_cmpl->u.qsfp.offset = page_data->offset;
> +	fw_cmpl->u.qsfp.page = page_data->page;
> +	fw_cmpl->u.qsfp.bank = page_data->bank;
> +
> +	err = fbnic_fw_xmit_qsfp_read_msg(fbd, fw_cmpl, page_data->page,
> +					  page_data->bank, page_data->offset,
> +					  page_data->length);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Failed to transmit EEPROM read request");
> +		goto exit_free;
> +	}
> +
> +	if (!wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
> +		err = -ETIMEDOUT;
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Timed out waiting for firmware response");
> +		goto exit_cleanup;
> +	}
> +
> +	if (fw_cmpl->result) {
> +		err = fw_cmpl->result;
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to read EEPROM");
> +		goto exit_cleanup;
> +	}
> +
> +	memcpy(page_data->data, fw_cmpl->u.qsfp.data, page_data->length);
> +
> +exit_cleanup:
> +	fbnic_mbx_clear_cmpl(fbd, fw_cmpl);
> +exit_free:
> +	fbnic_fw_put_cmpl(fw_cmpl);
> +
> +	return err ? : page_data->length;
> +}

[...]

> +static int fbnic_fw_parse_qsfp_read_resp(void *opaque,
> +					 struct fbnic_tlv_msg **results)
> +{
> +	struct fbnic_fw_completion *cmpl_data;
> +	struct fbnic_dev *fbd = opaque;
> +	struct fbnic_tlv_msg *data_hdr;
> +	u32 length, offset, page, bank;
> +	u8 *data;
> +	s32 err;
> +
> +	/* Verify we have a completion pointer to provide with data */
> +	cmpl_data = fbnic_fw_get_cmpl_by_type(fbd,
> +					      FBNIC_TLV_MSG_ID_QSFP_READ_RESP);
> +	if (!cmpl_data)
> +		return -ENOSPC;
> +
> +	bank = fta_get_uint(results, FBNIC_FW_QSFP_BANK);
> +	if (bank != cmpl_data->u.qsfp.bank) {
> +		dev_warn(fbd->dev, "bank not equal to bank requested: %d vs %d\n",
> +			 bank, cmpl_data->u.qsfp.bank);
> +		err = -EINVAL;
> +		goto msg_err;
> +	}
> +
> +	page = fta_get_uint(results, FBNIC_FW_QSFP_PAGE);
> +	if (page != cmpl_data->u.qsfp.page) {

Out of curiosity, can this happen if user space tries to access a page
that is not supported by the transceiver? I believe most implementations
do not return an error in this case.

> +		dev_warn(fbd->dev, "page not equal to page requested: %d vs %d\n",
> +			 page, cmpl_data->u.qsfp.page);
> +		err = -EINVAL;
> +		goto msg_err;
> +	}

