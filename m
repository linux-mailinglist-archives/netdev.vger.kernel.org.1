Return-Path: <netdev+bounces-247862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9EECFF836
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC601300D283
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936DA374194;
	Wed,  7 Jan 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iza1CDI8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AF36CDF4
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811219; cv=none; b=mQwWCtnjj/Aud/EbykByXzATThbJJRD/cd8owb6U9hDbvzMQVTuLcPNq9/hqDfNMoIB6gqhuPml3T+LNMcXT4RyUODB/4HlZ2vM9lmxHqeP63+3U+fBnX6fX0VzUZY0GPtI/DjPab9d5AiZoGTRmIIsqVXX+Gg0e4kO5Co3eMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811219; c=relaxed/simple;
	bh=u9LVgRDX+8OW4Z15E5Cr62wF/Qwb7kdu3j1pwOVzwLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M66G6+c5JJldaMVHLo4LSgSpCB11fBIUfWFWk4akhz3LHppE1m8Fh+MFR8vqksZoWoipprGVJK5LkQIC0V/HJAgfd5z0cAc0Z0sdV5WKz5CC86YQm6XuDEzsZ+mErx3p4hfjHBs6j0tYK1nbQRX45OPj0VGa4oXwwRphychSUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iza1CDI8; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fb7704cb4so24158317b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 10:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767811212; x=1768416012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD2jIr/VDx15GPtkNoiN6D8LeRDZdb8Oijt8AkLHlJA=;
        b=iza1CDI8wduqSyfoTMuLk+r/OkgQVFOOiLOcnlhOD+GQ9jI32KS6KmTpBORRMjDJ/g
         h0Qa13WufjPVoZ31PqGTbYCN35Bxfxteoygp9MJczGEbMr27mURrCp3qnxihO5y/ZeJR
         uvc8jnwT5vbpOhyKZaApQLUdJFj99+MqBcnfiTd57+pjRUq/FOZdV7BxhQJDIyQU6Hsk
         kttArLc8Q4AnzYAx7pG+HwJbMu8xk0Fz89khAthAuJ6WGIRDCcCAoh8DnUNzvBGWxmYV
         yIpOaemng17I57Ian/7AEYKVEEKYFtCBm5h0zOTxBKOOhgES7Exf+V6cKNwhQhNwfPA0
         MwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767811212; x=1768416012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CD2jIr/VDx15GPtkNoiN6D8LeRDZdb8Oijt8AkLHlJA=;
        b=P1bOzEECuGFK9fPCf4TAtfSm3tpemiqRCGzStmizRp6kcxiQhNJtAeHfZJnH02pE8W
         KOzoOx8aeDSVcOCBb8uQmKNrpgtJSufihIcRFb+6pwyqhH9sY/hvpNPFL3Zfg9mNpfMN
         kdsrMsUgNZk0qnYIVV5qrooBL5kLCndWFC9KouNq2QGLDe5O4h9OnWmIXOCxR2/sGYwC
         PEUSd2rjDpBa6VU16WTfVjFdaeY68GgzWG+tUnX4awQITZ1I8VYCUVboPFRaYTzA0hJY
         GdaVkpHFAMSOlobI42B2w8pXi/1/hel2SiTMRZKkitRFx3xNmVjuR4FzzTlMqUp4jrRX
         Wpsg==
X-Forwarded-Encrypted: i=1; AJvYcCWn1o0D2v+0IVPlpdLKOAud4acW3bTeCZ3JoqtfyOCsHdzeinqM2zjy4W1FlZLgcIiftJd349Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJUArUODawBywGpICrWtjGlnl8sM0Kvr4TEemLKHbehKizoHw
	TTCBjSs4iiQKwq9w/Ya0oNF2TxT6fTPWd82Qu0wwDaS9fxTxCec0vhJ1kNpCR9UkAn8IDO4WiHc
	PepZm6cHFrKbEmVGZjH4FEvBuhD4mtp0qhAJ+GXfj
X-Gm-Gg: AY/fxX5HtJVRymvrznxmtYL6c+tbC+y8LL2tcLwf7KLDl56CEAa7pN2r/r4DnCeo/SZ
	b+nlVkmo2fIX9JqhNp8sKzBxQrhMLONXDvSq6zA4Kh1VLvpL8vtFAwFLDq/pTLeD1DP26XG98/W
	p6vsavsJL6iOROM5oIxIl+oFTq4JRbJb4XjZtPtoJzBYOeFwztao6Sc4GIED4qzj8SkJF8+6ib+
	2ueBLe4vj4VJunkw8p9TCV6ChCRCOEFvCzjtFp0r2TNjCWUQqdHDUcjitN1BQ8okIk3ARHuwfH8
	n2JxRhqRFxl30r2w62PuNTx5aw==
