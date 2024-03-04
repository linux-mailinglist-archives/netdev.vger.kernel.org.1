Return-Path: <netdev+bounces-76948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554886F9AF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 06:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E541F21206
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 05:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFDCC13D;
	Mon,  4 Mar 2024 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGN3Thb5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B5BA33
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531147; cv=none; b=LqKw38xRMtaY1O8Z4OsIN8fLoOWgfaIMURbkCssmTTaq1YghCK1il2s4TfM+0wrwFlc3BvEdfIT/pkKZ2thVmLnWWQOGscFmL2zPt/k/DyS/2qmg7Rw9l1xSg8pI7+7tbbXrP0t76oYVXSGh9Y5jvOxNnxZWesJomxO8UazXe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531147; c=relaxed/simple;
	bh=Opih2PZV9gDsPvBwpspCv8TGpZmtmjlOY8SluqDWbFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6l6QT9fUG8m64VAD6mn8+fYY1fSWaTZNHhU30p0PLsqzlmtA6D8I6oohcRu5TNJ/Mq+Zyp97w6NvjG8X7H+xS1RUjFbRN9W24ux6k8mi3rtVsBRJDf66QbCFKGlqEcH6Wum78rBviGtQdhBjI+C8/gF23+/W9HUSbGYO0GJ9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGN3Thb5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e58d259601so2576414b3a.3
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 21:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709531144; x=1710135944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nyLi8+SmSre8SLNOigrTqCqxHxWeA+jhwdAxcyOndLM=;
        b=WGN3Thb5nCuEA604AinhfkMD+bTyPJzuGBLsOXz3YY+Rg6kckJu+iTRpqpU2il7i3P
         ChUxgagjFlrjxQxOQGysTqSuR5hXR9WuMc4PYa68iWKmqAYSniwzZGUhRfWX95x7e3EG
         X5ECHiQd7F3rV/AuaK5j+AtLod07cJhDE0ZZuA3EiWCX4ErSsIAS+TI/tSoWUvufdfkE
         p+OenSJE1ga3+/AIrwnXszTcVQMOC+Iz+IHba6kdNYGStUFdGTE6Q2iE8SCKTjYji4CK
         M4RSFwdclltEnDCH1LWEFDiLHoGvft/DpwXKux41XzqGqk4O2BA+M0pFqnyIoCWGBMw1
         mfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709531144; x=1710135944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyLi8+SmSre8SLNOigrTqCqxHxWeA+jhwdAxcyOndLM=;
        b=NlgasLpySCxwv+GjNJvqIaIY1DmqE5zOWffbjvZGbQTF0qlpgWQVEruMKnrxjTN7Ap
         lq5oqdPApkSTTd2RwsIQgcFVb3d2rLfnPb9cqDhg4XpR1HVB79aEz1xJsM3aWl0KETH6
         d1mCvZEbybKMm0hC5MEVfU8YxwE6itVUWRGUTZ5O5MG2A/XdZ8PTuanpiNMmv/M4QE9W
         U2gW3dgExJ3DghVcoY9XqzGYXqr6AL+RKNl1RKRZgIxpT8m3GhV26YwqeoNxWsybozlB
         uRXVD+aX6fCBe1QaBabwziTYku77LHicl64YCr51p42YagapCfCHB4vm/V6sVRWyGSjy
         NtEg==
X-Forwarded-Encrypted: i=1; AJvYcCWbMeF9CTR0oIZQz/6oQ1TA+BQDaa2q74hXo959QR+uGBodRfTGtaHAEQIgE0h0Fc60ZvX7raq+n6LiuY7HeQlVjXYQK503
X-Gm-Message-State: AOJu0YyNmGIOH5jQjIjIQn/77eZzGADTlUAUUsRk2iLKUZFmP4KH95WB
	1x7V51JEDDc9OVCveQ/G7764jsmfS42V4Pg+iU02lFD0HW/ivscXkXczlhYywg==
X-Google-Smtp-Source: AGHT+IEb05hPzFeBZje+h75WEQQpiRcBp848ihooFqT4tnzoz+8bG6TqQJGYpSZro6DP/2UhVDknig==
X-Received: by 2002:a05:6a00:2fd1:b0:6e5:d3b9:2d06 with SMTP id fn17-20020a056a002fd100b006e5d3b92d06mr7157632pfb.21.1709531144470;
        Sun, 03 Mar 2024 21:45:44 -0800 (PST)
Received: from thinkpad ([117.207.30.163])
        by smtp.gmail.com with ESMTPSA id q4-20020a63e944000000b005dc1edf7371sm6746085pgj.9.2024.03.03.21.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 21:45:44 -0800 (PST)
