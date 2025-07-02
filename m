Return-Path: <netdev+bounces-203293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E90AF1339
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B293A7B7F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482EA258CF1;
	Wed,  2 Jul 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="C9bRSqZw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97519AD89
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454326; cv=none; b=UVOVOBgLuXjgcz5eRBDYnq6efooqKkWGxvm16U+b8HF0G4TfbzPKCLGi7X1Ihh6dtDmccJC2u5GcW6X/K9lTBbl/oMm/yo2qjiWW9MEvowejI2rSJCnDWLrMKTKOdgV1TowgY0Xteuf++3Rq46xnnRblklPPMpufdpIBTOJmAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454326; c=relaxed/simple;
	bh=agRYeoOwRt8h0k2J+LL4XYo1Frd7ebnhO4GcAjaSxP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SS5nPAoQ7sftH76P09yIIXSYp1zkOt4L687+edHyc6yNjQbe50wAiBPObCh/sJx1oHE+6/joPpIxEgKFcjtt7vkBvB9GE0Jfk8cf9XJvn2FVFLl0vFyGfamAhYrdVKlfw2Mp/ZyQgjxZuXW1tE+ZsFz+3DhMJ4nxRbTAeNF/TtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=C9bRSqZw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so6277696a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751454323; x=1752059123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2C4+Yvp6OyfPa23VlNkCKp6gnO+5rj24D3Gx6EnEvI=;
        b=C9bRSqZwljEYUbnwY5j+wUl1A5Qm4Pt2y9UC/Vuwnt8+gegO5xZiPPeYUwCg9PIOoF
         k6ECa/aDPswz3kE6RaV9xRp12fBCLJltweP/El/9Yvb1cwFnFOq9YysLBWq4051059Bp
         1sK3yQPHtah1MkeGufT43ykTH4ZKejAvzZsIgpUsbJwgvxO1GDWgJjl2FEJBZTIiLVi1
         Qwk5n65WqXjcxkHCl64OgGLACGKQmyztIWfCAmUXMrR3S8XbBQi45y/Z4J0hFoMBasEi
         vGn+Rq6nQB+g4w0vbNTFqjMXbNWSywcdWXh/LwVoiyFlg6ZLoROvoBe1l4Xtu4tXFD0Y
         ks/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751454323; x=1752059123;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2C4+Yvp6OyfPa23VlNkCKp6gnO+5rj24D3Gx6EnEvI=;
        b=R3Io+90E7UUfsFkNB87rb30ZMV9COUYAJxzonn76MT3QOVZvF+U36JFr1MCdZB0fqM
         8l/T25Xd6gpCOgrpJbK8fHJ1zd6w92Y3oDt5p+yGGU1DyWdmI4ZpQVvIhDWU9ICFXk3H
         sBy3/w+tPu6ZFs7h8i5jxb9pX2q0GJvLw4X8yKAamKeD7emFjQr5kBvnX3mvig9qUOnS
         swBjo7FL0OcCTMMQ0L9Pqq43Kf7+R2bRPgJMRbwg8n9QUaemwPlCQcV8R7v/Iijel7bU
         rxIm3ldqKME8hEqh/iyAi1j1dQabICNR/1up+uMneUOWCWSrxRYWt0rsTlGcJaQ0iYcA
         sfUg==
X-Gm-Message-State: AOJu0Yxvg+N+h1tZUklROHpjkfi1bsdBhhHEvGmP6bZ2hzLyttP3YJZE
	V/9dcUp5g/83wKHp+FWXJ89VAxNmcPcCAW1fZ1gI0LuxkEP/nhh09k9WKik/HAzlaxk=
X-Gm-Gg: ASbGnctWIhjIYB/9JBlBnzm/G8tiCmi+hJ6m+qQLEieX6C/8/AJyKOOW9ekyHE8mZpd
	GW4hrZSeiajQVOYDFw6HA585BpNwZWxjMnGAayWGrzZId0tZv8ceGy8wnKjxT7Q/ELNZ8jGwDv2
	SsU9JaLhJulEJpQ2jQ4AmzAnzDcR4JRbbetgqANVwD4gxzcw36YlD9ARYQnLRxBoR0xooYDVBYw
	JNiA4kjTv94CEZw4Q6z2X3zRLbxwgsgNssqv20Jn1N9kOkipgwAuC/IxTjGZrbE6ohHbPO1m4yE
	YiMP/tZumQDAjcYkUjRyTONHbt3DMW5O3Bx12Fa36auBQJLXcVqJZKU=
