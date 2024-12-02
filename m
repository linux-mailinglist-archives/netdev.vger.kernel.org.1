Return-Path: <netdev+bounces-148023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3B59DFD35
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36E6281CAC
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC51FAC3D;
	Mon,  2 Dec 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PQcSwSk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175D1FA169
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131964; cv=none; b=S6nOdTNuEEEtBHzj1DkxkGybSxpq1lU7FjSPuvmjWiRPqUR+f9+biSEj7arnPu6z9v+wsyq4XUP7uxqLkfScTqJsTswlxe6YYG9yQ/OzVviLS89tvRdN/qkXAP5t8I2JMUd4FyZADiwbHoItZ2xnC+H7eoX5RjRGZ80qdSrmHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131964; c=relaxed/simple;
	bh=kVXE/ki/KkA9M8CTRd966bqfCz5463/+o3C+QEfkBy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLupfFTRr+VF/8YOT/lPnGzTcGMyZ/Fikr0aqD0zsjIeBnykjJCfFu2Lh6FBHS6pQKkqmQULMIVClAWJk4dJk7v5kSFDz9Ug4jd8IJczoFslWSGR3HWQlhaR9LASKx3P08VqCSz/iH5B0jWEWjSjpplIny7/zTBbUjmLpWK3wnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PQcSwSk; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-515192490c3so1148330e0c.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 01:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733131962; x=1733736762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVXE/ki/KkA9M8CTRd966bqfCz5463/+o3C+QEfkBy4=;
        b=1PQcSwSkPieprHzXj4dUgfgm+FBeNnEMd431FzLGC94sK/tntpfFC0QtQop9dsqL76
         NuozOd8zTom3bVdcKVJnfQ8BfU0iqWKgLOF72ILDI+6vYD4oW5khGBtrt51kqcnWQJ0s
         sR+lUhWrKq0gmb/xyvGeZD81z0Jr5HtuPi/Mp2KhAtDYnM940izJZ+gIYhZPxy+WMBBn
         2dwuSw3SbIajHvGWLkHwjqLjozmNYjI3y4Cc+tOzhvOgoVAoGVmwBIuE6HBVUULtkNKg
         wAThX21LYqxEqU4S7jbOFKgmXJZvWtyT2rUEF+e8acTxmNXL8UKVLJX4QRoKuJbbRl0t
         FHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131962; x=1733736762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVXE/ki/KkA9M8CTRd966bqfCz5463/+o3C+QEfkBy4=;
        b=vqep8MINC3eFOrSSWjxYQ9eNT9dKTdR+v+8irNqvcahBTBIMuKmpvU+tTEGduUDZAY
         pbx3SAAO94tJLHDflqCwGK9EBYAohpQwShTCuqwVZ0VJQoRq6e4W6AoE9ot+Nph9txbH
         SD2aTw/QZ+FfdUOz1mL4p6jKBA8fXzDTKgt8qpr8aUISOR9rBz3/Ugr6+K/WFuPQNsQR
         ke3aCRtRY9/2LhV4l/BCzsI77tcUl+RoYxAJxX8T16HpGq6yvsU57H25WRUe5xmPhsyd
         JdLlkrhkxC5gYnTdwT00Yl8hfDbRXSwuaHhT2Y0pxSIAc+kBPe6vLn4ahSwKclDVMWHA
         /TLg==
X-Forwarded-Encrypted: i=1; AJvYcCXLB2FaXZi030ftsHZLRKUCFevblRhaHx3OuTIbRgA2fasFDovWWk1/DrPmMDnMQsCuHKKM5K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxLsy+ckk6xX9sedd7r5/YoJuE2JJl1BQhdBnWWtk0Ujtq9C9
	jhSIgQb+ro56BSfd3CR3+YGlCEP15SSbTbKCi5UZ29leL5jZDFkWxhzvb835vGNIVYt3nwboGcf
	PFyOmsLvyoRf/opORKLatB91og92SSHWrK7WR
X-Gm-Gg: ASbGncvD1WkGORWDMQgeccDm0mb2utStdNnBKvUAYJLD+zNYB8lJcyNaysIeaPoKt5q
	hN5qMLGxJsD8PWjAp/0p+P/fYxY31LpL8+6weJXQ9RI8NB3vPm+BOi/Q4vjnkvg==
X-Google-Smtp-Source: AGHT+IHHi3bLNsBy5XdABkyWzSukR1vhDWaGMCcr7HDBu5Qx8ILNRUzQmr9hbFxaFxrBqoMQX9U1aslO1xepcR8knNg=
X-Received: by 2002:a05:6122:551:b0:515:4fab:2e53 with SMTP id
 71dfb90a1353d-515569e2820mr23612069e0c.7.1733131961670; Mon, 02 Dec 2024
 01:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201152735.106681-1-syoshida@redhat.com>
In-Reply-To: <20241201152735.106681-1-syoshida@redhat.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 2 Dec 2024 10:32:04 +0100
Message-ID: <CAG_fn=VqUi=sGzz+0PJ9L7QrtOcgcn0ju=30BEGwB=D728wE8A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 4:27=E2=80=AFPM Shigeru Yoshida <syoshida@redhat.com=
> wrote:
>
> KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
> cause of the issue was that eth_skb_pkt_type() accessed skb's data
> that didn't contain an Ethernet header. This occurs when
> bpf_prog_test_run_xdp() passes an invalid value as the user_data
> argument to bpf_test_init().

Hi Shigeru,

Thanks for taking care of this!

Am I understanding right that this bug was reported by your own
syzkaller instance?

Otherwise, if the report originates from syzkaller.appspot.com, could
you please append the bug hash to the Reported-by: tag?

