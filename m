Return-Path: <netdev+bounces-232645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28158C078C9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F90B3AD38C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E698B343D6D;
	Fri, 24 Oct 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVYzUUf/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7D1D61BC
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327075; cv=none; b=hiwTuSD5sbOGFv/njYTEOJIZqv4aue7unzGu90TPkrywAd37C/dGPzuFbhx/vtcy3LfxwHrOzNG16I0efHYK80CTNj4hvyLR+lS4Dy5ls2KySu4RgGREOoUxKTT0MdZyY3kbi7s2Iwqo5JykNXEw7EnUW9N3wN1ICkGWn0B8/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327075; c=relaxed/simple;
	bh=9xij/PZRZYIryt7Tv2GJhZUBJ++I0ueOtF7xmKO1Gg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpZOYBX7Br8MWwkLN+Ou6vWBhGDh0/u6/2W4hY7JmGBDAUlMqfygMHjORvHP1L7OyJ4UJRsHd7FTXIWQxRR3ZsCTveFLl4ufHW0nzgLsYc+pp8shXN+fl+8dbho2C7yDgL76PVtaJO07D1ka39+1Wn2OoK3rACZan05RlsEOvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVYzUUf/; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63bcfcb800aso2637183d50.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761327073; x=1761931873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xij/PZRZYIryt7Tv2GJhZUBJ++I0ueOtF7xmKO1Gg0=;
        b=FVYzUUf/pmOrQbMwM+RCrdvAYlQuUxchlseHwDCsFdJQM17BPk4LRUOkQREA4r2KGj
         4h/BHyHEh+TJuDqemiVPDK36xU10CvZF7K+lKIlOgu9BlEmgkuRskcRxeaKTvX9rhVvH
         2zjgLNwIWYDhdsNrmPo4QPRVovb//tdSF3owQMzN/2hR8IOOVHX+bJm2TuTaHfyIpsbX
         UR2xb8H8kCGhBDJY66dOYt94XtH+817bfc03JYfk1pxGlsgJoieI1MORMfV4dXJIstlL
         Iatt8Y49LrmXcKYk7s53kpWcKZXI0ll4NeruBMvCNqNKX2Se/K9H+zm1h0mT1Jt+Sb3y
         4JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761327073; x=1761931873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xij/PZRZYIryt7Tv2GJhZUBJ++I0ueOtF7xmKO1Gg0=;
        b=bNz754PcYFndoz9F99UMfM/2VBIkhE0HN0BVuFJVRc+0yNqQ0YZVqvATI5NZMNUOPi
         Nu2/OXiW1+yGPOgcVcj2Bs983nAihHaQGc5lncC/Dqc8TiPoCmgG31mKYHSXN2itG1dw
         mIVSd14EmXH4ucImE66sYeQb2Ks6pmyLIA8Volq8+AhHH2MpMpqbEzmo/HNlkRKLoXK1
         lqxnYuXBnbNp+zHseB28esaEVfqjXktugFb8RnzIg4hF5eZ/9kS7ioI6ihrirqZzRuQx
         COr26iuL7jgVuqRCZTgaDjW+1trejo1PEIWXq4rThhk5En/60zoYf3jmKmmu3AGBU6xm
         JF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL0JVhsyOthDHW6Z7usChQZuwWccKTASL44kxyvtHusMLdo1pXT1PHIUePywguG5mQHuNbEEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZAlbHZstQ8+bhazMT3RXahIexwxuskYko9sYUOrx1ZMB0nKa
	OB6EC9Cem3sTVo32EGEnz2cXhnRkyxK1cjhqrZpSIWfQGplWdvCOGgpLbj8YvqlrZFtMJEk0QA0
	G6zbPD+46jEJvnXVCzvTgINo4xuBTGKFq5JCukqI/
X-Gm-Gg: ASbGncurvc+EM9d5al4jXKijA9Rtj5R5Uw8VAQlDJ7uvgFit3iv7yN3kvs+jHZ9SixH
	Lk9WwHLaKpDppLsc+w7HXSyu/jSVtUfTAUc6y4/P50sS1ZODYnMMyv2aXG1244cDO6YhW8vUzRL
	72KBNBR8+PiabGnSkc/yeqey99VkxnCXjNzPRDmjNZlyMy1VFWvykOeosBWXFrbZyjGk1pG2L4s
	frlHRmJIwkA0njBYF+QO4VwchBmFadIAWWa+qI/fUtxpcjEwey52fMJ752Nxa9CHGm29EcsfeW0
	bmgJ2HwlAxtyHZk6fN1tAtXHVQ==
X-Google-Smtp-Source: AGHT+IHoNlpLjWKI71Atidaa/U/Sw4jxQQRIScbDZB9h5uCOh9x/NY+6NtPRBmPtnYgIzkdPfsboiqO1uu3P5xwh4PI=
X-Received: by 2002:a05:690e:11cb:b0:63b:6b56:e6af with SMTP id
 956f58d0204a3-63e161993damr20601632d50.36.1761327072608; Fri, 24 Oct 2025
 10:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com> <20251023171246.78bea1d8@kernel.org>
 <CAHS8izOynoK_7pGumZGefecdThsH=oXr1HJJ7+BQMF_ZyTL7=A@mail.gmail.com>
In-Reply-To: <CAHS8izOynoK_7pGumZGefecdThsH=oXr1HJJ7+BQMF_ZyTL7=A@mail.gmail.com>
From: Ankit Garg <nktgrg@google.com>
Date: Fri, 24 Oct 2025 10:31:01 -0700
X-Gm-Features: AWmQ_bk4LAFz91Es3nVp8J95XBGjCNoLC45YHeMPfN2YmfeURP6FZEqM4pnWB0U
Message-ID: <CAJcM6BECrKh2updwNk9c-4oDPqhgku_2KVzTimDASit1c1JWvg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] gve: Improve RX buffer length management
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:41=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Thu, Oct 23, 2025 at 5:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 22 Oct 2025 11:22:22 -0700 Joshua Washington wrote:
> > > This patch series improves the management of the RX buffer length for
> > > the DQO queue format in the gve driver. The goal is to make RX buffer
> > > length config more explicit, easy to change, and performant by defaul=
t.
> >
> > I suppose this was done in prep for later buffers for ZC?
> > It's less urgent given the change of plans in
> > https://lore.kernel.org/all/20251016184031.66c92962@kernel.org/
> > but still relevant AFAICT. Just wanted to confirm.. Mina?
>
> This is very likely unrelated to the large ZC buffers and instead
> related to another effort we're preparing for. Not really 'urgent' but
> as always a bit pressing :D
>
> --
> Thanks,
> Mina

This is being done in preparation for enabling HW-GRO by default later
on. Our device only coalesces packets till 19 buffers are filled and
with 2k buffer, biggest HW coalesced packet will be limited to 38k bytes.

To enable 64k sized packet, 4K buffers are needed.

