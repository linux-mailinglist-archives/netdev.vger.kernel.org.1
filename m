Return-Path: <netdev+bounces-20518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA96275FDF8
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EFF1C20C03
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951EF9F1;
	Mon, 24 Jul 2023 17:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF0FBE3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:41:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2139.outbound.protection.outlook.com [40.107.220.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5CDE8;
	Mon, 24 Jul 2023 10:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpzcLJKnTH2IiVbWYsVdnTktr8y14oF5piENbo61JW3EpRBBw0CVUujqS7vLjyKibaTxT1Wq7927a8EQtq7hJvZkkxHq7QiZkCGqQxRWbbDyysAA9l37ASHhVbWH//8Q3H+mw96HrWqBiwCOOjzNm1xe4fGSMIL+kXRNmu04mq62FrhPPENwyLF+iRHOeVLAA3D9wHZjVU57hOCiUPeZ2ji1lAvV4dq8sczMnffrxInC4Sq4aAq23WTgvxbG5xSdAoAfVEG2MbTxT66J+Ra4UvRjN4HxHV7Hc8HhXTpx8MO9Oxm7pcTWfIJrgDslw6VURhc0sNYMxZm2wKh8xeLFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG1t+tf/mwbs1rkjEngG01ap1V6PW2CHUvzxVezzRug=;
 b=iHzMQcPQQm6ObqdRoq9XPr78H3a/zUlsZ9NI3E3WAKx9bImY4Z5BqYIMj3dNtrzi+BzEBlUkTabJdMJUOOuhB+EF/yg2XpP6qvSzW39xxmnrMGnQJTCPHsWqdFK1T/YSTCeUtXN6PykpeklK12tNKuC34WeV6M/iJeByKD3/ieMnota61LeZvXthUMb3Pp8hyUIUvajJMK1ccojyaCYXRvtzkg7tJ/M8LOqLoqTPXRzAGXAJNwIz74F350D7E47guU2BlhIeL/ek36ZTSHH8Cpebq9GSfHXw/9RY1FJC2Vj5LjBSynWsH91IQy9nFQ1F0oY6h00k3+IX77ZWt4HpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG1t+tf/mwbs1rkjEngG01ap1V6PW2CHUvzxVezzRug=;
 b=pl6Tntz0LGzFm1MygTKwAkTD2xMCWE1+7uZPZHy21WpsyzMGApXYRuZSNEZIoh30nYoowQu4By5GvBod56THWD9lzS4TTxoU+Ko9u4FkbG2v43ON+2OmUsl11YUOyICRGgx/5mvFcZura8nImGsNylawRHBVBVcUcB8cOyGL2hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3855.namprd13.prod.outlook.com (2603:10b6:208:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 17:41:47 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 17:41:47 +0000
Date: Mon, 24 Jul 2023 19:41:40 +0200
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
Subject: Re: [PATCH 09/11] ice: implement dpll interface to control cgu
Message-ID: <ZL631F2MWdXVoM+y@corigine.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-10-vadim.fedorenko@linux.dev>
X-ClientProxiedBy: AM0PR03CA0012.eurprd03.prod.outlook.com
 (2603:10a6:208:14::25) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed61bcf-ccba-4d8a-655c-08db8c6d40fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rsLw59wsiECSaYwCBrCQ1DjVB065hIORfNPjKVjc+zpYX8l1cLgd9MXPG0rBTuSNuXu3uboBV4GhzKOnx30WgCNI+TSmvkKkBl04+gqK5cNAp0+OkvkuxvhrqguzeNl4JsjUBj2Fgxg25Y17Ls3fhK5qxNYE3IC4Vg7Mn9NBeRc6/X4Xv0iudwy3VZq9OyG4uxEeBc36L8+gFwIvQeZiHrgRsVrbnOBkafRK5uIGFrnD50IBvCORzK1u3KH1gWXr/gLyMMCUcxqGtxpBV9Wf483jtx00QmwvSizyZagEm5L588qUSY+JNnTo/RCP/FIdS7IZTJat3qBvgLscsqaPIUMd4JKUNK/KN7upHh64HPXiVoBGMTFM9qW+Ybyq9lL8QPCWAVKqsFopoaAibIXBkrAy1aJejHlDzGCKuY3JokSUoCnwiL9YwM7qQmxF61gPn1jeVxWNgFBYqWsh2+T82SOqrffpO5vRwwWvFsOJTyCxVzxzdbJiCFKaJpq3cSmED15PpkOdJTAtAUFVNKkAEiec5yvoJTgLqXiETbpqz3+FjdrBn6NpMCw3Cn9efIdEHcVI9Isy9eOVDBqbsEsxPYLon0DwDVHHEN9Pimafcqn5r3pox8dzYpk3mQfEgSHwr3SXa+ALBOFIhMbW/84SdUEOIzgaLzX7f1JC/UEp7YI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39840400004)(451199021)(2906002)(2616005)(83380400001)(30864003)(478600001)(36756003)(8676002)(8936002)(6486002)(6666004)(54906003)(86362001)(316002)(41300700001)(66946007)(4326008)(66556008)(66476007)(6916009)(6512007)(44832011)(186003)(38100700002)(6506007)(5660300002)(7416002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQV8KfKwq7yExyiz+jdt6fwGOJ8++xIOlOu36hqPJHFA9Nj1Y3famRUOgDBZ?=
 =?us-ascii?Q?IgL1caoAdkP4y8+WelCG7D+wVZ1bSenBbgwA2c/QwTTiTp04zCFBoU7SXA96?=
 =?us-ascii?Q?QkPqB6vkcsUvK9mU82eQROkPt20SkkKskcocZJkkk/UsxSbq81csY6MeTfth?=
 =?us-ascii?Q?iLdr+KiEQ6ztwAtQEquXbqF6zjzqRD9Vxg1+UgkCMatgDW+oWJsakn3lzrs3?=
 =?us-ascii?Q?0ZCGN2DvHQTtMj05axWvWiqMWNKrZ7hspVwco2cRG3EVyOGCFtjezdKAZQHY?=
 =?us-ascii?Q?6jk4F7CGIBpWQWpHEu28Yjp3noR9XAskHMb3k7r4hMeXPZ4R8fA8jSKZ/m+6?=
 =?us-ascii?Q?jkJkDOBGYFokdS9A6N/75CzQqgNOzHDBMbmc6TNjOciWn3SJ7TFUz0rpKnoU?=
 =?us-ascii?Q?OCXX9lkoPAQ95y4Tgy52Q1b+B32oyIvUZjZUrreAhe2imCa3Qh8/AjD0MT/q?=
 =?us-ascii?Q?Jdbw83E6UeUEuLQpRMuoG5NSFnYEHu5rv4NKe3CZ8dmSIg61JVflWPKL8PRx?=
 =?us-ascii?Q?BUsXbNdVswkj0+vAC2I+L0rIOf0uLFoBnodeT73lTpKx7JINrif8KNXiCPdg?=
 =?us-ascii?Q?uw1TMlj2txmpgbBMPN81E3EfYLBCzX0ssn/B2ez34KWlMlXLDJ7vMd1u85wX?=
 =?us-ascii?Q?l9q+Ru83MjG6xEniEhmh21M5x7zEudG0dOG5Ldk9WjzDL23Wr+Sucvp+MPVs?=
 =?us-ascii?Q?N6PERMD1XemI4/xHcGYiuK9dA+m0RYA2W684g5Bfp0OH8/34c+uw8kr2dJl/?=
 =?us-ascii?Q?BDTJ9IZ55ew8+bk4lU46frcS6ssvI2t1dLiZ4A08ZwuBoH0yzs3uDofTHcsY?=
 =?us-ascii?Q?Xp7wYDcxVhL6JsfC4jzMBdwCR55XgCnCZSWtIot/vR7JXlcJTxXP/rLEP6zd?=
 =?us-ascii?Q?GarOF3ceJVbFoz8547TTxDpXjapanarxDz68qiFyZdv41kMuhKT8Q2qQEqXj?=
 =?us-ascii?Q?y8nNNsmtaSeQTd5NfZ3OYDkZHIEGgAJd4UdhMWhjGOXSCkW980M6Kawv2ukN?=
 =?us-ascii?Q?Dcu4YV5eb+6LdfQrdAqjCNGEW9ctxf7alpkOUNF4BqhZl4aTT/9dNGfWKxgb?=
 =?us-ascii?Q?+zHVB9NLFJBNqxfPxPNqWPLEkR+d+yl1ycL3G2trNQVEzuH2eXLTTNhfB3hl?=
 =?us-ascii?Q?b4uHlwq56l6rH8y7ARyE1ZnajcZC6oHTfweFTDGSDa/mdmXiSXxSP+8WLPBT?=
 =?us-ascii?Q?URTf18/y2B8AFd29iDhO6kM09ii5/6/DUCy+zIwcfgV7EhCdiNKQcNZ7C4/T?=
 =?us-ascii?Q?Tm+MqHOFAbNTCm4FgsKlLpLy0Ht6ebaIV5+4FyptzDnmn8XIx6iGXtlMJseg?=
 =?us-ascii?Q?A7g228H6QpFoHBlbG66CzAtcSkSuK5QMJaGzqeFFvZfDDniUk/6WFfRpv0Pj?=
 =?us-ascii?Q?scoH3E8FNxvZuO10OV0eg9Soji+oVoBdR1rGpbIh6Z7Dn84Qr7s/3mWi25Cy?=
 =?us-ascii?Q?ckyHCQx/IoPkG9922McVafe/6vtoNiWY71EoV7bt7FvLSj0f1XKmtZ4xE95I?=
 =?us-ascii?Q?VXDW2bJOTy4Ga3B7S5pHmyKbcdpx7ZHvPdTkZU9kWzp4+/iiKg251rfIo2x6?=
 =?us-ascii?Q?ldt1qqqzh8bjat2jvgFfjbqe79mtelkeC8QgtGPPWmM8kGveEmgjMmZZQ/6A?=
 =?us-ascii?Q?xs6sakGiqEVHPPz7jrmg0yY7MnJlmCiRes67R5ZsgubB+mvlDW10t4tREq12?=
 =?us-ascii?Q?t+NtrQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed61bcf-ccba-4d8a-655c-08db8c6d40fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 17:41:47.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PH17WG4rTMt2lE53aG+0tVFR1sht9SPxlzKxwVvE5rfwZfcX/KTeE1HpojS1sBBPBKFJgdK1ESFcH1njVWZONT0F0X9vWjt99XoOSGVFcWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3855
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:19:01AM +0100, Vadim Fedorenko wrote:

...

Hi Vadim,

> +/**
> + * ice_dpll_cb_unlock - unlock dplls mutex in callback context
> + * @pf: private board structure
> + *
> + * Unlock the mutex from the callback operations invoked by dpll subsystem.
> + */
> +static void ice_dpll_cb_unlock(struct ice_pf *pf)
> +{
> +	mutex_unlock(&pf->dplls.lock);
> +}
> +
> +/**
> + * ice_dpll_pin_freq_set - set pin's frequency
> + * @pf: private board structure
> + * @pin: pointer to a pin
> + * @pin_type: type of pin being configured
> + * @freq: frequency to be set
> + * @extack: error reporting
> + *
> + * Set requested frequency on a pin.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error on AQ or wrong pin type given
> + */
> +static int
> +ice_dpll_pin_freq_set(struct ice_pf *pf, struct ice_dpll_pin *pin,
> +		      enum ice_dpll_pin_type pin_type, const u32 freq,
> +		      struct netlink_ext_ack *extack)
> +{
> +	int ret;
> +	u8 flags;

Please arrange local variable declarations for new Networking
code in reverse xmas tree order - longest line to shortest.

> +
> +	switch (pin_type) {
> +	case ICE_DPLL_PIN_TYPE_INPUT:
> +		flags = ICE_AQC_SET_CGU_IN_CFG_FLG1_UPDATE_FREQ;
> +		ret = ice_aq_set_input_pin_cfg(&pf->hw, pin->idx, flags,
> +					       pin->flags[0], freq, 0);
> +		break;
> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
> +		flags = ICE_AQC_SET_CGU_OUT_CFG_UPDATE_FREQ;
> +		ret = ice_aq_set_output_pin_cfg(&pf->hw, pin->idx, flags,
> +						0, freq, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (ret) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "err:%d %s failed to set pin freq:%u on pin:%u\n",
> +				   ret,
> +				   ice_aq_str(pf->hw.adminq.sq_last_status),
> +				   freq, pin->idx);
> +		return ret;
> +	}
> +	pin->freq = freq;
> +
> +	return 0;
> +}

...

> +/**
> + * ice_dpll_pin_state_update - update pin's state
> + * @pf: private board struct
> + * @pin: structure with pin attributes to be updated
> + * @pin_type: type of pin being updated
> + * @extack: error reporting
> + *
> + * Determine pin current state and frequency, then update struct
> + * holding the pin info. For input pin states are separated for each
> + * dpll, for rclk pins states are separated for each parent.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */
> +int
> +ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
> +			  enum ice_dpll_pin_type pin_type,
> +			  struct netlink_ext_ack *extack)

> +/**
> + * ice_dpll_frequency_set - wrapper for pin callback for set frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: frequency to be set
> + * @extack: error reporting
> + * @pin_type: type of pin being configured
> + *
> + * Wraps internal set frequency command on a pin.
> + *
> + * Context: Acquires pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't set in hw
> + */
> +static int
> +ice_dpll_frequency_set(const struct dpll_pin *pin, void *pin_priv,
> +		       const struct dpll_device *dpll, void *dpll_priv,
> +		       const u32 frequency,
> +		       struct netlink_ext_ack *extack,
> +		       enum ice_dpll_pin_type pin_type)
> +{
> +	struct ice_dpll_pin *p = pin_priv;
> +	struct ice_dpll *d = dpll_priv;
> +	struct ice_pf *pf = d->pf;
> +	int ret;
> +
> +	ret = ice_dpll_cb_lock(pf, extack);
> +	if (ret)
> +		return ret;
> +	ret = ice_dpll_pin_freq_set(pf, p, pin_type, frequency, extack);
> +	ice_dpll_cb_unlock(pf);
> +
> +	return ret;
> +}
> +
> +/**
> + * ice_dpll_input_frequency_set - input pin callback for set frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: frequency to be set
> + * @extack: error reporting
> + *
> + * Wraps internal set frequency command on a pin.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't set in hw
> + */
> +static int
> +ice_dpll_input_frequency_set(const struct dpll_pin *pin, void *pin_priv,
> +			     const struct dpll_device *dpll, void *dpll_priv,
> +			     u64 frequency, struct netlink_ext_ack *extack)
> +{
> +	return ice_dpll_frequency_set(pin, pin_priv, dpll, dpll_priv, frequency,
> +				      extack, ICE_DPLL_PIN_TYPE_INPUT);
> +}
> +
> +/**
> + * ice_dpll_output_frequency_set - output pin callback for set frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: frequency to be set
> + * @extack: error reporting
> + *
> + * Wraps internal set frequency command on a pin.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't set in hw
> + */
> +static int
> +ice_dpll_output_frequency_set(const struct dpll_pin *pin, void *pin_priv,
> +			      const struct dpll_device *dpll, void *dpll_priv,
> +			      u64 frequency, struct netlink_ext_ack *extack)
> +{
> +	return ice_dpll_frequency_set(pin, pin_priv, dpll, dpll_priv, frequency,
> +				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
> +}
> +
> +/**
> + * ice_dpll_frequency_get - wrapper for pin callback for get frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: on success holds pin's frequency
> + * @extack: error reporting
> + * @pin_type: type of pin being configured
> + *
> + * Wraps internal get frequency command of a pin.
> + *
> + * Context: Acquires pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't get from hw
> + */
> +static int
> +ice_dpll_frequency_get(const struct dpll_pin *pin, void *pin_priv,
> +		       const struct dpll_device *dpll, void *dpll_priv,
> +		       u64 *frequency, struct netlink_ext_ack *extack,
> +		       enum ice_dpll_pin_type pin_type)
> +{
> +	struct ice_dpll_pin *p = pin_priv;
> +	struct ice_dpll *d = dpll_priv;
> +	struct ice_pf *pf = d->pf;
> +	int ret;
> +
> +	ret = ice_dpll_cb_lock(pf, extack);
> +	if (ret)
> +		return ret;
> +	*frequency = p->freq;
> +	ice_dpll_cb_unlock(pf);
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_dpll_input_frequency_get - input pin callback for get frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: on success holds pin's frequency
> + * @extack: error reporting
> + *
> + * Wraps internal get frequency command of a input pin.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't get from hw
> + */
> +static int
> +ice_dpll_input_frequency_get(const struct dpll_pin *pin, void *pin_priv,
> +			     const struct dpll_device *dpll, void *dpll_priv,
> +			     u64 *frequency, struct netlink_ext_ack *extack)
> +{
> +	return ice_dpll_frequency_get(pin, pin_priv, dpll, dpll_priv, frequency,
> +				      extack, ICE_DPLL_PIN_TYPE_INPUT);
> +}
> +
> +/**
> + * ice_dpll_output_frequency_get - output pin callback for get frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: on success holds pin's frequency
> + * @extack: error reporting
> + *
> + * Wraps internal get frequency command of a pin.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't get from hw
> + */
> +static int
> +ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
> +			      const struct dpll_device *dpll, void *dpll_priv,
> +			      u64 *frequency, struct netlink_ext_ack *extack)
> +{
> +	return ice_dpll_frequency_get(pin, pin_priv, dpll, dpll_priv, frequency,
> +				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
> +}
> +
> +/**
> + * ice_dpll_pin_enable - enable a pin on dplls
> + * @hw: board private hw structure
> + * @pin: pointer to a pin
> + * @pin_type: type of pin being enabled
> + * @extack: error reporting
> + *
> + * Enable a pin on both dplls. Store current state in pin->flags.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */
> +static int
> +ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
> +		    enum ice_dpll_pin_type pin_type,
> +		    struct netlink_ext_ack *extack)
> +{
> +	u8 flags = 0;
> +	int ret;
> +
> +	switch (pin_type) {
> +	case ICE_DPLL_PIN_TYPE_INPUT:
> +		if (pin->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)
> +			flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
> +		flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
> +		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
> +		break;
> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
> +		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
> +			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
> +		flags |= ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
> +		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (ret)
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "err:%d %s failed to enable %s pin:%u\n",
> +				   ret, ice_aq_str(hw->adminq.sq_last_status),
> +				   pin_type_name[pin_type], pin->idx);
> +
> +	return ret;
> +}
> +
> +/**
> + * ice_dpll_pin_disable - disable a pin on dplls
> + * @hw: board private hw structure
> + * @pin: pointer to a pin
> + * @pin_type: type of pin being disabled
> + * @extack: error reporting
> + *
> + * Disable a pin on both dplls. Store current state in pin->flags.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */
> +static int
> +ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
> +		     enum ice_dpll_pin_type pin_type,
> +		     struct netlink_ext_ack *extack)
> +{
> +	u8 flags = 0;
> +	int ret;
> +
> +	switch (pin_type) {
> +	case ICE_DPLL_PIN_TYPE_INPUT:
> +		if (pin->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)
> +			flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
> +		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
> +		break;
> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
> +		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
> +			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
> +		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (ret)
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "err:%d %s failed to disable %s pin:%u\n",
> +				   ret, ice_aq_str(hw->adminq.sq_last_status),
> +				   pin_type_name[pin_type], pin->idx);
> +
> +	return ret;
> +}

> +/**
> + * ice_dpll_frequency_set - wrapper for pin callback for set frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: frequency to be set
> + * @extack: error reporting
> + * @pin_type: type of pin being configured
> + *
> + * Wraps internal set frequency command on a pin.
> + *
> + * Context: Acquires pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't set in hw
> + */
> +static int
> +ice_dpll_frequency_set(const struct dpll_pin *pin, void *pin_priv,
> +		       const struct dpll_device *dpll, void *dpll_priv,
> +		       const u32 frequency,
> +		       struct netlink_ext_ack *extack,
> +		       enum ice_dpll_pin_type pin_type)
> +{
> +	struct ice_dpll_pin *p = pin_priv;
> +	struct ice_dpll *d = dpll_priv;
> +	struct ice_pf *pf = d->pf;
> +	int ret;
> +
> +	ret = ice_dpll_cb_lock(pf, extack);
> +	if (ret)
> +		return ret;
> +	ret = ice_dpll_pin_freq_set(pf, p, pin_type, frequency, extack);
> +	ice_dpll_cb_unlock(pf);
> +
> +	return ret;
> +}
> +
> +/**
> + * ice_dpll_input_frequency_set - input pin callback for set frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: frequency to be set
> + * @extack: error reporting
> + *
> + * Wraps internal set frequency command on a pin.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't set in hw
> + */
> +static int
> +ice_dpll_input_frequency_set(const struct dpll_pin *pin, void *pin_priv,
> +			     const struct dpll_device *dpll, void *dpll_priv,
> +			     u64 frequency, struct netlink_ext_ack *extack)
> +{
> +	return ice_dpll_frequency_set(pin, pin_priv, dpll, dpll_priv, frequency,
> +				      extack, ICE_DPLL_PIN_TYPE_INPUT);
> +}
> +
> +/**
> + * ice_dpll_output_frequency_set - output pin callback for set frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: frequency to be set
> + * @extack: error reporting
> + *
> + * Wraps internal set frequency command on a pin.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't set in hw
> + */
> +static int
> +ice_dpll_output_frequency_set(const struct dpll_pin *pin, void *pin_priv,
> +			      const struct dpll_device *dpll, void *dpll_priv,
> +			      u64 frequency, struct netlink_ext_ack *extack)
> +{
> +	return ice_dpll_frequency_set(pin, pin_priv, dpll, dpll_priv, frequency,
> +				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
> +}
> +
> +/**
> + * ice_dpll_frequency_get - wrapper for pin callback for get frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: on success holds pin's frequency
> + * @extack: error reporting
> + * @pin_type: type of pin being configured
> + *
> + * Wraps internal get frequency command of a pin.
> + *
> + * Context: Acquires pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't get from hw
> + */
> +static int
> +ice_dpll_frequency_get(const struct dpll_pin *pin, void *pin_priv,
> +		       const struct dpll_device *dpll, void *dpll_priv,
> +		       u64 *frequency, struct netlink_ext_ack *extack,
> +		       enum ice_dpll_pin_type pin_type)
> +{
> +	struct ice_dpll_pin *p = pin_priv;
> +	struct ice_dpll *d = dpll_priv;
> +	struct ice_pf *pf = d->pf;
> +	int ret;
> +
> +	ret = ice_dpll_cb_lock(pf, extack);
> +	if (ret)
> +		return ret;
> +	*frequency = p->freq;
> +	ice_dpll_cb_unlock(pf);
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_dpll_input_frequency_get - input pin callback for get frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: on success holds pin's frequency
> + * @extack: error reporting
> + *
> + * Wraps internal get frequency command of a input pin.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't get from hw
> + */
> +static int
> +ice_dpll_input_frequency_get(const struct dpll_pin *pin, void *pin_priv,
> +			     const struct dpll_device *dpll, void *dpll_priv,
> +			     u64 *frequency, struct netlink_ext_ack *extack)
> +{
> +	return ice_dpll_frequency_get(pin, pin_priv, dpll, dpll_priv, frequency,
> +				      extack, ICE_DPLL_PIN_TYPE_INPUT);
> +}
> +
> +/**
> + * ice_dpll_output_frequency_get - output pin callback for get frequency
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: pointer to dpll
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @frequency: on success holds pin's frequency
> + * @extack: error reporting
> + *
> + * Wraps internal get frequency command of a pin.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error pin not found or couldn't get from hw
> + */
> +static int
> +ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
> +			      const struct dpll_device *dpll, void *dpll_priv,
> +			      u64 *frequency, struct netlink_ext_ack *extack)
> +{
> +	return ice_dpll_frequency_get(pin, pin_priv, dpll, dpll_priv, frequency,
> +				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
> +}
> +
> +/**
> + * ice_dpll_pin_enable - enable a pin on dplls
> + * @hw: board private hw structure
> + * @pin: pointer to a pin
> + * @pin_type: type of pin being enabled
> + * @extack: error reporting
> + *
> + * Enable a pin on both dplls. Store current state in pin->flags.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */
> +static int
> +ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
> +		    enum ice_dpll_pin_type pin_type,
> +		    struct netlink_ext_ack *extack)
> +{
> +	u8 flags = 0;
> +	int ret;
> +
> +	switch (pin_type) {
> +	case ICE_DPLL_PIN_TYPE_INPUT:
> +		if (pin->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)
> +			flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
> +		flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
> +		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
> +		break;
> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
> +		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
> +			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
> +		flags |= ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
> +		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (ret)
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "err:%d %s failed to enable %s pin:%u\n",
> +				   ret, ice_aq_str(hw->adminq.sq_last_status),
> +				   pin_type_name[pin_type], pin->idx);
> +
> +	return ret;
> +}
> +
> +/**
> + * ice_dpll_pin_disable - disable a pin on dplls
> + * @hw: board private hw structure
> + * @pin: pointer to a pin
> + * @pin_type: type of pin being disabled
> + * @extack: error reporting
> + *
> + * Disable a pin on both dplls. Store current state in pin->flags.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */
> +static int
> +ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
> +		     enum ice_dpll_pin_type pin_type,
> +		     struct netlink_ext_ack *extack)
> +{
> +	u8 flags = 0;
> +	int ret;
> +
> +	switch (pin_type) {
> +	case ICE_DPLL_PIN_TYPE_INPUT:
> +		if (pin->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)
> +			flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
> +		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
> +		break;
> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
> +		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
> +			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
> +		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (ret)
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "err:%d %s failed to disable %s pin:%u\n",
> +				   ret, ice_aq_str(hw->adminq.sq_last_status),
> +				   pin_type_name[pin_type], pin->idx);
> +
> +	return ret;
> +}

Should this function be static?

> +{
> +	int ret;
> +
> +	switch (pin_type) {
> +	case ICE_DPLL_PIN_TYPE_INPUT:
> +		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, NULL,
> +					       NULL, &pin->flags[0],
> +					       &pin->freq, NULL);
> +		if (ret)
> +			goto err;
> +		if (ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN & pin->flags[0]) {
> +			if (pin->pin) {
> +				pin->state[pf->dplls.eec.dpll_idx] =
> +					pin->pin == pf->dplls.eec.active_input ?
> +					DPLL_PIN_STATE_CONNECTED :
> +					DPLL_PIN_STATE_SELECTABLE;
> +				pin->state[pf->dplls.pps.dpll_idx] =
> +					pin->pin == pf->dplls.pps.active_input ?
> +					DPLL_PIN_STATE_CONNECTED :
> +					DPLL_PIN_STATE_SELECTABLE;
> +			} else {
> +				pin->state[pf->dplls.eec.dpll_idx] =
> +					DPLL_PIN_STATE_SELECTABLE;
> +				pin->state[pf->dplls.pps.dpll_idx] =
> +					DPLL_PIN_STATE_SELECTABLE;
> +			}
> +		} else {
> +			pin->state[pf->dplls.eec.dpll_idx] =
> +				DPLL_PIN_STATE_DISCONNECTED;
> +			pin->state[pf->dplls.pps.dpll_idx] =
> +				DPLL_PIN_STATE_DISCONNECTED;
> +		}
> +		break;
> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
> +		ret = ice_aq_get_output_pin_cfg(&pf->hw, pin->idx,
> +						&pin->flags[0], NULL,
> +						&pin->freq, NULL);
> +		if (ret)
> +			goto err;
> +		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0])
> +			pin->state[0] = DPLL_PIN_STATE_CONNECTED;
> +		else
> +			pin->state[0] = DPLL_PIN_STATE_DISCONNECTED;
> +		break;
> +	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:

