Return-Path: <netdev+bounces-66788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5B840A6D
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CAB1C22008
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8DD15444C;
	Mon, 29 Jan 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fE4W5cm2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C129154448
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543265; cv=none; b=BgtRWPr5+YQQbgDSiN2u9mlIeG8w0TYSdUXx9GQ641sddnvBdk3C46LT5Ie0V9mSA2Y//iVSUuIk2eT/9iUlf0DvOAMGqK+z7WrlNlOrQAfwVrvnCFeDTzu18EKuVZM6tID/UZP4dWAOeqBA9LPyQxLEnaTdzqi41cfnsYv39vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543265; c=relaxed/simple;
	bh=e71rTvtPxDFneWq3ZzMAOdNG39+x8/faX2BoKUgmBvA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aMyi1rCNndBFvU/LJ5ahMG6MYDW6ZXTUJ/KioSk2I8811qp9CvCAPyBvSbNtDnRHj0WoxTUXk0G/D/PtWC4J+djdN5PkQlgCUuJ171xRlBvETmNllOtHpNBs5a3ZaPNfIwuQEE5uhRxncLW1UgyPRK6H08ZSTrRGsCmy5j3646Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fE4W5cm2; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-467e4a04086so438055137.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706543262; x=1707148062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oJOfHja10uqFUW21l2U+7rJfVn+PAsABlarxrannHD8=;
        b=fE4W5cm2t97bHMqhisbL84cN061EiNx+Rc1358mDmTNqr4ZPK14R465cjzL8GQrlQE
         g0V/9PrqAIPRFYuCTDNOzeg0ZL8bYPEEoNKb5J8UXK5qfAvsMetASdAd5w0Nv73vSlHP
         7P4kGbcl9h8DPMIOkVo+nySBSyyjty3OqbBQ8WrOmNPR6rdcLSBi5JdC+gxCqottd/6d
         CE1q+Y6V1N1zUBCSMIhwR/J0pkBRq7DZLhFVR8ihP2nQyuqKoXLY9dgHxtR9b6TkghIj
         UaPBKuvxhgPzAZcieuCU4zaFODmz4E906YdEM/ux+rz83PYATjKI7SFzd9jgIeKKlXQe
         sShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706543262; x=1707148062;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJOfHja10uqFUW21l2U+7rJfVn+PAsABlarxrannHD8=;
        b=TKgh27dxqQHWwxJ7GJ7e9cEoGB0YWIj1oUoDUuJLBBteKhXeSc8WRcnHdmW5VYRW8j
         9VkWPtZpPDuE5Vg515Xt1uZk2vJf7vB4yZQqdTu5XI0w1r8wNO+2gX2VRQSecklD2d0w
         /2IprNXMZ7wnjkMvL6gBwH08JCyfx4MKd5JVttX/ApNtK+Am4eS72f58RtobsiTB6mDG
         gtCLfsFlxxt24Nbq8KNQW7kduLNgaX218qgKQWchYcAPcnQ4WGCoMVw6rHVcPse1hBTH
         80njfBDb3KjdBEZr+o+yImZudPObEzkLItuXgd8TKPlECbHGcIE8qoMetyi9xbSR0MJ4
         FMgQ==
X-Gm-Message-State: AOJu0YyivQKeW9XpZ/+K4Ag2dN9hKEn5MJR0nPVhl0FWr59KbaAgXMNj
	EpR+2VLhxTRxEcvhajr8QNGitOf1rD1wtPnrBQIdg+5zg+en/9GP7VqGhGzfL4/eqnyxugzhqqj
	J+1mbvKHsk9ijKQjRAN3fpFYmKoakpiOfhyE1vw==
X-Google-Smtp-Source: AGHT+IHmSl2fS1dbhrXEFwChru7nCooY7CV03h6IE8myHIF3fsDlAyU2AUGEY1tYOslEsEj5iyXZpNsdl2G7Re3ey70=
X-Received: by 2002:a05:6102:2267:b0:46b:57b4:ad3d with SMTP id
 v7-20020a056102226700b0046b57b4ad3dmr1102566vsd.21.1706543262416; Mon, 29 Jan
 2024 07:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 29 Jan 2024 21:17:31 +0530
Message-ID: <CA+G9fYvYQRnBbZhHknSKbwYiCr_3vPwC5zPz2NsV9_1F7=paQQ@mail.gmail.com>
Subject: stable-rc: 6.1: mlx5: params.c:994:53: error: 'MLX5_IPSEC_CAP_CRYPTO'
 undeclared (first use in this function)
To: linux-stable <stable@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	linux-rdma@vger.kernel.org, lkft-triage@lists.linaro.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Leon Romanovsky <leonro@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Following build errors noticed on stable-rc linux-6.1.y for arm64.

arm64:
--------
  * build/gcc-13-lkftconfig
  * build/gcc-13-lkftconfig-kunit
  * build/clang-nightly-lkftconfig
  * build/clang-17-lkftconfig-no-kselftest-frag
  * build/gcc-13-lkftconfig-devicetree
  * build/clang-lkftconfig
  * build/gcc-13-lkftconfig-perf

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
------
drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function
'mlx5e_build_sq_param':
drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error:
'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
  994 |                     (mlx5_ipsec_device_caps(mdev) &
MLX5_IPSEC_CAP_CRYPTO);
      |
^~~~~~~~~~~~~~~~~~~~~

Suspecting commit:
  net/mlx5e: Allow software parsing when IPsec crypto is enabled
  [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.75-143-g87ae8e32051d/testrun/22361778/suite/build/test/gcc-13-lkftconfig-debug/details/

--
Linaro LKFT
https://lkft.linaro.org

