Return-Path: <netdev+bounces-145686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0709D0626
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEB81F21D6E
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47371DDA32;
	Sun, 17 Nov 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VO8TvOK8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB01DDA10
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878476; cv=none; b=KNYsq+PWv3aVVfhqbQebx7wWLjnBgwQfRb/pQ5DnDVw0ke3CLGSwpWrM54TbHddF/nc6YmRQnmMBIwyhSak6BuC42Ey8mBifHG5IZnX65uslO6et6seW4HlGkED0h4cWFI/M0RruhcRNTEF3axCVxVDVzavncZOnTJvek8JZ3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878476; c=relaxed/simple;
	bh=w9cEU43BbFKQvcCN8rFZFMN5Swgxvg9k+7SWoqeZY0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sh2RWO/mntaiE2msSJEMojT9CThnRQSFisRJXQypQsAjouLR0N30J0WTPBuMLP0BYMC/dC82a1bcIg4IxqiRGXD0ARYlvrtcNZddnG/crbD+OKOaFVqKuxISdf5tLaEP+cPeln0VoEyBq8eJNCd2rtsVXvnpW15h0abTqT2n5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=VO8TvOK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD84C4CED7;
	Sun, 17 Nov 2024 21:21:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VO8TvOK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731878474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fr+ue3lV00IafQ5IpqPjEfPR3OZp5mhckuDRMRSDja8=;
	b=VO8TvOK8npD90mA9HbTEYFCOKsOFclOYwl0gFcEWChNC/D9cuVgxhbJXgZ5k0gOcFKJ2ip
	33UNz8+ViMmeed3Feh1Pc/b/twQz53xFsX2EXuqKsnVHNmZOWKDgeIFfZWJcVxdE5ntnDU
	OdUC3kqI05VsApK9W0JnjUVa9Z3HPNA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 438d19b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 21:21:14 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 3/4] wireguard: selftests: load nf_conntrack if not present
Date: Sun, 17 Nov 2024 22:20:29 +0100
Message-ID: <20241117212030.629159-4-Jason@zx2c4.com>
In-Reply-To: <20241117212030.629159-1-Jason@zx2c4.com>
References: <20241117212030.629159-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hangbin Liu <liuhangbin@gmail.com>

Some distros may not load nf_conntrack by default, which will cause
subsequent nf_conntrack sets to fail. Load this module if it is not
already loaded.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
[ Jason: add [[ -e ... ]] check so this works in the qemu harness. ]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/wireguard/netns.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index 405ff262ca93..55500f901fbc 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -332,6 +332,7 @@ waitiface $netns1 vethc
 waitiface $netns2 veths
 
 n0 bash -c 'printf 1 > /proc/sys/net/ipv4/ip_forward'
+[[ -e /proc/sys/net/netfilter/nf_conntrack_udp_timeout ]] || modprobe nf_conntrack
 n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout'
 n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout_stream'
 n0 iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -d 10.0.0.0/24 -j SNAT --to 10.0.0.1
-- 
2.46.0


