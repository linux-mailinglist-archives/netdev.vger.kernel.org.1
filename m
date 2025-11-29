Return-Path: <netdev+bounces-242689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B76C93A06
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 09:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51E284E0F79
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE9023ABB0;
	Sat, 29 Nov 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ijsf8ekD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1602AE78
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764405342; cv=none; b=El+bFopaoCZVwK6rmeLL3SWOFpLBMOahTDddgJYKFhoqQZ6sgABdWuXHcyGQEedv/6KfGJeKYuUPdFG2FGJHAF8kp0bcsTdJeGlnF4tyr6ObDlAJDD2xC02fHwDIf/btlj96t2uN2Pez8+T5Y07CuhIkXOIfmF8Mtbdwf2VmwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764405342; c=relaxed/simple;
	bh=1IRjpEHM4HBHW8htk6xlFxikfTmk8bn5I4KnFr/Mt3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2nxFToMrMs4ZZVB98rxCecakSFom5EaqKgqtpml56/HZpM0dQF9yHG/fQ4QZ6v6DLw8Ma5GFNiR+O4uxyuPq+PEQUokq2tVYJ9WoD5e5jxx4mxYTdn5XCzV2MBUKN8CCjcwzUay16ry9e5/XjMrgny03+Hw41VPulzN7nRCvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ijsf8ekD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2ea2b9631so243849485a.3
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 00:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764405339; x=1765010139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IRjpEHM4HBHW8htk6xlFxikfTmk8bn5I4KnFr/Mt3o=;
        b=Ijsf8ekDIPNbuv0/G1VXYtVHCCGCKlzA7pvnFNT948mEs2tKiyBuuTGiXu1vzrrYMx
         cLQhKfYthMuNKBFJ32iUV+ugmb86ln/SvLZV/5V4OoBTAXMLCzg5t+Y6zUScJ4C3zM5w
         laZQk0C39ipjV7GgCngzDaEjpDwcjTLdtiJ1Jq+z83KUAAJ0HdXrzDPPH5+2CnRzTB8R
         OC4QIy5iAqu5fnF5stJEmQ3Be0EJ4BY6kVRZ393NZy6sZNhXicsXj6uRqObP/syxaaEL
         0QT3PPYbsctJTMtjzpbgjQZGh3xJ+6BwdskV+GCspZpPta6bZg2L/NsE67ZV+dRON61L
         LuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764405339; x=1765010139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IRjpEHM4HBHW8htk6xlFxikfTmk8bn5I4KnFr/Mt3o=;
        b=gKp2aLwVXglVdpv93xixWBG8Ai23st+N9ygl0LqStERJKmp7fE8SERezk+UBxe39e7
         MbFRdpCeIshK8KD6KWFJirH2MKOSQjNLhi7B+M4LKyjMcWQlc31+RU1Yc+DZLf6ETTpA
         yqFit8WzuU7RCeNwx6sOyuOO02qwdz5XgckxYs+aSRbW4u2tAl0g1EgIPVWXYp5mXATc
         BsPNFGsTL+aVX6b1nR4wHXlAsjvn2kJmQcaZvwJmnlnd+tsmCi4ilvVVhGv2JzCyT3A9
         FQU0TJZ8hvjAYYrDuqaNZc0hAEadrOI1mQqSslpKRL0GMPZi4KUZYqkNJpUnRFirpWND
         FNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR4oZf+JWayyYs42oQ7z6Up6vR+a+5vA2Gjg/jq60tMe3SsWHmr1f3U1KiMFhaxujoAs//5JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmiPz08XAyyv+CI/gVM4TyASC9tnDm6d5uJTN++HiG+blDNAgp
	92KjY+Furru8cWkdspdlqiFtDBORfy6l4CC/3NoyxYWmBNht9SgCZaRyG/MGVSr4J4Wiug1xtvf
	dYvxKuGfoB2jez2C3AsF68c/GNNXg5FpQg1j541Z9
X-Gm-Gg: ASbGnct6+FekoyY+mh3q0+wK3zxiZrdGQaqlh1xADakymW6Y7FrEfODvazUxgB88bB8
	H5U2SU4ixDvLXP/mBuwizPDHZt6iIiEXuM77HUJYb4A1yvYETw+IRDs2DcntYrCmk1yAUrz5hKO
	Dl4Q1VykfeQeJcckwYq+fvi4pi0SEib3aOE2MGQdlpwCsc7uGeL5CEfWXFFYa3rhKstgAgP9Irj
	JO5Oqoa8uR6W1ZPcmZysmVQfb+js52+EDpOMNSGBs0Z4N+rWNm8oPxPLeKylOxbeP1xLg==
X-Google-Smtp-Source: AGHT+IFeJZI8tA0bdZ33NL+dojMsFeaOMfmt/IXmLr+F64U9GAPiq9ayj3OGYuWJH1LbUspmts7t8pl8HVpu+KKDUa4=
X-Received: by 2002:a05:622a:2c7:b0:4e7:2dac:95b7 with SMTP id
 d75a77b69052e-4efbda5948amr298947511cf.37.1764405339375; Sat, 29 Nov 2025
 00:35:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083455.67474-1-fushuai.wang@linux.dev> <20251128194500.052b780f@kernel.org>
In-Reply-To: <20251128194500.052b780f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 29 Nov 2025 00:35:28 -0800
X-Gm-Features: AWmQ_blCFNdlLrKQhvV6Moa4pW5Tx4vTHWH89naE2otW1mRyhSkwuPMcGeE37d4
Message-ID: <CANn89i+0at_D0HXr0mEt1AbANKWRkcE9uFq51JoC==BQ+W1=wA@mail.gmail.com>
Subject: Re: [PATCH] rtnl: Add guard support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wangfushuai@baidu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 7:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 28 Nov 2025 16:34:55 +0800 Fushuai Wang wrote:
> > Introduce guard support to simplify the usage of the
> > lock about rtnl.
>
> We don't accept APIs without a user.
>
> Also in this case please read:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using=
-device-managed-and-cleanup-h-constructs

Another argument is that we are working hard to _remove_ RTNL these days.
This is a multi-years huge effort.

Adding such helpers are spreading a wrong signal : "Look how it is
easy to add more RTNL sections in the kernel"

