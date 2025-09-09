Return-Path: <netdev+bounces-221263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC9EB4FF44
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AE61C20CFC
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7734AAF4;
	Tue,  9 Sep 2025 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CkVOYSqb"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C51346A19;
	Tue,  9 Sep 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427819; cv=none; b=gbil1tmyLoLIhqDK2DdokzRru3vLsYWbRiTey3938ycALPBdkKd3Iyx7vX54Fbyj4W9gQYAKMua+r7XqbRVdzF/P4HVu4hAzAtyTVrx2p6B3gVVHapCIqUcaZmsJT4kfHxNY+jSTjDTtvfYqB+NcscGSaH2wp2aXccptQWt8qoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427819; c=relaxed/simple;
	bh=l8m/snQEYqONbXpHtup7kHAtv1F0u1xttQFSmMjBlIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cAfecFy2jocf+slPF2up17PlP8Xv12oh/I7454OvB2xOmMUaen8AHXYCEQyldokFSngKTCl8acpIAcZ9WvdR9Zb5Xn6OD5SepNEZDlGkdYYdxa6dgAIW5dBYAni87kpYtPxCg1cX2vaCismiNZITIVO2LbdQbPhzIp+rD6DI09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CkVOYSqb; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589EMW4R4042795;
	Tue, 9 Sep 2025 09:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757427752;
	bh=4+epmNqy1Eq8OIbrXco3iQgqzbgQ2IoiiAgqsfr9Uyw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CkVOYSqbUgFVJS9RsqJvz8KxSb83fxTBBRV3XvSx1VAVyE65HnXHP1LwZNd2BjaGp
	 ZaEjxXjeN/d3OyT1vTF0aVcoiLAESpnoNs9vBKSL3E04GWGjIUNTTVWqmo/P8XZ7oh
	 eZB+ZKz9D/A801t/0PzVL2ZGFdIR+oPNC8WFrANo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589EMWge3210850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 09:22:32 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 09:22:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 09:22:31 -0500
Received: from [10.249.130.74] ([10.249.130.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589EMM1D2460231;
	Tue, 9 Sep 2025 09:22:23 -0500
Message-ID: <54602bba-3ec1-4cae-b068-e9c215b43773@ti.com>
Date: Tue, 9 Sep 2025 19:52:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 3/5] net: rnpgbe: Add basic mbx ops support
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <danishanwar@ti.com>, <lee@trager.us>, <gongfan1@huawei.com>,
        <lorenzo@kernel.org>, <geert+renesas@glider.be>,
        <Parthiban.Veerasooran@microchip.com>, <lukas.bulwahn@redhat.com>,
        <alexanderduyck@fb.com>, <richardcochran@gmail.com>, <kees@kernel.org>,
        <gustavoars@kernel.org>, <rdunlap@infradead.org>,
        <vadim.fedorenko@linux.dev>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-4-dong100@mucse.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20250909120906.1781444-4-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 9/9/2025 5:39 PM, Dong Yibo wrote:
> Add fundamental mailbox (MBX) communication operations between PF (Physical
> Function) and firmware for n500/n210 chips
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 ++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  70 +++
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   7 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 425 ++++++++++++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
>  7 files changed, 555 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> index 9df536f0d04c..5fc878ada4b1 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> @@ -5,4 +5,6 @@
>  #

[ ... ]

> +
> +/**
> + * rnpgbe_init_hw - Setup hw info according to board_type
> + * @hw: hw information structure
> + * @board_type: board type
> + *
> + * rnpgbe_init_hw initializes all hw data
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	mbx->pf2fw_mbx_ctrl = MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
> +	mbx->fwpf_mbx_mask = MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
> +
> +	switch (board_type) {
> +	case board_n500:
> +		rnpgbe_init_n500(hw);
> +	break;
> +	case board_n210:
> +		rnpgbe_init_n210(hw);
> +	break;
> +	default:
> +		return -EINVAL;
> +	}

The indentation of this switch block seems off to me.

As per the coding guidlines
https://www.kernel.org/doc/html/v4.14/process/coding-style.html#indentation

Break statements should be at the same indentation level as the case
code. The current indentation has the "break" statements at the same
level as the case labels, which is inconsistent.

This should be like,

	switch (board_type) {
	case board_n500:
		rnpgbe_init_n500(hw);
		break;
	case board_n210:
		rnpgbe_init_n210(hw);
		break;
	default:
		return -EINVAL;
	}

> +	/* init_params with mbx base */
> +	mucse_init_mbx_params_pf(hw);
> +
> +	return 0;
> +}

[ ... ]

