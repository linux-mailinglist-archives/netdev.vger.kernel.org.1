Return-Path: <netdev+bounces-188516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70ACAAD280
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4671E4A22A2
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DF12E40B;
	Wed,  7 May 2025 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ0ETFEs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50556C2FA
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579992; cv=none; b=UXUACrS4RE33GiwsQzWfLJmo8D5ZN2w6EiqWqp6RU73LEtG/yRIAlC0KHnhssMHkGOqIEyGojNhGPtHTN0a83DyuRhQuEWe2GMbDDYucWSLz17qT9k8iY76ckIqSWbWGw4Lt3l9HDuNoUoYnkrQs0OaYZEEnYfP8O0UYDuGF+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579992; c=relaxed/simple;
	bh=25/lDCD1q3MaLhKl/A8laqVqAtpJygRUmIdrUHrlilU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7wAXFCntgicRkpRZ+E3T+7BAzKFAi1ntNxaL43citjm0xsWd110ta6cnHLFNFkQAtCC8EkilcnmpNW2ekC4NXTI/y2QfVmWOeAr+PtKNh0HFSavcLTvlIvTDbDN+q2GmCQQRTVd8V8jz+r8523djsuAYzNL5zNP3IGP+z3FB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ0ETFEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55371C4CEE4;
	Wed,  7 May 2025 01:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746579991;
	bh=25/lDCD1q3MaLhKl/A8laqVqAtpJygRUmIdrUHrlilU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQ0ETFEsnevXw296TS5rtrZ1QAeOzvFl0rptdSvzb2HeJ2FcsRbirO1Yl8FYf5+WW
	 NYK9/9o2sFt4Cj1cG1gD7eTSK6S8RYeoQcsEVy5+sfzOS8IcFLEbpMMG55u02y9IV9
	 gY0Andg8N48kbtuz/Rb5VWlXL27493APDJMPCB1ZDjV+i+kSaNZMsWl9CgpladqsNv
	 wkl0CU8gTbw4l8KGRE2iuZaKsbVKpec8J7RdKq/noIYqXtZ3v/rVQWWtV6+zdnNYcN
	 wzYDJ2vaS9EFP1ZrJbcY3eWnuIxD3d/ImI9tAHdzAzpuRpyQtK4KX4P9ES/8ON2TRi
	 yl75oMxL7ZUqQ==
Date: Tue, 6 May 2025 18:06:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com,
 syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: mctp: Don't access ifa_index when missing
Message-ID: <20250506180630.148c6ada@kernel.org>
In-Reply-To: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
References: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 May 2025 17:05:12 +0800 Matt Johnston wrote:
> +		/* Userspace programs providing AF_MCTP must be expecting ifa_index filter
> +		 * behaviour, as will those setting strict_check.
> +		 */
> +		if (hdr->ifa_family == AF_MCTP || cb->strict_check)
> +			ifindex = hdr->ifa_index;

The use of cb->strict_check is a bit strange here. I could be wrong but
I though cb->strict_check should only impact validation. Not be used
for changing behavior.

If you have a reason to believe all user space passes a valid header -
how about we just return an error if message is too short?
IPv4 and IPv6 seem to return an error if message is short and
cb->strict_check, so they are more strict. MCTP doesn't have a ton of
legacy user space, we don't have to be lenient at all. My intuition
would be to always act like IP acts under cb->strict_check

