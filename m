Return-Path: <netdev+bounces-235693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81731C33C75
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 03:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 537064EFBDB
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B44A17C220;
	Wed,  5 Nov 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f52iJApX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662629463
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309921; cv=none; b=H5vdevy1aL6GbjWPd8bsE1ou+QWtFFJQPRElBVAorQscElz+Q5uqQ6YQSZFGIlQi3gk2bwdJebV5mDYLlx8IYrSNw6oPjS5O3LNxM8NUElIi8ndI8xdoVfmKcRp7zHm5UnE3s0hgHd862Uqc8blIEE2tDgZEKwsRtCf5Hr/cpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309921; c=relaxed/simple;
	bh=N66lmHQ41ZDXetSBgvIvh3usb9oXxS7iym9uIs0RMFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pU+Q801+AmADRE6l8GZYSAINvAVAJ6snyS/AhCg42uR5UKoh6+yAOXa9HoqL7is1w5hiKmUYMouaaQEW3xNDzLPtD4GG4shOJkN3TSVpONkBNnX52LQq60XkYS3oK4oha+g76B9YhVRGfOcDJX2J4IE+7H/yzpxDSmcww5LGWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f52iJApX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7009C4CEF7;
	Wed,  5 Nov 2025 02:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762309921;
	bh=N66lmHQ41ZDXetSBgvIvh3usb9oXxS7iym9uIs0RMFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f52iJApXniSnJG23KU5Oz+PgjvuiRtr+krHr/tt3GTouhQj548TRkgfRflFebtszu
	 LhNWS9yekrzDAqRuxdjntOyeR560iDOI/X5MAMpjNO38HOiB+dXiDlWelGWfWIHRkd
	 5ObftU5iDrmvL1Z/i6zUGpEJbigiNjVMUZaxTvQlXHmZ/rXIg/MC+oJpqN34AVgG+A
	 p8pOtPmfsGzFHOhSrB4pAADf5Qmc2ZSBvph1JnaWxj+eDQEP+EpJRG04ZezurbfCpA
	 k8oiKnnpqT6/19f/KpfKt35hnV1J/JQwk3UNisk/lkaVXxCdTdUhYA/XPagWtYOkLG
	 rj7T4yKvb//QQ==
Date: Tue, 4 Nov 2025 18:32:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: airoha: Reorganize airoha_queue
 struct
Message-ID: <20251104183200.41b4b853@kernel.org>
In-Reply-To: <20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
	<20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Nov 2025 11:27:56 +0100 Lorenzo Bianconi wrote:
> Do not allocate memory for rx-only fields for hw tx queues and for tx-only
> fields for hw rx queues.

Could you share more details (pahole)
Given that napi_struct is in the same struct, 20B is probably not going
to make much difference?

