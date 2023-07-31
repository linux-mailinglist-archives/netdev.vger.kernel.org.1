Return-Path: <netdev+bounces-22862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B76E769A78
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378A21C20B65
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550C18C22;
	Mon, 31 Jul 2023 15:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6718C14
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B807AC433D9;
	Mon, 31 Jul 2023 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690816229;
	bh=qU1aJBXLj8OvL5BxkBm/yTat5cqvXnPkIXeHqHxtlwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUi3CJXsrDYDon8PZ1ZFtDc3ZImRViLGAkenIm/dbcms4NKyHjAAuhpbXQHSj1OwD
	 fNvQc/0+GbtK2m1R/JtpN9raiFkubbDnJEbOuUW8/JOhH/vGXa+BD9MCTtvWsJTdNR
	 pmZZt45Xr05z4noO+rU+tjw3vo4pQrQeMx674cyTQClhPifmxs1uICImowl4/yJUR6
	 qhVXMOaOwVKXAQ4kAm/p3DrxZfKfa89TUcFwDy2msm6IvH0NOO8Ems7lfd+sVrpYOY
	 584rNgS5xgX7asKgBGAddiKhp9vzYZAHQerYTuDIOvDFtAjhRPqOk8OKE9bN6u7ZP6
	 62WhvKw+9pBCQ==
Date: Mon, 31 Jul 2023 17:10:24 +0200
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
Subject: Re: [PATCH 1/4] soc: qcom: aoss: Move length requirements from caller
Message-ID: <ZMfO4B5ZifxPv/sk@kernel.org>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-2-quic_bjorande@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731041013.2950307-2-quic_bjorande@quicinc.com>

On Sun, Jul 30, 2023 at 09:10:10PM -0700, Bjorn Andersson wrote:
> The existing implementation of qmp_send() requires the caller to provide
> a buffer which is of word-aligned. The underlying reason for this is
> that message ram only supports word accesses, but pushing this
> requirement onto the clients results in the same boiler plate code
> sprinkled in every call site.
> 
> By using a temporary buffer in qmp_send() we can hide the underlying
> hardware limitations from the clients and allow them to pass their
> NUL-terminates C string directly.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/net/ipa/ipa_power.c        |  2 +-
>  drivers/remoteproc/qcom_q6v5.c     |  2 +-
>  drivers/soc/qcom/qcom_aoss.c       | 25 ++++++++++++-------------
>  include/linux/soc/qcom/qcom_aoss.h |  4 ++--
>  4 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
> index 921eecf3eff6..26181eeed975 100644
> --- a/drivers/net/ipa/ipa_power.c
> +++ b/drivers/net/ipa/ipa_power.c
> @@ -332,7 +332,7 @@ void ipa_power_retention(struct ipa *ipa, bool enable)
>  
>  	(void)snprintf(buf, sizeof(buf), fmt, enable ? '1' : '0');
>  
> -	ret = qmp_send(power->qmp, buf, sizeof(buf));
> +	ret = qmp_send(power->qmp, buf);
>  	if (ret)
>  		dev_err(power->dev, "error %d sending QMP %sable request\n",
>  			ret, enable ? "en" : "dis");
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 192c7aa0e39e..8b41a73fa4d1 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -35,7 +35,7 @@ static int q6v5_load_state_toggle(struct qcom_q6v5 *q6v5, bool enable)
>  
>  	WARN_ON(ret >= Q6V5_LOAD_STATE_MSG_LEN);
>  
> -	ret = qmp_send(q6v5->qmp, buf, sizeof(buf));
> +	ret = qmp_send(q6v5->qmp, buf);
>  	if (ret)
>  		dev_err(q6v5->dev, "failed to toggle load state\n");
>  
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index e376c32cc16e..5e74332515cf 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -206,36 +206,35 @@ static bool qmp_message_empty(struct qmp *qmp)
>   * qmp_send() - send a message to the AOSS
>   * @qmp: qmp context
>   * @data: message to be sent
> - * @len: length of the message
>   *
>   * Transmit @data to AOSS and wait for the AOSS to acknowledge the message.
> - * @len must be a multiple of 4 and not longer than the mailbox size. Access is
> - * synchronized by this implementation.
> + * data must not be longer than the mailbox size. Access is synchronized by
> + * this implementation.
>   *
>   * Return: 0 on success, negative errno on failure
>   */
> -int qmp_send(struct qmp *qmp, const void *data, size_t len)
> +int qmp_send(struct qmp *qmp, const void *data)
>  {
>  	long time_left;
> +	char buf[QMP_MSG_LEN];
>  	int ret;

Hi Bjorn,

please consider preserving reverse xmas tree - longest line to shortest -
for local variable declarations in this Networking code.

	char buf[QMP_MSG_LEN];
	long time_left;
	int ret;

...


