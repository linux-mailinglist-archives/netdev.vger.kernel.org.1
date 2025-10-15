Return-Path: <netdev+bounces-229423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372A2BDBFA8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C28218871CD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 01:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E52F6572;
	Wed, 15 Oct 2025 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejdovxqZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A41D5178
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760491571; cv=none; b=mSU+4tCjT8YBkfCDMo9nisKPdCcye6Bvkgex7Zea8AOgKvkJdAbN27L+TMdrinl0IzB9RlKrZe0FCiuVBSmvJk9Zd57ZXX8X6flr5mS91mRvK2/Q8IEOiAjfKfouNbg8d1It1AyO6l1Mol7eWMIX4Xy0KPABYmrbaRtC8d/6I+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760491571; c=relaxed/simple;
	bh=cjJS0G2aPBCIRiv5AjzjQblvTPPjsjWQvR5I9m1fB1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fierB8/RNj9xI0U4cerpN6Yxc7vDkVgu8i8iYquzjwZ889N+ZrNX1UUT6X+P2B49rc/iHWc1MxenNcbIvKciZNM2mjBc9UdHPtvVRFzXmAgHErSxuLRIjgaDH3JWWjfRlTy1nLoXKIhriyG8pw8MjfoxeavBsnicCfRqf73qTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejdovxqZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so3683861a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760491569; x=1761096369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q5dz5Gj88sNElZ8LH0dTxbQkaOtoFBCo1ZKVE/LXNA=;
        b=ejdovxqZ+y/p8YixvvyohbB/70oK1JnYqCSPfu7ecR/z0XuOuyEXWwYVnXfFxTOmP0
         FzxNYr+oZRaRtuSc5xg3vUGxsCkVRvQMSslFO7yGUsu+JBF5jG58hiLBOeGL4lmp3UF7
         kPW7+BeBJvv05tGThwIUYMyFxKEwzxZvnapuAnAa6dxIg4giX7cKWpSqWJsZIUz/yh0s
         JRo2fcz3OZuj2ue5seXULtJt1MEQfsW3t8HtuCa6Q93bvRwzdKt9L8dVocEMwLc2Dsed
         W72SBvLx2DPdonl1kLxcV4sJ1mHf+rs0cBte0rnmx6Zalq8OzX8naXh4a439i3TlUZ8v
         YmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760491569; x=1761096369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q5dz5Gj88sNElZ8LH0dTxbQkaOtoFBCo1ZKVE/LXNA=;
        b=Pcr44sMPIqm4TP9PVBL9tIGrJ7EObIF7Z7nN3IfLt6ywiri7WbgF8QFQjuCZoSFLxT
         VeRHAR19zPp4nf84U9jiQLQl76Pi3LFaEfRpV/vvoGNONhDN80//37t9i6HD31SxHVyE
         9nuStRBnI+nh83NvtJEgpGSyxwt2UVeYkRH9eK8o0kTFF2r7C/YjcOdtyquoZ9A3lnA9
         uFjV6vdSi1mX7/jrLQ4ZsQXoEJkuihghHrKqXDv50SvlLCSuiHVmgIQUHWNscJ4lXMNL
         CIxUUCgu3tnIZ1Z6cmDkSxluqFlBJ6WLNMO+MOnHUeWNrSbk1drqnwCU44VMN85AAS1Z
         F15A==
X-Gm-Message-State: AOJu0YzccLEaxTM7npDOhMB7P06ykjT5OXDo3nPGGA6pAXr6H2xe7/mH
	Q00kBfk5KHCXJmPR4pwadmnRCZzjPpb26BOnjSc4oIixaBBxDLFj1KCw
X-Gm-Gg: ASbGncuFK2oD/0h+hakpbGCU7YfTLWv30pk/4Lr2GJbWWQszqd0V4jctb2QUM6Jyo+s
	Q2BTmp6CcWtdMNTNPuPqcStQQ5WLa2usgLQ3d9MmRJfhZJMuvKCbfow1ZBMs5SlBCiIvv8G+M1F
	QF36ZAvOqyljCCqPMVwkU5bgm5o9UmVWMbTLNeF9HIGMXId/+eMhrt4DBjfW9ciUl3zh7E2NwbO
	AVmvELVOsaQHM7jE+GQuoXXvEHZy19jdWYYXVqpHrPRlYxHG161Zd6FQujAxCUH3xRmJAKh49lt
	O2s5dDDphBcp8FUYka7A1zrF8+hkHGhuH8jgBK0EdZOVa3kDTpCoxh59OVqXeHa70XCX/ZXlt61
	glJfaf267CcnqY+LvV0gaWATXjUvSp4QYNowmwntJ03EmrWeSQQ3PVM8uPm39k1OZ778ckzMPQ/
	WrVP5iDCq+KA==
X-Google-Smtp-Source: AGHT+IGzF5+LW53UkepzFQKI1Jzn1qFhxcSosnAtHxXYK8XVZjCibUQ1WkRpULc0fl9NPUgHG3Sndg==
X-Received: by 2002:a17:903:246:b0:27b:defc:802d with SMTP id d9443c01a7336-290272b537bmr343555765ad.28.1760491568988;
        Tue, 14 Oct 2025 18:26:08 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e4930esm176198915ad.54.2025.10.14.18.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:26:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:25:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <aO74J20k16L7jS15@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>

Hi Jiri,
On Tue, Oct 14, 2025 at 11:40:12AM +0200, Jiri Pirko wrote:
> >+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> 
> I don't like the "virtual" naming. In the past, we always tried to avoid
> that for lower-upper devices like bond/team/bridge/others. Soft-device
> was the used term. Please let the "virtual" term for vitrualization,
> would that be possible?

Sure
> 
> How about "master_upper"? This is already widely used to refer to
> bond/team/bridge/other master soft devices.
> 
> MASTER_UPPER_DEV_VLAN_FEATURES?

I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?

> [..]
> 
> 
> >+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
> 
> netdev_compute_master_upper_features?

netdev_compute_upper_features?

Thanks
Hangbin