clang-16 complains that:
 
  drivers/net/ethernet/intel/ice/ice_dpll.c:461:3: error: expected expression
                  u8 parent, port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT;

Which, I think means, it wants this case to be enclosed in { }

> +		u8 parent, port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT;
> +
> +		for (parent = 0; parent < pf->dplls.rclk.num_parents;
> +		     parent++) {
> +			u8 p = parent;
> +
> +			ret = ice_aq_get_phy_rec_clk_out(&pf->hw, &p,
> +							 &port_num,
> +							 &pin->flags[parent],
> +							 NULL);
> +			if (ret)
> +				goto err;
> +			if (ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN &
> +			    pin->flags[parent])
> +				pin->state[parent] = DPLL_PIN_STATE_CONNECTED;
> +			else
> +				pin->state[parent] =
> +					DPLL_PIN_STATE_DISCONNECTED;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +err:
> +	if (extack)
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "err:%d %s failed to update %s pin:%u\n",
> +				   ret,
> +				   ice_aq_str(pf->hw.adminq.sq_last_status),
> +				   pin_type_name[pin_type], pin->idx);
> +	else
> +		dev_err_ratelimited(ice_pf_to_dev(pf),
> +				    "err:%d %s failed to update %s pin:%u\n",
> +				    ret,
> +				    ice_aq_str(pf->hw.adminq.sq_last_status),
> +				    pin_type_name[pin_type], pin->idx);
> +	return ret;
> +}

