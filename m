Return-Path: <netdev+bounces-81076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1685F885ADC
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C602D2844E3
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D605185C5E;
	Thu, 21 Mar 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InpN5d4J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C284A50
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031448; cv=none; b=k+H3u+zkDmHYhqTw63dC0ZWudwT7PmUH1KfvNRKa3NnyO9SriB3Af2gVtvEx3GutgnY2WCWv0AcxY0iK8GXb4AnVKCErXbedRyJ9TANf7YEDIYdM0bj5M2V7ep0tUa3tcFZMZpgZLOE0l1sbiJciPTei7yXoWcPV4AqZ5BYMcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031448; c=relaxed/simple;
	bh=pQtjH+pTMInREJIjM32PY8nkyllfkOtwzCUnNyEAvoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDXtVLtaSwPZPKu9zm/s8Bh+MadzXMe+ESi+Bn6L358X/Om/xGeMUjho0esd99Y4gglss2TxlbjhLzjwvhjZRD6ybWdRTTmgMs4UdvmUuboyUmMqNI6F1priv5xf6li8MIjVXipHLS4Q+wBGy0enLu7iRVjLtIXZi9aG2VmGA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InpN5d4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87FCC433C7;
	Thu, 21 Mar 2024 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711031448;
	bh=pQtjH+pTMInREJIjM32PY8nkyllfkOtwzCUnNyEAvoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=InpN5d4JGUiZDotzf/3UiUg25jT0g1aLzvjeSWkcbHStOkF0syLA4mMJwQ+zz0vbb
	 BiqyZUe73eIbCJ5857ji0WVJjnaNMNDyaiuuIWzDVXL0RIqKANhMglLdOh9ucImZwQ
	 MIJQfa0LvodFBNt9t2bx+wzS1cshoWiU+Yt8geT+9qwjeJntPwmgdLWafwIOZuGGSL
	 oYtDVRMQ9F6dCahnrvTRhh3j1Fdx5AH8SZ71OWJ2DmQOlPAorTw4u8IyvfOdm29FCe
	 4BC6IEz3/Fg3N+2TTxM7AFPd4nPLd0qJWMLoCzWfznzFliRUhhXr683lfAeSA4JDUy
	 S9YI26LWhrBFw==
Date: Thu, 21 Mar 2024 07:30:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: renmingshuai <renmingshuai@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <idosch@nvidia.com>, <netdev@vger.kernel.org>, <yanan@huawei.com>,
 <chenzhen126@huawei.com>, <liaichun@huawei.com>
Subject: Re: [PATCH] net/netlink: how to deal with the problem of exceeding
 the maximum reach of nlattr's nla_len
Message-ID: <20240321073045.3ee6127d@kernel.org>
In-Reply-To: <20240321141400.38639-1-renmingshuai@huawei.com>
References: <20240321141400.38639-1-renmingshuai@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 22:14:00 +0800 renmingshuai wrote:
> RTM_GETLINK for greater than about 220 VFs truncates IFLA_VFINFO_LIST
> due to the maximum reach of nlattr's nla_len being exceeded. As a result,
> the value of nla_len overflows in nla_nest_end(). According to [1],
> changing the type of nla_len is not possible, but how can we deal with this
> overflow problem? The nla_len is constantly set to the
> maximum value when it overflows? Or some better ways?

It's a known limitation of the legacy SRIOV VF API.
Use switchdev mode instead, please.

