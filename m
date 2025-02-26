Return-Path: <netdev+bounces-169798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A52A45BDD
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01248176464
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C8238179;
	Wed, 26 Feb 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acRHnWda"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CC2459D4
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565899; cv=none; b=qfv/qyp13o/eqmc8pWp5AbVykRlrEc9bA/OaTokwt9dIo4KSE6u5KsE5eQT39AWasqV5HxgGe8EuWFEwAAMvEefYRC7jKX+blWCWKyKjGVjxBM7NB07CwR/Z5rxZGvRxI2o2ty0PwwELzStPu73GwQAkdzr24RsXPEVUEhuZpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565899; c=relaxed/simple;
	bh=eE6TEDJjEUVFfIcxM8iKB9praMK7xTPiqSf/9sV1pC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emOkN3BJVgV7/gS3bTI8toNrVtGqjO5/OOzUVRfmdZwnLEskx0aQlnOSPQO40TH2wQS0B3W8YKYNzLon6+CiIzDqLI9Q+Hn5vyrxIZj11wVR4AKzmz+mByLW58uEl+vrMOcceg9UjI2YuIhG/Y9APuEOixG82Pp03ZgfaEPrFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=acRHnWda; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso1034936666b.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740565896; x=1741170696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YuDC37Jw+Zolzu5V30KigWgIEI9SejHaSTwT5Rkex4=;
        b=acRHnWda/Z+QO80DeZpxs2wq9NcRC9nQF845v45rzVYX5WKaM7mxKypjh5wsKPz/F1
         fXluH1LfTciao71Gcez7vuoNGBbL8I00Qmp8CouPqJFKpLNlAQXPr3ze0ec0TveCcBNu
         jstDLj6/E3+J1IXRwYutyGcxj79fYh4TGEnvKxxoZn/oJ/dRVHDWOeYkviMyYwTERfN/
         AOJ04Mu6f9egCoeEkm0qoPjpb3G22hWYhNlAA8kpP9ri99UyUHeUhGJw1RzlJU8To875
         y2NuD7Lj1bQ/ZLN0/VPrbZ61b+V3XqV75w2Tv8qhFM8Qcw9pZ2Uybc53LODVuYHN1YZ0
         SNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740565896; x=1741170696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YuDC37Jw+Zolzu5V30KigWgIEI9SejHaSTwT5Rkex4=;
        b=GLDh8gD5XkbMEZ8fH4GdGtcbjsBUt6lkeHF0sCsDeSb4DU705e8+pPe5swAIUa9o5J
         FO771BQcEFH3gOS+Q8+825q8d8wn0SZnAWSMyaW6lyYP0AkjP3QQRRiP8S8lUQLjB4kV
         dVS/XywhLCGomgqh/lWZRjlTAARwofpraphQpgHUH3nCT8awggECv1a4kx1ReNqjUbpu
         ge3nccJMbBmrBoojb7iBuXg0I6KnuXJ/fXfMkXJKSYLZvfaDZt9o6eu2iq/7k/8sv4SH
         J9AACOdd1PMElTEEz/ZngR0+rtOtVURXJQTeJf8RGbTyDR7g5sZIvqRI5kMkrFwTHXaT
         atBw==
X-Forwarded-Encrypted: i=1; AJvYcCVR32nnAcVambF81DtWzhQMyex0TWMfnAHD3+1ottltSOKW5DE6H0mf0hHkFC5IPPatrV68Ubg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwqNVikecu/c1hwMvGqGj4ED87F6dcPucfAve1rFYSEXZrgyC
	P2nSP4StfCYv2qcbI6pnodRmobb8Gqkpx4xX+8Ey19L5ZcvVB8N1YU7sqhxTPBj3g500HVOwl70
	Cvy2imnXB+Cq3Ev/VcYxi5/kkLtGfc00DzBKn
X-Gm-Gg: ASbGncuLIISuaclLAtGp9StmW1VRgZmZzCeG1eWA01aOb81l8HdmsD3gmOZ/RH2pMCa
	UMgkZLNyDFWUjhAetDQT+NQuhVeHoD0bj27MH0CSRdtmrv+/L9voDSaVHTpAHpTPe/WZUtDg9iJ
	eoy2+HRQo=
X-Google-Smtp-Source: AGHT+IFAtFSzX90h2Iaz5b1UCMdYq9wwFG9cA0Om7iVgOoxBp3Dkrx+53LsEBr0LX2IvgijhMM8CQeoEfn63itsLTZU=
X-Received: by 2002:a17:907:6ea2:b0:ab7:b072:8481 with SMTP id
 a640c23a62f3a-abc09c1a63dmr2056837866b.45.1740565895517; Wed, 26 Feb 2025
 02:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223221708.27130-1-frederic@kernel.org>
