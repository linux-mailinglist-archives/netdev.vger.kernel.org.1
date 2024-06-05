Return-Path: <netdev+bounces-101038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BAC8FD027
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82AD1F21EBB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FDF14AD1A;
	Wed,  5 Jun 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoX3e5Cb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8082BB1C;
	Wed,  5 Jun 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595471; cv=none; b=M61AfHsF0wjIZaqQdfVCmBDSUJasGUn8CsIKTWBKaFoqpbAl+F1LabfFTCDgoVZvf9zwcZY6LQF5kzWtcsF8qZFO7N95WO0q9ms5V9eBq+82zZkCFkSAaOr6E4qRcKVJCXIbwwgmngAcMW31ojqHaGkYBFXGAsEK5y9VFf24BuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595471; c=relaxed/simple;
	bh=5LyhUxJv0s2KRQRgg7PUVSJAFVVaLDS/b7y7t0U5DFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhXNqlelT+OWgKfNgeyuE+tBbiMO5/gaLd8WqsRObdLGLy/BHQoLPy38tDGHAcHpJ7eNClT3dabVbXwlVdaW4FTZeFGzM+aBnfdPqfp1WMezOaM0wvYJYIMS33dsWyjliCFGOxDINNR+5GmI3miDeA33ot11wg+1/ia+BdbcYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoX3e5Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A89EC2BD11;
	Wed,  5 Jun 2024 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717595471;
	bh=5LyhUxJv0s2KRQRgg7PUVSJAFVVaLDS/b7y7t0U5DFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YoX3e5CbLu3Vh2K52jF0o7iUh0XgHM3xiwkUiIczpFEgzBYnBrV1exKU7n5R62ZvB
	 TFAAPScBsQng/ne8I/871js+odlAFOC0CnObl80gGq1rWiBYzwDTg5pIYhAq2EAPUO
	 ZnuYlS5RqF0Ilf0n5MA/i/5c6fUj4Dqp0Foz9mAM26weGWPzcJZqDyWOsi1gCV+w1P
	 TZ2UbA+8ynvoivP4VCm7BPUp7k7LcW+ftvhH+CV92UAD8b75rC2o1ZQQMZrg+T8+13
	 GJ7kxSAVU2kjTFR1gwtrAyW+bYLMSGCHhascswDdOO5uU8cJg1diXzDCUPx/fkOt8H
	 gjQPIg5z+UDZQ==
Date: Wed, 5 Jun 2024 14:51:06 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 2/4] vmxnet3: add latency measurement support
 in vmxnet3
Message-ID: <20240605135106.GM791188@kernel.org>
References: <20240531193050.4132-1-ronak.doshi@broadcom.com>
 <20240531193050.4132-3-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531193050.4132-3-ronak.doshi@broadcom.com>

On Fri, May 31, 2024 at 12:30:47PM -0700, Ronak Doshi wrote:
> This patch enhances vmxnet3 to support latency measurement.
> This support will help to track the latency in packet processing
> between guest virtual nic driver and host. For this purpose, we
> introduce a new timestamp ring in vmxnet3 which will be per Tx/Rx
> queue. This ring will be used to carry timestamp of the packets
> which will be used to calculate the latency.
> 
> User can enable latency measurement using realtime knob in vnic
> setting in VCenter.
> 
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


