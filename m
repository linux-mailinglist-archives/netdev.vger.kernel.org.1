Return-Path: <netdev+bounces-222771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD6CB55FB2
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 11:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8DF3A58BC
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361C29AB12;
	Sat, 13 Sep 2025 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hk9Ji3RX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D71B5EB5
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754248; cv=none; b=WuXzRgWrvuFysOhxhTAtMJczCj6QYu+nX7DwBpz8Ndxoc73evik41Bhd5ZzHTTrneVk+lMCRg/5DwrsmXJujM5w9W52zCXt3gkGKPHWVBNmao32YeDhx6h0jvjcD/L/AwnqgBPvDTZAnWp7+7KUd4q3z2UpUubxe5mjbSAD62o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754248; c=relaxed/simple;
	bh=UVVvhK2i7Y2RoE3+f00O+S3W1jVZajQywCamG7ZRhvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rs3sPr/DMmaKJ7VeaEBUBoeb3WGaU+sunOj5oVM3Vpz00KoHOXzkNqZVZlu/8wo+ykfokj5KZZaNWWL/80ofb4QTJWDUKRPfhoAJHjY295A/KGytX2mf1gSV+sAs/LYuj8kAkv5GauTHG1K/l754BO27jR47i1e3OWz3cJ7CBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Hk9Ji3RX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso4586141a12.1
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757754244; x=1758359044; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVVvhK2i7Y2RoE3+f00O+S3W1jVZajQywCamG7ZRhvI=;
        b=Hk9Ji3RXPcI4aTwd+6OMVgPA3FjHCZakfDt/7TFOP3MT9C4skseWn0XdP6GZF/hGa4
         KAzr3lWUSFq7qlJ4pQph1IXTUW8swGdge3wCSeHpVwbJgwQKjJ/CYsb4D07p4OIJKIEA
         jQOkiC8ry7uBd6Q+lmrPf2syZ8K0CTgN7/1N5V8et8IxsxpTonLC/ExydeyhPv7FqLve
         jCujm9QroXXMI3izULNtdPcyyHzQAqSR1QQroPk5L4gntAJeJwH9wx4QRNqmwT3fpUt2
         MMvf+nT7Ki8Me6tLatTmCxFOuNEeQEqLo1xlIylA4LG9wD8hDu5Nuifc6Xs0vcxYHCr4
         nmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757754244; x=1758359044;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVVvhK2i7Y2RoE3+f00O+S3W1jVZajQywCamG7ZRhvI=;
        b=DpoTme8tczJkKoilTYxsY/3Apu1WODvIPb8mRPRUL0+FjHCwBwC8l9jejat6jqUDQv
         29tkaNXx4OEjmpI90IF+tcgfD55LIyORghb7nhM+zNq56DlgEIc1qfZBFC2LWChBBMo+
         2PH7JYcePrAvlMpJY8YH5mNxkJljXyj0CMY3WZFre/DdPUWUhv1SkBV1Fyh5Zwf/72Cd
         CwJZtH9Puid4K+4a2R5IEi5xUma6mGpa2/ApC2UaUuPmplqXVGMOor0hUTr49DwTMbbf
         /eeZQL9TXyoyXi5dmjQL6x5mHck2gYHOVM/3HsW8KuvjJhm18WQS17qcIeHcGAyA0trz
         rqZg==
X-Gm-Message-State: AOJu0Yx2d2sKoQuLrCyM+wQJh/lCPZXiGVzgz1Ke2v3XvpOrDMumGKr9
	wOUa76s2D4PfDlkhO0avcEkgG4CFcGp8I8uuZiHIQcSn6ckDwnKMXOs2mAjD4EM8KDg=
X-Gm-Gg: ASbGnctwtxkDOQ+5DTAZOOWCURdKF6cBtkp6tbHdFg1Hw8nmiJ4HfNPWWQTO+hN1ql6
	x3+1KUVfC7SGjTc9kJDpAhPYR8SMtctJvl9FaLSTuNIXe+0gAlxcusRzPhA0Pm/4S5UG7VuwZwg
	Ag7m3fqMNKbuhZg12srUKUzm8A4zwxxz5/x1t8phltovgWpnIV4JuaSs54okYMknEIjswnRwKb/
	tHiSKMI5AI+rGi4PC/LR42sao+p2qB1ocQCRcKpe+JATIr8dCLrL96u9U99smwnefL52kV8aeJg
	iqgEqu7U7G6fERoRagU1tSKV3rgT+4PSdcsiBAC8X3A5B17Q5C2/ZJmqlL4bggCx7NMlH7SS4oH
	EeYgyBNXAB+770znybInDrWSu
X-Google-Smtp-Source: AGHT+IEmRoINHFXW/b714jq1nah0puvwxLmdIa5RnYaQvTLCE16E1IGzjYI0PWNN2KA/kQnxApRjTw==
X-Received: by 2002:a05:6402:84d:b0:62e:d473:8582 with SMTP id 4fb4d7f45d1cf-62ed827098amr5640856a12.14.1757754243820;
        Sat, 13 Sep 2025 02:04:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2dc::49:221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33f57dbsm4923806a12.25.2025.09.13.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 02:04:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  Neal Cardwell <ncardwell@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  kernel-team@cloudflare.com,  Lee Valentine <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next v3 1/2] tcp: Update bind bucket state on port
 release
In-Reply-To: <20250911180628.3500bf0c@kernel.org> (Jakub Kicinski's message of
	"Thu, 11 Sep 2025 18:06:28 -0700")
References: <20250910-update-bind-bucket-state-on-unhash-v3-0-023caaf4ae3c@cloudflare.com>
	<20250910-update-bind-bucket-state-on-unhash-v3-1-023caaf4ae3c@cloudflare.com>
	<20250911180628.3500bf0c@kernel.org>
Date: Sat, 13 Sep 2025 11:04:01 +0200
Message-ID: <87a52y67we.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11, 2025 at 06:06 PM -07, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 15:08:31 +0200 Jakub Sitnicki wrote:
>> +/**
>> + * sk_is_connect_bind - Check if socket was auto-bound at connect() time.
>> + * @sk: &struct inet_connection_sock or &struct inet_timewait_sock
>> + */
>
> You need to document Return: value in the kdoc, annoyingly.
> Unfortunately kdoc warnings gate running CI in netdev 'cause they
> sometimes result in a lot of htmldocs noise :\

Ah, thanks for the hint. 'scripts/kernel-doc -v -none' didn't complain
about it.

I think I will drop the doc comment altogether since it's just a private
helper now and the flag it checks is properly documented.

