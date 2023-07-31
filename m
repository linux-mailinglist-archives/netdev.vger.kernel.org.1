Return-Path: <netdev+bounces-22901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BE769E61
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5092816CE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67F1D2ED;
	Mon, 31 Jul 2023 17:06:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69118C3E
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 17:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C62C433C7;
	Mon, 31 Jul 2023 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690823193;
	bh=K65KHyK9F8khoYI+m0aZ6H6RAm7BXl0DtgeC8D5wmCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KFBiiYfQolCzBpcPgnAIdn1Ooh+0dF2OvmPaju8cS+n5Cw/A3WdOvWcGk/iDtJzii
	 P909d49g0RA7AjzmC4COF8tZ/1YDxV6QjRFGnPdzfjseuG51pMG7d6Gtj1z8YyvYnc
	 etcDL8KneAkLNPUjZeQIsGh8KpJ2ssJF93SRSyzymeyHDkLzllHYAh3mnyciwgz/pT
	 SY63S0H4rAfRZnauu0kwV4HjhYn7isnVxGYgjlkSMQm7+cc/D0H6o7LNLNfQnWlfa+
	 1DjmvW0IOUO65EcvlG8D9FLyIcjgFm/NVEAfxYsDmk8KsmAnx1nQTcWzIdRSLJzc3G
	 oCvz2JOTsJCUw==
Date: Mon, 31 Jul 2023 10:06:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 11/11] devlink: extend health reporter dump
 selector by port index
Message-ID: <20230731100632.02c02b76@kernel.org>
In-Reply-To: <ZMeunKZscNRQTssp@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
	<20230720121829.566974-12-jiri@resnulli.us>
	<20230725114803.78e1ae00@kernel.org>
	<ZMeunKZscNRQTssp@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 14:52:44 +0200 Jiri Pirko wrote:
> >This patch is not very clean. IMHO implementing the filters by skipping
> >is not going to scale to reasonably complex filters. Isn't it better to  
> 
> I'm not sure what do you mean by skipping? There is not skipping. In
> case PORT_INDEX is passed in the selector, only that specific port is
> processed. No scale issues I see. Am I missing something?
> 
> 
> >add a .filter callback which will look at the about-to-be-dumped object
> >and return true/false on whether it should be dumped?  
> 
> No, that would not scale. Passing the selector attrs to the dump
> callback it better, as the dump callback according to the attrs can
> reach only what is needed, knowing the internals. But perhaps I don't
> understand correctly your suggestion.

for_each_obj() {
	if (obj_dump_filtered(obj, dump_info))  // < run filter
		continue;                       // < skip object

	dump_one(obj)
}

