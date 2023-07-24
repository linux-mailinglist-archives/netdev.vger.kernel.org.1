Return-Path: <netdev+bounces-20511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F975FD16
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE3281447
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B27F50E;
	Mon, 24 Jul 2023 17:22:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028FDF66
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:22:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105DBE76;
	Mon, 24 Jul 2023 10:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FayGbuR3GPUL8gkquaOiwHKVrjAmkiNPeN+/FfgwP/Mc/jctSVx7WIF01jrG3xadMVggEwRg+u7zYTSCx1tLwwyJ/jQ9IRnMHUfkmadcbopV5FpTb0WT/UJihTOwCfHJAc6lfe1Xoiy+adbpTzN9X+9vBV9IFGMACdjUgwapWXl2h2v3hpnrCKVWmQ7nHutv+l9hPFFqRbFsylbRq+VX/T7JsXzE6+9G/dHRW6bb1+6poRh277oOJLw1XAzMxXnjFAHt0mut7pcFJzq10WJhWkVMEzU/SalgSahzilz7wMfhHSkqRNhvL79ZiwTTxJaiE/qmORQdEdcRmIaldNQaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djvmojwnYh9a5f7kcrDQ+w4JpbzOc7sOBRATPU6OqMI=;
 b=eI47jjFaHMLQVydJIwViflQ2IsXwzRWe1QbvM7fXJYCB5xfGnKpTuoVfEdCGmLlGy7ilGU6+TtB1wtTKwbTtp0uCSXD5QE7vPCKM8dbX+GbwvBz8Rv9ympY+mzuylfbY9gN6PVIexWcM8QaFsuy2RPCm4nJ8x+uNvOU3MKuk0GRKYqgMsjTdxDMUy4BzMmgptYOCQh71YzoAZizFp9tNpYQGa73nff+KqakdwVZtYUgy6wuGW1P6nbNskoaoxkjPBYjFbndte8Vq0fqMDGYsG8LDK9l+iHGpi3JKYIWrrP5FsF76h2OAEA56UMPPfn15kPlLhBbXvYRCYuOwIatqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djvmojwnYh9a5f7kcrDQ+w4JpbzOc7sOBRATPU6OqMI=;
 b=YkTrEUjNvRkgTg4ccSn8RgORDE1CopjMlDgiLaE3Xg5cKCfUW+hCHvl+JtpOEpATln87ZYj/uB5K/Bc3j/e3+OZDpbW8UgM3TiyLUuZ6po2s55Mp5S9ICXqfIogTHpvwx0Z8OhHMiBHiqJ8fT5DKFucZfp2NF3IWIN9ayEACCdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY1PR13MB6240.namprd13.prod.outlook.com (2603:10b6:a03:522::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Mon, 24 Jul
 2023 17:22:12 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 17:22:12 +0000
Date: Mon, 24 Jul 2023 19:21:54 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH net-next 08/11] ice: add admin commands to access cgu
 configuration
