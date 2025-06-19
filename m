Return-Path: <netdev+bounces-199586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA7AE0D39
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 20:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0537D3BD9AE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB221FF5D;
	Thu, 19 Jun 2025 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoeAZsr9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894830E834
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359409; cv=none; b=MRkI43OspqdDGDdYfNUDAlIgbrNF1bUehCsdOTT5B1zprrK18N0/DC4pWZE0VxNmAJMogGgKIdn74gGOmvob8Y6sWO51sqeLHJnn1O7Z0gTQHBIAwGmCF2YOhGzNOgknEkAylInJPsjEHYq8ZpSVjK3FN6oQ6CIJDcLml8CdrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359409; c=relaxed/simple;
	bh=fKF/I0+isHtGiRm6xuU+f9Uo0CAsrds2Al+UOu1mQ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ+NwCXUMXnwj9Bp7tgp7tQAqwKz5TPEpGmHfDWVcPbVrL+Sg3g4XDywi/1I/X5U5v176rPEHn1nsl/NDPUjC6qO4Rj3dlh3pi08+1Fo2XaRy1qhDd2Pv7t1jQCiXIEv1cpMQgcLRORSib1sCHCt04YOV/saTx3BgKFi3srCq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoeAZsr9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c3d06de3so1195009b3a.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750359407; x=1750964207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPfQOrhMScbXL+oNW2gI5wzKhXNZfE204OqcaxBBPT4=;
        b=FoeAZsr9zk5NdOVAhe8MVVLrQnyP5smFXfDfyirCr3BZRxuHH2qmPSQmSHAXTqZexD
         aXGW8wYiemiQ7LDM7M1/Pi8Z2ajHqaX2Qqudi6zr0Sjkwx2Mbthud0FceEAbLL4QDTjv
         rIwoOwR6ekV5xQIAbYJY6oJ8FKbPt0LyUCT3F2zd6CtQkcyh4t7el4Rg0Rxv/NvF3pqA
         0rQeKO2foeWEXyMFqwWMZM2U4rcukx9+414VY1LuUIKvqpRgMu3bm90Si2jK7abQkjUY
         VpiPys6cjBW0E6DOpufa7Suof7XyO5rLb2mkO5orEktvo6oLXLwlN/UWIsBNtbarzaOg
         Bimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750359407; x=1750964207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPfQOrhMScbXL+oNW2gI5wzKhXNZfE204OqcaxBBPT4=;
        b=SaCGnqt5gwglJ7vFwyOtKr0EL/tFCvhGo9uqBshgxzrtMw4dD4FaehFh+84IeAp992
         CCU5QaLxb+YTtJaqwgmwHFgT9yHZOPeKJPvhFNXdmJh6VqrS+FC3ZapD1hrXXA6/VFVu
         BX1Aa9tKm/VOTVWBMknc0nLQDkBvnTu3lCOiB4i9mb49SmeDckUqEwYaaHk5+399/lOh
         U6xha0Fwb2FAXqqiWDXi99gfr3N2baPWajcAKIi6YzYaMtppBJzDfQN1hAQdJgqcyVOq
         YphPCsv/E7/qpbsvNDpeDexj1AJTdcEU0fccBBgGTSIcyVIfaqm9cDlc5iyNjVBPWMmC
         zsRA==
X-Forwarded-Encrypted: i=1; AJvYcCWTOXubV8mSp0ZcH8xXOkFkjK8b/6kHWYT1FARHZy0GYDTiDeWTgq1Jvge3oIzViqJ7GMXxugU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ap5Bka2YvC9PiqAZLSYxycdSv7ORqDMvUKEI5vAMXGppj7pQ
	6iXGu4Xw/YQqzKvvfZUuokAHk3AUnypo7H6hVeVbfX0cmR+b2OW+qGbNnK12G+dqsusD
X-Gm-Gg: ASbGncsWzHnc8eb8SzRF8j5gvKw/Cf3ZiU10iDsJ8za+PKGJVsI9OSn78xs8Qg0p15J
	ID6pHDFXJg7uaCBd9eEgwUaFJjf0xj8GR4NrrPx8MtUUrGFYByQ2OJ9mPIe+AfNAMy+sCBFrFj8
	wa4zlKdaNLjJytgtPFvHEJlPnkl82UA7dxm5bZepnROkLen8Q++ViYiJ4eqakCFj/lqLg9XuiF3
	YpjAqan7D0qPWVO2ti7KFyYBgIyRc4IeCb57+GPa7s1G5PayMTsaXEtoOloIpO/2jeRh1GpqNXx
	mdAp0ItIRiY0yX6NU97LHTFOKKlgS3CJ8t1wWmE=
X-Google-Smtp-Source: AGHT+IF92Y0gC//wIs/aswreTNLpnPdJNrWSDkgaaIDQVRDXD7MLQ1aXg9J0ShjOxcY+j9VAl8TzPA==
X-Received: by 2002:a05:6a20:a123:b0:21a:ec1b:c85f with SMTP id adf61e73a8af0-22026e1314emr114349637.4.1750359407135;
        Thu, 19 Jun 2025 11:56:47 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a689180sm388556b3a.146.2025.06.19.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 11:56:46 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 06/15] ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
Date: Thu, 19 Jun 2025 11:56:08 -0700
Message-ID: <20250619185645.1647494-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c84e2303-2240-4bd7-a0d9-2e1d4d0c0677@redhat.com>
References: <c84e2303-2240-4bd7-a0d9-2e1d4d0c0677@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 19 Jun 2025 14:33:56 +0200
> On 6/17/25 1:28 AM, Kuniyuki Iwashima wrote:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> > 
> > In __ipv6_sock_mc_join(), per-socket mld data is protected by lock_sock(),
> > and only __dev_get_by_index() requires RTNL.
> > 
> > Let's use dev_get_by_index() and drop RTNL for IPV6_ADD_MEMBERSHIP and
> > MCAST_JOIN_GROUP.
> > 
> > Note that when we fetch dev from rt6_lookup(), we can call dev_hold()
> > safely for rt->dst.dev as it already holds refcnt for the dev if exists.
> 
> I'm not 110% sure it's safe. AFAICS a racing dst_dev_put() could
> potentially release the rt->dst reference concurrently???
> The race looks quite orthogonal to the patchset, but double-checking I'm
> not missing anything.

Oh, I missed that one.  Given some ->err_handler() use rt6_lookup()
under RCU, adding rcu_read_lock() could be safer ?


diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index c91134c7e927..fc49f84d74ca 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -201,12 +201,14 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 	if (ifindex == 0) {
 		struct rt6_info *rt;
 
+		rcu_read_lock();
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
 			dev = rt->dst.dev;
 			dev_hold(dev);
 			ip6_rt_put(rt);
 		}
+		rcu_read_unlock();
 	} else {
 		dev = dev_get_by_index(net, ifindex);
 	}

