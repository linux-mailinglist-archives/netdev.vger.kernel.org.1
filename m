Return-Path: <netdev+bounces-127974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488DC9775B6
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 01:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0A01C242D9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866C71C2DD9;
	Thu, 12 Sep 2024 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSZ7rY2+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8118891D;
	Thu, 12 Sep 2024 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726184753; cv=none; b=ntW7pl3OzQXE6XeweO0rpiSxZ87w2hkMu53td3SjlC0bmWqJhzMLhT8pD9KN9Ub3O/fT+yaZfmrUvhKJ2NMTr91KU1KZCBl0GpMhHrG8XT8Bjq+WjCTr6XEJSA5aV1PaQertl+4S1UfdghsE3VDrN39aNtgSARO/EEJj0Kb/xgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726184753; c=relaxed/simple;
	bh=Uq0kkQVqpccg0BdoOMB4WvgRs+396QtDG1vIiaA8lb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxvYekMPJBF6v8kANUniE5EnZckzTngaZSHdmJegQVapmjXXtPMGVtzWP3SWZMsgZb6BBviKlIwKwgz5T9bUAMrSnnorJ2WZKiPM+1OcDKFCnr2vZpEDEz4F5KvxnloAhlVk28cQ8+9IqudpVedYaAWajbRWVSoRSB2Jf35Hyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSZ7rY2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CC9C4CEC3;
	Thu, 12 Sep 2024 23:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726184753;
	bh=Uq0kkQVqpccg0BdoOMB4WvgRs+396QtDG1vIiaA8lb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OSZ7rY2+aXDt0vXwwWW9KJ090mwIUS+k8dK1uwVNtg6gsF+oaO9ZLrknjSSvMxiK2
	 u+c0i64QPr3e3+0gws872UINBWAnQ5My7OQnvf/3ueI6AtBmoygbxTAUekMEyntUgV
	 tUrI4leOZXZ3F512NxH3K63TuIftPrFvq1gvcP6ERhQKy7/g7VY/E6qTz/xqOZ22w6
	 kwFDlvVWkzOFR4pbpJx2BOJOToav1wOxC21H6CB9l3SDS3pb8WVtADzeOWy9yv/2r/
	 xaoQBYzPoD1uaAaozdjl2NvQrf3T7AvAmUunStwGPsl+1V7FkeJFGXr6fywcimxJd+
	 ufq63ojEpyb+A==
Date: Thu, 12 Sep 2024 16:45:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ethtool: rss: fix rss key initialization
 warning
Message-ID: <20240912164551.3ce5b1a8@kernel.org>
In-Reply-To: <20240912230531.3116582-1-daniel.zahka@gmail.com>
References: <20240912230531.3116582-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 16:05:30 -0700 Daniel Zahka wrote:
> -			WARN_ON_ONCE(!ret && !rxfh_dev.key &&
> +			WARN_ON_ONCE(!ret && !rxfh_dev.key && ops->rxfh_per_ctx_key &&

wrap at 80 chars, please, make sure you read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
before sending v2
-- 
pw-bot: cr

