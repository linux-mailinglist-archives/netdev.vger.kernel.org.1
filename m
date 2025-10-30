Return-Path: <netdev+bounces-234259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29CC1E2F8
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B396D1888A7A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8342EA731;
	Thu, 30 Oct 2025 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G460pf5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC02D0636;
	Thu, 30 Oct 2025 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793574; cv=none; b=NXy7QMs3cpIoXcVYX6z92WzG1JH9xzXU2PFhB6mI0C9wLx1dHZp8pererfoHu4VB+0XsclILdA/UCWEvvN+1ZAE8S0B/yTibRwIzCnAlDUhZ9Mva5jAgt3T6jtD4VnlEopqL2B2FtJOZBbAblXjWuoAmXWeyAYbPdWJDulHQq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793574; c=relaxed/simple;
	bh=dVUd0kxP8SBgNKarJK8Wzf0YKtUqqRpN45iifynlBCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKT2b94EcQeO0/6gOEV14ZMFG6Xp24uJMDRQrQJT/15EbAyqlBkXw5a8FWObed7yPNgTWGbHSktOrhHyafKLdC2UBwwFb0Yp8usVhMn48azvPbgbi49IIE8bxXKT2SDkZ5LrI9dh3XQUBJmDMIxP0VYG/RdSgTYohTzvREMiMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G460pf5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EE2C4CEF7;
	Thu, 30 Oct 2025 03:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761793574;
	bh=dVUd0kxP8SBgNKarJK8Wzf0YKtUqqRpN45iifynlBCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G460pf5wZhF+5PaPtXWKUHL7xcNeYSTZq5hk994ffhXrjkGhrgreSpGNZyneEKfoD
	 PwDjfzcQDKLl4mDUwnv0v9ccHu48LXdI+LxeCtNmvPCEEJbLlaZ5k/ZFATc9bxk/79
	 sPPII1vhsbTRFwgdxKyQnXM61r0Kf2nMvvLB7v5ZWlquSgOxG3zVFqIBiRq6rX+8Ra
	 Bb6lAPLQSaYbv/9J6r8ZAwC066QnJMnbmdK5pTmgaFEDRUdXWwBgrFtkAwDpwHRpZL
	 RyxMPd7Gq4YechklQOWL+7lWM55HuaYxKL1P/QUz7dFcEL2F2C+7l2DQ+Ff9PmgkXg
	 CnMEEcH/JeC3A==
From: Kees Cook <kees@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 0/3] Resolve ARM kCFI build failure in idpf xsk.c
Date: Wed, 29 Oct 2025 20:06:09 -0700
Message-Id: <176179356659.2479588.16940248582240491111.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 25 Oct 2025 21:53:17 +0100, Nathan Chancellor wrote:
> This series resolves a build failure that is seen in
> drivers/net/ethernet/intel/idpf/xsk.c after commit 9705d6552f58 ("idpf:
> implement Rx path for AF_XDP") in 6.18-rc1 with ARCH=arm and
> CONFIG_CFI=y. See patch 3 for a simplified reproducer on top of
> defconfig.
> 
> I think this could go via hardening or net.
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/3] compiler_types: Introduce __nocfi_generic
      https://git.kernel.org/kees/c/39c89ee6e9c4
[2/3] ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
      https://git.kernel.org/kees/c/1ed9e6b1004f
[3/3] libeth: xdp: Disable generic kCFI pass for libeth_xdp_tx_xmit_bulk()
      https://git.kernel.org/kees/c/c57f5fee54df

Take care,

-- 
Kees Cook


