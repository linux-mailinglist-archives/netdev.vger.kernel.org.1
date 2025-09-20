Return-Path: <netdev+bounces-225006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FD5B8CF31
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 21:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B05179509
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A06A23D7E4;
	Sat, 20 Sep 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zenAKCwp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB41DB122
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397129; cv=none; b=C3t1yWlqpY54SgQDwH6xkJRDpnXuPRorHPjWR/fxXz34TCUYqNptXBK33puhkCCGucs7Ukj6aPaplSE0nOj0gR7sr9fyuJZQ3P5YLyrvPFMELBdtyR4NVoENA3Qw7RufDujzLlPak7MA4dMF1saQiRA4NWHRH4hXsi9/SAnzbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397129; c=relaxed/simple;
	bh=KgUnkQgEryI4+i+0SZ1ZrvjpVtNKG5/O91vj5h2fcbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKXZAcFe2TSDdyJwWV1PROpkVotFwLK+BHg9wurBoARdu8cXsbX5vLm72DEOZ70ZXbj57GvQVM99OKh7TceuOVObpaPCTK2YtatRt6UlQL25okWvV1km1EkRNwTwn/e/fMgpOXXCkmPG/cmRpHOABaIuwwOYyzhJ37ZSlOZOGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zenAKCwp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b38d4de6d9so20923661cf.1
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758397127; x=1759001927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtnRcilC6eNsvcK5BHkv1krIV/OTznTLAfwyrPbpEyM=;
        b=zenAKCwpk7BLkcvlg9M1tjUp0Yl2lsI2VaKha36F2CMo4c9TU60k5jb+62OALup7DK
         xAF1xt54BL/6NWxqvTubc/ovX/ZXug+0SfsoFQboMN34rpn8iMCUVjV5aE/yD5HwEy31
         J3uw5R8W69T3V/Q4tQAn7scyxKcEDrnswLfSkwwjS8q6EWMFMyRMP1KP1vPSiY74ZNl8
         5S3jnzkt3DOSwMXcR0ZABGb1C3uxT3At8dTKtZzzzjPpqeAbX+rsIIhUdeEG07hQlzJr
         snJlpMR9P9ySMBB/m2m40Xwut2KZonf4ydlPaTAbDOyREHFBmav6QSPoaYbST9VaTS9B
         qoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397127; x=1759001927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtnRcilC6eNsvcK5BHkv1krIV/OTznTLAfwyrPbpEyM=;
        b=tMdcFIkDAq+bocmJUqx2pmbzvL9f+4/bvn/8qHscSYo9bi1rb0w9CJG5mzs7xByjFN
         RTnHbw+jKWBExlzXMbh/RxNAMHkZ2B47LV2rnjDpYVL0hTPpUTNr/9k4IGBRTtcWyd7M
         lGN4qY2eC0l4/SJLDZY1iWBPt4HCFdyN5Z7mnydcfp44fuGLmM97Z1tHX3QJhhpaN2Gq
         DYXbRIHN427x/Ao1qSPs5Fzq6fR/qphSUefzdbRe3Yz2pZYOlZBB0UCuaioarjG7XllZ
         T7xxcX+5FN/IqVpWSpo+n4NdfeeEhPXhdz4U6KjJHv1wKjC2yMuHps/ixL4xA/PRlRjL
         L/CA==
X-Forwarded-Encrypted: i=1; AJvYcCVkNM+UzON+koEUPts3L+VTMifnQvznmzCKVXp8+YQxfvsRkcuy6wcegfdIHFTqcRLbwJ+cJ1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgdehX83Z53fpQ455uacTSR5SiI0Ke4/EChHoiOoEdUfG/Gkm
	DSQqeGeuoRFiSyu5C5VnluFtYGXr8Za2QYAAy841/gvps+j76Y4smAha3p5O91W2XHzeKQkKNN0
	0k7eBj+0TgvEuSY6xh5ZEjqln7csAB4ITwwltZ78a
