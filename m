Return-Path: <netdev+bounces-143030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759D59C0F32
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2CE1F245D3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDACC21731F;
	Thu,  7 Nov 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFODgOoj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3A186E58;
	Thu,  7 Nov 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008675; cv=none; b=emAL3YpD8TjYaJYOmhUS50Brrm5Hu1WhZQxnDcTdukalCuBpOSVOPl0Kl+QJN2o1NzsnhJWGts5WnBJ74FHODuMOH9EXXycj8/4Mm4F/jbGXrUPfhudSxPfqOOLOcZXUpbMiURNXUPdLSDssIId9iB+ajY+Ykhld6fdgfguGNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008675; c=relaxed/simple;
	bh=Lm1VbNzcJYV38ew2xCXXcRVdevnaodY907xW8j0a740=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+oi6106Sp4vdm69Dsq6mt4gFMUsk+bYW0yq/JGnm2t8Te4TA2InxyChJTWRuB124+95oiYIyHAffCA7EJrVglJktHgTyAAK3b1Xq2/PFZOoKo599+vQBipircLqtff4YmnLCM8TazKB2tP8ZdgPjJfV/geFOgqSJfu0xrz5RVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFODgOoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165C1C4CECC;
	Thu,  7 Nov 2024 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731008675;
	bh=Lm1VbNzcJYV38ew2xCXXcRVdevnaodY907xW8j0a740=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cFODgOojKut0CCnQIUfFzCYR+5UG5cWqmL1LQr2ZY9xqG+p4Av+JgxHdV4Fmkqgtw
	 zvs15wgpazMCwa2ygyC/Kskwlm7ZEgvSukkGkDRVHdk7ADbJOBY/PkJZxEfl1LYIS2
	 Hx1+Ycq+qydo0e9X52tPVNFJKLTa3FrGQgjXragfz/c/LiPKAS4wUF2iQbDNgCB+9J
	 EAJOCgZsqsA8uReH4L5LO+e5PiC07J2o+B/MGA0LYWlJosWvVSRiyElknHlx1TGsEg
	 ywHgDxOCgvsZ01alDC6GEsuYUG1upaX+6eWmt7cHCA2ZEFKuCgvJ4hy1iYDM2Uck+l
	 jEVDqrk3HageA==
Date: Thu, 7 Nov 2024 11:44:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Wentao Liang <liangwentao@iscas.ac.cn>, brett.creeley@amd.com,
 davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Wentao Liang <Wentao_liang_g@163.com>
Subject: Re: [PATCH net v3] drivers: net: ionic: add missed debugfs cleanup
 to ionic_probe() error path
Message-ID: <20241107114434.05e6b875@kernel.org>
In-Reply-To: <79f0ce60-58a5-4757-88eb-1cdc8a80388b@amd.com>
References: <20241107021756.1677-1-liangwentao@iscas.ac.cn>
	<79f0ce60-58a5-4757-88eb-1cdc8a80388b@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 11:31:50 -0800 Nelson, Shannon wrote:
> On 11/6/2024 6:17 PM, Wentao Liang wrote:
> > 
> > From: Wentao Liang <Wentao_liang_g@163.com>
> > 
> > The ionic_setup_one() creates a debugfs entry for ionic upon
> > successful execution. However, the ionic_probe() does not
> > release the dentry before returning, resulting in a memory
> > leak.
> > 
> > To fix this bug, we add the ionic_debugfs_del_dev() to release
> > the resources in a timely manner before returning.
> > 
> > Fixes: 0de38d9f1dba ("ionic: extract common bits from ionic_probe")
> > Signed-off-by: Wentao Liang <Wentao_liang_g@163.com>  
> 
> Thanks!  -sln
> 
> Acked-by: Shannon Nelson <shannon.nelson@amd.com>

Just in time to still make today's PR ;)

This change looks fine but as a future refactoring perhaps there should
be a wrapper for:

        ionic_dev_teardown(ionic);                                              
        ionic_clear_pci(ionic);                                                 
        ionic_debugfs_del_dev(ionic);

which pairs with ionic_setup() ?

