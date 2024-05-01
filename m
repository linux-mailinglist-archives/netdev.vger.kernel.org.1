Return-Path: <netdev+bounces-92862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59548B9262
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531DA1F21B40
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDFE16C44A;
	Wed,  1 May 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tioMIJgp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B31168B0E
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714606071; cv=none; b=t2yL3DVvccH6lOGTmuBQG6B6CDKmtin4hxRd+CdSPtkqxVvCjgyzmykZns1E25xgDAjfhaz6hiof2L4th1hf/YzBKVB41s4rvKHRGmEko7xE3m2Tw780QN47IJ6LvnNp0QuaSqTjzkw4WACaNqEFVaSn4CVJs6w+zpeHTWSB7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714606071; c=relaxed/simple;
	bh=mFosTE4q8AoPNXJu77O185XHKNKj58/EvH2EDQ6vzaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdblVQZcxYyhM50zgrowdOSsdfO50rgTil9lvSDablc+jUfBnWjgWgs4kF1H6YGr6ug8oj1+X6OB5inTQ7OfHPlQquvolSEOsQPVZGUIwV7etF2Z+MEowaWU9KS1L2MeYGcPDPDQD8zH2KdtdW/W+8CQnYv20EgvdFklo5ToSOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tioMIJgp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b36232fa48so521568a91.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714606069; x=1715210869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEPAhu/Kcz931sMh7NMaCvx8A28gxPfAEBjZ63j6/F8=;
        b=tioMIJgp7fwyijaMyRMDtK5jpvZ3aIOSMVaiOPzACgjtKPdM+6v8tOAOjPFNpDRODq
         wnKBZBN0OvIXqyJMFAGByqlf36qcTD6Z/Wx8ctOTW6YQW1bhmlwcnlzrlpTpOG1vozqk
         dKybVa8GFgmKrRN+urRCsDthzqR7+LMrGsgH0vg3u7Gr0JkNKbIF/jvAZm9XNBE2UKzo
         qMN4GXM/h8mGIEMPDdhurX7y+Mm18NvGJ8d/Xudt+9orkvol1o9SxdBrDS7hRRQU0C2R
         y43Qor6mH39QLEEj8iBQ7NfcZyhsXBkAoS/YpIPdUXfRhlOOBpwCJjvIjzoIGorXmIKX
         FJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714606069; x=1715210869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEPAhu/Kcz931sMh7NMaCvx8A28gxPfAEBjZ63j6/F8=;
        b=Jeuvzq9a/f5FT9xSRGAJzC8BCqobDGNnL+BGCC1ZgQJTxP5savqPpHKonquSYKFKZt
         216kEMLP99AzimeRx26hOoJv/3L8+iFa6YcXsoW67/fUidsL2/84uaIixO+9w7XCTLfe
         7fuqRor/xpqqAS8HzLHGm/1EMfpxk+U6zzIs2gIo61HEDzSABJk5+poXgCBOIOLA88Lv
         x9mgul6Cmwl9SRkkK2f8lhCjP1CQ1xnXkhh5SmvMtXNAoBtgrtWpF5/FioR1C0jKqhP9
         Tc/+lJ9uahdjz9VlR4ILA2e9KFJ3BbgxqWC/MMxmtWZov2hSSXnUTfFU/HvnPVaHhpc/
         lElg==
X-Gm-Message-State: AOJu0YyuYTaImucwgWC8B68pkuHRSpo3vBoAao9/TnV3txXQp1656pRi
	FGOy+SIgdqHMDfVbs0qlJDL/irjtJiEqpTh868ihDJB4KwL3q3LIDbz/wWA6XFSqdCA3XDfOuM4
	yGYgJisDVh0nub3P3VHbDqa8BmEea6OWpjPoa
X-Google-Smtp-Source: AGHT+IFPp8E2hl2ak27Rn7Re4JtFL/XWrSbrUxbn8SDofHoUzl+HxSGNUIo4MmzPSBX56eDvuoJMcc2kO8PmCEG1qAs=
X-Received: by 2002:a17:90a:bd95:b0:2b1:b6f:e297 with SMTP id
 z21-20020a17090abd9500b002b10b6fe297mr390106pjr.36.1714606069133; Wed, 01 May
 2024 16:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com> <20240430231420.699177-4-shailend@google.com>
 <663248a7b3624_36251a294d7@willemb.c.googlers.com.notmuch>