...

> +/**
> + * ice_dpll_update_state - update dpll state
> + * @pf: pf private structure
> + * @d: pointer to queried dpll device
> + * @init: if function called on initialization of ice dpll
> + *
> + * Poll current state of dpll from hw and update ice_dpll struct.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - AQ failure
> + */
> +static int
> +ice_dpll_update_state(struct ice_pf *pf, struct ice_dpll *d, bool init)
> +{
> +	struct ice_dpll_pin *p = NULL;
> +	int ret;
> +
> +	ret = ice_get_cgu_state(&pf->hw, d->dpll_idx, d->prev_dpll_state,
> +				&d->input_idx, &d->ref_state, &d->eec_mode,
> +				&d->phase_shift, &d->dpll_state, &d->mode);
> +
> +	dev_dbg(ice_pf_to_dev(pf),
> +		"update dpll=%d, prev_src_idx:%u, src_idx:%u, state:%d, prev:%d mode:%d\n",
> +		d->dpll_idx, d->prev_input_idx, d->input_idx,
> +		d->dpll_state, d->prev_dpll_state, d->mode);
> +	if (ret) {
> +		dev_err(ice_pf_to_dev(pf),
> +			"update dpll=%d state failed, ret=%d %s\n",
> +			d->dpll_idx, ret,
> +			ice_aq_str(pf->hw.adminq.sq_last_status));
> +		return ret;
> +	}
> +	if (init) {
> +		if (d->dpll_state == DPLL_LOCK_STATUS_LOCKED &&
> +		    d->dpll_state == DPLL_LOCK_STATUS_LOCKED_HO_ACQ)

Should this be '||' rather than '&&' ?

Flagged by a clang-16 W=1 build, Sparse and Smatch.

> +			d->active_input = pf->dplls.inputs[d->input_idx].pin;
> +		p = &pf->dplls.inputs[d->input_idx];
> +		return ice_dpll_pin_state_update(pf, p,
> +						 ICE_DPLL_PIN_TYPE_INPUT, NULL);
> +	}

...

> +/**
> + * ice_dpll_init_info_direct_pins - initializes direct pins info
> + * @pf: board private structure
> + * @pin_type: type of pins being initialized
> + *
> + * Init information for directly connected pins, cache them in pf's pins
> + * structures.
> + *
> + * Context: Called under pf->dplls.lock.
> + * Return:
> + * * 0 - success
> + * * negative - init failure reason
> + */
> +static int
> +ice_dpll_init_info_direct_pins(struct ice_pf *pf,
> +			       enum ice_dpll_pin_type pin_type)
> +{
> +	struct ice_dpll *de = &pf->dplls.eec, *dp = &pf->dplls.pps;
> +	struct ice_hw *hw = &pf->hw;
> +	struct ice_dpll_pin *pins;
> +	int num_pins, i, ret;
> +	u8 freq_supp_num;
> +	bool input;
> +
> +	switch (pin_type) {
> +	case ICE_DPLL_PIN_TYPE_INPUT:
> +		pins = pf->dplls.inputs;
> +		num_pins = pf->dplls.num_inputs;
> +		input = true;
> +		break;
> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
> +		pins = pf->dplls.outputs;
> +		num_pins = pf->dplls.num_outputs;
> +		input = false;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num_pins; i++) {
> +		pins[i].idx = i;
> +		pins[i].prop.board_label = ice_cgu_get_pin_name(hw, i, input);
> +		pins[i].prop.type = ice_cgu_get_pin_type(hw, i, input);
> +		if (input) {
> +			ret = ice_aq_get_cgu_ref_prio(hw, de->dpll_idx, i,
> +						      &de->input_prio[i]);
> +			if (ret)
> +				return ret;
> +			ret = ice_aq_get_cgu_ref_prio(hw, dp->dpll_idx, i,
> +						      &dp->input_prio[i]);
> +			if (ret)
> +				return ret;
> +			pins[i].prop.capabilities |=
> +				DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE;
> +		}
> +		pins[i].prop.capabilities |= DPLL_PIN_CAPS_STATE_CAN_CHANGE;
> +		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
> +		if (ret)
> +			return ret;
> +		pins[i].prop.freq_supported =
> +			ice_cgu_get_pin_freq_supp(hw, i, input, &freq_supp_num);
> +		pins[i].prop.freq_supported_num = freq_supp_num;
> +		pins[i].pf = pf;
> +	}
> +

I'm unsure if this can happen,
but if the for loop above iterates zero times
then ret will be null here.

Use of uninitialised variable flagged by Smatch.

> +	return ret;
> +}

...

> +/**
> + * ice_dpll_init_info - prepare pf's dpll information structure
> + * @pf: board private structure
> + * @cgu: if cgu is present and controlled by this NIC
> + *
> + * Acquire (from HW) and set basic dpll information (on pf->dplls struct).
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - init failure reason
> + */
> +static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
> +{
> +	struct ice_aqc_get_cgu_abilities abilities;
> +	struct ice_dpll *de = &pf->dplls.eec;
> +	struct ice_dpll *dp = &pf->dplls.pps;
> +	struct ice_dplls *d = &pf->dplls;
> +	struct ice_hw *hw = &pf->hw;
> +	int ret, alloc_size, i;
> +
> +	d->clock_id = ice_generate_clock_id(pf);
> +	ret = ice_aq_get_cgu_abilities(hw, &abilities);
> +	if (ret) {
> +		dev_err(ice_pf_to_dev(pf),
> +			"err:%d %s failed to read cgu abilities\n",
> +			ret, ice_aq_str(hw->adminq.sq_last_status));
> +		return ret;
> +	}
> +
> +	de->dpll_idx = abilities.eec_dpll_idx;
> +	dp->dpll_idx = abilities.pps_dpll_idx;
> +	d->num_inputs = abilities.num_inputs;
> +	d->num_outputs = abilities.num_outputs;
> +	d->input_phase_adj_max = le32_to_cpu(abilities.max_in_phase_adj);
> +	d->output_phase_adj_max = le32_to_cpu(abilities.max_out_phase_adj);
> +
> +	alloc_size = sizeof(*d->inputs) * d->num_inputs;
> +	d->inputs = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!d->inputs)
> +		return -ENOMEM;
> +
> +	alloc_size = sizeof(*de->input_prio) * d->num_inputs;
> +	de->input_prio = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!de->input_prio)
> +		return -ENOMEM;
> +
> +	dp->input_prio = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!dp->input_prio)
> +		return -ENOMEM;
> +
> +	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
> +	if (ret)
> +		goto deinit_info;
> +
> +	if (cgu) {
> +		alloc_size = sizeof(*d->outputs) * d->num_outputs;
> +		d->outputs = kzalloc(alloc_size, GFP_KERNEL);
> +		if (!d->outputs)

Should ret be set to -ENOMEM here?

Flagged by Smatch.

> +			goto deinit_info;
> +
> +		ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_OUTPUT);
> +		if (ret)
> +			goto deinit_info;
> +	}
> +
> +	ret = ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
> +					&pf->dplls.rclk.num_parents);
> +	if (ret)
> +		return ret;
> +	for (i = 0; i < pf->dplls.rclk.num_parents; i++)
> +		pf->dplls.rclk.parent_idx[i] = d->base_rclk_idx + i;
> +	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_RCLK_INPUT);
> +	if (ret)
> +		return ret;
> +	de->mode = DPLL_MODE_AUTOMATIC;
> +	dp->mode = DPLL_MODE_AUTOMATIC;
> +
> +	dev_dbg(ice_pf_to_dev(pf),
> +		"%s - success, inputs:%u, outputs:%u rclk-parents:%u\n",
> +		__func__, d->num_inputs, d->num_outputs, d->rclk.num_parents);
> +
> +	return 0;
> +
> +deinit_info:
> +	dev_err(ice_pf_to_dev(pf),
> +		"%s - fail: d->inputs:%p, de->input_prio:%p, dp->input_prio:%p, d->outputs:%p\n",
> +		__func__, d->inputs, de->input_prio,
> +		dp->input_prio, d->outputs);
> +	ice_dpll_deinit_info(pf);
> +	return ret;
> +}

