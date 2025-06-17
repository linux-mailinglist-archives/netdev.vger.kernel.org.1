Return-Path: <netdev+bounces-198544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD7ADCA1B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F99189A111
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE63421C9FF;
	Tue, 17 Jun 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UiQBjNrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03C2DF3C1
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161381; cv=none; b=UYil17Z2+fgZFGwxRayrGS/C89/XqQEowk28iCXLD+Cj2kMJuZTpHuJu5gEhLfcMb7yambIf5L9PfUYo7DAobGClbl9W3/9TDz9L/ztIvNOt3lcHWUQ55fkc/dvBhpmA7Abgc+CNxPGs1fdEjNXjofgTXgJ57ns2G6jWK0ozzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161381; c=relaxed/simple;
	bh=hUrh0JsoieyUUpS5QdFU0961KMMCdTuTI4vVH6J5pgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQu4TfJBmp8uwTFslgNutEKSe62HjL677YAvEPiaiYW61VDl+AtwnDips9B1zloX/JmwCqpE3Ig4TWdj947nnNaMU+7wT2fJCKwOM7SMn2OUNeOnYXvCH0RSgT47iWWc8lSBBpMVXdGr+Xrd4c9DvQ9KcFwbG1D4Pnb48Dmq6hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UiQBjNrW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4531898b208so5167675e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750161377; x=1750766177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZib2EAxYXc6vAmfwD8FP6fgSUgLC3pCF4+8SwyEQno=;
        b=UiQBjNrWPIkE5t/uGZxytEBmAZ+U6oALS88kbK2M8mBpQB8QR2TqhN99Apc9Tyr+w9
         61aBuhuI5W+L2GBbA9qBjxBiKe5/Oiw71n8JtWkIiYy0AApiC8OwIVUXT0IYexeSHlP9
         t4XJHyPwtY6Xrzm556dgR7riQySaRikL4940vpqJMqYoXN3Q0LqQp0jqu4WASLt4b90z
         l2Zh5fsWTNDB67+xro+9VtkO7j2RPOERAbHiI0pK6Sk7yzq7LBeEBqEXtiFk6hP3Vx6Q
         EEErj6OC3iR7FqajVK3WhrhxCx66KE7ppyNb61cOTz3tQRbTqiU8RwTjOrKkmTtJM1Jk
         qH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750161377; x=1750766177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZib2EAxYXc6vAmfwD8FP6fgSUgLC3pCF4+8SwyEQno=;
        b=FWMbtorwm9ZXSmOyRMP7jRIUAaW8dieJFt2cb5oh5hrKjZYXAwSUJcPPxpvkOcJjgU
         qsMfJKebB9h924R3wLLbQ+zJLEAsER42s0h53b1DVR+09gUd5zCMUt5yl+GVx15hSWT6
         xEMsVDjdxLVnBzxVRe9TWOYuW2pQ0iWrmPLRuKjPEx0t2TArrYXRV6POGw7YH0MYG+kp
         B9fLrn0n8+OXHNU0Pz8/CSZ3u3cRxBdCNdaVWV/csCsqdTK5MpKu8RJ+u4d8fMz27KyV
         kud8Zy3NH9V748Km9qJyjF/qcCeLEdBKEDsiojGfS3vYmDWT5rpKlV44XFvr5feC/rpT
         KnLg==
X-Forwarded-Encrypted: i=1; AJvYcCVOUxHRoYqe4BdZKGNxky3GpUFjmuA5WiiAbxV4McuhCzsZwUGg/cgvDEo9ciUTJfZQr08HPmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRs9PWb59S9+atFZUDJill0nMhk0L33v0A92ujQTQkA55AJ0/
	U1thGSoC4I86o8vN4Z1Egykh98rIGoiyyo8Hcb5jgiAR1xsEHR+H/0Y759HpfX1UYlM=
X-Gm-Gg: ASbGncsLHIeSgfLZGMHIe/colNSIrTY+o7sUMAFGwwNYM6mY6qkPMrr0ovg1ACBG2HE
	JMYhNjWYawCDUrngY7mOEutNahLxb7KVWRQrV/L50LG/Tq1jzYD0+EFJALRaDgQd8f7SAbtkduK
	UL7ZCLa/ZaQNOUMniKM7zhHltUA44pWKLUfAQb7q2EFEixYhY70hJ1fOD9dXkylUdzx4oxTA9LW
	PsqCtMf2G2emg/M0zMAwq1CgLEKikXymICXdJTRqHcSOAlEG1+dKseEmSyFs/X05CF3KAdCps2+
	PlJ4y8IcEJ+X5K70osiHujWWNFIzgyYWK8qX7RHB5h7SHloC+cywcJ8OrO4FTvmBp64Jq+GY8T4
	/wGoB0p+xducJMCRn9GMG4eLCMcoj6k57a8b/ahcDCkBy4/VfVirCQCLztyrxN0kZ0qM=
X-Google-Smtp-Source: AGHT+IGAOuw0cWNP/dm6FxfczRCqze8gyHxlT9VqrXK6Km1ShSiz79wkJohNkjxqZiCQ0Et/w4COzQ==
X-Received: by 2002:a05:600c:4f48:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-4533ca60745mr46258825e9.3.1750161376622;
        Tue, 17 Jun 2025 04:56:16 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087f8sm14021612f8f.53.2025.06.17.04.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 04:56:16 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:56:12 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "open list:NETWORKING [TCP]"
 <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] tcp_metrics: use ssthresh value from dst if
 there is no metrics
Message-ID: <20250617135612.26aed53d@mordecai.tesarici.cz>
In-Reply-To: <54d712a2-31a7-4801-aa65-53746edda117@redhat.com>
References: <20250613102012.724405-1-ptesarik@suse.com>
	<20250613102012.724405-3-ptesarik@suse.com>
	<54d712a2-31a7-4801-aa65-53746edda117@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 12:48:30 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 6/13/25 12:20 PM, Petr Tesarik wrote:
> > @@ -537,6 +537,9 @@ void tcp_init_metrics(struct sock *sk)
> >  
> >  		inet_csk(sk)->icsk_rto = TCP_TIMEOUT_FALLBACK;
> >  	}
> > +
> > +	if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
> > +		tp->snd_ssthresh = tp->snd_cwnd_clamp;  
> 
> I don't think we can do this unconditionally, as other parts of the TCP
> stack check explicitly for TCP_INFINITE_SSTHRESH.


Good catch! I noticed that the condition can never be true unless the
congestion window is explicitly clamped, but you're right that it is a
valid combination to lock the maximum cwnd but keep the initial TCP Slow
Start.

I'll fix that in v2.

Thank you,
Petr T

