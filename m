Return-Path: <netdev+bounces-268851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKJDNRkHummmQgIAu9opvQ
	(envelope-from <netdev+bounces-268851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:59:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D82B513C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8F1F304566D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9FE254B1F;
	Wed, 18 Mar 2026 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMqxIik5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D0224FA
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773799190; cv=none; b=FZ0T6zHzxOsx9jm8+6gc1TCoaNEUjhsEYAFjhm6q/c5yHIGuQ/TcU1vmxQ7OKdARS3quFMim+HP1nKM2uyHGGW7InadUgK1fT4ZTZmxHsoxcnbuKhnb+Lk7iG/4TaQPopphQEsEVIEtssH3kIZDgNol6o8F+wLuwzyHLflK9SXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773799190; c=relaxed/simple;
	bh=xrjVBeDv/Df2HmsrYK/HbHtrtCdVoSl6y/aclzbxdck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFQp09JBc9iBVDlgWedrSK78xMpJ3oaoNhzZJ0UfURS02n8j4BU/xJQTp5SHPOiKjd8iH4xyrJJKIuU80HMv0n9d9dUyGifx/0vDgdw5Vy0KqsX606kh3R1yq2QCx6uj90VXWKyqza+PSz8bNgPruZAwdS/GIlxq6siCMlHVbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMqxIik5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b96d784828bso951808966b.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773799187; x=1774403987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1abtcIpGMom0wsy1NJZLYcHl6br7lH8/k/qysH5VHys=;
        b=WMqxIik5IgBnRUVDZvFQ0y+VMBep/00ZxCmxyYA8bHF04tlpOcVwhUb/MwLPy9CusZ
         WiFHJSJZ1Xz19Luiy26ZRhEmzeXwGmrvwerQKrpQ9BAlNN9/UjXlKkPuA7/+l2HOhSZv
         w7kP8Cc/Xq0+YOFbybvuGJMRyQU8qJ3+IT1TjLjhlHE0f+GxzU3ni+mUveB/+JOCdwc5
         Al/iYeawTc6LUaWRiWeGOBkiH3mgX8cB+mhH1B6nh8FGXQYQ4or+hPTnqvNGo9/eC7mr
         /Mq/OSRMvMbRIjWzXP5jFu2+/G8WnAq0o93QBWlfxqOpGB7vLfqJNAi58UyimOrSN2C0
         roZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773799187; x=1774403987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1abtcIpGMom0wsy1NJZLYcHl6br7lH8/k/qysH5VHys=;
        b=LzBEy+0i6fctZDOJVF7LK2unJ4LnALsX3DSWYyDMfG7P2QCHshEmpQ3KCcNhdPAr4t
         kXQqZNf+ORYdaS5+9wvVAPLToK1HPkv8DKk1QoQW1ZjGvOT3joqvcBqq3RWP+6wX2LcR
         3NaIb6VjPleA7d31BAXUJhpnBhkTVT5zhxa4B2Lf5FaWytdDY0WSmsZCqg+QmJnLu4NS
         xSfXXhiX4OD27zJ66kkRPpi3wyzVY7qXaqshf+mKgAcByiQkEMgRhqOwi7qxgAa2ljKt
         V1/g5MqOkTGiewB7dyBCu5NBG6hz7JOqYOguPfdCiojvJW6NKVkvTLbRX8VOEQ0Vii19
         ZhfQ==
X-Gm-Message-State: AOJu0YycYl/J3CortniMphn6jjTMc2sxyZJ3Xg5t8b9A8NfTv4TIUStk
	USZY0Jyzr+h62bkA7DIog7zRFXgw+9P3Y1uMGep5hwj0a/EHoVFhHSQI
X-Gm-Gg: ATEYQzx3Ir6ChBammNLUhyzx1Jw9RRJfKjwMxXwdDjI5uutVFDjQpoYe3n/d7qzuudH
	L5FhjkCf4PW6pIf5t1RxIq69d6wIT4roK4OsqC+rb6I0Kw5WWV3mcVOlRyq4oWwBLQZXM7TvJl3
	6ciuOD4TtTSNoC9KV0rJNda0TzScXXB7mXzkhbijUc9XzaTbC3x0RztHTdzzVNFISl2UBmV1Xjq
	dTuRPKRn75pKERJkj/mI1Mz5TO4ZU5bHBwTtUIiOVvSGHARYjoZCBHv1nuhqOyuZ4zuOWj53VcP
	4ny++EH0mAcMKz5ODUI8rRUbZ7f2xMOWEp5tH/nHn43dysv3npSy6+sDuXN5eY4L9o3udl/t/c7
	mkJC/YuXmNeDAh0NTObNjWqDAq2urxJZQMZgoV1AbtK9StypAQg5LbawQEPr2nOzJRkEjjMvu3P
	P8IlQ=
X-Received: by 2002:a17:907:9346:b0:b83:1326:7d45 with SMTP id a640c23a62f3a-b97f4a3db88mr83441666b.32.1773799187320;
        Tue, 17 Mar 2026 18:59:47 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e22:2e3c::49b:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16868cesm97079766b.33.2026.03.17.18.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 18:59:46 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Martin Olivier <martin.olivier@live.fr>
Cc: netdev@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH net-next v2] ppp: add IFLA_PPP_UNIT netlink attribute
Date: Wed, 18 Mar 2026 09:59:29 +0800
Message-ID: <20260318015937.239409-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <PAWP192MB2411A808BB36F0086A9B00B99742A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM>
References: <PAWP192MB2411A808BB36F0086A9B00B99742A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268851-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[live.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,live.fr:email]
X-Rspamd-Queue-Id: 2B5D82B513C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 02:14:29 +0100, Martin Olivier wrote:
> Currently, the PPP rtnetlink API allows creating a new network interface
> with a custom ifname, but it lacks the ability to specify a custom PPP
> unit id.
> 
> Setting a specific unit id is currently only possible with the
> PPPIOCNEWUNIT ioctl. If a user-space program also requires a custom
> interface name, it must create the interface first with PPPIOCNEWUNIT
> and then rename it.
> 
> Resolve this by introducing the IFLA_PPP_UNIT netlink attribute. This
> allows user-space programs to atomically request both a custom ifname
> and a specific PPP unit id during the RTM_NEWLINK creation process,
> eliminating the post-creation renaming for this use case.
> 
> Signed-off-by: Martin Olivier <martin.olivier@live.fr>
> ---
> Changes in v2:
> - use nl policy to set IFLA_PPP_UNIT min allowed value instead of a manual check in ppp_nl_validate()
> - use of nla_get_s32_default() to collect IFLA_PPP_UNIT value
> Link to v1: https://lore.kernel.org/netdev/PAWP192MB2411A5E7D3BE1B55E155A92F9747A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM/

The patch itself looks good to me, but I would like to check the
userspace changes too. Please create a pull request at
https://github.com/ppp-project/ppp/pulls

+Cc: Paul Mackerras, Guillaume Nault, Pali Rohár

Regards,
Qingfang

