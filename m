Return-Path: <netdev+bounces-186550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C12BA9F996
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34F11A83990
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B6E2973A0;
	Mon, 28 Apr 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEZT/bSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66F294A06
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868913; cv=none; b=gqboNePr07NesJ5u9JIFgcgaLB1MHWGBu4VMVgtMpEn/mfgJcRKE3cwNH9LDK/CyrL5aeUl/+j3vLo4FG4H7NQFN/NwSzvdGQBUs4oqVulmXEDSrKHnubNFrbBPcoa7fj8ljk4GGrUT4nMIYdVLAdBAeouzkDNEKPr1cWKNTtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868913; c=relaxed/simple;
	bh=fGPt7x9MqrSLkVqMjGu8QKUROezXbB6lZfHpJG1XKCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2AKqFR7jkqob44nB5NvEp41H3O8/I1l4B3z4ZeeGA96RhLY23JgYf/7d2zeua7hESmo5q+n8kpTtxmQgXaF3zf9b4JHSJjr7+noxcDRZPUBPXHzmc4qftd1ZRhDQ9Y2vI5qpmomKlHvAIIdEJVyYIHTo1dLs3xScZzJVgKbxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEZT/bSb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-391342fc0b5so3885591f8f.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745868910; x=1746473710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az0Zt6Dv53GMDteM9JS2CU4K7aTSPI6l1A4/TfLXRTs=;
        b=cEZT/bSb437gDZtt/Xz/DGCJEOMpEXCIqD+b1VtOpoPKv882Mv8IP84Bw6Z8JiSr1B
         tyw82uqJjPyZskuiY7g2xad0mkA13fJdAzaR6tV+mAP6OMkWIGMoRIajfauyR4Xy1EOZ
         j3hEcc2XGlxPQxnIahIVX2Z0qc4UapV5vulzdCAbY/p8WaiYW5Y2d/dH8/fCE7HIzqdJ
         FgsiIWJ3Kmcl6hfa8oLpAEBQGOGveb2TOSLLQm/o3p82g110gHaiPMgD/3eQBstw7H52
         WyiE+M4LBl3UaWOlOI8ns+gUA3IL52yrarbDr/gNTbfYGgxcMv8mG1Vxh0Aoh0PwzAYT
         sbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745868910; x=1746473710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=az0Zt6Dv53GMDteM9JS2CU4K7aTSPI6l1A4/TfLXRTs=;
        b=RaAJBOseu2Ft7WSviv8w+JYGqne6IGupta/xTeOTazR2tFlpk8+AbVIJmTDnhVru1i
         j5dtVw5Dyh4R3xYYdOKtP1DSl5DUJ0BaeAogR+M0QL2oaV6UzV2VqwvA7+DGnElqgC+b
         qyC2T69dM0SeMiAJaqxvU1Rcw6CYqlnilrBX3v1+8l4N68zRQY9GHp5P9MdZtaM+dmI2
         O8T7c8uqSZv91DaS0joKcN0RG4aRi0BiPJkKWFU91vOXI+uWQOoEQ0eM2o9HpUBjN0rB
         QWay2yysD62Of3yeGpdd4U2Odk6DssuiavlI1Yr7IR/Hcg97dRCy+oASmpuxfWywZnjh
         L/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCX40HDKjN3CpdJoelRqL/Ko9QF5L+YBPvkMFutUOZQZSVyEWv7TUuE1Ss6lkj64jUv9MUkEjhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA3HFtg8c2/cfVwFUwU/yt2rhyVeJXCD2Jn/7xUbA7Wm8JupyQ
	i+eN7tzBb45sDfin6DtiZE15MNuVYkDGK3voMt2t3sZdQwMmExVEX6Zen9T8SqBZu0NF2HUpdQV
	TP75rRIpdrJDH/qNBgLW71Y6Hri1tYBDabx6l
X-Gm-Gg: ASbGncvSt/FEghX/whv9Zgw+0LQniuUFCDLSeFie3bSh8JXYOxVPSpzlzrzhg5O/9Vj
	3iGIBeZUt8HBxeMbyAlmEWW9a41xhKT1porLPgOgRMCUdR6uy5hB8HrvnhdlPxhqTB59sLxmZzz
	dxnBPLhhbJVQi0Kcx8yrZWnRMX1R/AGCDFfA==
