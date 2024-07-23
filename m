Return-Path: <netdev+bounces-112487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E999397A9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 02:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647E8B21616
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 00:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D86131BAF;
	Tue, 23 Jul 2024 00:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwAQmRit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670832C8B
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 00:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695943; cv=none; b=Nc5z53GuNgj4t/0Mcv3txZHMOZTLW43/6DfAVqzSAugvkm2lLWSfIvL3w40ogX0ky2UfaFENhKc34jvaRjN/jgasd1W5pg9w2UyjQJWSy/2awQw5Hejaapw0fLdpGbLAdp4ETyrkthTMTiHhfM4dOPnrTFlxByJ990Ctdh8rGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695943; c=relaxed/simple;
	bh=EyX0WjxMHLfkomQAs0X4B56In/LxcK3sRmcJj7lxpdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4RjhVhylqq0c1xQQTgKrwsFKTGRpADBsSngdM3KBsBIE2juvI+EIvtL6VTkdrZRJXtBMN3+S52Hi8JmTX/5kX7OJ/clRObHlPOuHjsmYW/0npvGj7cIkwORPqW3i1ZLb4arD4rLL53rlYikwdJoE8FfKmbwj0TdUvDMUSXQNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwAQmRit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA9C116B1;
	Tue, 23 Jul 2024 00:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721695943;
	bh=EyX0WjxMHLfkomQAs0X4B56In/LxcK3sRmcJj7lxpdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WwAQmRit1iH/1oefQ5+7tKhZsAw6zQmrUGJeE4sigm/uK9mdaop4yE9H+hdP5S6rn
	 NpxekfxxDPJlupliwDPfuvYMi7OS2bNaIuGIaWYLj8f/JH8hEJdXJAF+VI2vog6Wse
	 7v1v++zkVhngQnuox7fzDvAX5BrTUq3E5CFCHM/AZbaRXzqoW24XD86HRRpXoeYs/+
	 CrFdweFOydaPfsxG+wFa4iS0B2eMu9OgMgFJY+ym6EHM3kAbC5uOtzx87DG0effkUq
	 qHtsP76enVFSXpCIw2SnKHdKjnJLxT6ehK6ZP1nr4bTO1QY3wprZnaPc/Wa0wf+5yv
	 uE60UuATzdKbQ==
Date: Mon, 22 Jul 2024 17:52:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, passt-dev@passt.top,
 sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, edumazet@google.com
Subject: Re: [net] tcp: add SO_PEEK_OFF socket option tor TCPv6
Message-ID: <20240722175222.4be6eb3d@kernel.org>
In-Reply-To: <20240720140914.2772902-1-jmaloy@redhat.com>
References: <20240720140914.2772902-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jul 2024 10:09:14 -0400 jmaloy@redhat.com wrote:
> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> 
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Please repost with the selftest and the empty line between Fixes and
S-o-b removed.
-- 
pw-bot: cr

