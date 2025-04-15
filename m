Return-Path: <netdev+bounces-182536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCC5A89050
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658B81896F33
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA228F7D;
	Tue, 15 Apr 2025 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Pi7YOLJE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73B14A8B
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675461; cv=none; b=mxVoKmLNZsEx1cds/ZQARg7Ps54WIeLOU9clO+SkTbAJmPxjQBIxF6jOwIphYZY0QvVrV5sPA1qLZ23uLLGpjm6KiUulLwVQQK8XAGlaC06ueP0SajEcY3USe1rRBB/kUPw7i9nrywpmr1G2C1s0BMcMPdgFfuEz4hV7L2pvX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675461; c=relaxed/simple;
	bh=PS719wBQYAW0LmE7NqcxyxUPbjHdJgEVyJDECQFpzqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSmHn3lbY0yqBb8tyVtOQVfPtBFPWiVQUV51MQtdE1zdSDSQLL3JbPRxanHEE0zRx1H9nzkyLGCUPCTFpxKNEh3kx2iyvJhrddAfuZt65/06uRyOjiqhAb6HrJeqt/3xEwwpqlr+aHAjYu2NOz5R141yKDzAfZhTlQNk6lq04+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Pi7YOLJE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b0459668101so582582a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744675459; x=1745280259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9rKcs9i0K6VnxdiF/QNrlfIo4o35VZi+xWyIIsDano=;
        b=Pi7YOLJEjEol/SNoHJ5yMq78/fxmkKSRS+tjmSsSzoseK8edIGO0XNIhsGvT5Tyoxk
         uDwcnc4WgPH5gckVTq2F4G+IMqFJrafz9Qjjd5I2hSOAWUG2MolPC1fIJHnjFPq855Hf
         Y7RnhI14MljBUJNouZLkq7NtOP+YcBIWyj5spUzThtiZACoe50p5DT5KUfwuHTLPksZV
         33fvLmiuE8VIxuXNxQU1muhIWbstx12SHWXhvfaJnejISPGX0wMH3Z1LkvxsGbxb/tvu
         4ys1fRmAkVTA6vXnq2BsOB0aLrC+AOweJ57PY/UoXmyJKQjD1BsSa3Y+xvH+46r6Qyz8
         Sdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744675459; x=1745280259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9rKcs9i0K6VnxdiF/QNrlfIo4o35VZi+xWyIIsDano=;
        b=iVmyJsRLI/AunQVl5Za8LRk9KbVf9OjjSRTZP63H9yWSztpSFLaPk7gUUo87sQqf5P
         4KEOmLLnbp0AwoT8YADsxrJ24+5+wQJmouEERmf+en5Uxkhv2SnEUz14G38E+p1k0gfL
         mihwU0WJK9uzSigib/vtioc8353qWiP6WHilkuEwpAARwAFC1E6wAlINnZkcRBJZ3Vn/
         jL2trBy2s7bw7XPLXkrCGFQVY5Yfz2p9sMCcu4KFvJKAQyGAbxasXWi758hm8Vxw7NqD
         8D07/WKewy0zI4onzNu7R3YGdNrqmq96bbQ3TTwZ79Qm993wtfm4iz7RRKqEo1/jyHk4
         3LCg==
X-Forwarded-Encrypted: i=1; AJvYcCVNwU3G5DihPS7EwCYNq9HvRThZeyQV3dp0dPwQsBl9QPme3hqBcKWq3yBBhGZJK7Sla0kBLIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZ8pqvugdv6fRGIGi6UYHtuUmE9DScyAj4q96J6MI1LFCv4F8
	b+0c/1oVnLfnmh7tJwUOZ7RIynyZyJlctbaOUoQmAj9lslR/HgjTSkINxhTonDs6U9VptHaoZD7
	Ej6U=
X-Gm-Gg: ASbGncsnvP1o1nZV6odY0UI3f1P0nK0ClGrpYqq2KZ0RXUj5DDmJiR0x+dCAksIR7vq
	hf8IXGhYl00aZ2yioXy5Ukf7L8uFTys8NcuOvn+xLWT9Skfx26Mudu13yEeR49NY9YdCb96fVgD
	WnhHaw45ta8mZhGRvRgAKXC9yM4EESlIlJ9GoC2OECDCtshot0KFq47QGEoHu0yHhK9gsrdrbgW
	uSQjQdjZQ4szWvME/sK1eWxCzCuSgsoSTfp1+y/u200hNH8un1nReCaSAEd0sLKU9WakoSNa96H
	byam/rjPQf++HLB7m4P4XrvC9DrE/0SPOQYGDbpoNbCKHEIIaBUzoBaegikbD/zsoT9UzLOFDt7
	m5h7r
X-Google-Smtp-Source: AGHT+IG17xyjLQYSxoGHSzwwxz9HQWruNpOX+0byalfl7FguPA/0Kgk/qVoty8eSfPjWy4fsnd/axg==
X-Received: by 2002:a17:90b:1e51:b0:2ee:acea:9ec4 with SMTP id 98e67ed59e1d1-30823775b41mr7825282a91.3.1744675459130;
        Mon, 14 Apr 2025 17:04:19 -0700 (PDT)
Received: from t14 (135-180-121-220.fiber.dynamic.sonic.net. [135.180.121.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10e4c9sm13265068a91.10.2025.04.14.17.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 17:04:18 -0700 (PDT)
Date: Mon, 14 Apr 2025 17:04:16 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v2 bpf-next 5/5] selftests/bpf: Add tests for bucket
 resume logic in UDP socket iterators
Message-ID: <Z_2igISGVwL9yqM-@t14>
References: <20250411173551.772577-1-jordan@jrife.io>
 <20250411173551.772577-6-jordan@jrife.io>
 <315cc79b-fc63-4164-9725-8b5fe2fb27f9@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315cc79b-fc63-4164-9725-8b5fe2fb27f9@linux.dev>

> > +static int read_n(int iter_fd, int n, struct sock_count counts[],
> > +		  int counts_len)
> > +{
> > +	struct iter_out out;
> > +	int nread = 1;
> > +	int i = 0;
> > +
> > +	for (; nread > 0 && (n < 0 || i < n); i++) {
> > +		nread = read(iter_fd, &out, sizeof(out));
> > +		if (!nread || !ASSERT_GE(nread, 1, "nread"))
> 
> why checks nread >= 1 instead of nread == sizeof(out)?

Will adjust this check to be more precise and apply the other changes
you mentioned.

Thanks!

-Jordan


