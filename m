Return-Path: <netdev+bounces-241196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF5C813BE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B6BA4E1315
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A3296159;
	Mon, 24 Nov 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiVXH5Qj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395F28725B
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996844; cv=none; b=tlZ5fY/KiScXrWwtowW1IF2E/VX8A8KSTW+wbSEo9CWm4Qx0zoT8EBV5W6LPNzzmni8GKN8FGb6I/DMzngM1W1KyPtwpbQfiW9/ahQ4/RQtd6csRTbtrI95nIX8AL6qpvZx1UYxn+SoL1ZLnyCaL5Ae2g4m07ayyf4SL4FeEkJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996844; c=relaxed/simple;
	bh=KWfvD5bbHnsXFh/tjkiC+gj921RN1CFu/6sCcsqk0UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Mc2oo4ZX7OlGajIX3Xkm+5hnkSJ6huB+G108O+XpoDeS+STgQS8bbXHbrYvTZ++KS9Vb+Gur9ixsLhj42oqIOZWs6X/kjEyzTldtP8WwdYUdOBrWI8ix5KdsIPLvH++tXejdCDS+o70e5+PCGEQVwTXZUhd9C3GfisESuoizsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiVXH5Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0421C4CEF1;
	Mon, 24 Nov 2025 15:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763996843;
	bh=KWfvD5bbHnsXFh/tjkiC+gj921RN1CFu/6sCcsqk0UQ=;
	h=Date:From:To:Cc:Subject:From;
	b=YiVXH5QjP/Fy0mZV+CRfu6i4jGri/n5CRZ45irE8Yfb1g6ld+Q2t2D2sTLQ6DbFSH
	 l2oAU7HbuaLLk87zodFgnYydPnBXpkhojsh7o4AWBcyCKo74/9kt0kF+U1nqFMWvQA
	 /Dv4v2uT6BeWR4IX0Mvr63WHRJR2cp7M+Uo2Y9NVd7XMcZkkHHahE3iLxnCyB1YHav
	 8Z4Awz3c2u2D/F6p2W6HqIKLgcyaBY5j4jlb/r0DMgi5f+1o37jLPf6gB4JpKP+4uL
	 6Sjx4sFVPkVBQu+IAfC3CojufwQf5Tn6GPQFMuRhZKvM8ubzlxvI/Rx62lewBXSFTZ
	 jy4v3wX3yEZaw==
Date: Mon, 24 Nov 2025 07:07:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] so_peek_off flakes on new NIPA systems
Message-ID: <20251124070722.1e828c53@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kuniyuki!

We upgraded our system for NIPA recently to netdev foundation one=20
(as you know). Looks like net/af_unix: so_peek_off is flaking
on both debug and non-debug builds quite a lot with:

# # so_peek_off.c:149:two_chunks_overlap_blocking:Expected -1 (-1) !=3D byt=
es (-1)
# # two_chunks_overlap_blocking: Test terminated by assertion
# #          FAIL  so_peek_off.stream.two_chunks_overlap_blocking

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/399761/134-s=
o-peek-off/stdout

The newer system is 10-20% faster it's also moved from AWS Linux to
Fedora. But I suspect the real reason is that our old system had
quietly broken compilation of af_unix selftests
because of Wflex-array-member-not-at-end which AWS Linux gcc doesn't
understand:

gcc: error: unrecognized command-line option =E2=80=98-Wflex-array-member-n=
ot-at-end=E2=80=99
make: *** [../../lib.mk:222: /home/virtme/testing/wt-1/tools/testing/selfte=
sts/net/af_unix/diag_uid] Error 1

So effectively we're been running some old copy of af_unix tests since
this flag was added.