Message-ID: <ZL6zMmyIUObOY+6i@corigine.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-9-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-9-vadim.fedorenko@linux.dev>
X-ClientProxiedBy: AM0PR05CA0073.eurprd05.prod.outlook.com
 (2603:10a6:208:136::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY1PR13MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e7f288-a5a2-4057-de80-08db8c6a8491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rQjXgNm2cFDHC8s50MmCc/nO9YTEhaF3FwE9D3EfAvIFmMwJSyAPyauqKdqVCKQu6iGKdzsmhtPVdGNjxmOTgt18KejzFxA5hIwMQK+5AcFchldAFAApoZanfuxk1qKj1Ey4v0jdHxallGc8GvMO9x02qMVZQY4IAd4Z+Ket4y5iMuvvOnMNR2xqxGJ+s1ib9pW/5AorhwNtwvsqo0jtJnxbQzbHGAejV6VNOyChS3j/7+p1HNAnFjqHhoSvHjeN4sNjvmpprEuN+hEr+QkgBwnu1+B7bgDYgcWkKUO6R1BCj0ydq/U+ZBQlweVocrLHad+3bM4sbOhcPY2rV/CfuBCDF17ijcP9UA55g/CLikWFZavXrGiibnH1ml/p59I2ccty+ywIYNGIuA/2mjicBVvk222CJeBGhMni5jCs+ARnJwWTzSCH47L7hQM9STyuOiEQCixQZHCT8lZeXP+/8Ss+mXJhQ17moHX597lvtSGBbTlTGeAH4pW2LqsGgl4YZakLNdNGlYlQlJIAaP4Lpre/I73HzUfyj9j38dm3enRiBLN7YsUc5U47KdmkcdnO/lPAM+lBZWkvmdGCyxtb9mfYmficwA9OgkSzdSFMuR+QqPK/MF219TDwjduwRBj9oFTUCsStQeFmgylqw+Po1KyGoloP5UtinJCOwJBRJCg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(396003)(136003)(376002)(366004)(451199021)(41300700001)(2906002)(5660300002)(316002)(8676002)(8936002)(36756003)(44832011)(86362001)(6512007)(6666004)(6486002)(83380400001)(6506007)(478600001)(7416002)(38100700002)(186003)(66556008)(2616005)(6916009)(4326008)(66946007)(66476007)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HewAB68TAz0bfwG4AZfpS5LYFNXA7pY78cajVTwICiUuAP1lkn8zhAcYjb+f?=
 =?us-ascii?Q?SqjVSSmPhNzMmvqGbBCWn2x9warpQqu0YljcKPK3KuZTdZToCo7qadW4DtRh?=
 =?us-ascii?Q?kqYIc6i3muxfwSLvlZM4yln5p7qCwuRdNXsOre4i87MUMlzRvI6fleSH7E/Q?=
 =?us-ascii?Q?oRK5u+0okP0/P2kDitcIm1oUFVBiDsbMeiaz8eF5slW1ZGLmv3Dvl7V9riGP?=
 =?us-ascii?Q?v7z2FL8LqUdT5gDgW5VVc19wxqjpx9ckL7tgFIQeDAiyvlXZjmZ8G6M1U4iR?=
 =?us-ascii?Q?Nox6reAWDxnM8KQK8DWaiG8C2+Qzy6hYhpUJ6CQBi6800I09CaMs1iO2kjlp?=
 =?us-ascii?Q?Re1V3acdloaw1L9nRsxs/otK1PdLIpIUYAD/1TSPQQMylFXTuqrRMVdw53zl?=
 =?us-ascii?Q?sgY28nXa+2g+S2MwYcB9GelOEWPoj5uJO1IJIYtAJrGP5YC7SLLQ1ef1yecN?=
 =?us-ascii?Q?AwuguoYA3JBd3LNRbG6AnqnKJe4/V/SoArrEnzc6v6UC8/QIc/8Sc94VNHuH?=
 =?us-ascii?Q?9k7P64K/cw4doosRDEciGLRM5XjuzpEnuCHy0CSMgbDN4lceL7wuuLEoaCY5?=
 =?us-ascii?Q?yAsBD8SyumI5u704hFHga8HU6KYt0AR/Nudgy87P+6XAFsKol1gbXqxENR1k?=
 =?us-ascii?Q?vMlWzkR0usAnkp9Xzk9H2cgDhz+mCBSqwheeJWd7cgIjPLbHsaWJjlJzkV5G?=
 =?us-ascii?Q?nfJ4YqJ49Y/X+WPoWeZU+P0hFOVZjlwzPpnT1aMr7m10xpZhen0fCzU+rEzF?=
 =?us-ascii?Q?R6ppdP++4tzdz0uC4E0TQqbSvMiq3lstbrpHPYs3zQCr42SCE54Eo3LWJWnr?=
 =?us-ascii?Q?TY6LJK4KlQy2Ow9j7xgxJGHlYH1zUjoJimjcwEJ6j1QOvfN+rO/BZzpEP1MC?=
 =?us-ascii?Q?Ni+g/Bey/aOWVBoJf54H9KZwnjqaN7w5jADT1SFY1nil7ZyD4RPebzjvT1+9?=
 =?us-ascii?Q?dPNLTzLeSTpxcQkjgEi2D34PLLTIi7P8E8mQUri7VK/vHE6gRbFdxpsLxaDo?=
 =?us-ascii?Q?XU6u4kXBgltpBcrtO2HTI8aU0RS3SjUEYspd63CEbot0eWhEsXyP4fqy6D7W?=
 =?us-ascii?Q?CsUE2Bd+ACI/DT9DFHE19VU5D55ivClyLk1mHkr+3qGMFvHmAUYPPEKuIt0T?=
 =?us-ascii?Q?DKffy3V9ofSBliICL+HWNCM1NMhacy5JIqW1eeBMNWwT85hNVi6/L8emyZ7s?=
 =?us-ascii?Q?85wUL+jzxOxOqHffMsmCju5Km6RyAAKisYTq7BqhNuB5Ig+MOOQ8h810ppRi?=
 =?us-ascii?Q?WqzBrCi/iuOF0pWG4/2oSFw+RAI+XiGtHhbLTdJlxAkafqZwfi4UnYWAZIWK?=
 =?us-ascii?Q?EAUUTgHNAgYIcMzR+eJQxgo7KScUkogFTxWWBJV/xdHrLOtaZA7LI1NMqGK6?=
 =?us-ascii?Q?mSuwJTObuOrt2Wk6N9l6S12/Fcus8TJub6YOwkL8HT9JCQ1Th4VPaxYpmbE8?=
 =?us-ascii?Q?KGs2FhQVFij0slRyYVIdMtW7NUsEfvIIdB97DyK2rOF9E61nojspDpfS9MJE?=
 =?us-ascii?Q?1bdUP/L7WPEoU2pK+/uVglEEGM7NjoaJlLx+Cz/K2dEJyTFbIGkbI46lRDqc?=
 =?us-ascii?Q?C3Ur2LoeNm64ij2vbtyPI2u/aFBQB5wyPOljQ06GimqvF4qBNFHorAoEYRFZ?=
 =?us-ascii?Q?CPmpqyk3/zChuBzFYobY8jWhZD77sIX9+k2l2FnmnW04k+kV4eAxEDdj0ogj?=
 =?us-ascii?Q?bsChrg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e7f288-a5a2-4057-de80-08db8c6a8491
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 17:22:12.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rghN7JIduudjJt4flO5IpYW7CQ+EIpxAOsIQmpiwxLfNNTXW8wESnsbQkITE9QEwQOh7yCgqBiOUr7P45iIClexYP0rys1eMgSpc4nE0E7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6240
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:19:00AM +0100, Vadim Fedorenko wrote:

...

Hi Vadim,

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c

...

> +/**
> + * ice_aq_get_cgu_dpll_status
> + * @hw: pointer to the HW struct
> + * @dpll_num: DPLL index
> + * @ref_state: Reference clock state
> + * @dpll_state: DPLL state

./scripts/kernel-doc says that @config is missing here.

> + * @phase_offset: Phase offset in ns
> + * @eec_mode: EEC_mode
> + *
> + * Get CGU DPLL status (0x0C66)
> + */
> +int
> +ice_aq_get_cgu_dpll_status(struct ice_hw *hw, u8 dpll_num, u8 *ref_state,
> +			   u8 *dpll_state, u8 *config, s64 *phase_offset,
> +			   u8 *eec_mode)

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

...

> +/**
> + * ice_get_cgu_state - get the state of the DPLL
> + * @hw: pointer to the hw struct
> + * @dpll_idx: Index of internal DPLL unit
> + * @last_dpll_state: last known state of DPLL
> + * @pin: pointer to a buffer for returning currently active pin
> + * @ref_state: reference clock state

Likewise, @eec_mode is missing here.

> + * @phase_offset: pointer to a buffer for returning phase offset
> + * @dpll_state: state of the DPLL (output)

And @mode is missing here.

> + *
> + * This function will read the state of the DPLL(dpll_idx). Non-null
> + * 'pin', 'ref_state', 'eec_mode' and 'phase_offset' parameters are used to
> + * retrieve currently active pin, state, mode and phase_offset respectively.
> + *
> + * Return: state of the DPLL
> + */
> +int ice_get_cgu_state(struct ice_hw *hw, u8 dpll_idx,
> +		      enum dpll_lock_status last_dpll_state, u8 *pin,
> +		      u8 *ref_state, u8 *eec_mode, s64 *phase_offset,
> +		      enum dpll_lock_status *dpll_state,
> +		      enum dpll_mode *mode)
> +{
> +	u8 hw_ref_state, hw_dpll_state, hw_eec_mode, hw_config;
> +	s64 hw_phase_offset;
> +	int status;
> +
> +	status = ice_aq_get_cgu_dpll_status(hw, dpll_idx, &hw_ref_state,
> +					    &hw_dpll_state, &hw_config,
> +					    &hw_phase_offset, &hw_eec_mode);
> +	if (status) {
> +		*dpll_state = ICE_CGU_STATE_INVALID;

dpll_state is of type enum dpll_lock_status.
But the type of ICE_CGU_STATE_INVALID is enum ice_cgu_state.
Is this intended?

As flagged by gcc-12 W=1 and clang-16 W=1 builds.

> +		return status;
> +	}
> +
> +	if (pin)
> +		/* current ref pin in dpll_state_refsel_status_X register */
> +		*pin = hw_config & ICE_AQC_GET_CGU_DPLL_CONFIG_CLK_REF_SEL;
> +	if (phase_offset)
> +		*phase_offset = hw_phase_offset;
> +	if (ref_state)
> +		*ref_state = hw_ref_state;
> +	if (eec_mode)
> +		*eec_mode = hw_eec_mode;
> +	if (!dpll_state)
> +		return status;

Here dpll_state is checked for NULL.
But, above, it is dereferenced in the case where ice_aq_get_cgu_dpll_status
fails. Is that safe?

Also, perhaps it makes things a bit clearer to return 0 here.

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h

...

> +static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_inputs[] = {
> +	{ "CVL-SDP22",	  ZL_REF0P, DPLL_PIN_TYPE_INT_OSCILLATOR,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "CVL-SDP20",	  ZL_REF0N, DPLL_PIN_TYPE_INT_OSCILLATOR,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "C827_0-RCLKA", ZL_REF1P, DPLL_PIN_TYPE_MUX, 0, },
> +	{ "C827_0-RCLKB", ZL_REF1N, DPLL_PIN_TYPE_MUX, 0, },
> +	{ "SMA1",	  ZL_REF3P, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "SMA2/U.FL2",	  ZL_REF3N, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
> +	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, 0, },
> +};

A gcc-12 W=1 build warns that ice_e810t_sfp_cgu_inputs, and
the similar static variables below, are unused when ice_ptp_hw.h
is included in ice_main.c via ice.h.

Looking at ice_e823_zl_cgu_outputs[], it seems to only be used
in ice_ptp_hw.c, so perhaps it could be defined there.

Perhaps that is also true of the other static variables below,
but I didn't check that.

> +
> +static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_inputs[] = {
> +	{ "CVL-SDP22",	  ZL_REF0P, DPLL_PIN_TYPE_INT_OSCILLATOR,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "CVL-SDP20",	  ZL_REF0N, DPLL_PIN_TYPE_INT_OSCILLATOR,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "C827_0-RCLKA", ZL_REF1P, DPLL_PIN_TYPE_MUX, },
> +	{ "C827_0-RCLKB", ZL_REF1N, DPLL_PIN_TYPE_MUX, },
> +	{ "C827_1-RCLKA", ZL_REF2P, DPLL_PIN_TYPE_MUX, },
> +	{ "C827_1-RCLKB", ZL_REF2N, DPLL_PIN_TYPE_MUX, },
> +	{ "SMA1",	  ZL_REF3P, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "SMA2/U.FL2",	  ZL_REF3N, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
> +	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, },
> +};
> +
> +static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_outputs[] = {
> +	{ "REF-SMA1",	    ZL_OUT0, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "REF-SMA2/U.FL2", ZL_OUT1, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "PHY-CLK",	    ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT, },
> +	{ "MAC-CLK",	    ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT, },
> +	{ "CVL-SDP21",	    ZL_OUT4, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
> +	{ "CVL-SDP23",	    ZL_OUT5, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
> +};
> +
> +static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_outputs[] = {
> +	{ "REF-SMA1",	    ZL_OUT0, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "REF-SMA2/U.FL2", ZL_OUT1, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "PHY-CLK",	    ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
> +	{ "PHY2-CLK",	    ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
> +	{ "MAC-CLK",	    ZL_OUT4, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
> +	{ "CVL-SDP21",	    ZL_OUT5, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
> +	{ "CVL-SDP23",	    ZL_OUT6, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
> +};
> +
> +static const struct ice_cgu_pin_desc ice_e823_si_cgu_inputs[] = {
> +	{ "NONE",	  SI_REF0P, 0, 0 },
> +	{ "NONE",	  SI_REF0N, 0, 0 },
> +	{ "SYNCE0_DP",	  SI_REF1P, DPLL_PIN_TYPE_MUX, 0 },
> +	{ "SYNCE0_DN",	  SI_REF1N, DPLL_PIN_TYPE_MUX, 0 },
> +	{ "EXT_CLK_SYNC", SI_REF2P, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "NONE",	  SI_REF2N, 0, 0 },
> +	{ "EXT_PPS_OUT",  SI_REF3,  DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "INT_PPS_OUT",  SI_REF4,  DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +};
> +
> +static const struct ice_cgu_pin_desc ice_e823_si_cgu_outputs[] = {
> +	{ "1588-TIME_SYNC", SI_OUT0, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "PHY-CLK",	    SI_OUT1, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
> +	{ "10MHZ-SMA2",	    SI_OUT2, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_10_mhz), ice_cgu_pin_freq_10_mhz },
> +	{ "PPS-SMA1",	    SI_OUT3, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +};
> +
> +static const struct ice_cgu_pin_desc ice_e823_zl_cgu_inputs[] = {
> +	{ "NONE",	  ZL_REF0P, 0, 0 },
> +	{ "INT_PPS_OUT",  ZL_REF0N, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
> +	{ "SYNCE0_DP",	  ZL_REF1P, DPLL_PIN_TYPE_MUX, 0 },
> +	{ "SYNCE0_DN",	  ZL_REF1N, DPLL_PIN_TYPE_MUX, 0 },
> +	{ "NONE",	  ZL_REF2P, 0, 0 },
> +	{ "NONE",	  ZL_REF2N, 0, 0 },
> +	{ "EXT_CLK_SYNC", ZL_REF3P, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "NONE",	  ZL_REF3N, 0, 0 },
> +	{ "EXT_PPS_OUT",  ZL_REF4P, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
> +	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, 0 },
> +};
> +
> +static const struct ice_cgu_pin_desc ice_e823_zl_cgu_outputs[] = {
> +	{ "PPS-SMA1",	   ZL_OUT0, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
> +	{ "10MHZ-SMA2",	   ZL_OUT1, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_10_mhz), ice_cgu_pin_freq_10_mhz },
> +	{ "PHY-CLK",	   ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
> +	{ "1588-TIME_REF", ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
> +	{ "CPK-TIME_SYNC", ZL_OUT4, DPLL_PIN_TYPE_EXT,
> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
> +	{ "NONE",	   ZL_OUT5, 0, 0 },
> +};
> +
>  extern const struct
>  ice_cgu_pll_params_e822 e822_cgu_params[NUM_ICE_TIME_REF_FREQ];
>  

...

