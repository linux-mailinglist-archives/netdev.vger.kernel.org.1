Return-Path: <netdev+bounces-23331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463F776B930
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040CB1C2087D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9145C1ADE9;
	Tue,  1 Aug 2023 15:56:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D054DC96
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D61C433C7;
	Tue,  1 Aug 2023 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690905406;
	bh=DFsjXNVLkHjDFwEKintpZ37wRLSBecvpAbIibBjOS9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rb4Jew786K6rs+JCpx0uQf8xEXbgQVXIabu3vxcTh3uXx7Nn4Bpx0ihY0qlE51MkJ
	 fhUQinKjjeQkbWrj1fQ744Xky2bCYIUfRxX/sMf1z4c5JGcs9PuP8Vydf88TF0WcDJ
	 pB9L+nuEpYomy/iuOPnNTpySwL5QG3JstA6SdfvR/edVFjfFOPno+GpwxeGNDA9tkN
	 lNE/iZyGOOFfLA0ZJWvpuQDFNs/gC3xJsTwBPf+wMKs7cgSY18yfZhGBHWv1Eri6PU
	 tOFDzzbbsaM+ID6CFHeJX90vjBlJODdz2MzwqN1l20SBxCsLtd9tZ3igLMsuO98xjQ
	 cibsZocCirsyQ==
Date: Tue, 1 Aug 2023 08:56:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 11/11] devlink: extend health reporter dump
 selector by port index
Message-ID: <20230801085644.7be5b2e4@kernel.org>
In-Reply-To: <ZMirCXLlY6H2yVEq@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
	<20230720121829.566974-12-jiri@resnulli.us>
	<20230725114803.78e1ae00@kernel.org>
	<ZMeunKZscNRQTssp@nanopsycho>
	<20230731100632.02c02b76@kernel.org>
	<ZMirCXLlY6H2yVEq@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 08:49:45 +0200 Jiri Pirko wrote:
> >for_each_obj() {
> >	if (obj_dump_filtered(obj, dump_info))  // < run filter
> >		continue;                       // < skip object
> >
> >	dump_one(obj)  
> 
> I don't see how this would help. For example, passing PORT_INDEX, I know
> exactly what object to reach, according to this PORT_INDEX. Why to
> iterate over all of them and try the filter? Does not make sense to me.
> 
> Maybe we are each understanding this feature differently. This is about
> passing keys which index the objects. It is always devlink handle,
> sometimes port index and I see another example in shared buffer index.
> That's about it. Basically user passes partial tuple of indexes.
> Example:
> devlink port show
> the key is: bus_name/dev_name/port_index
> user passes bus_name/dev_name, this is the selector, a partial key.
> 
> The sophisticated filtering is not a focus of this patchset. User can do
> it putting bpf filter on the netlink socket.

Okay, I was trying to be helpful, I don't want to argue for
a particular implementation. IMO what's posted is too ugly
to be merged, please restructure it.

