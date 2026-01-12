Return-Path: <netdev+bounces-249094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2251D13E24
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B92301C94A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE53364036;
	Mon, 12 Jan 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv49jL0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772832BD035
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233975; cv=none; b=BLWJF1terl5W6jJA/LAH/DlGWb4PAuEShqx9G764n1XYjeMJo1K5jMAKYZFPQUODU6LBam3Z+gZx02kQSe+myeEvJJ0TixcKP7KysYBsgwPurGY/b2WkzkxDoEfVDV7F0FuveoiycmFIErqwWFvRp3lMJBe0jlTWj4nCqA2rM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233975; c=relaxed/simple;
	bh=hr1LpeUSVsgMgXX04pPeVZ3/Tz/dvWj7altLipWq/c4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ETJ0JGuC2TFcDAsk4IYj//U33vnrr2Q+aDKsxyznPTquaLNWtIeLeStqqZ6mWHiFM1cS99tj4FzU9doOOPIPPTc9nKAegYnXp4tf8hRxQuoKDC5bN4A6M8zajvhkEeBUAVwO20gQsXJWcqn3nQ63nQ+BQ0GBxp5VKjiI4gfBdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv49jL0v; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-644715aad1aso6553268d50.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 08:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768233973; x=1768838773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JGdgHIhiZP3m+qHj7U1YyVaqXSCkghOp17m4pp5neQ=;
        b=kv49jL0vhJXyu5QWec/dC+FjSBuZ28LWz5/7d4de2Rl7n5d6sHJ/7nJCfYRFvog89Q
         cY4Znai69uRcWPEe25tGo3+PqGYasvkD/yVMI1SBLaK2JADPhgatKyiV17yPXDqzEOoZ
         t3SXJdXXev9e5NS6BeWFoGhyECEgXe/tKuAa8d04KnaD0WnGjCMsQ+CqQKkDSp7ONSez
         9XtrQ0SpKEzSt5xVyw7BhkhCuvNkKROrexXPJaFLH8gSzUHw4uMxpcuKoAY8eYmfzBzy
         JQueIPKe7ndSUof3881FCOr0k6+pwct6Ii/kTS7j9SL/9+3YfCoAM/6wThIGVU7svrt/
         iDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768233973; x=1768838773;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JGdgHIhiZP3m+qHj7U1YyVaqXSCkghOp17m4pp5neQ=;
        b=Swhf+P73ijgh6SY9kPhoBFyPIU09RugfXnXLOR2ttIyCV8J4bCSg3TgqYIQP1FkMu0
         VEOO/jT6ZDgu2HltUf3Vn9kAs3qrTGNII7AVXQV8jyMsQBeurSyqxYmCWLK5azJZgb6A
         h9U2ukxFRAaqZnSdVcm8xbD6yPob+XsJMSa6zZSdg7afJoazGOG50SuczJfVQ4PdYjlY
         a/zktlwtyMwtBQFyHF4DFXhm7Q1tJNS+kcGhJfmJpTwsxW/ctNjd2zhFzXCQ3f5lnN9y
         nNb9xV5M5Eg7lTVX2Up+Tv+tRVGrjaPW1mg32+QMWNyMs52WQ6pPwzv/TywET3uVjM1b
         rj0g==
X-Forwarded-Encrypted: i=1; AJvYcCVJgNqNCo8GBcWsArVVXuoEWHJwIwBb3cOgv+ajE6fk1FICWwb5mD4s8Cd2dYNkKcoVYIp0Oa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKa9citedeQm+4FRypj3c/D6MSaxh4SbWAqsKh3iE+KOMKB4l
	vvB59RG083rWzNaZsYpRLOMLC4WIM88An5KBCZ07snTT7ZfhCrRyCq3N
X-Gm-Gg: AY/fxX73Ert7Kp6VLpylYLwHcEb8BLgfh7xlLtMuvUQKVe/3UQgXMVMZInFPwBdLoe/
	bJL4oVY+uZrWW0gv9T1OinjoSOrZKeHFtUaP/kMVmVhAEpVVcBOBXtAK5Bthyq80Wk+efBdM/7v
	4WlhPyYAmgAhKdgseTHbW1lFkmyRaJDP0Sp50BR16G6W24yQQgy9UCM2JJybxRTVgMrusgXFdva
	aihDHZG3h0gR9S7QeA4MxVh2eTOdK8A2F/7pbDf49JrubBLHi2JacP4oHpXsMcPEzQYfHYvdTe6
	BmGfr/+9txiTzV5BZtGdNQ2gByIPYMrACaWsVt9SX0MRv+37LF4h3cv1Qm72wtyo8VcZ9Kx+Mx/
	A+iaS+7Vb8TnJde3PmctqG/63yHRu7G1Wmk/5d3uT2arWvO3AFRPNxIMNAOp/hdAJIEIdLebA2w
	Kyi2txieBKx1bQqdO4y44AhSYG9IBh/8s3vnfcTkYXE9gLYqDq9MlSD56cm4o=
X-Google-Smtp-Source: AGHT+IGmPosrm+A15oJLUPggJ93G4/eVuIjwCR8uuTr+1EtXKG52ldXvyt14EhDewF04LtFg+sLUUw==
X-Received: by 2002:a05:690e:b84:b0:644:6d8c:e439 with SMTP id 956f58d0204a3-6470d156cfdmr15999476d50.0.1768233973298;
        Mon, 12 Jan 2026 08:06:13 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790b14df5e7sm65359617b3.7.2026.01.12.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:06:12 -0800 (PST)
Date: Mon, 12 Jan 2026 11:06:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gal Pressman <gal@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Coco Li <lixiaoyan@google.com>, 
 linux-kselftest@vger.kernel.org, 
 Nimrod Oren <noren@nvidia.com>
Message-ID: <willemdebruijn.kernel.e77552f797c0@gmail.com>
In-Reply-To: <a95dca83-b996-49e7-86d5-f07e8f178767@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
 <20260111171658.179286-3-gal@nvidia.com>
 <willemdebruijn.kernel.e28b1e33bbf@gmail.com>
 <a95dca83-b996-49e7-86d5-f07e8f178767@nvidia.com>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: fix RPS mask handling
 for high CPU numbers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gal Pressman wrote:
> On 12/01/2026 5:29, Willem de Bruijn wrote:
> > Gal Pressman wrote:
> >> The RPS bitmask bounds check uses ~(RPS_MAX_CPUS - 1) which equals ~15 =
> >> 0xfff0, only allowing CPUs 0-3.
> >>
> >> Change the mask to ~((1UL << RPS_MAX_CPUS) - 1) = ~0xffff to allow CPUs
> >> 0-15.
> >>
> >> Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
> >> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> >> Signed-off-by: Gal Pressman <gal@nvidia.com>
> > 
> > Should go to net instead of net-next?
> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com> 
> 
> I usually send tests bug fixes to net-next, since it doesn't fix a bug
> in the kernel.
> 
> Should I send those to net instead?

I'm not aware of a separate policy for tests. Not sure if maintainers
have a preference. Probably behavior on this is a bit inconsistent
anyway.

