Return-Path: <netdev+bounces-26946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CA377991D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 23:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206A6281E19
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA4329A3;
	Fri, 11 Aug 2023 21:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141AC13AC7
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 21:01:59 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C5E7E;
	Fri, 11 Aug 2023 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Jpy95QT2Gj0P5lCOqBdXXUs2+WPR8bargTYgOq+jIE=; b=tKzL+KVTlHYFtLvSuw1fpzMkAi
	Dow3493P0T+n8+qGJA7IrMXwCn7NFXJ7o93JSJtCNW5gcaD4lIGaThl5SPSmO56He5VbIrMGZWGfR
	kBwoUeGgIPT25AxvVRlZiAvzhJ4/6rJJsePtFPIhRcSJpOeFQvTE7QFDrMyVJs16PPKI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qUZGY-003qQb-CL; Fri, 11 Aug 2023 23:01:50 +0200
Date: Fri, 11 Aug 2023 23:01:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Chris Lew <quic_clew@quicinc.com>, Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] soc: qcom: aoss: Add debugfs interface for
 sending messages
Message-ID: <d212e5a7-e9e5-4297-85fb-030818f7c647@lunn.ch>
References: <20230811205839.727373-1-quic_bjorande@quicinc.com>
 <20230811205839.727373-3-quic_bjorande@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811205839.727373-3-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static ssize_t qmp_debugfs_write(struct file *file, const char __user *userstr,
> +				 size_t len, loff_t *pos)
> +{
> +	struct qmp *qmp = file->private_data;
> +	char buf[QMP_MSG_LEN];
> +	int ret;
> +
> +	if (!len || len >= QMP_MSG_LEN)
> +		return -EINVAL;
> +
> +	if (copy_from_user(buf, userstr, len))
> +		return -EFAULT;
> +	buf[len] = '\0';
> +
> +	ret = qmp_send(qmp, buf);
> +	if (ret < 0)
> +		return ret;

Sorry, but you still appear to be sending binary blobs from userspace
to the firmware. This is not liked.

The documentation you pointed to has three commands. Please implement
three debugfs files, one per command.

    Andrew

---
pw-bot: cr

