Return-Path: <netdev+bounces-101294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6BD8FE0D0
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC881F25F4F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5913C835;
	Thu,  6 Jun 2024 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbeIZ23h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA413AA48
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662102; cv=none; b=KlWy3mTSFYHPwUzVM7HDr47S6Jauu7Hl2yCKmxHBvx5HDnvnSt5OyvdWV+hikOHUKbbMupfoagow8OdFQpX9MpUr1R5vMWvtV+QnJ3id9t1H3jkPR5lTs/VscKkNzxdXYq7CpnZWyzPyD6sy4cF7oLBB+y+V2MEAlpqhz//wn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662102; c=relaxed/simple;
	bh=aeK3bnvjs8VEJFtu6HdqB8LOAkT/9yDIQ2qbTFkOBF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjrF6IM8wGiQ8s3fXm5rxbqo2ZSvBeylR/mChyxkGkLNggaL3AF96w4k8v/Yy2P5hncP6M4Bzc9j2LP1bcsc3wOHyLtAtzGVnpNFRGxjH/oA/EFTgdNsJTlIaKvqaQCRTUee6c1PYtyS4rfv57PaL05OSWMId1ee4fT9Hp04YKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbeIZ23h; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so5670a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717662099; x=1718266899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHvKEz5JKdCznxSqHezsMu71OI+px6uSS61YT0rHfuU=;
        b=HbeIZ23hH4Ka6f0sKo4cmwfPcRDkIuYnzfJ4YYdcdFAdHOyVlJHRQ7Q4GwCIFGS9NI
         0zKVt0qSorWejr5JOpr9BSHR7kBSLdfnqh/4T/C7zP13ReUl4P/GOyqWnW+qCo8iucL0
         EGB6lh8oVGUTv/lIM6LlrGL4xBsQm3mwP4EcqgXURRUpbTsgyJGaVyxKzl2tnJBPKLsH
         zllNASFbBpxhLY+MGdzZqfjiNeWps8qQHAWmWUmW0Sn5obRn1M4ji++dLAHPh96iTAGA
         2kxdX0wwhJXQAIy130emN5Oom2w3OQ1VsAVVLW5MJGIw0wnQFAp7QZQZ1wALR3UdCA35
         lQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662099; x=1718266899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHvKEz5JKdCznxSqHezsMu71OI+px6uSS61YT0rHfuU=;
        b=Vkr5GiWUyjt1Vnw/YNypPTq1CnICgOuxZtHpyV8ou71sqnxAQrgwRDLpyrxyTV2QZk
         IzS8Wf6ZC0wuCpQeyJ7FAJQCZawKsP7sXfgOwig8+Tt3YhKCl8znSyQuB0IXz0KeKbWu
         KQVr6p4ohkK2zNLUMvty6endhDTGvbbuY4owHT9R5C3Ml0JiZI81kG3Wud6IPPx6MACX
         rC1K4IY6uLDcGxd6ND9H5zgwuFoXBM6TVjCYjyna+bio29x+jgmYey4ZhenMJFM2XM3p
         I+hSt7Voeo5YOAxbCzVU3elFH+dRY1ttZdu12zmYFwGsniOiEWJZnAVpQWAKniu5olPj
         lpVA==
X-Forwarded-Encrypted: i=1; AJvYcCXwyttOlO30S6OUqa7eH/tLpKZP19ilb9HBsG5kkDqTsJkyIiygWhmshnfoLK/QetO2GcMv/UY3aPFfvoI8FcZ9PNi7Pcp1
X-Gm-Message-State: AOJu0Yw74ScgXLDgF3hC3ObTd+RmTtrxMAJ8OlH6C2DCusahsCGPvMeC
	Zs6vkHwkAvHxG9UBE9v2rGBDm/4DgimiResxWcM5hv1WpZq2wvh6SIcfXuhBCWk7KteJ1Ny2bqs
	JLv/XzFO2ju8Ov1RpY27Ygdkwc2sJB4tA8qBV
X-Google-Smtp-Source: AGHT+IHh2yQO2i7W4TVOkZXhb8V7bKamRBQUc7Lc+uRHNVgFKKNhugjLVTkGob22mKGuMH+YwFRJbIKAat4YiCfDe/0=
X-Received: by 2002:a05:6402:180e:b0:57a:9ea1:f92a with SMTP id
 4fb4d7f45d1cf-57aad34e850mr99772a12.7.1717662098423; Thu, 06 Jun 2024
 01:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com> <20240606-tcp_ao-tracepoints-v3-3-13621988c09f@gmail.com>
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-3-13621988c09f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 10:21:26 +0200
Message-ID: <CANn89iJyKWuZ4DtegJR99jYaSf-kbhr0gSosw_XGxjiaGT=00Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] net/tcp: Move tcp_inbound_hash() from headers
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:58=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>
> While at it, unexport and make static tcp_inbound_ao_hash().
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

