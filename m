Return-Path: <netdev+bounces-116531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CC594ABBF
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BD4283249
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD75823A9;
	Wed,  7 Aug 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu6gBJYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BB81751
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043319; cv=none; b=lgULBLwzt+056rRaScvgKhKIMYgWLYHnEANXH2ZKcb54gWyfLPJIyxKr7yg1/wuUaGfHaqktGrd3Ns+Q6y95zB+T8/JrgilKO2FdrO0kQxZodf1nYHfEVZW52Vv+5ZZFhd0+wTXeNm8/CZ/2UpBLsxLQqZvCAtPTR6O9toPx0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043319; c=relaxed/simple;
	bh=DUp0Ih5+z3asTkjuClXwUv9D+k4Zb3O5J2RpJLqenV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/3QDOBFIXZ6qD7B73EOHB3YCXwhx+7fWkpbuQnbpaG0q6eEcR7z+mWf0/YzFtsLT+Nvb2r76ITzBzLU6N0SWXqyK/66VMXBjvnGPP/voFsnkuxA/vJKjWmhKIkiinTsZvObNo2Zca2gRNQMFsdeLPOAiDGb+ZQVuTCt03Ko9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu6gBJYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19F2C32781;
	Wed,  7 Aug 2024 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723043318;
	bh=DUp0Ih5+z3asTkjuClXwUv9D+k4Zb3O5J2RpJLqenV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bu6gBJYpR4F91ENloZ7//MNfo6ycIHdi6EskYRzLC4IHAwDjEVyCMBIkUKidPHM3q
	 kX/Ww1GIYShV7Q932bREhaL+CbZ99rgWDBu9P5LW0r0FeTwCYPt/DT0Uky6qkzq8Pp
	 ZUPNPA798dtVr9kyTsih++JED4N9AH+Pt1wJlGYmfkUBoTSW0zCH/eeATM2GDDh8XD
	 sWUWtS0zOhvqBwmCIG0NsYRfMeehVNmhNm82dUsc2FFiMcQS89yL1tE48J5+L7ERy2
	 12VZOOd+DnC+xfiJesxP8jjPRUI+K7DtrOx8wRvwaa9Hh2dGWTcOaAONrBLAMRoBz5
	 x+OS3CyFw16ww==
Date: Wed, 7 Aug 2024 08:08:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
 ricklind@us.ibm.com
Subject: Re: [PATCH net-next v2 7/7] ibmvnic: Perform tx CSO during send
 scrq direct
Message-ID: <20240807080838.289900bd@kernel.org>
In-Reply-To: <20240806193706.998148-8-nnac123@linux.ibm.com>
References: <20240806193706.998148-1-nnac123@linux.ibm.com>
	<20240806193706.998148-8-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Aug 2024 14:37:06 -0500 Nick Child wrote:
> 1. NIC does checksum w headers, safely use send_subcrq_indirect:
>   - Packet rate: 631k txs
>   - Trace data:
>     ibmvnic_xmit = 44344685.87 us / 6234576 hits = AVG 7.11 us
>     ibmvnic_tx_scrq_flush = 33040649.69 us / 5638441 hits = AVG 5.86 us
>     send_subcrq_indirect = 37438922.24 us / 6030859 hits = AVG 6.21 us
>     skb_checksum_help = 4.07 us / 2 hits = AVG 2.04 us
>      ^ Notice hits, tracing this just for reassurance
> 
> 2. NIC does checksum w/o headers, dangerously use send_subcrq_direct:
>   - Packet rate: 831k txs
>   - Trace data:
>     ibmvnic_xmit = 48940092.29 us / 8187630 hits = AVG 5.98 us
>     ibmvnic_tx_scrq_flush = 31141879.57 us / 7948960 hits = AVG 3.92 us
>     send_subcrq_indirect = 8412506.03 us / 728781 hits = AVG 11.54
>      ^ notice hits is much lower
>     skb_checksum_help = 2.03 us / 1 hits = AVG 2.03
> 
> 3. driver does checksum, safely use send_subcrq_direct (THIS PATCH):
>   - Packet rate: 829k txs
>   - Trace data:
>     ibmvnic_xmit = 56696077.63 us / 8066168 hits = AVG 7.03 us
>     ibmvnic_tx_scrq_flush = 30219545.55 us / 7782409 hits = AVG 3.88 us
>     send_subcrq_indirect = 8638326.44 us / 763693 hits = AVG 11.31 us
>     skb_checksum_help = 8587456.16 us / 7526072 hits = AVG 1.14 us

Thanks for the numbers!

I presume the numbers are inclusive of all callees? It may be worth
while making ibmvnic_xmit more prominent, maybe indent the rest?
My first instinct was to add the AVGs in my head, and because of
different hit counts that's rather misguided.

