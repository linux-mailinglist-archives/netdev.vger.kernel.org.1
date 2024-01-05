Return-Path: <netdev+bounces-61761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F805824CF5
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 03:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F431F22DBA
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD1373;
	Fri,  5 Jan 2024 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4IsjcJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5F20EB
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b7a3189d47so364299e0c.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 18:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704422035; x=1705026835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThgyuooqPa677VCnX9rKhNAUI6nqeWdduoyOKlUuAmk=;
        b=i4IsjcJF0ypX7dDDbdztWQMQmmfvSubDtc9OM7gau+pasZLVRtw5mqQ5CyhMkAUrOc
         OjojuDQsrj771NFbefKIrZpPcfd75DENHw2l87yRxO/TBXKdK4yadimt83WHtJ6+OPu2
         oWJLtcQAPUia5rIMtCS+bDAUt1xLojyFpgLj5M4C4FW6V+DOKUMAU3KOF3gtFHa5Sw71
         ff4WqUqg8bnka5Ka5YARXGLv38JkpHCX9Dbmath3OZ+J32HfRaO5A2Crl8dHt8h30a7m
         GNl95G8UDl7Gum70D375CF3ZHwaTKBMmbBgOmTj1X7RabKk0zR4yTHUUqRPFDDGoiOW0
         vOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422035; x=1705026835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThgyuooqPa677VCnX9rKhNAUI6nqeWdduoyOKlUuAmk=;
        b=ezaWc2X2xIVitypLw5gfjtmYDkJss6geQprd2hAZPCnrjhddfyw/DfNFsTzvCVhDTu
         pLypamnBycaJzdAum/twRIPXZE405uhA1Io+ib57Ly9tXirjU6h39TWxOPIBuRue7qTu
         1yFJyXtL2ECSvsuRdV0T6A3myhLNk1k+kPSXgN80UJ47tBvKnCTL/AxrU5DPRQ7aGAt0
         Dh9konxvJrK+HdZzULneCFR9tb+hG5Nv9nLPusKl5DbXGMRIK6sXbxCVHHHdVNBYF2Xi
         pRnWlnRCFFv/nuYIMg97R02WBVYqxJ7tKFHj5sjjyd0MKScqMQd8z0OtQSazBLFrGsc4
         854Q==
X-Gm-Message-State: AOJu0YydPC1FHkYmfWIXHnP2ZaBbeGF6Q+NivC4SpFOPTUayCsETNqdt
	xqVv6KZ0BefhzCowLBx2uisaJZ3gYmQjxBde1/l+DDUXOII=
X-Google-Smtp-Source: AGHT+IENyN5kYDn7kRbRgIn3cjnySGYt4yaxUJh82mxK3Vn5Cn5kTD9jLWOmVDIUCEskGkWqutJ1Jwc2peLGuZS5qvY=
X-Received: by 2002:a05:6102:4406:b0:467:aff0:57ba with SMTP id
 df6-20020a056102440600b00467aff057bamr753429vsb.7.1704422035006; Thu, 04 Jan
 2024 18:33:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226182531.34717-1-stephen@networkplumber.org>
 <CAM0EoMmH-5Afhe1DvhSJzMhsyx=y7AW+FnhR8p3YbveP3UigXA@mail.gmail.com>
 <20240104072552.1de9338f@kernel.org> <CAM0EoMkP18tbOuFyWgr=BaCODcRTJR=rU6hitcQSY_HD9gD87g@mail.gmail.com>
In-Reply-To: <CAM0EoMkP18tbOuFyWgr=BaCODcRTJR=rU6hitcQSY_HD9gD87g@mail.gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 4 Jan 2024 18:33:43 -0800
Message-ID: <CAHsH6Gsz7ANvWo0DcfE7DYZwVzkmXSGSKwKhJMtA=MtOi=QqqA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] remove support for iptables action
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 4, 2024 at 8:15=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Thu, Jan 4, 2024 at 10:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 27 Dec 2023 12:25:24 -0500 Jamal Hadi Salim wrote:
> > > On Tue, Dec 26, 2023 at 1:25=E2=80=AFPM Stephen Hemminger
> > > <stephen@networkplumber.org> wrote:
> > > >
> > > > There is an open upstream kernel patch to remove ipt action from
> > > > kernel. This is corresponding iproute2 change.
> > > >
> > > >  - Remove support fot ipt and xt in tc.
> > > >  - Remove no longer used header files.
> > > >  - Update man pages.
> > > >
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > >
> > > Does em_ipt need the m_xt*.c? Florian/Eyal can comment. Otherwise,
> > > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
> > Damn, I was waiting for Eyal to comment but you didn't CC
> > either him or Florian =F0=9F=98=86=EF=B8=8F
> >
> > Eyal, would it be possible for you to test if the latest
> > net-next and iproute2 with this patch works for you?
>
> Sorry bout that. Also Florian (who wrote the code).

I tested and it looks like the patch doesn't affect em_ipt, as expected.

I did however run into a related issue while testing - seems that
using the old "ingress" qdisc - that em_ipt iproute2 code still uses -
isn't working, i.e:

$ tc qdisc add dev ipsec1 ingress
Error: Egress block dev insert failed.

This seems to originate from recent commit 913b47d3424e
("net/sched: Introduce tc block netdev tracking infra").

When I disabled that code in my build I was able to use em_ipt
as expected.
Eyal.

