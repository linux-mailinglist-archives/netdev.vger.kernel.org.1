Return-Path: <netdev+bounces-74222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540ED860871
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 02:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A421C21F7B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 01:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5553B641;
	Fri, 23 Feb 2024 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFM7xF/J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C518BF3
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652648; cv=none; b=Np5EsaByiSOIa5Z8vh/P/r3MF+oifI0hQnSEy/qLql2d5cAsKmBSzAKF4D6LXd4SsJeDhyCMK+t6vaILKV/gS7J1qNo6m87HljNKaZzOExMLFw+QYm7h6IOw4wC8TWqp2pnvZmjXlHf+4rS7QrKrZ7rEQ9m8Kg22xZeoUFmdoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652648; c=relaxed/simple;
	bh=CC8AyI6GfWrPXof+A9oFujmN88ev3sQidLKvz7uYVg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XE9o2oaZpAq+j9N9oy/GT/S1vcnIPZWVA2HpQATJZiEp5K87hrdy3kdflpmTthFsTe8jYHYuvHtwtrbFXGToR8XFiqfQrKaXJGmc76Un0qXZ9kUczIzr9HRIyReHMcx3VkCrrcsgFpWqQ09N01u3PgrrM/rwLASyIMZ2lNfWYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFM7xF/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22EFC433C7;
	Fri, 23 Feb 2024 01:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708652648;
	bh=CC8AyI6GfWrPXof+A9oFujmN88ev3sQidLKvz7uYVg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VFM7xF/JeOwVcjW3I63gfsxRZSPa9BvPgZUKGChD4JP9S3FCq/uA6HfvzS2iLmnVy
	 sNQ7r8wdxcEt/Ags/F3wReblpZQudbsYFG/AM7Q5vx+Sv3rp7EZLmN3d35/TU8FuMJ
	 zUB0HvP16zK2KJXueRgzq8m6lkvhwQvoZ1dZC4XQdF/sAEvouF6QdlpQOCxkA0BYyq
	 zOk2MpHbLlppfVBDhSK7YKgTpO03eiK3WmfSB+4lkxGdpCApOzNwU7JTe4cYTyuzDx
	 sMzL0HH1pPkuxd4LE6mMkquf/MoYqkWsmL/E8JXNtLFpzl/wMN8A/yRq2ObF3TNTgq
	 M2RKXjK41jeQg==
Date: Thu, 22 Feb 2024 17:44:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <danielj@nvidia.com>, <mst@redhat.com>,
 <michael.chan@broadcom.com>
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
Message-ID: <20240222174407.5949cf90@kernel.org>
In-Reply-To: <e6699bcd-e550-4282-85b4-ecf030ccdc2e@intel.com>
References: <20240222223629.158254-1-kuba@kernel.org>
	<20240222223629.158254-2-kuba@kernel.org>
	<e6699bcd-e550-4282-85b4-ecf030ccdc2e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 16:29:08 -0800 Nambiar, Amritha wrote:
> Thanks, this almost has all the bits to also lookup stats for a single 
> queue with --do stats-get with a queue id and type.

We could without the projection. The projection (BTW not a great name,
couldn't come up with a better one.. split? dis-aggregation? view?
un-grouping?) "splits" a single object (netdev stats) across components
(queues). I was wondering if at some point we may add another
projection, splitting a queue. And then a queue+id+projection would
actually have to return multiple objects. So maybe it's more consistent
to just not support do at all for this op, and only support dump?

We can support filtered dump on ifindex + queue id + type, and expect
it to return one object for now.

Not 100% sure so I went with the "keep it simple, we can add more later"
approach.

