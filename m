Return-Path: <netdev+bounces-152364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E647A9F3A9F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 21:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A621888E29
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649D1D47A2;
	Mon, 16 Dec 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cC5a8b5B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E091D4618
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380010; cv=none; b=WC/0lZm4EAwIhle8j5YkWubvjWHRZ2zCNiK09VElVAFq+kKyhrjUnxdll6Ih4SxIt+yWmTKdmGcF7l9KvmKteicW/OY7quobXoWkM9/9ctwnDWdvPRhPfVZGGDB5jcHlg3UzXSLY6Rqe+Z/0JAk7DtY0lZ3I6xJulkkZBxsWVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380010; c=relaxed/simple;
	bh=61HxeimFlMEVl2KwPvPCcTKNZsDGn+ecl4uR0p2ZsAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWFkWLwE4RbZVQB/toe0a12zTzKDbPYgvI9aoEeWSd9KXU0FokxkKvXhOHoZPx2ylbpw2B8vmi1OCkErfduNcZwqL8t1SXIRuhsxCtd3XLsF7zDvMAJMLye1Y9PLO2CDPPI+hoQ0L+QACyxA8rmaXyfPb+n4783EFLT/GuxYFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cC5a8b5B; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so3163651f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734380007; x=1734984807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61HxeimFlMEVl2KwPvPCcTKNZsDGn+ecl4uR0p2ZsAI=;
        b=cC5a8b5Bgkw8scPEtgTdHc+HV93FtXmz1T6Ke2wXXnMVdyqwnQFx3S4k4VCLC3/MOr
         mbGk1DdN5EPPaAGcWX9JNtB2dN8twbe5ZJB+ocKBSGNY+Q5hKTRsbKvpNz5VyJXpU4VH
         JfRBKLkW7chc2Pro4r91nZwlUHcdhr2Z0drbnWbPaB1AAx+B6H5UokdxUUv7ebsT/0b2
         8n2iaABNLG5RzDQ/XI4HgXyA9mmYc0advSq3iX4M5Jhg0CPqK5Ulu2PuWVObg9lTNCqe
         wR/wXPod/jghCfechR1rF+oAwzaFGlfmjxI/Y1BP/fQ+dsi036GN9JJgWvtObE70NyIo
         YVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734380007; x=1734984807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61HxeimFlMEVl2KwPvPCcTKNZsDGn+ecl4uR0p2ZsAI=;
        b=odjS24bJNATrbeOpJAMFFQTNDDJ24rwKPCFGrx+9ED2AndAmsjBSpONWi3IMUD5yn1
         QRf1W9BgdSE6Q1OUQK+kaGWUvogRhwb1NFCc2629HSZn10neHkrs70oGbFoclnCviVcW
         t8YscDRjaQ9Q/4YNbxrWBWeLz0+l4xkZnSQBfBlghuAbZxH59CvDkzi3yAx2GDL6x4NP
         IRaaGLaqRg3k4xFD88fyDvdkyEg1TuNl5VRq+g/Y+y3nWEcL07c1VXbHkzXfw3IRnwoo
         RozJ5iobbTlu2jQS0j2iMsyNLSab4dQE+5b7IxB+cT7Q/YN6xaQdjf9qKRH6N3oCtuWa
         gW8w==
X-Forwarded-Encrypted: i=1; AJvYcCX5lEtgGEFFkNcdA4N8XfZesbvFnv/0C9uzQOw/3CtPwNLUkl/gBqaMJPEzoIYn0gtpMqBeJWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Mn/tLwn4llCvpJir3LNaUWHaExH6UhIx6U+gcHnhwsFxpBYZ
	xPCBjHaispEmLGxETfHk4RJTJzh+KleJdhBOTWpUOqu7yF6ikuRlCP93kPDduAY2ZJh5pFCK4z/
	sXkv7tC089bJoHpL2sDGGo1wcRrf2be5odWmq
X-Gm-Gg: ASbGncuV3oG2ZSBHl570i0AZKPYjr1XzX5+/Ycl8sd1f6F2bxEBqewh23fW1AP/lk7a
	bdYBLV35vy93dbBkXNvZHDvMwL7ta4HN2eY7PiJ5kZMn0e9TTWFll7zwLtH4ZQ4U8eC/rCg==
X-Google-Smtp-Source: AGHT+IFmlbX9xhNR1EJspR2ERQUcqblea1plJilcBHpQ2o55rePDoziJMVFfeClQNZNy/tF+ey1XIElWbRaT+lI6g58=
X-Received: by 2002:a05:6000:4616:b0:385:dedb:a148 with SMTP id
 ffacd0b85a97d-3888e0ac4f4mr11412043f8f.46.1734380006716; Mon, 16 Dec 2024
 12:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216162735.2047544-1-brianvv@google.com> <20241216162735.2047544-3-brianvv@google.com>
 <b81501de-7dd3-4808-920e-14b2cc817038@intel.com>
In-Reply-To: <b81501de-7dd3-4808-920e-14b2cc817038@intel.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 16 Dec 2024 15:13:15 -0500
Message-ID: <CAMzD94QR-+408wf+dindhaw+NMJ1GK9W-4xuiJpY2FkhtMVLig@mail.gmail.com>
Subject: Re: [iwl-next PATCH v4 2/3] idpf: convert workqueues to unbound
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org, David Decotigny <decot@google.com>, 
	Vivek Kumar <vivekmr@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, emil.s.tantilov@intel.com, 
	Marco Leogrande <leogrande@google.com>, Manoj Vishwanathan <manojvishy@google.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:11=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Brian Vazquez <brianvv@google.com>
> Date: Mon, 16 Dec 2024 16:27:34 +0000
>
> > From: Marco Leogrande <leogrande@google.com>
> >
> > When a workqueue is created with `WQ_UNBOUND`, its work items are
> > served by special worker-pools, whose host workers are not bound to
> > any specific CPU. In the default configuration (i.e. when
> > `queue_delayed_work` and friends do not specify which CPU to run the
> > work item on), `WQ_UNBOUND` allows the work item to be executed on any
> > CPU in the same node of the CPU it was enqueued on. While this
> > solution potentially sacrifices locality, it avoids contention with
> > other processes that might dominate the CPU time of the processor the
> > work item was scheduled on.
> >
> > This is not just a theoretical problem: in a particular scenario
> > misconfigured process was hogging most of the time from CPU0, leaving
> > less than 0.5% of its CPU time to the kworker. The IDPF workqueues
> > that were using the kworker on CPU0 suffered large completion delays
> > as a result, causing performance degradation, timeouts and eventual
> > system crash.
>
> Wasn't this inspired by [0]?
>
> [0]
> https://lore.kernel.org/netdev/20241126035849.6441-11-milena.olech@intel.=
com

The root cause is exactly the same so I do see the similarity and I'm
not surprised that both were addressed with a similar patch, we hit
this problem some time ago and the first attempt to have this was in
August [0].

[0]
https://lore.kernel.org/netdev/20240813182747.1770032-4-manojvishy@google.c=
om/

>
> Thanks,
> Olek

