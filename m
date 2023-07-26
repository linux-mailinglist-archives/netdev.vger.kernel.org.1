Return-Path: <netdev+bounces-21545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406EB763E07
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7411281E43
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22E1803D;
	Wed, 26 Jul 2023 18:00:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC01AA60
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:00:08 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17892697;
	Wed, 26 Jul 2023 11:00:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so27853b3a.0;
        Wed, 26 Jul 2023 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690394407; x=1690999207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBrqRf9KetYwqqw9kE2OBONwOaipxgqPSXo8Gqyj3es=;
        b=BJugwYfk9LHDG/VPjAGZ96UsiwDn8TCeZ9LCCV0vdU+A86oCwErSafXPcRTlt4wyHH
         olEKlDsp5tCv9J+gTP/BCdtUV1gH+RSTCHx3QU5HZaWkvSMVDcnHbt0HTDCMOpGiNsVE
         KyyFCDdEclB2qjuRpur33Oh2MGejJdqA7Pfq6/FOgmiHLUK7/y5O6PIXfnfP6kye5GyV
         uEf8nCHvAvLC4zwWtjhSolGUu8oBsiIviNL8P5VLKgQCOepoWWgti5/7n7qeNhc9amP9
         wgNYW8PGLhnvtR+Aax5NdsXZYVoX8zScB/0xptN72pTMS2Pro4MsWraYmL2WqtGk/Mrl
         xVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690394407; x=1690999207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBrqRf9KetYwqqw9kE2OBONwOaipxgqPSXo8Gqyj3es=;
        b=AfpQt7vMoj9TIqAokboYjpOGDZHEPAHIR5ewl3FgIlByJLMwu1eSkgnPPxlUJCRYiM
         sksazTbL89ru3Stn0Ai1torwRQ2Gm+IBGIy8FSJfxK+cDljUk+kkPKeZYNJBc2e5EMNx
         6sBwJdnKCw8UH0Ty39MoBnNDpk7v1x2/bRoaxkv5lKQPJyv5UNg7sMQO187ChK3gwxys
         hQBP5Kby13MUWAE7vrcgC71Wu/ShNDNqA11B54S/ZLR4FJHx3Blmxo5iw3tVo0lKuLy9
         Jjf7LpP64f3TpvNgpdtsvWOzR5Mig5QVjMVnGowRq17lgKqAA39cFLdY5H2M5xHcXE0i
         LLEQ==
X-Gm-Message-State: ABy/qLZl0BV1E7m9P1rmYjL6Wv4PZoYAsuoIhU0CV6qbePFIdE7a+dCh
	ff+yx2LekXxDAa6t6GKRlKE=
X-Google-Smtp-Source: APBJJlG559OmZQOAWOCS2hhWRYItf+2S/u6gwpf8Y2j8REtyCHKh5CtnNq+MNgm4Zg9WsYQYl0arUg==
X-Received: by 2002:a05:6a00:2d82:b0:675:8627:a291 with SMTP id fb2-20020a056a002d8200b006758627a291mr2820706pfb.3.1690394407071;
        Wed, 26 Jul 2023 11:00:07 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id i8-20020aa78d88000000b006765cb32558sm11724126pfr.139.2023.07.26.11.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:00:06 -0700 (PDT)
Date: Wed, 26 Jul 2023 11:00:03 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Johannes Zink <j.zink@pengutronix.de>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>, patchwork-jzi@pengutronix.de,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <ZMFfI3xU5pkJW4x4@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 12:01:31PM +0200, Johannes Zink wrote:

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
> index bf619295d079..d1fe4b46f162 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
> @@ -26,6 +26,12 @@
>  #define	PTP_ACR		0x40	/* Auxiliary Control Reg */
>  #define	PTP_ATNR	0x48	/* Auxiliary Timestamp - Nanoseconds Reg */
>  #define	PTP_ATSR	0x4c	/* Auxiliary Timestamp - Seconds Reg */
> +#define	PTP_TS_INGR_CORR_NS	0x58	/* Ingress timestamp correction nanoseconds */
> +#define	PTP_TS_EGR_CORR_NS	0x5C	/* Egress timestamp correction nanoseconds*/
> +#define	PTP_TS_INGR_CORR_SNS	0x60	/* Ingress timestamp correction subnanoseconds */
> +#define	PTP_TS_EGR_CORR_SNS	0x64	/* Egress timestamp correction subnanoseconds */

These two...

> +#define	PTP_TS_INGR_LAT	0x68	/* MAC internal Ingress Latency */
> +#define	PTP_TS_EGR_LAT	0x6c	/* MAC internal Egress Latency */

do not exist on earlier versions of the IP core.

I wonder what values are there?

Thanks,
Richard

