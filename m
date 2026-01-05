Return-Path: <netdev+bounces-247158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC4CF5244
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E117309D6FD
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7402314B87;
	Mon,  5 Jan 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAqUOQNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243DC29D26E
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635823; cv=none; b=dIFfnqcUWIfl0Ccza5ejCPICek5ZvdaTTjAc7m81P9pawNxuxyeKjB66bDZCc6kQJzf7lPugTdhLxP24Urzhtwuxsk+CEOOlve2p9px5192uAAyi/3jsYxYIgA3X/b+6homCEpSLY8XbnMj6WjaPJiWub9x4lppFh44DoUVlAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635823; c=relaxed/simple;
	bh=yyksT/KuO1YXmCrqTz1hYIm3irFrpccprBVb5wdpCJo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=f8N98E65yo76EU5S19NtMHR026o9I4UUV7fY7xCtL97zg3vNu7caDk8Iz4/1Wl/VRs7E/Iql/5rI1xrAgCbu/5enr9B81EcRgWLN3YlEDD3F3Yr8CPRtvvaQsyRZKnM3sIVEUhLmithPKb8EVGi5UvsteG9rEMt1Lb19xaDxQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAqUOQNB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-790992528f6so2440657b3.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767635821; x=1768240621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ySbnyvHafzMvE6mhxVn5kVrIuI6aNt2bA+51RSU18M=;
        b=lAqUOQNB85UsLFQr95yhN3Gri1CH+uOePm26PIOMAi1iymUNuZZZQhxeGD3Io3fKWP
         EzNjUDltOtt/UaDzfCzpamuxY6YOqvqwFUOEDhhjsZ6/UhSTwlj5Bhwt2Ov2uaiE061X
         Hp2Kkjg5FJ5PcVrs4q94voYOG0kdx+Ibov2JceNR0TQPocEJB/hMktS2ArnMw0VfKqg5
         BGECzBzHSzNUzKDQiYfLbsEoI4wl5Jlct+DHvW3+lD62mO1Eu9lrlFAS/4EkS6c2GnWe
         AMVJyr2QZoPAyw2USDvTyM5BZuYzr5U+2wICNO5mnz4GJwabqj/iWX9wu+ojrY+yJDeB
         kmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767635821; x=1768240621;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ySbnyvHafzMvE6mhxVn5kVrIuI6aNt2bA+51RSU18M=;
        b=B4JSd1kRQovP1kE9zpv45iL5foKltDgOBQwiJGgxCvPq3nadXJGii+BPXnpIwrcgEQ
         DYJhJen4pPAwir+3MeKlvxo1RELhAaJFlbCupb1a3l6YgRfjWBIpyFNJD7i3Avv8OJiw
         cl5zDE0YVKnm7c8i+SSGGC3JR4Rq4QX2jo8SrKuLZt8Zf5aNjLt1GaZ8C5LOdBdUbSrf
         jGDd2Kb138NGzmOvKAzZwxBQYAOkb/eSCMrjIVd8FHAu6Gk9W0Lvd68m7lpPthngf/q2
         dJx0uq6NOKxyLENmNOedc0aroEwRbTc+7rh5IgLo7VeQUEF62QS8qpyC9l56ojoaj6hY
         wKqg==
X-Gm-Message-State: AOJu0YzsLT5lgwmsk60KzxSqStQTEQn+IWbC5ZhYXmmweeTRJDnHwJiu
	avCGosnX/jQHXvEmq7jBr6lYUmrhFmFYLrZngaD6ww4t0NmZxkWvtkF6
X-Gm-Gg: AY/fxX7EOJaow2ML1vQjpqeeImZORpIL9zHhkdR79OZqruvVnCO75ZuP32+Qu5q10cy
	8pDirXSBcyZlb94/jgCaJnBO6tuPmUpszub4ojazPTyI11wUNbhTlaYVZan8Pcvvt+Fw0l46JRB
	nFrLLQ2sXl3XKTymkNtbKSMiUqtj5hYlmQkjn71aV1cyJkjF4+/L+0yM/baq10ZBhjKGyECGxLd
	uNMEeQ/+SfeSlwMCf8E64SOuaXtG1bfvFxWbt+GrXvZCnjzFHhQfTs/frQ0h0EX1uzRPUrmgiOq
	HMaestGnWSLrQw3bb1Kl/Nv8X4ZRau6NrZ0VkutI3OJ8/G6OZ3catBdvolIxf3s+BukNiXx21/5
	AcI76pEj1JicE6mszkruGwHWE1VR5xV20GHLhey/TMXWEkzty0+O7L3dKHf2cutljRE+focTqQk
	tHg1DkYQM4O7mJxQYI1Xd+D/36DB5Zqf1UmmFU9KvNe6DIQCsxyEW29yXb0aA=
