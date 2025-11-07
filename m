Return-Path: <netdev+bounces-236703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B26C3F000
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64FE188CE45
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6B3101BA;
	Fri,  7 Nov 2025 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRgMv+8g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC321D95A3
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505011; cv=none; b=VBp/i5FPfBaRX/YBPt6TRpJLg91UJPFZnpmW6hw5QLm+YIxIfoJRYKs0WvFDgsELNxQ1S7eCXb3uQIys6NdtA+x6DC9bW4vOWxV1hPIrV8aN3BRz/niv9fxNLTKjLjHluO11oacCM8NqSm9NREiu5rGeKJeljpxYWZxvVkAWvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505011; c=relaxed/simple;
	bh=fjt/4j1HFWu8MXictzspIkQ7NLUClLwqhat7s8I8sl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKCZhyDY99VYKpTG1pu003nBxN/g4Gw0+EeYLQQSL67WJBz0pCxXeIDQ/ctIwX+2dT+Ir8WB8KvbDZ4SZ0mW8nmfhuqUlOuT+qKz4JC4iQaqj8Bu/cXsyNEDpsCzYH/7HHkiMNTeNSR5HjBURsdS8HjcJ0uJ8MLS3/RVG/uVNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRgMv+8g; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8804ca2a730so8881326d6.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762505009; x=1763109809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbWpUIzre2k6WgKfKaWKTjJVpYnUjh1VE5vlvgQ0a1c=;
        b=lRgMv+8gS/uVjRqjgZvsnasGQ2bDyKh+J126moGzEKRz+bIsVHU5OK7/2jHaaTWyp8
         Ag+YjTJSSKzSI2U1+fJv+C6DkZdcAyvnCQ8mfaJuDTzcVDWz/ojuurfFXhF8rpeBNhfb
         owReqxgkQlBHl4LZd3MjdFsp0BqQtT3Ldggp1xNvi2mVL+YH3qD9fLELnsCvJ6Fg/j8M
         AScSlUgHf2HGQlH2BDqxdiRu9rqK1lELwgGdKz8sjzkT8+1jyGIR1ny+w0mx1KcJQX37
         l3fBBhLywJv5RX3HV4E3GIwGh9PxG0O05CNPyDhvAMSBIB9/eKq1TXqo/b3eMuzrxDDx
         OBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762505009; x=1763109809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbWpUIzre2k6WgKfKaWKTjJVpYnUjh1VE5vlvgQ0a1c=;
        b=qKO2dhYkjI1nVDBuQt8PvhoRZ3we2eGlYcl22vCruSLC0Ekg13LBNfGcVJ4nPXNg8p
         0rbvtlU+FSV+aQ5k8wmMywW5Lm5m3IpF59XxQ8NnLY9g8viX33kOCY56YPNypqw6ovWr
         Qg/mzo77pQhgTadYjcq0l7Yu2JeA3kQ4HJOtG43X0bU3PT61Xl+6Rk7KRaAXzu3CE8ON
         xduQS5EuJD3Ne1GP5tfNyGmJe0JPYOhjoC3WfG3iVNA8esnIzZQ9zn+gN05i0hZfijh5
         zmqngbgwanInC2tdj/EfAOIwGpF633/Okv54K3GZr3i+hEUcUOeasPPBeMV2y/fmqjf8
         jhcg==
X-Forwarded-Encrypted: i=1; AJvYcCU0dD1vejvPy5WLdB/Y7Bg1/cx8HEj0/eEhXwFi1yR0ccR7Qr2TSBIrwFbXYYz2MA/+a4FMg/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyem5FIPfgMX97AjkUsW7AR9zj+bip76CVJYTPKst5pab5KzL1R
	ajzVVx0b1jDBXRp9bsQ5ZQHNE4djAZo3VGFBbLWU9BKwJEdQ+cKjoY1hNW2u96q4qiQ1Yu0g+kH
	rJ1UP77vQpSuXq8MuKwMkBCwNULOsSznn3zCKeqlbljLtT1pLvpPEDPNH
X-Gm-Gg: ASbGncvqunrb6mRGN8RbzcVpo53w8giyluu4q4GyXl1m+4rIxaIg2ptwnUOkah57YqW
	1JJyeuaDxhXRUvOt8LO6nS9pvu2JoOZ89NaFr56mNMlERiTOvw97hTGYfegOx4wVjYHVQ6/iafL
	FlyF/+hnu4WtD7CX+fMyXwvOObyGH29wACLPwp5hzhFAn14/titmthYLOMkpxo8zg0R+NAIVFN2
	dIAVGDvuRJdg2oJt+7dKhFzMArN6CJ7e8b9shhhYrRCROPvEAMpp4nS2RzEDsB3iBhvK4Ea
X-Google-Smtp-Source: AGHT+IFn8XJjx+Xax3q0Efklbt+zLb8JBLF7hFJrEaQSCw5Ahrgl0ms4+3SPoi2AmZLlNMa+Ii/B/V5vCXhNs3wgkCU=
X-Received: by 2002:a05:6214:d61:b0:880:54e2:3517 with SMTP id
 6a1803df08f44-88167afcf40mr31162286d6.12.1762505008753; Fri, 07 Nov 2025
 00:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com> <20251106003357.273403-7-kuniyu@google.com>
In-Reply-To: <20251106003357.273403-7-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 00:43:17 -0800
X-Gm-Features: AWmQ_bnm-Mv8JPEu2rRcA9ueOSaNcH4YbnEEMluoVmhrX6OfLymqSiJ9CBcFBWY
Message-ID: <CANn89iJ9ED4WwnmnWM5ehMb9J=tMYK0Fh15Q2B2y=E6K=KbM7A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 6/6] selftest: packetdrill: Add max RTO test
 for SYN+ACK.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> This script sets net.ipv4.tcp_rto_max_ms to 1000 and checks
> if SYN+ACK RTO is capped at 1s for TFO and non-TFO.
>
> Without the previous patch, the max RTO is applied to TFO
> SYN+ACK only, and non-TFO SYN+ACK RTO increases exponentially.
>
>   # selftests: net/packetdrill: tcp_rto_synack_rto_max.pkt
>   # TAP version 13
>   # 1..2
>   # tcp_rto_synack_rto_max.pkt:46: error handling packet: timing error:
>      expected outbound packet at 5.091936 sec but happened at 6.107826 se=
c; tolerance 0.127974 sec
>   # script packet:  5.091936 S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
>   # actual packet:  6.107826 S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,=
sackOK>
>   # not ok 1 ipv4
>   # tcp_rto_synack_rto_max.pkt:46: error handling packet: timing error:
>      expected outbound packet at 5.075901 sec but happened at 6.091841 se=
c; tolerance 0.127976 sec
>   # script packet:  5.075901 S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
>   # actual packet:  6.091841 S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,=
sackOK>
>   # not ok 2 ipv6
>   # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
>   not ok 49 selftests: net/packetdrill: tcp_rto_synack_rto_max.pkt # exit=
=3D1
>
> With the previous patch, all SYN+ACKs are retransmitted
> after 1s.
>
>   # selftests: net/packetdrill: tcp_rto_synack_rto_max.pkt
>   # TAP version 13
>   # 1..2
>   # ok 1 ipv4
>   # ok 2 ipv6
>   # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>   ok 49 selftests: net/packetdrill: tcp_rto_synack_rto_max.pkt
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

