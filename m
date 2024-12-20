Return-Path: <netdev+bounces-153805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B75FC9F9B51
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5111886CB4
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4D1F7546;
	Fri, 20 Dec 2024 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVDYPawX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22D13635B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728619; cv=none; b=rMNTdGm0vVqyS/IknX0mAgakSsg0T31+MR/qPllHUXw5IdPQFDgLDFLl1x0L67RorGEcYT6pdH9GcAG1ROSg5FJ8u3lghmkbrirqb7ao9ywTS9ovTa4TYQc5LR+Ud90ES9qJAJYB+YfZzIf8Y1xCuKOB0jrt9XohAfNf+1WaSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728619; c=relaxed/simple;
	bh=Pyv4cAlOfM1+yzVuGxoCfbowUp7CPtFB4Egd8Ne6+6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJfJKFW8HUACYJgWki58ySnH/x2yHISbkX1RH+I7RwdLDx200rp/HbNZFWdMqma+JaCsPriQ9uplwpOXFvO3+7LD3QSS44YYQ5JxiQCjAILq7MjnSSJ+3FrtXx0CPCbA9Rc3hs7DnFmHQcj/EHHLhHd29ip65fNRssv/z2vUC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVDYPawX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC8EC4CECD;
	Fri, 20 Dec 2024 21:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734728619;
	bh=Pyv4cAlOfM1+yzVuGxoCfbowUp7CPtFB4Egd8Ne6+6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lVDYPawXXMTXvlXdLAOzYhhmDhsxhCSEBl7jmXcr1ydRBSg1iBAOu0n7G5VxsLt75
	 BTqIaZTBWJk38E2JeGRTHKKkS39lZme/hq3A1+upW0DG8tOU7HivPrQGVxd8tQl1yD
	 7iEi3qFIIr8uY3PtrzFKDABLyDkzHxcXQ2iO9XSZv3XXSaB47KOcJyN0eiwqSa16DF
	 lzOGKiUco3TbPJqPMYWbTZj8y+noCHBzOjnjd5fdhUjxwgRqi6OnMfA6pnURl5EkzU
	 g+g+ZVUF6cDmQLlvxrVXEiauJH/GY0sqTnLzPvTmqx3cC8nQyMsM0VfL4EgeQpOiPP
	 9GSTlBHnkmlpg==
Date: Fri, 20 Dec 2024 13:03:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH net-next] eth: fbnic: fix csr boundary for RPM RAM
 section
Message-ID: <20241220130338.7c8aca32@kernel.org>
In-Reply-To: <2a375625-5016-4f4a-a5fa-5a73dc536651@lunn.ch>
References: <20241218232614.439329-1-mohsin.bashr@gmail.com>
	<2a375625-5016-4f4a-a5fa-5a73dc536651@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 09:25:41 +0100 Andrew Lunn wrote:
> On Wed, Dec 18, 2024 at 03:25:58PM -0800, Mohsin Bashir wrote:
> > The CSR dump support leverages the FBNIC_BOUNDS macro, which pads the end
> > condition for each section by adding an offset of 1. However, the RPC RAM
> > section, which is dumped differently from other sections, does not rely
> > on this macro and instead directly uses end boundary address. Hence,
> > subtracting 1 from the end address results in skipping a register.  
> 
> Maybe it would be better to actually use FBNIC_BOUNDS macro, to make
> it the same as all the others, and so avoid errors like this because
> it is special?

That may require changing the format / contents of the dump a bit
to include unimplemented registers (which would read as ff).
Note that the subject is incorrect, the patch is for net, 
so the one-liner fix is more appealing at this stage.
But I may be biased...

