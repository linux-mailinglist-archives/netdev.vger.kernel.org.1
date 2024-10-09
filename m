Return-Path: <netdev+bounces-133844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9F99730E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFEC1F2317F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240441BE869;
	Wed,  9 Oct 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZU06nU+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7F1A2846
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495121; cv=none; b=N+eoqStekCBhpEjDzlVnavsFcFonAEVtf5T+0M1EYIwxzvWzvfzWVAH8Kvf4vYyXade/UhpJuiq44MMsn6A3Kmfhq6kj1Ih96v0PvnYmpK/RxPNjFT3h6djlqNvyGVIOCNNEK/uEmMeEJs3ZJfubqrvXlTZKp9eEjGR+Mbv3ZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495121; c=relaxed/simple;
	bh=QnHcOEt2Q+E/BSuDqJ36ap3bLP7FuAm5tWk0fu4xuqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpH59ogHpRUJ178gONquCP+0BAfXnW9YONY5PYLnkrxAhyYaF8RKqUs0hPFUH6AtdJw9xR4xDZvkfThCvWvp1QnItNaai7rb6LWd+dbKN4i63XXa706QyIANQXwjp9SJ/c7ucOssGnJ/5yp7wWr+S6URLbSFbc9G5FNUnxYuLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZU06nU+N; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d2ddb61c8so8513f8f.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728495118; x=1729099918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnHcOEt2Q+E/BSuDqJ36ap3bLP7FuAm5tWk0fu4xuqk=;
        b=ZU06nU+Nf3773zoc3fe7n1VdYvjz9bSlOxU7UVd8gQTCmRxQ7+yJBh7DxT4uhSpZNa
         VNp9Qtn1TbZML56ede7pOZFfSehxswu1Ar/BwTo6NYE308Ri8cIC+QK2oTqCnbyrBemv
         TVGc84r0/a7dh5HBIsxnP25cbKSRsFZ1BQZAC6a/pnDppmR5gtGv9O6i7WkGNS3krmAz
         gyRDJCbPMLEzZ+e576noDsiQrTTvZ4pICiJByQJJOF6NkSmCGztbHxdFwSbX2X6ewcFn
         io1v7yZwAWvMAgYn3v3rZZxX5r83xnhL9m9cjOkp9JK7DSFOpqUP7tCsmPLIOc5VfrYZ
         PMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728495118; x=1729099918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnHcOEt2Q+E/BSuDqJ36ap3bLP7FuAm5tWk0fu4xuqk=;
        b=Ooxh5qumco2xrfepdqiXLzgx3wnfZluLZdjEQPSnYogQjnproaOpC+WV9UHojZSw9f
         ThAYfXFJESsmk1wuGjHudUMz6MJiagx38flAap6WW4mWb3/Fj4RkGlKEmle60Z1IUQUA
         1WjvfClLh+PmqAcAxmHdjN2GloyqXnoywzMgqJCT0zfd945tcnxmtN2V+Bv5RyDd3KDb
         C0tNLEdO/saX6RSXxdXzyQj64jvboDbHlSSVp6KZp8NM9yFyeW15BZ0AZrD8FRUNER0Q
         E3Q7XwBiTONoXDswmHLSLHdiXBgw+CQmiiZD98mHiuNVtVjucnQY8DAMHYcqwjGvSMBD
         +kag==
X-Forwarded-Encrypted: i=1; AJvYcCUuOc5VyQOlbv1yM7OtQ9+HrU52OlNmkoyLqrG9ZuIp4rHpTgVdQp9fBqUxL7BM6wZUJtQMj+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDOHl2i1B9j0rgajNnYk+g5EFB33czmudHdgv9gNcRGp1ooI/D
	SOkPD//aLjCCfV3xNKOaKRRGXZE08Xrk4gQrqC+Nl9k1faL0R956szSUq9KDQSU27LELL48m+Ts
	1Ak/mfGDzrH36fYuw6lIzat5wh3S6XyH4cCU=
X-Google-Smtp-Source: AGHT+IF6GCJdoJW6FolMqGZLbIHS6bpmoo62eYMZ6TI055KcdVX4GGTofCCv1p67aeAG77Mk+PVpRnvqrHsSe4d83B8=
X-Received: by 2002:a05:6000:4182:b0:37d:4586:948f with SMTP id
 ffacd0b85a97d-37d458695fbmr2622251f8f.42.1728495117653; Wed, 09 Oct 2024
 10:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-3-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-3-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 9 Oct 2024 10:31:46 -0700
Message-ID: <CANDhNCq38L8o5vKJaC8WzfvqEoX-xrxX=-n6ReohKK_vR65Sqg@mail.gmail.com>
Subject: Re: [PATCH v2 03/25] timekeeping: Avoid duplicate leap state update
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> do_adjtimex() invokes tk_update_leap_state() unconditionally even when a
> previous invocation of timekeeping_update() already did that update.
>
> Put it into the else path which is invoked when timekeeping_update() is n=
ot
> called.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Could probably use a comment in the code to that effect, but otherwise:

Acked-by: John Stultz <jstultz@google.com>

