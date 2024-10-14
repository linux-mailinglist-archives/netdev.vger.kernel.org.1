Return-Path: <netdev+bounces-135153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3999C849
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8ED1F23EC3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E3D1A01C5;
	Mon, 14 Oct 2024 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DSyIH1Na"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160F19CD0E
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903954; cv=none; b=H/BXUcWHVmrJiFNeMG8TPiPmuUvexJM2fzqQ5VgBqD0ONyLkWU2SvObOd6iXoga/4yujapZzx/nJ2tKeCvP1yA6c9Locmcsk9coqa5jqsWX4YRWbFgS264FSZTHWAoD/wXrDEypwq+v8UtDb5pWJLy+DgRF5tziTlAPsrUJvoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903954; c=relaxed/simple;
	bh=SZduyd5PlZwbvcO1kNCCzjkc3tuS/Im4y2OrFxkyM+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvVt7dZIkM928VfL85d9R8vpQVUFsq+l1iIbnE2c7okpE2p7EE5/7uKPXd3b/Ff5t0vkJafixui99qH1UsSbADydyoHcSUZ+z/CesA99JghoRG0ST6DpqjgEvfDsIVpAWm6hAfS7QA2dkmpMjFVk93FCg2ScWAYaAYmboXbMkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DSyIH1Na; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ece8648c-e555-4a7a-9b73-8a8e7afd7b05@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728903949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bztqRj+LjYKMuLBZdcPQ7znVekB8Zzh9IllBzUVGDRk=;
	b=DSyIH1NaLNaJTuAWWFqza4OdmoPV91a7X6BueZCvfJ7Zcvr/GgJ8xKqPJloDP5IokABKcv
	yBFlHC8gY75uF1VbE3FGg8vtRdV1lM6GPrGoImmFdku50EWMF0WmRBGsH3V+IspSxt55tu
	fhqLpmkRT0foO/Qx342I0TuOPbb4lM0=
Date: Mon, 14 Oct 2024 12:05:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] eth: fbnic: Add mailbox support for PLDM
 updates
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Simon Horman <horms@kernel.org>,
 Sanman Pradhan <sanmanpradhan@meta.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241012023646.3124717-1-lee@trager.us>
 <20241012023646.3124717-2-lee@trager.us>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241012023646.3124717-2-lee@trager.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/10/2024 03:34, Lee Trager wrote:
> This adds driver support to utilize the kernel completion API. This allows
> the driver to block on a response from firmware. Initially
> fbnic_fw_completion only has support for updates, future patches will add
> additional features.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic.h    |   1 +
>   drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 263 +++++++++++++++++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  59 +++++
>   3 files changed, 323 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index ca59261f0155..f58727e6e45a 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -31,6 +31,7 @@ struct fbnic_dev {
> 
>   	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
>   	struct fbnic_fw_cap fw_cap;
> +	struct fbnic_fw_completion *cmpl_data;
>   	/* Lock protecting Tx Mailbox queue to prevent possible races */
>   	spinlock_t fw_tx_lock;
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 8f7a2a19ddf8..deebff3b6821 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -207,6 +207,38 @@ static int fbnic_mbx_map_tlv_msg(struct fbnic_dev *fbd,
>   	return err;
>   }
> 
> +static int fbnic_mbx_map_req_w_cmpl(struct fbnic_dev *fbd,
> +				    struct fbnic_tlv_msg *msg,
> +				    struct fbnic_fw_completion *cmpl_data)
> +{
> +	unsigned long flags;
> +	int err;
> +
> +	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
> +
> +	/* If we are already waiting on a completion then abort */
> +	if (cmpl_data && fbd->cmpl_data) {
> +		err = -EBUSY;
> +		goto unlock_mbx;
> +	}
> +
> +	/* Record completion location and submit request */
> +	if (cmpl_data)
> +		fbd->cmpl_data = cmpl_data;
> +
> +	err = fbnic_mbx_map_msg(fbd, FBNIC_IPC_MBX_TX_IDX, msg,
> +				le16_to_cpu(msg->hdr.len) * sizeof(u32), 1);
> +
> +	/* If msg failed then clear completion data for next caller */
> +	if (err && cmpl_data)
> +		fbd->cmpl_data = NULL;
> +
> +unlock_mbx:
> +	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
> +
> +	return err;
> +}
> +
>   static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
>   {
>   	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
> @@ -651,6 +683,225 @@ void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd)
>   		dev_warn(fbd->dev, "Failed to send heartbeat message\n");
>   }
> 
> +/**
> + * fbnic_fw_xmit_fw_start_upgrade - Create and transmit a start update message
> + * @fbd: FBNIC device structure
> + * @cmpl_data: Completion data for upgrade process
> + * @id: Component ID
> + * @len: Length of FW update package data
> + *
> + * Return: zero on success, negative value on failure
> + *
> + * Asks the FW to prepare for starting a firmware upgrade
> + */
> +int fbnic_fw_xmit_fw_start_upgrade(struct fbnic_dev *fbd,
> +				   struct fbnic_fw_completion *cmpl_data,
> +				   unsigned int id, unsigned int len)
> +{
> +	struct fbnic_tlv_msg *msg;
> +	int err;
> +
> +	if (!len)
> +		return -EINVAL;
> +
> +	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_START_UPGRADE_SECTION, id);
> +	if (err)
> +		goto free_message;
> +
> +	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_START_UPGRADE_IMAGE_LENGTH,
> +				     len);
> +	if (err)
> +		goto free_message;
> +
> +	err = fbnic_mbx_map_req_w_cmpl(fbd, msg, cmpl_data);
> +	if (err)
> +		goto free_message;
> +
> +	return 0;
> +
> +free_message:
> +	free_page((unsigned long)msg);
> +	return err;
> +}
> +
> +static const struct fbnic_tlv_index fbnic_fw_start_upgrade_resp_index[] = {
> +	FBNIC_TLV_ATTR_S32(FBNIC_FW_START_UPGRADE_ERROR),
> +	FBNIC_TLV_ATTR_LAST
> +};
> +
> +static int fbnic_fw_parse_fw_start_upgrade_resp(void *opaque,
> +						struct fbnic_tlv_msg **results)
> +{
> +	struct fbnic_dev *fbd = opaque;
> +	struct fbnic_fw_completion *cmpl_data;

Hi Lee!

Looks like you didn't follow reverse Xmas tree for variables here and
in several functions later, all about cmpl_data variable.

> +	int err = 0;
> +
> +	/* Verify we have a completion pointer */
> +	cmpl_data = READ_ONCE(fbd->cmpl_data);
> +	if (!cmpl_data ||
> +	    cmpl_data->msg_type != FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ)
> +		return -ENOSPC;
> +
> +	/* Check for errors */
> +	get_signed_result(FBNIC_FW_START_UPGRADE_ERROR, err);
> +
> +	cmpl_data->result = err;
> +	complete(&cmpl_data->done);
> +
> +	return 0;
> +}
> +
> +static const struct fbnic_tlv_index fbnic_fw_write_chunk_req_index[] = {
> +	FBNIC_TLV_ATTR_U32(FBNIC_FW_WRITE_CHUNK_OFFSET),
> +	FBNIC_TLV_ATTR_U32(FBNIC_FW_WRITE_CHUNK_LENGTH),
> +	FBNIC_TLV_ATTR_LAST
> +};
> +
> +static int fbnic_fw_parse_fw_write_chunk_req(void *opaque,
> +					     struct fbnic_tlv_msg **results)
> +{
> +	struct fbnic_dev *fbd = opaque;
> +	struct fbnic_fw_completion *cmpl_data;

here again...

> +	u32 length = 0, offset = 0;
> +	struct fbnic_tlv_msg *msg;
> +	int err;
> +
> +	/* Start by attempting to allocate a response to the message */
> +	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_RESP);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	/* Verify we have a completion pointer */
> +	cmpl_data = READ_ONCE(fbd->cmpl_data);
> +	if (!cmpl_data ||
> +	    cmpl_data->msg_type != FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ) {
> +		err = -ENOSPC;
> +		goto msg_err;
> +	}
> +
> +	/* Notify FW if the data link has been severed */
> +	if (!cmpl_data->fw_update.data) {
> +		err = -ECANCELED;
> +		goto msg_err;
> +	}
> +
> +	/* Pull length/offset pair and mark it as complete */
> +	get_unsigned_result(FBNIC_FW_WRITE_CHUNK_OFFSET, offset);
> +	get_unsigned_result(FBNIC_FW_WRITE_CHUNK_LENGTH, length);
> +
> +	/* Record offset and length for the response */
> +	if (offset) {
> +		err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_WRITE_CHUNK_OFFSET,
> +					     offset);
> +		if (err)
> +			goto msg_err;
> +	}
> +
> +	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_WRITE_CHUNK_LENGTH,
> +				     length);
> +	if (err)
> +		goto msg_err;
> +
> +	/* Verify length */
> +	if (!length || length > TLV_MAX_DATA) {
> +		err = -EINVAL;
> +		goto msg_err;
> +	}
> +
> +	/* Verify offset and length are within bounds */
> +	if (offset >= cmpl_data->fw_update.size ||
> +	    offset + length > cmpl_data->fw_update.size) {
> +		err = -EFAULT;
> +		goto msg_err;
> +	}
> +
> +	/* Add outbound data to message */
> +	err = fbnic_tlv_attr_put_value(msg, FBNIC_FW_WRITE_CHUNK_DATA,
> +				       cmpl_data->fw_update.data + offset,
> +				       length);
> +
> +	/* Notify the waiting thread that we processed a message */
> +	if (!err)
> +		cmpl_data->fw_update.last_offset = offset;
> +
> +	cmpl_data->result = err;
> +	complete(&cmpl_data->done);
> +
> +msg_err:
> +	/* Report error to FW if one occurred */
> +	if (err)
> +		fbnic_tlv_attr_put_int(msg, FBNIC_FW_WRITE_CHUNK_ERROR, err);
> +
> +	/* Map and send the response */
> +	err = fbnic_mbx_map_tlv_msg(fbd, msg);
> +	if (err)
> +		free_page((unsigned long)msg);
> +
> +	return err;
> +}
> +
> +static const struct fbnic_tlv_index fbnic_fw_verify_image_resp_index[] = {
> +	FBNIC_TLV_ATTR_S32(FBNIC_FW_VERIFY_IMAGE_ERROR),
> +	FBNIC_TLV_ATTR_LAST
> +};
> +
> +static int fbnic_fw_parse_fw_verify_image_resp(void *opaque,
> +					       struct fbnic_tlv_msg **results)
> +{
> +	struct fbnic_dev *fbd = opaque;
> +	struct fbnic_fw_completion *cmpl_data;

.. and again..

> +	int err = 0;
> +
> +	/* Verify we have a completion pointer */
> +	cmpl_data = READ_ONCE(fbd->cmpl_data);
> +	if (!cmpl_data ||
> +	    cmpl_data->msg_type != FBNIC_TLV_MSG_ID_FW_VERIFY_IMAGE_RESP)
> +		return -ENOSPC;
> +
> +	/* Check for errors */
> +	get_signed_result(FBNIC_FW_VERIFY_IMAGE_ERROR, err);
> +
> +	cmpl_data->result = err;
> +	complete(&cmpl_data->done);
> +
> +	return err;
> +}
> +
> +static const struct fbnic_tlv_index fbnic_fw_finish_upgrade_req_index[] = {
> +	FBNIC_TLV_ATTR_S32(FBNIC_FW_FINISH_UPGRADE_ERROR),
> +	FBNIC_TLV_ATTR_LAST
> +};
> +
> +static int fbnic_fw_parse_fw_finish_upgrade_req(void *opaque,
> +						struct fbnic_tlv_msg **results)
> +{
> +	struct fbnic_dev *fbd = opaque;
> +	struct fbnic_fw_completion *cmpl_data;

...and again...

> +	int err = 0;
> +
> +	/* Verify we have a completion pointer */
> +	cmpl_data = READ_ONCE(fbd->cmpl_data);
> +	if (!cmpl_data ||
> +	    cmpl_data->msg_type != FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ)
> +		return -ENOSPC;
> +
> +	/* Check for errors */
> +	get_signed_result(FBNIC_FW_FINISH_UPGRADE_ERROR, err);
> +
> +	/* Close out update by clearing data pointer */
> +	cmpl_data->fw_update.last_offset = cmpl_data->fw_update.size;
> +	cmpl_data->fw_update.data = NULL;
> +
> +	cmpl_data->result = err;
> +	complete(&cmpl_data->done);
> +
> +	return 0;
> +}
> +
>   static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
>   	FBNIC_TLV_PARSER(FW_CAP_RESP, fbnic_fw_cap_resp_index,
>   			 fbnic_fw_parse_cap_resp),
> @@ -658,6 +909,18 @@ static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
>   			 fbnic_fw_parse_ownership_resp),
>   	FBNIC_TLV_PARSER(HEARTBEAT_RESP, fbnic_heartbeat_resp_index,
>   			 fbnic_fw_parse_heartbeat_resp),
> +	FBNIC_TLV_PARSER(FW_START_UPGRADE_RESP,
> +			 fbnic_fw_start_upgrade_resp_index,
> +			 fbnic_fw_parse_fw_start_upgrade_resp),
> +	FBNIC_TLV_PARSER(FW_WRITE_CHUNK_REQ,
> +			 fbnic_fw_write_chunk_req_index,
> +			 fbnic_fw_parse_fw_write_chunk_req),
> +	FBNIC_TLV_PARSER(FW_VERIFY_IMAGE_RESP,
> +			 fbnic_fw_verify_image_resp_index,
> +			 fbnic_fw_parse_fw_verify_image_resp),
> +	FBNIC_TLV_PARSER(FW_FINISH_UPGRADE_REQ,
> +			 fbnic_fw_finish_upgrade_req_index,
> +			 fbnic_fw_parse_fw_finish_upgrade_req),
>   	FBNIC_TLV_MSG_ERROR
>   };
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> index 221faf8c6756..a638d73d2da5 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> @@ -44,6 +44,19 @@ struct fbnic_fw_cap {
>   	u8	link_fec;
>   };
> 
> +struct fbnic_fw_completion {
> +	u32 msg_type;
> +	struct completion done;
> +	int result;
> +	union {
> +		struct {
> +			u32 size;
> +			u32 last_offset;
> +			const u8 *data;
> +		} fw_update;
> +	};
> +};
> +
>   void fbnic_mbx_init(struct fbnic_dev *fbd);
>   void fbnic_mbx_clean(struct fbnic_dev *fbd);
>   void fbnic_mbx_poll(struct fbnic_dev *fbd);
> @@ -52,6 +65,9 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
>   int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
>   int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
>   void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
> +int fbnic_fw_xmit_fw_start_upgrade(struct fbnic_dev *fbd,
> +				   struct fbnic_fw_completion *cmpl_data,
> +				   unsigned int id, unsigned int len);
> 
>   #define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
>   do {									\
> @@ -67,6 +83,15 @@ do {									\
>   #define fbnic_mk_fw_ver_str(_rev_id, _str) \
>   	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str, sizeof(_str))
> 
> +enum {
> +	QSPI_SECTION_CMRT			= 0,
> +	QSPI_SECTION_CONTROL_FW			= 1,
> +	QSPI_SECTION_UCODE			= 2,
> +	QSPI_SECTION_OPTION_ROM			= 3,
> +	QSPI_SECTION_USER			= 4,
> +	QSPI_SECTION_INVALID,
> +};
> +
>   #define FW_HEARTBEAT_PERIOD		(10 * HZ)
> 
>   enum {
> @@ -76,6 +101,14 @@ enum {
>   	FBNIC_TLV_MSG_ID_OWNERSHIP_RESP			= 0x13,
>   	FBNIC_TLV_MSG_ID_HEARTBEAT_REQ			= 0x14,
>   	FBNIC_TLV_MSG_ID_HEARTBEAT_RESP			= 0x15,
> +	FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ		= 0x22,
> +	FBNIC_TLV_MSG_ID_FW_START_UPGRADE_RESP		= 0x23,
> +	FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ		= 0x24,
> +	FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_RESP		= 0x25,
> +	FBNIC_TLV_MSG_ID_FW_VERIFY_IMAGE_REQ		= 0x26,
> +	FBNIC_TLV_MSG_ID_FW_VERIFY_IMAGE_RESP		= 0x27,
> +	FBNIC_TLV_MSG_ID_FW_FINISH_UPGRADE_REQ		= 0x28,
> +	FBNIC_TLV_MSG_ID_FW_FINISH_UPGRADE_RESP		= 0x29,
>   };
> 
>   #define FBNIC_FW_CAP_RESP_VERSION_MAJOR		CSR_GENMASK(31, 24)
> @@ -121,4 +154,30 @@ enum {
>   	FBNIC_FW_OWNERSHIP_FLAG			= 0x0,
>   	FBNIC_FW_OWNERSHIP_MSG_MAX
>   };
> +
> +enum {
> +	FBNIC_FW_START_UPGRADE_ERROR		= 0x0,
> +	FBNIC_FW_START_UPGRADE_SECTION		= 0x1,
> +	FBNIC_FW_START_UPGRADE_IMAGE_LENGTH	= 0x2,
> +	FBNIC_FW_START_UPGRADE_MSG_MAX
> +};
> +
> +enum {
> +	FBNIC_FW_WRITE_CHUNK_OFFSET		= 0x0,
> +	FBNIC_FW_WRITE_CHUNK_LENGTH		= 0x1,
> +	FBNIC_FW_WRITE_CHUNK_DATA		= 0x2,
> +	FBNIC_FW_WRITE_CHUNK_ERROR		= 0x3,
> +	FBNIC_FW_WRITE_CHUNK_MSG_MAX
> +};
> +
> +enum {
> +	FBNIC_FW_VERIFY_IMAGE_ERROR		= 0x0,
> +	FBNIC_FW_VERIFY_IMAGE_MSG_MAX
> +};
> +
> +enum {
> +	FBNIC_FW_FINISH_UPGRADE_ERROR		= 0x0,
> +	FBNIC_FW_FINISH_UPGRADE_MSG_MAX
> +};
> +
>   #endif /* _FBNIC_FW_H_ */
> --
> 2.43.5