X-Google-Smtp-Source: AGHT+IGbHz28kSa8vHoOTd/l/acaF9F4oaD/q+3RLp606gkzTUyaTORECWIL76C56s/+ZfTYoLC4yvl4k8VGhV/lCw4=
X-Received: by 2002:adf:ed52:0:b0:39e:db6a:4744 with SMTP id
 ffacd0b85a97d-3a07aa6ff6amr5641500f8f.32.1745868909888; Mon, 28 Apr 2025
 12:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425175426.3353069-1-brianvv@google.com> <a1d7a46f-184e-4c01-8613-6cc5d35d2545@intel.com>
In-Reply-To: <a1d7a46f-184e-4c01-8613-6cc5d35d2545@intel.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 28 Apr 2025 15:34:58 -0400
X-Gm-Features: ATxdqUHn7b7wMIuppd6jBPFRmU76m3L0oBF3otS7iF7IADHM_tILaAq92Y5FTZc
Message-ID: <CAMzD94TrjqQYVEp57h41VLB2+5RRoicT774gzvv2xq6gDEVuPA@mail.gmail.com>
Subject: Re: [iwl-next PATCH] idpf: fix a race in txq wakeup
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org, David Decotigny <decot@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Josh Hay <joshua.a.hay@intel.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick review Tony!

On Fri, Apr 25, 2025 at 6:41=E2=80=AFPM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
> On 4/25/2025 10:54 AM, Brian Vazquez wrote:
>
> Should this be a bug fix going to iwl-net/net? If yes, you'll need to
> add a Fixes: as well
>

Correct, will send to iwl-net then and add the Fixes tag.

> > Add a helper function to correctly handle the lockless
> > synchronization when the sender needs to block. The paradigm is
> >
> >          if (no_resources()) {
> >                  stop_queue();
> >                  barrier();
> >                  if (!no_resources())
> >                          restart_queue();
> >          }
> >
> > netif_subqueue_maybe_stop already handles the paradigm correctly, but
> > the code split the check for resources in three parts, the first one
> > (descriptors) followed the protocol, but the other two (completions and
> > tx_buf) were only doing the first part and so race prone.
> >
> > Luckly netif_subqueue_maybe_stop macro already allows you to use a
>
> s/Luckly/Luckily
>
> > function to evaluate the start/stop conditions so the fix only requires
> > to pass the right helper function to evaluate all the conditions at onc=
e.
> >
> > The patch removes idpf_tx_maybe_stop_common since it's no longer needed
> > and instead adjusts separetely the conditions for singleq and splitq.
>
> s/separetely/separately
>
> >
> > Note that idpf_rx_buf_hw_update doesn't need to check for resources
> > since that will be covered in idpf_tx_splitq_frame.
> >
> > To reproduce:
> >
> > Reduce the threshold for pending completions to increase the chances of
> > hitting this pause by locally changing the kernel:
> >
> > drivers/net/ethernet/intel/idpf/idpf_txrx.h
> >
> > -#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> =
1)
> > +#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> =
4)
> >
> > Use pktgen to force the host to push small pkts very aggresively:
>
> s/aggresively/aggressively
>
> >
> > ./pktgen_sample02_multiqueue.sh -i eth1 -s 100 -6 -d $IP -m $MAC \
> >    -p 10000-10000 -t 16 -n 0 -v -x -c 64
> >
> > Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> > Signed-off-by: Brian Vazquez <brianvv@google.com>
> > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> > ---
> >   .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  9 ++--
> >   drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 44 +++++++-----------=
-
> >   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ----
> >   3 files changed, 21 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/driv=
ers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> > index c6b927fa9979..fb85270c69d6 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> > @@ -364,15 +364,16 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff =
*skb,
> >       struct idpf_tx_buf *first;
> >       unsigned int count;
> >       __be16 protocol;
> > -     int csum, tso;
> > +     int csum, tso, needed;
>
> This should be moved to be RCT; longest declaration to shortest.

acked

