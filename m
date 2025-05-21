Return-Path: <netdev+bounces-192140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2BABEA26
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1FC1BA66B0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377E1E0B86;
	Wed, 21 May 2025 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egWpaHuA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568841DA21
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796700; cv=none; b=ssAcFrPOqBOW44j/sfPfZxzBsZQ5yjegaJlpeJiL3EjKBxyFLqSSHxdZHJorRCPjPwpCe5UIr03oyEsFzwov+2tvAo8svCqYf7sq+XkaA2FlHBHDJqgit45ttLSMaH4N4onm6ngZMEgpDJ5cmOkS3uYt3tnvm6h1cRsgPulyk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796700; c=relaxed/simple;
	bh=oKNGqJ4QCZAcKh6Vp2UKSmXuZCCv5GBIZ05NXjTpVsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc/8hmm463Lf0NWywLySVi55MRfGfbvkpnAOG/2w9fjj8U9KR8trraiP81TbV8lW9/ciQfJ07JVHc0y+ZO2SrtDF1hOt3fE1gIomVrqswGIg2+w1ANIXghVdOngl1BmPepeb5Aqv5rLrVD5FgSK9RKnfa9C9z6PmQoz2M2CtOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egWpaHuA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47666573242so1278271cf.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747796697; x=1748401497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64byJov1B8uVZZI8yUJl3UHAnxoBR3jsV8NO7iMWLzQ=;
        b=egWpaHuAeoWSZRcDrhkbHEENeU6wpgCDDI0zzAiN888ZK/alTN7qvG2Ug+Wh5B3oqK
         cC/MYfXYLR31CJ0udL0pG3NaJpWzmkCV6s+22/We5zZqSU8kl4YSt2COELWNF2Nmi5Bx
         UAATVwY+UVLMlMHHknlvtG5dvZvIwDqy6orWj2YyDCnnUd6JANbdPbRATD2XBZex2CeP
         g3FfQqpPoyXHJay1M15VhiktM4m/FoHKBhZVk4z8W8suGO3+lMf3AQR6lg4cvR/Pt65/
         9hTfELx+agC1zTj0nvkkGPDDDIOP6SJOIps5dwkKjdP6g7SpGfKFb8NeuZV1CFdOPGO7
         xfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747796697; x=1748401497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64byJov1B8uVZZI8yUJl3UHAnxoBR3jsV8NO7iMWLzQ=;
        b=bKl7CGw6PhmrL6eBWhcMLsopzG3mav7OZCoD/PqZZuXPB7cZAvZQvjgExjSjTLzEoR
         BNNQfyF87UOH5EQBTAsREOIGeXyHxtvHxrYJmF01CvgAz4LluASB8B4vW3od/kE+jgPe
         ULLmCMxgGQ7nL7djplFaQs6JqiewGTc339vZBgBBo0/LwrlGmFDOCLr+HeT9qTw/whSl
         OSz2tspw8dMwIgj/RqUbpE0BGAUtNduVtL5w08NRAIhfMLJZAAcD/onz9q+B1QcyPyMT
         tgj47pzrBBnDQppV50ck+LsqZJTEpzruwrvo3hDngK2+MJa5t9kqKgAKyY2raUkoI4ng
         CU+Q==
X-Gm-Message-State: AOJu0YyFE48YbqcFEZvURMozgOUagcc4TUFUB3gQdPd8tQ0w87rSWVMh
	9frXmBXcxQI+pP+nZUeh8KNjYIOf2rT3HKAXYs4c/HkoUlSRKl/ero4NvDxfgadvI/JoCmJqhQB
	VoOj+cyryCkWEZ8xxBIhyR4DeUQjKhDGT0gcZsoaw
X-Gm-Gg: ASbGncs60S8BrZ8qidUbBVvR7I0xrwxMF00We2mgtxd8CtSfma6Y02T2olWB59hVqmg
	qB9RcciNKh2PFACTSWIu348fA7RyMaHyGf+vQQbu1Q+MXKgoDzaQlmhUr4/M8pUZavuXSJr0uDK
	qGFdWszCG6VAJp2vI8A+lLy065J/h2TN+TVStePjqjUxMle8Sn6/UpEEny5ecfdDQRpa2iKNZr5
	q8=
