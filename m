Return-Path: <netdev+bounces-204043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D371AF89C3
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207F93BAA6D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE927CB04;
	Fri,  4 Jul 2025 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGkYmrkE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E71221299;
	Fri,  4 Jul 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614949; cv=none; b=nQp3F+J5sn7/f4G99IpTVOHe8XprpEi+XJU6SK85G6vKCJP/5FkPGlsKMyYUJ84TTZoIQ2MVrWBhlDm+0TiPwgu7bl2pNAqMZozqh+R9DHIFepiGlSKmlLVVHkh9xUP8cmQaS5MICYFBHP0oWwl7TeRPxqiRt04yvndFDfumDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614949; c=relaxed/simple;
	bh=RInAKiMcXFuQGhuyL4iw29AZbJuPxGcICcArqwRN9fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao5YGjv8Z4aIoeqS/QQMwIrcQBpPQi8f8A87Ex2GKEwG02QqINTkwv5m6Fv/Ked8F1b90GUE84KdjbEvNqcbIEuEXkHL/DGgX5hoyGJauUh/2Vu7OJzRlUQ+1++DEhEopIsF4UD8xK3sdM2O2K1kmk7gnnZ6Wb/gQ8vaB4w5sQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGkYmrkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3887C4CEE3;
	Fri,  4 Jul 2025 07:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751614948;
	bh=RInAKiMcXFuQGhuyL4iw29AZbJuPxGcICcArqwRN9fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGkYmrkEAefWTgYvzkCHc+Gbn9nAamLNFSeO2gj8kn+CrPLyr7meO9Lfmays4sihJ
	 lCsLPfQuJzme6LfZXt6x/VbLqDRm3liFvDXgBWrnjUtuTijqzwGavqPDMW6rExNCiV
	 unKoMNvB6F97ZR4AqA0WN0F+2+dFZrAIuzHbFu1Td+uvlKWYQBughZKgYLflTUCxls
	 sFvS1dNPUIa4vd2MBfBSJznAd6yQcFIC5uhZ9FABYDMEk+3gFFnPta6FpFwWUZy6xu
	 Tr+MMr3WGJMnKPeYZ3ASYjQNjUPgwm7h2s1WU4fiqBZsrbjvxFjIwVLiWVUhVfBjKB
	 urhpGA5UhKXRg==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>,
	Simon Horman <horms@kernel.org>,
	kuniyu@google.com
Subject: Re: [PATCH net-next v3 0/7] allow reaped pidfds receive in SCM_PIDFD
Date: Fri,  4 Jul 2025 09:42:14 +0200
Message-ID: <20250704-sangen-zuerst-e5933c3e7f8d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=brauner@kernel.org; h=from:subject:message-id; bh=RInAKiMcXFuQGhuyL4iw29AZbJuPxGcICcArqwRN9fg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSkt96NVpz3uOZP1D6JisUyRjuCGre+Yop6wHbB0GfWk xkXXk/m6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIqyHDP02+1q/NcxdtCMoU qGbV6Ylc5JQlPf/QhdIj1ulsHQm2pxn+GVz7Xpx/Z8Op0Ju7HqyK2tZYylBtkH3722Eh2VdneR+ 08wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 04 Jul 2025 00:23:04 +0200, Alexander Mikhalitsyn wrote:
> This is a logical continuation of a story from [1], where Christian
> extented SO_PEERPIDFD to allow getting pidfds for a reaped tasks.
> 
> Git tree (based on vfs/vfs-6.17.pidfs):
> v3: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale.v3
> current: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale
> 
> [...]

Applied to the vfs-6.17.pidfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.pidfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.pidfs

[1/7] af_unix: rework unix_maybe_add_creds() to allow sleep
      https://git.kernel.org/vfs/vfs/c/9bedee7cdf4c
[2/7] af_unix: introduce unix_skb_to_scm helper
      https://git.kernel.org/vfs/vfs/c/ee47976264cd
[3/7] af_unix: introduce and use scm_replace_pid() helper
      https://git.kernel.org/vfs/vfs/c/30580dc96a3e
[4/7] af_unix/scm: fix whitespace errors
      https://git.kernel.org/vfs/vfs/c/2b9996417e4e
[5/7] af_unix: stash pidfs dentry when needed
      https://git.kernel.org/vfs/vfs/c/2775832f71e5
[6/7] af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
      https://git.kernel.org/vfs/vfs/c/c679d17d3f2d
[7/7] selftests: net: extend SCM_PIDFD test to cover stale pidfds
      https://git.kernel.org/vfs/vfs/c/861bdc6314a4

