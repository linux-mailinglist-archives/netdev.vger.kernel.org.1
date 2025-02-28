Return-Path: <netdev+bounces-170726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22139A49BCB
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562BD3A8606
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02E254861;
	Fri, 28 Feb 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5fC7F9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B678BE7;
	Fri, 28 Feb 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752538; cv=none; b=IbAt1EaCeyle17vcWto9C4hXcPeveqHJ+a5wNOl69Xo4CLv6Hh2pKXl4NKh5GDg3B82djTWSXi/C3q6p4MZ/JdHRHFFiM2+Mrc9g3Zf3TjEHvKhNS6kDIg/Q9McUnfwDEj8lM944CU03ILTxD5vEcV44l9LlGlNSzbjJmNuH6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752538; c=relaxed/simple;
	bh=TCbaia+FH/NlwMBsYQ9DCgKt0TkP3HMdynGCxInYhtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKZx6wosU7UvYhgK3WZ3m8aZF0QBgfGbHyXTXZilE9/1Egc0OOWuHP6U5DU0e30YS9uaudNBwAQnku1Lz96XYzZH7zXl8i2sVh5EvQCNabez8Jf5sU9tk8RZUaH2eXgaIhjbvDAf/wm7A1KKqNengaRrRlk3At6u9g8O+c6YuSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5fC7F9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD64C4CED6;
	Fri, 28 Feb 2025 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740752537;
	bh=TCbaia+FH/NlwMBsYQ9DCgKt0TkP3HMdynGCxInYhtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I5fC7F9N7DOGEzdQ/HVF/xYaQZ2UdKdmhXsboYY0mFV7x4Kb+bGJkn6Cn+Vr6nQbC
	 fUHd2qHzY4kdpIYEUOgWfCaqFTBiQO7Es0HahJMUcEYOZXofcMM1CPDxUga0Nju2yp
	 q7E3M8HE/cMBPMbkbwPH5nqcXdlZc6Da2peXRQQPKRw7WarxUpox4gacDHLN7Cdb/x
	 6heXcLfw0zCWMiy7jhvRhIyuCc6ef+9WR16Eu3Nkcs5KfdQEZJhLT9ilH5ktYSciNz
	 wUQ1KCmfTz1Riv3a8vhHt8QDF9wo612G9yEThjq8OrgbEjjMKjrBxsqlP5jPO2mIbA
	 jWcLg1FjHODiA==
Date: Fri, 28 Feb 2025 06:22:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Marc Dionne
 <marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-afs@lists.infradead.org, linux-fsdevel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] afs, rxrpc: Clean up refcounting on afs_cell and
 afs_server records
Message-ID: <20250228062216.77e34415@kernel.org>
In-Reply-To: <3190716.1740733119@warthog.procyon.org.uk>
References: <3190716.1740733119@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 08:58:39 +0000 David Howells wrote:
> Could you pull this into the VFS tree onto a stable branch?  The patches
> were previously posted here as part of a longer series:
> 
>   https://lore.kernel.org/r/20250224234154.2014840-1-dhowells@redhat.com/
> 
> The first five patches are fixes that have gone through the net tree to
> Linus and hence this patchset is based on the latest merge by Linus and
> I've dropped those from my branch.

FWIW:

fs/afs/cell.c:203:5-22: WARNING: Unsigned expression compared with zero: cell -> dynroot_ino < 0
-- 
pw-bot: nap