In-Reply-To: <663248a7b3624_36251a294d7@willemb.c.googlers.com.notmuch>
From: Shailend Chand <shailend@google.com>
Date: Wed, 1 May 2024 16:27:38 -0700
Message-ID: <CANLc=autx-MmR+Sm40QaNsJ3sit2RuD=J8=cLHZK-PrtYVRxwg@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] gve: Add adminq funcs to add/remove a
 single Rx queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, almasrymina@google.com, davem@davemloft.net, 
	edumazet@google.com, hramamurthy@google.com, jeroendb@google.com, 
	kuba@kernel.org, pabeni@redhat.com, pkaligineedi@google.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 6:50=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Shailend Chand wrote:
> > This allows for implementing future ndo hooks that act on a single
> > queue.
> >
> > Tested-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Signed-off-by: Shailend Chand <shailend@google.com>
>
> > +static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue=
_index)
> > +{
> > +     union gve_adminq_command cmd;
> > +
> > +     gve_adminq_get_create_rx_queue_cmd(priv, &cmd, queue_index);
> >       return gve_adminq_issue_cmd(priv, &cmd);
> >  }
> >
> > +int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 queue=
_index)
> > +{
> > +     union gve_adminq_command cmd;
> > +
> > +     gve_adminq_get_create_rx_queue_cmd(priv, &cmd, queue_index);
> > +     return gve_adminq_execute_cmd(priv, &cmd);
> > +}
> > +
> >  int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues)
> >  {
> >       int err;
> > @@ -727,17 +742,22 @@ int gve_adminq_destroy_tx_queues(struct gve_priv =
*priv, u32 start_id, u32 num_qu
> >       return gve_adminq_kick_and_wait(priv);
> >  }
> >
> > +static void gve_adminq_make_destroy_rx_queue_cmd(union gve_adminq_comm=
and *cmd,
> > +                                              u32 queue_index)
> > +{
> > +     memset(cmd, 0, sizeof(*cmd));
> > +     cmd->opcode =3D cpu_to_be32(GVE_ADMINQ_DESTROY_RX_QUEUE);
> > +     cmd->destroy_rx_queue =3D (struct gve_adminq_destroy_rx_queue) {
> > +             .queue_id =3D cpu_to_be32(queue_index),
> > +     };
> > +}
> > +
> >  static int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queu=
e_index)
> >  {
> >       union gve_adminq_command cmd;
> >       int err;
> >
> > -     memset(&cmd, 0, sizeof(cmd));
> > -     cmd.opcode =3D cpu_to_be32(GVE_ADMINQ_DESTROY_RX_QUEUE);
> > -     cmd.destroy_rx_queue =3D (struct gve_adminq_destroy_rx_queue) {
> > -             .queue_id =3D cpu_to_be32(queue_index),
> > -     };
> > -
> > +     gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
> >       err =3D gve_adminq_issue_cmd(priv, &cmd);
> >       if (err)
> >               return err;
> > @@ -745,6 +765,19 @@ static int gve_adminq_destroy_rx_queue(struct gve_=
priv *priv, u32 queue_index)
> >       return 0;
> >  }
> >
> > +int gve_adminq_destroy_single_rx_queue(struct gve_priv *priv, u32 queu=
e_index)
> > +{
> > +     union gve_adminq_command cmd;
> > +     int err;
> > +
> > +     gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
> > +     err =3D gve_adminq_execute_cmd(priv, &cmd);
> > +     if (err)
> > +             return err;
> > +
> > +     return 0;
> > +}
>
> This is identical to gve_adminq_destroy_rx_queue, bar for removing the
> file scope?
>
> Same for gve_adminq_create_rx_queue.

One doesn't immediately ring the doorbell, added a comment in v2
clarifying this.

