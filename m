Return-Path: <netdev+bounces-122533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665596196E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A56284E7E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736D1D3652;
	Tue, 27 Aug 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyGGWazV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F413B293
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795445; cv=none; b=oA75mnTLDJy1fbA6hhaBaX6V0YEhMkTBwDwzilQx0Fr6tgHvC5yMRheFFLPHEsrRvLxRjkmekPbsEigM2ZqCsCBhAau3hn0W1Rk91BF5AHWh6vCkX2dbL3xymR4TIZxwMgACU5kiq/WTXP+WpFJ16w3UaC7AtgnQ4xnSeDZn1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795445; c=relaxed/simple;
	bh=5W9CfWH+esXz9WBOHwi84UDDTzV+1yT/2i+CCpT+Dn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqkJ+dK1SvYLoaLmyv172bhhcDRp546evJpwDNhWIg7rno3Xhh9qHm2zTJo10Z45FxIBq1Fc68cYYweGIMoTFOF0ZHI+vuqPrLZ9KGVO/pYA7DmWJLDcpXE6WBNJtibe5aq/gRFR7m6nZXG69UqQ0+kM87f2sELcB8UopJ6QArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyGGWazV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA89FC4AF19;
	Tue, 27 Aug 2024 21:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724795445;
	bh=5W9CfWH+esXz9WBOHwi84UDDTzV+1yT/2i+CCpT+Dn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gyGGWazVMBe7SJrAyo9Q3q2K5E1GEix5pHky0qZxVCdX7o9c5o/isFGS+w1YIEqDr
	 Q/4Ct+xDdUNTWkigJ/Sy8n3KAVAPyToA9tcgRYb7QUmDStAQWR1TbTlf9+FDeuwKrM
	 oOLkOFV3OV4mwUNKYY760CHc832iQLQmhAams6tB2UWzSjZhNg059yZHtuNYNgtXUR
	 EEj8v8QJYQPw+ZZgSUJqZT2X0WtiJNzptTmAQe0rplVBSD7y/+h7qA2wAelq27mVyU
	 P+3N5tBY6m7mAxM3Vmh8J6+U3ALcjOnWjmNfse59bnkdh//HQk2m7Bjo6rWcI0mpMS
	 px6m4e6xcIWfA==
Date: Tue, 27 Aug 2024 14:50:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, passt-dev@passt.top,
 sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, edumazet@google.com
Subject: Re: [net-next, v2 2/2] selftests: add selftest for tcp SO_PEEK_OFF
 support
Message-ID: <20240827145043.2646387e@kernel.org>
In-Reply-To: <20240826194932.420992-3-jmaloy@redhat.com>
References: <20240826194932.420992-1-jmaloy@redhat.com>
	<20240826194932.420992-3-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 15:49:32 -0400 jmaloy@redhat.com wrote:
> +}
> +

nit: extra new line at the end here, git warns when applying

BTW did someone point out v6 is missing on the list? If so could
we add a Link: to that thread?
-- 
pw-bot: cr

