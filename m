Return-Path: <netdev+bounces-96241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2F58C4B1D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447F91F21845
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BD04C9B;
	Tue, 14 May 2024 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5cmSdJS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A293A29;
	Tue, 14 May 2024 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715652741; cv=none; b=dP84FCn/JTVWfI424whRk9/rx67kIqbrJ8085oTR4uABgD6M9xrtex2Mb7087p+qAUTE738Fgsumy/lf89GuwIgY3GXT7wYs+iBucK1EFomXrNJIG8JBbReD79yMT7xcoVzsHBlElO9U8XfXR0CnDZK/DgrCNozUBMIsxKxwGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715652741; c=relaxed/simple;
	bh=CP2yORU2QLUpZZbAVHnkZl9UujEHmEmiWsQipoH3pVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/FW3LkMHK6or9dO9XAXa8OuPwSjUQ9SQypuuUK3xQP/CSO1mQZa/ev2ysj27n5ztVtV/Bb1o/qTLkHTKih57g4HTrPJhhab/veuoXYYAgyFd44nVIFDBlEzDdwTbFT5IT8LWXt4hKMcyPFD2nBrde1E9XTpZZ3Sh49fuB8ypas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5cmSdJS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so67766521fa.2;
        Mon, 13 May 2024 19:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715652737; x=1716257537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiSlYgLhvRlOdf1PLlKWZmFW7JZJkIcpnGrXsUxvvfo=;
        b=H5cmSdJStCXmbtRsS0ldELjNV0aoYN7wgrRswv/2S164njK0uT/Hpzzd4l/FRD77WT
         BDbdoZmE4JJgJgYCEBQ75aiPMORMuMPjeIzKPt8y03KV6TPbiS3jwhXp8oU1rJnp8qWk
         Dzoo+jJELxDzotO1rTv3Tsi+Hig2HqBP99TwvsJfqxiL3FyMCovXG/jqSe3I6N2QHFO6
         oUCdmvjWaRJN2uxGkuNViXFAVG47MWPSawGkSmwHKNK3iF/dnA0VfJGcnkEFgGtUP57z
         hqTie3z/YeDDRagc+MUHMgvpiKQKDnddfYRE5c2KtKfrw97nJscz+KtIcq7PXE4bfj/0
         tl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715652737; x=1716257537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiSlYgLhvRlOdf1PLlKWZmFW7JZJkIcpnGrXsUxvvfo=;
        b=MeXFZROzxK0C9mSf1NzXcbt3TFAeFW5pc3DikPJtIgocYMrhqI+0U+3odtGkYEwcOc
         R4xFGpQJN0q86X4sATiPN2Xte9LNWHOvV7985/wsmL7RJcM5bNVpYl8e72AQfvIrn+M7
         NvZur1leAMFkauYVU2vMoBqROoxbW+sQiPPKvIoIR1Qx+7cS3dhlgWM6qvuuYv0vs80q
         bSTEPzcFyAxKfeW81Jsn1ASDNyt5ulLqrsP+YOOEuUH6wI0uDdeEM57fiMslAd70u1X7
         +CPR7HkCqR3ql8j8QjEDHPGdBHr4A4yxdQoKy0tbzuNMG8cL9rJtakDPOyV6r8RYYeBN
         l5cw==
X-Forwarded-Encrypted: i=1; AJvYcCUajtAVQtOW9CQHRTtSOy2A2zkjF25UREdLn4ZTEo1Ww1LpBHaMgKrOy0YkmIxUqTW0czjzAKCxcnu/g5YKE2dwrHkSF8+4EgxxagIEh2oMLizAxhVKGt/vF34KzETxP4MMI3hXnU7A
X-Gm-Message-State: AOJu0YxuVgmmQLxVBrnOpJASXIZgHDC3KSaC17gdwq5rWz3kiMWxXjwU
	NbxRUjj+KQSAFfCx+eqOkcsKWdK2sAEy/fr85YbFzrZwr8lxrCg1bDZW3FyFayHiBiSVwYgirWp
	lbzR/PP1p3mRPBNQkNsxOOTi2Zdw=
X-Google-Smtp-Source: AGHT+IFsbzCGSY2FcgIGpf2fhsRPTo9X1WvcAMawPR++Pls1dgDq1L7jvLubi16lN8vYWnse2tVWbpR/1FqY9Qs7mYs=
X-Received: by 2002:a2e:1309:0:b0:2e6:a87e:6df9 with SMTP id
 38308e7fff4ca-2e6ac4bb517mr20566731fa.20.1715652737198; Mon, 13 May 2024
 19:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org> <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org> <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
