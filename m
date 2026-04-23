Return-Path: <netdev+bounces-280689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEQtFHfw6WnzogIAu9opvQ
	(envelope-from <netdev+bounces-280689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:12:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19012450641
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 754233005143
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F23E638D;
	Thu, 23 Apr 2026 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk05PlEY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE33E5EEA
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938286; cv=none; b=QFyoJrpDJa37KEB1R++hf9vuj80UGIZC3KWDjmENp8MDru6Nrd/+6iFqWrUmA2QnChjyln5Wr3YqO0rjT3IJEkGiLzLXC70CUbpJRjgQ8HAlThVfFzHK92Bs3PEQQtOeW121mFD85OTbPlc52kNwQg8kdnm/tiOgk0PkTnP498g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938286; c=relaxed/simple;
	bh=4i2Pu3zqHhqY1LVrkEfbhdWbJY1ci5ulbDDwmXTHKi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qo47+p5IdcOL0MqYN19zHblNI1SziVKD76eLLtETU4njBpbGrmT6LhBdspyluv9rAtIarqJZw26uGSaIPUGvdGCOg0WW+6UMmskZlSJ4whwZ7MTACcGrIYvBEoECZwAMUbjr74axRmAdpPPnzUk9yt0R/G/HAPIe7UautI/mQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk05PlEY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f83bd32efso5063164b3a.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776938284; x=1777543084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxBjZOu7EvKRw2hJBLsj/m/4rWdIwz7qwQtkDCYo8So=;
        b=Jk05PlEY7DuwimoxqJ8MNy4SY0nbzTNJvlf6+BLLYYGJyxcc7tjYU0sFI7pIMcuCjP
         PHuDwn+6TwgZI9moCnQYS7FyWG4ch8FvLhn1RZtCLoSXUCybAIy8pIm3D7TeJ7yo1dgT
         js+XMDnSHtT2/S+MY2gHaZZ7tR6HTGBk/j+/+F+74lJcBig0qFVAm9rWewLXkUxc+64E
         VkXLac/UPcvbK14rqXWF+LHGF8icO9XXqRGZr0RLWbNpn5mI7NRLjA3VAGK4r5BcZJzc
         nniJzepkjmd00Nc16BQP5TWqTbr6KHic6pYWLXbb00d1a+IfrafObtQf1it0iYl5M5n3
         5g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776938284; x=1777543084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxBjZOu7EvKRw2hJBLsj/m/4rWdIwz7qwQtkDCYo8So=;
        b=fQfpP7QqHOueV5v2F+Sb19hTr1iczsjoRHbyDMeTP/6biUb/cjQQNKkmdOyCvbfELX
         dsfaSz1vjxNqMOLGxndjz4AxuPRtfDlCXwMYqfCUCnccPWd5GyL7AFB8ejxqfAkop1y3
         zJIIHwTfIqXZWuke3SKkgElbU5JuVbZ6l7PIQ0ofGmXGkLCzybAmtWL5QfI8DV5HHP9O
         +2WABq6/Iz0zPkT9J7JSOjVJPU5ZUe8uHhuMkIJ13M2W4f+C63F0Zh1hFAgyhHq+rrFv
         9VpUGYvZL2L/8l0sMYwT95L1HEfsHHky0jkqrfe8vWNe9vX83L6Tj9j8haXpMhHfjH+c
         SYYw==
X-Forwarded-Encrypted: i=1; AFNElJ+E/PQ5JIk6Jg1g3hb/UyCpoWrUaTSZJ71HtJrcP38WOFzSx6VrGcxFVfwVpBhiMO//EVUcVHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFx437L6bmYuWG2z9AP5TEKkj1QQgN86HUTY+JAFAuZKSVw+K
	RQmX41ZpQP4aR992fPPvp199qsQihO3nEslI6C/HDkPXLm/TnpLkjNcz
X-Gm-Gg: AeBDieuwQ9c/l0JE8D3CW8XDB1ODIjJX8xnsNsyuvWiGH1DiO7m9Zq4IjKv9nqUE8lL
	diA2QFAAy+txqGi9cGYF2j+ujlbVokhRmb8Tw3y8vl7rOQJ2LGfvnggrCJNM5Ru87IYWi/aHo/Q
	Z7FvJBI1x2WDLoK60tyGSF5GuO8Mk9SG2dboxnuXYDTq0NzdQGvJ0D8+Og/UmQPR03LuLgE2nK9
	nfDvvvDGcFc3AE4fS7oEVMf2M0ypRvExnl3+akBBJGmwM3fYSj7XdTMGBZEQvOnWMWnxE95qOcn
	74g7QgIukbzVpGJK7AkWbVLgm1IDi3l1lKJCbtl5IEMmbES8V8plVCJSMe4bn0tCaJxKyDC2IfX
	4socPKUED67dxLCP2paEb7mp+mCsCV5JXSY3ry/jSApzG0BGC3PGciBrF0+pROgvE+zeSgKOWRa
	iK4o4JPzfsTlKV6xIw4mCN1Nv/6mkhOIuQ/OgL1KFpRlsTbRTQ4CiA
X-Received: by 2002:a05:6a00:2341:b0:82f:6b64:1b0d with SMTP id d2e1a72fcca58-82f8c83446bmr29344689b3a.17.1776938284480;
        Thu, 23 Apr 2026 02:58:04 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981a0asm20542313b3a.3.2026.04.23.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:58:04 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: validate extension header length before copying to cmsg
Date: Thu, 23 Apr 2026 17:57:53 +0800
Message-ID: <20260423095753.3648669-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <01e90b44-88c8-4e29-86db-b9258d8271b2@redhat.com>
References: <01e90b44-88c8-4e29-86db-b9258d8271b2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280689-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19012450641
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026, Paolo Abeni <pabeni@redhat.com> wrote:
> The patch looks functionally correct to me, but the above 3 statements
> are repeated multiple times. You can put them in a local helper and
> avoud a lot of duplicate code.

I actually considered that first, but went with per-site
replication in v1 to keep the diff minimal for backporting.
A local helper is definitely the better approach though.
Will do that for v2.

> The packet is corrupted, allowing processing of later rxopt requires the
> IMHO not nice empty label. I think it would be better just returning
> from this function.

Makes sense.  Will return directly in v2.

Thanks for the review.

Qi

