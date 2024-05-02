Return-Path: <netdev+bounces-92871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AD18B9326
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 03:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5961C20E70
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B212E5B;
	Thu,  2 May 2024 01:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7V5baW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0D29A0
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714613947; cv=none; b=bWpY2m6qhuOKWHFQTF265c9/dzWi/qEwZNADLaUI7NeVdk8vTv6tfJZpmMF4AQV0wCC9URYs9WT5oDK4y+xwVVCmsKdTuMBcj24d0H2iFGtI3cs05bLEIoHQzrMs4i+xyPL3uz7mPVUeLPccDRtZqxCQgvgsl2cc3p2vgJu5nFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714613947; c=relaxed/simple;
	bh=QOHy7iUBu+bYJl0K6y1X7ia69mD2bfV+wooIWt3AnRY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rA9mTOc0thV7cXT0zww6gjfza8f5vOZD7fO0XgPrNsLSZanDKVzuLQCweoB1GbOCTiy4+en+7kf8oMocH04pv0AGebpNYSgwJLvdl7ayi0ufoxtt62IRToAOSd8fYooHcSuZWA4q+FGqn09qPFhHlKClZJqcp1+sfbGk0BQ2+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7V5baW/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6a0a7cf89deso23701286d6.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 18:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714613944; x=1715218744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XmgoGThuarzyNd32NYUffgMgDjvQQPf1chjUYx35z4=;
        b=E7V5baW/t8uPie1bk1pQ4IzIxQMTZdS3RVpXOyCq0TP3UH5DfHsuXmWCHxH6HCAIav
         oVqPdL3OWTUFecYSgDV73UfvuI2o5u0lHzrWoO/iNH4S8K2sGZ89vQvASK/E0SkEeZR/
         oK6q1CG1Sokt9hVc6payCaKHCbAYCtXmHnoIxfpv45m/5a3xhZfOIn+/K4tuKADPq2MA
         3GqHn0GYCkiW8sPWLyTlosIeYTELj6FHR8X9VXQjJPkTK5NrzWwzhBGTc1O89Zhjvj7c
         4cF72fP3Jm7GLziG8eZHsMOUp4sO9M5rpZCpiwFm1sz54YgAOXF36/TLTYruIZWe3lsr
         D+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714613944; x=1715218744;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7XmgoGThuarzyNd32NYUffgMgDjvQQPf1chjUYx35z4=;
        b=OoLEtq1r9tLqm6jbLAIFBS0Fqn5H3NcUiGjE8YbdNlbjhLOw0Hf9aZcXlffgESvAV/
         suDMQRCYjC1CupaT8cjRelJpSMryb4AZfwvfd2VhpsyS+uAQIXbM0YJmtu+jTp62H05p
         GTQGPRjpdAtjDEpdI06GjhZEtSNtMEV2NDdDjYc5klnEy7OHiVmNMI3+yZ9awEf0X8+D
         /gMMRa7tVocwI3Jn6Hc9VwHUXfJKflAvTT5YHhM6mR3kpm2VVvb//l0Wg+4E3MoRx/ZT
         0/vxC58jrVw+X3nwGz4DwuOp0z3/VjzqPmQDgUSrAsHjGI5Gi80wjxweEfQx+cdi3XJP
         5hjg==
X-Gm-Message-State: AOJu0Yw5aAr0mlnxvgYa4TefFTtwUjQEGtjj09WsJHyjKn9dPCLL2EmD
	Wh8fxskymPUB12g63AemXY8/aOO3Rq2BHcEYl96dpEsA63bLONu9
X-Google-Smtp-Source: AGHT+IH6jwub9qjWLn/9Pj1vThxyqtw1yfAK+E3Pj5nO8xEAX2Jr8PoYX6LQGihlkq0Dmq51reGUrQ==
X-Received: by 2002:a05:6214:5098:b0:6a0:c903:7226 with SMTP id kk24-20020a056214509800b006a0c9037226mr5225415qvb.34.1714613944445;
        Wed, 01 May 2024 18:39:04 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id y7-20020a056214016700b006a0e8c1d7a5sm1571504qvs.120.2024.05.01.18.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 18:39:04 -0700 (PDT)
