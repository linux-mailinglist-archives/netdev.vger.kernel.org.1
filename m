Return-Path: <netdev+bounces-143991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D569C503F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BFE280F05
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51CA209F4F;
	Tue, 12 Nov 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeVSuJkS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51419D067;
	Tue, 12 Nov 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398670; cv=none; b=dJedDTbQwWJDmdopXnqWEBOl0I71rs6+OHD7hdJ7mMKvX70N3HlPH1QrMvcePG5ujyCOVRcjF6sT2H2vlsy9ttxzmJHLTARf2TDIlyxqs4WElDV9Phx6sMWluF8kqgQsMYKoddMuIM4G1tZrrXJwe/fjpMAwu+Vt8ptgY/Ji5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398670; c=relaxed/simple;
	bh=tbjCTY8Kq8k5fwwjHXBcf2N2UrtZkaUEX5+nE0YZN4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S9tFH33+05QzJhwtq+R96uEIXsxI53F81/x3Z9n3sBbYQfITZcSE+f3tgwrKHSmljTOZkFbWeHvrWOBs97ZaIp9uuj8C66aFvooNIZnEv82BsNKS33ix2IQskYia61hJvLXV0i2JwstT81cVv+hcHNV7htIo8uviW1oHi9ajRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeVSuJkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E90C4CECD;
	Tue, 12 Nov 2024 08:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731398670;
	bh=tbjCTY8Kq8k5fwwjHXBcf2N2UrtZkaUEX5+nE0YZN4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YeVSuJkSBR5zPDteRZCrvmoPiTgIUkJFUsDj8oscIa3kdzrV3cJfCINaX7o8xogUz
	 eK95JFCPfrvnqU0W7xSWRMXliBxQ5nCEGm2at7iPukyHbJaD1khmQB7iZkt2rjk17+
	 4I2eieUClHIKNwzOc/g/A5IDBM1v4ulrWK+MfFSDFhYG7DUcktUCPho5JhMRRnzDbo
	 8pqr6rBmdnfAsfI1PkZk2/MlxwYhXZ3rrKqcpSiamGxsgjeUrethE17byHy1J4BPgg
	 erj5PbMuprHZmb3hHX3lfBCWcspccA3saEaiY0Noclimo0T9UrZCbiDpOwZTsF7r0d
	 ga84jVfSmsRIA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
 michael.chan@broadcom.com, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1730882676-24434-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730882676-24434-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-next v2 0/3] bnxt: Enhance the resource
 distribution for RoCE VFs
Message-Id: <173139866617.84226.11533636606364356309.b4-ty@kernel.org>
Date: Tue, 12 Nov 2024 03:04:26 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 06 Nov 2024 00:44:33 -0800, Selvin Xavier wrote:
> Implements the mechanism to distribute the RoCE VF resource
> based on the active VFs. If the firmware support the feature,
> NIC driver will distribute the resources for Active VFs. For
> older Firmware, RoCE driver will continue to distribute the
> resources across the total number of VFs.
> 
> Please review and apply.
> 
> [...]

Applied, thanks!

[1/3] bnxt_en: Add support for RoCE sriov configuration
      https://git.kernel.org/rdma/rdma/c/53371c5c218f9f
[2/3] RDMA/bnxt_re: Enhance RoCE SRIOV resource configuration design
      https://git.kernel.org/rdma/rdma/c/304cc83807da5f
[3/3] RDMA/bnxt_re: Add set_func_resources support for P5/P7 adapters
      https://git.kernel.org/rdma/rdma/c/cdb21c12adcb9e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


