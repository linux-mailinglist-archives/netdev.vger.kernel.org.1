Return-Path: <netdev+bounces-120522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70841959B21
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1491F242FF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE7F1D131F;
	Wed, 21 Aug 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0buUKYz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258D1D1319;
	Wed, 21 Aug 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241601; cv=none; b=NmHYCy4iUrW0rJ1aGDfBNmPA+XEiOR4h7nv4Xx36tHBYQA7Y4cRqIvEfv+0JHYYqy+dagppQBfXAsntrTpawA3ewaPtN6Y7K7pMzOXMy7KycvnaKRlek8A4wlDrv6sR6Q1oafq75gAWCsLwba7gIterYYfi9XDBmDE7X/PBxOOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241601; c=relaxed/simple;
	bh=bSqA1SX4xFA1YcHeBRV2FPCPjBeOQJDzHyccFnQd4Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Db0mPwqOiboQVb7dJxbPleasmuTiEd2Oxj8VLXbSjMGpSdQUHpgEndf+7Z+H5oimZtupjCVvOOI2kp5AuBFcelUnWuFDQBxwslYeGztuS8Pc9WUEq8+vf4F5CyqC5cDFDxGk+hvaA72CugQABDtldLn9UkdNnkPqzwmWbrLq/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0buUKYz; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e1205de17aaso5456888276.2;
        Wed, 21 Aug 2024 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724241597; x=1724846397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSqA1SX4xFA1YcHeBRV2FPCPjBeOQJDzHyccFnQd4Tc=;
        b=F0buUKYzKgny4b1WdKT0vBYDfteHVRLny5tLm5w+lvFDPySj/VkRSeFbeJArwj4DYv
         nIgtvwIxUKaIRd2EMJr7o5EPWi19ZBPb3SfYXNRjaKmPEQYj7anZp76asoLszaPc4aoO
         IjrcuBGVkJ04kXJ+gqNYNBzScTtSfWMjeQnyeiyjZeErX03YaiGStdS+x7fRuEIqQVCF
         /vVIWk7c69FOrj/RBOUc/cec6EooyAHH3cZZADXXis5arGuUDPNRRqfHRmHZwDUbHkKx
         oLw0nd+6kzB99EoPGuyB8u3rd+J5rFszm2dLA7lt3M32WHvqW3VzouyT6x0PJnCQ/Ieg
         YhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724241597; x=1724846397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSqA1SX4xFA1YcHeBRV2FPCPjBeOQJDzHyccFnQd4Tc=;
        b=sWZ4c1v7QIBw2kwv78p/04V4IouvP19lyBoE0pHIPWq7Z3VIMoe21YwErF50VsLRLv
         dlCZV9DfZgxWif9vLVWVEpOThZDMBZaMpKuJBXetD8UNdrvQF0qlUBcEYPnYLNG2YBRK
         8iuI9hry8sv2NiPPRI0FPLNa5M8ScW4ogfMDFDtOOg2cGDnCM3wc6HD7C0Zfj5boP4P2
         z0f/XF3HqwSoxUJi26xvJaTNEOGFqZmOkrUYx7j+bK5SjokMgHEzCHzRbj2kwKfyVBgq
         FCYG/P+Ro0GjBAYZVKsg2aZHWk/XuaBxwhshY3hIxNiL2Za8ilbMKik/HQova53XaFKP
         IfqA==
X-Forwarded-Encrypted: i=1; AJvYcCW1kB3vz+eUZv9Zx92Q5gmIdlWvE8Phf9AZWxDmbvDprvn+3YhsawTfnyKzxa3fd2M8ArKWvoIS@vger.kernel.org, AJvYcCWOA1mD8R+Yha3ZBeMi7FgxlZ9oB+Pn67pv131LM7UiMp3Gxr6FCZbLlJhUZAhrSjcbPWyOCeAaUA777yE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xjA3GIeF+r+cQkRy6dgudg1OXTVP8EYUyMO8GI8RYgCmy2H/
	X9LGAr95ZDRTpIZNdpRcRp+t2QOqE17A70Se3Quc2iJvIWxU5OvS1aje2VktrNPaaNkqEr5eg8w
	Xwt/v0lXj/emPvQo23V15uwXa5x8=
X-Google-Smtp-Source: AGHT+IGp5jHL1VfEBBvHVw7ToGdsDoplwAOVdXGeOtbAAGg1AVvg604rOZ/bAVJMXRGtPUH9G0701rAj8CUm0S5OgMw=
X-Received: by 2002:a05:6902:1202:b0:e13:c684:ebb3 with SMTP id
 3f1490d57ef6-e166540eb27mr2466741276.1.1724241597372; Wed, 21 Aug 2024
 04:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815122245.975440-1-dongml2@chinatelecom.cn> <CAG=2xmMQZ2JgagfUUUF_Cod+3G5Yj=dfnKxEBz1A7Mpj51WR0g@mail.gmail.com>
In-Reply-To: <CAG=2xmMQZ2JgagfUUUF_Cod+3G5Yj=dfnKxEBz1A7Mpj51WR0g@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 21 Aug 2024 19:59:53 +0800
Message-ID: <CADxym3b1UwvMDpURt_b9J9c0P4eg319Eea5fkrdi65k7NRwjKw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ovs: fix ovs_drop_reasons error
To: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
Cc: kuba@kernel.org, pshelar@ovn.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, dev@openvswitch.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 10:23=E2=80=AFPM Adri=C3=A1n Moreno <amorenoz@redha=
t.com> wrote:
>
> On Thu, Aug 15, 2024 at 08:22:45PM GMT, Menglong Dong wrote:
> > I'm sure if I understand it correctly, but it seems that there is
> > something wrong with ovs_drop_reasons.
> >
> > ovs_drop_reasons[0] is "OVS_DROP_LAST_ACTION", but
> > OVS_DROP_LAST_ACTION =3D=3D __OVS_DROP_REASON + 1, which means that
> > ovs_drop_reasons[1] should be "OVS_DROP_LAST_ACTION".
> >
> > Fix this by initializing ovs_drop_reasons with index.
> >
> > Fixes: 9d802da40b7c ("net: openvswitch: add last-action drop reason")
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> The patch looks good to me. Also, tested and verified that,
> without the patch, adding flow to drop packets results in:
>
> drop at: do_execute_actions+0x197/0xb20 [openvsw (0xffffffffc0db6f97)
> origin: software
> input port ifindex: 8
> timestamp: Tue Aug 20 10:19:17 2024 859853461 nsec
> protocol: 0x800
> length: 98
> original length: 98
> drop reason: OVS_DROP_ACTION_ERROR
>
> With the patch, the same results in:
>
> drop at: do_execute_actions+0x197/0xb20 [openvsw (0xffffffffc0db6f97)
> origin: software
> input port ifindex: 8
> timestamp: Tue Aug 20 10:16:13 2024 475856608 nsec
> protocol: 0x800
> length: 98
> original length: 98
> drop reason: OVS_DROP_LAST_ACTION
>
> Tested-by: Adrian Moreno <amorenoz@redhat.com>
> Reviewed-by: Adrian Moreno <amorenoz@redhat.com>
>

Thanks! I'll resend this patch to the net branch
with your testing.

