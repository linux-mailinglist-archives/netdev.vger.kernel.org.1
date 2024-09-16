Return-Path: <netdev+bounces-128538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A557F97A289
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC2A1F21683
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD9155322;
	Mon, 16 Sep 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FU017zB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80014D2B3
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490877; cv=none; b=Ddq7jYq39cVFvKccn2uQvEiMdOCzACsciKniSnlyFPGr8z+XpaN8BWwBnbGx3Fu9DkY8G24zyIguY2oXWpE2dtSCmr9xpC2Ys6JmGa4uwT2Y4eSPD7FHdXB/XS4jGTV6vmlPzVgUMJO/9GrZ8MrprTfQTKooAAwR2LwTfic+zXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490877; c=relaxed/simple;
	bh=jsbn+WmVH0Dzf5lO8SflvbPNnk9/a0RI84FKIQmQlCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnRRzDFG0yxV9dUEfK0RvAkACSop1eHcHERMrabI8ShjBhB6rpYtdOTBtmv9HMZIrHQMk9OKnS2sgiPV7TNsEiAuQPxwqDSTiI0GhJFiilUbJPLXo3hwkCSG/U/S1IlTskG2+N9bAcgNNMESRvSkYDscE212A4rcgUt2G8JD7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FU017zB9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f759b87f83so47008251fa.2
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726490873; x=1727095673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EwFsfsQ8QQ5I+uPaTEJavUH1NqV2xVXw1sAB8RhWP0w=;
        b=FU017zB9cfUmAbtzi99jHnd0XYxfo8Pzb27vqAuZ8HBpWRTXFi1DuNYuF4f7iMc7rP
         LZL6WKxMBeJTtR0pU5FOVIvOhvxp5FxiePSNCgNa1iVxTuizuveRzuL9u7xTOMwYdtmd
         qyTJ3UjlLUTM8NmpSIEURKhj6VoFBFeuCk5SrWSSk434rVl6ipYjZmqP8tnYJiHerUBW
         MG4HZgrGPt0sWJcxliTDUBEMA8eWqfARf+PTJy/7j07GMBv3epjQvUsWRkV9rl65bCsf
         ZxV3YJQK7ywFZ6yvH070nhSu3hyXUM6Ks+W/jH3F3xtRZSueYhGcLh3Fu7YRWPZ1AWvn
         0TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726490873; x=1727095673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwFsfsQ8QQ5I+uPaTEJavUH1NqV2xVXw1sAB8RhWP0w=;
        b=dGjoo1IDGOnyK3glZp0YWIFM0bHKrdOWFrFcGmPtJQJf25heIVrKAO0SUF8eGtRZ15
         Tn9C+lr/HCVegd0SlYcIIcDzCz7TGBWpQ4C3rXWyjf38i/8m0f1hYafVOzzF32n1U8wf
         jBCqhhJyhVn5iZo+iVfwHOUYOzvP3+awOcyvY/n/FBiyDluy/pEiM0JOaO4hCOntPiWh
         O6IiAYvIRo1Mdo77+ZylqY7mBwbv3cM3xB4FTF6UbXBcFwKfsKwmOWaKOXCn6WPc/Hj1
         FS37U5g1xjCkY5K1wkwJaMjs5ORqImJYDBl9NJL4hvgHEStPTVqrOU+8OVa+X0i06VB5
         LKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRJR1lL4HinwZKCsD9CSY9yd7k+h6sN5SLRzbGJXYYrSo/eABYiWbGB+BKQkkAHrdwTfGhCGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztikIwXx3kFpkkGs+NumFloPxztQIhZJMSyKadN1caMjzxEBP9
	3SZqpJFgjHAUPKAgeGLMoGVEyJfEE8M7owGcXcBLJdrmrH8QCJs8OFyvY5FdqzeabuJ8cTGU0jd
	l12tIh7ETsEkMeO5qg1AYhZGqR2Y6JuWJKYDl
X-Google-Smtp-Source: AGHT+IEJz/yX7vNGeXW9Mog5agAdXl6T4dtywfGdJ5ErW57HcTLB8Ws2OuR13PMxIldSMbIKSszIGMk8XbZ3BK5iOkY=
X-Received: by 2002:a2e:bc0a:0:b0:2f3:b078:84bc with SMTP id
 38308e7fff4ca-2f787dad3bamr83585811fa.4.1726490873175; Mon, 16 Sep 2024
 05:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000060476705f07bbba5@google.com> <20221223120350.7af6afa2@kernel.org>
In-Reply-To: <20221223120350.7af6afa2@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Sep 2024 14:47:41 +0200
Message-ID: <CACT4Y+YqsCqyWVYDgaEkW0DfUAVtq5sqK4vcvCLfW_6xY-DMEg@mail.gmail.com>
Subject: Re: [syzbot] net-next build error (5)
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+e5341b984215b66e5b19@syzkaller.appspotmail.com>, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Dec 2022 at 21:03, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 23 Dec 2022 01:51:38 -0800 syzbot wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    1d330d4fa8ba net: alx: Switch to DEFINE_SIMPLE_DEV_PM_OPS(..
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16c71ba3880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b0e91ad4b5f69c47
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e5341b984215b66e5b19
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e5341b984215b66e5b19@syzkaller.appspotmail.com
> >
> > failed to run ["make" "-j" "64" "ARCH=x86_64" "bzImage"]: exit status 2
>
> This is syzbot ooming during build or such? I don't see any error.

Yes, it looks like it OOMed:

  LD      vmlinux.o
Killed
make[1]: *** [scripts/Makefile.vmlinux_o:61: vmlinux.o] Error 137

Filed https://github.com/google/syzkaller/issues/5317 for this.

