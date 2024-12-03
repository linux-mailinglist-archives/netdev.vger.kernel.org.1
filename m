Return-Path: <netdev+bounces-148324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E49E11F6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A78282597
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26331166F29;
	Tue,  3 Dec 2024 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWq9VWfK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C63F9D2;
	Tue,  3 Dec 2024 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197377; cv=none; b=nMms3LQZOQVZxMO1eh4d1QZo4H/7lyJNVdaXPWDstPVYIFOnIuRo05/PRNixB1WzwqKVWIDqieXPoqgUrXDLkglYfpscqyAMBWqIwGPhj97w/0SFDhQVUG9GdcGq/UNkNB9gjRnOiqlgyCnj/dYrPsxobjNuaPS0JxkSb6OZRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197377; c=relaxed/simple;
	bh=K7vuE+c/X135ZutY7JE6Hl6CxFQPpuUd1zraxJeqJSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+cGQN7WxLGuYmG9gDqjbMXZObRwdvXU8EM1MrzyxFLtCm1XayP37LApldqKFWiWku1Rh4Ur12GodA60SbQYNE1kgAqzGFZpkXrrYljG7+Gjlkarbz6HVpDW4aA2hUAqrH04NnU/UucVQnL8PWXiLaTiCkm8JK08oM52EN1Cofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWq9VWfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBE2C4CECF;
	Tue,  3 Dec 2024 03:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733197376;
	bh=K7vuE+c/X135ZutY7JE6Hl6CxFQPpuUd1zraxJeqJSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AWq9VWfKXjydHjXbP2S76q1ULK9HLFXzpR8ggTK+HzwGsHwWQeF+/maqWeigSD5l6
	 ogxHqdBEYABXAFjAN9hBRm5DSp2ZRvGFaa+Fk3EHKtdC30Mf4Mz/iAaaFqZv1LZmBV
	 U+gkrttDSGa0HNTOngINE0LqCk+vtMHGYqGngjfn4D1Y6ozQa/45OYEZYYSj6wYO2q
	 FPe8jXEiGWwWLp16ZO3ZHwzjGUlmGKg+2rLxENO4fpNn796przS0awXDQUybblq69t
	 cE/K/lTnWTWj0PeIAIJc8Z2tr8hnmzt2SP2X1veY9UOGA1CxWd+/WqcgCV4tlHxI7A
	 ROqWmyL5snUFQ==
Date: Mon, 2 Dec 2024 19:42:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/37] rxrpc: Don't set the MORE-PACKETS rxrpc
 wire header flag
Message-ID: <20241202194254.2c02511c@kernel.org>
In-Reply-To: <20241202143057.378147-5-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
	<20241202143057.378147-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Dec 2024 14:30:22 +0000 David Howells wrote:
> The MORE-PACKETS rxrpc header flag hasn't actually been looked at by
> anything since 1988 and not all implementations generate it.
> 
> Change rxrpc so that it doesn't set MORE-PACKETS at all rather than setting
> it inconsistently.
> 
> cc: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org

missing SOB
-- 
pw-bot: cr

