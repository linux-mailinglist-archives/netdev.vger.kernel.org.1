Return-Path: <netdev+bounces-112801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A395A93B4A2
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC941F22D33
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C9515EFAE;
	Wed, 24 Jul 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wiNRq8MQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493615EFC9
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837508; cv=none; b=bib70HL1Gta3eyyc4RMo5YC3u+SQSzdFYTERK5+xFNF9LGvhg9p6kJz9HavlDYAc1bXHQTn/5QP+vZNtntEiuMNETSkeUNGf1o9xE8EZ5tcdzUcDarb0F8HfBcB1/8Zyr6KlOC0QlK1j6ozsGX1owF+HTfJJ1mfUZo9eWUOk+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837508; c=relaxed/simple;
	bh=W2bUjAP7MhfYd0F/wGCLhHPaYybJTOMSFQa7xR+R4+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qa+QnftM2bkjJE2Bdv6pJ6X/8fgp6Qy0LCQwyN2f5qxumEjoRsoxw6ZR2UQBcUDP5enJ3q3Q23l6lY67kKtochGceGvvcuZQ4mFkmXPnyDkcaMSYnDZK21Oc4oMBaHt0dV5dviVK20Rt6sMuaLj9BFOs50dC6YfRkdx8M7H/WMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wiNRq8MQ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d9de9f8c8dso3726230b6e.1
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721837506; x=1722442306; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c35JIAd1RtfxDUn+Ffa74CAGm2VTsGX1wdwv6k5IrP4=;
        b=wiNRq8MQtVdv0hKYCNGR3GgAABPZQSi1RTOjk/yjKTLbbJVWdp/VgBnKzQlT9T+gFf
         IBAhrPBOiVnT2DLDzIRZJZvYdVNws+E+gUVHzbgrtct0aQLqlZge02fKmiQwO19ydGH9
         eKI0ec9KTJUh1anW7Pex5Rlf0QltoPPZQvHq+gYyWoLl6sx7Gp9S2yOVpPsAc2HiDCiz
         uFyhm9t+P5TeQeHWoTRVngmO5/aZVTKyzv8VCJXVUHTULdqXD0OE9WYe4RRwgDk2FFsG
         XWPAAWgVDEYP89Y/goYFu2rhbr4MB367tYNGRyk+0MSyo0U43nlmzDxNlKuchvSeIMNY
         EqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837506; x=1722442306;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c35JIAd1RtfxDUn+Ffa74CAGm2VTsGX1wdwv6k5IrP4=;
        b=QwO6f0ZCMh+N+jYEtG3mzzYFrtCmt0ukA56FkJy6qAEDa05kB1cUrzP6TDzsgF3NK5
         21L7yy7Lm0kAmhUsJiTwlu5Bf36qjF7qa7kp6ZjgyzXKl2v44uCzAkGoQqxZ6Ks/8uGx
         lmMW3A32/OM7rdV4/jesjoG8W9zmBfeOL2foQjV4L0c/eUN+6l+xFROf96QF8KBmmOE0
         M/qznFTyLfMY6tVU0PHh6R82MGOKjvtLhzpq8bW7rOKEnrITxfr95P8ymNoUx52ayhUl
         IXcAPf7kNcefz2HddoXJ3DuKk9NXnKXdrqWLlkOcUs63qG+yg+usLEYkLiuDwd5/+KXw
         uF4Q==
X-Gm-Message-State: AOJu0Ywktg5bDrAZszZ/c/hDZBd6AomINRk95DJprOwbP3nQr0eo8zYb
	dPiVpsDnfoTwQh1QZvZ6lmchPoatHaFN/rNiqY4g/eMqdmGT4JekAlXXO3UmD7k=
X-Google-Smtp-Source: AGHT+IHSb8zBqIDnF8s6rDi6ddqCpOgI8zWB2B0SQDQrXsHZ1dzXL1rbc2zdWIwEn57hkeeglNaHIw==
X-Received: by 2002:a05:6808:158f:b0:3d9:2ab5:c697 with SMTP id 5614622812f47-3db10f279dfmr72708b6e.20.1721837505752;
        Wed, 24 Jul 2024 09:11:45 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:23ae:46cb:84b6:1002])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae09d5fa7sm2442487b6e.48.2024.07.24.09.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:11:45 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:11:43 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Raghu Vatsavayi <rvatsavayi@caviumnetworks.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] liquidio: ethtool and led control support
