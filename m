Return-Path: <netdev+bounces-166315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3700EA35750
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 07:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17DD1892094
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A34C1FFC63;
	Fri, 14 Feb 2025 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp7bIZn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB21802AB
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515328; cv=none; b=WMXZJ31GYU0cZ+D6z4Z9S/8P9e2YuRwI3tTR34ZKXe5i44pIqjq76ddlSxPr6UcDZFSXX7zAgJvdT+MG9GCBLV2tTQqgKesoAVQLvRwlHwcGw06hqnAfa71iwL1AN74xIcCzE7WJ997L1R+DWQfqrGWo1qsnJlACD9cia+jD4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515328; c=relaxed/simple;
	bh=mNe5sou4Use3KwUXbXn+xWE66+A+aBWpdIZhWQC5j/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=InxXhAueFh0nUUkDxX3oHV++jKoYcuVrYjP921+afCEuC+Ux8YiZwDZQnYp2PTXVIV/niK5y9Xgc8p0dGXq5g+TdD1dlKwgd8OvQbeuOjA8fNcm6LcC4zWP44w+xXTZxVcAFO4UD6FLXDj2ZJHLsO00FwBuNTL30GuIFXBSBlUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp7bIZn1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so2746535a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 22:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739515326; x=1740120126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIZCv5F6HJ4qsVJ+aO0SAA6iDDFstDDEG7Ie+tflEME=;
        b=Dp7bIZn1iQ2vTcFk3KN2NctFo4TFtvBnZG5Zft0jKb2aFnD+6WdkcSx9q8ypMkhCsA
         b+9ruhqlmhJRQ2z5Ik8Jl8NZh7BDlGFKYU/pAlCDwdolfN6uLwiIbZ7maHrDQGbTsnjr
         sZkZ2UjWdlnEYe8VhOeEM28WPFokwT3CUL+GsDNlcRAbQ4Y3r4ZiP0oVqFRuyPevAKsB
         iRS+wBxTRt9mUZkfpk0hC/U3P+1l8+3mq7EYSSXsExKBPuWlwKoN9pagJZDASAFHwMmG
         h5lAFXSgaGtcthkETcbPvgturDNyMxLNGGTMOh3zulRDE6dBXC1SuT7B9HOnJdK0vz/P
         kncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739515326; x=1740120126;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIZCv5F6HJ4qsVJ+aO0SAA6iDDFstDDEG7Ie+tflEME=;
        b=h4Fq5ed8smiVYz7kkWXitXF/Ha8xmcXLeFdF5xdDdpR1Qw3fLYi+DxebDUIM/0QyJ8
         sRgITlaiVxoPElDfoCXUeqZLv16gDgFq0DW+5i4xXIjxnJZ2XVeM+gL4RdZSthN6DQjl
         m5tJj1Lf10sJzZN9HPzzaWnFmunMJLgB5YPtAQeB/2Qp7vpJ7mCeCCo/6c040ripQ9mL
         sKnyZFUtpNS/SunD24W+40y0sqaowbU/h4N/LzcmFflVCO/47pf//Oz5g1D0kXj1OOc2
         hIbFKZRfcTE0/Bu6PbkgFO4vVqJe6DQCamlIN6yszSuasCBEPrkUM9PcMJyfWrnxBEU0
         7Ivg==
X-Gm-Message-State: AOJu0YzBjzs9a6P+ywh9+HAw/U393OrYFEk/8fNpTe/jU1UjxL5g0DhJ
	GhPR4GrodnVDJZGodfe5I8aZEsyrbbGlOvsgfof1pb+0rqgKpYk3Fvg/kPflw/8=
X-Gm-Gg: ASbGnctB3BtB6ZNFo7JrkHSot0r++IW+rsMyV0xveJQK3jHJqUsCkz3oB6MeglwI5w3
	dCWOityhuwxHPO6Pur1ya2asW7Hu1ClyHBHfKOC+IsEYImroBj7Pop/z0qnqddbsfB4YmiKfYHc
	WDLJYGuxYi2e83slqsNGDZw1skRvnsY8qjYrKkNLLUK3JUXr6UNl1/F2rAphPfWt8ScAPLm0/H7
	vwiMqO2OtUUBpQhxKjGgFZoNI1JKZxSJ3FB8w4rIpGh9Qt4THi1GRII3kSsOfIS9MY7+9nKDHKK
	xJpWDFKeL8v6jx/qarzg
X-Google-Smtp-Source: AGHT+IE9qwb0FYQkh08HJphdEiUbZpFBUuPPcBd/KAWmmgLsSCoDP3MajvyoVJD/ILk7zMZ5BzqKAg==
X-Received: by 2002:a17:90a:e70d:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2fc0f09f09fmr9302942a91.24.1739515326410;
        Thu, 13 Feb 2025 22:42:06 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55963b5sm22522485ad.249.2025.02.13.22.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 22:42:05 -0800 (PST)
Date: Fri, 14 Feb 2025 06:41:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Travis Brown <travisb@arista.com>, Di Zhu <zhudi21@huawei.com>,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Subject: [Issue] Handling NETDEV_UP/NETDEV_DOWN for macvlan/ipvlan in
 Namespace
Message-ID: <Z67lt5v6vrltiRyG@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi folks,

Our QE team reported an issue where, if macvlan/ipvlan is moved to a namespace,
link up/down events from the lower device are not propagated to the upper link.
e.g.

# ip link add lower type dummy
# ip link add link lower name macvlan type macvlan mode bridge
# ip link set lower up
# ip netns add ns1
# ip link set macvlan netns ns1
# ip -n ns1 link set macvlan up
# ip link set lower down
# ip -n ns1 link show macvlan
4: macvlan@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 1a:f2:01:99:06:bc brd ff:ff:ff:ff:ff:ff link-netnsid 0

After reviewing the code, I found that netif_stacked_transfer_operstate()
only transfers the carrier state but does not handle device_close/open()
operations.

I noticed that VLAN handles this state properly—if the lower link goes down
in the default network namespace, the VLAN interface in the namespace also
goes down.

I’ve drafted a patch to make ipvlan/macvlan follow VLAN’s behavior. However,
I’m a bit concerned about whether we should allow control of a device in a
namespace from the default network. For example, if a user sets ipvlan/macvlan
down in the namespace while the admin sets the lower device up, should we
bring ipvlan/macvlan up as well? For VLAN, it follows the lower device’s state.
e.g.

# ip link add link lower name lower.2 type vlan id 2
# ip link set lower.2 netns ns1
# ip -n ns1 link show lower.2
5: lower.2@if3: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether b6:82:39:94:f1:67 brd ff:ff:ff:ff:ff:ff link-netnsid 0
# ip link set lower down
# ip link set lower up
# ip -n ns1 link show lower.2
5: lower.2@if3: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether b6:82:39:94:f1:67 brd ff:ff:ff:ff:ff:ff link-netnsid 0

Looking forward to your thoughts.

Best,
Hangbin

