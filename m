Return-Path: <netdev+bounces-250197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279A7D24F6B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00723012BD2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D7734D3AD;
	Thu, 15 Jan 2026 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AFIA3KkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5B2DCF72
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487570; cv=pass; b=ggO/9TkQ1/R2XdDc9G/EyivU00u8VDTuIX+Q+J3IrWRMQVLwBLk/beRESk5NlJ5Wn3+JQINIUDQ5jJgKSBHWMWGxDwAszjQEKtIBBiYCbpfQd6RVwPcjihzc5YP9877IaQveYbPIcMFBQsRTyxxHf8ywug7l1foh5HRm03YRgyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487570; c=relaxed/simple;
	bh=pnKBieAsBBN1nRjdO+ZKu8Q1lebF47x2O3DUXxtYCFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/Vu9SB7Y34KXMbqEJT/0qoiAS2w7f5EtZtPdaGaMj1fk+7o1w9xnB7p+cRuQtQx/6um9JWE9u7QCWW27zlgSxK1jpVdbop/nstcwvfjdgsgGzqIKeVdgc7NmCUwCIo654yFFj7gnXdNGYYm4qqVo/kVe4CwMRB6FgWh23MttXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AFIA3KkJ; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0a95200e8so6302305ad.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:32:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768487568; cv=none;
        d=google.com; s=arc-20240605;
        b=N3iEQ6G41Q8lplsYdYXNlRwYyqjGt4r9jOPKVCiTd0t7fWYhltXC0fgwj8ukZTbVCn
         vNN+kEhLqjyCb/gch/MJeak8ZeUHPfz4mfDdtcOl8FrDMCB8OC87ZlAlPrmNZMGPiL6+
         9wolNjcgJgnF6uh67DquBFwMpJiBcufL4jPvcj75v4xXs4yRAHK07WoDtEBMeiIOtulB
         mJsX28lJSgOwiiKMqOT0yRB731WCzlNiPyPJalRoipAxOcWQNDxx/vHjgu/JcTclSINu
         vFODMcdnpTNZToLX/eaGi+IapS8Vn8hJRZxOmMPl3/1su3h37ofQaTaBULOibKSBDt5M
         Z4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pnKBieAsBBN1nRjdO+ZKu8Q1lebF47x2O3DUXxtYCFE=;
        fh=l+hYmDP9K3m7s5UnqGCg8IUNM9mkrr8gYo7Ggo7zrvU=;
        b=NT96zNhH8o0fxcMfEGQLa77VHwO0iZ31Ywdh1hPtsQEU63rI6q4L2hC6KFEGeFKBZK
         k8qGQXMQCVY25cpauKM3ugq3WUD0EmgBIEru4bmyVtmrwAxcnEHnW2kDxzT39oVYIjC9
         k8cOwHejEwqRVwyBAP91r48gJAwVfixFJEy1F6z6/OSk+NrO4abVon1NmftUjGvET9xu
         xJWMZUHJRQ76LJP6TuC8RFDJlin4h44k6pS5BEGlsJxlMwPEkgWt9T8RqIklP9z5OcNz
         E48fl9qNbxOuDhQ58AvjkdmjCF/m9u4tPF4iQiWIi1ntQbxKWMDtj1hQFQ8JeMM+9I7d
         puKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768487568; x=1769092368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnKBieAsBBN1nRjdO+ZKu8Q1lebF47x2O3DUXxtYCFE=;
        b=AFIA3KkJjoSwuuMC/gScuUH4HPfFsB61fL4mlP+dZrb4EIfqsjMAUw6ssPH+h12YWe
         CbvgreRiA2RhSsY7r/dkGrBE7zNJeT5Qt4xL//WT2tjPPHvvNUfwVgrj4agj2E1GwfSD
         QAGEK1bzbrxom9UIzhm7r9WxKfkZaz/qdFCBuotNLDilj/ZIFmTxG1rLcRzxvSvbiER/
         stgUpEMQRdpIk6htFq1agLyGaPkU1SAzYFOljc0Ek0ixIqbgpIhCXYY7ObKYS4UCq/IQ
         Fdi5wjXSauL6F/l7D9qWm8Z4S5po0bWbs5WrTClr6Q0ZmQpkfrIEXefNP7eS2nrERr+W
         8ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487568; x=1769092368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnKBieAsBBN1nRjdO+ZKu8Q1lebF47x2O3DUXxtYCFE=;
        b=iVTUfOGh9oxoJpDwSKwjD66YR4scUa4XI7Q/jseKrwJM9ybbg3LLcUOT2IZbSjEZER
         dT7ebVzmInhw0fnL4JwS1LNhG14R+o75n2F/eQlTndQmtPR85cKDx/xP4fKuopx2Xrfu
         NbfBGydJecuRlUwz8NSF3qIWYMdXNv1edlGbdf87zImtmShmkt5fUkFjGqvWJc5/ZdPy
         jMg7+1I0k0HkMPiej6PLwUaTiFk9S1rWuXO6biC1Q5T6P0cfLc0zvdjM0/TXc1tu1jKp
         n7UnyZmNoCSu0Iub3wzvIxjbkj7o1GYX5k1feiJgs7YKzKSaoUVyoQvKGqhuwa7S9W4I
         YaBw==
