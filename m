Return-Path: <netdev+bounces-230806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC84BEFB39
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 499954E271E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 07:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D7C2BFC73;
	Mon, 20 Oct 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8NGz1ku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65C2253FC
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946094; cv=none; b=sYWZ2PwuoOvq51HeIjdj3lyyV2wMbf92i6zBREQ1vX1pkW110GoDB/EXaUUqksBucTzSvzpVdWFIZ2FHFcmtm9JPcA9FXXlAULLtapnwG+qXBh7yB6lCGrAzSuP1O7OKkOFYPAekOqlsMlvk0BQjC8/QRGgWDqvtis8vuoUOvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946094; c=relaxed/simple;
	bh=rAsG0TIlC/Cw3DIiS7mjauyfgRfnqSmnJzIcnpWRlYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtJhliyZlsoMq1aDl5Uoflt/H69xRCUQR8EjwOdZfSyfS8YKj/IwvZnYd1Fcd+2y7vIrS/OvVmJcS8lHCOznMmjAcQYH9w1V+Wr3jCFAxwfJr51e5RZJ1pH/5lhiRo6BGxJXgvPY6bznvDATbZ+8c8mmkI6B95oZ/YAj5tprvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8NGz1ku; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88e525f912fso630271185a.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760946091; x=1761550891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAsG0TIlC/Cw3DIiS7mjauyfgRfnqSmnJzIcnpWRlYA=;
        b=x8NGz1kubh1rDcqCUxCQmEmMsvGhlUx4PU+MTvRT495Y3lDJEFoZRRaDXTpUJwMO4Q
         et9fIOwGDTQS3t2Dv/M0cOvqqVoqfsgysXzdSItSdc9L7w8Sg87InvSfsNZRARli0Y7L
         S7O3MOIXz0BrLe6M++RBSqw9OWwXcfLh3pLv9kMYjRI5jS5VrV6yp4vqR0vAqmAFT5LG
         01laeoMuVCjLgtGOK6DT2mRsHkGXjCm4s+ww9y3QsB2jszFgnj819Iya+lE3u19WwuWm
         OxUl3eM4U7wdy1RVMzldkEpZ4lSgeJNUEm3imAMcDExnKLGwa6wif5JyPJ2VskZaBvFV
         55nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946091; x=1761550891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAsG0TIlC/Cw3DIiS7mjauyfgRfnqSmnJzIcnpWRlYA=;
        b=wlMduyNWKWCodRFFizbaCGvl8t35p5Pec7hTSPL3VsouZUCV5dGcfe6V1wrnY32kAv
         PPISaucp8bbh83PXqXCYl4iTUhTNj13acUO+W+Dy6kq2FTqRqu/vroBvTQ8iY4FTwTzQ
         7+kvcM1PNEQpRUzd95xyyK0QVJDcbOvS7BkXuO2VjPQloBCEXcdbOI4b7ryTVRZ5C1dB
         Q6N8wUKA5qKUAreZyQJymVfApBtBxLcBhpDVm6ed9v+cJlULp+AY78NYLNfV7xwT5UVx
         efjH0ThxhoCzbZp8OOBEQoU5MdojyIEBvHemd+VG3THyFhDqv63vqoQAKy4jSHdEIlfx
         mnrA==
X-Forwarded-Encrypted: i=1; AJvYcCXkhZHDS/LuScrKTxYGKLQmhCE4vPbwdCGSDxbrQbNDmos2I02VSahjASFVGS/dpCcpn3LW3nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAcN+YKBI9+daew4s/eVx+uOHtCM05UzWKJlXc2ULMD+G77Rkj
	m1p5501d39vLmmzfzXm3eUY8egoXDWjnBkMi47G6gmE3XlyjogKjCt09Bm2gMdDgNsTrldQsU5h
	tP1+gD06qUiv433UB1tte1X7Jz+boQAjGgjhV0E5y
X-Gm-Gg: ASbGncumh9K5r6z804gi1pafsyyw5ysfAJbP6GRkvKsbOrqZYWabXpZCRsT+M0o8OAi
	llzb9LBgeKoONQAUjwelElCZVOCcTSt6CZNB3fm6/CH9h53a7VWVbQUa5OJsZMlVBn6FnyCzSk6
	mkr9sLSnAiXoVez/Qet8PIJEUNJx1iURN+XZx+mlieCODhOhegW7unHHmOdtpQPQHJ+nCVutI7W
	d4Zf/RMkX1Zi+0cxOxsjkyOmGpUOTmtYmZU2Al8L5vXx5zeYl3jCu8vFlNY8YUuoUY+Eyc=
X-Google-Smtp-Source: AGHT+IHLXYmQjijBQ9jj7TosYo5Wf0bYoz0oqH86AbiwYT/ZoC+0per8xvTbzkdU8+PooIsKI35kVmU/QgdOkauDpvs=
X-Received: by 2002:a05:622a:1101:b0:4e6:eb5b:be85 with SMTP id
 d75a77b69052e-4e89d28b357mr139014811cf.30.1760946091199; Mon, 20 Oct 2025
 00:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com> <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
 <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com> <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
 <CAL+tcoD6+0gSMS2rOiOOFpnJ=iyYYJuNMg8+mNXBqCOYyeo5uw@mail.gmail.com>
In-Reply-To: <CAL+tcoD6+0gSMS2rOiOOFpnJ=iyYYJuNMg8+mNXBqCOYyeo5uw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Oct 2025 00:41:20 -0700
X-Gm-Features: AS18NWD06z0zQhZSs8sWfzVNRUX_ZV7YdmkPxRTYt3_AgXMr0V4PObiqCU1iFIs
Message-ID: <CANn89i+bLvG0-v9nPF4R53UvFZ7im0=nzC-=K1+QeUDNxYbtNw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:02=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>

>
> Sorry, I've been away from the keyboard for a few days. I think it's
> fair to let us (who are currently working on the xsk improvement) post
> a simple patch based on the series.
>
> Regarding what you mentioned that 1% is a noisy number, I disagree.
> The overall numbers are improved, rather than only one or small part
> of them. I've done a few tests under different servers, so I believe
> what I've seen. BTW, xdpsock is the test tool that gives a stable
> number especially when running on the physical machine.
>
> @ Alexander I think I can post that patch with more test numbers and
> your 'suggested-by' tag included if you have no objection:) Or if you
> wish you could do it on your own, please feel free to send one then :)

The series focus was on something bringing 100% improvement.
The 1% figure _was_ noise.

I think you are mistaken on what a "SIgned-off-by: Eric Dumazet
<edumazet@google.com>" means.

I am not opposed to a patch that you will support by yourself.
I am opposed to you trying to let me take responsibility for something
I have no time/desire to support.

I added the indirect call wrapper mostly at the last moment, so that
anyone wanting to test my series
like I described (UDP workload) would not have to mention the sock_wfree co=
st.

