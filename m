Return-Path: <netdev+bounces-120154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BBC958759
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1021F228CB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D131518E039;
	Tue, 20 Aug 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRY5MUfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8818DF6D
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158258; cv=none; b=N818JgubkauZl9xx67hNbs7LVG7jFcahiEdldPYMDkJgAKPzl8zhluf5Jq05Ib9cdbVPXFC5nc4A0WzV1hISkGaNgtkqj8stOIVXLZnZuXPFHdrXTf5sbAbbSte+B3DuP9/oN0Au+xaJjIrhkHdOEg0QGkdPvAZQbitYdS1Bc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158258; c=relaxed/simple;
	bh=s8MWPtR3uO+2gRcNSfNeD+/PBxQZUdD+N+6nlWLLGfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6ax/dVblqZdC0CaT18lQstw6yCyFInbIdfoSXABXxj3ZckRRE2Vh500ayEfRbPEwYA6mQEUoZLiUjnjqXFFHOVtTwL/3KXwQWjKeA4qADdGZneDH1LN2g93CsMRav1fNRAobblE7t26iTDaBDv/069hY6Z5bRL5SYziSryVZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRY5MUfZ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39d3872e542so11052105ab.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724158256; x=1724763056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8MWPtR3uO+2gRcNSfNeD+/PBxQZUdD+N+6nlWLLGfE=;
        b=eRY5MUfZU3a3yCEyLoPXkxgCQxWNc4MIRZcD4wP8g7OewRrRjrUcqlVxk67bIoGx7C
         rgwOlTFIIyyoPF5Kord8NhR60x+tErH83IGJNhKllCFg75NtHxZZYTue4PSiYvritm0+
         jiSK/RGUzELj3k7n6vDMJbKQw+/IAYzOdOMj8eH8Cgh2t7xpIk1vajMAt/GBWVCPU2hI
         1Oty6PU3rEHUSvOAagqin20JjMOeMd2P0EFBWaTL0Fc0hT1F3pqmp9plzsKPVTxGF35K
         AkTO1d0RtFD8RnA2y/F+l1MXprTRcEtlMq/cYOVcmIFo93/nIUWE6nX/ib24uV1mrglA
         vzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158256; x=1724763056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8MWPtR3uO+2gRcNSfNeD+/PBxQZUdD+N+6nlWLLGfE=;
        b=s7KbOFFNoSdxZQAnSGfXtP5xIYHPoiWepBw2NnD5C/9FVDv2wZ+WiM4bsd6lzkcZKw
         asgd76AiHok9VclK+OyIyKTenhnlJfHhjvJwTBViCHi5N1dygaZ3sk9GWsRfaiPm8k/D
         ZVIiNT50qpbKG1/I2KlX/0+yyxrzY1ja7BVLtwJGPa6/vJvgyogY/myzG5ugJPXLolRX
         Fvk0X8e7rdcLbzTuXbSqxrSFDYspH1OEo/uEcigEvP5bxcGbsKSXgytkTyaNbqfvParo
         RFl4M3kQghhOZJ3W499MEMEEz1Oa7sGOAIaKTDm5+HpzEhdwa5HD2PI3BGwTXpqGpF/K
         PgCA==
X-Forwarded-Encrypted: i=1; AJvYcCVs3CsSBCgme/jkCSyPwxQCkbrcj0c9HNyws+XSoYelHGzepm2n0CfswN5Qd0jPl1BJvNv+eDRslQ1pKgm0Yy7HHh0KQOZ9
X-Gm-Message-State: AOJu0YxUqlulgvcurgbAzRa2ED2g8aYiMDCRYoPGsr04sbrorhQZ369K
	Ga93jew9lQzEyczT199FOFnJ6Tig3DVHrGOwaOWrpWOv9YfnoDFOQs06+ReHCf+OuC2+Wogg1VJ
	Srkix5rsMALs8pK5JP3h29DH2GDY=
X-Google-Smtp-Source: AGHT+IFVxQ43R1DJd6akbV18b6pyczSK14XaTu16dBY59vXNpdDIaQCLmgqUMOpNyGXjAchHGzKrDl3RBz2gofMBJp0=
X-Received: by 2002:a05:6e02:1e06:b0:39a:eb4d:4335 with SMTP id
 e9e14a558f8ab-39d26cdf9f2mr151062465ab.4.1724158256249; Tue, 20 Aug 2024
 05:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815113745.6668-1-kerneljasonxing@gmail.com> <2ef5d790-5068-41f5-881f-5d2f1e6315e3@redhat.com>
In-Reply-To: <2ef5d790-5068-41f5-881f-5d2f1e6315e3@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 20:50:19 +0800
Message-ID: <CAL+tcoDnaVVGVgTxwqYnYZvc8ErD62hGB=HNOU6_3Mwo7M6cSQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	dsahern@kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paolo,

On Tue, Aug 20, 2024 at 7:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/15/24 13:37, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We found that one close-wait socket was reset by the other side
> > which is beyond our expectation,
>
> I'm unsure if you should instead reconsider your expectation: what if
> the client application does:
>
> shutdown(fd, SHUT_WR)
> close(fd); // with unread data

Thanks for the review.

Perhaps, I didn't clearly describe the details here. I'm not surprised
that the close-wait socket could be reset like you said. It's normal
behaviour. I'm surprised that the close-wait socket is reset by
another flow just because of the tw-reuse feature.

Can we reuse the port and then reset the previous connection which
stays in the close-wait state, I wonder?

Thanks,
Jason

