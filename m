Return-Path: <netdev+bounces-145541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2309CFC68
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 04:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80D12873C5
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57878C75;
	Sat, 16 Nov 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cMw3hNo0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1544C8F
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731725999; cv=none; b=KyyV5UpwbeZjXEMt2ytmqM05rMIRgyXuVi3khdHWb6ybKt2kkLTH4KBSBgBtnYQldrNqHRTB62rP4wP634avHfjVoCQeLHMwOrxq62wwYDQzEBMzowke1DUxoMFk1ahLb3hOy5kDEV0lD7TpR9g8u/D2m3kRNb6kurQmS963DFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731725999; c=relaxed/simple;
	bh=sHwM0zIMkBBNZpzY3dUX5CsLAMAFYIkxD+1fTp5+aIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQH2JjocaUIy3TG2Wn8hxCWeSwlnrZOYBFf/ds+OzAmQjNlPMOxDzkfgHUMqJ1UF8U+BXGfQGidd+B6/kjXPfnDkApC7SW2ADHaDnCi+cmSz/RqFmlZiFbpgudAZHZ79iCQkZ8qdN82YaY0gqQRqPUcJzL3dr4cunbgi65/rJFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cMw3hNo0; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by smtp.orange.fr with ESMTPSA
	id C92PtgSs8ENnBC92Pt7laO; Sat, 16 Nov 2024 03:59:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731725994;
	bh=/Bn345Cy6wEdmGCXjW98zQRzQZPL/BpCvSGGpzZaZDI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=cMw3hNo0pZNtRgZ3ykvAgV2JCXBKZr/TPox4prPWP0BE4aYhf4S558coINuRXxMMI
	 0OewdpxonaOYedXVcOnzxazT6phyDIGx5fPRhHGH20wbTGTOY/oXqdYOp3b8MZRjXK
	 fW8UFLcVfCCqFIAiSjZ6PxEotmyudWM/xDsCFkpkYvIZdPiGi83krm6FKIVKxOuJ19
	 qsemj3wb/D1zqqv99tKWBvE7n7af6fI96zGLWFwpO5qdSySVQqEm0UbZTovuVvXi8h
	 uAgYYlmpYBI6MBVQQxdhWU2mK3mnhR/TZcC61uz3ER9YSDWsHQ9Nh5kypGVW9I7sxe
	 k6me2eZ/E640Q==
X-ME-Helo: mail-ej1-f50.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Nov 2024 03:59:54 +0100
X-ME-IP: 209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e44654ae3so208570466b.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 18:59:53 -0800 (PST)
X-Gm-Message-State: AOJu0YzxOVvt3Ivod5G35t1HRBG4PzDeahlvoNL4aT2KBNV8oeSRQa8y
	Q4d+RCuvmQ0XmxU7Tjb5XXqqk2VRpTp0WHAE9xuBXl7w/F0zU8Xbdkk0xciSGE5CDJTPmLPQoG1
	Rsn83+Cp2aw2Zx2QyS+PE5I9XmN4=
X-Google-Smtp-Source: AGHT+IE9KaFlNuwBB6UAF3oNO2eh18Qw5qd9ZpUsfdxJjL+Lq8nFd99l+AuY4661DIldI2vEpOpDoVGKAAsWs49+Pk8=
X-Received: by 2002:a17:907:7ea5:b0:a9a:183a:b84e with SMTP id
 a640c23a62f3a-aa483508b20mr386768466b.40.1731725993606; Fri, 15 Nov 2024
 18:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115151030.1198371-2-mailhol.vincent@wanadoo.fr>
 <20241115085150.62d239ae@hermes.local> <31ea1d1b-dbe9-4bc6-8218-64de1884baaf@wanadoo.fr>
 <20241115123210.752b5580@hermes.local>
In-Reply-To: <20241115123210.752b5580@hermes.local>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Sat, 16 Nov 2024 11:59:42 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqK_+r2OAFtug34vczgqGWodddy282wu6BrO+reYj0Q2UA@mail.gmail.com>
Message-ID: <CAMZ6RqK_+r2OAFtug34vczgqGWodddy282wu6BrO+reYj0Q2UA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] add .editorconfig file for basic formatting
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat. 16 Nov. 2024 at 05:32, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Sat, 16 Nov 2024 02:59:01 +0900
> Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
>
> > > [*]
> > > end_of_line = lf
> > > insert_final_newline = true
> > > trim_trailing_whitespace = true
> >
> > Just let me confirm this one: do you really want the automatic
> > whitespace removal? On some editor, it will trim not only the modified
> > lines but also any whitespace in the full file.
> >
> > This can create "noise" in the patch diff. If you acknowledge this risk,
> > then I am fine to keep this parameter.
>
>
> Yes, emacs and some other editors have bad habit of leaving trailing
> whitespace. And sometimes new files get added without new line at end.

Ack. trim_trailing_whitespace = true will be added back in v2.

> Line length should be 100 like kernel.

It is a bit more nuanced.

  1. On the code, the official limit remains 80:

       https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings

     Since below commit on checkpatch.pl:

       https://git.kernel.org/torvalds/c/bdc48fa11e46

     warnings are indeed only produced for exceeding the 100th column,
     but as far as I can see, the 80 column limit is still broadly
     followed on kdoc comment blocks and on all the documentation.

  2 .Commit are wrapped at 75 columns:

       https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

    When I applied the max_line_length = 100 parameter, emacs started
    wrapping the body of my commits to the 100th column. I will add:

      [COMMIT_EDITMSG]
      max_line_length = 75

    to the v2 to prevent this.

In v2, I will apply your suggestion of a broad max_line_length = 100
configuration, with a max_line_length = 75 exception for the commit
messages. I am happy to take any of your suggestions as long as you
agree on the risk and potential side effects!

Yours sincerely,
Vincent Mailhol

