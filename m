Return-Path: <netdev+bounces-99737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611148D62A9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1687928191C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E23158DBA;
	Fri, 31 May 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9jA2xP/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40583158DB2
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161260; cv=none; b=H0ER4FzggVJv5PLJmtJowUYT4D5JCKqGSnnr347NvCD37A9np/ywhMUydmXtvDCAOYovF7AKDWGHk40mFtKI3UKI3yLK1W6IzdACY4I157vLvi3F0IoYkZ/0gCDPjjyUYyfuuztQTg+3ZGL56uUvuxnmYGmFLqxjQ0Jf/6u9xPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161260; c=relaxed/simple;
	bh=bCLfhY6NlaWYUZTBrPRCziJRGyr/nA6JhP0LrlD97Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI/WMHM1BucRoc8+5zUhYGpPIR7uqfpU95+RXqLrsTjivimWaYRWISifcdtiUyEOPdTQpXvzUkCz067Ojt0M5XpcYHLh0ZTAdwmBX76mXVDswnMctRD4hU06U1uIkf6m01kFlvpL4bna2oZmoR81w12iZ2klpZlPd/y+f5/EXWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9jA2xP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A107C116B1;
	Fri, 31 May 2024 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161259;
	bh=bCLfhY6NlaWYUZTBrPRCziJRGyr/nA6JhP0LrlD97Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9jA2xP/50OGb6IO3SRIO5Q9WcwFq3EvZueP0/yHWGqGR4DFDEySqKt5L4DC5jGo0
	 o3inm4ONYvt58krMmPyqHdDi90v5bbyDR08PUqSYaHHOM6D1chfus3yjwrKNIg9z3P
	 8z4UO9hnPUbbmEvbJG4ECXDzGCg2ilXbY39RJwP9E4JhK13fJuPISUH91pfj9DVFGE
	 APuxc50uJjpvy01EfEIyiTDso6Tg6PLfZPSufCl2rPj5HsKiNbuRiTFS7tUvxwIQDe
	 H0jsnxHtnz8qcnNeLRVS0MAu03E5H7Mv7yk360tXW2xXoxhbr+Td7hdrMI45DPmHjp
	 xWJEElavZs8kA==
Date: Fri, 31 May 2024 14:14:16 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, anthony.l.nguyen@intel.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v2 02/13] ice: parse and init various DDP parser
 sections
Message-ID: <20240531131416.GE123401@kernel.org>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527185810.3077299-3-ahmed.zaki@intel.com>

On Mon, May 27, 2024 at 12:57:59PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Parse the following DDP sections:
>  - ICE_SID_RXPARSER_IMEM into an array of struct ice_imem_item
>  - ICE_SID_RXPARSER_METADATA_INIT into an array of struct ice_metainit_item
>  - ICE_SID_RXPARSER_CAM or ICE_SID_RXPARSER_PG_SPILL into an array of
>    struct ice_pg_cam_item
>  - ICE_SID_RXPARSER_NOMATCH_CAM or ICE_SID_RXPARSER_NOMATCH_SPILL into an
>    array of struct ice_pg_nm_cam_item
>  - ICE_SID_RXPARSER_CAM into an array of ice_bst_tcam_item
>  - ICE_SID_LBL_RXPARSER_TMEM into an array of ice_lbl_item
>  - ICE_SID_RXPARSER_MARKER_PTYPE into an array of ice_ptype_mk_tcam_item
>  - ICE_SID_RXPARSER_MARKER_GRP into an array of ice_mk_grp_item
>  - ICE_SID_RXPARSER_PROTO_GRP into an array of ice_proto_grp_item
>  - ICE_SID_RXPARSER_FLAG_REDIR into an array of ice_flg_rd_item
>  - ICE_SID_XLT_KEY_BUILDER_SW, ICE_SID_XLT_KEY_BUILDER_ACL,
>    ICE_SID_XLT_KEY_BUILDER_FD and ICE_SID_XLT_KEY_BUILDER_RSS into
>    struct ice_xlt_kb
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index b7865b6a0a9b..aaec10afea32 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -3,6 +3,1257 @@
>  
>  #include "ice_common.h"
>  
> +struct ice_pkg_sect_hdr {
> +	__le16 count;
> +	__le16 offset;
> +};
> +
> +/**
> + * ice_parser_sect_item_get - parse a item from a section
> + * @sect_type: section type
> + * @section: section object
> + * @index: index of the item to get
> + * @offset: dummy as prototype of ice_pkg_enum_entry's last parameter

Please consider including a "Return: " clause in new Kernel docs.
This is flagged by ./scripts/kernel-doc -Wall -none.
The -Wall flag was recently added to the Netdev CI.

Likewise elsewhere in this patchset.

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
> +	return (u8 *)section + data_off + (index * size);

nit: I don't think that the cast or parentheses are necessary here.
     Likewise elsewhere in this patchset.

     It's usually not necessary to cast to or from a void * to some other
     type of pointer. And in Networking code it's preferred not to do so.

     Similarly, although sometimes it is best for the sake of clarity,
     it is preferred not to add parentheses where they are not needed.

...

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
> + * @size: size of IMEM entry
> + */
> +static void ice_imem_parse_item(struct ice_hw *hw, u16 idx, void *item,
> +				void *data, int __maybe_unused size)
> +{
> +	struct ice_imem_item *ii = item;
> +	u8 *buf = (u8 *)data;

I think that in this function data can be used directly in place of buf.

> +
> +	ii->idx = idx;
> +
> +	ice_imem_bm_init(&ii->b_m, *(u8 *)buf);
> +	ice_imem_bkb_init(&ii->b_kb,
> +			  *((u16 *)(&buf[ICE_IMEM_BKB_IDD])) >>
> +			   ICE_IMEM_BKB_OFF);

nit: I suspect that FIELD_GET can be used here.
     And elsewhere where >> is used in this function and
     ice_imem_alu_init().

> +
> +	ii->pg_prio = FIELD_GET(ICE_IMEM_PGP, *(u16 *)buf);
> +
> +	ice_imem_npkb_init(&ii->np_kb,
> +			   *((u32 *)(&buf[ICE_IMEM_NPKB_IDD])) >>
> +			    ICE_IMEM_NPKB_OFF);
> +	ice_imem_pgkb_init(&ii->pg_kb,
> +			   *((u64 *)(&buf[ICE_IMEM_PGKB_IDD])) >>
> +			    ICE_IMEM_PGKB_OFF);
> +
> +	ice_imem_alu_init(&ii->alu0,
> +			  &buf[ICE_IMEM_ALU0_IDD],
> +			  ICE_IMEM_ALU0_OFF);
> +	ice_imem_alu_init(&ii->alu1,
> +			  &buf[ICE_IMEM_ALU1_IDD],
> +			  ICE_IMEM_ALU1_OFF);
> +	ice_imem_alu_init(&ii->alu2,
> +			  &buf[ICE_IMEM_ALU2_IDD],
> +			  ICE_IMEM_ALU2_OFF);
> +}

