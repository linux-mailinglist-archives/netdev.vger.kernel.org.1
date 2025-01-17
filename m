Return-Path: <netdev+bounces-159306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F8A15097
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C21188C288
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347A1FF7CF;
	Fri, 17 Jan 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glviQ+as"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37981FF7A4
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120843; cv=none; b=t3CynzbbCmULNK8RSgRPgq9VIJJ6k9U2i+tfhk9JNZcNgCnSmj8dDiYy2K2XjC/biD8Rmb8nvZ/GURom0H7u79FEE54BFJljEKCt/aVH9LjYbwsCuUsGS7X/eb0sBikv6pODaRQfx6KS+ApiFpEjt30on3b4y2I05R5+0NppznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120843; c=relaxed/simple;
	bh=E2b+8btLLhDobB5M+NqzfORkG9yijbiJzyQzAqHxpkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4izk1nae2srWQm12mQSu+drMbJEr4erSN7RIvCACq8Z9Td8MeG5BQvYDUcoSzbdNH1M0hpEWlQiMppdC+wnHxPCk673WAXK5bbnSahdGn8Je3PaBKmcJw93Igab945X+YMmVXEH7VOZydIGkUp8Jsvt3nTbN+OK0mSSwJujTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glviQ+as; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC3FC4CEDD;
	Fri, 17 Jan 2025 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737120843;
	bh=E2b+8btLLhDobB5M+NqzfORkG9yijbiJzyQzAqHxpkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glviQ+asNj29LMw6fy8KCUE/wLCEdWZiQjiXLHlcOqKEkWZ/QNXW76hq8TLMw9/1v
	 Uhs4UF9POLVfvwoIqrBRtIhsl0a6gxCYtUFuKA1kZCo2EoPuTYs1cYK+etbLxv6a92
	 mI/AKLlFiZSr6UWzvPKrD8/yloUEPeBq2CkWZ5WgdX68KJOrx6Ki2qt8sXT9cDa3Su
	 d5ujeSBRVcCpLXSZm1MR4+FcfXXwqF8do+nHyVaBzLXjAYheU6LC4XyWpPNiiUv2D4
	 y3hXjNIu7WWiNEPmNr6lJ8K+ak/SPM1AS+X64l3VtyOJHKbkmoEvI9Gs+eubWKQbil
	 Jr2ZZrSUSPcOQ==
Date: Fri, 17 Jan 2025 13:33:58 +0000
From: Simon Horman <horms@kernel.org>
To: tianx <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v3 02/14] net-next/yunsilicon: Enable CMDQ
Message-ID: <20250117133358.GN6206@kernel.org>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
 <20250115102245.3541496-3-tianx@yunsilicon.com>
 <20250116135559.GB6206@kernel.org>
 <0ed84d3f-9571-4bd9-831e-7aff64de3eb8@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed84d3f-9571-4bd9-831e-7aff64de3eb8@yunsilicon.com>

On Fri, Jan 17, 2025 at 11:42:22AM +0800, tianx wrote:
> On 2025/1/16 21:55, Simon Horman wrote:
> > On Wed, Jan 15, 2025 at 06:22:46PM +0800, Xin Tian wrote:
> >> Enable cmd queue to support driver-firmware communication.
> >> Hardware control will be performed through cmdq mostly.
> >>
> >> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> >> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> >> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> >> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> >> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> > ...
> >
> >> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
> > ...
> >
> >> +static void cmd_work_handler(struct work_struct *work)
> >> +{
> >> +	struct xsc_cmd_work_ent *ent = container_of(work, struct xsc_cmd_work_ent, work);
> >> +	struct xsc_cmd *cmd = ent->cmd;
> >> +	struct xsc_core_device *xdev = container_of(cmd, struct xsc_core_device, cmd);
> >> +	struct xsc_cmd_layout *lay;
> >> +	struct semaphore *sem;
> >> +	unsigned long flags;
> > Hi Xin Tian,
> >
> > Please consider arranging local variables in reverse xmas tree order -
> > longest line to shortest - as is preferred in Networking code.
> > Separating initialisation from declarations as needed.
> >
> > And also, please consider limiting lines to 80 columns wide or less,
> > where it can be achieved without reducing readability. This is also
> > preferred in Networking code.
> >
> > I think that in this case that both could be achieved like this
> > (completely untested):
> >
> > 	struct xsc_cmd_work_ent *ent;
> > 	struct xsc_core_device *xdev;
> > 	struct xsc_cmd_layout *lay;
> > 	struct semaphore *sem;
> > 	struct xsc_cmd *cmd;
> > 	unsigned long flags;
> >
> > 	ent = container_of(work, struct xsc_cmd_work_ent, work);
> > 	cmd = ent->cmd;
> > 	xdev = container_of(cmd, struct xsc_core_device, cmd);
> >
> > With regards to reverse xmas tree ordering, this tool can be useful:
> > https://github.com/ecree-solarflare/xmastree
> >
> > ...
> Thank you for the tool. I will address the same issue across the entire 
> patch set.

Thanks. I forgot to mention that the 80 column preference can
be tested using ./scripts/checkpatch.pl --max-line-length=80

...

