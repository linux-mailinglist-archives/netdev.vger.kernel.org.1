Return-Path: <netdev+bounces-232206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE2C02A25
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7453AFAF7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CB9345CDE;
	Thu, 23 Oct 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAzeb67q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA25345CD8
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238577; cv=none; b=CA3isUZdoGSlBRyoqYwAlCvkYnquwxctR+H6qdgS8pCkZ9yu1cAM6qGykI9eLTZfFuE2U1/KzXvleFRoLLLbi4BFBCMJqXcyLmQG6C7TEdYnunzicWmv2z8Izjko3K/0m+VTG2p+EAy5zibw613Jve6D2l/xNKjKPj+rxy8bqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238577; c=relaxed/simple;
	bh=7sTaFAY0i0UpyN/V+3nClAJ0FqgP+WzfxcAytNEo09Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiqZVK2VWkW37T+rmQfYDHhI0wrlZpba2Sll2+r3K+kIxmHV7JNJdTGbz+hRMRn/fGPJ4LiYEyB+ykqPegtzYXR81pZPf0oYn2Dzsx7vWP1tJDYTJJBemFlksDMaBdV0L5aAtQRhVPsPHwz7DTrBcS5aGf+2eFAHF+hhvdy4ImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAzeb67q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7833765433cso1399959b3a.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761238575; x=1761843375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyIF9He3AQaNVecfdTsFNoyNYPTFP7D9PI/cuCCk9Bw=;
        b=BAzeb67qK9p+jvgts23+2lIY3fglCm57lUZ2jwpZeCJ7Ccz5n2n2wBheVkShVnjHUD
         1UU6AIG1JRvQEhMCsP8LVLmvjNzWL/cWCwDo9nH5ppGM7FMnYajgkq0jnlAKUyvMiWK1
         cyr+icMPeY4+ilxLLW+ADdkQAj/gSktc21YcZPVDFJNcWpSFONp+hd/ZbwFoALMHUzQ2
         3AVr2PIrGY6Xbj8zjVDdnjhzz4gs55SbodlqQjgak9blbdPTluheimM0Wc4xcvv0/grK
         xLXUYP8DOCYNeg8bXcy8YPF9cvSqIvA2b1EBhvHFjXTKmBpmxdGUYWqJNvDoC0fooPd7
         LDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761238575; x=1761843375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyIF9He3AQaNVecfdTsFNoyNYPTFP7D9PI/cuCCk9Bw=;
        b=Fbcdr6mW/YUSVBrnFF3UVe16kyBnBO4SuOZ49/beaOYCRyjDPXahUGI1Ya9Gwe5s5f
         EPrqvgdiHlQWmpp+BpFuhBNYtRluU/SLnwZ9o09Eaq1nagNRd8Qaxp0lfrKblSjcyLjs
         Yen6RN3WHp1Ha/LpusdKw42i/SmEFyUgU8dbhWeRi62DT+SpfBdRU2GtRVLPmcKhbh2c
         Kn3+Yj/rzqisOzDltcSYO+ChTZJWs4dJxYRCb4RuGngTqI6FO1Q1a+cHJZyh/OCVMxjS
         B/qoyGZ0QR9g5Qkn32mX+Wcdspc6hcqYIX0jo/4hFXoesK9ikcb5OHGtiXeEktXRYQi3
         7PhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZJ/JZdwpAWSZe1ulv5yNsb6pUbu0RaMdEQvWeRY2Jel2yrP+pYhVX5EzuYBLUXYuh5BJzxXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfpZmeSWTXQnN3K3UIdXNTsKqmxvYOtJ4FCRWF7YO72OwEeGd
	KGde+JxFDfvQhxF/cm383pyUKz6sQaR8MecjsYaDeGkdrZZ7oyEp20CU3HQT5zKNnoQOeDb+Rwv
	DI7sHgxmg4zq3stkADoAGtGoLHoGcAbpW3oZv
X-Gm-Gg: ASbGnctCcWSeZ6Rz1Adll7vlfGzQOjan7GwBkKE3udBU6b3pV0msn33bUiX7tHEEoHv
	tqdL7f8XJfgjFJuCg3w8HMLWq0Xo766FDHimj2v4mGSKBXvmPClhdcJblS/G99889ZLPtZ1QWp5
	ctRI/5A8NXKnkyc3xA2TfHr4BuuW99ld5bcnGv/MOvFIeZBRKmTYNxZQog0SVD4EOV3Hmsk0y27
	SQiDrFzlmOy1+FFYnqQeONGLPFRdJLzezx9JB0UxUztMQS04FQgCTdqKKbtuY1QQYOwzOBg7GlE
	5mDAiZMiBKalQgwucnxc2wnssR1p1w==
X-Google-Smtp-Source: AGHT+IEvRoXJfYMZjLnM9ZP63L/5zp9Rf14uYE21EAJuMeQwO8GZzBEVXuVhiBcrXsZ+KWISLhDWamGqzNn6ZRdV9YM=
X-Received: by 2002:a05:6a00:3a21:b0:781:4ec:4ec4 with SMTP id
 d2e1a72fcca58-7a220d30df8mr31645438b3a.31.1761238575072; Thu, 23 Oct 2025
 09:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-kmsan_fix-v1-1-d08c18db8877@gmail.com>
In-Reply-To: <20251023-kmsan_fix-v1-1-d08c18db8877@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Oct 2025 12:56:02 -0400
X-Gm-Features: AS18NWCOd__EDody6eeBwzndQnzzqlcDk_m68XoL7saCBzCoOClxu7kW1b4-ve8
Message-ID: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
Subject: Re: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:52=E2=80=AFAM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Fix an issue detected by syzbot:
>
> KMSAN reported an uninitialized-value access in sctp_inq_pop
Hi, Ranganath,

The issue is actually caused by skb trimming via sk_filter() in sctp_rcv().
In the reproducer, skb->len becomes 1 after sk_filter(), which bypassed the
original check:

        if (skb->len < sizeof(struct sctphdr) + sizeof(struct sctp_chunkhdr=
) +
                       skb_transport_offset(skb))

(TBH, I didn't expect it would allow BPF to trim skb in sk_filter().)

To handle this safely, a new check should be performed after sk_filter() li=
ke:

+       if (sk_filter(sk, skb) || skb->len < sizeof(struct sctp_chunkhdr))
                goto discard_release;

Could you please proceed with this change in sctp_rcv()?

Thanks.

