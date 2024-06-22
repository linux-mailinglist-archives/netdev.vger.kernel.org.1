Return-Path: <netdev+bounces-105820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E1591310E
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 02:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08002B21BB8
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 00:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D8728F1;
	Sat, 22 Jun 2024 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKLcd54V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0702119;
	Sat, 22 Jun 2024 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014749; cv=none; b=hYW1B00Nt8l7vSJuqQX0PoE74vmER7Hy8T9UAMQmiGBrPUe6LktFS5h8cbWQmIFbhhPeRkOjDCxPgWJ79s4scNOyls4pPIcJM1By7KM/AZ5zRUVAjIG5ApIsiVwvO/tHf1w7eQd7IMxu59BbCfQqMa1euz1MhAAJLIqxwZ6JENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014749; c=relaxed/simple;
	bh=MhQOPNbcZW2UknZ5/E2o3DrYW4YHYA2kU1rWz3UmQX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoKFad8H62fL9nVNy8hHNFptv3kHMREXSwAJlkJg/YES5YNfiKnukvQkIypQ3m5QbVHO1hxygzwdr4izEBBlmWQ5z09ZWcsi0F9GX2Et2ESlK4WnrMF4x/yCNpSd/JR/pKklMq5cVbOwXL0Oxf3V/cxANPIvlviYMDsXl2QBk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKLcd54V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF150C2BBFC;
	Sat, 22 Jun 2024 00:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719014748;
	bh=MhQOPNbcZW2UknZ5/E2o3DrYW4YHYA2kU1rWz3UmQX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKLcd54VCW3FOn3TnF6UrtmHqvO6D/ihPGRoTIufvYwCdmQAbRqQdphOg8N5Vma+e
	 iGmk3TNTO2mqqIVFeHu06BfVhFgHdARNkwXpey+wFHA67FzxnvCHfmxHqGy7tMwzbl
	 0KZsYfmCvtHy1dDGnyO7ZKeDJHucPm70mDb1feZlP9x9z7agumROtLeLjOCr4726ds
	 oKk1hiOGAiKyuPlq+oSgT+cxWqo6y550Gkf8vB+9iEcz2RIP0R3bS6xJsA+UkEHHQb
	 lNdfHSAjFCeCTk2Ldpm6+HAAnPQh1+6LpHESnM7HXze901mdjzjOxMCemMZ7OczJP7
	 th6uMQe2oHFbg==
Date: Fri, 21 Jun 2024 17:05:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: yskelg@gmail.com
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Takashi Iwai
 <tiwai@suse.de>, "David S. Miller" <davem@davemloft.net>, Thomas
 =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Taehee Yoo
 <ap420073@gmail.com>, Austin Kim <austindh.kim@gmail.com>,
 shjy180909@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ppbuk5246@gmail.com, Yeoreum Yun
 <yeoreum.yun@arm.com>
Subject: Re: [PATCH net v2] net/sched: Fixes: 51270d573a8d NULL ptr deref in
 perf_trace_qdisc_reset()
Message-ID: <20240621170546.0588eec5@kernel.org>
In-Reply-To: <20240621162552.5078-4-yskelg@gmail.com>
References: <20240621162552.5078-4-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jun 2024 01:25:54 +0900 yskelg@gmail.com wrote:
> Subject: [PATCH net v2] net/sched: Fixes: 51270d573a8d NULL ptr deref in perf_trace_qdisc_reset()

the Fixes tag goes before your signoff, rather than as title.
try

  git log --grep=Fixes
-- 
pw-bot: cr

