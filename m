Return-Path: <netdev+bounces-248343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1356BD0715F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 05:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 647303008F2A
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 04:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD092D12ED;
	Fri,  9 Jan 2026 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHnOMJnX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7027E1C5
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931974; cv=none; b=iDgiSMg5bzQdpIcohPTY0KlMtPeHteu4WZQD3I++XjJcw5QqLe7M+EXs/NPH6nBeqG7Jd2nRAWSLnEG50uHXIGWBrmEH0DGxsMA7Nju+6ho4JTyzvOcck7NxgYArh+DfIa6PGY8sUJ2j4Ien5q5C0CM7eolbUwrWYPKgAuDP124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931974; c=relaxed/simple;
	bh=RECAF4SNoLMHSd5KswFR7D6GpQrzkfxbfSOcD9gF1zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQhe0FwLq/TFNmNraRkjRWh1loVHNI1Mlp863pjgUrVNBEnnh5sqOWWswS+AyDB7/N9pdIwN6lzhp/CwpyZhXVRIaiWXUi70buayhc5cBo4O6A1WvhMnuAbc1S9MFAsB8KoCwVcDO7nTaJtgQsw5i7n8zsE4uuwv6OjehIbo5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHnOMJnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7A6C4CEF1;
	Fri,  9 Jan 2026 04:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767931974;
	bh=RECAF4SNoLMHSd5KswFR7D6GpQrzkfxbfSOcD9gF1zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHnOMJnXScYpYJ8OcWES7vNbVJgF5TVKNu836/w0iwmOzLZKgQSsoiLaLfXx9J7Va
	 QENjK5sxCkYVrX6G9fnpE6KVIU2pUYQhZZGv5qyEq3P5ct7EfNVLwND082LNyasIdk
	 Ne5euLyb+yjDEcoOsA8O9GcJEY7nIoZ21QMqAX0FmCh9+KI5egAyxH1H506dFreVS9
	 40J1vO3788Jl7yxltIrIZx1Mp9PCKWdplinD3QYADm69I9F5yAkvhTc7m/BR2nY+w/
	 SYF4rcC5pH9a6fTB6fpZ6H5/8aQ3MdJNhziPOjivebfKK03mmSokgYCOa6BMYF24Qw
	 0OXMsFfoXq5Tw==
From: Jakub Kicinski <kuba@kernel.org>
To: toke@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	cake@lists.bufferbloat.net,
	toke@toke.dk,
	j.koeppeler@tu-berlin.de,
	willemb@google.com,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	edumazet@google.com,
	victor@mojatatu.com
Subject: Re: [net-next,v7,4/6] net/sched: sch_cake: Share config across cake_mq sub-qdiscs
Date: Thu,  8 Jan 2026 20:12:14 -0800
Message-ID: <20260109041214.2918115-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108-mq-cake-sub-qdisc-v7-4-4eb645f0419c@redhat.com>
References: <20260108-mq-cake-sub-qdisc-v7-4-4eb645f0419c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/sched: sch_cake: Share config across cake_mq sub-qdiscs

This commit adds support for configuring the cake_mq instance directly,
sharing the config across the cake sub-qdiscs.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index deb9f411db98..4dbfee3e6207 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

> +	if (tb[TCA_CAKE_AUTORATE]) {
> +		if (!!nla_get_u32(tb[TCA_CAKE_AUTORATE])) {
> +			if (q->is_shared) {
> +				NL_SET_ERR_MSG_ATTR(extack, tb[TCA_CAKE_NAT],
                                                         ^^^^^^^^^^^^^^
Should this be tb[TCA_CAKE_AUTORATE] instead of tb[TCA_CAKE_NAT]? The
check here is for TCA_CAKE_AUTORATE, but the error message attribute
points to TCA_CAKE_NAT. This appears to be a copy-paste from the NAT
handling code just above. When a user enables autorate-ingress on
cake_mq, the error will reference the wrong netlink attribute.

> +						    "Can't use autorate-ingress with cake_mq");
> +				return -EOPNOTSUPP;
> +			}
> +			rate_flags |= CAKE_FLAG_AUTORATE_INGRESS;
> +		} else {
> +			rate_flags &= ~CAKE_FLAG_AUTORATE_INGRESS;
> +		}
> +	}

[ ... ]
-- 
pw-bot: cr

