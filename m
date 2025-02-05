Return-Path: <netdev+bounces-162855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA41A282BA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 04:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05541886814
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E779FE;
	Wed,  5 Feb 2025 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vBylLj/d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5A25A647
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725521; cv=none; b=sGXHk6+UsFca4XwB3KL9qdrhgQo6SDuMq6V9d165LJY6+479s5y8x/OB37mFxb+ajiu+rvaoJ1UeLgiFbL+YMNLXI6cta2qXLSPn5HyUV6qsesSh+EtkCQMVq6gVaAr2IR9di9AIMU9MTDNb6Hsl591AoumKGPrQKh/BiqbM3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725521; c=relaxed/simple;
	bh=O7IeDytuScu5r0bK9yl/chNUeUiDA7ktYEBpbW0W5FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o70n9P+YN0bhKF3yhHkvr+igETFu/owhJehgVw5PPSjrhbbpWfZ4sGGYX7HhytJJrWQpBGtxdimeQzIQvAsuveT+dy3RuUR8VS75yZVV62nE0NpGtgKwVyq+l/zhR2cDP1Uko+vEERHY25kgaUyWpckgPHTgTgqEDZwI4jv42XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vBylLj/d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21636268e43so140747075ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 19:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738725519; x=1739330319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD/U5phP/RLFyGCm0vWNM7cwXNfVCS6mJRDW7IhkBrw=;
        b=vBylLj/dWpW2PwNxO3h1pEqQvLMqZHzJQ/ly1vSTaxo9jBjkkgXCobVJpnHSPO2F6U
         aPRGNMzH8HoiZtq7KP8j9Kzc7dUMH0LtUS+LoofFB3o33LwYlZdKjQRWNaXpd0mP44tc
         ufXxdN4h8hc+qQdsgnaVa+xaQ5vv8c3Qlus/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738725519; x=1739330319;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hD/U5phP/RLFyGCm0vWNM7cwXNfVCS6mJRDW7IhkBrw=;
        b=hf9qrNgnwWRK6zDQQ6Fr6/D8al5pLP6KxPMWlo5RtY2nhEdNy7128wbhgLmqqJqREF
         r9yPRO9ZDkoxwAUQW/h39ngvMVj0voZlussnxXkPbYIK55gFyUn4USUnIm1at80cI7Y3
         yy0nUO/rJMKVFem+LPGunajU1QY5EZGTCiuvustmjIgvwqj2wnyKPzcyrPZdqgY6akep
         8uoD/q3/wqhbOvAPmjGZrNPo37DU7J31BCbtV+erXLdv6a7U6flIe/HFN4s5AJuXI1tQ
         XaZ8skCghvdJ0FriOW3llXdpF295gpWg2ntCWp5zoMYPI0rXO7cggcwFLXVNiNJiIGkV
         4OIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYKyMUjsYNJ/IbBZYgwxjiTk/r03X4j7gl7nqrAWDuCdsfGqLl2bX77Z3yputwiY5m/qkstyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuuHSH3IlkStY/Zf3Wo3C2QnvTn8zK/W4N5/EIVqVzHpkaEMp7
	eu01G9yH2M3EGhB5XHyrOpTMS63Dov74LW1HfVN7a8Jr9XFKguneXy/giAUTH3ecJ9vifWFwoTA
	0
X-Gm-Gg: ASbGncuYvmvqafPQMh2iYtHH5i26vZqZ/opsT42nbdXfUL6XQrUIJLQ1KvjZ8rZ70fG
	3WUfP6w2wKqtJWYYmfYl6VMM52a8lM1K6De+vGNcyohYK7+rnYkHglUN0fLrHIKWsmOtL4hLAli
	5cLSLjCG2kyoZfABqgeojzhCf3FdKT5fNV/mFi03kqPW3TPA+Ng/QshmTFe3PLCjDWR68V0qwl2
	uTI9gZWS8YzxsIzHxWk/z1XftSjr8DsRurgGoMbVxnHI6Lwwfy+OkstLJRt/A+S1YIJg5Pe49Rt
	tKvKPq7yCgiU/QJDTEXy+g7Q4Z1oN61MYYfDecyAD/6En5yaMYtO7Z5QQ34Xp5k=
X-Google-Smtp-Source: AGHT+IEfmLyQd1Eaxi1hoFdjFd/Mju4vr9oEHQ4sXoQt7m0S21IoDP9guLOkX9clao+NmbzCrOUguw==
X-Received: by 2002:a17:903:228a:b0:21d:cd0c:a1ac with SMTP id d9443c01a7336-21f17df7196mr19708445ad.17.1738725519335;
        Tue, 04 Feb 2025 19:18:39 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de330386fsm104694215ad.192.2025.02.04.19.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 19:18:38 -0800 (PST)
Date: Tue, 4 Feb 2025 19:18:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
Message-ID: <Z6LYjHJxx0pI45WU@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205001052.2590140-1-skhawaja@google.com>

On Wed, Feb 05, 2025 at 12:10:48AM +0000, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.

[...]

Overall, +1 to everything Martin said in his response. I think I'd
like to try to reproduce this myself to better understand the stated
numbers below.

IMHO: the cover letter needs more details.

> 
> Setup:
> 
> - Running on Google C3 VMs with idpf driver with following configurations.
> - IRQ affinity and coalascing is common for both experiments.

As Martin suggested, a lot more detail here would be helpful.

> - There is only 1 RX/TX queue configured.
> - First experiment enables busy poll using sysctl for both epoll and
>   socket APIs.
> - Second experiment enables NAPI threaded busy poll for the full device
>   using sysctl.
> 
> Non threaded NAPI busy poll enabled using sysctl.
> ```
> echo 400 | sudo tee /proc/sys/net/core/busy_poll
> echo 400 | sudo tee /proc/sys/net/core/busy_read

I'm not sure why busy_read is enabled here?

Maybe more details on how exactly the internals of onload+neper work
would explain it, but I presume it's an epoll_wait loop with
non-blocking reads so busy_read wouldn't do anything?

> echo 2 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> echo 15000  | sudo tee /sys/class/net/eth0/gro_flush_timeout
> ```

The deferral amounts above are relatively small, which makes me
wonder if you are seeing IRQ and softIRQ interference in the base
case?

I ask because it seems like in the test case (if I read the patch
correctly) the processing of packets happens when BH is disabled.

Did I get that right?

If so, then:
  - In the base case, IRQs can be generated and softirq can interfere
    with packet processing.

  - In the test case, packet processing happens but BH is disabled,
    reducing interference.

If I got that right, it sounds like IRQ suspension would show good
results in this case, too, and it's probably worth comparing IRQ
suspension in the onload+neper setup.

It seems like it shouldn't be too difficult to get onload+neper
using it and the data would be very enlightening.