> +/**
> + * mucse_read_mbx_pf - Read a message from the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * This function copies a message from the mailbox buffer to the caller's
> + * memory buffer. The presumption is that the caller knows that there was
> + * a message due to a fw request so no polling for message is needed.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int size_in_words = size / 4;
> +	int ret;
> +	int i;
> +
> +	ret = mucse_obtain_mbx_lock_pf(hw);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < size_in_words; i++)
> +		msg[i] = mbx_data_rd32(mbx, MUCSE_MBX_FWPF_SHM + 4 * i);

The array indexing calculation should use multiplication by sizeof(u32)
instead of hardcoded 4.

> +	/* Hw needs write data_reg at last */
> +	mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM, 0);
> +	/* flush reqs as we have read this request data */
> +	hw->mbx.fw_req = mucse_mbx_get_fwreq(mbx);
> +	mucse_mbx_inc_pf_ack(hw);
> +	mucse_release_mbx_lock_pf(hw, false);
> +
> +	return 0;
> +}
> +
> +/**
> + * mucse_check_for_msg_pf - Check to see if the fw has sent mail
> + * @hw: pointer to the HW structure
> + *
> + * Return: 0 if the fw has set the Status bit or else -EIO
> + **/
> +static int mucse_check_for_msg_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	u16 fw_req;
> +
> +	fw_req = mucse_mbx_get_fwreq(mbx);
> +	/* chip's register is reset to 0 when rc send reset
> +	 * mbx command. This causes 'fw_req != hw->mbx.fw_req'
> +	 * be TRUE before fw really reply. Driver must wait fw reset
> +	 * done reply before using chip, we must check no-zero.
> +	 **/
> +	if (fw_req != 0 && fw_req != hw->mbx.fw_req) {
> +		hw->mbx.stats.reqs++;
> +		return 0;
> +	}
> +
> +	return -EIO;
> +}
> +
> +/**
> + * mucse_poll_for_msg - Wait for message notification
> + * @hw: pointer to the HW structure
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int mucse_poll_for_msg(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int count = mbx->timeout_cnt;
> +	int val;
> +
> +	return read_poll_timeout(mucse_check_for_msg_pf,
> +				 val, !val, mbx->usec_delay,
> +				 count * mbx->usec_delay,
> +				 false, hw);
> +}
> +
> +/**
> + * mucse_poll_and_read_mbx - Wait for message notification and receive message
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * Return: 0 if it successfully received a message notification and
> + * copied it into the receive buffer
> + **/
> +int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	int ret;
> +
> +	ret = mucse_poll_for_msg(hw);
> +	if (ret)
> +		return ret;
> +
> +	return mucse_read_mbx_pf(hw, msg, size);
> +}
> +
> +/**
> + * mucse_mbx_get_fwack - Read fw ack from reg
> + * @mbx: pointer to the MBX structure
> + *
> + * Return: the fwack value
> + **/
> +static u16 mucse_mbx_get_fwack(struct mucse_mbx_info *mbx)
> +{
> +	u32 val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
> +
> +	return FIELD_GET(GENMASK_U32(31, 16), val);
> +}
> +
> +/**
> + * mucse_mbx_inc_pf_req - Increase req
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_inc_pf_req read pf_req from hw, then write
> + * new value back after increase
> + **/
> +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	u16 req;
> +	u32 val;
> +
> +	val = mbx_data_rd32(mbx, MUCSE_MBX_PF2FW_CNT);
> +	req = FIELD_GET(GENMASK_U32(15, 0), val);
> +	req++;
> +	val &= ~GENMASK_U32(15, 0);
> +	val |= FIELD_PREP(GENMASK_U32(15, 0), req);
> +	mbx_data_wr32(mbx, MUCSE_MBX_PF2FW_CNT, val);
> +	hw->mbx.stats.msgs_tx++;
> +}
> +
> +/**
> + * mucse_write_mbx_pf - Place a message in the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * This function maybe used in an irq handler.
> + *
> + * Return: 0 if it successfully copied message into the buffer
> + **/
> +static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int size_in_words = size / 4;
> +	int ret;
> +	int i;
> +
> +	ret = mucse_obtain_mbx_lock_pf(hw);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < size_in_words; i++)
> +		mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM + i * 4, msg[i]);

Same issue as above - should use sizeof(u32) instead of hardcoded 4 for
portability.

> +
> +	/* flush acks as we are overwriting the message buffer */
> +	hw->mbx.fw_ack = mucse_mbx_get_fwack(mbx);


-- 
Thanks and Regards,
Md Danish Anwar


