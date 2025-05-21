Return-Path: <netdev+bounces-192352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2632ABF8F0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0F41889E8F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363A1922F6;
	Wed, 21 May 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b="QnqhbbyO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5802030A
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840118; cv=none; b=I/+nBooqOoChtmCR3BtsltZuaVwGUWB93RZsNC10K6NU2eEAGDeBxZaE+ab5gGu9ECVJiXhRWsu8av/oh512x1PqSbbFCD/eVaQXx65yWTFHkyv+Tbg5UH0TtHJuN27kaGmsNgkAybIUgZldf87q+HZ5AsP3v3fjFc5dhPTG+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840118; c=relaxed/simple;
	bh=8lh9FtHzklwZBjzaX6FJk7lVlKJED7HKvgLTyFgMI2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXrl5W6aCLpOMhfSOPDW1P7+jXluo17F2DO1nQk1s1o6JJ5UxfNNpNH8aGstAGLBlGu7elnVxZEHhYeBR/8LtmGZ/uHpghrm0PQvJcQHdSi3lIi8M6WL6JBnPMjAkhp1nbLtLyHMntxfQ7mqyCGqTJS/8kxWoYqSVYVMjzajl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com; spf=pass smtp.mailfrom=deepl.com; dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b=QnqhbbyO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepl.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-551f00720cfso4752137e87.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepl.com; s=google; t=1747840114; x=1748444914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVN+uPwA9HVT869LEXKTT9tWVdE0pR4aOc6we73dD6s=;
        b=QnqhbbyOYx2x6wb+1ykfT5f0C2vSfxEmM7boAZtmJ9gPHaweUn0tzsZTHAPXYQqSqA
         cRfNsTvVmQjB/O4YzY9wXTfrDmcWEzJLYfxZ3O8bMjP2SmgcAZ5Y7F6i6vbmQ1NCuPDN
         +21zxWCcgSRt4S3wqRiNKXojQNymdF+mOlEEsJj0N+BUPsWdI2/x/hGVcriBBrYcMNWP
         0Ya1Qm94glOc1u5WUrZwR/cRI/JycnmJWnQWTx5NXGAhnm72wost49cfCBNxYaGbg+qc
         crN1j9g8WshKpFL31nlDuQGIR5e2MOQthHqYUyFXghf9YZ0IO5bzzZ9w4SeaFqmosmeE
         xOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747840114; x=1748444914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVN+uPwA9HVT869LEXKTT9tWVdE0pR4aOc6we73dD6s=;
        b=m7gfFT+ttivou1GHK9y3W96tdMnXR9zIW7WKYpLtUlQcmVjbO+1cgBHOa2CaSouAYm
         PykRqoe0GP55J7cmZoGJAMTJ6yqTbocQ7FFAkjysCtffKlKTHOtGaAyFvmnmtV+zvfyM
         j9gl+QN73G/Ym58Q/VXDM5ntySwWRWlaCvwSBLHcb/mLFhU/1c93uZkxccL7ASyr6GII
         VtnMgXSp2b8o0mVtHwcMKsVXLV046zi95xIGn269olJnslL41WWCQxoM/wN+oz/wXV8X
         7/WN7l3whDvJnuNM4WAKPGgnkgBN40lKFNV4rWSI8fn8I8R0Q2qvtuOXO5FKBFt0wN9i
         sWYg==
X-Gm-Message-State: AOJu0YxM2hKlKejnS6EPKZFWieiO5cekRM3wIVFmBT1VJi6AWEteOWK7
	oljVUqNxfJ1evMQU7JqjB52IEQgHIiJSZwFacW2p+TVhPrWTi+NzQu5KfqIVDAytsxsW6h3jnpy
	6ln6NbXvdEv4fXH9CDYchzbOsv+vgQcEu352RpSrwoXCRELrR8UtTYJE=
X-Gm-Gg: ASbGncu6TcS5Pu387mWKYSlju9K5clEoIpSZMvmqZCW85l7c1bmtbeDYxcShkG6enBa
	jqll7m5evfYqIftJYleKBVontiqSSC+vxaKU5JO5ZKIpZzIxNwBhxaFYN2SwPAka+BzE2Aj9Joj
	yu+uLceQZJ7lm0Xr4HX3b4mzzkZf0EVWTrWN/WoprtwRnXVt9LqZKLue25llfZDbGHYtI=
X-Google-Smtp-Source: AGHT+IGi9kEZVjUpB4ejMIXyk8nSOmjBh4hYylMBgFRnsfzviuklq1wasTg7kRlZMq67nLY13hBFZIvzWYPvfCGvpJo=
X-Received: by 2002:a05:651c:324f:b0:30d:624d:c064 with SMTP id
 38308e7fff4ca-32807712b72mr58452441fa.10.1747840113922; Wed, 21 May 2025
 08:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
 <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
 <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com> <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com>
In-Reply-To: <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com>
From: Simon Campion <simon.campion@deepl.com>
Date: Wed, 21 May 2025 17:08:21 +0200
X-Gm-Features: AX0GCFt_qtmYAH7D6VlV0fGaXbfQAp2QMHT3qpXuADITehd7ARlwI8ehPE3GTs0
Message-ID: <CAAHxn9_++G0icFE1F+NCfnj3AkErmytQ3LUz2C-oY-TJKbdwmg@mail.gmail.com>
Subject: Re: Re: [EXT] Re: tcp: socket stuck with zero receive window after SACK
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Great to hear we have a potential lead to investigate!

We've now seen this problem occur several times on multiple different
nodes. We tried two workarounds, without success:
* As far as we see, the patch Neal mentioned was included in the
6.6.76 release. We rolled back some nodes to an earlier Flatcar image
with kernel 6.6.74. But we saw the issue occur on 6.6.74 as well.
* We disabled SACK on the nodes with broken connections (not on the
nodes they connect to). The problem occurs in the absence of SACK as
well:
05:59:05.706056 eth1b Out IP 10.70.3.80.57136 > 10.70.3.46.6920: Flags
[P.], seq 306:315, ack 1, win 0, options [nop,nop,TS val 2554169028
ecr 1041911222], length 9
05:59:05.706142 eth1b In  IP 10.70.3.46.6920 > 10.70.3.80.57136: Flags
[.], ack 315, win 501, options [nop,nop,TS val 1041916342 ecr
2554169028], length 0
05:59:07.846543 eth1b In  IP 10.70.3.46.6920 > 10.70.3.80.57136: Flags
[.], seq 1:609, ack 315, win 501, options [nop,nop,TS val 1041918483
ecr 2554169028], length 608
05:59:07.846569 eth1b Out IP 10.70.3.80.57136 > 10.70.3.46.6920: Flags
[.], ack 1, win 0, options [nop,nop,TS val 2554171168 ecr 1041918483],
length 0
05:59:10.826079 eth1b Out IP 10.70.3.80.57136 > 10.70.3.46.6920: Flags
[P.], seq 315:324, ack 1, win 0, options [nop,nop,TS val 2554174148
ecr 1041918483], length 9
05:59:10.826205 eth1b In  IP 10.70.3.46.6920 > 10.70.3.80.57136: Flags
[.], ack 324, win 501, options [nop,nop,TS val 1041921462 ecr
2554174148], length 0

Another important piece of information (which I should've included in
my first message!): we set net.ipv4.tcp_shrink_window=1. We disabled
it to check whether this will avoid the issue.

Thanks for all your help!
Simon

