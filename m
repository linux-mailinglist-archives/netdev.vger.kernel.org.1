Return-Path: <netdev+bounces-250800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD0BD392A2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2027E3002D3B
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC11313545;
	Sun, 18 Jan 2026 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbIBLOS8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E741313E1B
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768708570; cv=none; b=hfmJxNQpPlmkOkt8XJwWUn1AqwaUrrYkK59owrfrvxOINLB81p5ZT/mjN/FjMCTWeMw5AVlNsu1L7ePHzsT8smhw+9Rtjfa3Zb7zWJ+pk3G3v+IVomOzEuF321LXoyvKT5CaOFI1VFQaConZDmJjXloVS5/s9HytGw5FXwvtjiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768708570; c=relaxed/simple;
	bh=SkV209TjL+UnTRnvbeBYDuV3//sLPQqgmNMZroeIusg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCXkFhmekOZvcQrhlVYlFvlGiaMcVnk17+7/kxsPQxIWpkYVTQLQxA25k+fX0ZECRf0rWm35liZFEqq8c5oN+7OSqW1gi9KoG0iI1lH2sxY41HzkDc8/uAb8Qqx8gn4EBPYOhhYI1yzUW9ulHdslb77I1GhsxCLo81nH+m+g2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbIBLOS8; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93f4f04d9f6so2616821241.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 19:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768708568; x=1769313368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkV209TjL+UnTRnvbeBYDuV3//sLPQqgmNMZroeIusg=;
        b=MbIBLOS8G7k4yo3kWtcercz4Z6e2IbX7l0sf0k8SmsiJLNQFqU9LR5auOr07yJhm1h
         pciH32Vkon4mvX14ApWR9c2l+jGiSVBw3H8p+KF8fDYPV089Svxw4BwRw7MwCQ5SA8Y/
         20spqivKnEwcs1yKl7B3gqOfkvd5BxkM58ab59zJTt3c07leB0ef1UfmB0ApWmtM5TqU
         SxPPo/M5wZfjqPrdKnzeYGsgs83ytThP5QYMNGN2MFexGi2Z2iamoCprX0bpu9eYQffK
         Cu3xB2Npq1mv5YMPZHKLlhm5k7R6PSi+QP20QIrcfk1mSZPkY/a0hPzejOsxxvOnyJu3
         5ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768708568; x=1769313368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkV209TjL+UnTRnvbeBYDuV3//sLPQqgmNMZroeIusg=;
        b=PzQAYctZ48i4RaHW/QzuBPfiXja5nRMdeehL8AJFP6AjdWlmCImyIc12NhmT9Wfkyz
         zlF/XHs91cuzVeYxltdzAlTJru5OaSUaC96NwPID0CZjc6O/vic85P85TLg1JapbuY2R
         QC4aqjN6rkY+pfLJlaCdEIoL/m1sLfOUGvr2nU+Rg03APZrmSbAeJgeeubuKl+b5LI2q
         4CKSj8e3yJq7o+TF2kaxf0nCEkozvNnjPZQDUGhbdwwZCslpnFRBS7sjvyxOmWWW2skO
         G59LLpXZWuY7KiFXSBy5Qx6oSPNEVvidwytK+Gzu/JwrVMPfJaEfZFn8P88J5wOkMc4e
         8vEg==
X-Gm-Message-State: AOJu0YxyUgGAcirPZ/3ugsYK2pGdWTemKaTL+zryYQ2k0nzaBhFFVmM7
	GaHErSJbEQJ6OjOjF1NNziuw3djZ9kUS39w+MBdrWojVMv7VMt2TJcVrV7HcMPz/5pnPw8TD6NB
	g56a8ossZ6LF8XXRyVZyM+E8OIZgDLFrqhA==
X-Gm-Gg: AY/fxX67O219KJ2rj8Hh05L546k2F0k1W3pwpBlWvVIp1lubwuzpvPikw5tQubIfHmH
	7GhcIRL61d6PoSUH+9SGQD8uR0UIDbcz9kx/kFI8pc2lCpadXt4D+MtxDv6DcWhoDKzS+PBn/n2
	tzzxFYBa4IHw0qgmvT94PvuMUhBfCTB142zTlZWf5KPlukId0rEBTW7lfwMadpR+Usr2pbekv11
	Ho/UvxAdI7ikxoOzKDsBRyljnSbFRloszorNK//q7r8Xc+P+w57tWQAu9yJ06RfxVGE3yz9Z59D
	EjZHh5FPCx1IYlmbg/eksGpBLGxL
X-Received: by 2002:a05:6102:e07:b0:5ef:b6d0:d5f2 with SMTP id
 ada2fe7eead31-5f1a55e5992mr3039847137.21.1768708567635; Sat, 17 Jan 2026
 19:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113190634.681734-1-xiyou.wangcong@gmail.com> <20260115183351.3ffc833e@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260115183351.3ffc833e@kicinski-fedora-PF5CM1Y0>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 17 Jan 2026 19:55:56 -0800
X-Gm-Features: AZwV_Qgjtdp80CvO-HcoqN6PQwElQrOkQHI9RkKc2ZInKodojPea2e5sJyL_nvY
Message-ID: <CAM_iQpVYjN7x4zG9MG=p5D6hJo8PkFBSoThtGeEqgs=-sCd3cg@mail.gmail.com>
Subject: Re: [Patch net v7 0/9] netem: Fix skb duplication logic and prevent
 infinite loops
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 13 Jan 2026 11:06:25 -0800 Cong Wang wrote:
> > This patchset fixes the infinite loops due to duplication in netem, the
> > real root cause of this problem is enqueuing to the root qdisc, which i=
s
> > now changed to enqueuing to the same qdisc. This is more reasonable,
> > more intuitive from users' perspective, less error-prone and more elega=
nt
> > from kernel developers' perspective.
> >
> > Please see more details in patch 4/9 which contains two pages of detail=
ed
> > explanation including why it is safe and better.
> >
> > This reverts the offending commits from William which clearly broke
> > mq+netem use cases, as reported by two users.
> >
> > All the TC test cases pass with this patchset.
>
> Hi Cong, looks like this was failing in TCD
>
> # not ok 709 7c3b - Test nested DRR with NETEM duplication
> # Value doesn't match: bytes: 98 !=3D 196
> # Matching against output: {'kind': 'netem', 'handle': '3:', 'parent': '2=
:1', 'options': {'limit': 1000, 'duplicate': {'duplicate': 1, 'correlation'=
: 0}, 'seed': 11404757756329248505, 'ecn': False, 'gap': 0}, 'bytes': 196, =
'packets': 2, 'drops': 0, 'overlimits': 0, 'requeues': 0, 'backlog': 0, 'ql=
en': 0}
>
> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/474644/1-t=
dc-sh/stdout
>
> So I marked it as changes requested.

Right, it is weird that I didn't catch this in early versions.

I will send v8 shortly.

Regards,
Cong

