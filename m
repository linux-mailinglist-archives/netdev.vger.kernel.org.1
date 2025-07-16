Return-Path: <netdev+bounces-207341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935AB06B13
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964AF7A07E6
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562C0214A64;
	Wed, 16 Jul 2025 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR0RkNb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E22E3700
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629026; cv=none; b=urqBKegzWwnwsxedx7esGb9stfFMFD6p6cJ6yfUf+qFucZSBSqku236QymBVn3yAaM7CUBhIbrJAC8YawmiOpgv/WjH0hRs8y5aLv29h95IlyPGGa758vzokgetlA1OUqeJu+Pm7fIoams7js34XAJQS+SnFQjxSWzhqfkf63u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629026; c=relaxed/simple;
	bh=mf6cj0BLrm7eZitt30vEb4VwYozeCa3hH+jXJPss3G8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGfyUhLWtwCUbdv26CdT/lb86E/pHEo4EpwoahMphNIoDiKwBqUPtndnJmNGubmhllgxvmA5GwMlUyzDjTU8njpYuSJg0RID9s+p+XnkDFiq8oeXRLMaeE0bDt/LRFNgWfnOVz6chZAdc/tnpfF9Zh1aKO95S+rRYX+fNVoiWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR0RkNb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E55AC4CEE3;
	Wed, 16 Jul 2025 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752629024;
	bh=mf6cj0BLrm7eZitt30vEb4VwYozeCa3hH+jXJPss3G8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FR0RkNb4zf7OVXRDmDYXV5Or+B0kNcozh/SM1yg23cVkdaPcB7UMDF6LOjf9iQpPu
	 gib+Vm3xNwtHg0s5O2TEwrvlLlMm5y3xgENguf9UUyNTLX6W8LAZ0TZk37cgCQh9MJ
	 hCJas8/Be2vIdS4SzEj+9/cUCKwcEi+ivU8SyyvcHebJyy22pfn1maGIKX3Z4sA2lK
	 wMkcoDUo1Yrrrowk6W1gagBS2C9bRv1NVcumQfxQRJz/U4ch0AHpvyeAf7r7XUrQJC
	 J5+q0Vu4fTbR6cVR+LU7GGcKfSrM3Ilr8iyqJVSVT6uwZ4DH9e8AV2ApJi2UMm33HX
	 dr1jd3LBduPkw==
Date: Tue, 15 Jul 2025 18:23:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 03/15] neighbour: Allocate skb in
 neigh_get().
Message-ID: <20250715182343.5ed6f8fc@kernel.org>
In-Reply-To: <20250712203515.4099110-4-kuniyu@google.com>
References: <20250712203515.4099110-1-kuniyu@google.com>
	<20250712203515.4099110-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 20:34:12 +0000 Kuniyuki Iwashima wrote:
> +			err = -ENOENT;
> +			goto err;

nit: maybe name the label ? err_free_skb ?

