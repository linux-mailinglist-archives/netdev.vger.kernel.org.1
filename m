Return-Path: <netdev+bounces-119598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC499564B8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BAA28346A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63626157E99;
	Mon, 19 Aug 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxMQmcbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36913C8E8
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052662; cv=none; b=XtBH6vBh9bNEhIjsub0CqhNnrm4kCNn6VeiKbM460xcwUlTCqfigsbiCrEw7VPe7OInqUCJYrgGNLmy/7vebdUswKCild4llgCPWwNGOdXHK+zWUnLKMofw32VH6SF4K8MdOiZrDPvrBdV2EDz4FOw0TAiTV+KpdXbCVBDeSkfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052662; c=relaxed/simple;
	bh=/2bRiv9Y7E3oCx+lhHk0CXWF7OqVXwCLo9HbRwmWyJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/br5ap2nbh2oS7YjDP6HnUtYsimk3qiobyMHrVo9vqBRWlc1pZUy3Xg9+zHn5HmFnT1nCjmjAtWeCRIdMT9ZMETY36oEPCoZ6laa8e/sqgFvqh/+WqVq722oWkzBOaPkNmtBm4apmzSSSLyEYcpCH1LsoOU91pez7RdWpl4cd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxMQmcbT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso375356466b.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724052659; x=1724657459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htW1CggNuPvk1g706T5I0VXyuAg0Pnh45MZ/KwloqG8=;
        b=AxMQmcbTmdE2qgrJWXGgnCDyePyLiXz2/yuNhNidCM2Qa2QXKF17keD6CEoqC94QVI
         Mv/xms0k7mmCmSFH0hsEh9h/4cE5usTZS5NzjcigBwio/NHaqLnL1TKD8tyixxitN87r
         RDxmozD7DsEu0z04MTm4knDdlRLe8DnNRRlEhx+EbnnWX6KDjY12do7F0yymnx3PoPdL
         NNCymiJvl4WYzei7x+KiVQc7HFnE0z2oK5809GMP8S8xQrTMqsXW2VtUDLlhhVb7sTdG
         /XZAEvDtRAm1iHeq+w7PwBstSsWdNsRzo5n2ywR27MD4WFG0ZafmD42GzcH9zcN3TGOe
         jniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052659; x=1724657459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htW1CggNuPvk1g706T5I0VXyuAg0Pnh45MZ/KwloqG8=;
        b=iHgKPKqPT3CHvFqYrynvlkv1b7xJnQnFTfAUlFiC56I+ul0Q//tE5z+vtxlBHEEJS5
         jb84mQ92yaEY/AGvnHxFhoVSAW5LTRyK8TU49lj3cfQZiDOU78iaQ1K+0o4VqltFx2Kh
         EoE1OwEqAE3Dmm8Q7YNzJ/UC9kRDgCZxzelB0wHl17D5SkShP5JlNuPyptMwiZK7lXJ/
         075f1wVPVHx6Ym7oFSU5nD/9Jr8u23rnuWUj9RxkqjFYt0KFgqBYyhzvZnNSNDcoRmuE
         dNJTxlfLQZnWYplgLizmBnb6x4R0EGMFssFo2VqeJBurXcYRlWsZ+6x7g5doJx/Ypm78
         MiCw==
X-Forwarded-Encrypted: i=1; AJvYcCWOVPwEXjkR7KikhC5BtmpFKr2G71yuKTOG09ORNnCBxZU3MmM8Jpg1sAllA/vXfr/hzIzS3uLTxmURmEI3FwkNFu0KwSUP
X-Gm-Message-State: AOJu0Yz8C0leXql9ehnkj6yVW9RJT2MMhT2rcHJ1GlLG/gcqBAFbC76n
	z4S3HpH1L93H70EbPSElsmBDTJcjPQBP8GfvfWPnLo5OgfUv5U+DWRSLKsTN99GXM1R2zPTux6k
	AgtkBKdWSNvInZrqpptSnL0z4MKBydMkPjfdw01QvdawO1Xf/nQ==
X-Google-Smtp-Source: AGHT+IF5FSq8Q3GCwd868mh4udzXWaR3GOfLraVL3O59YpFruhEWpOY2kIWJaOp0Ma0JxGsR+VWrka8l3zgPj3W/lCY=
X-Received: by 2002:a17:907:9712:b0:a7a:c083:857b with SMTP id
 a640c23a62f3a-a8392a11c5fmr747336666b.42.1724052658155; Mon, 19 Aug 2024
 00:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
 <20240818184849.56807-1-kuniyu@amazon.com> <CAL+tcoASNGr58b7_vF9_CCungW=ZZubE2xHDxb3QCQraAwsMpw@mail.gmail.com>
 <CAL+tcoDHKkObCn=_O6WE=hwgr4nz3LY-Xhm3P-OQ-eR3Ryqs1Q@mail.gmail.com>
In-Reply-To: <CAL+tcoDHKkObCn=_O6WE=hwgr4nz3LY-Xhm3P-OQ-eR3Ryqs1Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 09:30:47 +0200
Message-ID: <CANn89iKxrMH2iGFiT7cef2Dq=Y5XOVgj8f582RpdCdfXgRwDiw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 0x7f454c46@gmail.com, davem@davemloft.net, 
	dima@arista.com, dsahern@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 2:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Aug 19, 2024 at 7:48=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Kuniyuki,
> >
> > On Mon, Aug 19, 2024 at 2:49=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Sun, 18 Aug 2024 21:50:51 +0800
> > > > On Sun, Aug 18, 2024 at 1:16=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > On Sun, Aug 18, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljasonx=
ing@gmail.com> wrote:
> > > > > >
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > Four-tuple symmetry here means the socket has the same remote/l=
ocal
> > > > > > port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:8000.
> > > > > > $ ss -nat | grep 8000
> > > > > > ESTAB      0      0          127.0.0.1:8000       127.0.0.1:800=
0
> > > >
> > > > Thanks to the failed tests appearing in patchwork, now I'm aware of
> > > > the technical term called "self-connection" in English to describe
> > > > this case. I will update accordingly the title, body messages,
> > > > function name by introducing "self-connection" words like this in t=
he
> > > > next submission.
> > > >
> > > > Following this clue, I saw many reports happening in these years, l=
ike
> > > > [1][2]. Users are often astonished about this phenomenon and lost a=
nd
> > > > have to find various ways to workaround it. Since, in my opinion, t=
he
> > > > self-connection doesn't have any advantage and usefulness,
> > >
> > > It's useful if you want to test simultaneous connect (SYN_SENT -> SYN=
_RECV)
> > > path as you see in TCP-AO tests.  See RFC 9293 and the (!ack && syn) =
case
> > > in tcp_rcv_synsent_state_process().
> > >
> > >   https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7
> >
> > Yes, I noticed this one: self-connection is one particular case among
> > simultaneously open cases. Honestly, it's really strange that client
> > and server uses a single socket.
> >
> > >
> > > So you can't remove self-connect functionality, the recent main user =
is
> > > syzkaller though.
> >
> > Ah, thanks for reminding me. It seems that I have to drop this patch
> > and there is no good way to resolve the issue in the kernel.
> >
>
> Can we introduce one sysctl knob to control it since we can tell there
> are many user reports/complaints through the internet? Default setting
> of the new knob is to allow users to connect to itself like right now,
> not interfering with many years of habits, like what the test tools
> currently use.
>
> Can I give it a shot?

No you can not.

netfilter can probably do this.

If it can not, it could be augmented I think.