X-Google-Smtp-Source: AGHT+IGE2AtfXRGR2AFq6oyQ7WHv1A33RtypAvLjawbr9q/GNT0zJqkm0yq24WOBh/ukJWhmfx4ZiI7JmyKt7xKaPCY=
X-Received: by 2002:ac8:4905:0:b0:497:2f60:4ca4 with SMTP id
 d75a77b69052e-4972f6f9829mr12105591cf.15.1747796696991; Tue, 20 May 2025
 20:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
 <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com> <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com>
In-Reply-To: <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 20 May 2025 23:04:40 -0400
X-Gm-Features: AX0GCFv2amb0qbHw7fWfmkD_so3TIuwTT6uYSxA5ymIV_tkKgrXKeabzamVHjqg
Message-ID: <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com>
Subject: Re: [EXT] Re: tcp: socket stuck with zero receive window after SACK
To: Simon Campion <simon.campion@deepl.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cc +=3D Jon Maloy <jmaloy@redhat.com>

On Mon, May 19, 2025 at 11:03=E2=80=AFAM Simon Campion <simon.campion@deepl=
.com> wrote:
>
> Gladly! I attached the output of nstat -az. I ran it twice, right
> before a 602 byte retransmit was received and dropped, and right
> after, in case looking at the diff is helpful.

Thanks, Simon, for the data!

Skimming the data and the code for your kernel (6.6.83), I have a theory:

In your nstat data, we see TcpExtTCPZeroWindowDrop is incremented by 1
when the 602 byte retransmit was received and dropped:

> < TcpExtTCPZeroWindowDrop         485489             0.0
> ---
> > TcpExtTCPZeroWindowDrop         485490             0.0

That SNMP stat (corresponding to the SKB_DROP_REASON_TCP_ZEROWINDOW
drop reason Simon mentioned earlier) is incremented by
tcp_data_queue() when an in-order packet arrives and
tcp_receive_window(tp) =3D=3D 0, and the packet is dropped.

But, critically, tcp_data_queue() in that code path does not call
tcp_try_rmem_schedule() to try to free up memory.

Why is tcp_receive_window(tp) =3D=3D 0 in this case? A conjecture:

(a) I bet  the machine was probably under memory pressure earlier,
triggering ICSK_ACK_NOMEM

(b) We can see your kernel 6.6.83 has a backport of the recent bug fix
patch that sets tp->rcv_wnd =3D 0 upon ICSK_ACK_NOMEM events:

commit b01e7ceb35dcb7ffad413da657b78c3340a09039
Author: Jon Maloy <jmaloy@redhat.com>
Date:   Mon Jan 27 18:13:04 2025 -0500

    tcp: correct handling of extreme memory squeeze

    [ Upstream commit 8c670bdfa58e48abad1d5b6ca1ee843ca91f7303 ]

...

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index cfddc94508f0b..3771ed22c2f56 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -263,11 +263,14 @@ static u16 tcp_select_window(struct sock *sk)
        u32 cur_win, new_win;

        /* Make the window 0 if we failed to queue the data because we
-        * are out of memory. The window is temporary, so we don't store
-        * it on the socket.
+        * are out of memory.
         */
-       if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
+       if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
+               tp->pred_flags =3D 0;
+               tp->rcv_wnd =3D 0;
+               tp->rcv_wup =3D tp->rcv_nxt;
                return 0;
+       }

---

Putting this all together, a conjecture about what happened:

+ the machine was under memory pressure, so  triggered ICSK_ACK_NOMEM

+ this caused the new  "tcp: correct handling of extreme memory
squeeze" patch to set tp->rcv_wnd =3D 0

+ this caused tcp_data_queue() to see the in-order packet arrive and
tcp_receive_window(tp) =3D=3D 0, and the packet is dropped.with
TcpExtTCPZeroWindowDrop

+ tcp_data_queue() in that code path does not call
tcp_try_rmem_schedule() to try to free up memory

+ so even if more memory was available at this point,
tcp_try_rmem_schedule() is not called, because of the new "tcp:
correct handling of extreme memory squeeze" patch

I suppose one possible fix would be to change tcp_data_queue() in that
(tcp_receive_window(tp) =3D=3D 0) case, to make sure it calls
tcp_try_rmem_schedule() to try to free up memory.

Eric and Jon, WDYT?

It's a bit past my bedtime here in NYC so I may not be thinking straight...=
. :-)

thanks,
neal

