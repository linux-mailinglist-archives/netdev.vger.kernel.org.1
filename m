Return-Path: <netdev+bounces-211112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F3B169EB
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75C718C6E64
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBE72617;
	Thu, 31 Jul 2025 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn4w2GOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769FF2905
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924370; cv=none; b=Jl6k6yMuMdfGSveoXUjy+lTQ1PH3Ly9E1og45bGNaIQBmVQzSyQkzNkfTRCCTGrX/RzLndI9V0VC0BiSmnQdCr/+5oMGe6SHF2y77QBHkjgWvj0rG5C4h15aqbYdfV/Qb24vze5CTzm/VACsx0jJiLW5BrtG1wKD8XtHizpxx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924370; c=relaxed/simple;
	bh=9ociyqJyFcfldmKy6upAQyl7szxtyAo8GBQWBDsaj/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHmEg9pPBbi6VVd74OkRvMjXotsqUnQjUgz2P1fpfEf9A/CPL27sAXrFnqONcy4jERGDtV/nn/bMTToR2hLcFq/VlZLWdcU0JC45kIpiuuAw139VKkuJFDwCQMwzIwIn/MNU1R4A/hbdEeRJGqlrmQvF1tGCjORqkw1t0QMcEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn4w2GOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA910C4CEEB;
	Thu, 31 Jul 2025 01:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753924370;
	bh=9ociyqJyFcfldmKy6upAQyl7szxtyAo8GBQWBDsaj/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gn4w2GOD+ymA63b3IU68rZvEl4enPLO/sq59qejPyPszeh80upsM3XABbWkxnKpVk
	 /TFYh3BhQ/enam5jHGr5dfwfBG8wpQLtUa5DeB+0iUizEUSChqh+2Uq28ke5YQp57K
	 vwOXnLb9FOvXTVW2ZUZswrkZrI2EIjVL5rs2umAL9mrxxzCrj103Ya+XzMIrvyGgkM
	 AW9MFVCk8WCncxJFvvUWJGgYVvTDj0t6Wbnnyx2ASkfcy3GcKQDZ/wL3G362Z9R6Tf
	 uNP84BROAie6guePSVhDtoml9wVW4liHEQsqSohyHGKgIx4cH7p2XL1EVaYYL3RGKm
	 EruCJrJ0GmCrw==
Date: Wed, 30 Jul 2025 18:12:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix PPE table access in
 airoha_ppe_debugfs_foe_show()
Message-ID: <20250730181249.78dbe4f2@kernel.org>
In-Reply-To: <20250728-airoha_ppe_foe_get_entry_locked-v1-1-8630ec73f3d1@kernel.org>
References: <20250728-airoha_ppe_foe_get_entry_locked-v1-1-8630ec73f3d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 13:58:08 +0200 Lorenzo Bianconi wrote:
> +struct airoha_foe_entry *
> +airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash)

Hm, could be just me, but the way we/I used _locked in the core was 
the opposite. _locked means the caller's already taken the lock.
Here you seem to be saying that the "callee is locked"..
Can we stick to core's interpretation?

> +	struct airoha_foe_entry *hwe;
> +
> +	spin_lock_bh(&ppe_lock);
> +	hwe = airoha_ppe_foe_get_entry(ppe, hash);
> +	spin_unlock_bh(&ppe_lock);
> +
> +	return hwe;

Is the lifetime of the hwe object somehow guaranteed in the debugfs
code? Looks questionable..
-- 
pw-bot: cr

