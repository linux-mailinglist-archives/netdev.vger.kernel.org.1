Return-Path: <netdev+bounces-241197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AB4C8147F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A5A3A6C57
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0238730AAC1;
	Mon, 24 Nov 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZA26I/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C127FB1E
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997512; cv=none; b=bYwh4N5CBhssHxqbezFli5o/AiOmsA/wFAxoiUg1xaEbrHHpJ9zShg50xZoyIX0GVhjTacIUeMVOn4Voyqcjm2Fo65Aq9MzMbzg4H1A0KUHnuF14U/ASjGg3KL2QCHRHwQGwiAr71QQjHFx60ciMdkpkaC+coew3rcT0HvXnSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997512; c=relaxed/simple;
	bh=DbTxJOtlnG+452WILNUM3WASSzpPs3RC3wLJQXIbpWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lNc7CAaIk9szh+6tv3T3e7S8QhT+MrgzUjdpZALB7i8MpNBliuI/Rif2MBcoGaNTg8TRO+eRmaRIGFQu6sTuTjbAO/MUu7refzLgoMlZS0MHbu7eQ1Hj/SB+YNuh1Z8f87aADWDVFBNmE2bIYKjKI0gE7EcU2Idn0QVC+o+rfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZA26I/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41425C4CEF1;
	Mon, 24 Nov 2025 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763997512;
	bh=DbTxJOtlnG+452WILNUM3WASSzpPs3RC3wLJQXIbpWM=;
	h=Date:From:To:Cc:Subject:From;
	b=RZA26I/vDbheo10jDR+18alplaAFcncICfEZLA+WpKjkjnk00YZeY+OKq1MvChcin
	 jaPpLWjw07Fw5cCxi+CEVdjCjbyQ/R/Z84bvUlFvoigSHckSq2RJq3hIP9DU/Vc9cz
	 t2PXmubokcOVhcFlpwwbh6u8fAmoEfuAATbW76jzeUlNSK6bwrHjo6YkTywqGRFhoB
	 Bb0IZ6e2ZOMYO+QfJnZm2T8SiXy3oiosH4Xj65iZtFJJemJHbCMuYKp7BA+C+rrt+N
	 OJHP7y+fYc/EmB0DPnAEWen7diqRBc/wyekwUPaO7AHNX7IACYxPIelSdUGrTiNb1T
	 MkkeNtbxz48/Q==
Date: Mon, 24 Nov 2025 07:18:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org
Subject: [TEST] tcp_zerocopy_maxfrags.pkt fails
Message-ID: <20251124071831.4cbbf412@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Willem!

I migrated netdev CI to our own infra now, and the slightly faster,
Fedora-based system is failing tcp_zerocopy_maxfrags.pkt:

# tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect outbound data payload
# script packet:  1.000237 P. 36:37(1) ack 1 
# actual packet:  1.000235 P. 36:37(1) ack 1 win 1050 
# not ok 1 ipv4
# tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect outbound data payload
# script packet:  1.000209 P. 36:37(1) ack 1 
# actual packet:  1.000208 P. 36:37(1) ack 1 win 1050 
# not ok 2 ipv6
# # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0

https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/399942/13-tcp-zerocopy-maxfrags-pkt/stdout

This happens on both debug and non-debug kernel (tho on the former 
the failure is masked due to MACHINE_SLOW).

