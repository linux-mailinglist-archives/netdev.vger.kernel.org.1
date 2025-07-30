Return-Path: <netdev+bounces-211018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D6B1632E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E84E18C6E07
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271A2C324F;
	Wed, 30 Jul 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ENz+bQmb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C19F2DAFDF
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887108; cv=none; b=Adt7OGopIY4V3hHS3orGs7CyFor0UvjFysoXkBofn4gFsq7hKmz13zUgO4gJo2pXeRb6jx2/8P0M8utngQTkIuxx3XDIbmQST2o9jPCWMBg8J+HlVMiH6kRSYAUyaYkDj76NQSH1g8Pf2g9nnNuZlNbp5GNeDDUFdu+4RXXJNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887108; c=relaxed/simple;
	bh=uoQKFbo2YdSIN6eRQ6crnJicETUciP8v6WhTAsB2wPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+ciEmMjiZfi4QcNcIeeqomRfqvZrKOjEvi1THdInwN8mtvP/Qkx4FSjANIKzhFEFudKresv1QUYZuqEEneotnm1KNVHg+o1m6/hfbpFNITrm8eAHXl1Eh0LEnVNdFM6J5GXt1kzMr1dlPO6p2PHagqK/zCIfwu0W7OSLn6OD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ENz+bQmb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so1669449f8f.3
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753887104; x=1754491904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU7fSeBJtxQop1jITbCeP7a0NZkr6EsCC+M54lVb4lo=;
        b=ENz+bQmbMZzK4KWnlqADy68MM4/RiQNF2MOR5h8eLHKgOp4u+8CmPukcwcX0gOL1Z/
         OvIh4g1BlYgJPg4qWfOU4h2KQCUeWT53ca12HzsyeqfMGcAhQR6+p0ep9SCsQNVTfN81
         5RRk3Lk9tdMe+qbC9Sk2N3qygdtZhYiypAc5cyibBueM6/y4v3I2uc3VopRSve1F6/Rp
         uGQ527tnMOFtc7HmJ6h8jfsPlmoTmOapv/vEdK+wo2GmDYl7rXKbJDN/AjaL0DCbhBsp
         HnaolvJRJ3z82mVntjTkjEtPvKq5KHdP0RaWzPxdpZtGaPKRbaJ9WnfTF/Tm7CuqNrj9
         xWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753887104; x=1754491904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU7fSeBJtxQop1jITbCeP7a0NZkr6EsCC+M54lVb4lo=;
        b=WE0e7afmbQr0AXkV9fDgQRUYOcrSb1spVC2jJK9uzaD2qBgqVoPcGZHGwN+GjiDzeI
         TMLCZb8DuER3qs6k6uPoiY1O7gNqMV9BUZle+c/XiweWSO21waD3w0157p4LqGh8D2TJ
         FRqVN25LHkTRZvyZbNGLNmQSJu/h1T/QTP2jTAw4FUje76E1eC05KVKs4QkhB9tboqdM
         wQdFedQoVzUAy2TsU6gf7KDfhy0xKfVFLLoPzAUqebOpWJ4rxMQoeS2MZ/nTlexP+jol
         e7+Z6jzhpeZ5GD2depp8FcKfJL3sZUitpsnppeeFR45zK+4W6ovuI4Hc7+W3wap+npdh
         4o6w==
X-Forwarded-Encrypted: i=1; AJvYcCUsdxP4UNGnrc9yvbGq43AxcWFYik/5defr+z9KiMZyTfsnLhZuHwhIXBmwOywNCrLynz57BCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzntPSetlL1QKcYCB5UdxSAAIxZudugwOzhqXAEUx6iELInLgtZ
	VekJ1w8EpKZd83Kx8EnvCskSV1XR/FGj0nFpzR6jispfy8f0FA/FEA+oPepuwZ54QxQ=
X-Gm-Gg: ASbGncsh6Kmop7+aIoJry8EzN0LIne6dZrz8+rW+MKj7zDbBezi3UOuyuoqaLlj/TXI
	/NycHMjr/nzmkOHGy8Y8LEC4L84M9OIJkaiO6nO87OI8z6r+IASlMEztODfQus05Jm01nZXbQN2
	0ghyEYCy0hpq1V68buZ9ywmxfTfhxMAZ5qfO6L0aOc8qFGEoirn0bD6Ys7fZBv3qqqdawBeZENK
	/Q/r9R1CeTtoC7YUEHO2xntecIlA6pDIKy0E4He5S22/VKUJeMn+KznWMliHMCsHj8v4fGKfNGS
	2N39AWpU+dFTTmO2lJgicg33/Zc9Eq6vdauhT3dDG9f+RVOTCFgNbWOxOuJtXVXC4SEpeG7as5Y
	bt2RzD1pdn/MVfqPzSXu0CnwEVOR4yjoBWkncZ5Px8MT1UhiNSpb/tcKIiCGOd7JKsvcVMtG/55
	8=
X-Google-Smtp-Source: AGHT+IHXx6q0uN16zF3G4BvFRnfqcTZ0qg7OcD90jKr0TJgrYI2cKQbHcmTjVCGiQc648BjyRRGekg==
X-Received: by 2002:a05:6000:2912:b0:3b7:882c:790 with SMTP id ffacd0b85a97d-3b794ffcfd5mr2443457f8f.37.1753887104427;
        Wed, 30 Jul 2025 07:51:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d900725sm46347605e9.1.2025.07.30.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:51:44 -0700 (PDT)
Date: Wed, 30 Jul 2025 07:51:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Dong Chenchen
 <dongchenchen2@huawei.com>
Subject: Re: [PATCH net] selftests: avoid using ifconfig
Message-ID: <20250730075139.21848612@hermes.local>
In-Reply-To: <aIoWcxoHfToKkjf4@fedora>
References: <20250730115313.3356036-1-edumazet@google.com>
	<aIoWcxoHfToKkjf4@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 12:56:19 +0000
Hangbin Liu <liuhangbin@gmail.com> wrote:

> On Wed, Jul 30, 2025 at 11:53:13AM +0000, Eric Dumazet wrote:
> > ifconfig is deprecated and not always present, use ip command instead.
> > 
> > Fixes: e0f3b3e5c77a ("selftests: Add test cases for vlan_filter modification during runtime")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Dong Chenchen <dongchenchen2@huawei.com>  
> 
> Not sure if there is a way to replace the ifconfig in rtnetlink.sh.
> 
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> 

Would this work:

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 2e8243a65b50..a3d3f2261bab 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -318,7 +318,7 @@ kci_test_promote_secondaries()
        for i in $(seq 2 254);do
                IP="10.23.11.$i"
                ip -f inet addr add $IP/16 brd + dev "$devdummy"
-               ifconfig "$devdummy" $IP netmask 255.255.0.0
+               ip addr add dev "$devdummy" $IP/16
        done
 
        ip addr flush dev "$devdummy"

