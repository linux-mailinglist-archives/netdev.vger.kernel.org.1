Return-Path: <netdev+bounces-238181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA33DC556B4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8135D3A8379
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3722DA756;
	Thu, 13 Nov 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU9S3G0S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B892C181;
	Thu, 13 Nov 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000342; cv=none; b=ZDIpEHUpMTbAUnr3PkO14mR228DPF0LEK/unTxQUL5jH9PKTV0zUqh1f0hBQFlxtgD4CV39WbRr37ftJK4s6BI/JBsyUlEigZADYFEfOXZE1S3wWyHsVy1PkKEHxu2LaHawxpaFjzXM+6Qp7JaA3ZMCNeBbVS0JFkYEDxb9u1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000342; c=relaxed/simple;
	bh=msztFxay1oMVA/+ICSOB8YjjJ+xlYUvgd9APiNUfgyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EM1W0FaDodO5ormZdcDlkRfFs/4pGxkw6ZUGTPxHMpsGveLve+MQ86QM4HnhJfjKjr2oe3WsnDzE9j+AATZGHsWGQutwSYk9bZzSQ2i6K7tSbCJxQ1P3R590d19EijSfRMi2s2deGUhf1++Y8rJEfbgqENROq079urNQt9992ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU9S3G0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6DFC4CEF5;
	Thu, 13 Nov 2025 02:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763000342;
	bh=msztFxay1oMVA/+ICSOB8YjjJ+xlYUvgd9APiNUfgyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uU9S3G0SwkTw4XJ4jjDr5fc91SDYZDo8teQl2YKnFSdKASFAZReqlSHagnINZYsSk
	 kGYtEopSCK4+RSkOq6yXF71NAYMyJpPGyNGU9KWdwz9KdwyoNw1hz4Dol4+JYxSnkQ
	 AFt/Ofu3vPqve+YWcxZAei2SGqhScaAiJgaZZdfBE3qvy/BwkEzv6hbT+RCIgYH4t7
	 Wr9sDekdEI8zmPuql+92RG8kHEuucMaLCYZBta/ZExL+t9sixrkfk0ti9D/HVUNIKw
	 rCMgOC/51WMRl5p8wSci+MD+CL0eMB7qkpH0ThpOYwv7h40FJyeOiD37Nvvw0ro4uK
	 2T/D0u/T5WYAw==
Date: Wed, 12 Nov 2025 18:19:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Antoine
 Tenart <atenart@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Yajun
 Deng <yajun.deng@linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net: ethernet: Allow disabling pause on
 panic
Message-ID: <20251112181900.56e3ce27@kernel.org>
In-Reply-To: <9109c963-4544-4c4b-8d75-3293d8173cd5@broadcom.com>
References: <20251107002510.1678369-1-florian.fainelli@broadcom.com>
	<20251107002510.1678369-2-florian.fainelli@broadcom.com>
	<20251110171036.733aa203@kernel.org>
	<9109c963-4544-4c4b-8d75-3293d8173cd5@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 14:53:51 -0800 Florian Fainelli wrote:
> > please no sysfs for something as niche as this feature  
> 
> Would you prefer ethtool in that case?

Yes, no strong preference where exactly but somewhere within ethtool
would be better.

