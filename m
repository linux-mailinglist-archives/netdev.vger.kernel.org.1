Return-Path: <netdev+bounces-176714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27528A6B968
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0D83A72E7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD979221F1A;
	Fri, 21 Mar 2025 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgKBqOMi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7921D3F9
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554862; cv=none; b=rDpdVgo6L121eEZmmpX//snejCb/wfRAWpKaerMmqUZvpZlbm+C9+MCTdFPZPYHFH9n+wRKSAHf2Sd+6vmZc9uuDkxVE7F/dAccYqYRVsbtw7rh3jAQNaPKsJI8/fjLk+r3SpR6wU0qCEC5SVL7ap49CV3o/oU0on1zmEoLqdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554862; c=relaxed/simple;
	bh=MClhHYdDYbfSs0X8oLGlhpUPZfPqb+p3CJs/tABView=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2FijNFevTiTxNqZCEV7G+WjAjMc9AWkopNsfH55Qlah9PwNTPWI/+QT7fI5v32lisS6jJp2FCkVeWuvdkzy93edoR3wzl+2/tLyEhv+Xey5jEX2p79nzCpRLreZCZoMADfmE8TlHMEsKYMVo33Urb8yQiDY73Q8ZhJnV3emk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgKBqOMi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742554857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kR92x38MaPIUcSwwuTEs6+JYl/zG4hCrnKTSGKNxEmY=;
	b=DgKBqOMiH2FVqKxz1Dd7St4oJYKQgm4/4mOE14oGvylDG6pPmx8Ts68lfeyInDVwEPvJ7C
	5J4SmGJ1CTZPn/ZagCD75aFu+ScBn5UqgXKEIAijZ1+BF5n3j//wjPtCSRYwtbdZ24AmyK
	v+ZlN/wpECYEqaE1DRS4UQHPQHrRyK8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-mTF1tTljNOaFqWdAEVoigQ-1; Fri, 21 Mar 2025 07:00:55 -0400
X-MC-Unique: mTF1tTljNOaFqWdAEVoigQ-1
X-Mimecast-MFC-AGG-ID: mTF1tTljNOaFqWdAEVoigQ_1742554853
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3a9c3a8f7so182469266b.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742554853; x=1743159653;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kR92x38MaPIUcSwwuTEs6+JYl/zG4hCrnKTSGKNxEmY=;
        b=NP+Q/NTvqFfwdUOMmvS009o9/YRuG5BbWBSug1CcWWM8I6fox548L3RVO3lHIhU39/
         KgoiLXxPmzpec86nNNHCkVvV8GMOIT4NwPZsr9hRXLbXYE2UDdDbNs+jvTML04cWJSnO
         XrGIwUxb7Bjd2enGbr3B3+MLPqu7BX1SLMf0O1ldaTHYNvcb+zkaTeFlaECQGU+FQ1wS
         BkDcqVYbgs0AJEk4Ou6XHJfkgZhh4RYvLoR7NGSdGTEq87w0DFAnOMM3hjecGpYbh3RO
         YM1tO4xtQDv6SxA/tlZI+cgBpznbCKAty/NVEFNhj0F8+Ctr0//sVkyvDO8lxwRnFTTd
         pnkg==
X-Gm-Message-State: AOJu0Yz+HmDTYLdgJs5mqRSd0ZshvpadvRD9ZXQn8TPHZ3Nn/lY+N4Oy
	5+YpS5awgsW74W5CsufH3vCJnN0/rpl3A7c8v2MuK5SGmw2seXwwSlFEKKzPCFnW8ZXv3NR4XrL
	AAY0TfSmth/XPihWxTYN8o0TqQJlhc34mirIJFsUPlvI/9LRT9WSXUQ==
X-Gm-Gg: ASbGnctspJCgiieK0tzUZUx6HVBZrV00r3yEnleke8Xdu1Lm3Gt3m7RYRm8nQw/2tOd
	Vij9taVh9nVf0PxyuyGku8F8LUC3btxZwnbIUm15XjvcNa5e+8CGirDmgR6TVU6mfGeP43Uxrs1
	ypuDiy5PfhOju75u3eD828B//O1P+KmFIhCy8kPx/FPwGe1B1WTVKQeFQpXtoZJcaLGzbeiTLHR
	552CXlraJNCX47BjlHRYRMhw22+elJ7mpqhRtV+wyOYTfXgYo6XQqc1RuJo/7VMYorzOu1BMyEU
	sabl6Q3Wg2VCN33llMqzk3+icjBI5g/jhTzT/7lcqHwXW3qL2/mYc9tbG7OR
X-Received: by 2002:a17:907:7ba8:b0:abf:6ec7:65e9 with SMTP id a640c23a62f3a-ac3f24d7921mr264857166b.43.1742554852929;
        Fri, 21 Mar 2025 04:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUELeIFk2iV4bJhmhlsWZybhpWr1ETkAjOnrpXoDFpNR4vvFc6TbQxKArtqciFKT2yl++k2A==
X-Received: by 2002:a17:907:7ba8:b0:abf:6ec7:65e9 with SMTP id a640c23a62f3a-ac3f24d7921mr264852566b.43.1742554852498;
        Fri, 21 Mar 2025 04:00:52 -0700 (PDT)
Received: from [10.44.34.122] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef93e1bbsm129520966b.81.2025.03.21.04.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:00:52 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Pravin B Shelar <pshelar@ovn.org>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next] net: openvswitch: fix kernel-doc warnings in
 internal headers
Date: Fri, 21 Mar 2025 12:00:51 +0100
X-Mailer: MailMate (2.0r6239)
Message-ID: <1FAE19BE-E1F9-4836-9AF5-5EFB7FD291AD@redhat.com>
In-Reply-To: <20250320224431.252489-1-i.maximets@ovn.org>
References: <20250320224431.252489-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 20 Mar 2025, at 23:42, Ilya Maximets wrote:

> Some field descriptions were missing, some were not very accurate.
> Not touching the uAPI header or .c files for now.
>
> Formatting of those comments isn't great in general, but at least
> they are not missing anything now.
>
> Before:
>   $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
>   16
>
> After:
>   $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
>   0
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Thanks for taking the time to fix this. The changes look good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


