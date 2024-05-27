Return-Path: <netdev+bounces-98324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25CC8D0C8A
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 21:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DF11F22438
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E3C15FD11;
	Mon, 27 May 2024 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LgVka0WV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC2168C4
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837646; cv=none; b=HaQjH903dUpcv9b7u3mBEP4BNBykb6hvZerD0lcv7ZEOdelrknxyTKv3WLQ8AkXsjSIGdALGSZyNmMRisUGuWflmc30CIVbGoI7jGksfRD4V+H8GPhgZYuyXCo1zb6sAfZ9JpXhyx+nmYXRLIdb/f5e9y4zxvqeXwl+khZnBVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837646; c=relaxed/simple;
	bh=4EkNz74OlBGEC6z1YuEiLXE4v6QZ8njYb41SVknyWCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLqYPVARwNe/dsLTv2NjOdDmgYyxF6Wq9Mqy7Y90zkGocEkMDNwpT6Lkh+ug88x6EN6LhyiPo79rkzAu6CiwESigYixzk9/zLHdXlhEg8dzKiBv67xmg5XfNJLUv/89WCNA0gQLziGfRoceAUVdBltqzFuDjXBOSIFvSRpsrD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LgVka0WV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso104454e87.3
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716837642; x=1717442442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=av+hI6RrZwvLerv2odhQfSwHlj6qlp1CeMI357Hz1qc=;
        b=LgVka0WVeSeA/Byv3DFCUEwqtU/4ECcB/c11XkaRZRXAEmx1yXa/qI0qsQjJOt5V8g
         OObNm6wI8dEa1YklY0WX0hNi4SUyhGZj4DvrbPfgzySBFJtCHfnfP62xDMbSa8qFjoBb
         M1zuXe1z7Hsml34cYr4YPS48s5qdnqwfES6qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716837642; x=1717442442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=av+hI6RrZwvLerv2odhQfSwHlj6qlp1CeMI357Hz1qc=;
        b=XvH4EmD9iT15Cz3yhaVrJtvYXnoiUc93GFFOetqPRdT7cXajTvT54IyHPlHafzIV4K
         aL6MRKedhloT+4RVcy2Mo3h679jA7zjzTIYSZq5fu5mdGbT0eGjqN1yS5YAhPqNiYsiI
         wAmPWX2ebpC5c9AhX8zU2KsOFC68nmD8dUly/VOnLeW5elIWBCtYBbwa4q23g+EEwBeC
         HBEh6maTsuhnEXWuJEzyJX1nIJ6a/s3DcINoD4BpjQcNqsDPIt2B8cmnqDbZ34R/XVCW
         FZva+jgmgaoTKuh0A8TUoIIMO2xhnBbqkafXLBZgbg3DIuvswsV2ps4F/XZv2+JTzSiQ
         OWRw==
X-Gm-Message-State: AOJu0YwyhFVNfz4c1YBYfm4JOukFR2jW4ld3MOCcoYLa7cf6WES7wfsg
	cnWmkxZlpTDOJcbBNxMrkd2ASMITsJ6/TGM7QI7KrPHv4dM4U6rev75lfTb9Ekm9IQ7K1TIGLXO
	YCbpC5A==
X-Google-Smtp-Source: AGHT+IHqloMc171NYKN+lhXpJfHNoRrZj4m6C/U4W7tH7q9hQvKff7iRF9nB+iNvYJldqeGOC8hPZA==
X-Received: by 2002:ac2:52b6:0:b0:51f:5c3:2d6e with SMTP id 2adb3069b0e04-52964bafa4dmr6402099e87.17.1716837641843;
        Mon, 27 May 2024 12:20:41 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529a81eeaedsm416207e87.267.2024.05.27.12.20.41
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:20:41 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso104435e87.3
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 12:20:41 -0700 (PDT)
X-Received: by 2002:a05:6512:224c:b0:51f:d989:18f6 with SMTP id
 2adb3069b0e04-529645e230emr9748602e87.13.1716837640937; Mon, 27 May 2024
 12:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV> <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
 <20240526231641.GB2118490@ZenIV> <20240527163116.GD2118490@ZenIV>
In-Reply-To: <20240527163116.GD2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 May 2024 12:20:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2VS-ZYPGARrdYVKdexcC1DsERgG1duPojtc0R92w7CA@mail.gmail.com>
Message-ID: <CAHk-=wj2VS-ZYPGARrdYVKdexcC1DsERgG1duPojtc0R92w7CA@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 May 2024 at 09:31, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Alternatively, with a sane set of helpers we could actually _replace_
> struct fd definition without a huge flagday commit

It wouldn't even be all that huge. We've got less than 200 of those
'struct fd' users, and some of them hardly even look at the result,
but just pass it off to other helpers (ie the kernel/bpf/syscalls.c
pattern).

With just a couple of helpers it would be mostly a cleanup.

               Linus

