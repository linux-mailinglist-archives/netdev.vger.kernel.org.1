Return-Path: <netdev+bounces-124623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE84496A3DB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2C2281391
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45D188596;
	Tue,  3 Sep 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp6KGnzX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A41DFFC
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379949; cv=none; b=h3s8Ta+wmJtF9hyWwiUsbdVeFkH56BaAUvM4pQBmNdsj9Q6HTGcMt1RlJ5ROTvKxHbbbFC5sbpkLv2RZhP6SRLWsW8Cv2g2WF1dUts4Ah6eNwNgeat8Ba+ne56b/y4hkIWcc7x+0mzLKovSA+I7jeV7kVeqxmkoBMQolGERzHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379949; c=relaxed/simple;
	bh=H1/r0HJ1CHNrtF1HlIipYtqFFTtkeZ8cWi+DFJQePag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xd+bNU7K43YA3HgSZXUnKkthxQovUVsrWDq0+xJzDMv6iDbsZ1YWsozvrj/WzJ1F5wH0w9r9Bl3g7hFa8x2RQgsAFT8BP88LDdNRauNtOSFGQMs3Ie/UE/MjzEebj8bRIDR6eg6WBUOupPPLX8S9LuK6DUL6foeDODBoxA2iMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp6KGnzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F855C4CEC4;
	Tue,  3 Sep 2024 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725379948;
	bh=H1/r0HJ1CHNrtF1HlIipYtqFFTtkeZ8cWi+DFJQePag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gp6KGnzXRltO8y/jz28T1NNf4Rx5ic2JDbW7+sZ+G6oiDM/DeB9/Y2OEg5S1RrLwT
	 1g/Tgv0q6CA1ulRtZUhPUs6TzBc0maqDRn2Hvl9+FeMMTyZxec3YJStjEVXajswDzW
	 hcW6hdCACRKAhRdbOzhSXIytLfUSL1YCkcrqjMjLCXviJmRq9aSDaD1xDVBCfuMIqJ
	 hdxSVEuokN3aNNBQ7aSV+qoocEza2uM5Gr4Sq9CQtRgeMX0fFeSVRkbO65GczdQPK3
	 zm1WnDT9Q6B7UIn+LXE6Gf/YWVxQzJ9gC/Ql25eOmaJTvLB/ZLQi0r8k4UTcWlXrzt
	 oIMD439ca7Sow==
Date: Tue, 3 Sep 2024 09:12:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <christophe.jaillet@wanadoo.fr>, <horms@kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH -next] netlink: Use the BITS_PER_LONG macro
Message-ID: <20240903091227.75269a25@kernel.org>
In-Reply-To: <d20a0971-a03b-ce24-1111-ca06de234cd6@huawei.com>
References: <20240902111052.2686366-1-ruanjinjie@huawei.com>
	<20240902183944.6779c0a5@kernel.org>
	<d20a0971-a03b-ce24-1111-ca06de234cd6@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 10:06:02 +0800 Jinjie Ruan wrote:
> > Does coccicheck catch such cases?  
> 
> Yes

which script?

