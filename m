Return-Path: <netdev+bounces-188777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5221AAEC69
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 21:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E3D1886140
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C16621ABCE;
	Wed,  7 May 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCLmN5LI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389C79E1;
	Wed,  7 May 2025 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647195; cv=none; b=FOLgow6T4RuhI16r3aZ7c3/adoAauG+Pg9HlodYVyYngnxmt3yRtCbPB2wheahlsGddFjH9+t87yDY9Ms1CxnQDfi6Of2+RQgY6LXB5WlWC3OHAp0LFnKQYW4Mk3V/F3f+AiCVe7rTQeb9h9M3taJN/P3MlvM9YBcEl4h4lmu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647195; c=relaxed/simple;
	bh=+huMUCEEnaDT5lX704UojfexBqvHbN5oYGY2yGXWQ30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBsA10QSRHR8m0ZHUAnIOn1DdxaecMYLp0UHXkVg4TToDRZcaQ4uBzfoclLr2Ig620tdasK2cC7CkKMQz7knDGa/3W/VlFN8LjgaF7e9CndE4sSNnx0Wr5A3koD9VOPLjqcjUHh+zkDwl98u7yQqM9ZBlyzTtK6D4O4gUlHDkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCLmN5LI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B0FC4CEE2;
	Wed,  7 May 2025 19:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647194;
	bh=+huMUCEEnaDT5lX704UojfexBqvHbN5oYGY2yGXWQ30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCLmN5LInegKEB5CvhHT7hQQMTkjbAYsHXveeurSYr72atvkLvJHqABRhqEqo5YJC
	 BlkUKj9xzln0fg2D/TwqN/9H0fLa4FKyIP1GUfoGogihnwfK5Cx2LLhmjZu2+4xlZb
	 tJHwyCJh6EHZ0I9pR76wlDxigsU9dyfSWs//UbuNplniCoD8NZa45BKDswEiYRC3Hz
	 2fwGDeqzj6KImgIQOAqeYsRgX5PtA6K07rlIkfsHatStUI/vFmLmrLnYmfc1sMuL+j
	 rjmJSmgmwO+/skNd7S7emoa2xF5WJgWGd9mxGbicFVjEG3EI7HwJ9Qb//jEniIqrvI
	 OpPWuTzXp2xRA==
Date: Wed, 7 May 2025 20:46:30 +0100
From: Simon Horman <horms@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1] ptp: ocp: Limit SMA/signal/freq counts in show/store
 functions
Message-ID: <20250507194630.GJ3339421@horms.kernel.org>
References: <20250506080647.116702-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506080647.116702-1-maimon.sagi@gmail.com>

On Tue, May 06, 2025 at 11:06:47AM +0300, Sagi Maimon wrote:
> The sysfs show/store operations could access uninitialized elements in
> the freq_in[], signal_out[], and sma[] arrays, leading to NULL pointer
> dereferences. This patch introduces u8 fields (nr_freq_in, nr_signal_out,
> nr_sma) to track the actual number of initialized elements, capping the
> maximum at 4 for each array. The affected show/store functions are updated to
> respect these limits, preventing out-of-bounds access and ensuring safe
> array handling.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>

Hi Sagi,

With this patch applied GCC 14.2.0 reports:

  .../ptp_ocp.c: In function 'ptp_ocp_summary_show':
  .../ptp_ocp.c:4052:28: warning: '%d' directive writing between 1 and 11 bytes into a region of size 5 [-Wformat-overflow=]
   4052 |         sprintf(label, "GEN%d", nr + 1);
        |                            ^~
  In function '_signal_summary_show',
      inlined from 'ptp_ocp_summary_show' at drivers/ptp/ptp_ocp.c:4215:4:
  .../ptp_ocp.c:4052:24: note: directive argument in the range [-2147483639, 2147483647]
   4052 |         sprintf(label, "GEN%d", nr + 1);
        |                        ^~~~~~~
  .../ptp_ocp.c:4052:9: note: 'sprintf' output between 5 and 15 bytes into a destination of size 8
   4052 |         sprintf(label, "GEN%d", nr + 1);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  .../ptp_ocp.c: In function 'ptp_ocp_summary_show':
  .../ptp_ocp.c:4077:29: warning: '%d' directive writing between 1 and 11 bytes into a region of size 4 [-Wformat-overflow=]
   4077 |         sprintf(label, "FREQ%d", nr + 1);
        |                             ^~
  In function '_frequency_summary_show',
      inlined from 'ptp_ocp_summary_show' at drivers/ptp/ptp_ocp.c:4219:4:
  .../ptp_ocp.c:4077:24: note: directive argument in the range [-2147483640, 2147483647]
   4077 |         sprintf(label, "FREQ%d", nr + 1);
        |                        ^~~~~~~~
  .../ptp_ocp.c:4077:9: note: 'sprintf' output between 6 and 16 bytes into a destination of size 8
   4077 |         sprintf(label, "FREQ%d", nr + 1);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I think this is because before this patch it could work out, based on the
use of constants, that nr is never greater than 3, so the formatted
string will fit in the available space.

But now, although in practice that is still true, GCC can't see it

I wonder if the following is appropriate to add, either as squashed
into your patch as a separate patch. Arguably it is correct as
it allows provides enough space in the label buffer for all possible
values of nr, even though in practice only rather small values are used.

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index c723d6fe3d31..ce52b4080a19 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4044,7 +4044,7 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
 {
 	struct signal_reg __iomem *reg = bp->signal_out[nr]->mem;
 	struct ptp_ocp_signal *signal = &bp->signal[nr];
-	char label[8];
+	char label[16];
 	bool on;
 	u32 val;
 
@@ -4067,7 +4067,7 @@ static void
 _frequency_summary_show(struct seq_file *s, int nr,
 			struct frequency_reg __iomem *reg)
 {
-	char label[8];
+	char label[16];
 	bool on;
 	u32 val;
 

