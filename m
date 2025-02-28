Return-Path: <netdev+bounces-170492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEA1A48DEF
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064183ABF49
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063822097;
	Fri, 28 Feb 2025 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf0Czs6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEFF182D0
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706047; cv=none; b=coL+hJEis4m26IpGGgtMxQIIwoC/l39vdPX4/NwEUXa3kUVPSOlWkrcxsJxQLvUa0ZYntCC9fRLERwWxYhcgJVec7dWVLB/LCFfXLIjCvfb7IZumNr8btK13lno6GyJWaGoTqyfRnu/TAiPrsB2Fu/t7B5TWwFhI4dXFZx3kkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706047; c=relaxed/simple;
	bh=LyfnNZuFL7X8hd1Y9mnhQZaqPmLCo3wd2Jx63TFRQuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgFhWCRJqawCTA2aC/Mnu3uJe+7XOCdDb0FkGUp9hi8+ATrR2Mzppap/ULucjLynFoSn2+ZcHutokfp6KNkO3Ef5iS83c5Qye25H4q3HrBVg+EzgOoPPbH8Ektve7ppisg5EVur9u7oFQBY1Xl87EIG1yUqEqUXRlstXCMeIqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf0Czs6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4457CC4CEDD;
	Fri, 28 Feb 2025 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740706046;
	bh=LyfnNZuFL7X8hd1Y9mnhQZaqPmLCo3wd2Jx63TFRQuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pf0Czs6b1aQjRpF1L5pbem6I3SOHDPsNm4dnkG3NmkXE0YRkjcI4VPWOqxELQ9WhU
	 4NJvAiEibQNUmb0FKjVhTDRiCdQjOUmKIuNHo3kXqCtgj+ByUX5Nl68cy2D1yLEDaV
	 TUuCpkDMHxSqk7qIZli1ib5H4itxUTh7Q+TCLbJOkqD+nKhux1+fx8FlOvH8506KtU
	 25VwbeVgh9izz0n3WBbvFCi4CYmR83zC08A6+KHDo6PV9/Bfzm/c9M2M52gEE8NDIL
	 9N6ql4IuesicF0Ya7QQ20m5ooxxjGA6n4L75mIhQbwHcPeGTT+WkWKw0dUs+ZpBXM6
	 LfdqajwXQy15A==
Date: Thu, 27 Feb 2025 17:27:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>, David Wei
 <dw@davidwei.uk>
Subject: Re: [PATCH net-next v8 00/12] net: Hold netdev instance lock during
 ndo operations
Message-ID: <20250227172725.4312334e@kernel.org>
In-Reply-To: <20250226211108.387727-1-sdf@fomichev.me>
References: <20250226211108.387727-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 13:10:56 -0800 Stanislav Fomichev wrote:
> As the gradual purging of rtnl continues, start grabbing netdev
> instance lock in more places so we can get to the state where
> most paths are working without rtnl. Start with requiring the
> drivers that use shaper api (and later queue mgmt api) to work
> with both rtnl and netdev instance lock. Eventually we might
> attempt to drop rtnl. This mostly affects iavf, gve, bnxt and
> netdev sim (as the drivers that implement shaper/queue mgmt)
> so those drivers are converted in the process.

Needs rebase after Ahmed's changes and the net merge
-- 
pw-bot: cr

