Return-Path: <netdev+bounces-205407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39B6AFE93A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC75562FEB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9B22DA77E;
	Wed,  9 Jul 2025 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3i5HEK9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E43597C
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065068; cv=none; b=M/TKStXVjFatgMIzvOqIWNwHnkDQH/O1aaKu/NSc27KsZaRhh6y1vwbiOyhUdX73wAf8SvL0XuyZiFjFw/15REAXh5/wxAFgQ0LnednSoJV8I30tut6+HIf/vR5jWOp6iXHRtCyqFvce144lO9F9XfxOK54H8keMj+NP8/Jf5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065068; c=relaxed/simple;
	bh=IAdlkXmYJnbautpH45eYgye/PX0Z4HUwzD9R6awi71c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjQVhEfUQX4GLrC1QbVo/EKmr8YXCyrOiRAhD+3Kqp7nEiNp8GR0gWyOhIG+haFXPaJHWk0xsLxrL4uuBbzNudaXBilYIUnQW12083SRRdQgjnPdIBcjiGgExghILUl91MseVuyt14RBE1E/KZLxtf8iJQd667fcBa7g3+cpTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3i5HEK9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58d95ea53so11507881cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 05:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752065066; x=1752669866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ2pFoBfWssWUMIkFLx9BPizPkUSvYsKoHWqJr87Tgg=;
        b=g3i5HEK9YC4QjO+dLsQKwAT4baYDcXZZTZGsvydP6zdHHc2yRtJOWp8sN5aBN67VCg
         gm/VU5953mC4hJ3tGJqmmH8IKtBJLskzuzDHMbyeBlLw+L9JrpLaw0sBTGnfE1A9RStm
         jlaVrb626nihlkZdv470Twtz5V3Y+ZVNLakPu99uvadun456WnLt2e/ESmaQYIYULNt7
         t3xM7W8o1yg9lMx8mJylH7yo2lbHoS5TtvJxEQokO/vkyU3SCt4vyDtUw9Ll8M2+hAwE
         6t3B5K1nVaHHr0YqoetuSNFJcEZh/5NoGSudC0QGYUyMbnyLmiSvnSvevVUOsFqvgzj2
         mTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752065066; x=1752669866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ2pFoBfWssWUMIkFLx9BPizPkUSvYsKoHWqJr87Tgg=;
        b=FATS9Yw5rLCC3izXBN9Mtfl6cDXYRmZRnApMyqNFumWuU+D+kixjyN+siurnmIuRsP
         /9Nowjqvu2CimGtfUWpi2rGdP0KxbA9iosogpCkTUx1e1OrCG9QfCEchcAmOYQha55X1
         fDu8DijDiM7paZyKkuX8Z5NuL7WXxeV7fSXfPOMADlYeL5QAUPcHzDhLJfdjpWXufXZN
         Vhh5OTP2GtIvQWW549lCdqJwBQKtkzr/RRlEAdsK4N8/qK1kmdSRATEKZO8GLstMBBxI
         V6MF2tK4eWq5vNNjsOn4iFw4ifnaf+NWj4bx99xTRa3lHaV9Jit8cUXJOdJVWFQ5hsRV
         gKLA==
X-Forwarded-Encrypted: i=1; AJvYcCVn881bpS2pIRoCy6W+bD4KvO8iZVo/k6nHeGQo+DMmXxprPi4AQMKkaHywReXTRdFrKCD2xd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYZSFQK5kSgWnj3e1+9VeT1EssJ97BT3b5YC4JiTchXzCAT+G
	Nbcw77tDMGoYbUXnUYbTCehmtGUupo+hr6GhvjGJRy8DBUVYHlVlpAzcJ6BEa83nSJ+wWoD+j7/
	gYC/bezFu/SnRTvmrR4b3BB2EFqdE4J6+JU652fvq
X-Gm-Gg: ASbGncv39rwoqqKvv+D3KFHYxORL+crRG5xsvXH6B30HWHc4ae9QS0tTf8rf4K307wM
	FK0I4DAmOVaJz7X7q3Kuks6XCcbeL7qekRxITh8lidG1Hd9xreJuqbNl5D4KveRf8k+J6f2fFB+
	hanDnzxe5jXrnkSG1Anfuei1lPgcqTHI2Rjaemj4PwrrNQzPMJmQ1O