X-Google-Smtp-Source: AGHT+IGjMMhZ/IhC6X/EujIlmECly+CReLquvnDp8UqwOXWG3WXyMC1+2TiKNc9tQrJkyjjvyiDqN6tO5vOoIDN+Q6U=
X-Received: by 2002:a05:690e:1301:b0:641:f5bc:68e1 with SMTP id
 956f58d0204a3-64716c90566mr2944673d50.78.1767811211551; Wed, 07 Jan 2026
 10:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107010503.2242163-1-boolli@google.com> <fba866fa-5ed7-4321-8776-e1585b4c417b@molgen.mpg.de>
In-Reply-To: <fba866fa-5ed7-4321-8776-e1585b4c417b@molgen.mpg.de>
From: Li Li <boolli@google.com>
Date: Wed, 7 Jan 2026 10:39:59 -0800
X-Gm-Features: AQt7F2qnt5SlMz_K9bh9suJQOY5pRnMK_fv_zkb81D4dAfNCQuOVAomik0utphM
Message-ID: <CAODvEq4HK0isNpT5G-O3zKAgThiLt39hz_h8eQS4-Vnf1NjJnw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 1/5] idpf: skip getting/setting ring
 params if vport is NULL during HW reset
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:30=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Li,
>
>
> Thank you for your patch.
>
> Am 07.01.26 um 02:04 schrieb Li Li via Intel-wired-lan:
> > When an idpf HW reset is triggered, it clears the vport but does
> > not clear the netdev held by vport:
> >
> >      // In idpf_vport_dealloc() called by idpf_init_hard_reset(),
> >      // idpf_init_hard_reset() sets IDPF_HR_RESET_IN_PROG, so
> >      // idpf_decfg_netdev() doesn't get called.
>
> No need to format this as code comments. At least it confused me a little=
.

Thanks for the pointer. Will drop the comment format in the future.

>
> >      if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
> >          idpf_decfg_netdev(vport);
> >      // idpf_decfg_netdev() would clear netdev but it isn't called:
> >      unregister_netdev(vport->netdev);
> >      free_netdev(vport->netdev);
> >      vport->netdev =3D NULL;
> >      // Later in idpf_init_hard_reset(), the vport is cleared:
> >      kfree(adapter->vports);
> >      adapter->vports =3D NULL;
> >
> > During an idpf HW reset, when "ethtool -g/-G" is called on the netdev,
> > the vport associated with the netdev is NULL, and so a kernel panic
> > would happen:
> >
> > [  513.185327] BUG: kernel NULL pointer dereference, address: 000000000=
0000038
> > ...
> > [  513.232756] RIP: 0010:idpf_get_ringparam+0x45/0x80
> >
> > This can be reproduced reliably by injecting a TX timeout to cause
> > an idpf HW reset, and injecting a virtchnl error to cause the HW
> > reset to fail and retry, while calling "ethtool -g/-G" on the netdev
> > at the same time.
>
> If you shared the commands, how to do that, it would make reproducing
> the issue easier.

Here's what I did to introduce TX timeouts and virtchnl timeouts at run tim=
e:

