Return-Path: <netdev+bounces-215428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F625B2EA54
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9623B98EB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1B71E98E6;
	Thu, 21 Aug 2025 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmcfr7e8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449A36CE02;
	Thu, 21 Aug 2025 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738971; cv=none; b=QjalFCCCqINwU8nTKnjb4nXhBjkbFTof1U+cutLZA0VT6D29hMGs+tPW/hrIfn9uUz0KfYxlkax1cdFqV6FribdOv6UR13PWZkVUjCOvE0cDRSUui8+2i+zFVG+7hJJU7OvTQXZPFKy7YNyeFN9N5Tfk0hpgczCHiapuTuc6BcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738971; c=relaxed/simple;
	bh=PkeRqvBIRGhspvX/sKPFj1tXO8ucfCKO6Wmq7H5bPh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+CAC3jTdVvkdB7ExTNcVYpIcEhMxjcZgAiUT6xRl7KEsrPMYezIbU9chRpHrf8dmNGVPbsOo3iAizfQW6fBNBYBRfug5QC7itfZEawbffGp/0U5YOeqU6CpTz+mm8xIhvJfhGk4H2zh2otbOmnAaM903XNVVy9DdC/Ls/Qy62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nmcfr7e8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D79C4CEE7;
	Thu, 21 Aug 2025 01:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738970;
	bh=PkeRqvBIRGhspvX/sKPFj1tXO8ucfCKO6Wmq7H5bPh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nmcfr7e8X94BeorS+PzjFVtzAk4dzIyD17E/Qv+R8sSC/1yD+csRH3Gp/LslhEVru
	 +1DUNhByODJR0TY0JV6L6PM0TjlPCGXT732+v8UsMCvsAQfaW2l6SuDTUCcI9JDpxC
	 ghRP4TcmNBnXaNwS4shi1GeSQMbKBiYR18YpYlPzKbZyLa/tLNCOd2tMJxMFZ/UlU/
	 +op5CUXaQ9vDFGJ7OYk/n32qbYlWw/axg65ThxXDH0EnL1X8jkEsBMX3RFqLiWmjPw
	 l/9tmz5aO3PsECQfmQv5j4+xBhO+FKSiMcZE3m/SyYkqAheKqKF2Lx8xuDBEzL1YeB
	 bsy2CrwgDt0YA==
Date: Wed, 20 Aug 2025 18:16:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <cratiu@nvidia.com>,
 <parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 7/7] net: devmem: allow binding on rx queues
 with same DMA devices
Message-ID: <20250820181609.616976d2@kernel.org>
In-Reply-To: <20250820171214.3597901-9-dtatulea@nvidia.com>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
	<20250820171214.3597901-9-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 20:11:58 +0300 Dragos Tatulea wrote:
> +static struct device *netdev_nl_get_dma_dev(struct net_device *netdev,
> +					    unsigned long *rxq_bitmap,
> +					    struct netlink_ext_ack *extack)

break after type if it's long and multi line:

static struct device *
netdev_nl_get_dma_dev(struct net_device *netdev, unsigned long *rxq_bitmap,
		      struct netlink_ext_ack *extack)

> +{
> +	struct device *dma_dev = NULL;
> +	u32 rxq_idx, prev_rxq_idx;
> +
> +	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
> +		struct device *rxq_dma_dev;
> +
> +		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx);
> +		/* Multi-PF netdev queues can belong to different DMA devoces.

typo: devoces

> +		 * Block this case.
> +		 */
> +		if (dma_dev && rxq_dma_dev != dma_dev) {
> +			NL_SET_ERR_MSG_FMT(extack, "Queue %u has a different dma device than queue %u",

s/dma/DMA/
I think we may want to bubble up the Multi-PF thing from the comment to
the user. This could be quite confusing to people. How about:

	"DMA device mismatch between queue %u and %u (multi-PF device?)"

