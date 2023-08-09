Return-Path: <netdev+bounces-25956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE3777645B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AD9281DEC
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287F1BB31;
	Wed,  9 Aug 2023 15:48:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F418AE1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:48:32 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1AC1FEF
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:48:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so11549796e87.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691596110; x=1692200910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E1r9SEbY/6BeSSvbVtRdbVSYPWqzFDwd0F7d6h1DkFU=;
        b=gIQZNr9zucdDpiDYxZAbnSd8p+eXyRJwgBN2PAmxVDna8ceKNJtFeXf7HTwR1SVrIq
         XMYqqlFBKE09cOyG0eoO6o3XAIff8kErBdLGucfq2Q4c3e2Ujajt9Ybroo+jDb/DVd87
         iSdZjDH5wfyPOcr+0if2kWXr20MjD3dJUWkvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596110; x=1692200910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1r9SEbY/6BeSSvbVtRdbVSYPWqzFDwd0F7d6h1DkFU=;
        b=Z90w3UtaYM70KdCVf0ZJbt8M+XXARLM4jMJKJDmKpZMfzV+nySV7r5Yskr+x+nadeg
         fp0JwE58dOR+9gpz8L8sR0EtYMAWkv187aeWFLEktJZ5JgUtMRRavkXLFobWoN/pvjMf
         RAxabpTykan6kWd8TgWaHQ4Z6Du4LPjronHHj/4S+dgyufM7B7Mv8hPUc4UZRINnMhiZ
         8ZKvOyF2Ugsj6+hnFLKSZx8yLUg8RSsKvcid7QylGrvEBaalCESOLgDb1a7LobYXfsDW
         o/F8vyxQtyq1cEE0xgY2I/xls9wS6yc+UbsPs2eeIe1ZrpHejNo6jCt9RDw1Ue2JhTBH
         9EyA==
X-Gm-Message-State: AOJu0YwsHH0Q9xSbK22JbtE+XYzFu83flto4fmB600MQuAdrcbLW2cbP
	vU8zTjojfsnb93tzfMFFw1T7E2fzouJrOFqh9K4NZ3qt
X-Google-Smtp-Source: AGHT+IHhzeZiA1xXd4TgFaBCUChYNEMO70i5HkxncTEWtbp4jag9drjRVPRwaYp0JRYwU0EYNynn+g==
X-Received: by 2002:a05:6512:3d24:b0:4f9:571d:c50e with SMTP id d36-20020a0565123d2400b004f9571dc50emr2484049lfv.36.1691596109729;
        Wed, 09 Aug 2023 08:48:29 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id u7-20020ac248a7000000b004fe875e57besm102717lfg.251.2023.08.09.08.48.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:48:29 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so11549722e87.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 08:48:29 -0700 (PDT)
X-Received: by 2002:ac2:5bca:0:b0:4fb:89ad:6651 with SMTP id
 u10-20020ac25bca000000b004fb89ad6651mr1974250lfn.28.1691596108621; Wed, 09
 Aug 2023 08:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87edkce118.wl-tiwai@suse.de> <20230809143801.GA693@lst.de>
In-Reply-To: <20230809143801.GA693@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Aug 2023 08:48:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com>
Message-ID: <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
To: Christoph Hellwig <hch@lst.de>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 9 Aug 2023 at 07:38, Christoph Hellwig <hch@lst.de> wrote:
>
> The original set_fs removal series did that as uptr_t, and Linus
> hated it with passion.  I somehow doubt he's going to like it more now.

Christoph is right. I do hate this. The whole "pass a pointer that is
either user or kernel" concept is wrong.

Now, if it was some kind of extended pointer that also included the
length of the area and had a way to deal with updating the pointer
sanely, maybe that would be a different thing.

And it should guarantee that in the case of a user pointer it had gone
through access_ok().

And it also allowed the other common cases like having a raw page
array, along with a unified interface to copy and update this kind of
pointer either as a source or a destination, that would be a different
thing.

But this kind of "if (uniptr_is_kernel(src))" special case thing is
just garbage and *not* acceptable.

And oh, btw, we already *have* that extended kind of unipointer thing.

It's called "struct iov_iter".

And yes, it's a very complicated thing, exactly because it handles way
more cases than that uniptr_t. It's a *real* unified pointer of many
different types.

Those iov_iter things are often so complicated that you really don't
want to use them, but if you really want a uniptr, that is what you
should do. It comes with a real cost, but it does come with real
advantages, one of which is "this is extensively tested
nfrastructure".

                  Linus