X-Google-Smtp-Source: AGHT+IEq88zmgjpOc6byeXLCyqhGjreTvPH4otpjeBh/Fsctu9Dyd3D9+xoyG1tTQ2bMYn0uypOR8Q==
X-Received: by 2002:a17:907:1c0e:b0:ae3:163a:f69a with SMTP id a640c23a62f3a-ae3c2d4e7famr229869666b.33.1751454322620;
        Wed, 02 Jul 2025 04:05:22 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1cbesm1059139466b.166.2025.07.02.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:05:21 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zijianzhang@bytedance.com,  zhoufeng.zf@bytedance.com
Subject: Re: [Patch bpf-next v4 0/4] tcp_bpf: improve ingress redirection
 performance with message corking
In-Reply-To: <20250701011201.235392-1-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:11:57 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 13:05:20 +0200
Message-ID: <87qzyyn98v.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 06:11 PM -07, Cong Wang wrote:
> This patchset improves skmsg ingress redirection performance by a)
> sophisticated batching with kworker; b) skmsg allocation caching with
> kmem cache.
>
> As a result, our patches significantly outperforms the vanilla kernel
> in terms of throughput for almost all packet sizes. The percentage
> improvement in throughput ranges from 3.13% to 160.92%, with smaller
> packets showing the highest improvements.
>
> For latency, it induces slightly higher latency across most packet sizes
> compared to the vanilla, which is also expected since this is a natural
> side effect of batching.
>
> Here are the detailed benchmarks:
>
> +-------------+--------+--------+--------+--------+--------+--------+----=
----+--------+--------+--------+--------+
> | Throughput  | 64     | 128    | 256    | 512    | 1k     | 4k     | 16k=
    | 32k    | 64k    | 128k   | 256k   |
> +-------------+--------+--------+--------+--------+--------+--------+----=
----+--------+--------+--------+--------+
> | Vanilla     | 0.17=C2=B10.02 | 0.36=C2=B10.01 | 0.72=C2=B10.02 | 1.37=
=C2=B10.05 | 2.60=C2=B10.12 | 8.24=C2=B10.44 | 22.38=C2=B12.02 | 25.49=C2=
=B11.28 | 43.07=C2=B11.36 | 66.87=C2=B14.14 | 73.70=C2=B17.15 |
> | Patched     | 0.41=C2=B10.01 | 0.82=C2=B10.02 | 1.62=C2=B10.05 | 3.33=
=C2=B10.01 | 6.45=C2=B10.02 | 21.50=C2=B10.08 | 46.22=C2=B10.31 | 50.20=C2=
=B11.12 | 45.39=C2=B11.29 | 68.96=C2=B11.12 | 78.35=C2=B11.49 |
> | Percentage  | 141.18%   | 127.78%   | 125.00%   | 143.07%   | 148.08%  =
 | 160.92%   | 106.52%    | 97.00%     | 5.38%      | 3.13%      | 6.32%   =
   |
> +-------------+--------+--------+--------+--------+--------+--------+----=
----+--------+--------+--------+--------+
>
> +-------------+-----------+-----------+-----------+-----------+----------=
-+-----------+-----------+-----------+-----------+
> | Latency     | 64        | 128       | 256       | 512       | 1k       =
 | 4k        | 16k       | 32k       | 63k       |
> +-------------+-----------+-----------+-----------+-----------+----------=
-+-----------+-----------+-----------+-----------+
> | Vanilla     | 5.80=C2=B14.02 | 5.83=C2=B13.61 | 5.86=C2=B14.10 | 5.91=
=C2=B14.19 | 5.98=C2=B14.14 | 6.61=C2=B14.47 | 8.60=C2=B12.59 | 10.96=C2=B1=
5.50| 15.02=C2=B16.78|
> | Patched     | 6.18=C2=B13.03 | 6.23=C2=B14.38 | 6.25=C2=B14.44 | 6.13=
=C2=B14.35 | 6.32=C2=B14.23 | 6.94=C2=B14.61 | 8.90=C2=B15.49 | 11.12=C2=B1=
6.10| 14.88=C2=B16.55|
> | Percentage  | 6.55%     | 6.87%     | 6.66%     | 3.72%     | 5.68%    =
 | 4.99%     | 3.49%     | 1.46%     |-0.93%     |
> +-------------+-----------+-----------+-----------+-----------+----------=
-+-----------+-----------+-----------+-----------+

Plots for easier review. Courtesy of Gemini.

https://gist.githubusercontent.com/jsitnicki/f255aab05d050a56ab743247475426=
a1/raw/715011c50396ef01c9b5397a19f07d380d56cd25/sk_msg-redir-ingress-throug=
hput.png
https://gist.githubusercontent.com/jsitnicki/f255aab05d050a56ab743247475426=
a1/raw/715011c50396ef01c9b5397a19f07d380d56cd25/sk_msg-redir-ingress-latenc=
y.png

