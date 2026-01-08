Return-Path: <netdev+bounces-248170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF704D04817
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FA3030445C5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9D52D7DCE;
	Thu,  8 Jan 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6mP/TCd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA028688C
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890247; cv=none; b=SIIjiLVdxgJ1b1VQjzBP5DbQhhOQKhF8m/Cc9r3vDQk93U9EJJdf8Bhh6QuNNBZ95VwWMEXxaKmqUzJ8D70jEVOT9YF3eij6wEEczvg8AXv7SOs06gsFel7KSTogGksIJl/eQ0xOgl0lYupZqq065780HYRdblrjKFco8gLYQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890247; c=relaxed/simple;
	bh=oiUJOqy4+7szk5Y7VIQU5zTbc+NUVFVNGpKBy1cwMy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoynY14k1haLWiFUoxwsXWlILUJ8CCBK22+s14xNjhMr/GqKTlKfYWjHooQnI07Wv2WuUwZ2t7rJBuveIos3uAJxbJ1banABkPxgFq/rB67q9lmgVPhEMvBKQ5ZNGw2hkLEdUQJ3SqGpFauuBMvpHUQ7bYz88Ras5DDjaxw2Wbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6mP/TCd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4f1aecac2c9so25114211cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767890245; x=1768495045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTBWtsdOdEJC2lJNr/ZVJNmgBqrVXGpeJsYz8CSdWns=;
        b=D6mP/TCdn3jVffNeeuPjAgnCx+SB1iPZBGU1oy6+8SyL0WX/5Pp1tNdkfmxhqiUjsb
         O0s6DAoF41DPkBZ4pJOc9V8Honapajjzbj7qjAEmlpxGeKTbpmrlfA2RTgd6YM3NwQL1
         3FbQtX0rOzpp7r9LBfPGWMscdRRopH5A19CcL5DW8FtUQvFf4fZ95Iihyuobop3hFRot
         CeGntQJOsByxWeFCZ6hQ8Kou1KoiX6s+h7K3E3y2Xjka/HYrRPb8eWoBQzNmN4ovhrv2
         o59EUzt4hasHN87sHDKlfkITF/Ow32xIMN1yybh+EPC0WTsWmr6Su+JnJDIYMqylkfO5
         Mbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767890245; x=1768495045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTBWtsdOdEJC2lJNr/ZVJNmgBqrVXGpeJsYz8CSdWns=;
        b=V01hH5XsyC7UhqCPCaCxZfhdnmLbjbD7E17SG2gF/4AaYwWcl2ZFM7smiOtLpauvrH
         Snonopg5XDPHEwwlqmp/H71rtlb9uTjugC1eLlmJz/N75xBXQGKMdqw4NQsRQwAgmfxA
         2zs7P5ZAWO7v7lS3+uLOR8C787qH9zSnpAw3kq7u9TRs1J942j57pKRqsMAIX/TY1Mh4
         DxZXtAUdQZhpgs/AEkkQ3lqAb8CyHUKe++rpvhZj46BhO/OTqmrzv/Faq1nbj58r78zc
         m5zaWD/Ma4u/JANEesRnbmMf9yZjFNJ05zwm/fEslTLG55EnepbtsaDCFSOe4DVGDJMX
         mppA==
X-Forwarded-Encrypted: i=1; AJvYcCVO+577z3kESFlfAQ3ZVKZimrgND5aazS1RIpV+jwvelr3BlkV6ehQz6XfK1blTcMX3Q6cB4q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8oojSSrjaRF1AjEyUIFzvswSpFS0elk0UlNbMibkGncZX3nAf
	/rTJVgvsL1epY0ZTW3/QVDnDImCaZadDTv/0J2unrBkk8Mh2ClIreE967zwVSCSPStm9lhjP8ox
	lClh8MwkSYIXho7BCGhHvf/17dQeLlV1HJ4RYSP4a
X-Gm-Gg: AY/fxX6bcsR5ZDoeEXPTDiU6mMYW2R24ZrPadT77pl/a0JBEecHxVdeaEMu/Mmkblx5
	A6UNb0ow+XP7g+V06T5KOgO3tAr0g6AiwMyAePJvkH5udOaF/kzpkXEF0Z1xtJaS7Gf5/6L9aDA
	1In0YBDfba8F6gOmm2b3ALnqjTjTfLTplbILh99+9A979Br/xOsW3tnksCd+UmoNO3us0PWj2AU
	J+wSyX/aJeu0XcE0cV0v7U7rloIcDE4NHsr4sH1gSJC1CeeQr/hmXP5URuxDhen6AjzzQ==
X-Google-Smtp-Source: AGHT+IE2f3jpfVr0DitkgQW0hgUpjNRprB0PR+qzZgf0vZaVTjpsGhCNA+19FxT3hPHaBT/ttMh7PhhiKWRsFSyPKyE=
X-Received: by 2002:a05:622a:7291:b0:4ff:a8c1:b00e with SMTP id
 d75a77b69052e-4ffa8c1bf36mr109817591cf.2.1767890245238; Thu, 08 Jan 2026
 08:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105232504.3791806-1-joshwash@google.com> <20260106182244.7188a8f6@kernel.org>
 <CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
In-Reply-To: <CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 17:37:14 +0100
X-Gm-Features: AQt7F2pZbYuFwcYb8xyVXNJG4r7Uvb6KoQWlgEB11-noITK7mtV2kImy1DvF0ZQ
Message-ID: <CANn89iK_=W8JT6WGb17ARnqqSgKkt5=GUaTMB6CbPfYuPNS7vA@mail.gmail.com>
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
To: Ankit Garg <nktgrg@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Catherine Sullivan <csully@google.com>, Luigi Rizzo <lrizzo@google.com>, Jon Olson <jonolson@google.com>, 
	Sagi Shahar <sagis@google.com>, Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 4:36=E2=80=AFPM Ankit Garg <nktgrg@google.com> wrote=
:
>
> On Tue, Jan 6, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Mon,  5 Jan 2026 15:25:02 -0800 Joshua Washington wrote:
> > > This series fixes a kernel panic in the GVE driver caused by
> > > out-of-bounds array access when the network stack provides an invalid
> > > TX queue index.
> >
> > Do you know how? I seem to recall we had such issues due to bugs
> > in the qdisc layer, most of which were fixed.
> >
> > Fixing this at the source, if possible, would be far preferable
> > to sprinkling this condition to all the drivers.
> That matches our observation=E2=80=94we have encountered this panic on ol=
der
> kernels (specifically Rocky Linux 8) but have not been able to
> reproduce it on recent upstream kernels.

What is the kernel version used in Rocky Linux 8 ?

Note that the test against real_num_tx_queues is done before reaching
the Qdisc layer.

It might help to give a stack trace of a panic.

>
> Could you point us to the specific qdisc fixes you recall? We'd like
> to verify if the issue we are seeing on the older kernel is indeed one
> of those known/fixed bugs.
>
> If it turns out this is fully resolved in the core network stack
> upstream, we can drop this patch for the mainline driver. However, if
> there is ambiguity, do you think there is value in keeping this check
> to prevent the driver from crashing on invalid input?

We already have many costly checks, and netdev_core_pick_tx() should
already prevent such panic.

>
> Thanks,
> Ankit Garg

