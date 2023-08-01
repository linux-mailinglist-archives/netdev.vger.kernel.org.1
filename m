Return-Path: <netdev+bounces-23464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E750276C078
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3311C2105F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB64A08;
	Tue,  1 Aug 2023 22:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245B440C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:35:24 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB541BF6
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:35:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so49225915ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690929322; x=1691534122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoE3c8ICemots41uvNCVYms50IlLZwpK4rs4AeMXx54=;
        b=b8Dlc3rNrIoGeoB3AITiPCLmuLqATv0RcuCPd76wAPvqZRG/FLE/JudB8GxxwbyelX
         6U5n5WKerZH663GTEe5YbkqXZm8XsC6h57C+FmmXEEljxgjdAEuDmIoO44ZXGoh+cPvQ
         LdMyklUOsUHGQEyPJcqg0SQYQ1vXA1r4J19FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690929322; x=1691534122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoE3c8ICemots41uvNCVYms50IlLZwpK4rs4AeMXx54=;
        b=VhzUUU/al1VJ6HDdmTLtdFH3+Duy3Bioix5lJxPlC7HBL9Z6lobXZF8dZIaYdUjDTB
         mLxXgGTZx9TRvAQ9dUOAX8Vh1VxrR4BYmnh92ptW70jmr2z/jc+dteCj/o+7KrbRRtwY
         O4+fnKxNhiVDnZY29VascRsbsCoLLiiWzvCiFoaWJzzX6vUHr1+/BUXvQE3ObX1Ii5IM
         o4icbcpAy4/VOzXYKSIxB9unzD0rkAsU/hcW+eWgQLz6b5Q+H2om3csy8WrgE8qF1IGG
         +F9Hc5RP4LNYnge1gJ262dkxBTkIRlM6H7TUhLLAd4ktvUSFqjWIq1722MRba8ue/vh6
         bREw==
X-Gm-Message-State: ABy/qLbwM0cYS+9ssnXNqXwBTrmWewxrwLJOaa50ghl5ZagiNP+7BdPI
	93GYcS02i4t/6ZDk3KvO9nMbWA==
X-Google-Smtp-Source: APBJJlElgraw/W6oH7KzSXHtGpfX8bqLl3oOYDzTdVMdq4PcdwrTVXZGZQ4aBsDaQXfyFx+MN3C5kQ==
X-Received: by 2002:a17:903:1ce:b0:1b8:88c5:2d2f with SMTP id e14-20020a17090301ce00b001b888c52d2fmr16472861plh.64.1690929322430;
        Tue, 01 Aug 2023 15:35:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902759200b001ab2b4105ddsm5246480pll.60.2023.08.01.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 15:35:22 -0700 (PDT)
Date: Tue, 1 Aug 2023 15:35:21 -0700
From: Kees Cook <keescook@chromium.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [RFC net-next 2/2] ice: make use of DECLARE_FLEX() in
 ice_switch.c
Message-ID: <202308011532.A92CFB351@keescook>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
 <20230801111923.118268-3-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801111923.118268-3-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 01:19:23PM +0200, Przemek Kitszel wrote:
> Use DECLARE_FLEX() macro for 1-elem flex array members of ice_switch.c
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 53 +++++----------------
>  1 file changed, 12 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index a7afb612fe32..41679cb6b548 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -1812,15 +1812,11 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
>  			   enum ice_sw_lkup_type lkup_type,
>  			   enum ice_adminq_opc opc)
>  {
> -	struct ice_aqc_alloc_free_res_elem *sw_buf;
> +	DECLARE_FLEX(struct ice_aqc_alloc_free_res_elem *, sw_buf, elem, 1);
> +	u16 buf_len = struct_size(sw_buf, elem, 1);

With the macro I suggested, I think this line can become:

	u16 buf_len = __builtin_object_size(sw_buf, 1);

but either is fine. (N.B. the "1" here is a bitfield, not the "1" size
above).

-Kees

-- 
Kees Cook

