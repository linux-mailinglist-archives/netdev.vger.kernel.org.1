Return-Path: <netdev+bounces-207259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D870B0679F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6896188A8CF
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72E41EFF9B;
	Tue, 15 Jul 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6TplRCc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2511EEE0;
	Tue, 15 Jul 2025 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610604; cv=none; b=ie5ySVZ/JCPxYZdug5LaasGZgy+hLAiyRpomPK9WIZwKoDVMqQIUpOlRu9JoejRHQdUppyjoO7eXAVe8rS1fFI2zv63rI1C2tkf9bo2kk5naEI4p1DF2GMiTjzZOIZRxlmBlwLpGAqqWQj5LPCIeWhGTs7/mq56dXt3khi2JDAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610604; c=relaxed/simple;
	bh=sJ/g+WH+oOo18gZ32qIGOTp7+DqXt/8ANhMamSl+Th0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K07jBElLb7fbfr6TdXh0MPbh7Q7QLG2CVSFrMTngu+pn2E7yeHNY3RJz6cLNm3iRCzZNsVnbi5FiGPxD5dKhiT4yUg6S4FguXntOxiKExLqlLhjfPSicHNLQhYpD1DT9ji2+cPsslX4WeVd96RJCpYxdzIWXd3DvRDxaC2vAxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6TplRCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64470C4CEE3;
	Tue, 15 Jul 2025 20:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752610602;
	bh=sJ/g+WH+oOo18gZ32qIGOTp7+DqXt/8ANhMamSl+Th0=;
	h=Date:From:To:Cc:Subject:From;
	b=i6TplRCckdtx7+U7OXpU24bzZ+zNt0yQx/dSuHo7SKSP7ETgH9g42mvC4cpXGiOWN
	 bKLT7ScvWzStfzfPhCtB/Bj/4Ld/3E/rEILtL9C4Y+yuN59ayQQJODu3glIpMk3h9t
	 SDb322BxGu3uTFR0RicZWfbvs8znJUzNVdcKAUTkefEh702yY1npnIiPbbW7BZDIZb
	 YZ4BOs0FM3prZHVS2syFfzgseoYUPPki73W+G8ANgi9T1Tx+xd9ut6UNC24q2PwOMt
	 z5PGnOC8e53vzc5u/l6p/S/EbTSNZ++/8+NGpxZKDv4aTzec9mM8z7SbDK/lnTOPRi
	 2CnJExDVNcolw==
Date: Tue, 15 Jul 2025 13:16:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Remi Denis-Courmont <courmisch@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: -Wuninitialized-const-pointer in net/phonet/pep.c
Message-ID: <20250715201637.GA2104822@ax162>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

A new warning in clang [1] points out that dst is not initialized when
passed to pep_find_pipe() in pep_sock_accept():

  net/phonet/pep.c:829:37: error: variable 'dst' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
    829 |         newsk = pep_find_pipe(&pn->hlist, &dst, pipe_handle);
        |                                            ^~~

It looks like this was introduced by commit f7ae8d59f661 ("Phonet:
allocate sock from accept syscall rather than soft IRQ") if I understand
correctly. Prior to that change, both calls to pep_find_pipe() were in
the same function with pn_skb_get_dst_sockaddr(skb, &dst) before them,
so dst would always be initialized. Should pn_skb_get_dst_sockaddr() be
called before pep_find_pipe() in pep_sock_accept() as well or is there
some other fix for this? I am not familiar with this code, hence the
inquiry.

[1]: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e

Cheers,
Nathan

