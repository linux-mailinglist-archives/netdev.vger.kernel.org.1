Return-Path: <netdev+bounces-74963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E421867AF6
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6B9B21E0A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593C129A7B;
	Mon, 26 Feb 2024 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFMAD8yW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54CF605D5
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959357; cv=none; b=lnrjVPxs4GJV/QrGVEudaNHZrm2FIO6B61yyD+pWiePd42bnORkTVssqXxoiol+jEu3lgMwf7Uyh/omYFcKnjq4bmDhCTrhCqgXcjBEvfOfvkXb9Orga1p/yJSJqrygMsWcTgcQo3y1BTjsYDhnzfaZzcgAKavqnGVg3yynvgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959357; c=relaxed/simple;
	bh=5sbi5B8TfZZpHXw6nsE3Ir3Nu60cN72UewmoH5SPOn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEc+c1JwLnbNuA06bLmqm8JM4XiVdX/ZpI1Hc7xZh6z9c6o3HJA7fjEYOX6y6dh3NlI3xqg/TFdQtBg/QucAwYh2iiiWgTpJO23gL9pV7jVegc78i7Gq5ZUxRT/k8xf0yR+mwHMu96OjZwcz70QqKoPD0ZUpH7Kg9PE70Q/Lrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFMAD8yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4FEC433C7;
	Mon, 26 Feb 2024 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708959357;
	bh=5sbi5B8TfZZpHXw6nsE3Ir3Nu60cN72UewmoH5SPOn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jFMAD8yW26u9hDR73Uyg/RdJufZtOA9M7uqHW99rTiS+r3YgnxvD9FWjHp9ttShxV
	 fPDKn7fqaEhEVB9LusskKcmGAEpXtiZE7QZk4zTm99eZLovjYbvhmYwp0Uza0qWIgT
	 WvAFXV32cQMwlNqB0bxKeFWxFPsDOGaC0nh74znTLgzWkgerJon1ulQ43bHK/6oODa
	 L4mMhIPFLccrl7c5Fs3AxI+XEG5cQ+Vpe3kyr2S5MxtfqbYxXkSeQsmpahDOEkGXMN
	 dMA6v/2/FzjVQtRR/ngyaHIrG/16Mk3sONr14AqInvdh27Ejc5MV96bjhaOY7aw8N3
	 seIu6I9X5bSlg==
Date: Mon, 26 Feb 2024 06:55:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jakub Raczynski" <j.raczynski@samsung.com>
Cc: <netdev@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
 <joabreu@synopsys.com>
Subject: Re: [PATCH] stmmac: Clear variable when destroying workqueue
Message-ID: <20240226065556.0ffe7cb1@kernel.org>
In-Reply-To: <000001da68a3$cc05a190$6410e4b0$@samsung.com>
References: <CGME20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b@eucas1p2.samsung.com>
	<20240221143233.54350-1-j.raczynski@samsung.com>
	<20240223163251.49bd1870@kernel.org>
	<000001da68a3$cc05a190$6410e4b0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 12:06:02 +0100 Jakub Raczynski wrote:
> Scratch that, confused main workqueue with fpe_workqueue in that message.
> Proposed commit should not introduce problem with fpe_workqueue, since in
> stmmac_fpe_event_status() there is check for both NULL and __FPE_REMOVING
> before queueing work.

You're right, I missed the NULL check.. if there's no other use of
fpe_wq - v2 just needs the Fixes tag.