...

> +/**
> + * ice_dpll_init - initialize support for dpll subsystem
> + * @pf: board private structure
> + *
> + * Set up the device dplls, register them and pins connected within Linux dpll
> + * subsystem. Allow userpsace to obtain state of DPLL and handling of DPLL

nit: userpsace -> userspace

> + * configuration requests.
> + *
> + * Context: Function initializes and holds pf->dplls.lock mutex.
> + */

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
> new file mode 100644
> index 000000000000..975066b71c5e
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2022, Intel Corporation. */
> +
> +#ifndef _ICE_DPLL_H_
> +#define _ICE_DPLL_H_
> +
> +#include "ice.h"
> +
> +#define ICE_DPLL_PRIO_MAX	0xF
> +#define ICE_DPLL_RCLK_NUM_MAX	4
> +
> +/** ice_dpll_pin - store info about pins
> + * @pin: dpll pin structure
> + * @pf: pointer to pf, which has registered the dpll_pin
> + * @idx: ice pin private idx
> + * @num_parents: hols number of parent pins
> + * @parent_idx: hold indexes of parent pins
> + * @flags: pin flags returned from HW
> + * @state: state of a pin
> + * @prop: pin properities

nit: properities -> properties

> + * @freq: current frequency of a pin
> + */
> +struct ice_dpll_pin {
> +	struct dpll_pin *pin;
> +	struct ice_pf *pf;
> +	u8 idx;
> +	u8 num_parents;
> +	u8 parent_idx[ICE_DPLL_RCLK_NUM_MAX];
> +	u8 flags[ICE_DPLL_RCLK_NUM_MAX];
> +	u8 state[ICE_DPLL_RCLK_NUM_MAX];
> +	struct dpll_pin_properties prop;
> +	u32 freq;
> +};

...

