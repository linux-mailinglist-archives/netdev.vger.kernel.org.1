Return-Path: <netdev+bounces-131706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE0998F4F7
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A2AB220B4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236741A3033;
	Thu,  3 Oct 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSP1E+9c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F47199FC1
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975937; cv=none; b=UwV5PYBWNbLUFF1k0T/Qa/tHaCLRy9pwJG2JPiiZiVKUm4n/JOhxWwTeoklqR53hoIXK7jG/UPbWrHfBvuXeN7HynJph9wFg7bcIRSCmfCRzRRKzWn+9PX3t2xMxzhqnpe2OCifltfaKiSx1WV9wkmLYYpv+0u0UyWeD8xuq1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975937; c=relaxed/simple;
	bh=gW3JfwEqx+m7TAOPqQ1Bz4IK6GgwyQJmhA/4Hj9susI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI0/Rz1qSKBpoGMfH1T0Ac4Y6Ob6CI87Z6Am/Mhdn3fe0ma883oyEjbXLhvsN6C/yOxJdIoVyybT/pfIejhwabueOpPhKN5+dMj74PdOphogFuMI+P0+SYec7cD87agMPYt2G2JHRlbDhJw44knNmX8sx1yTwWJ99MChVAYPcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSP1E+9c; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso812023a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727975935; x=1728580735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QB/H/nDAGoM96EbRYFXNQ5D6YGMnG8ohppHJ3hTRLc4=;
        b=kSP1E+9c4LAYh3EkNR54hzRCekR/15SujqiACyXzq72W8AmgAfdpIrQcu5epVlKtqP
         3o+U3LO7ZUQbmx02GPlgWddzziyVXuLzYj2FTGQJ43Mmx+/HPv93+N+OAVPS6pULlQeI
         jCyq0ynBPvyvl5/r/p2S20mOcG1eiU4awI46P6CeTtUkN7mUllYTZ4tUcgJa37YtCLQK
         NinJ3b06PIisCt0E/60OQewQSo/vRfz6raK0bnr9+SZvpAme/I5zJYvyMSnueMb1t/lX
         hhFQAaj8NPM7IKXtEQkdfzdBF7u5GH552fyxEXpdqfp+RgYe6y9ynSJn3ytsWC0Wcl23
         DwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727975935; x=1728580735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QB/H/nDAGoM96EbRYFXNQ5D6YGMnG8ohppHJ3hTRLc4=;
        b=obYoVLHRkqrcU/Z5Ci10IYOlJMIzT96iU7dtNr94kkuQtf8DU55IndkRN8rZm00qV/
         j8dHk+IvDeGSb6X32XGywMOiqSUp9OdDerqe0ikKN9QBO3hRmyeiKokDZR1gam3ppwj0
         a7cBJWd74dlpc7sIYh6L2VZzP+5zceQldSVJvWyMB+kesaZpdWxU9x7IUC5vzobo95t2
         mymemA838VOXnD4XJkQ+eQ1UizYDaKY0RmIedGkvNk/KkxzefVmYSyJs7bYSPTQjVVmw
         g88p+hVGeLqOlSKr0I+eJg0uiUHR6f3U/5XyHRuPvTEI7OJ/vZpwUhUbVZkDy8hWdAh7
         w+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0BHfvbEPfGkQ9JYcasDKinP+UsPlvrLJKYbO78MN0IFehl9r2xeUCJ74931ff3J+mndoZgOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLk64HilYV1tlWeNqqqKiTK3vGDYDY1Be96/sNAsrACmuAaRU
	RgamqTwXnOhy27yz4neZDyRwgUm61IzDazxmOZLu9K5QF89BcPY=
X-Google-Smtp-Source: AGHT+IGeP6lmhEjKlJCfnTH4GfERKfbipEvB/OiS6yHusZmdWsi8Is8oXz18tK0fnFiEz0MTNF3F8Q==
X-Received: by 2002:a05:6a21:10b:b0:1d2:e78d:214a with SMTP id adf61e73a8af0-1d6dfae33c0mr33062637.44.1727975934790;
        Thu, 03 Oct 2024 10:18:54 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb51csm1599932b3a.113.2024.10.03.10.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:18:54 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:18:53 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 10/12] selftests: ncdevmem: Run selftest when
 none of the -s or -c has been provided
Message-ID: <Zv7R_dRFZ0VGindy@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-11-sdf@fomichev.me>
 <CAHS8izNwYgweZvD+hQgx_k5wjMDG1W5_rscXq_C8oVMdg546Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNwYgweZvD+hQgx_k5wjMDG1W5_rscXq_C8oVMdg546Tw@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > This will be used as a 'probe' mode in the selftest to check whether
> > the device supports the devmem or not.
> 
> It's not really 'probing'. Running ncdevmem with -s or -c does the
> data path tests. Running ncdevmem without does all the control path
> tests in run_devmem_tests(). It's not just probing driver for support,
> it's mean to catch bugs. Maybe rename to 'control path tests' or
> 'config tests' instead of probing.

Re 'probing' vs 'control path tests': I need something I can call
in the python selftest to tell me whether the nic supports devmem
or not (to skip the tests on the unsupported nics), so I'm reusing this
'control path tests' mode for this. I do agree that there might be an
issue where the nic supports devmem, but has some bug which causes
'control path tests' to fail which leads to skipping the data plane tests...

We can try to separate these two in the future. (and I'll keep the word
'probing' for now since it's only in the commit message to describe the
intent)

> > Use hard-coded queue layout
> > (two last queues) and prevent user from passing custom -q and/or -t.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 27 +++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 900a661a61af..9b0a81b12eac 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -688,17 +688,26 @@ int main(int argc, char *argv[])
> >                 }
> >         }
> >
> > -       if (!server_ip)
> > -               error(1, 0, "Missing -s argument\n");
> > -
> > -       if (!port)
> > -               error(1, 0, "Missing -p argument\n");
> > -
> >         if (!ifname)
> >                 error(1, 0, "Missing -f argument\n");
> >
> >         ifindex = if_nametoindex(ifname);
> >
> > +       if (!server_ip && !client_ip) {
> > +               if (start_queue != -1)
> > +                       error(1, 0, "don't support custom start queue for probing\n");
> > +               if (num_queues != 1)
> > +                       error(1, 0, "don't support custom number of queues for probing\n");
> > +
> 
> Remove the start_queue + num_queues check here please. I would like to
> be able to run the control path tests binding dmabuf to all the queues
> or 1 of the queues or some of the queues.

Will remove, but let's continue discussing this in the other thread.

