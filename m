Return-Path: <netdev+bounces-131746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B59298F693
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0331F1F25966
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010A51AB6D3;
	Thu,  3 Oct 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFhc6ZLt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C81AD3E1
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981683; cv=none; b=QpmnGEcWR3yX/M8Z8qcLBB7281YDmMGujiPIMiz5nJvWl3qydudV7Uh0s7LNCeibvkH/mwFJ9G+MLxLby26vgYVap6NNxIvz9s7pDiH+NvlQs6Eed+80i3zUGOgAXwzyAk6rgCnYoMywsQs6Zx2hIsTE/9L5M4LtCatSZK85q5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981683; c=relaxed/simple;
	bh=3aR1RY4pNKeIg0fmmb3iv0lnOpv1g4Tmw+gKGSUfR8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvvqBBD8TA1vxMJEQ0gFMor2IGkkmw6AO/wYf57UnjCJ93Puo3mftcxR1Isa4OM575ffsRbCWbpQi0eE0fhrozyIKr39RsLep4ZJhUsIhfH+gPMbhxk4LBcymcbdebMI/AyB1ojPtgZoMyQV4AOx52gRsIAqaEXaI9EaagGxK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFhc6ZLt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4582fa01090so44131cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727981681; x=1728586481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fctu9XLNQK5toBoUozF2TrcAPe8SD35nzamgQ4djNus=;
        b=PFhc6ZLtsWbtAjt4oQmoONQz7x/dsWGvtYh6zwTMXyWXwzVm21QW2rpWsB4Y6r7qvl
         O9HrFaSbrSuiuIP6q3BJOOHwFbHlehcMXBZbGQS1igH+KgBTWNUKRwryyXMSHqJSYJx6
         3GzzsBS4f9kkveoH2sXo5cFd9h6QvxMsXFQRe5jnMV9domeBn/CWAaIDHWE0ljkxMaKu
         Kj0c8BO2aGmIkZft4NW6b+wCG22NarI2ljE1GxVSwfA0uv/nhWAoNP/tnE4gVxygEm3S
         6hwyGKoWiGEA3yEtTWrQIpceGzY77zF1MgKFA1zcZt9cz0Wukf26t4fZfzgGyhejnryg
         78Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727981681; x=1728586481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fctu9XLNQK5toBoUozF2TrcAPe8SD35nzamgQ4djNus=;
        b=bzAUf4/AZmC6jZm54+PLQu96c5lnL9MdkvIsqge3g7qPE56Hc2jX6ED3TBdwLR7Q+k
         XNkv3dbXkyrfRVkxKIw1l+kqRcI96lCr7flXf+UHSEiTDeH/EAWuOJiBYlMK8pDRbW5j
         ZJjVfdgzsZyL0P/W4FIoUkXK86jCv5D4pJI21t2DRM1YMftQ3toIM55YodGZwzMcAmY4
         z5+eAPyFbNvQuzXolXLVXtZIU7yPfe/evAONjRoqr1h4PFk1p3TPNMtOozLdPOr2k+sO
         vE0i+ACDAHibMouGiARn09+rFVHpLQ551IhPIqwlLX2yqH1b3m1fhEtpNWhaXNgu+v5L
         4KmA==
X-Forwarded-Encrypted: i=1; AJvYcCVllomnK1V8R9VWMRivK20mSJByUOh7DTKWnwAf7urvuGMwFjLIZZyBi12Gr8fIuFxy71pgFFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7O2PBN0vhmW9W6CDm8Xe/MK6Z+NQsvTb7azu7lYi7/FvsnoTS
	rLOb428u/hsIeqiX+PVHfLGE6QT0wmXSLqy75zdwartsn4ISsJOnnENIEG5gDVGEH8qo6RAhYpd
	YsBTwoC1aiEHvHbmracbByz3j2b9M/CHH1RPx
X-Google-Smtp-Source: AGHT+IFIEQnIRLTiVqdGI0RdLxemQZ8WiciFsWhs9NeRSWL+xU+dhQfa+GUd9R3Qxf7nOzlpfuFfRt2khXhnz/ZQf4k=
X-Received: by 2002:a05:622a:4e0d:b0:45b:5cdf:9090 with SMTP id
 d75a77b69052e-45d9bbdef2fmr181221cf.17.1727981681017; Thu, 03 Oct 2024
 11:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-8-sdf@fomichev.me>
 <CAHS8izO0Z6soYWLeU0c-8EKP5monscFqpnw6gn5OkxoqwTxKbg@mail.gmail.com> <Zv7Jbf5yVO9eV8Md@mini-arch>
In-Reply-To: <Zv7Jbf5yVO9eV8Md@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 11:54:26 -0700
Message-ID: <CAHS8izOtNP2DXHWd_NcXTbD=P9s055g-EWWhknv4VkPh2NXKvg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/12] selftests: ncdevmem: Properly reset
 flow steering
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 9:42=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 10/03, Mina Almasry wrote:
> > On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > ntuple off/on might be not enough to do it on all NICs.
> > > Add a bunch of shell crap to explicitly remove the rules.
> > >
> > > Cc: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > ---
> > >  tools/testing/selftests/net/ncdevmem.c | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/s=
elftests/net/ncdevmem.c
> > > index 47458a13eff5..48cbf057fde7 100644
> > > --- a/tools/testing/selftests/net/ncdevmem.c
> > > +++ b/tools/testing/selftests/net/ncdevmem.c
> > > @@ -207,13 +207,12 @@ void validate_buffer(void *line, size_t size)
> > >
> > >  static int reset_flow_steering(void)
> > >  {
> > > -       int ret =3D 0;
> > > -
> > > -       ret =3D run_command("sudo ethtool -K %s ntuple off >&2", ifna=
me);
> > > -       if (ret)
> > > -               return ret;
> > > -
> > > -       return run_command("sudo ethtool -K %s ntuple on >&2", ifname=
);
> > > +       run_command("sudo ethtool -K %s ntuple off >&2", ifname);
> > > +       run_command("sudo ethtool -K %s ntuple on >&2", ifname);
> > > +       run_command(
> > > +               "sudo ethtool -n %s | grep 'Filter:' | awk '{print $2=
}' | xargs -n1 ethtool -N %s delete >&2",
> > > +               ifname, ifname);
> > > +       return 0;
> >
> > Any reason to remove the checking of the return codes? Silent failures
> > can waste time if the test fails and someone has to spend time finding
> > out its the flow steering reset that failed (it may not be very
> > obvious without the checking of the return code.
>
> IIRC, for me the 'ntuple off' part fails because the NIC doesn't let me
> turn it of. And the new "ethtool .. | grep 'Filter: ' | ..." also fails
> when there are no existing filters.
>
> I will add a comment to clarify..

Ah, understood. Seems this area is fraught with subtleties.

If you have time, maybe to counter these subtleties we can do a get of
ntuple filters and confirm they're 0 somehow at the end of the
function. That would offset not checking the return code.

But, I don't think it's extremely likely to run into errors here? So,
this is probably good and can easily be improved later if we run into
issues:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

