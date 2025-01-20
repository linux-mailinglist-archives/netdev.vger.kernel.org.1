Return-Path: <netdev+bounces-159857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD151A17332
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD0188276C
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF6A1EE026;
	Mon, 20 Jan 2025 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a417/nSb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54EB1E0E0A
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402047; cv=none; b=EdYWOpIK+kic+tzmBu9MLrapwfjxhNCekR/saR0CJqam0mcIy++bcvuhfasEWle7hlSUsUgJJkw+IE+KA3tZ61YdQW/+qBp5gaADz2hbyK5wnFKOv+eOczlgX7LmkquQSb0AkJa/hYYyrNc0A6LLCBiRZC0zE60r3TciPDlHdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402047; c=relaxed/simple;
	bh=L2JungrhmSGKU/aHWSA1Z8rVywvNrUtd6hb/w/9MVUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rg5cDomuFbzsffVyvF9srw/FPVD5G/tsTlwviuPowLcTnBxUSpNHOrHkxsRL7+EIALajwHwc1tpM6m3Vmu7w6DcTAl6qXe3zSBpvABd6XkwxsTl7TF01qMmiAXOx9PKHKGH0A5uPMlXtj5XjKH5t2wBKc9bIDic6DMLGv8P12s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a417/nSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24CEC4CEDD;
	Mon, 20 Jan 2025 19:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737402047;
	bh=L2JungrhmSGKU/aHWSA1Z8rVywvNrUtd6hb/w/9MVUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a417/nSbpmP83djB1Jr+UJn/OkkpdmoJ2ITdheHvo4N5fTol8K+51zufCHAtyd/Px
	 jQEclrZyv0gt3NbnmjlJfOEIX0I2YQXzlNHBTjRuaHgPj6aV3YwSaxvCkHC7GoM8mA
	 SiUtwLgDJcSimNF+IsSrtSW2qYb89oujpSI3ku3hq5aDHaCYB+DX9OmTpZvWBTpCij
	 cvqcrey6qAn1dOTPKQzRxdsQWq9UZWwKbD6VczfWWddNHOkFg8o5DcHjzEToI/KKlB
	 4MAwNlVmBagKP/r+LKnvrE4h3fPOLfn7eOV4ZBmeBTQmFoyjIjMZ1vJxHDGNrSvsQE
	 vwAnWNkYtJRwA==
Date: Mon, 20 Jan 2025 11:40:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 stephen@networkplumber.org, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net-sysfs: remove the
 rtnl_trylock/restart_syscall construction
Message-ID: <20250120114045.3711fdc9@kernel.org>
In-Reply-To: <20250117102612.132644-1-atenart@kernel.org>
References: <20250117102612.132644-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 11:26:07 +0100 Antoine Tenart wrote:
> The series initially aimed at improving spins (and thus delays) while
> accessing net sysfs under rtnl lock contention[1]. The culprit was the
> trylock/restart_syscall constructions. There wasn't much interest at the
> time but it got traction recently for other reasons (lowering the rtnl
> lock pressure).

Sorry for the flip flop but would you mind if we applied this right
after the merge window? It doesn't feel super risky, but on the small
chance that it does blow up - explaining why we applied it during 
the MW would be more of an apology..

