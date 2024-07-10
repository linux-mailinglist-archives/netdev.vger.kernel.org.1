Return-Path: <netdev+bounces-110464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B766392C82A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C431C22079
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35A66FBF;
	Wed, 10 Jul 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIN2HJC4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC15B660
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576729; cv=none; b=IRm2KmVS8GHlI1tgnCvmyDkfxNhrT49FcnEOsVkK6JzpFuzP0T3otWxgRDcoQlYFnpTF92AYHSo1BqZgi0RBGPmfCA6csFVoHvDKlO0K8Ef+OVdG/5y4V6LSZle9wmkI+QXRVnezcY4bQvbrSGAM1NDDmNqcn253r9uRCQrQxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576729; c=relaxed/simple;
	bh=3tNPM5VQKRyAzfZV4Eo973br6f+kSN9e8szuzcQACs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfucUCBzfm9yhwoJWj/fK2YptAr7z5/1nvQe/VBr89WtzuMxAPf2dDhpT/p3/DjKcFo51xF1Il0vy0Rt0dg4WxW0jvI50nm0asTFjS9H0AqBrXPo0N+9gUIIrwkVkOOc0Bpz+HU4HOjXBnvhUrbNYv24bUOP1/AzmKIQCHRC/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIN2HJC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C18EC3277B;
	Wed, 10 Jul 2024 01:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720576729;
	bh=3tNPM5VQKRyAzfZV4Eo973br6f+kSN9e8szuzcQACs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIN2HJC4sY4ho9FmXCRATEcIOhbx4rbHUOnfNRoYU1WaJvdu8c2cbyIrN23LEzjnZ
	 8h/9sZii0DTLXHSzSmpHbSvqax/fZLFOZ8Hi2/rJMqIH8Xp9DKaiggJqmtZIXJsNwA
	 p1yd/l1sIZuwi58I/WJ8rxcV7yONR+SRrBRP1PTlNtHbEh3W5C/LkO+ZhJw0W+1ADV
	 5/N05Tq4brO1+rRY4k9FV0VGBJBiZvjUyyTmo15meoiamwJP/HkoLJnLnoGeCEUjBG
	 Ggex7PbK0mPvi/ng1jfZ3EU2iV+doRRNI+AnYpHtz41zwsqZ9HoQE5+Dp4rxGeNliV
	 QwBQpjsNF5W7Q==
Date: Tue, 9 Jul 2024 18:58:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next V2 07/10] net/mlx5: Implement PTM cross
 timestamping support
Message-ID: <20240709185847.41c15b60@kernel.org>
In-Reply-To: <20240708080025.1593555-8-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
	<20240708080025.1593555-8-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 11:00:22 +0300 Tariq Toukan wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Expose Precision Time Measurement support through related PTP ioctl.

Please repost the PTM patches separately and CC the timing, pci and x86
people. Looks fairly reasonable, but IDK what the latest is on cross
timestamping.

