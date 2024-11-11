Return-Path: <netdev+bounces-143816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431BC9C44EE
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071CF282ED6
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C31A76CC;
	Mon, 11 Nov 2024 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELgN/aFj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7B450EE
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349594; cv=none; b=cD4d45OVnSXNgdakIQE+N2tjAf6UhBSwYbkb3vOG5GNx5yHb4fCKrrGM2x9IVdVlawPLa01jke08mSEvjC0tGgpNO8z/m+O9U/u+G/7ivkEImN1zsxLEVJ+4VVKU+ZFr7lOPzVxi6ooMwqjzicG6BUET4TFPgwlf5pSSnIUeMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349594; c=relaxed/simple;
	bh=2esEkTYbaeUSMu1I1XrSolC2HxaIWeevrpZIL+k3gs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCPCsi8HnjtYtFr5XOMpSk8Aj6E5o4FVkq4vSxPsTIOjtSJzVJrKo0EZcE2ljc2ZT9U6fcPIZjgOTvSCLWow5uUkCFOfwtEtXgv+oroKiQh2aF70cmacGjKYrEAADKEuoNMRPvXrvxloQmakZaZlBIjL4PuoI4mVZbdBNcZKKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELgN/aFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75712C4CECF;
	Mon, 11 Nov 2024 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731349593;
	bh=2esEkTYbaeUSMu1I1XrSolC2HxaIWeevrpZIL+k3gs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ELgN/aFjdNCcaBdxvKIYwUQvPB9OclC/MQgA/10F+Y6G2ILuCyzq/cEfYxmFqIEAA
	 Swf7WPlntUn49lxANFPrF6ViqeMcpu4V0kkBPkpUODUoAiE8HEd5an2+uT2+jjfDVg
	 x0sr/LLlrY37wNLz7KeJ5eImNPbxGr+vyLFaewU35waUtXLinOiBd4J4mWi+JAiR2m
	 3ds7n3gID+ZJwByROAftLevMBFGgWQuowj3U36u0US6GUuXsm7W2LBSOKukQuwkCI1
	 1oTgISN2ue0xJQ5TctTjDwXa3/ooGq+WnH/uUl1pPsv3FvYoJP9p6HJvht/C5/LAy2
	 F19BjJZ7XM6Og==
Date: Mon, 11 Nov 2024 10:26:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, alexandre.ferrieux@orange.com, Linux Kernel Network
 Developers <netdev@vger.kernel.org>
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic
 failure to free IDR entries for hnodes.
Message-ID: <20241111102632.74573faa@kernel.org>
In-Reply-To: <CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
	<CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Nov 2024 07:50:53 -0500 Jamal Hadi Salim wrote:
> Please split the test into a separate patch targeting net-next.

Separate patch - okay, but why are you asking people to send the tests
to net-next? These sort of requests lead people to try to run
linux-next tests on stable trees.

