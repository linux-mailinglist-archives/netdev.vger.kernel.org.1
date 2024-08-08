Return-Path: <netdev+bounces-116776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8C094BAC4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2CD287FBE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F18188002;
	Thu,  8 Aug 2024 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGKYm0iM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820013AA31
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112515; cv=none; b=p4LRAyZjUqTCioeE7dAEzcAQfymXPVn1Eca3IezWkxmUfPiG4DYFS5iNH7WvpfRsvRn+T5LIazlJrXFXIg+nLUu4rIzCCb+DPETvd6UMilQXI2K6avQYNpKKZlpb6dC1Z0KrDIE7izWf1qZfSwgmXRbrkwLMFsqHmQv49ZSJ5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112515; c=relaxed/simple;
	bh=Dav8nNX/YM4XW3d8sDO6WGAlwNU+M07FVmKEuPLPMJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GrRQDzkTugu7/e2WvhBDX821uUzapW8X7mXUs2M6we5ELsYQjHFGBEYJBu5NfE2c5pWU5ERWagP3nubNer3a5vX9D1UJICBLVHNneqMp1jrWC2FL0VB/s4F9q4ufAuHrKiczrsjOh3vfvWQUd6zzZCONlF0EIvQGJxujVfxSo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGKYm0iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36136C32782;
	Thu,  8 Aug 2024 10:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723112515;
	bh=Dav8nNX/YM4XW3d8sDO6WGAlwNU+M07FVmKEuPLPMJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tGKYm0iMS8RJUfNVH8udT6H1ezc/dUABjMhZmv5qVoY4/mmvjAiqfJOZwlSUqbR1n
	 lTQdO4DHXolVE9Gi00pWp6PjsKE26DkCu0+YlNzG+JMjEYSuv8tGd9TMQ41atX79Hm
	 d+9wtEuGOCOaPACLo1oXZcqAYoidT14tNhGpuYpJZ/HP7PHpsphawKJuQIG6+1ANZr
	 sU2hNmXVNQP05t4coUFYrEGm5dr2IVf8cMUxsLP4X22ybPGvWNZB8qrkjprxnj/gUe
	 YQ6zMwt4RPu/YQnduvuLWnu5+XvjttGW/hD0KsMYrMEldtAutb2NLzIf1c49Z+/8TY
	 pccJbCwAoClPA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2C5CE14AD672; Thu, 08 Aug 2024 12:21:52 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Duan Jiong <djduanjiong@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
In-Reply-To: <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
References: <20240808070428.13643-1-djduanjiong@gmail.com>
 <87v80bpdv9.fsf@toke.dk>
 <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Aug 2024 12:21:52 +0200
Message-ID: <87mslnpb5r.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Duan Jiong <djduanjiong@gmail.com> writes:

> Now there are veth device pairs, one vethA on the host side and one
> vethB on the container side, when vethA sends data to vethB, at this
> time if vethB is configured with a smaller MTU then the data will be
> discarded, at this time there is no problem for the data to be
> received in my opinion, and I would like it to be so. When vethB sends
> data, the kernel stack is sharded according to the MTU of vethB.

Well, yes, if the MTU is too small, the packet will be dropped. That's
what the MTU setting is for :)

If you want to send bigger packets just, y'know, raise the MTU? What is
the reason you can't do that?

-Toke

