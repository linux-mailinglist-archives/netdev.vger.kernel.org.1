Return-Path: <netdev+bounces-152875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3A9F6263
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A2E7A517D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDAB19924E;
	Wed, 18 Dec 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh8iQ/8Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C715155345
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516516; cv=none; b=bi4l4Ipw3GSUD9pSuNsR4rn8mg/tn5IozrHo/kR+VUOQh6E//OLKeU1d6KofZTGgowZC1KlxZ1h+IFQLe2HpSe4x7H6l2/iOLaRSe36U9JrT3o0cgoOiNQ7s1MnyGxZY9JXBtYJR+7ywc+qjaIoLoaKZUQI8jpv8O16klpb/iFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516516; c=relaxed/simple;
	bh=McJFBGRi73qOskvj2dJzcmMaMHZrowp+ckL4fxI8kEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+beESHIBeapHG7maZCDxLs1OaK3U3WcQDs6UpxBkKeW+a9JKTNfdwVzpnpxlQwDlkejzp0fI2zfmJJMVv9UtpoAnKCkZmHVZ97ZzayWnT1kfIq/TNbwl4HNnhFafsHzOYyrBtwqMVtlAyDJoqa8anXDwRfurih2YAfNCAocN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hh8iQ/8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734516514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=28LtfQqtpdHfDU07S6WF6bvRxmpMXf24CtX5DCj2iy0=;
	b=hh8iQ/8QtuS0m7idCpZYOXuCrXxi4C4Ge9VRZm5yOsCEWpAPCAqyGtmuv25Cvqupbm27w4
	LkFKgwjAh5KvwWeWAwDdxjsfV1CNKCF6AIE4+IRR3Np7yulQPaz7sABHic0oaiOWOYOJym
	O7iRJgNQ4DNApnnijA9gqZ17t03lks4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-YrJfWyDHMgO1lG2hVG_PHw-1; Wed, 18 Dec 2024 05:08:31 -0500
X-MC-Unique: YrJfWyDHMgO1lG2hVG_PHw-1
X-Mimecast-MFC-AGG-ID: YrJfWyDHMgO1lG2hVG_PHw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa6a831f93cso668682666b.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516511; x=1735121311;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28LtfQqtpdHfDU07S6WF6bvRxmpMXf24CtX5DCj2iy0=;
        b=acsd0QmsdKf1e/417KeWyTdxXoOSu0XsICYhqSMSIJNhyAYkWSLKXnza6p0RFKrVPq
         HSaBalC2x1UyErA1DoYUUxbqSTeMYyz/cROQnt3m9jBrVPKLc0OQyN+TASIWkEHadmkl
         R25p/6VgsnbSyO9vrHaeZpxhpfhoF7ufTCI9Wlok+jKnkkeMv4637jf0yUqSSkJiyp09
         ZnvEGcOmCodyjM7nX9BKnXtsSDadPiS9LCBLKU8gT9y+kiF3iRcgJ3q+AuBvcty/gmrL
         aUQcGSpH0k0RFQ1kAF38QFbx0NC3cCqjfPVsAZ6ehauv2h9EVkesI1mh9AhGGv1rktNT
         zvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh0PM3+gyoz/Rt5wPMvVrQXXQRU0zEkU5eo6TbVlaPKlPN44qspYiG+nyP2VLvIidBCQFeE6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2CxJAfmbwr/zWxKPAUQbHR1MIwqzG57v3KWtyIiX27MfhcgIJ
	VLzFrU/8QKMmlLTfkwKLNe3yNQQiR2AAFt0GkDRbUJP+0oSOaAURPnTweZE82fjqq4nWmdlpOmK
	f0HV9IvZThWpKiv5FYxfBKcYBzuWkWSl8ACenTfoDag86pSX4jjOGjA==
X-Gm-Gg: ASbGncsxXG6SvUmtsxdIwvLH7NjPupHnql+zyiTXwtEnKBlH4mNpZhR2m78b0I/LUyZ
	sQOwqAVfLtkGTywp8qoRt3KH8uwSzKZheh9Pz6kE30//4zT1kSVge8+P5gh50X7nok7peEmEsa0
	CjFcuIEE6mKcsR3SidC1mKtExu75f/HBMkj/PbzUp0lAFATfF0Or9Vr/mWL3Edg2sIrQVin7Amt
	UyS05MJ/ukYM8wGFxDMleONtW8H5b+u7WDqYnMN5BgudOI3xrlt1aQI7UJKXfLT/7NGV6WvmD9H
	10DsKS3ufa7V7W02gphyrrH7cZM=
X-Received: by 2002:a17:906:ee88:b0:aa6:950c:ae0e with SMTP id a640c23a62f3a-aabf491e146mr184739966b.51.1734516510647;
        Wed, 18 Dec 2024 02:08:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElz+KnDnIV4/z/HLgJGjKzAErVWdv9XAf6U6sQ+wwJVIlLKVdwuAxA2tbLvawq9el84pF0yg==
X-Received: by 2002:a17:906:ee88:b0:aa6:950c:ae0e with SMTP id a640c23a62f3a-aabf491e146mr184736566b.51.1734516510242;
        Wed, 18 Dec 2024 02:08:30 -0800 (PST)
Received: from [10.39.193.174] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96067ef1sm534517866b.48.2024.12.18.02.08.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:08:29 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: linux-kselftest@vger.kernel.org, dev@openvswitch.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] selftests: openvswitch: fix tcpdump
 execution
Date: Wed, 18 Dec 2024 11:08:29 +0100
X-Mailer: MailMate (1.14r6065)
Message-ID: <6D309AF5-AC5A-4F68-9F86-84E66AC0FB4F@redhat.com>
In-Reply-To: <20241217211652.483016-1-amorenoz@redhat.com>
References: <20241217211652.483016-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 17 Dec 2024, at 22:16, Adrian Moreno wrote:

> Fix the way tcpdump is executed by:
> - Using the right variable for the namespace. Currently the use of the
>   empty "ns" makes the command fail.
> - Waiting until it starts to capture to ensure the interesting traffic
>   is caught on slow systems.
> - Using line-buffered output to ensure logs are available when the test
>   is paused with "-p". Otherwise the last chunk of data might only be
>   written when tcpdump is killed.
>
> Fixes: 74cc26f416b9 ("selftests: openvswitch: add interface support")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Thank for fixing this, the change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


