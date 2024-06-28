Return-Path: <netdev+bounces-107812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AA491C6E0
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66BC1C20DCC
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821077581A;
	Fri, 28 Jun 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA0mo0s1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E744757FD
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604467; cv=none; b=cg3FbFfCnNw959wuOhIpHDsT6vPxwn+gILXzU9wgCInBBIs9dG3PZWC+sfZ8tCY0Z6BKuWqLBjrbtntj7Doa22BrGUMC2ZO4XEtqWbXhT1FgR/Z/5GuWBC1/SXQ78qzjBNhmv4xPogapVWIVSdJCZk5f0kdgMB971sBVFs5QyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604467; c=relaxed/simple;
	bh=CCQKhNS4RG8lFZ+aKfLGr3JR+MusSNRT/qf2VcXO3gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpHjvTKEvy633KXXKZF6cmWs05dhNXJR5ku34wkOPzw4QPUPzaOI8wduQzkBcBIEkCUWX6ckzy2D+ldbVGy8RmWnSuoEPLVhTGvutJmCs9JwElGJk2/fNpztjGsWrzoYh/aW5b/RNr2fEiTMAZyCad774rk/DR/wDwPKEyE6Ow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA0mo0s1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34039C116B1;
	Fri, 28 Jun 2024 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719604467;
	bh=CCQKhNS4RG8lFZ+aKfLGr3JR+MusSNRT/qf2VcXO3gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BA0mo0s15wveWcilsf8OWeFOZycwawH3wzi3YQWuI4+JL2TpIe5X0OvoioXFEU1H8
	 PGO9eHC7P+JgiMT5zg9B/cN6OdqWR1FxedCBDsU8Epav/QCwSlSx5ChohVf4l8KWMu
	 Wb6DuuxvayLnXVBA30jrnkCrk+ym/OKBVijncQzhPWit/qpNko2FrSVLgYYBS+kNee
	 DYMsHz+0V8QijHLyFp+wJgbW4EoiNYh8RtFVaaGcsJcV3YFMdY7qcAJTMEg0NAYXsn
	 /VPFaccPKzgRDHCcoacGE1kaTS17JiwNinEFAFrPn7vC4W98wBPTLDo+//MisAOO9G
	 75nugZOmo3gHQ==
Date: Fri, 28 Jun 2024 20:54:23 +0100
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jiri Pirko <jiri@resnulli.us>,
	syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
Subject: Re: [PATCH RESEND net-next] net: ethtool: Fix the panic caused by
 dev being null when dumping coalesce
Message-ID: <20240628195423.GI837606@kernel.org>
References: <20240628044018.73885-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628044018.73885-1-hengqi@linux.alibaba.com>

On Fri, Jun 28, 2024 at 12:40:18PM +0800, Heng Qi wrote:
> syzbot reported a general protection fault caused by a null pointer
> dereference in coalesce_fill_reply(). The issue occurs when req_base->dev
> is null, leading to an invalid memory access.
> 
> This panic occurs if dumping coalesce when no device name is specified.
> 
> Fixes: f750dfe825b9 ("ethtool: provide customized dim profile management")
> Reported-by: syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e77327e34cdc8c36b7d3
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> This fix patch is re-sent to next branch instead of net branch
> because the target commit is in the next branch.

Reviewed-by: Simon Horman <horms@kernel.org>


