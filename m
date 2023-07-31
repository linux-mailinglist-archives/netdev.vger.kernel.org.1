Return-Path: <netdev+bounces-22861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB4F769A65
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137912816ED
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAEF18C1E;
	Mon, 31 Jul 2023 15:08:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586A18C17
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE470C433C7;
	Mon, 31 Jul 2023 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690816137;
	bh=oOqLznACyt0Ze2IndXFJD1mCt9TSZtRNhA9cISgtZXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhqUrVvU/jpadfIcIjeyew8oAopooOc0nuJYMPtyReqOMemjUriEaGM1gXynsSbrL
	 tXD8KcsbgO+lmwA07fI2kLZY02ghDtoieDnPb9I67uv5pm8sr0syJEVU6e70o0t8IA
	 Kk1myA92TRiaD755njdJp4wH0nHR8hLwz988qcDSSJ1eoMre2vWcPz87PemUpQir70
	 c1k0LjXhakjUp5ZyMWvrLX877WeRgkr3CxiDgm4AFqeEXZwmgIJXrB+pJa+A1LLk2k
	 B0yWQBGNZUd+8PCXLdvbmAo1+3kJk4tCoEKM6hhqGRKlgkij14v47TOLDgd/CvKYR6
	 kLN9uCQ58Ijpg==
Date: Mon, 31 Jul 2023 17:08:52 +0200
From: Simon Horman <horms@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Chris Lew <quic_clew@quicinc.com>, Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/4] soc: qcom: aoss: Add debugfs interface for sending
 messages
Message-ID: <ZMfOhJI0FNXFwenb@kernel.org>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-3-quic_bjorande@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731041013.2950307-3-quic_bjorande@quicinc.com>

On Sun, Jul 30, 2023 at 09:10:11PM -0700, Bjorn Andersson wrote:
> From: Chris Lew <clew@codeaurora.org>
> 
> In addition to the normal runtime commands, the Always On Processor
> (AOP) provides a number of debug commands which can be used during
> system debugging for things such as preventing power collapse or placing
> floor votes for certain resources. Some of these are documented in the
> Robotics RB5 "Debug AOP ADB" linked below.
> 
> Provide a debugfs interface for the developer/tester to send these
> commands to the AOP.
> 
> Link: https://docs.qualcomm.com/bundle/publicresource/topics/80-88500-3/85_Debugging_AOP_ADB.html
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> [bjorn: Dropped debugfs guards, improve error codes, rewrote commit message]
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/soc/qcom/qcom_aoss.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index 5e74332515cf..4c5bb7034fff 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2019, Linaro Ltd
>   */
>  #include <linux/clk-provider.h>
> +#include <linux/debugfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/mailbox_client.h>
> @@ -82,6 +83,7 @@ struct qmp {
>  
>  	struct clk_hw qdss_clk;
>  	struct qmp_cooling_device *cooling_devs;
> +	struct dentry *debugfs_file;

Hi Bjorn,

Please consider adding debugfs_file to the kernel doc for struct qmp.

>  };
>  
>  static void qmp_kick(struct qmp *qmp)

...

