Return-Path: <netdev+bounces-110727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99AA92DF84
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 07:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7023C283A4B
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 05:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6607E792;
	Thu, 11 Jul 2024 05:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748074047
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675737; cv=none; b=J+G6Y9YeP2JVcNyoUkBaPKJoJmpGJqjHKMUcEjMbXE2RrEpMY8oUwczvEfRkPs3Ap9yPrKfQQdhkbW3fYvxEzeAXY0qkOEXxcwsIsGo2kYLBNd2ZlPSPFwY8/Q8qkICxxAt3jjNBwWSZ/gwX8NhnmkI5isGp1FkeOFUV1VjVx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675737; c=relaxed/simple;
	bh=gAjIWdpXPGSB0Pj/3BGXvMQx4dRMT9XfelZxiPGaZcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+rnZRYSQtV/M5UbtgwkvI7gTYeZ9xI20AOpXr4aWUozuh48rKQYEFh1tCK4CfWpGYF4nh78CVM10SBRTI0lIaJeta0BwE5j2ff2yDrLUEY6VMgVBJPnSoU82axkrb050rcnQX/cfUNHv/ylsy3rX5odLES97AEF7gbSPcrUbSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af435.dynamic.kabel-deutschland.de [95.90.244.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D134061E4050B;
	Thu, 11 Jul 2024 07:28:26 +0200 (CEST)
Message-ID: <ff7bb882-5285-49c7-bba7-0630be1abf22@molgen.mpg.de>
Date: Thu, 11 Jul 2024 07:28:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 02/13] ice: parse and init
 various DDP parser sections
To: Ahmed Zaki <ahmed.zaki@intel.com>, Junfeng Guo <junfeng.guo@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>, anthony.l.nguyen@intel.com,
 horms@kernel.org
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-3-ahmed.zaki@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240710204015.124233-3-ahmed.zaki@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ahmed, dear Junfeng,


Thank you for this patch.


Am 10.07.24 um 22:40 schrieb Ahmed Zaki:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Parse the following DDP sections:
>   - ICE_SID_RXPARSER_IMEM into an array of struct ice_imem_item
>   - ICE_SID_RXPARSER_METADATA_INIT into an array of struct ice_metainit_item
>   - ICE_SID_RXPARSER_CAM or ICE_SID_RXPARSER_PG_SPILL into an array of
>     struct ice_pg_cam_item
>   - ICE_SID_RXPARSER_NOMATCH_CAM or ICE_SID_RXPARSER_NOMATCH_SPILL into an
>     array of struct ice_pg_nm_cam_item
>   - ICE_SID_RXPARSER_CAM into an array of ice_bst_tcam_item
>   - ICE_SID_LBL_RXPARSER_TMEM into an array of ice_lbl_item
>   - ICE_SID_RXPARSER_MARKER_PTYPE into an array of ice_ptype_mk_tcam_item
>   - ICE_SID_RXPARSER_MARKER_GRP into an array of ice_mk_grp_item
>   - ICE_SID_RXPARSER_PROTO_GRP into an array of ice_proto_grp_item
>   - ICE_SID_RXPARSER_FLAG_REDIR into an array of ice_flg_rd_item
>   - ICE_SID_XLT_KEY_BUILDER_SW, ICE_SID_XLT_KEY_BUILDER_ACL,
>     ICE_SID_XLT_KEY_BUILDER_FD and ICE_SID_XLT_KEY_BUILDER_RSS into
>     struct ice_xlt_kb

Did you write this from hand, or do you have some scripts to convert it 
from some datasheet into code?

As the parser is new infrastructure, are you planing on adding some 
tests for the parser?

Could you also go into more detail on how to debug possible problems, 
that means, how to make sure, that the parser works correctly and how to 
debug it in case one suspects the parser has a problem.

> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ddp.c    |   10 +-
>   drivers/net/ethernet/intel/ice/ice_ddp.h    |   13 +
>   drivers/net/ethernet/intel/ice/ice_parser.c | 1396 +++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_parser.h |  357 +++++
>   drivers/net/ethernet/intel/ice/ice_type.h   |    1 +
>   5 files changed, 1772 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index f182179529b7..953262b88a58 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -289,11 +289,11 @@ void *ice_pkg_enum_section(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
>    * indicates a base offset of 10, and the index for the entry is 2, then
>    * section handler function should set the offset to 10 + 2 = 12.
>    */
> -static void *ice_pkg_enum_entry(struct ice_seg *ice_seg,
> -				struct ice_pkg_enum *state, u32 sect_type,
> -				u32 *offset,
> -				void *(*handler)(u32 sect_type, void *section,
> -						 u32 index, u32 *offset))
> +void *ice_pkg_enum_entry(struct ice_seg *ice_seg,
> +			 struct ice_pkg_enum *state, u32 sect_type,
> +			 u32 *offset,
> +			 void *(*handler)(u32 sect_type, void *section,
> +					  u32 index, u32 *offset))
>   {
>   	void *entry;
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
> index 622543f08b43..97f272317475 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
> @@ -261,10 +261,17 @@ struct ice_meta_sect {
>   #define ICE_SID_CDID_KEY_BUILDER_RSS 47
>   #define ICE_SID_CDID_REDIR_RSS 48
>   
> +#define ICE_SID_RXPARSER_CAM           50
> +#define ICE_SID_RXPARSER_NOMATCH_CAM   51
> +#define ICE_SID_RXPARSER_IMEM          52
>   #define ICE_SID_RXPARSER_MARKER_PTYPE 55
>   #define ICE_SID_RXPARSER_BOOST_TCAM 56
> +#define ICE_SID_RXPARSER_PROTO_GRP     57
>   #define ICE_SID_RXPARSER_METADATA_INIT 58
>   #define ICE_SID_TXPARSER_BOOST_TCAM 66
> +#define ICE_SID_RXPARSER_MARKER_GRP    72
> +#define ICE_SID_RXPARSER_PG_SPILL      76
> +#define ICE_SID_RXPARSER_NOMATCH_SPILL 78
>   
>   #define ICE_SID_XLT0_PE 80
>   #define ICE_SID_XLT_KEY_BUILDER_PE 81
> @@ -276,6 +283,7 @@ struct ice_meta_sect {
>   #define ICE_SID_CDID_KEY_BUILDER_PE 87
>   #define ICE_SID_CDID_REDIR_PE 88
>   
> +#define ICE_SID_RXPARSER_FLAG_REDIR	97
>   /* Label Metadata section IDs */
>   #define ICE_SID_LBL_FIRST 0x80000010
>   #define ICE_SID_LBL_RXPARSER_TMEM 0x80000018
> @@ -451,6 +459,11 @@ int ice_update_pkg(struct ice_hw *hw, struct ice_buf *bufs, u32 count);
>   
>   int ice_pkg_buf_reserve_section(struct ice_buf_build *bld, u16 count);
>   u16 ice_pkg_buf_get_active_sections(struct ice_buf_build *bld);
> +void *
> +ice_pkg_enum_entry(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
> +		   u32 sect_type, u32 *offset,
> +		   void *(*handler)(u32 sect_type, void *section,
> +				    u32 index, u32 *offset));
>   void *ice_pkg_enum_section(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
>   			   u32 sect_type);
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index 6c50164efae0..1f1a5a87f089 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -3,6 +3,1284 @@
>   
>   #include "ice_common.h"
>   
> +struct ice_pkg_sect_hdr {
> +	__le16 count;
> +	__le16 offset;
> +};
> +
> +/**
> + * ice_parser_sect_item_get - parse a item from a section

a*n* item

> + * @sect_type: section type
> + * @section: section object
> + * @index: index of the item to get
> + * @offset: dummy as prototype of ice_pkg_enum_entry's last parameter
> + *
> + * Return: a pointer to the item or NULL.
> + */
> +static void *ice_parser_sect_item_get(u32 sect_type, void *section,
> +				      u32 index, u32 __maybe_unused *offset)
> +{
> +	size_t data_off = ICE_SEC_DATA_OFFSET;
> +	struct ice_pkg_sect_hdr *hdr;
> +	size_t size;
> +
> +	if (!section)
> +		return NULL;
> +
> +	switch (sect_type) {
> +	case ICE_SID_RXPARSER_IMEM:
> +		size = ICE_SID_RXPARSER_IMEM_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_METADATA_INIT:
> +		size = ICE_SID_RXPARSER_METADATA_INIT_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_CAM:
> +		size = ICE_SID_RXPARSER_CAM_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_PG_SPILL:
> +		size = ICE_SID_RXPARSER_PG_SPILL_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_NOMATCH_CAM:
> +		size = ICE_SID_RXPARSER_NOMATCH_CAM_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_NOMATCH_SPILL:
> +		size = ICE_SID_RXPARSER_NOMATCH_SPILL_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_BOOST_TCAM:
> +		size = ICE_SID_RXPARSER_BOOST_TCAM_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_LBL_RXPARSER_TMEM:
> +		data_off = ICE_SEC_LBL_DATA_OFFSET;
> +		size = ICE_SID_LBL_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_MARKER_PTYPE:
> +		size = ICE_SID_RXPARSER_MARKER_TYPE_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_MARKER_GRP:
> +		size = ICE_SID_RXPARSER_MARKER_GRP_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_PROTO_GRP:
> +		size = ICE_SID_RXPARSER_PROTO_GRP_ENTRY_SIZE;
> +		break;
> +	case ICE_SID_RXPARSER_FLAG_REDIR:
> +		size = ICE_SID_RXPARSER_FLAG_REDIR_ENTRY_SIZE;
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	hdr = section;
> +	if (index >= le16_to_cpu(hdr->count))
> +		return NULL;
> +
> +	return section + data_off + index * size;
> +}
> +
> +/**
> + * ice_parser_create_table - create an item table from a section
> + * @hw: pointer to the hardware structure
> + * @sect_type: section type
> + * @item_size: item size in byte

in byte*s*

> + * @length: number of items in the table to create
> + * @parse_item: the function to parse the item
> + * @no_offset: ignore header offset, calculate index from 0
> + *
> + * Return: a pointer to the allocated table or ERR_PTR.
> + */
> +static
> +void *ice_parser_create_table(struct ice_hw *hw, u32 sect_type,
> +			      u32 item_size, u32 length,
> +			      void (*parse_item)(struct ice_hw *hw, u16 idx,
> +						 void *item, void *data,
> +						 int size),
> +			      bool no_offset)
> +{
> +	struct ice_pkg_enum state = {};
> +	struct ice_seg *seg = hw->seg;
> +	void *table, *data, *item;
> +	u16 idx = U16_MAX;
> +
> +	if (!seg)
> +		return ERR_PTR(-EINVAL);
> +
> +	table = kzalloc(item_size * length, GFP_KERNEL);
> +	if (!table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	do {
> +		data = ice_pkg_enum_entry(seg, &state, sect_type, NULL,
> +					  ice_parser_sect_item_get);
> +		seg = NULL;
> +		if (data) {
> +			struct ice_pkg_sect_hdr *hdr =
> +				(struct ice_pkg_sect_hdr *)state.sect;
> +
> +			if (no_offset)
> +				idx++;

Can’t `idx` initialized with `U16_MAX` now overflow?

> +			else
> +				idx = le16_to_cpu(hdr->offset) +
> +					state.entry_idx;
> +
> +			item = (void *)((uintptr_t)table + idx * item_size);
> +			parse_item(hw, idx, item, data, item_size);
> +		}
> +	} while (data);
> +
> +	return table;
> +}
> +
> +/*** ICE_SID_RXPARSER_IMEM section ***/
> +#define ICE_IM_BM_ALU0		BIT(0)
> +#define ICE_IM_BM_ALU1		BIT(1)
> +#define ICE_IM_BM_ALU2		BIT(2)
> +#define ICE_IM_BM_PG		BIT(3)
> +
> +/**
> + * ice_imem_bm_init - parse 4 bits of Boost Main
> + * @bm: pointer to the Boost Main structure
> + * @data: Boost Main data to be parsed

Excuse my ignorance, as you use `data` in `FIELD_GET()` is `data` the 
right name? The `FIELD_GET()` example in `include/linux/bitfield.h` uses 
`reg`. How do I know the valid values of `data`?

> + */
> +static void ice_imem_bm_init(struct ice_bst_main *bm, u8 data)
> +{
> +	bm->alu0	= FIELD_GET(ICE_IM_BM_ALU0, data);
> +	bm->alu1	= FIELD_GET(ICE_IM_BM_ALU1, data);
> +	bm->alu2	= FIELD_GET(ICE_IM_BM_ALU2, data);
> +	bm->pg		= FIELD_GET(ICE_IM_BM_PG, data);
> +}
> +
> +#define ICE_IM_BKB_PRIO		GENMASK(7, 0)
> +#define ICE_IM_BKB_TSR_CTRL	BIT(8)

[…]

> +
> +/**
> + * ice_imem_bkb_init - parse 10 bits of Boost Main Build
> + * @bkb: pointer to the Boost Main Build structure
> + * @data: Boost Main Build data to be parsed
> + */
> +static void ice_imem_bkb_init(struct ice_bst_keybuilder *bkb, u16 data)
> +{
> +	bkb->prio	= FIELD_GET(ICE_IM_BKB_PRIO, data);
> +	bkb->tsr_ctrl	= FIELD_GET(ICE_IM_BKB_TSR_CTRL, data);
> +}
> +
> +#define ICE_IM_NPKB_OPC		GENMASK(1, 0)
> +#define ICE_IM_NPKB_S_R0	GENMASK(9, 2)
> +#define ICE_IM_NPKB_L_R1	GENMASK(17, 10)
> +
> +/**
> + * ice_imem_npkb_init - parse 18 bits of Next Protocol Key Build
> + * @kb: pointer to the Next Protocol Key Build structure
> + * @data: Next Protocol Key Build data to be parsed
> + */
> +static void ice_imem_npkb_init(struct ice_np_keybuilder *kb, u32 data)
> +{
> +	kb->opc		= FIELD_GET(ICE_IM_NPKB_OPC, data);
> +	kb->start_reg0	= FIELD_GET(ICE_IM_NPKB_S_R0, data);
> +	kb->len_reg1	= FIELD_GET(ICE_IM_NPKB_L_R1, data);
> +}
> +
> +#define ICE_IM_PGKB_F0_ENA	BIT_ULL(0)
> +#define ICE_IM_PGKB_F0_IDX	GENMASK_ULL(6, 1)
> +#define ICE_IM_PGKB_F1_ENA	BIT_ULL(7)
> +#define ICE_IM_PGKB_F1_IDX	GENMASK_ULL(13, 8)
> +#define ICE_IM_PGKB_F2_ENA	BIT_ULL(14)
> +#define ICE_IM_PGKB_F2_IDX	GENMASK_ULL(20, 15)
> +#define ICE_IM_PGKB_F3_ENA	BIT_ULL(21)
> +#define ICE_IM_PGKB_F3_IDX	GENMASK_ULL(27, 22)
> +#define ICE_IM_PGKB_AR_IDX	GENMASK_ULL(34, 28)
> +
> +/**
> + * ice_imem_pgkb_init - parse 35 bits of Parse Graph Key Build
> + * @kb: pointer to the Parse Graph Key Build structure
> + * @data: Parse Graph Key Build data to be parsed
> + */
> +static void ice_imem_pgkb_init(struct ice_pg_keybuilder *kb, u64 data)
> +{
> +	kb->flag0_ena	= FIELD_GET(ICE_IM_PGKB_F0_ENA, data);
> +	kb->flag0_idx	= FIELD_GET(ICE_IM_PGKB_F0_IDX, data);
> +	kb->flag1_ena	= FIELD_GET(ICE_IM_PGKB_F1_ENA, data);
> +	kb->flag1_idx	= FIELD_GET(ICE_IM_PGKB_F1_IDX, data);
> +	kb->flag2_ena	= FIELD_GET(ICE_IM_PGKB_F2_ENA, data);
> +	kb->flag2_idx	= FIELD_GET(ICE_IM_PGKB_F2_IDX, data);
> +	kb->flag3_ena	= FIELD_GET(ICE_IM_PGKB_F3_ENA, data);
> +	kb->flag3_idx	= FIELD_GET(ICE_IM_PGKB_F3_IDX, data);
> +	kb->alu_reg_idx	= FIELD_GET(ICE_IM_PGKB_AR_IDX, data);
> +}
> +
> +#define ICE_IM_ALU_OPC		GENMASK_ULL(5, 0)
> +#define ICE_IM_ALU_SS		GENMASK_ULL(13, 6)
> +#define ICE_IM_ALU_SL		GENMASK_ULL(18, 14)
> +#define ICE_IM_ALU_SXS		BIT_ULL(19)
> +#define ICE_IM_ALU_SXK		GENMASK_ULL(23, 20)
> +#define ICE_IM_ALU_SRID		GENMASK_ULL(30, 24)
> +#define ICE_IM_ALU_DRID		GENMASK_ULL(37, 31)
> +#define ICE_IM_ALU_INC0		BIT_ULL(38)
> +#define ICE_IM_ALU_INC1		BIT_ULL(39)
> +#define ICE_IM_ALU_POO		GENMASK_ULL(41, 40)
> +#define ICE_IM_ALU_PO		GENMASK_ULL(49, 42)
> +#define ICE_IM_ALU_BA_S		50	/* offset for the 2nd 64-bits field */
> +#define ICE_IM_ALU_BA		GENMASK_ULL(57 - ICE_IM_ALU_BA_S, \
> +					    50 - ICE_IM_ALU_BA_S)
> +#define ICE_IM_ALU_IMM		GENMASK_ULL(73 - ICE_IM_ALU_BA_S, \
> +					    58 - ICE_IM_ALU_BA_S)
> +#define ICE_IM_ALU_DFE		BIT_ULL(74 - ICE_IM_ALU_BA_S)
> +#define ICE_IM_ALU_DS		GENMASK_ULL(80 - ICE_IM_ALU_BA_S, \
> +					    75 - ICE_IM_ALU_BA_S)
> +#define ICE_IM_ALU_DL		GENMASK_ULL(86 - ICE_IM_ALU_BA_S, \
> +					    81 - ICE_IM_ALU_BA_S)
> +#define ICE_IM_ALU_FEI		BIT_ULL(87 - ICE_IM_ALU_BA_S)
> +#define ICE_IM_ALU_FSI		GENMASK_ULL(95 - ICE_IM_ALU_BA_S, \
> +					    88 - ICE_IM_ALU_BA_S)
> +
> +/**
> + * ice_imem_alu_init - parse 96 bits of ALU entry
> + * @alu: pointer to the ALU entry structure
> + * @data: ALU entry data to be parsed
> + * @off: offset of the ALU entry data
> + */
> +static void ice_imem_alu_init(struct ice_alu *alu, u8 *data, u8 off)
> +{
> +	u64 d64;
> +	u8 idd;
> +
> +	d64 = *((u64 *)data) >> off;
> +
> +	alu->opc		= FIELD_GET(ICE_IM_ALU_OPC, d64);
> +	alu->src_start		= FIELD_GET(ICE_IM_ALU_SS, d64);
> +	alu->src_len		= FIELD_GET(ICE_IM_ALU_SL, d64);
> +	alu->shift_xlate_sel	= FIELD_GET(ICE_IM_ALU_SXS, d64);
> +	alu->shift_xlate_key	= FIELD_GET(ICE_IM_ALU_SXK, d64);
> +	alu->src_reg_id		= FIELD_GET(ICE_IM_ALU_SRID, d64);
> +	alu->dst_reg_id		= FIELD_GET(ICE_IM_ALU_DRID, d64);
> +	alu->inc0		= FIELD_GET(ICE_IM_ALU_INC0, d64);
> +	alu->inc1		= FIELD_GET(ICE_IM_ALU_INC1, d64);
> +	alu->proto_offset_opc	= FIELD_GET(ICE_IM_ALU_POO, d64);
> +	alu->proto_offset	= FIELD_GET(ICE_IM_ALU_PO, d64);
> +
> +	idd = (ICE_IM_ALU_BA_S + off) / BITS_PER_BYTE;
> +	off = (ICE_IM_ALU_BA_S + off) % BITS_PER_BYTE;
> +	d64 = *((u64 *)(&data[idd])) >> off;
> +
> +	alu->branch_addr	= FIELD_GET(ICE_IM_ALU_BA, d64);
> +	alu->imm		= FIELD_GET(ICE_IM_ALU_IMM, d64);
> +	alu->dedicate_flags_ena	= FIELD_GET(ICE_IM_ALU_DFE, d64);
> +	alu->dst_start		= FIELD_GET(ICE_IM_ALU_DS, d64);
> +	alu->dst_len		= FIELD_GET(ICE_IM_ALU_DL, d64);
> +	alu->flags_extr_imm	= FIELD_GET(ICE_IM_ALU_FEI, d64);
> +	alu->flags_start_imm	= FIELD_GET(ICE_IM_ALU_FSI, d64);
> +}
> +
> +#define ICE_IMEM_BM_S		0
> +#define ICE_IMEM_BKB_S		4
> +#define ICE_IMEM_BKB_IDD	(ICE_IMEM_BKB_S / BITS_PER_BYTE)
> +#define ICE_IMEM_BKB_OFF	(ICE_IMEM_BKB_S % BITS_PER_BYTE)
> +#define ICE_IMEM_PGP		GENMASK(15, 14)
> +#define ICE_IMEM_NPKB_S		16
> +#define ICE_IMEM_NPKB_IDD	(ICE_IMEM_NPKB_S / BITS_PER_BYTE)
> +#define ICE_IMEM_NPKB_OFF	(ICE_IMEM_NPKB_S % BITS_PER_BYTE)
> +#define ICE_IMEM_PGKB_S		34
> +#define ICE_IMEM_PGKB_IDD	(ICE_IMEM_PGKB_S / BITS_PER_BYTE)
> +#define ICE_IMEM_PGKB_OFF	(ICE_IMEM_PGKB_S % BITS_PER_BYTE)
> +#define ICE_IMEM_ALU0_S		69
> +#define ICE_IMEM_ALU0_IDD	(ICE_IMEM_ALU0_S / BITS_PER_BYTE)
> +#define ICE_IMEM_ALU0_OFF	(ICE_IMEM_ALU0_S % BITS_PER_BYTE)
> +#define ICE_IMEM_ALU1_S		165
> +#define ICE_IMEM_ALU1_IDD	(ICE_IMEM_ALU1_S / BITS_PER_BYTE)
> +#define ICE_IMEM_ALU1_OFF	(ICE_IMEM_ALU1_S % BITS_PER_BYTE)
> +#define ICE_IMEM_ALU2_S		357
> +#define ICE_IMEM_ALU2_IDD	(ICE_IMEM_ALU2_S / BITS_PER_BYTE)
> +#define ICE_IMEM_ALU2_OFF	(ICE_IMEM_ALU2_S % BITS_PER_BYTE)
> +
> +/**
> + * ice_imem_parse_item - parse 384 bits of IMEM entry
> + * @hw: pointer to the hardware structure
> + * @idx: index of IMEM entry
> + * @item: item of IMEM entry
> + * @data: IMEM entry data to be parsed

[…]

> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
> index 09ed380eee32..26468b16202c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.h
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.h
> @@ -4,8 +4,365 @@
>   #ifndef _ICE_PARSER_H_
>   #define _ICE_PARSER_H_
>   
> +#define ICE_SEC_DATA_OFFSET				4
> +#define ICE_SID_RXPARSER_IMEM_ENTRY_SIZE		48
> +#define ICE_SID_RXPARSER_METADATA_INIT_ENTRY_SIZE	24
> +#define ICE_SID_RXPARSER_CAM_ENTRY_SIZE			16
> +#define ICE_SID_RXPARSER_PG_SPILL_ENTRY_SIZE		17
> +#define ICE_SID_RXPARSER_NOMATCH_CAM_ENTRY_SIZE		12
> +#define ICE_SID_RXPARSER_NOMATCH_SPILL_ENTRY_SIZE	13
> +#define ICE_SID_RXPARSER_BOOST_TCAM_ENTRY_SIZE		88
> +#define ICE_SID_RXPARSER_MARKER_TYPE_ENTRY_SIZE		24
> +#define ICE_SID_RXPARSER_MARKER_GRP_ENTRY_SIZE		8
> +#define ICE_SID_RXPARSER_PROTO_GRP_ENTRY_SIZE		24
> +#define ICE_SID_RXPARSER_FLAG_REDIR_ENTRY_SIZE		1
> +
> +#define ICE_SEC_LBL_DATA_OFFSET				2
> +#define ICE_SID_LBL_ENTRY_SIZE				66
> +
> +/*** ICE_SID_RXPARSER_IMEM section ***/
> +#define ICE_IMEM_TABLE_SIZE		192
> +
> +/* TCAM boost Master; if bit is set, and TCAM hit, TCAM output overrides iMEM
> + * output.
> + */
> +struct ice_bst_main {
> +	bool alu0;
> +	bool alu1;
> +	bool alu2;
> +	bool pg;
> +};
> +
> +struct ice_bst_keybuilder {
> +	u8 prio;

Add a comment, what `prio` is and what values are allowed?

> +	bool tsr_ctrl;	/* TCAM Search Register control */
> +};

[…]


Kind regards,

Paul

