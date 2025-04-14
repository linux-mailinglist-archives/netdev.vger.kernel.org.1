Return-Path: <netdev+bounces-182053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C45A87857
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17EB1892435
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 07:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A181ADC7C;
	Mon, 14 Apr 2025 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZGkpFXN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A225776
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614194; cv=none; b=fKVLJXB4UdKm4kmKBZKJztwWCSoAP/4soo6rVgKbKARYS9C74HlfPe+mVoFT5TpaK+6YMFr3Yu2d9C5E9TjgK6ODZrO2quWyDgB2snmZumxmvEXld20UMQPCtOJONXKf8I6j9ztoDKQxaiOjIjLtq/QFLOclYJocMMfkCnOqKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614194; c=relaxed/simple;
	bh=M8n0PSHddyTE6fc+cZMW8tLH2wTWAC9GQYr616Qmvlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwaiWpfCNahfXgKxp5DQA573gknzp1yPC9yCdBm9RgW/eJwRtTKPu4Ckqqj2WQrU5qOvmeJu412uq0VAuFcj98ItsCm4KaTV4JqcK42esyOoDUcKkaSBHrvW92aV0qVQMWTgG3cXAL/LkxGI253tKtJ2nLj5Jh0qYzKp+QVkNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZGkpFXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744614191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ4c0a3Aexij9u47Hm76JUGfKE2lcIO7FCQlwEhiSF0=;
	b=dZGkpFXNsGg/U8jaHidpE+xbw1IYKSfnGZUw5LoeK/HNqKj039QfbTtu/KwzunU+YMgvRF
	L52bABXh9v9ssm+lit9YHCwTckTRu0mbqWOuhHx2du1LYzMgXxztHZR//F1l2kikdLwszP
	XaUdGxFdmRlKZooa3oum+tG2iAIHrDM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-MceeAE3LMRqgrnDhF3oA5Q-1; Mon, 14 Apr 2025 03:03:09 -0400
X-MC-Unique: MceeAE3LMRqgrnDhF3oA5Q-1
X-Mimecast-MFC-AGG-ID: MceeAE3LMRqgrnDhF3oA5Q_1744614188
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac3dca41591so364911666b.1
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 00:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744614188; x=1745218988;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ4c0a3Aexij9u47Hm76JUGfKE2lcIO7FCQlwEhiSF0=;
        b=YgEp6j+RKtxtriqWXso018WY8VQTMieALz8r2ujJDHh33c1ssWYEjckLRW1urem+yg
         Lu/ocGbhNuRsg5k5Dj0d9Q62Y/O3CHGyoW27546dLYC9aPulu0fcXh1BhMDjHIA7khpN
         PebKnNAe7YeYGGyn3xb2HHmWcSj0bum/qFqkpJg4eFSUQo7h9Bhxad4wGhZ/PW+NatpF
         O9q4nbhtEEDHF2c9RQwx0RhF9jhDTwYODd79dumNjAREaQ7Uj8cxoRf6EqPK91x6i7pS
         NECKbvS9dmk2hAamPChvw0zUg4VXTUDxJULYrQ1WX4S+E6Ev3ACBSy5HrRCKumOO1MMV
         Norw==
X-Gm-Message-State: AOJu0Yy/AUkIKPtWvLoiEIfPxLHKfgJVsRkcpWqGIUEJdkxxQgsbsy+d
	/Od//Dp+uFudYvitd9ppwSfo220ahmpwHiWUIxSdHOSK3H6ltBpiGVbm281WHBcokll60njsnBA
	v3pncEOIaoTa7X2IObFloMwVOiCGhz/6MNZDSSNLwTofi/4U778vFoQ==
X-Gm-Gg: ASbGncugf2jRXxWyP45JAtecaJ9z8WPK/hq4QcS4zplR+lr8S9Jk1JEmIbdqyxwrSuj
	0UhiGqpvyxFa/96cAjGZgvdoUcX3IO3MChpwt74G0Sl42y2SGbtmN6oUIRgGQmZ5SwTcfld4OEG
	RoWsFBjtINIhnO5zycKsJj9UdCB4rsTrhgf9SwvbI2nd6MRNN2t1vzbzH8CwGbCtX9rWLlTqSg8
	obpmEHaL+CLdW5ZiX8pc1xny10a1DvVOqi/3x/cT9Qynd6l/akDyFQA46EKIF/Z6uVmzYu46M48
	LH3TbwU3WXaS9cYgvR4+ojkVjcNq5hLRbxjagnCTDjuf1QiWi6H22Q4=
X-Received: by 2002:a17:907:3d0e:b0:ac4:5fd:6e29 with SMTP id a640c23a62f3a-acad34d8a60mr1051268266b.26.1744614187911;
        Mon, 14 Apr 2025 00:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6kUFXmElchnX/VTz9gfGixQp4NvnPe/DcOgLrFIMflSHFpxy7Try/58ehYN202cHqJyyGXw==
X-Received: by 2002:a17:907:3d0e:b0:ac4:5fd:6e29 with SMTP id a640c23a62f3a-acad34d8a60mr1051264966b.26.1744614187474;
        Mon, 14 Apr 2025 00:03:07 -0700 (PDT)
Received: from [172.16.2.76] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce818bsm851777166b.182.2025.04.14.00.03.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Apr 2025 00:03:06 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Aaron Conole <aconole@redhat.com>,
 syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: openvswitch: fix nested key length validation in
 the set() action
Date: Mon, 14 Apr 2025 09:03:06 +0200
X-Mailer: MailMate (2.0r6244)
Message-ID: <8141724C-7CC1-4715-B5DF-0469273E8358@redhat.com>
In-Reply-To: <20250412104052.2073688-1-i.maximets@ovn.org>
References: <20250412104052.2073688-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 12 Apr 2025, at 12:40, Ilya Maximets wrote:

> It's not safe to access nla_len(ovs_key) if the data is smaller than
> the netlink header.  Check that the attribute is OK first.
>
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Reported-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b07a9da40df1576b8048
> Tested-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

The patch looks good to me.

Reviewed-by:  Eelco Chaudron <echaudro@redhat.com>


