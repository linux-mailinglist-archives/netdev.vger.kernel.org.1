Return-Path: <netdev+bounces-125344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5640396CC6F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6F91C22607
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E645C2ED;
	Thu,  5 Sep 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSSIk2UN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E838F66
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501530; cv=none; b=aObxW3upDX6iB3oU68lU7hMvTfmPDjZmRoaFpihpic5pg/BcspyeVImgJ7NgoPEfEPFkmJzyFSI/L0wiOjbzrxUxwq9B7m+ds5+Gan+9HRw88syGOFWWFb+kMOjl1tSwFR1Qina8Mjqk8zQVXYiM2ZFs4v2ewS81jLtz/QMU6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501530; c=relaxed/simple;
	bh=Dp0uIt19uV8jfyz1blroxyh65yMot6gtYdnqFbeY5Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEEUgZRQIXtBZkEX5ttAXdfKofuGsUGzvljjEoayWPZPh1vb+whkjoyl7ARA3nVmEMoF2oL6qH3s3Gm3dyeGf/io862aBmBuS83Z9+UdxuArsbYbgw9TjTqnAdKv7ex6nDBKoI7fW0xgZSo67qRsiYw0Q82o1fOdNE7B4FmSVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSSIk2UN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57238C4CEC2;
	Thu,  5 Sep 2024 01:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725501529;
	bh=Dp0uIt19uV8jfyz1blroxyh65yMot6gtYdnqFbeY5Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSSIk2UNCV0ui1IywpeOjyXPH0o6sqeolm49JPArO+VfXLeexPCQSWqoo09RYEF7V
	 rilv4BfCu3N7hL1bEI0Rkhq9Ruo/1RXmGMRDu5RnM4V7JM1tvoaBciXHqedGJL/wah
	 uWZ0zKw51cCv0BsnD3+16sfRNIoPDvhIu5xm7yKAUIHbclj7+47pFY/EMcvCppY+Xu
	 9O4Tf98ShoyQRGaZEQGPURH6B7sA4+Sszx4zZUEc6Mp3UBJmSWecHiIkh4GgfgP+EJ
	 kvowgyUCeYdkJvVRGcqZ79BVRzAimdjPndcEhYHjDi1u7chQcrgGBVFzen3o32LvMu
	 djDONxxm4dDNw==
Date: Wed, 4 Sep 2024 18:58:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 14/15] iavf: Add net_shaper_ops support
Message-ID: <20240904185848.19a7f588@kernel.org>
In-Reply-To: <f95f1e851e8e40bbd9cd382e42f72e12998a122c.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<f95f1e851e8e40bbd9cd382e42f72e12998a122c.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 15:53:46 +0200 Paolo Abeni wrote:
> +static int iavf_verify_handle(struct net_shaper_binding *binding,
> +			      const struct net_shaper_handle *handle,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct iavf_adapter *adapter = netdev_priv(binding->netdev);
> +	int qid = handle->id;
> +
> +	if (qid >= adapter->num_active_queues) {
> +		NL_SET_ERR_MSG_FMT(extack, "Invalid shaper handle, queued id %d max %d",
> +				   qid, adapter->num_active_queues);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

This can go once we have the real_num validation in the core?
Otherwise LGTM!