Message-ID: <7e9fbad4-d040-409c-a4d2-24e9929e63ba@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Raghu Vatsavayi,

Commit dc3abcbeaeb9 ("liquidio: ethtool and led control support")
from Sep 1, 2016 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/ethernet/cavium/liquidio/lio_ethtool.c:2721 cn23xx_read_csr_reg()
	warn: reusing outside iterator: 'i'

drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
    2706         /*0x100b0*/
    2707         for (i = 0; i < CN23XX_MAX_OUTPUT_QUEUES; i++) {
    2708                 reg = CN23XX_SLI_OQ_PKTS_SENT(i);
    2709                 len += sprintf(s + len, "\n[%08x] (SLI_PKT%d_CNTS): %016llx\n",
    2710                                reg, i, (u64)octeon_read_csr64(oct, reg));
    2711         }
    2712 
    2713         /*0x100c0*/
    2714         for (i = 0; i < CN23XX_MAX_OUTPUT_QUEUES; i++) {

You would think this would loop 64 times, but it only loops once

    2715                 reg = 0x100c0 + i * CN23XX_OQ_OFFSET;
    2716                 len += sprintf(s + len,
    2717                                "\n[%08x] (SLI_PKT%d_ERROR_INFO): %016llx\n",
    2718                                reg, i, (u64)octeon_read_csr64(oct, reg));
    2719 
    2720                 /*0x10000*/
--> 2721                 for (i = 0; i < CN23XX_MAX_INPUT_QUEUES; i++) {

Because these inside loops re-use i and end with i == 64.

    2722                         reg = CN23XX_SLI_IQ_PKT_CONTROL64(i);
    2723                         len += sprintf(
    2724                                 s + len,
    2725                                 "\n[%08x] (SLI_PKT%d_INPUT_CONTROL): %016llx\n",
    2726                                 reg, i, (u64)octeon_read_csr64(oct, reg));
    2727                 }
    2728 
    2729                 /*0x10010*/
    2730                 for (i = 0; i < CN23XX_MAX_INPUT_QUEUES; i++) {

Etc..

    2731                         reg = CN23XX_SLI_IQ_BASE_ADDR64(i);
    2732                         len += sprintf(
    2733                             s + len,
    2734                             "\n[%08x] (SLI_PKT%d_INSTR_BADDR): %016llx\n", reg,
    2735                             i, (u64)octeon_read_csr64(oct, reg));
    2736                 }
    2737 
    2738                 /*0x10020*/
    2739                 for (i = 0; i < CN23XX_MAX_INPUT_QUEUES; i++) {
    2740                         reg = CN23XX_SLI_IQ_DOORBELL(i);
    2741                         len += sprintf(
    2742                             s + len,
    2743                             "\n[%08x] (SLI_PKT%d_INSTR_BAOFF_DBELL): %016llx\n",
    2744                             reg, i, (u64)octeon_read_csr64(oct, reg));
    2745                 }
    2746 
    2747                 /*0x10030*/
    2748                 for (i = 0; i < CN23XX_MAX_INPUT_QUEUES; i++) {
    2749                         reg = CN23XX_SLI_IQ_SIZE(i);
    2750                         len += sprintf(
    2751                             s + len,
    2752                             "\n[%08x] (SLI_PKT%d_INSTR_FIFO_RSIZE): %016llx\n",
    2753                             reg, i, (u64)octeon_read_csr64(oct, reg));
    2754                 }
    2755 
    2756                 /*0x10040*/
    2757                 for (i = 0; i < CN23XX_MAX_INPUT_QUEUES; i++)
    2758                         reg = CN23XX_SLI_IQ_INSTR_COUNT64(i);
    2759                 len += sprintf(s + len,
    2760                                "\n[%08x] (SLI_PKT_IN_DONE%d_CNTS): %016llx\n",
    2761                                reg, i, (u64)octeon_read_csr64(oct, reg));
    2762         }
    2763 
    2764         return len;
    2765 }

regards,
dan carpenter

