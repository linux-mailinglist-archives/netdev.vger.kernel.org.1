Return-Path: <netdev+bounces-98706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9B8D2233
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23554285747
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACBA173338;
	Tue, 28 May 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6TAfEpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400B16EBE2
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916428; cv=none; b=Al8Ci+7SFxIoGV+ROiW5nZx5N/oKAAu1gEmTYEapo7KH7TVPkBTgK7LmgjS3brpIYoTEPxXZr0cWYGFWPw3zc/TgQi1CbMWx8IxNDSYhOJvOdHaJqZWQQTTiFy32l4GAKlrQyLVAsjO9hhQ+g5Pxx0k/8VwtJKQN3ODL5hk51XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916428; c=relaxed/simple;
	bh=RT7WNDkh1WyUOBUasStO585xo8/Qz3LsbhvQ9GSOdLY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ogkNigHnHeffjLrGgenF40HAXkxIMh84UfLwxfPuRSB21HVl/zeB8IRokqLm0+dp3z1k/1jbablop9bmNvhrouUnLxj4nVHDHSu42iydys0ckS45sqoiSL9CcQSA15Daeckd04ifcYLh3oHIck2IQyugnOict7nvF2nTosIF//Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6TAfEpq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df7713034bfso1667497276.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716916426; x=1717521226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WgpFj8SleZOBYv8EYsnY5wx+PMsSrui01Yg0FDQJfTo=;
        b=p6TAfEpqQztiD1V5AIC7ftVvxlche36X/7It5HoqQEcprkiDccXG0JSv1lGmldI/mU
         z4LguGZSu+L26+nKLaObQOP+N/iF2psHJrqy0PU6F/ARt5GyZ2Ou/muPjwQhtaoKNDsG
         cuKc+60y5oe+k5FPmOKMZZkr9j1OeX4amaN4zbHdX/39oL3ICyV7aezkiVmyPPPqV3Yn
         wHltoj55kAneAZsOl1F9MHZiUIH3+FhkNrkfgrck2ePn9z4vwZi5ELMxcN0dIdWLl6Cv
         xUTnKhYyv6iiY3cllgGA7JQEnG3UbzB6tuRmKneFnhqQaYI2Dqt8IzIDzaA+pp2RB7B5
         F8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716916426; x=1717521226;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgpFj8SleZOBYv8EYsnY5wx+PMsSrui01Yg0FDQJfTo=;
        b=ElBHyIaahtz0sA8gB/N8f54SYQkmgrflZkCwYLFso56iA4oMvJWL3UP9+fDecxjDQ8
         bi1Z67XL6UiAzFRWlvvoY8maxwwE3v341+wyXbP15Z9DpcKkUzAyoTi65CeLSGnDhiev
         0ik1ojrwKBrSakG/EZaxrd/XjqGfHO3Hm1925nPxW+cV/BIAj9t8W8tLe5V4JFdtF7nh
         LPa6Z1BK4Whzxo1NMacDgmwKhvCr0DdJwxEcmhXlXGTUum+jY1elaHAdT2E9riPEIKaN
         l1z626xo00gX7KrjETBwrLXwc9dpPJhcc4hkXArCIxXFQc03Xf6eQO4CPADd8pgpw4MZ
         ek8w==
X-Gm-Message-State: AOJu0YzdzySvFmKHlNvDBx6cAW+GL8l1QXw3xFOO0c117nIgXRQY+Eol
	QQ/syG2G0cnFYBriSFsB6hHxlfyuMPGkT8sBPQhmj70KAx9HZrekEFx4yZuBQ/dmdQ==
X-Google-Smtp-Source: AGHT+IHo1dH6FGvqj6Mk7egkX04oeXsVV3znpdyxRQHVwAnrf39d0ELXGRMImCr/gpVfucBx7eCiieg=
X-Received: from yyd.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:13c9])
 (user=yyd job=sendgmr) by 2002:a05:6902:2b8b:b0:df4:dfce:ba0 with SMTP id
 3f1490d57ef6-df772210d5bmr1014512276.11.1716916426395; Tue, 28 May 2024
 10:13:46 -0700 (PDT)
Date: Tue, 28 May 2024 17:13:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528171320.1332292-1-yyd@google.com>
Subject: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
From: Kevin Yang <yyd@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Kevin Yang <yyd@google.com>
Content-Type: text/plain; charset="UTF-8"

Adding a sysctl knob to allow user to specify a default
rto_min at socket init time.

After this patch series, the rto_min will has multiple sources:
route option has the highest precedence, followed by the
TCP_BPF_RTO_MIN socket option, followed by this new
tcp_rto_min_us sysctl.

Kevin Yang (2):
  tcp: derive delack_max with tcp_rto_min helper
  tcp: add sysctl_tcp_rto_min_us

 Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
 net/ipv4/tcp.c                         |  3 ++-
 net/ipv4/tcp_ipv4.c                    |  1 +
 net/ipv4/tcp_output.c                  | 11 ++---------
 6 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