Date: Wed, 01 May 2024 21:39:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shailend Chand <shailend@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 almasrymina@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 hramamurthy@google.com, 
 jeroendb@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 pkaligineedi@google.com, 
 willemb@google.com
Message-ID: <6632eeb7ee528_37f3af2946e@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANLc=autx-MmR+Sm40QaNsJ3sit2RuD=J8=cLHZK-PrtYVRxwg@mail.gmail.com>
References: <20240430231420.699177-1-shailend@google.com>
 <20240430231420.699177-4-shailend@google.com>
 <663248a7b3624_36251a294d7@willemb.c.googlers.com.notmuch>
 <CANLc=autx-MmR+Sm40QaNsJ3sit2RuD=J8=cLHZK-PrtYVRxwg@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] gve: Add adminq funcs to add/remove a
 single Rx queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shailend Chand wrote:
> On Wed, May 1, 2024 at 6:50=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Shailend Chand wrote:
> > > This allows for implementing future ndo hooks that act on a single
> > > queue.
> > >
> > > Tested-by: Mina Almasry <almasrymina@google.com>
> > > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > Signed-off-by: Shailend Chand <shailend@google.com>
> >
> > > +static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 q=
ueue_index)
> > > +{
> > > +     union gve_adminq_command cmd;
> > > +
> > > +     gve_adminq_get_create_rx_queue_cmd(priv, &cmd, queue_index);
> > >       return gve_adminq_issue_cmd(priv, &cmd);
> > >  }
> > >
> > > +int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 q=
ueue_index)
> > > +{
> > > +     union gve_adminq_command cmd;
> > > +
> > > +     gve_adminq_get_create_rx_queue_cmd(priv, &cmd, queue_index);
> > > +     return gve_adminq_execute_cmd(priv, &cmd);
> > > +}
> > > +
> > >  int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_que=
ues)
> > >  {
> > >       int err;
> > > @@ -727,17 +742,22 @@ int gve_adminq_destroy_tx_queues(struct gve_p=
riv *priv, u32 start_id, u32 num_qu
> > >       return gve_adminq_kick_and_wait(priv);
> > >  }
> > >
> > > +static void gve_adminq_make_destroy_rx_queue_cmd(union gve_adminq_=
command *cmd,
> > > +                                              u32 queue_index)
> > > +{
> > > +     memset(cmd, 0, sizeof(*cmd));
> > > +     cmd->opcode =3D cpu_to_be32(GVE_ADMINQ_DESTROY_RX_QUEUE);
> > > +     cmd->destroy_rx_queue =3D (struct gve_adminq_destroy_rx_queue=
) {
> > > +             .queue_id =3D cpu_to_be32(queue_index),
> > > +     };
> > > +}
> > > +
> > >  static int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 =
queue_index)
> > >  {
> > >       union gve_adminq_command cmd;
> > >       int err;
> > >
> > > -     memset(&cmd, 0, sizeof(cmd));
> > > -     cmd.opcode =3D cpu_to_be32(GVE_ADMINQ_DESTROY_RX_QUEUE);
> > > -     cmd.destroy_rx_queue =3D (struct gve_adminq_destroy_rx_queue)=
 {
> > > -             .queue_id =3D cpu_to_be32(queue_index),
> > > -     };
> > > -
> > > +     gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
> > >       err =3D gve_adminq_issue_cmd(priv, &cmd);
> > >       if (err)
> > >               return err;
> > > @@ -745,6 +765,19 @@ static int gve_adminq_destroy_rx_queue(struct =
gve_priv *priv, u32 queue_index)
> > >       return 0;
> > >  }
> > >
> > > +int gve_adminq_destroy_single_rx_queue(struct gve_priv *priv, u32 =
queue_index)
> > > +{
> > > +     union gve_adminq_command cmd;
> > > +     int err;
> > > +
> > > +     gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
> > > +     err =3D gve_adminq_execute_cmd(priv, &cmd);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     return 0;
> > > +}
> >
> > This is identical to gve_adminq_destroy_rx_queue, bar for removing th=
e
> > file scope?
> >
> > Same for gve_adminq_create_rx_queue.
> =

> One doesn't immediately ring the doorbell, added a comment in v2
> clarifying this.

Thanks! I clearly totally missed the issue vs execute distinction.

