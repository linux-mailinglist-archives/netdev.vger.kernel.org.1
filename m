Return-Path: <netdev+bounces-170651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D7A49765
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F6918842CC
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0325F790;
	Fri, 28 Feb 2025 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/v+Amvc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277325F789;
	Fri, 28 Feb 2025 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738725; cv=none; b=ZAUQ1nPNEYeIXwlIhg4aSL84hPPEOHYR/JWwBjIclgfuCThwgecNk8waPnnPkX973eA9BSsTU1e63PpXHMf1ZAYMqHrG6+h4/XxfvhvYlnANKPkbiLYmMnnyps7w50IQzdwcoqwIWnPhbodhhNOJYpmyvQkmcn+eCnTiHnDLNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738725; c=relaxed/simple;
	bh=YV+Rz0nT05zsjBIIG2ncvX7T1edTVuc7s3cZPCIXE2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF8I3UryIJdVe918kb4cfJHnp5yZqrkny3g4bjyYovZySf9WU8/3+LrTGe4wXk7yQL3/yHtojvTf27quPd5EgcaocM6+An0UtlNgWWlVn+mxcZW20b2Sev3gp76c9C6lAIXcRs0KYYqQMUQy3ajhAGxGxn/p1BmoHsSSaVD0L4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/v+Amvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4E4C4CEED;
	Fri, 28 Feb 2025 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740738725;
	bh=YV+Rz0nT05zsjBIIG2ncvX7T1edTVuc7s3cZPCIXE2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/v+AmvcOgOUCGexFGwYBeu6jkR/m6VEG64na9kIEbaMFq2RbAesjtS5qJb11NBZK
	 nqglb19EGi9H73eFZRoeiijl3FRRDkIn3u1SyuD5XTr0yYngUafdaQKzEt72ieOn5m
	 l52jwXmyp4EcicCeydWfQnYpmFldPpYmCXyF0057sYUqpZUkTSNZGGsF3f6sAA7IH0
	 sx1+N4QKERtkofqlKT+nX/Bazs1c1BcYn3tZ/zd6xgI0/0LE6Yl2RfQXYLCbwgKKbF
	 tLICY+2RsW6oRFsToPZudoeMebzFDyxQG3cuts6RAvsyEbwW6K+bfZxJoWHxA4+6cT
	 9hCvQ5LSjG5Rg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Date: Fri, 28 Feb 2025 11:31:51 +0100
Message-ID: <20250228-unberechenbar-trauen-cef35cae8629@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <3190716.1740733119@warthog.procyon.org.uk>
References: <3190716.1740733119@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=brauner@kernel.org; h=from:subject:message-id; bh=YV+Rz0nT05zsjBIIG2ncvX7T1edTVuc7s3cZPCIXE2c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfnDDPbdeb7T2dwW0zbwicyPts+sGk9X/d9FMHJ4nOc eQXfNel01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR+TZGhn9H3lzhOKg+98rv 9+6NGz6WGiw/qrLfyebOK1327Ry24n0M/+vffizfk6LOErVgbqmUvriU/wv1dvPA/dMLL77zdp3 Kwg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Feb 2025 08:58:39 +0000, David Howells wrote:
> Could you pull this into the VFS tree onto a stable branch?  The patches
> were previously posted here as part of a longer series:
> 
>   https://lore.kernel.org/r/20250224234154.2014840-1-dhowells@redhat.com/
> 
> The first five patches are fixes that have gone through the net tree to
> Linus and hence this patchset is based on the latest merge by Linus and
> I've dropped those from my branch.
> 
> [...]

Pulled into the vfs-6.15.shared.afs branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.shared.afs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series or pull request allowing us to
drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.shared.afs

https://git.kernel.org/vfs/vfs/c/d0710fad7ac3