X-Google-Smtp-Source: AGHT+IF6HV1hGzAbRKcrDqbmUhNZQ3JD6E5sUCFQXTonDPWmTLwmgflb3xbsoN8Vq+8aWGcXfWI1IoV06zTydysA4DY=
X-Received: by 2002:a05:622a:5a0b:b0:4a7:7326:71be with SMTP id
 d75a77b69052e-4a9ce4c08a9mr100566731cf.5.1752065065445; Wed, 09 Jul 2025
 05:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709095653.62469-1-luyun_611@163.com> <20250709095653.62469-3-luyun_611@163.com>
In-Reply-To: <20250709095653.62469-3-luyun_611@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Jul 2025 05:44:14 -0700
X-Gm-Features: Ac12FXxyCO7LIPlCP2Qe8xqhwgnGFOKidInr8A6Xi3bns36W4r2F_LC-4GXwjZU
Message-ID: <CANn89iJZ=t6Fg4fjgPooyTAbD4Lxj9AKFQx_mnJty5nq9Ng9vw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by tpacket_snd()
To: Yun Lu <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:57=E2=80=AFAM Yun Lu <luyun_611@163.com> wrote:
>
> From: Yun Lu <luyun@kylinos.cn>
>
> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
> pending_refcnt to decrement to zero before returning. The pending_refcnt
> is decremented by 1 when the skb->destructor function is called,
> indicating that the skb has been successfully sent and needs to be
> destroyed.
>
> If an error occurs during this process, the tpacket_snd() function will
> exit and return error, but pending_refcnt may not yet have decremented to
> zero. Assuming the next send operation is executed immediately, but there
> are no available frames to be sent in tx_ring (i.e., packet_current_frame
> returns NULL), and skb is also NULL, the function will not execute
> wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
> will enter a do-while loop, waiting for pending_refcnt to be zero. Even
> if the previous skb has completed transmission, the skb->destructor
> function can only be invoked in the ksoftirqd thread (assuming NAPI
> threading is enabled). When both the ksoftirqd thread and the tpacket_snd
> operation happen to run on the same CPU, and the CPU trapped in the
> do-while loop without yielding, the ksoftirqd thread will not get
> scheduled to run. As a result, pending_refcnt will never be reduced to
> zero, and the do-while loop cannot exit, eventually leading to a CPU soft
> lockup issue.
>
> In fact, as long as pending_refcnt is not zero, even if skb is NULL,
> wait_for_completion_interruptible_timeout() should be executed to yield
> the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, move
> the penging_refcnt check to the start of the do-while loop, and reuse ph
> to continue for the next iteration.
>
> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for tra=
nsmit to complete in AF_PACKET")
> Cc: stable@kernel.org
> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>
> ---
> Changes in v3:
> - Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
> - Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_61=
1@163.com/
>
> Changes in v2:
> - Add a Fixes tag.
> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_61=
1@163.com/
> ---
>  net/packet/af_packet.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7089b8c2a655..89a5d2a3a720 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2846,11 +2846,21 @@ static int tpacket_snd(struct packet_sock *po, st=
ruct msghdr *msg)
>                 ph =3D packet_current_frame(po, &po->tx_ring,
>                                           TP_STATUS_SEND_REQUEST);
>                 if (unlikely(ph =3D=3D NULL)) {
> -                       if (need_wait && skb) {
> +                       /* Note: packet_read_pending() might be slow if w=
e
> +                        * have to call it as it's per_cpu variable, but =
in
> +                        * fast-path we don't have to call it, only when =
ph
> +                        * is NULL, we need to check pending_refcnt.
> +                        */
> +                       if (need_wait && packet_read_pending(&po->tx_ring=
)) {
>                                 timeo =3D wait_for_completion_interruptib=
le_timeout(&po->skb_completion, timeo);
>                                 if (timeo <=3D 0) {
>                                         err =3D !timeo ? -ETIMEDOUT : -ER=
ESTARTSYS;
>                                         goto out_put;
> +                               } else {

nit (in case a new version is sent) : No need for an else {} after a
"goto XXXXX;"

if (....) {
     .....
     goto out_put;
}
/* Just reuse ph to continue for the next iteration, and...
 * .....
 */
ph =3D (void *)1;


Reviewed-by: Eric Dumazet <edumazet@google.com>

