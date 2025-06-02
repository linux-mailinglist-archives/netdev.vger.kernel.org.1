Return-Path: <netdev+bounces-194613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE31ACB37D
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9DC4A3F09
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF6A23BF9C;
	Mon,  2 Jun 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOcXeLP9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C6223DE1;
	Mon,  2 Jun 2025 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874157; cv=none; b=VgpwPpza6fUgmMMy74LbfI0EJIJJ8Khj4ywoDaHgds/7k79KrMXrxjhrz1KkQCaKN7pPGdqGcN7iTnd8n57t2J+mkkALff5ZBy9oJLXY6Nyv7+jQLLIaRhGvOiqTtF+yKs1Jo4teY2eHUy23EZR23O8TseZfimoapVf9m6P0ayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874157; c=relaxed/simple;
	bh=4asGXC+3cQS1Vtxvk8QtAW0Q9zZdEBvNR6Cj25g7FHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Op+zuPiDLWLrWzKQD7w3lmJ6wC2tbAqpvINtq0vOhE+spyV7sfTmc/ab/6zW82w2Nqvew2pV51U9XKoxNCeAFbU0TqmXyoXv+4eY7VEHQpo61AkomiE7tnKl5OwEIfqJk+dago8AffrXPm0wbgLGAMVOQzUxns3TeBvAt170XXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOcXeLP9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso37544221fa.0;
        Mon, 02 Jun 2025 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748874153; x=1749478953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvWTXPKPlqF0Qo0JqfM4yt9Sti77l2uaO9tTuXi5U5g=;
        b=QOcXeLP9Qys8j8eUIshTS2mjSNd/m2QLZBZ9dv1KYOnjFyVNhKJlwaMhh2ltl80pwl
         dxFlYn7SEtm+VhdV2Udby1n3LrZJ5zP1CjhFTjbKk7YXpuobJnN2xto4rcAuOjUgHRGB
         jtGsp+rPw2Vn1uA49eV58Uj3RQdSAMdoHanSxzXu6WOo27Qw+wOfGuFKON+7yWLCcOOw
         vcmm1kyBjskJc8kwFWAffuvqF74nLFERtk8nLvHXe79g5yOeyqesXzxwjCrhgIa2LA0u
         V5oAdgGN+PFNa5t6N980UCtFfuLrJQoy+XfAE5+FY4lTIbeeBoOS/BGq8f7QnN0RcuWA
         MXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748874153; x=1749478953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvWTXPKPlqF0Qo0JqfM4yt9Sti77l2uaO9tTuXi5U5g=;
        b=pd4DUEPsyG0enRKbySP50g+qxaIYh29km/jBbX8aMq+hp6KyEzFB/fvYGZ6BpSj3wN
         YORATUAGNIvFnF/EC4Bv7sxDO8JqIzt4BkGWUdXVE17ekD98WclyrOrEyfw/GogtP8sz
         q0C/RIG7P3kCHV5+i+lck9a4qIVPIfj/A/6byFpWhk8J8wowSq3BrGwTFyVsSkclRRma
         AzsPDwu3ReZDiS443/PgCo4cZ4UDQEJQIaQxHyMb2wG8k71yxDwCmumgCBBYuYUZ+dXy
         VkA3dpESAIF2kt4IXwh7w4FIuKWRylhz9JxYSGmdjYchRowfCqRGUY+s8QjrKfCYjnBJ
         f1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVtcz8/z7t3W09mwRPOIWyHRqWIpuG5ap6UCAwXDReJZQXQgwF2d7sX/u47cGrJsh77xMa7moHmxjQRUhw=@vger.kernel.org, AJvYcCX5a3g18Kht8KAnx+D5/qurx2cFjN2BO3iR2HFsbKuhL7XXrjw8a8at6ZP1LNu/P8ucO16Rn9gZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMM/zkiV4iRqCd2pqjHLTYoU6Okwh9zW51OlQfVS7GJAOabTD
	0vTjGkFopkWnpD3xKpzMy/gzod3pLJ9kcm/9oRRrAQcW3NgyDB59iLLCu3RWXMDAsn8Jci2sli6
	PIkcuNqUJM0gOllkIhbI+3y4x0/Rn6JU=
X-Gm-Gg: ASbGncv4dv1fFlQFZYF9ZZWY1ZZBUXREwPFu6Bo+p0aJM3r8aZot24TgO+FQZgVt1N2
	5rRtmHlC/yEco+t9VxOiPhkzigqnYlRjJzKfOczNShxPcKyjFjyKQkLdmP1mSglSbASgGjd9l0M
	iikiGqFBQMDQS10a5sHzBALbp0ZfFGqRNkHESvzbEkhHglLCEjDY2tz2s5qqTBXx7h+mnrjb4FI
	zZ1vA==
X-Google-Smtp-Source: AGHT+IHmMQ5umwgAaQsxy+DfEQa54r62K54cfCeV/2DUTHutNDjoygIf/pTFf55KcmMrjin8z35F7WklY2+5DsgGAZY=
X-Received: by 2002:a2e:a581:0:b0:32a:778d:be86 with SMTP id
 38308e7fff4ca-32a9ea675c3mr23004991fa.31.1748874152720; Mon, 02 Jun 2025
 07:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com> <EEF63CCD-BEED-4471-BF07-586452F4E0BE@kernel.org>
In-Reply-To: <EEF63CCD-BEED-4471-BF07-586452F4E0BE@kernel.org>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Mon, 2 Jun 2025 19:52:21 +0530
X-Gm-Features: AX0GCFth8659Ha8JYy7z_o7EgLsVB1j9purYjddl2or_1vq465S9rAnAtkqnsAI
Message-ID: <CAH4c4jJYxXr=Q_cWCmDrRyWGEHnSfyOzM1kWCBWUC+jSXFafpw@mail.gmail.com>
Subject: Re: [PATCH] net: randomize layout of struct net_device
To: Kees Cook <kees@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keescook@chromium.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 7:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On June 2, 2025 6:59:32 AM PDT, Pranav Tyagi <pranav.tyagi03@gmail.com> w=
rote:
> >Add __randomize_layout to struct net_device to support structure layout
> >randomization if CONFIG_RANDSTRUCT is enabled else the macro expands to
> >do nothing. This enhances kernel protection by making it harder to
> >predict the memory layout of this structure.
> >
> >Link: https://github.com/KSPP/linux/issues/188
> >Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> >---
> > include/linux/netdevice.h | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >index 7ea022750e4e..0caff664ef3a 100644
> >--- a/include/linux/netdevice.h
> >+++ b/include/linux/netdevice.h
> >@@ -2077,7 +2077,11 @@ enum netdev_reg_state {
> >  *    moves out.
> >  */
> >
> >+#ifdef CONFIG_RANDSTRUCT
> >+struct __randomize_layout net_device {
> >+#else
> > struct net_device {
> >+#endif
>
> There no need for the ifdef. Also these traditionally go at the end, betw=
een } and ;. See other examples in the tree.
>
> -Kees

Thanks for the feedback. I will update the patch accordingly.
>
> >       /* Cacheline organization can be found documented in
> >        * Documentation/networking/net_cachelines/net_device.rst.
> >        * Please update the document when adding new fields.
>
> --
> Kees Cook

