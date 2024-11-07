Return-Path: <netdev+bounces-142714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06869C0136
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B49CB21082
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522061E0096;
	Thu,  7 Nov 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kV/0bGMC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAAC2ED
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972104; cv=none; b=ka8FbUXb8/IZVV654DB+1euXfqy45FsUCBWvrjkZXx9Ac7VcdP7GYx7CZq6G7WyzV5lDG0YPkFg04//tni4dHF+wYe+e+1Z5/zloGPcBuSYvtJJzqHYeJLmDXlyJ3v3HLnV3qNmAo2uUuG8hHzG5G28UyJJnTdRH0N10wdrWO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972104; c=relaxed/simple;
	bh=IN2DmLQ1o2SDyeRsGj1pPFvvBNQQ00WjUmtCXsGbIA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q130SCqSBSmuFaaIu+g6+cmPDAgzoOzwI7MmymZkhwQkj6MFeb7iXWCdDviiGsMjxz4TYk4vXu3qX881RnqbQ2WhdB5oiM1KAi5mchrROvuR7WbKsL2TQ0CN8kfE5SqL2MrXhrgoW/n0dSt7yIGmV4ELHNihLXECY2MbhNi+V08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kV/0bGMC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso1401977a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730972100; x=1731576900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN2DmLQ1o2SDyeRsGj1pPFvvBNQQ00WjUmtCXsGbIA8=;
        b=kV/0bGMC6d7L/Qxg1x9tFqhMi3/uzO9SFrKbAICivZsT0AlaIXhLf4kQ/RhA6gkF6I
         ff6rFa2exRzpbg4jsWucoWTZCo/MaYmD9qLwXKP54ypRcskX9xutlCx4WBXS1TYWjlJV
         hJMT6PFoBRPdAI2L3tkTNv4sLmfqhGGGI9+SwevIzvLti5A6z8M25FvAC1zoXdLAtDsD
         /r0rsmC+kdl+d0q26Pq2cvVXAq/nYnLJaYKxMxqUY2aWgW3ht6yOA1pQXuYnnHjkhEM8
         9OQE9wK+gcACjmnOU42RGgHlRqcMmA6YiTAhBm8e7XhTz1d4Ii3IjCPOSo4n8x852AEN
         c+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730972100; x=1731576900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN2DmLQ1o2SDyeRsGj1pPFvvBNQQ00WjUmtCXsGbIA8=;
        b=i2J0VN31pWRD2UFrSQN/+MQp7I8vU278TPIP+Ru1mHNHv6jzbFstYzcubX/xPpyWuW
         f9aCFeer2cc8CX1/QbqN31O8Szk+DXFFkyaONKKDu0PZryvICGQAf9+LCeur0jINfUmB
         ss2gUhZF4e64sGvcgqvGIgkWdIWfjlPAWyb9up35U+EXrevrykjvfIXJL2nt2UpBPaB5
         xmm5VB4JM4vW10omcgxhhRj10cjjwXVqXxkf/zxZv7Dh5Z3LSw9gRIjB6SOEpu9/t5Gn
         nIE9Vbo5rjhaFa3+kgIWstNVruwh98xA8QKMQOfJtaNwsdL3GEzezF6EVnSZ52Es232m
         AMNQ==
X-Gm-Message-State: AOJu0YxahsG1S4Ptbhj6+ZL0E+IF2X1lQoCA6h8Ougd8FnHNx1LD7e28
	LC094+etxhex4qzmSn729X1KC/h3GeRiahYSn7YfXzgouNJWmn6WmC1csmBEoWv8/KYHdEYtAYc
	yC3x/baR9D/kC7yu0XArIiag7+uM7jLISR+em
X-Google-Smtp-Source: AGHT+IE47nVRQew3dIPy8uphshtnLRVAmJQxcNisdb+tz1uWuD9hBOnbkuCslIypfXnTLuIB1boVwF9r1HAlZ+e2M4k=
X-Received: by 2002:a05:6402:84c:b0:5cb:991d:c51e with SMTP id
 4fb4d7f45d1cf-5cf067f0552mr482331a12.15.1730972100287; Thu, 07 Nov 2024
 01:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-3-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 10:34:49 +0100
Message-ID: <CANn89iKUnrHuf=V8uYNU5jBy7=sQByH4B0hZ=c4+G3oZzF4BnA@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 02/13] tcp: create FLAG_TS_PROGRESS
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Whenever timestamp advances, it declares progress which
> can be used by the other parts of the stack to decide that
> the ACK is the most recent one seen so far.
>
> AccECN will use this flag when deciding whether to use the
> ACK to update AccECN state or not.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