In-Reply-To: <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 May 2024 22:12:04 -0400
Message-ID: <CABBYNZ+f8L946_=6RyGvsN3bmu4EwJ2tTgxPg9YmNxckJTc_iw@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, May 13, 2024 at 10:01=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Willem,
>
> On Mon, May 13, 2024 at 9:32=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jakub Kicinski wrote:
> > > On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote:
> > > > > There is one more warning in the Intel driver:
> > > > >
> > > > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'causes_=
list'
> > > > > was not declared. Should it be static?
> > > >
> > > > We have a fix for that but I was hoping to have it in before the me=
rge
> > > > window and then have the fix merged later.
> > > >
> > > > > It'd also be great to get an ACK from someone familiar with the s=
ocket
> > > > > time stamping (Willem?) I'm not sure there's sufficient detail in=
 the
> > > > > commit message to explain the choices to:
> > > > >  - change the definition of SCHED / SEND to mean queued / complet=
ed,
> > > > >    while for Ethernet they mean queued to qdisc, queued to HW.
> > > >
> > > > hmm I thought this was hardware specific, it obviously won't work
> > > > exactly as Ethernet since it is a completely different protocol sta=
ck,
> > > > or are you suggesting we need other definitions for things like TX
> > > > completed?
> > >
> > > I don't know anything about queuing in BT, in terms of timestamping
> > > the SEND - SCHED difference is supposed to indicate the level of
> > > host delay or host congestion. If the queuing in BT happens mostly in
> > > the device HW queue then it may make sense to generate SCHED when
> > > handing over to the driver. OTOH if the devices can coalesce or delay
> > > completions the completion timeout may be less accurate than stamping
> > > before submitting to HW... I'm looking for the analysis that the choi=
ces
> > > were well thought thru.
> >
> > SCM_TSTAMP_SND is taken before an skb is passed to the device.
> > This matches request SOF_TIMESTAMPING_TX_SOFTWARE.
> >
> > A timestamp returned on transmit completion is requested as
> > SOF_TIMESTAMPING_TX_HARDWARE. We do not have a type for a software
> > timestamp taken at tx completion cleaning. If anything, I would think
> > it would be a passes as a hardware timestamp.
>
> In that case I think we probably misinterpret it, at least I though
> that TX_HARDWARE would really be a hardware generated timestamp using
> it own clock, if you are saying that TX_HARDWARE is just marking the
> TX completion of the packet at the host then we can definitely align
> with the current exception, that said we do have a command to actually
> read out the actual timestamp from the BT controller, that is usually
> more precise since some of the connection do require usec precision
> which is something that can get skew by the processing of HCI events
> themselves, well I guess we use that if the controller supports it and
> if it doesn't then we do based on the host timestamp when processing
> the HCI event indicating the completion of the transmission.
>
> > Returning SCHED when queuing to a device and SND later on receiving
> > completions seems like not following SO_TIMESTAMPING convention to me.
> > But I don't fully know the HCI model.
> >
> > As for the "experimental" BT_POLL_ERRQUEUE. This is an addition to the
> > ABI, right? So immutable. Is it fair to call that experimental?
>
> I guess you are referring to the fact that sockopt ID reserved to
> BT_POLL_ERRQUEUE cannot be reused anymore even if we drop its usage in
> the future, yes that is correct, but we can actually return
> ENOPROTOOPT as it current does:
>
>         if (!bt_poll_errqueue_enabled())
>             return -ENOPROTOOPT
>
> Anyway I would be really happy to drop it so we don't have to worry
> about it later.
>
> > It might be safer to only suppress the sk_error_report in
> > sock_queue_err_skb. Or at least in bt_sock_poll to check the type of
> > all outstanding errors and only suppress if all are timestamps.
>
> Or perhaps we could actually do that via poll/epoll directly? Not that
> it would make it much simpler since the library tends to wrap the
> usage of poll/epoll but POLLERR meaning both errors or errqueue events
> is sort of the problem we are trying to figure out how to process them
> separately.

@Jakub Kicinski I'm fine removing these from the pull request, or if
you want to do it yourself, in order not to miss the merge window,
then we can discuss it better and even put you and Willem on CC to
review the upcoming changes.

--=20
Luiz Augusto von Dentz

