Return-Path: <netdev+bounces-86899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2998A0B95
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103A328161F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9C140396;
	Thu, 11 Apr 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUOhp1sr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA52140367
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825266; cv=none; b=lndItoufcu6z8dRtW9QlEF28P27n+Psk5S895EJiPAndjimePZ2S37Oj0P98VSOJ+gPhUsjW6tP3hWFYMMPy2ysuCH9UW6PRRO9QgMeAjzpm6aQXn4X42Z0ylkwqE5yRijkORky8Uk73GVlFK6fgf9Z2z349Y+DVBjJQN97wptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825266; c=relaxed/simple;
	bh=XogImJrUwJH3MFfJezd+om3eXHJumAKFWdjjf/eYD3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGcuac+KKN7Lk46L0ixRVGndcYNvrD6Au3bn+OQiqyvyCR2kOtG6KxR+20iC/TUUFpt791zfSE9kn1tkjF+eyu8cw7Iw3KcT5FVrZJp58qajVgQZZRUZOeUxpKFiXGac9x2xPmB0evWVLly81eBR8KqYDKCAnKeReDzoERY+PVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUOhp1sr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712825263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHtTFVdGrPf71TfXVy4j7Zndl+6LgKqo0p4DXFjFlkU=;
	b=KUOhp1sraUpUQiKL3E6zajBPY4JdVQl3oGhD8qbPwJWeqcZrYAOrb+JI5e32F/aQcT+PuK
	CMfOqMo6o/IUbQaSdgozCHVEMlW7unHKUbijxw7Q64O9xXAhC60NyB5hxEaPzxYRplht7a
	YlBojAH3/vRJfPPrzpNflKvo/4PVjMc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-geJec4wdPxmWnbLUHOjDwg-1; Thu, 11 Apr 2024 04:47:42 -0400
X-MC-Unique: geJec4wdPxmWnbLUHOjDwg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a4a1065dc4so5202997a91.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 01:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712825261; x=1713430061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHtTFVdGrPf71TfXVy4j7Zndl+6LgKqo0p4DXFjFlkU=;
        b=RPx5vkUFCJk4wU9LUBWo2ooo4oHGGPjeLuLN9bDzfpwl5quQBF478dEmSMWBZ/wFgi
         Ei/g4TwxU6DUzmh7bUv/cDrroCs1tY6vEW1MCdChSn/9zsFil/DIIHbYAf8MKl9Ku+Ah
         VHtb/4VZH0p576AOP6dkIdbhNGkCdC6C9EAcOSt+JxClTXqIOhPqZD6/5PrElHl+XUYj
         ePwOy1diiJOzHm6XmjLBZHqEjZ1SH9/KsDd8W/Bl5gacL9t4+4Ey9EIWp2IpW3qPai+6
         X7pOg6Mzkl7pvDY0aKI7SIVUv/ecFuoli3v96W8bNsVU157NhdINtHai4t8MDk2jIK4u
         nO3g==
X-Forwarded-Encrypted: i=1; AJvYcCXroBo4IlTVRQY4JAlCOCw/XFweb0JwfDGNxpdJhvBL7ymZTZTO+VJZNZkurzOF9OsZ7zgtwG87UMF8K0trcZEE6Po83vqR
X-Gm-Message-State: AOJu0YySUq7FYOT7j0gPytdVM5m5CAyf57T2drSj7VHbXewYg88z6cmE
	PQeX6nx3O+6uw6HfwwMG55n3ZHIro+t1S5Cv1fcLuL7WutiYrMFp31hgid7LWySTUICthCw7St6
	RajpI1n3iznCYu1JIzyPMdSMO2H+xASECciiPofKnrsqDizO4rtvEgLKfqTSrjQeBN9bebkyeUQ
	RAjdmd+Zn35+EhZYRJC8ap0gljRBfS
X-Received: by 2002:a17:90b:1105:b0:2a6:db3:1aa5 with SMTP id gi5-20020a17090b110500b002a60db31aa5mr2508894pjb.18.1712825261126;
        Thu, 11 Apr 2024 01:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHULqDkAnmSkiGeO1ktymjHTUooHgAi06FSR4Xw2JS39YqUY1l2CbE924DdxcuAQso++xFTHXCMKloNBQ6guFk=
X-Received: by 2002:a17:90b:1105:b0:2a6:db3:1aa5 with SMTP id
 gi5-20020a17090b110500b002a60db31aa5mr2508880pjb.18.1712825260798; Thu, 11
 Apr 2024 01:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410042245.2044516-1-lei.chen@smartx.com> <9e0884e2a101215d3376f2ef9a7a68ca86599f0f.camel@redhat.com>
In-Reply-To: <9e0884e2a101215d3376f2ef9a7a68ca86599f0f.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Apr 2024 16:47:29 +0800
Message-ID: <CACGkMEsjTD7Q26BqLuRMh7QmRZYeWZuTbQSDrb7O=uny5oknTg@mail.gmail.com>
Subject: Re: [PATCH v2] net:tun: limit printing rate when illegal packet
 received by tun dev
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lei Chen <lei.chen@smartx.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 4:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2024-04-10 at 00:22 -0400, Lei Chen wrote:
> > vhost_worker will call tun call backs to receive packets. If too many
> > illegal packets arrives, tun_do_read will keep dumping packet contents.
> > When console is enabled, it will costs much more cpu time to dump
> > packet and soft lockup will be detected.
> >
> > net_ratelimit mechanism can be used to limit the dumping rate.
> >
> > PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
> >  #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
> >  #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
> >  #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
> >  #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
> >  #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
> >     [exception RIP: io_serial_in+20]
> >     RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
> >     RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
> >     RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
> >     RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
> >     R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
> >     R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >  #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
> >  #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
> >  #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
> >  #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
> >  #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
> >  #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
> >  #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
> >  #12 [ffffa65531497b68] printk at ffffffff89318306
> >  #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
> >  #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
> >  #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
> >  #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
> >  #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
> >  #18 [ffffa65531497f10] kthread at ffffffff892d2e72
> >  #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f
> >
> > Signed-off-by: Lei Chen <lei.chen@smartx.com>
>
> This change is IMHO best suited for 'net': the possible soft sookup
> looks nasty.
>
> @Willem, @Jason, any strong opinion against the above?
>
> Otherwise, @Lei Chen, please repost with a suitable fixes tag and
> adding the target tree into the subj prefix.

I think the fix should be

ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")

The target should be net.

And it needs to address Williem's concern about patch format.

With those fixed.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks,
>
> Paolo
>