In-Reply-To: <20250223221708.27130-1-frederic@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 11:31:24 +0100
X-Gm-Features: AQ5f1Jrx9yGutHY5PqKi7Fh2IVQ9c2aE4kyGGSpHRcRgB13e9kVMxTBIFM7KXuw
Message-ID: <CANn89iLgyPFY_u_CHozzk69dF3RQLrUVdLrf0NHj5+peXo2Yuw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Handle napi_schedule() calls from non-interrupt
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Francois Romieu <romieu@fr.zoreil.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:17=E2=80=AFPM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> napi_schedule() is expected to be called either:
>
> * From an interrupt, where raised softirqs are handled on IRQ exit
>
> * From a softirq disabled section, where raised softirqs are handled on
>   the next call to local_bh_enable().
>
> * From a softirq handler, where raised softirqs are handled on the next
>   round in do_softirq(), or further deferred to a dedicated kthread.
>
> Other bare tasks context may end up ignoring the raised NET_RX vector
> until the next random softirq handling opportunity, which may not
> happen before a while if the CPU goes idle afterwards with the tick
> stopped.
>
> Such "misuses" have been detected on several places thanks to messages
> of the kind:
>
>         "NOHZ tick-stop error: local softirq work is pending, handler #08=
!!!"
>
> For example:
>
>        __raise_softirq_irqoff
>         __napi_schedule
>         rtl8152_runtime_resume.isra.0
>         rtl8152_resume
>         usb_resume_interface.isra.0
>         usb_resume_both
>         __rpm_callback
>         rpm_callback
>         rpm_resume
>         __pm_runtime_resume
>         usb_autoresume_device
>         usb_remote_wakeup
>         hub_event
>         process_one_work
>         worker_thread
>         kthread
>         ret_from_fork
>         ret_from_fork_asm
>
> And also:
>
> * drivers/net/usb/r8152.c::rtl_work_func_t
> * drivers/net/netdevsim/netdev.c::nsim_start_xmit
>
> There is a long history of issues of this kind:
>
>         019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_s=
chdule()")
>         330068589389 ("idpf: disable local BH when scheduling napi for ma=
rker packets")
>         e3d5d70cb483 ("net: lan78xx: fix "softirq work is pending" error"=
)
>         e55c27ed9ccf ("mt76: mt7615: add missing bh-disable around rx nap=
i schedule")
>         c0182aa98570 ("mt76: mt7915: add missing bh-disable around tx nap=
i enable/schedule")
>         970be1dff26d ("mt76: disable BH around napi_schedule() calls")
>         019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_s=
chdule()")
>         30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finis=
h(): add new  function to be called from threaded interrupt")
>         e63052a5dd3c ("mlx5e: add add missing BH locking around napi_schd=
ule()")
>         83a0c6e58901 ("i40e: Invoke softirqs after napi_reschedule")
>         bd4ce941c8d5 ("mlx4: Invoke softirqs after napi_reschedule")
>         8cf699ec849f ("mlx4: do not call napi_schedule() without care")
>         ec13ee80145c ("virtio_net: invoke softirqs after __napi_schedule"=
)
>
> This shows that relying on the caller to arrange a proper context for
> the softirqs to be handled while calling napi_schedule() is very fragile
> and error prone. Also fixing them can also prove challenging if the
> caller may be called from different kinds of contexts.
>
> Therefore fix this from napi_schedule() itself with waking up ksoftirqd
> when softirqs are raised from task contexts.
>
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Francois Romieu <romieu@fr.zoreil.com>
> Closes: https://lore.kernel.org/lkml/354a2690-9bbf-4ccb-8769-fa94707a9340=
@molgen.mpg.de/
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Francois Romieu <romieu@fr.zoreil.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 80e415ccf2c8..5c1b93a3f50a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4693,7 +4693,7 @@ static inline void ____napi_schedule(struct softnet=
_data *sd,
>          * we have to raise NET_RX_SOFTIRQ.
>          */
>         if (!sd->in_net_rx_action)
> -               __raise_softirq_irqoff(NET_RX_SOFTIRQ);
> +               raise_softirq_irqoff(NET_RX_SOFTIRQ);

Your patch is fine, but would silence performance bugs.

I would probably add something to let network developers be aware of them.

diff --git a/net/core/dev.c b/net/core/dev.c
index 1b252e9459fdbde42f6fb71dc146692c7f7ec17a..ae8882a622943a81ddd8e2d141d=
f685637e334b6
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4762,8 +4762,10 @@ static inline void ____napi_schedule(struct
softnet_data *sd,
        /* If not called from net_rx_action()
         * we have to raise NET_RX_SOFTIRQ.
         */
-       if (!sd->in_net_rx_action)
-               __raise_softirq_irqoff(NET_RX_SOFTIRQ);
+       if (!sd->in_net_rx_action) {
+               raise_softirq_irqoff(NET_RX_SOFTIRQ);
+               DEBUG_NET_WARN_ON_ONCE(!in_interrupt());
+       }
 }

 #ifdef CONFIG_RPS


Looking at the list of patches, I can see idpf fix was not very good,
I will submit another patch.