--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -15,6 +15,9 @@ struct idpf_tx_stash {
 #define idpf_tx_buf_compl_tag(buf)     (*(u32 *)&(buf)->priv)
 LIBETH_SQE_CHECK_PRIV(u32);

+static bool SIMULATE_TX_TIMEOUT;
+module_param(SIMULATE_TX_TIMEOUT, bool, 0644);
+
 /**
  * idpf_chk_linearize - Check if skb exceeds max descriptors per packet
  * @skb: send buffer
@@ -79,6 +82,8 @@ void idpf_tx_timeout(struct net_device *netdev,
unsigned int txqueue)

        adapter->tx_timeout_count++;

+       SIMULATE_TX_TIMEOUT =3D false;
+
        netdev_err(netdev, "Detected Tx timeout: Count %d, Queue %d\n",
                   adapter->tx_timeout_count, txqueue);
        if (!idpf_is_reset_in_prog(adapter)) {
@@ -2028,6 +2033,12 @@ static bool idpf_tx_clean_complq(struct
idpf_compl_queue *complq, int budget,
                }
                tx_q =3D complq->txq_grp->txqs[rel_tx_qid];

+               if (unlikely(SIMULATE_TX_TIMEOUT && (tx_q->idx =3D=3D 1))) =
{
+                       netdev_err(tx_q->netdev, "boolli test:
triggering TX timeout for TX queue id %d\n", tx_q->idx);
+                       goto fetch_next_desc;
+               }
+
+
                /* Determine completion type */
                ctype =3D le16_get_bits(tx_desc->qid_comptype_gen,
                                      IDPF_TXD_COMPLQ_COMPL_TYPE_M);

--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -6,6 +6,9 @@
 #include "idpf.h"
 #include "idpf_virtchnl.h"

+static bool SIMULATE_VC_TIMEOUT;
+module_param(SIMULATE_VC_TIMEOUT, bool, 0644);
+
 #define IDPF_VC_XN_MIN_TIMEOUT_MSEC    2000
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC        (60 * 1000)
 #define IDPF_VC_XN_IDX_M               GENMASK(7, 0)
@@ -800,6 +803,10 @@ static int idpf_send_ver_msg(struct idpf_adapter *adap=
ter)
        xn_params.timeout_ms =3D IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;

        reply_sz =3D idpf_vc_xn_exec(adapter, &xn_params);
+       if (SIMULATE_VC_TIMEOUT) {
+               dev_err(&adapter->pdev->dev, "boolli test: simulating
VC timeout by returning -ETIME in idpf_send_ver_msg");
+               reply_sz =3D -ETIME;
+       }
        if (reply_sz < 0)
                return reply_sz;
        if (reply_sz < sizeof(vvi))

Then after the kernel is booted, we can introduce the TX timeout that
lasts forever by doing the following:

echo 1 | tee /sys/module/idpf/parameters/SIMULATE_TX_TIMEOUT && echo 1
| tee /sys/module/idpf/parameters/SIMULATE_VC_TIMEOUT

All my experiments in this patch series were performed after the
kernel was put in such a state.

>
> > With this patch applied, we see the following error but no kernel
> > panics anymore:
> >
> > [  476.323630] idpf 0000:05:00.0 eth1: failed to get ring params due to=
 no vport in netdev
> >
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/n=
et/ethernet/intel/idpf/idpf_ethtool.c
> > index d5711be0b8e69..6a4b630b786c2 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> > @@ -639,6 +638,10 @@ static void idpf_get_ringparam(struct net_device *=
netdev,
> >
> >       idpf_vport_ctrl_lock(netdev);
> >       vport =3D idpf_netdev_to_vport(netdev);
> > +     if (!vport) {
> > +             netdev_err(netdev, "failed to get ring params due to no v=
port in netdev\n");
>
> If vport =3D=3D NULL is expected, why log it as an error. What should the
> user do? Wait until reset is done?
>
> > +             goto unlock;
> > +     }
> >
> >       ring->rx_max_pending =3D IDPF_MAX_RXQ_DESC;
> >       ring->tx_max_pending =3D IDPF_MAX_TXQ_DESC;
> > @@ -647,6 +651,7 @@ static void idpf_get_ringparam(struct net_device *n=
etdev,
> >
> >       kring->tcp_data_split =3D idpf_vport_get_hsplit(vport);
> >
> > +unlock:
> >       idpf_vport_ctrl_unlock(netdev);
> >   }
> >
> > @@ -673,6 +674,11 @@ static int idpf_set_ringparam(struct net_device *n=
etdev,
> >
> >       idpf_vport_ctrl_lock(netdev);
> >       vport =3D idpf_netdev_to_vport(netdev);
> > +     if (!vport) {
> > +             netdev_err(netdev, "ring params not changed due to no vpo=
rt in netdev\n");
> > +             err =3D -EFAULT;
> > +             goto unlock_mutex;
> > +     }
> >
> >       idx =3D vport->idx;
> >
>
> Is there another =E2=80=93 possible more involved =E2=80=93 solution poss=
ible to wait
> until the hardware reset finished?

Please see Emil's patch series at
https://lore.kernel.org/intel-wired-lan/20251121001218.4565-1-emil.s.tantil=
ov@intel.com/,
in which https://lore.kernel.org/intel-wired-lan/20251121001218.4565-3-emil=
.s.tantilov@intel.com/
detaches the netdev at the start of a HW reset, which I also think is
a more elegant solution than mine.

I'm going to drop this patch series in favor of Emil's solution above.

>
>
> Kind regards,
>
> Paul

