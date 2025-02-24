Return-Path: <netdev+bounces-169187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0FA42DD0
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1592818974AB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15951ACEAD;
	Mon, 24 Feb 2025 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE2Ay2AE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9F15886C
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429036; cv=none; b=ULXNEMHWROBgLVAjfLtCF5Qdlvj+AAvXSv5PHQFBDDaK1OQTWYzzKy6I/G76/j5iKjWZnCdnS9yKomBeo+RmSTj3KxexJHr278m5JI5In93D/keHbvj1sl/p0UrO3cp3NE/J9potSzXW8TgiQmJxri9N7hTnYxgod+xWx0JavV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429036; c=relaxed/simple;
	bh=E8iE2CUWjYzHO6G4WlPRDQsPP77jDQo194ttItCJdf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo2wjybgDegYGZkYGEyFOApK2qwoMAGiMoxjz7wJQ5tbOzwE4CaHDDr0e2Yp924ABvlNGKKkNNuqdRmxitmD2YVb7gg3jnb1P9F6NZHpygmVvU+wHFaZtv5cC6y2fxSRibi6bhgWfMHxo17OHrsFftXh4ZX09cJpChEERf68CK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE2Ay2AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B3AC4CED6;
	Mon, 24 Feb 2025 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429036;
	bh=E8iE2CUWjYzHO6G4WlPRDQsPP77jDQo194ttItCJdf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gE2Ay2AEwB9oH8XRJeuc9um31uHexLX+1IBxvPrrD03baximtpTS4JGg80OWWV/Fa
	 aSIvacCs+mrP9Fy92uOf1SYOP0d3S3IkrYQtyQ/OfftjpKisTl9oFfeuCvNdXZjNrz
	 lySwh9bQ5EAF08pxYVC7yfZKCmA51qUadjDB+tunIlpIgpZcG6rJtBHvzT9fAaKeps
	 JJedrQJusSDvidUwslOia4mZgVephhZfNmbPmKW8AbSvoyQlfgrFIJmpLK1W2XTNAn
	 anISwZA87w8deNRfL9/6ScAfMDZmAhFdHFSzR2+GCwDXQki+vgnBwSxKuHpMQ3V+hI
	 tGoWLOXHKD/Gw==
Date: Mon, 24 Feb 2025 12:30:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com, Olga Albisser
 <olga@albisser.org>, Olivier Tilmans <olivier.tilmans@nokia.com>, Henrik
 Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>, Pedro
 Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Message-ID: <20250224123034.675e0446@kernel.org>
In-Reply-To: <20250222100725.27838-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250222100725.27838-1-chia-yu.chang@nokia-bell-labs.com>
	<20250222100725.27838-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 11:07:25 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> 
> DualPI2 provides L4S-type low latency & loss to traffic that uses a
> scalable congestion controller (e.g. TCP-Prague, DCTCP) without
> degrading the performance of 'classic' traffic (e.g. Reno,
> Cubic etc.). It is intended to be the reference implementation of the
> IETF's DualQ Coupled AQM.

Pedro reports that you're missing:

diff --git a/tools/testing/selftests/tc-testing/tdc.sh 
b/tools/testing/selftests/tc-testing/tdc.sh
index cddff1772..e64e8acb7 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -63,4 +63,5 @@ try_modprobe sch_hfsc
  try_modprobe sch_hhf
  try_modprobe sch_htb
  try_modprobe sch_teql
+try_modprobe sch_dualpi2
  ./tdc.py -J`nproc`

-- 
pw-bot: cr