Date: Mon, 4 Mar 2024 11:15:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v5 0/3] wifi: ath11k: hibernation support
Message-ID: <20240304054536.GA2647@thinkpad>
References: <20240304021554.77782-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304021554.77782-1-quic_bqiang@quicinc.com>

On Mon, Mar 04, 2024 at 10:15:51AM +0800, Baochen Qiang wrote:
> Currently in ath11k we keep the firmware running on the WLAN device when the
> network interface (wlan0) is down. The problem is that this will break
> hibernation, obviously the firmware can't be running after the whole system is
> powered off. To power down the ath11k firmware for suspend/hibernation some
> changes both in MHI subsystem and ath11k are needed.
> 
> This patchset fixes a longstanding bug report about broken hibernation support:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=214649
> 
> There already is an RFC version which has been tested by multiple users with
> positive results:
> 
> https://patchwork.kernel.org/project/linux-wireless/cover/20231127162022.518834-1-kvalo@kernel.org/
> 
> Basically the RFC version adds two APIs to MHI stack: with the first one ath11k
> is able to keep MHI devices when going to suspend/hibernation, getting us rid of
> the probe deferral issue when resume back. while with the second one ath11k could
> manually prepare/unprepare MHI channels by itself, which is needed because QRTR
> doesn't probe those channels automatically in this case.
> 
> Mani, the MHI maintainer, firstly doesn't like that version and insists that an
> MHI device should be destroyed when suspend/hibernation, according to his
> understanding on device driver model. See
> 
> https://lore.kernel.org/mhi/20231127162022.518834-1-kvalo@kernel.org/
> 
> After a long discussion Mani thought we might need a new PM callback with which
> ath11k is able to wait until kernel unblocks device probe and thus MHI channels
> get probed. So we came to the kernel PM list and there Mani realized that his
> understanding is not correct so he finally agrees to keep MHI device during
> suspend/hibernation. See
> 
> https://lore.kernel.org/all/21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com/
> 
> Mani also pointed out that an MHI controller driver (ath11k here) should not touch
> MHI channels directly because those channels are managed by the corresponding MHI
> client driver (QRTR here). To address this, we come up with this version.
> 
> Compared with that RFC version, this version adds PM callbacks in QRTR module:
> suspend callback unprepares MHI channels during suspend and resume callback
> prepares those channels during resume. In this way ath11k doesn't need to do
> unprepare/prepare work by itself so those two APIs added in RFC version are
> removed now.
> 
> The power down/up procedure requires a specific sequence in which PM callbacks
> of wiphy, ath11k and QRTR are called, this is achieved by exploiting the
> child-father relationship between their device struct, and also the PM framework
> which separates whole suspend/resume process into several stages. Details in
> patch [3/3].
> 
> v5:
>  - remove Kalle's s-o-b tag in patch 1/3 per Mani.

Why are you not carrying review tags? I have reviewed the patches and provided
my tags for patches 1 and 2 in v3 and v4. Now there is no tag again in v5 :(

You cannot expect maintainers to provide review tags in each revision.

- Mani

> 
> v4:
>  - resend v3 as v4 to CC netdev folks. No changes in patches themselves.
> 
> v3:
>  - skip QRTR suspend/resume if MHI device is found to be in suspend state.
> 
> v2:
>  - add comment on why destroying the device is optional in
>    mhi_pm_disable_transition().
>  - rename mhi_power_down_no_destroy() as mhi_power_down_keep_dev().
>  - refine API description of mhi_power_down() and
>    mhi_power_down_keep_dev().
>  - add/remove __maybe_unused to QRTR PM callbacks.
>  - remove '#ifdef CONFIG_PM'.
>  - refine commit log of patch 1/3 and 2/3.
> 
> Baochen Qiang (3):
>   bus: mhi: host: add mhi_power_down_keep_dev()
>   net: qrtr: support suspend/hibernation
>   wifi: ath11k: support hibernation
> 
>  drivers/bus/mhi/host/internal.h        |   4 +-
>  drivers/bus/mhi/host/pm.c              |  42 ++++++++--
>  drivers/net/wireless/ath/ath11k/ahb.c  |   6 +-
>  drivers/net/wireless/ath/ath11k/core.c | 105 +++++++++++++++++--------
>  drivers/net/wireless/ath/ath11k/core.h |   6 +-
>  drivers/net/wireless/ath/ath11k/hif.h  |  14 +++-
>  drivers/net/wireless/ath/ath11k/mhi.c  |  12 ++-
>  drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
>  drivers/net/wireless/ath/ath11k/pci.c  |  44 +++++++++--
>  drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
>  include/linux/mhi.h                    |  18 ++++-
>  net/qrtr/mhi.c                         |  46 +++++++++++
>  12 files changed, 244 insertions(+), 60 deletions(-)
> 
> 
> base-commit: 48294c8a226d82c687b52b2eb90a075bbfbcb884
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

