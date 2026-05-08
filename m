Return-Path: <netdev+bounces-285807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL1yOYvd/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:56:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A75B4F69ED
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DFBA3015A7B
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AEE33D511;
	Fri,  8 May 2026 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvqUiqYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8C3101B6
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245000; cv=none; b=QAR95aYCGJ99hcWzjyBwoGuWVKmOuxyQvEZzERBrZNfXuBSm94FDbrUrewy1+gKrRjQPqBPhbDF7UczrVR/9I3gijQRCA0AY2O3oCnHs88lTp4Dvy5SMw+DvqrhYFkS/5gZ3BkhXLmz/nb7VO0tYX259pTR8ODW3fxU1gBQjKp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245000; c=relaxed/simple;
	bh=Xx4Zr4sTJ4+K6Kd5DzHQIS8+LLlutTzxBDdT3APyyuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNVy7ly9D4sfr6MVT/AapAwaRoDAcT+2ctCFqrUUYoufPtuQYwnIxpdEGFonE7zOxX1mWcd/GNt6+yLzuYF15hKnX8rO+uSDlpaoeuLfAUmK0vj83DQK7/ovFYg380/YGzLYKOWENIUbF918JRR2+s4l1UWqgQGA5WrqcuqJOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvqUiqYq; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e363c6141dso629390a34.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778244997; x=1778849797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Bb6HPtRsGBp0YLqSkmO5CXUhsqKPg0jNt7PVf1qNJQ=;
        b=EvqUiqYqeQom6RFmx8lJbfRf/Hg1Bv3mdz4tgOsm9N50/MF1LZ7PS3sOgvmNgDvqoI
         +7hu/MC3O53G/SbC8/TaWgoO9lJriVAZScgSNdH9Wlqm0ibs/Bb2hqhE6BAsunZnJmd5
         MK74YD2jqAkmTR1Na397eGMgg0Rrscf5WZfNR5Tjd0GEsq3NwWpxP3IulClSJFxHc07D
         BaqBq68ROkw8SQRw+H17bSGWS+T9LpkbTpWhAFZUzyYYvh9AZ4KIJhY0sCtKkEvKJruV
         5kslhKHJE7ZT9OR0SpeJWrLlOJ+h6F6bGPE8pRyyt1I0wIGs0rStes4VbEMFM2WV4UvQ
         3zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244997; x=1778849797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Bb6HPtRsGBp0YLqSkmO5CXUhsqKPg0jNt7PVf1qNJQ=;
        b=MHdrEgEJK/orbS2c4xvAdqC4XG1j5HRoHXiWjVFizTSXCCMl4yNYkm7cGXAwA4mUyI
         RiCUEsTJ8mZONX8t3ll/pH5asyvJw1OvRtY1MA1uGM3a7qOxlg+WvkpC/HyyGXkqjDN7
         MP6Lg40PGPJwrew+nvVEwNvbKyL+0K+0Ni5tx5IByRaOTE4p5XxiozRxcfpKoa04/qY0
         biBnC+xOC6Nj+HEM/QaMzjBBZmcpnIUeaV+bM+ACtohl4go19Oo1y1Ajg+4Ft+sxsNI1
         09Ea4yHNpaY98dZm24qyeydpNxxrkTdW6J2dE2yTBplobtCTFoIlCouL2JHcPErgItpo
         HQKQ==
X-Gm-Message-State: AOJu0Yy8DjCD4+Ra4qBjZ0AmMW/grgS0C9Hea/Eb1CC4ecrYJO68speY
	hxTepalW76VN925yrsdPKKZ9bKzg/oRCB+x8jLkPeorva/PLuuu18cLpfVXhB74wIqw=
X-Gm-Gg: AeBDievJOWK+fHiwHX36W7HaNVcxu9w4wMJKAGQm7aAd0o9QLsCjqKVjiA4ZDAQHJOo
	mPHKLJX3JJ7y1e8A3cWfKPkr1uMLG56chiaH+pyWgTgj5Hw7n3ZDndkpo7qEFrfJUeU3LQAyRjo
	AJdUtN1AA3L0gx0XVo5kAqpmQrx4WeS6DiT/rlHxYERY8eUEM5w9awOsdqrH5m+6KRKTy30gVod
	8a97ETLBYDLu1nTfc0N8AlAWN8nehudhA/6wFu00MRErkwAtarka1LpkLvFvdTCVYno+mwRyq1O
	3BYnzifV+DFpeDSm2DT6cc9I2BjCC/gEy4x6N9Fq9bvVxZk+ij6krXaIAL4h3gvyLrBEVMzgQlG
	BuF2ZdUzz46SEFDnhgUt/hJwx7/qXldhw3t6Ct8Ah+GQa3ET2Ag458k3M0risQgVtf7DM3kXx0G
	u4hUhQIRl7Bsu8C/4=
X-Received: by 2002:a05:6830:67e3:b0:7db:a184:2b39 with SMTP id 46e09a7af769-7e1def3fe88mr7605656a34.11.1778244997466;
        Fri, 08 May 2026 05:56:37 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d4fe15sm1081925a34.18.2026.05.08.05.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:56:36 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	Minxi Hou <houminxi@gmail.com>
Subject: Re: [PATCH net-next v7 0/2] selftests: openvswitch: add pop_vlan test
Date: Fri,  8 May 2026 20:56:26 +0800
Message-ID: <20260508125626.2791111-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507131541.2331771-1-houminxi@gmail.com>
References: <20260507131541.2331771-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A75B4F69ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-285807-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Aaron,

Thanks for the review. I'll respin with the following changes:

  - Consistent error messages: all use "function(): missing ')'"
  - push_vlan error prefix changed from "push_vlan:" to "push_vlan():"
  - Added empty-string guard for ns1veth10mac and ns2mac

Will send v8 shortly.

Thanks,
Minxi

