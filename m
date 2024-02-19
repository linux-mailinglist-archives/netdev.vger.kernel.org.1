Return-Path: <netdev+bounces-72937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CAE85A3F3
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 13:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32541C21478
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F6C3218B;
	Mon, 19 Feb 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca0qRuxR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E340F31A9D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347369; cv=none; b=mzCgXnQOAPzu4vaEve8YqmC0TtRm3XjtTpSMh+ThztroioIr8VH1swIbBll8IrfDXSIlR+7XQVdxO+JgdWlyfRVbPGVgktMTqL20lUz+QhRrl616us+b+0vfyMyNmly8MnhJkTg9frbRraxGtENKqxA4zarK01v+1k1tNJRJ0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347369; c=relaxed/simple;
	bh=H2Aqh6odAsqKQXp5/rh/QR786iepyzHrG6Z5hFqfLqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgSgui3JO7UckPwU5D9a2NK7XQvfLgImYWt3/kFUSAejHn6ksyfQJCPm4jFwUrs/xpae0NoxNlL07O1Z1BoelVZHcqrTrC8yW//MJ58P3fzA+xf8YWOeTPyyPDcurNtRrFd3m7/IOS5E2SooNlXwlkbpboBhkMWA5A/TaZmdrNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca0qRuxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1411C43390;
	Mon, 19 Feb 2024 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708347368;
	bh=H2Aqh6odAsqKQXp5/rh/QR786iepyzHrG6Z5hFqfLqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ca0qRuxRUsnvkr95YveCHh1NvRqe0UvuvdcnZM9ZRra/Eh9zbLvNMLSynCC+NfPX0
	 rlh6sKdbIErU1mRr78AS7Qn55IVFiFEOJibAFQElcArL+FQkoHgD6uIC8Xt2nR51Dv
	 oKBhnBRU0BPbu1oPJ0vIG1h8mu0M74lO9Nn4/G3xMWr3QQ21AkP8qqLFjYBfaUr6bu
	 wT6iPazvIePXtSzQWb7A/Q8ruAr5UM2Lwg6VWcuBikk7oIjrylFmfiA6mrWrsaSFvZ
	 08C5G6n22+XasZF36pvnmrfcUvDDbJAMM2IVEPeKoXAGqyo6JecSTH15ftG6KQJ3Cp
	 GIdOo+Xt17vMA==
Date: Mon, 19 Feb 2024 12:56:05 +0000
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC] netlink: check for NULL attribute in
 nla_parse_nested_deprecated
Message-ID: <20240219125605.GA40273@kernel.org>
References: <20240216015257.10020-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216015257.10020-1-stephen@networkplumber.org>

On Thu, Feb 15, 2024 at 05:52:48PM -0800, Stephen Hemminger wrote:
> Lots of code in network schedulers has the pattern:
> 	if (!nla) {
> 		NL_SET_ERR_MSG_MOD(extack, "missing attributes");
> 		return -EINVAL;
> 	}
> 
> 	err = nla_parse_nested_deprecated(tb, TCA_CSUM_MAX, nla, csum_policy,
> 					  NULL);
> 	if (err < 0)
> 		return err;
> 
> The check for nla being NULL can be moved into nla_parse_nested_deprecated().
> Which simplifies lots of places.
> 
> This is safer and won't break other places since:
> 	err = nla_parse_nested_deprecated(tb, TCA_XXXX, NULL, some_policy, NULL);
> would have crashed kernel because nla_parse_deprecated derefences the nla
> argument before calling __nla_parse.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Hi Stephen,

this seems like a good approach to me.
Would you also plan to update the schedules at some point?