X-Google-Smtp-Source: AGHT+IFpQNXl+ICZpt37hJ1+yOTIe8l3+TdgX3xOEDoRUDv2+DitrKwMFXPd7G94f71FxBMTNRkpKQ==
X-Received: by 2002:a05:690c:6c0f:b0:784:952f:922b with SMTP id 00721157ae682-790a8b5a735mr3435337b3.63.1767635820943;
        Mon, 05 Jan 2026 09:57:00 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790a88ca88fsm1239117b3.41.2026.01.05.09.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 09:57:00 -0800 (PST)
Date: Mon, 05 Jan 2026 12:57:00 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kuniyu@google.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.4358c58491d1@gmail.com>
In-Reply-To: <5ce5aea0-3700-4118-9657-7259f678f430@kernel.dk>
References: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
 <CANn89iL+AuhJw7-Ma4hQsgQ5X0vxOwToSr2mgVSbkSauy-TGkg@mail.gmail.com>
 <willemdebruijn.kernel.2124bbf561b5e@gmail.com>
 <5ce5aea0-3700-4118-9657-7259f678f430@kernel.dk>
Subject: Re: [PATCH net-next] net: do not write to msg_get_inq in caller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> On 1/5/26 10:42 AM, Willem de Bruijn wrote:
> > Eric Dumazet wrote:
> >> On Mon, Jan 5, 2026 at 5:33?PM Willem de Bruijn
> >> <willemdebruijn.kernel@gmail.com> wrote:
> >>>
> >>> From: Willem de Bruijn <willemb@google.com>
> >>>
> >>> msg_get_inq is an input field from caller to callee. Don't set it in
> >>> the callee, as the caller may not clear it on struct reuse.
> >>>
> >>> This is a kernel-internal variant of msghdr only, and the only user
> >>> does reinitialize the field. So this is not critical.
> >>>
> >>> But it is more robust to avoid the write, and slightly simpler code.
> >>>
> >>> Callers set msg_get_inq to request the input queue length to be
> >>> returned in msg_inq. This is equivalent to but independent from the
> >>> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
> >>> To reduce branching in the hot path the second also sets the msg_inq.
> >>> That is WAI.
> >>>
> >>> This is a small follow-on to commit 4d1442979e4a ("af_unix: don't
> >>> post cmsg for SO_INQ unless explicitly asked for"), which fixed the
> >>> inverse.
> >>>
> >>> Also collapse two branches using a bitwise or.
> >>>
> >>> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@gmail.com/
> >>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> >>> ---
> >>
> >> Patch looks sane to me, but the title is a bit confusing, I guess you meant
> >>
> >> "net: do not write to msg_get_inq in callee" ?
> > 
> > Indeed, thanks. Will fix.
> > 
> >>
> >> Also, unix_stream_read_generic() is currently potentially adding a NULL deref
> >> if u->recvmsg_inq is non zero, but msg is NULL ?
> >>
> >> If this is the case  we need a Fixes: tag.
> > 
> > Oh good point. state->msg can be NULL as of commit 2b514574f7e8 ("net:
> > af_unix: implement splice for stream af_unix sockets"). That commit
> > mentions "we mostly have to deal with a non-existing struct msghdr
> > argument".
> 
> Worth noting that this is currently not possible, as io_uring should
> be the only one setting ->recvmsg_inq and it would not do that via
> splice. Should still be fixed of course.

recvmsg_inq is written from setsockopt SO_INQ. Do you mean
msg_get_inq?

I think this is reachable with a setsockopt + splice:

        do_cmsg = READ_ONCE(u->recvmsg_inq);
        if (do_cmsg)
                msg->msg_get_inq = 1;



