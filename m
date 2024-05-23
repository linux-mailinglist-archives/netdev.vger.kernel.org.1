Return-Path: <netdev+bounces-97785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553F8CD2DE
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE40B1F2131B
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8514A0AB;
	Thu, 23 May 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBoelqo2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841C8174C;
	Thu, 23 May 2024 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468954; cv=none; b=Y+ijDVZqLMw5Q7proWnqw006uxXzLArerjz5eI+S6tQzW7eM20uv09a0r+dZBOXDEBxlFycww7ULId/jcBaaSZPUt7Vlcv90m4wj3AXGSuR0W3TJGBkzbOvhM6FXDp5sUiKFRWLIoxhi0ffO1ZXZQDdJaConosztsAZrdsvP0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468954; c=relaxed/simple;
	bh=lZWCDNLYdh3G7nFtzihodDsqvt7voL9bMlCo0OYVZFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfXylvGCh+bsOG7ZVWGBhxxUHr3acAkIt+XpKJamQr6fBRr1fJTI6fL2zkNYO7+VzshI1YI1VPGObGzPOu7QyLsXvAMFGDbrALliPIJ9OuZeZZcoW/C7aNAt4h5yNDKNg56tfQVVAxGkny2e/KnzuMFGiuPa+dt8/OI1nblPOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBoelqo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E257C2BD10;
	Thu, 23 May 2024 12:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716468953;
	bh=lZWCDNLYdh3G7nFtzihodDsqvt7voL9bMlCo0OYVZFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBoelqo2F9lLszwI4GhC1WFQ9QqyxA3cwVF7viiB0crQWhNITasNNPo7vMZiaCvdo
	 oZ9te/h4q6n2Vstmr73apygmKDo20pvnOu94o95UuzGxgzuvg7oxWXS2BC0ugcK3oG
	 KmZkfG7+UO2Fz+aAFWdpuaIvXc1S4HWj5pV/TNSz7qBagioDvOl/64D6I7a8RtyyMU
	 Q42tLqzKF9CmvM8XjkIxw0meTPIOgCmF/oIFJii+5DlDrHsp3x+6x2sb6Hbw/1y/QD
	 npiK30rk6isdOmP15+O2+pyL7gBHDkI0aCXwzRcGW3uY2/U9MVvHaoMgF+9dBADeMI
	 mRNvvntnQai+Q==
Date: Thu, 23 May 2024 13:55:49 +0100
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	larysa.zaremba@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] ila: avoid genlmsg_reply when not ila_map
 found
Message-ID: <20240523125549.GM883722@kernel.org>
References: <20240522031537.51741-1-linma@zju.edu.cn>
 <20240522170302.GA883722@kernel.org>
 <44456b54.180f2.18fa31eca2b.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44456b54.180f2.18fa31eca2b.Coremail.linma@zju.edu.cn>

On Thu, May 23, 2024 at 09:44:15AM +0800, Lin Ma wrote:
> Hi Simon.
> 
> > 
> > Hi Lin Ma,
> > 
> > The lines immediately above those covered by this patch are as follows:
> > 
> > 	ret = -ESRCH;
> > 	ila = ila_lookup_by_params(&xp, ilan);
> > 	if (ila) {
> > 		ret = ila_dump_info(ila,
> > 
> > > @@ -483,6 +483,8 @@ int ila_xlat_nl_cmd_get_mapping(struct sk_buff *skb, struct genl_info *info)
> > >  				    info->snd_portid,
> > >  				    info->snd_seq, 0, msg,
> > >  				    info->genlhdr->cmd);
> > > +	} else {
> > > +		ret = -EINVAL;
> > >  	}
> > >  
> > >  	rcu_read_unlock();
> > 
> > And the lines following, up to the end of the function, are:
> > 
> > 	if (ret < 0)
> > 		goto out_free;
> > 
> > 	return genlmsg_reply(msg, info);
> > 
> > out_free:
> > 	nlmsg_free(msg);
> > 	return ret;
> > 
> > By my reading, without your patch, if ila is not found (NULL)
> > then ret will be -ESRCH, and genlmsg_reply will not be called.
> > 
> > I feel that I am missing something here.
> 
> Oh my bad, it seems this bug was already fixed by the
> commit 693aa2c0d9b6 ("ila: do not generate empty messages
> in ila_xlat_nl_cmd_get_mapping()") last year.
> And my dated kernel does not apply that one.
> 
> Thanks for reminding me of this false alarm.

Thanks for checking.
I think we can retire this patch.

