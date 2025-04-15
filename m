Return-Path: <netdev+bounces-182559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDDCA89187
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE33B08D8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF63819E99E;
	Tue, 15 Apr 2025 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuaiPW9r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9213EEA9
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681383; cv=none; b=r31n/0ziKPlLpCxY11T12qnn0yufo0HefZtuuAaF7u69XJ2L4xPCIjzuk5pjd6v8wN5oV1UTiuisOs8iqibaARDVEVoU4cITdtqiIweMrbwjId9xVOpVFls7ZDUi5PrkQW1Jy3f3zzDrY4Ee5LnOnYss0aMqRdHq1zXBBEFrQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681383; c=relaxed/simple;
	bh=sFoO7NUbRY4sLkGQ6T4mRaXxDo+g2GsDdvoHHT8JDtg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raeLpwFQSZbpLkGkJByIlkzu4NRe8TcHK62WZzqfl00QyiLJHv9z9uCfYG+TtyeeI3+fYvGjtELouhU9rUlH1OSR7LtI36nI/ryZec/3TGLKDiNxxXKo7G0AL3kKRyBC3xUujH5yezUiAt1MW9omexX9wrwGkB8rrsQ6MQeTTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuaiPW9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97509C4CEE2;
	Tue, 15 Apr 2025 01:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744681383;
	bh=sFoO7NUbRY4sLkGQ6T4mRaXxDo+g2GsDdvoHHT8JDtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RuaiPW9rPm6+TAUYlaiTc/N9amXNIZwIFqv8Z3f6PAZwxoIjlkiZAcObxVRzwJ4ly
	 DbfqdsuNAnb9rA8hmAvi3OhFLqmVUtM+xSzk2B0qjRtJgmHYpVuBUBGjK32l82pxj9
	 zOd58ION1C+JRNbBrzgdAONUgKTFKvyTNItdPmi6iTYT/lAI+zbmnzJ024Ax9bVdVw
	 TqpAGUQzPa6vKbetK/m5XIb/0l/cPy4G96243IkK8EP+d6XbSZnGnMCtffzjBOkZel
	 1Lb5zr9fzk0KiWmrlBXJihgJrJKx+kU5G9/TR6oOfa3xVi4HC8ItOTqmOSpSCWOlnY
	 tkHtjEzyQvJVQ==
Date: Mon, 14 Apr 2025 18:43:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>,
 <horms@kernel.org>, <parthiban.veerasooran@microchip.com>,
 <masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
 <geert+renesas@glider.be>, <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v10 13/14] xsc: Add eth reception data path
Message-ID: <20250414184301.7108c32b@kernel.org>
In-Reply-To: <20250411065326.2303550-14-tianx@yunsilicon.com>
References: <20250411065246.2303550-1-tianx@yunsilicon.com>
	<20250411065326.2303550-14-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 14:53:27 +0800 Xin Tian wrote:
> +	xsc_page_dma_unmap(rq, dma_info);
> +	page_pool_recycle_direct(rq->page_pool, dma_info->page);

Why not let page pool handle the DMA mapping? it's far more efficient
than local driver implementations.

