Return-Path: <netdev+bounces-83882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04169894AAC
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F031C2216A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4900A17C6D;
	Tue,  2 Apr 2024 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3IBmQpm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BB17BBE
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033629; cv=none; b=LkZ/jUDM5hJG90c4zSXDVhsnGWng86oKbVMO9TBZncTIkUUii6HitGpkvPl0s67/iap+fCXVEbZ1OWP9Fs5CE9bOLjI52W9u2bUeMmtv5kQ6QMMZogWVIz35vO/0yoH/TnnChdD3m4yerD6GD4Oo4iqDwKx9Jopd8D/2OBGjEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033629; c=relaxed/simple;
	bh=+PeFQ0pHHjyE8xUPMlec0rllsDBswD8q9iVXdS6tk1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9+phRK387Qkuv4pQSqye2Mc99Go25onuDUMYbMtN4WnU5JFrXzp3LehOjYmE6OE1OGQ6rJnadjGs2eO2QS1XXNSeUZhM+kt1sTSa0L7ENwYV2R4DXEKvkEwk2zPKVT+HWn9dxA/q5YJU+O5WPA+z2k8H+2JfncqkAtuXezY1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3IBmQpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19794C433F1;
	Tue,  2 Apr 2024 04:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033628;
	bh=+PeFQ0pHHjyE8xUPMlec0rllsDBswD8q9iVXdS6tk1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y3IBmQpm+2DwRn3xHvbN8Y2Qd+9bydxf5x2XolD1dXkv7MksrGmbcQiA+hGPFNEfh
	 rhwXMMHBNp7MSQyJyhz8HmSiWRxGcXlaJABPbMJTHPvlr3h7HqkKtQ4gxvHEgiAb/A
	 aDhTCpgYY6E1fJJ1O8A68zJwr/XQiiP1Mcq5otn4/1VY4s3VbC5h0zQznlyVv/ezTn
	 8p4ZfcFlYUjKZKd5oIOoLKk81KM9MTxjVMC/gsZf5spsRKQLmmORvGBGJWCoOq19t3
	 ov+xzP8u4EiJ0ryFFdOHcXf1ygo5/rjUob9qnQ4t/ejsmMpVPeVweVbyI3GaSVELm0
	 907Sp6208KhLw==
Date: Mon, 1 Apr 2024 21:53:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 gospo@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com, Somnath
 Kotur <somnath.kotur@broadcom.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next 5/7] bnxt_en: Add XDP Metadata support
Message-ID: <20240401215347.18dc2cd3@kernel.org>
In-Reply-To: <20240401035730.306790-6-pavan.chebbi@broadcom.com>
References: <20240401035730.306790-1-pavan.chebbi@broadcom.com>
	<20240401035730.306790-6-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Mar 2024 20:57:28 -0700 Pavan Chebbi wrote:
> +static inline struct sk_buff *bnxt_copy_skb(struct bnxt_napi *bnapi, u8 *data,
> +					    unsigned int len,
> +					    dma_addr_t mapping)
> +{
> +	return bnxt_copy_data(bnapi, data, len, mapping);
> +}
> +
> +static inline struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,

No inlines in C sources unless you have measured perf difference

