Return-Path: <netdev+bounces-135366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A50B99D9E6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C74282B4B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A961D172B;
	Mon, 14 Oct 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1jOz6On"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC991CC158
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946175; cv=none; b=Ux8p59ZW+PWcrk99aBwsZ7R3Mn+ogpYI8yQwCzE1C9tk3fuJ+TC45TPZVmB20X8ZdmdPCVjymTtQMCdFQJGqy2OCwMfgCYHWdLr89UQGbSZnKeBOwrQzbN/LJWWRjZKgpYQID3Y2LjOjuANRR/Sw34IPjM20uf1gvg9Q+/472+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946175; c=relaxed/simple;
	bh=4elktoXETCpagETj2EpFgO5MSsOXV5w6UAt5koHLyZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6MTF+X3KnevXmlbYQU699hK83fczwQV/cYv1XxEWSrWVIHLNB7A1ysV8sl6TnBQrkLiD+/470zQqxrt3mHZs0ZR8PuWJq+AuWBwdFRJxv9U7ZihZ1OViMbZJRCceE6YZvcXQEdFrrOINTlXpWYj8zXkpeGAYZH66gECBMigzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1jOz6On; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4603d3e0547so514891cf.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728946172; x=1729550972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfUVuPmIHXxTrNMPoVC3QVY09itfrJasWDhq086IzqU=;
        b=v1jOz6Onnuxez7xVDM9wzDTHMTUDMLLGDEsj3kAbhpsYr106oyACG595FDKo8tty5W
         PljPhxWNmQCNASmYRo34SeYz5nGkbik7yefnCzMoXwxr1DHZ8sDe2Uy4a8WXgGQJZeV4
         +wIu8sHyx+KcBPcRTKkQzMIUCiricdmDh0qvqHwQNcFjhyMIHAD2L98MSBCWpQtNg+9M
         GFSDbJBDN9SxIw47FAOizUMnGT5CXl+NDhsNljYgrc2KyPimR0CRKfGiMFpB61wxu/ed
         11MQyi2j9Jzc5jfBJ3pJeDLME1IM8caGqe//yEcDHCmu2B/Ubg6q1GVCfcBCz1XMhHxw
         6cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728946172; x=1729550972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfUVuPmIHXxTrNMPoVC3QVY09itfrJasWDhq086IzqU=;
        b=TjukQX6TOxZdzZqXjRzDqPe3ogZk3P7mYInnFhAFwrlMUZs0zvlARxQNzFwQZrxPVp
         d5Fek0OMyfkgKWmDLs7BkKENRzjTlgYezp+esjSs4NNhqmTewVSzvOF2xebe62elUUet
         mnt3PI7wLHwYqt/6BQ04OKk0cCRhqZUHX1npQLDgAzs6YU314Al1dyVFtHgJ3GK4kOXh
         Iq3iaryZA1IQ5NxrX8N9dALlb1Ept8QC6CPuyxqjPURwZsloplI5XCHLb5UDA7il/Rra
         OTt2jc4IJ29IkmLL+ZfMXw8um+MSpVCNmsa0mrcp1XWoYk7IWcrGt9uhSrJwzD8EhfxJ
         OE3g==
X-Forwarded-Encrypted: i=1; AJvYcCUzZofvZ7AHK9YKtGbO8XRPEOXK7z1WBD9XMqdUt+MyEYL2fqlWrsWbtwR2i4NIxnWnm1KP0Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyElBeowdjKoFgKjaguzY2YYMBWO4UE1nFRJIu+orGmY90U0iBE
	gT8gmFVmzS/S4j0HyQsgQnotSqiA7KtzjvUNBiFnL9lUQA1iBXSRjrRA2SKgD+C3UbE0dl6OLCq
	rFTBwqDOdHSAEG9tkNYqah8EmmZiQ6U06z36S
X-Google-Smtp-Source: AGHT+IHXDzWbjGiFPahH1pmtVeE3RjcCX0XJJ8LvZXKbZ/oM9QqI2PTj4H4C5OmuPNseLplmLLkIvTVpiNH4O4uELgU=
X-Received: by 2002:a05:622a:7c0e:b0:460:4546:12f2 with SMTP id
 d75a77b69052e-46059c47130mr5774831cf.7.1728946172280; Mon, 14 Oct 2024
 15:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009171252.2328284-1-sdf@fomichev.me> <20241009171252.2328284-10-sdf@fomichev.me>
 <CAHS8izPh7kwnvQtxwqGxka_rOe0fB21R7B167j2guJXkve9_bg@mail.gmail.com> <Zw0vByssO2j6wfxI@mini-arch>
In-Reply-To: <Zw0vByssO2j6wfxI@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 15 Oct 2024 01:49:19 +0300
Message-ID: <CAHS8izOd1eGzBUo-Mj-Cdp+MLbzNVxWBZ0vHu3iySNxMocufOA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 09/12] selftests: ncdevmem: Remove hard-coded
 queue numbers
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:47=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/12, Mina Almasry wrote:
> > On Wed, Oct 9, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomiche=
v.me> wrote:
> > >
> > > Use single last queue of the device and probe it dynamically.
> > >
> >
> > Sorry I thought agreed that multi-queue binding test coverage is import=
ant.
> >
> > Can you please leave the default of num_queues to be 8 queues, or
> > rxq_num / 2? You can override num_queues to 1 in your test invocations
> > if you want. I would like by default an unaware tester that doesn't
> > set num_queues explicitly to get multi-queue test coverage.
>
> I might have misunderstood the agreement :-) I though you were ok with
> the following arrangement:
>
> 1. use num_queues / 2 in the selftest mode to make sure binding to multip=
le
>    queues works (and this gets exercised from the python kselftest)
> 2. use single queue for the actual data path test (since we are
>    installing single flow steering rule, having multiple queues here is
>    confusing)
>
> The num_queues / 2 part is here:
> https://lore.kernel.org/netdev/20241009171252.2328284-11-sdf@fomichev.me/
>
> Anything I'm missing?

Sorry, I indeed missed that this is reworked in patch 10/12. Squashing
the patches could be OK, because the changes to num_queues here are
essentially reworked in the next patch, but this is also fine.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

