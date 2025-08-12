Return-Path: <netdev+bounces-213087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17AB239C4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 22:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6147B9E3E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE32F066D;
	Tue, 12 Aug 2025 20:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587F2F066C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029282; cv=none; b=IgryU1US+IqOwpYSKpeDBi1P6LVWaYNFJslGcj+HKLcSJzH0skfmqUv4bg28Bq3+4nEcJAr7yFXkeo9efL2yUlDq71xs5+7UnsPWJnz8Wo8Yb2EEy12D3yI/Hv5O4o6YHMVGzljXgCmZH+2Vbwc5Wo2wQbUgnEuB9mrrJy0fKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029282; c=relaxed/simple;
	bh=OUVabgjpO1ZeNGQh4Xp6WmUmmLzr2oSOX5UK3q1EWZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVoRPbmKqA7Nonp5Eb9Dt5n3X1qLnQozuUsesMnuTqbWy5sdRzTkuEjYNGC0+S4urVvYs83xtf8XvxMDqgdOWTprzHtptPa21B2B/tQcxOEj122dYwbzGv3BPeXn1Q3ZqcGhkNZY2D1WK0QDCQ/NJBWBVAo/dSciF33CNxzFoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5dc555db.dip0.t-ipconnect.de [93.197.85.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EFCF561E647BA;
	Tue, 12 Aug 2025 22:07:40 +0200 (CEST)
Message-ID: <edbc1372-b063-4294-b045-72752adf37b3@molgen.mpg.de>
Date: Tue, 12 Aug 2025 22:07:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 02/12] ice: split queue stuff out of
 ice_virtchnl.c - p2
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
 <20250812132910.99626-3-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250812132910.99626-3-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Przemek,


Thank you for your patch.

Am 12.08.25 um 15:29 schrieb Przemek Kitszel:
> Add copy of ice_virtchnl.c under the original name/location.

Why not mention the rename in the summary/title instead of p2?

> Now both ice_virtchnl.c and ice_virtchnl_queues.c have the same content,
> and only the former of the two in use.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/Makefile       |    2 +-
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c | 4611 +++++++++++++++++
>   2 files changed, 4612 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl.c

[…]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

