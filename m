Return-Path: <netdev+bounces-106946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639F9183C5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B2B1C20CE5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D64185083;
	Wed, 26 Jun 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+s/IILI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307A155A26
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411528; cv=none; b=UfInxqWU0+KG5+eZsAaFh5jNI+Tvd2B9LDQqrhJxZMNXwYce9qI5EuBSFb0Vxf+1ssnph7+qK1o6Db4QW9R4EibGjrI9zjkjKX/CS9VJ0LjXAdIEhzq018hOL2z+NJXQYPCYviOoNkbVMavmp1o1JTZl7fD/Usj2qqkq2KFmw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411528; c=relaxed/simple;
	bh=YApogd4YS34PgBT4Ut2wx0iv+FEJLxdYFEBg+FtnC7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zi+R0sai4k3hi/IMBGBJ/en1yM7KYyBfXq5okz6VjKEYAaAE4gD4yFOZg+FPSg0nWyHAjfP35sg32I5eNWA02i/cpai4ac8c0gUtoF9UNskjsDbECTRhVJgVi5s9D6mdIiJVP0cm4ETgQGmKNsKBQ3ivNaanGDkfjPyc0Uf6LcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+s/IILI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1382C116B1;
	Wed, 26 Jun 2024 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719411528;
	bh=YApogd4YS34PgBT4Ut2wx0iv+FEJLxdYFEBg+FtnC7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+s/IILIQ48zWaM2oO84pdtlW9kkdUejcY56vkFjhl9Ym5dF72AXEnhlMdkCyaywk
	 AKUQ0Tv4+d08okiv2Z1W/SKCnVhIfIVyhnGtktv3lBud78T3WZ3W2FnwiQAm5KM4Y+
	 mslj3ZLntaJUdXj0deItT7z/aGbdVMbnpgrs/1Fe9wSNXb2dOHuUeG82GWhwxfDEFE
	 fMq9Ecjm8D6Tm5wa1Ph/T8cRAF31vLLs6gQ+Lld32fhReu/kzySOdpUFk/FdcoR1mx
	 KOo2pwQdXEKVXx9oe8iNKBKoei5ST5+B4YSP5ZU2UNLDNpMJPAl6kIhS8vt1QG8lX2
	 njAGwq2IdIgPg==
Date: Wed, 26 Jun 2024 07:18:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH v2 12/15] eth: fbnic: Add basic Tx handling
Message-ID: <20240626071846.447fa4fa@kernel.org>
In-Reply-To: <171932618195.3072535.9492312390279973200.stgit@ahduyck-xeon-server.home.arpa>
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
	<171932618195.3072535.9492312390279973200.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 07:36:21 -0700 Alexander Duyck wrote:
> +static inline unsigned int fbnic_desc_used(struct fbnic_ring *ring)
> +{
> +	return (ring->tail - ring->head) & ring->size_mask;
> +}

clang says this is not used until the next patch
-- 
pw-bot: cr

