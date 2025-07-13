Return-Path: <netdev+bounces-206466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9071B0334B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 00:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FDC177605
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1D1F9F70;
	Sun, 13 Jul 2025 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="n9WvhvAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5A1F9A89
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752445249; cv=none; b=uoyKEwqF+XBkhorNDzh0sCSsseXnWayyWroUOSGX3vxw+Y8xGT5XmYzOaDG/3lgQIhZd6zv1txuYpTncqbM0vpvuiPtW9r1R2hlAMmpYhEevj3YipAHEv5xqgRlq+E3bpnHQ1Gbyn7to3qiKeC73ImDHAn18ZLoqO2ZzuZK3jQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752445249; c=relaxed/simple;
	bh=b8Q+RIb9crzmuYHL6FAJrZdl/WrcXsxHGXyFyrb9sBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWUAT3bzTwpnMTQhNooI2Ad1gj7sJIQpA24yGkPFr7CaW8e8EcbO2T4ZLxCHgK0M2TUp8PIpFYJxvO3K46cse8goTZfQiQU237Z34WHFCiZpdtkQEfMFJxUCmlhUwy5c/VUPAlqwFV1sPEvSDovqOzKTIb4A3KrEg/Dxtntvvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=n9WvhvAG; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87f04817bf6so3687922241.0
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752445246; x=1753050046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTaBGTdzUK7Y2CQhpoGApAKOtMPICq7gXimiXmfB7LI=;
        b=n9WvhvAGLNggFY+gA43yEBVSCw+uAU1JVJhb5Kte/TctSCNBitoEfGgVbnmEv1D5TC
         Bz2hlzaJHmqJoqjdxrBh8Mf5eGLVtC1y/5NypRMxG6FM94qk1vC2UfLSAkC73T0apQQ9
         z2qAIBb1uIS6NMKKjhM2PKHjhY8nV3vANhKDan97LRoo/Svo692/n4iMr1gyYSYOkYyg
         AQoFlKlquIWSHRBBYust6gFmOrIE1BVVXyytAGGyk2wILInf+slwV4Yvj1+xPsfALvMH
         IUG3um0f8j0O+y2b0TBmHR0xzKIhr2JYwiTTtN5+PjxEi/nV7VZuCcStTrqaFRR9GmIH
         1uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752445246; x=1753050046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTaBGTdzUK7Y2CQhpoGApAKOtMPICq7gXimiXmfB7LI=;
        b=vscDyfEAsKrPX4ZCLwu2VNenSTAYv3mtCWchmux6+v0xAE9jvBKxvSVvf58rO+5JOR
         Or+g6WiqGfSQv1I+eR+6KcMqWKIAsXfIwQ9RWyD/YNkVe8t80bShDzGF4gaPrgfaO5Vp
         6yt0vQ4ETxhZRFJuUInHir8+Eei4DlLNgs1TUSLGw+dFEcvymiHgn/FXAArHPCixvo/S
         KEQGDeWLfyl2w0SGiA55BpsFduiKcL/KLkux2rfEqSDbkeL9014tvk8w6cRq+nnavIcU
         Fmmribh/a25hSdpIFBRnaxEY+CAJKLMEZyNERGXl4JqHG4LsaxpEu30dnzb+/u8rK5S6
         3Cqg==
X-Gm-Message-State: AOJu0YzbpUTeKihwLzKnb6/6tRPmj0lBvCSxkdUcJ0ZptIf9EPUA9u2C
	gBaoJxnKb6nh7NBe6Htsoy/QoQLrgebTFJqZ1ZJqQ8rFLscGpHAzmjbUURGE4c/1crhcjw+nect
	E4CxT
X-Gm-Gg: ASbGncvKMs2pswncSwMSjJhPPxLyJg8K/EXOG3VJCrNKhy/kOLep5OnIVP+1PwfCsQS
	Rc54CDgu8qZ9o1jo9xe8YlbqbwWavXWQGxb+p0sYXmKLrEP/8u7aowI5PqwyQK8CPTJwiUcJlUF
	2KmC2auhA08sjbwzHu7LnLOzcHm7EERroQZFeClX+18sZWbB+3KSAN8Lp8a+qxdpXIOfCyQYw29
	jLfZDOVMAxVwarB/xXQIJxAqWWD4IIB5OUYZru0y7Fenq53scI/x09uO7Uk5+2GYXgRHXgaQGOa
	OjL83g1DnOn770HTHWO23GiNUqRObZYYw6Chmx18t14QKDHlx7We5VIMFsPnTePBsJhQUEv5Xig
	voWV7whjLOhEwKBkk2hO1DSG+jR8kL+4LwgZGm+V0PkxiFhHMNmOdUizD0Nq9R/hKMubkTx8Woa
	mFkdq5ZRqChA==
X-Google-Smtp-Source: AGHT+IHAoFmZSdM88w/GUPjBhNoOvYVCrHkXxj/+jMNCceV4Vd9vM6Xx2kd+xok20symjdcruWz10w==
X-Received: by 2002:a05:620a:4141:b0:7c5:a55b:fa6c with SMTP id af79cd13be357-7ddece12ee7mr1468699885a.38.1752444743898;
        Sun, 13 Jul 2025 15:12:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e31a495a40sm39004085a.105.2025.07.13.15.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 15:12:23 -0700 (PDT)
Date: Sun, 13 Jul 2025 15:12:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, will@willsroot.io, Savino
 Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v3 net 1/4] net_sched: Implement the right netem
 duplication behavior
Message-ID: <20250713151220.772882ab@hermes.local>
In-Reply-To: <20250713214748.1377876-2-xiyou.wangcong@gmail.com>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
	<20250713214748.1377876-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 14:47:45 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> +	if (q->duplicate) {
> +		bool dup = true;
> +
> +		if (netem_skb_cb(skb)->duplicate) {
> +			netem_skb_cb(skb)->duplicate = 0;
> +			dup = false;
> +		}
> +		if (dup && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
> +			++count;
> +	}

Doesn't look ideal.

Why do yo need the temporary variable here?
And you risk having bug where first duplicate sets the flag then second clears it
and a third layer would do duplicate and reset it.