X-Gm-Gg: ASbGncuBgoUO99FkkVPgmnxfA6JZX/YXpKIe6+G6NZV08IqbXmL0YQIYom8QGBiom6n
	K0Pc51M2LuBVQkHan5XkhkDKakIbniEyWVZbQGuDJksJBvSr43Jx4o24wo+wJ397lcHM0BnwhmN
	3LW3f+IJhA6gyCf/L8yRDJheMaFnrVbqN2j0Dxucgj/Z5p6OE/MpyETkZPt7sUgqpRP/IT8JXwo
	Bov+YuD
X-Google-Smtp-Source: AGHT+IHwKdxFb50aeHCu0zfA/eqBOuKP9fXGGxh1a1SVNT98cIAk9GdqMdo7cjvqn6ADUGsNxNVHlHhWsiPZD+rwR14=
X-Received: by 2002:a05:622a:90a:b0:4b5:e12b:9e1 with SMTP id
 d75a77b69052e-4c073c9a3ddmr71857371cf.60.1758397126469; Sat, 20 Sep 2025
 12:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920080227.3674860-1-edumazet@google.com> <20250920111059.500c2b8f@kernel.org>
In-Reply-To: <20250920111059.500c2b8f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 20 Sep 2025 12:38:35 -0700
X-Gm-Features: AS18NWBouUVISk9xgqXbvVI8vUYL4uUqxpwbjqEtWuLVTpuozezmJNjM11iWkPk
Message-ID: <CANn89iLATYmTgvxxLjv9nQ1opGVqDZpYfxc64qsk0H0sUQvEWw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] udp: remove busylock and add per NUMA queues
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 11:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 20 Sep 2025 08:02:27 +0000 Eric Dumazet wrote:
> > busylock was protecting UDP sockets against packet floods,
> > but unfortunately was not protecting the host itself.
> >
> > Under stress, many cpus could spin while acquiring the busylock,
> > and NIC had to drop packets. Or packets would be dropped
> > in cpu backlog if RPS/RFS were in place.
> >
> > This patch replaces the busylock by intermediate
> > lockless queues. (One queue per NUMA node).
> >
> > This means that fewer number of cpus have to acquire
> > the UDP receive queue lock.
> >
> > Most of the cpus can either:
> > - immediately drop the packet.
> > - or queue it in their NUMA aware lockless queue.
> >
> > Then one of the cpu is chosen to process this lockless queue
> > in a batch.
> >
> > The batch only contains packets that were cooked on the same
> > NUMA node, thus with very limited latency impact.
>
> Occasionally hitting a UaF like this:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/306342/3-fcnal-ipv=
6-sh/stderr
> decoded:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/306342/vm-crash-th=
r2-0
> --
> pw-bot: cr

Yeah, destroy is called while there are packets in flight, from inet_releas=
e()

I have to hook the  kfree(up->udp_prod_queue) calls in udp_destruct_common(=
)

I will test:

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index fedc939342f3d1ab580548e2b4dd39b5e3a1c397..59bf422151171330b7190523e0f=
287947409b6b5
100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1808,6 +1808,7 @@ void udp_destruct_common(struct sock *sk)
                kfree_skb(skb);
        }
        udp_rmem_release(sk, total, 0, true);
+       kfree(up->udp_prod_queue);
 }
 EXPORT_IPV6_MOD_GPL(udp_destruct_common);

@@ -2912,7 +2913,6 @@ void udp_destroy_sock(struct sock *sk)
                        udp_tunnel_cleanup_gro(sk);
                }
        }
-       kfree(up->udp_prod_queue);
 }

 typedef struct sk_buff *(*udp_gro_receive_t)(struct sock *sk,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 90e2945e6cf9066bc36c57cbb29b8aa68e7afe4e..813a2ba75824d14631642bf6973=
f65063b2825cb
100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1829,7 +1829,6 @@ void udpv6_destroy_sock(struct sock *sk)
                        udp_tunnel_cleanup_gro(sk);
                }
        }
-       kfree(up->udp_prod_queue);
 }

 /*