> >       count =3D idpf_tx_desc_count_required(tx_q, skb);
> >       if (unlikely(!count))
> >               return idpf_tx_drop_skb(tx_q, skb);
> >
> > -     if (idpf_tx_maybe_stop_common(tx_q,
> > -                                   count + IDPF_TX_DESCS_PER_CACHE_LIN=
E +
> > -                                   IDPF_TX_DESCS_FOR_CTX)) {
> > +     needed =3D count + IDPF_TX_DESCS_PER_CACHE_LINE + IDPF_TX_DESCS_F=
OR_CTX;
> > +     if (!netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
> > +                                    IDPF_DESC_UNUSED(tx_q),
> > +                                    needed, needed)) {
> >               idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
> >
> >               u64_stats_update_begin(&tx_q->stats_sync);
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/=
ethernet/intel/idpf/idpf_txrx.c
> > index 970fa9e5c39b..cb41b6fcf03f 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -2184,6 +2184,19 @@ void idpf_tx_splitq_build_flow_desc(union idpf_t=
x_flex_desc *desc,
> >       desc->flow.qw1.compl_tag =3D cpu_to_le16(params->compl_tag);
> >   }
> >
> > +/* Global conditions to tell whether the txq (and related resources)
> > + * has room to allow the use of "size" descriptors.
> > + */
> > +static inline int txq_has_room(struct idpf_tx_queue *tx_q, u32 size)
>
> no 'inline' in c files please. Also, it's preferred to prepend driver
> name to the function i.e. idpf_txq_has_room()

will fix in v2
>
> Thanks,
> Tony
>
> > +{
> > +     if (IDPF_DESC_UNUSED(tx_q) < size ||
> > +         IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
> > +             IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq) ||
> > +         IDPF_TX_BUF_RSV_LOW(tx_q))
> > +             return 0;
> > +     return 1;
> > +}
> > +
> >   /**
> >    * idpf_tx_maybe_stop_splitq - 1st level check for Tx splitq stop con=
ditions
> >    * @tx_q: the queue to be checked
> > @@ -2194,29 +2207,10 @@ void idpf_tx_splitq_build_flow_desc(union idpf_=
tx_flex_desc *desc,
> >   static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
> >                                    unsigned int descs_needed)
> >   {
> > -     if (idpf_tx_maybe_stop_common(tx_q, descs_needed))
> > -             goto out;
> > -
> > -     /* If there are too many outstanding completions expected on the
> > -      * completion queue, stop the TX queue to give the device some ti=
me to
> > -      * catch up
> > -      */
> > -     if (unlikely(IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
> > -                  IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq=
)))
> > -             goto splitq_stop;
> > -
> > -     /* Also check for available book keeping buffers; if we are low, =
stop
> > -      * the queue to wait for more completions
> > -      */
> > -     if (unlikely(IDPF_TX_BUF_RSV_LOW(tx_q)))
> > -             goto splitq_stop;
> > -
> > -     return 0;
> > -
> > -splitq_stop:
> > -     netif_stop_subqueue(tx_q->netdev, tx_q->idx);
> > +     if (netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
> > +                                   txq_has_room(tx_q, descs_needed), 1=
, 1))
> > +             return 0;
> >
> > -out:
> >       u64_stats_update_begin(&tx_q->stats_sync);
> >       u64_stats_inc(&tx_q->q_stats.q_busy);
> >       u64_stats_update_end(&tx_q->stats_sync);
> > @@ -2242,12 +2236,6 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue =
*tx_q, u32 val,
> >       nq =3D netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
> >       tx_q->next_to_use =3D val;
> >
> > -     if (idpf_tx_maybe_stop_common(tx_q, IDPF_TX_DESC_NEEDED)) {
> > -             u64_stats_update_begin(&tx_q->stats_sync);
> > -             u64_stats_inc(&tx_q->q_stats.q_busy);
> > -             u64_stats_update_end(&tx_q->stats_sync);
> > -     }
> > -
> >       /* Force memory writes to complete before letting h/w
> >        * know there are new descriptors to fetch.  (Only
> >        * applicable for weak-ordered memory model archs,
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/=
ethernet/intel/idpf/idpf_txrx.h
> > index c779fe71df99..36a0f828a6f8 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> > @@ -1049,12 +1049,4 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idp=
f_rx_queue *rxq,
> >                                     u16 cleaned_count);
> >   int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off)=
;
> >
> > -static inline bool idpf_tx_maybe_stop_common(struct idpf_tx_queue *tx_=
q,
> > -                                          u32 needed)
> > -{
> > -     return !netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
> > -                                       IDPF_DESC_UNUSED(tx_q),
> > -                                       needed, needed);
> > -}
> > -
> >   #endif /* !_IDPF_TXRX_H_ */
>