...

> +#define ICE_MI_GBDM_IDD		(ICE_MI_GBDM_S / BITS_PER_BYTE)
> +#define ICE_MI_GBDM_OFF		(ICE_MI_GBDM_S % BITS_PER_BYTE)
> +#define ICE_MI_GBDM		GENMASK_ULL(65 - ICE_MI_GBDM_S, \
> +					    61 - ICE_MI_GBDM_S)

nit: Some macros might make this a bit easier on the eyes (or not?).
     (Completely untested!)

#define ICE_GENMASK_OFF_ULL(high, low, offset) \
	GENMASK_ULL(high - offset, low - offset)

#define ICE_MI_GBDM_GENMASK_ULL(high, low) \
	ICE_GENMASK_OFF_ULL(high, low, ICE_MI_GBDM_S)

#define ICE_MI_GBDS		ICE_MI_GBDM_GENMASK_ULL(69, 66)
...
#define ICE_MI_FLAG		ICE_GENMASK_OFF_ULL(186, 123, ICE_MI_FLAG_S)

> +#define ICE_MI_GBDS		GENMASK_ULL(69 - ICE_MI_GBDM_S, \
> +					    66 - ICE_MI_GBDM_S)
> +#define ICE_MI_GBDL		GENMASK_ULL(74 - ICE_MI_GBDM_S, \
> +					    70 - ICE_MI_GBDM_S)
> +#define ICE_MI_GBI		GENMASK_ULL(80 - ICE_MI_GBDM_S, \
> +					    77 - ICE_MI_GBDM_S)
> +#define ICE_MI_GCC		BIT_ULL(81 - ICE_MI_GBDM_S)
> +#define ICE_MI_GCDM		GENMASK_ULL(86 - ICE_MI_GBDM_S, \
> +					    82 - ICE_MI_GBDM_S)
> +#define ICE_MI_GCDS		GENMASK_ULL(90 - ICE_MI_GBDM_S, \
> +					    87 - ICE_MI_GBDM_S)
> +#define ICE_MI_GCDL		GENMASK_ULL(95 - ICE_MI_GBDM_S, \
> +					    91 - ICE_MI_GBDM_S)
> +#define ICE_MI_GCI		GENMASK_ULL(101 - ICE_MI_GBDM_S, \
> +					    98 - ICE_MI_GBDM_S)
> +#define ICE_MI_GDC		BIT_ULL(102 - ICE_MI_GBDM_S)
> +#define ICE_MI_GDDM		GENMASK_ULL(107 - ICE_MI_GBDM_S, \
> +					    103 - ICE_MI_GBDM_S)
> +#define ICE_MI_GDDS		GENMASK_ULL(111 - ICE_MI_GBDM_S, \
> +					    108 - ICE_MI_GBDM_S)
> +#define ICE_MI_GDDL		GENMASK_ULL(116 - ICE_MI_GBDM_S, \
> +					    112 - ICE_MI_GBDM_S)
> +#define ICE_MI_GDI		GENMASK_ULL(122 - ICE_MI_GBDM_S, \
> +					    119 - ICE_MI_GBDM_S)
> +#define ICE_MI_FLAG_S		123	/* offset for the 3rd 64-bits field */
> +#define ICE_MI_FLAG_IDD		(ICE_MI_FLAG_S / BITS_PER_BYTE)
> +#define ICE_MI_FLAG_OFF		(ICE_MI_FLAG_S % BITS_PER_BYTE)
> +#define ICE_MI_FLAG		GENMASK_ULL(186 - ICE_MI_FLAG_S, \
> +					    123 - ICE_MI_FLAG_S)

...