X-Forwarded-Encrypted: i=1; AJvYcCWoM2XCYE8cG+pvsRiVzDXKhTVA12J+UNvl+4jy8dhk3L/Hf40aInh+vJVbW/d1JOVVmutx9n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydpdhjvWefxm6NnfWbTLUjUjEGg68rdinrk34CdZh7ZpsEjkEO
	T6htbfQWDS6GIkKmH1nc6YFPBMacAF5364RCyPNfVCrntO5tRtcM2d2ThXfavZbvoZYlLl45LI4
	a9xCau8qj2oVfkdbfB642QU6+DCfOaemGg/dT106A
X-Gm-Gg: AY/fxX6gK5yjTrpq4tiL22AjxTCbEH+hk+d/GkO20eqlNWqVywrSSOdlZlshEuiJGX4
	5DIKQ6/Cr6EVE95Po01bY9GpsOuDwvEPpj9JDah30fQ7WCN186FAB7Ek9C6p3jLS22jl+hkm4JG
	5VWoktG0aaw4i70suETEi23u1VBuJOyCd0zZHNSMHuUwQpxT+edBiU9AIarzw1Ts+GCxbfBk/7/
	y0TWLPjnRoXXgvBcpkiwbdzHMZzG0y8AZ6dn9OB7jCPqA4jc5vnE4QTPWeWO5SXp85NfIGTM0D+
	6Iw=
X-Received: by 2002:a17:902:d50f:b0:295:5972:4363 with SMTP id
 d9443c01a7336-2a599cd28e2mr57322295ad.0.1768487568175; Thu, 15 Jan 2026
 06:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com> <d42f0c80-e289-4e0f-8608-10580d315fd9@redhat.com>
In-Reply-To: <d42f0c80-e289-4e0f-8608-10580d315fd9@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 15 Jan 2026 09:32:37 -0500
X-Gm-Features: AZwV_QipabjBhZ4WpV9rzlhYCiOdxNRQmYEEEVl7HpRiSmMSb8kUxTzzzVTbiRo
Message-ID: <CAM0EoMkFMURPj3+gNOaqO60D4deeht2F3EZWZbmShjO+B4wJBA@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, victor@mojatatu.com, 
	dcaratti@redhat.com, lariel@nvidia.com, daniel@iogearbox.net, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	zyc199902@zohomail.cn, lrGerlinde@mailfence.com, jschung2@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 5:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/11/26 5:39 PM, Jamal Hadi Salim wrote:
> > We introduce a 2-bit global skb->ttl counter.Patch #1 describes how we =
puti
> > together those bits. Patches #2 and patch #5 use these bits.
> > I added Fixes tags to patch #1 in case it is useful for backporting.
> > Patch #3 and #4 revert William's earlier netem commits. Patch #6 introd=
uces
> > tdc test cases.
>
> Generally speaking I think that a more self-encapsulated solution should
> be preferable.
>

I dont see a way to do that with mirred. I am more than happy if
someone else solves that issue or gives me an idea how to.

> I [mis?]understand that your main concern with Cong's series is the
> possible parent qlen corruption in case of duplication and the last
> iteration of such series includes a self-test for that, is there
> anything missing there?

i dont read the list when I am busy, but I will read emails when Cced
to me. I had not seen Cong's patches before yesterday.

But to answer your question, I presented a much simpler fix and more
importantly after looking at Cong's post i notice it changes a 20 year
old approach (which returned things to the root qdisc). William had
already pointed this to him. The simple change i posted doesn't
require that.
In any case if Stephen or you or Jakub want to push that change go
ahead - we'll wait to see what the bots find.

I am more interested in the mirred one because the current approach
has both loops and false positive(example claiming a loop when there
is none).

> The new sk_buff field looks a bit controversial. Adding such field
> opens/implies using it for other/all loop detection; a 2 bits counter
> will not be enough for that, and the struct sk_buff will increase for
> typical build otherwise.

My logic is: two bits is better than zero bits. More bits the better.
I am not sure i see sharing across the stack - and if we do hit that
situation, something will drop and we can debug.
At the moment I know of these two bugs - which are trivial to fix as
shown. I don't think it's fair to ask me to fix all potential (and
hypotheical) loops; i can fix them if someone shows an example setup.

> FTR I don't think that sk_buff the size increase for minimal config is
> very relevant, as most/all of the binary layout optimization and not
> thought for such build.

It is not really. Nobody turns off options that are ifdef just to say
"i need to save 1B".

cheers,
jamal

