Return-Path: <netdev+bounces-200292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC170AE4704
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3159B4A00D3
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166A253340;
	Mon, 23 Jun 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hz5sKH/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B7253359
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688712; cv=none; b=uT8RS9HlQtdqigZgonD9KeSgsEKwcfypL6HL1NEHPNVyCkvBv1W0SJH8K4a9n6R4Z7EvP5mqmFfxqS/DUx1SHjP0Tf5Tn42h6Aap6xjIrpLlEdm2u5/fjXwODG4vqTak11L4y+nMDMwV/XLcxfAWQrYtrUahtjG6ZYSrI7dD/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688712; c=relaxed/simple;
	bh=0UZtMH503c8+1SDVd6iG+rOnSlR2koS5U3DxzW6SI4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrCPa7ZdglLMhwXlfkrrRS6+vJWwN29G8RR+r20ri2zp7zpS87s/t3nO4CYZUVUp8wEuqzA0UwHsoO7RD5FFMW8WY6Z4lwrnILi11zesd9b/baIBOA6vDb7rjCHnBwJNBXhF6be+8xwya0DDFqNi4n58tL88mbu3pQm8LlTlvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hz5sKH/0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a6f6d52af7so51228141cf.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750688709; x=1751293509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UZtMH503c8+1SDVd6iG+rOnSlR2koS5U3DxzW6SI4E=;
        b=Hz5sKH/0CUqCVy+gyeVDbBluqvWvIWtW/vlElI3RC9jKg+1d9czMYTUOzn/Bq9qn/V
         jn/AMkslROBbF3BWXMUcA9zdtSPBa+WCLXbg2jZ99/6wwqaM7P4CGUtdZpuDNQEdqtww
         pUyRzqSnrdcKoi+RYigvfqbE6QWxd8xB8sjJLNt6ACK/2Qdscc0uamLizbxiGiTjyGGQ
         5YLU5ELu0j/QDsyNxSQOYb7/1aqLms3T4z7xhX+d61PoNO38zN0RauyUMpKY9aLSmNnA
         Il5fTV0bbasKtzVxXezUZCEbZAGNpU/2BcSXRkImS6nZeZ1RhLXpVibByaQOX4tYn86g
         wODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688709; x=1751293509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UZtMH503c8+1SDVd6iG+rOnSlR2koS5U3DxzW6SI4E=;
        b=jzC3UUgmeEwwKzoUFmLrbHK9/JLnK26h90gu9+duhXPF95/cXsxaFQQlmxNPANKaBu
         MsYZ8lif2ABZEusTgP4uNhrrX0tYcO/AQjLbaqttsekS9SOuD+hL7dPO/6yVtvxH4Bws
         651/1rq+OjeUiPpHhVwK8ks+sNZZ1sz4/Z6JcUrPVL105KFUOvXRaQ1ZvggUTd+o0WEa
         gwd8EJzs1yfzBYEmR6O4NtngH4IFXnRZhMda6oS2CK7wNItkBwwzpHZ4l51XC17hw9Kk
         OW4IjyUUXU+eVBloEynAG/h66pIUy7dEc+Xi4TTL3WxcGxVOumlssRgR0bA/Fe/4L847
         mWyw==
X-Forwarded-Encrypted: i=1; AJvYcCUIwcK9g21oicQbbWA/iHzBW2rvWqRpxVptUW6JWa+1G1JdHqp+RABtdUFtync3mvoFR7oHznU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrm6eecXR5avqW+te1O/kbBTXxdTv9m3020wtWfMpzlztjS5f
	RhhLjlH5Jp1Y40L4xySb2iov2yGqnXE19eSGjTlaLljPttaHsCSqAwxxgCKANzwnyZBV3ULNUOb
	caCrQJff4U1k6PWUJ451Wf9wInH5pHHDlRpaTqtM9
X-Gm-Gg: ASbGncvH8qkCBKYJ7gJ8DZ2tQeFGQlnZmG+kEke0pJZpz7hTv5XBPWgLTg0hZ3VAAP9
	wc1GRkDvweC73KPWqo4mbtAe0WZpZVG29srs2P/Zn2GAW5LRJXSPvHj5kB07vD/z5C6M7jG4YHw
	RraXS7iTdIWBW7ZEBqb0ZAsgp8+P8grSN3m7rMcaFBFHs=
X-Google-Smtp-Source: AGHT+IEmKVWhHe3CQXXXmJ+3AX8EMi+q/7rsvjNQufpnZ23z/jr0CTEgZ/cgGqhdl0YDzCXcGLOX3ClO1xMMJtgKcVk=
X-Received: by 2002:a05:622a:81:b0:4a7:30e2:b31e with SMTP id
 d75a77b69052e-4a77a233d86mr212392981cf.34.1750688708438; Mon, 23 Jun 2025
 07:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-3-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Jun 2025 07:24:56 -0700
X-Gm-Features: AX0GCFuuumLhEceI4NFGCl3EfDcvOiQNAlPh4nu_8dUwfmmZX_i1-HOe9hb43D0
Message-ID: <CANn89iLzOJ6YqQuQGOm5b8vdbJ12jp_2YTbKW=aGZjsy6FM95g@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 02/15] tcp: fast path functions later
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:37=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The following patch will use tcp_ecn_mode_accecn(),
> TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
> __tcp_fast_path_on() to make new flag for AccECN.
>
> No functional changes.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

