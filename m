Return-Path: <netdev+bounces-67294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD76842AD9
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BBE1B24F91
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B74129A7B;
	Tue, 30 Jan 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GBSNh07F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CD1292D2
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635539; cv=none; b=tD+CrxruRZNjqPtgWyuVKNRxCtyWO1cse7Nkl73LR9zHlh4IZveCangJ82SO4QI2KR7xG/HFy1kFq1k/ugKX7DuJYDXx03ElsEvXjk0I1ZqPL06HDZ3xFCMhuHN93gvo8M9962p1Cbj02SlywZPhd3cvliCqQkg2VdXFp3xV5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635539; c=relaxed/simple;
	bh=FcwkWgQyZxHw0vq0MR9FTO1uQCeqns6oU7XSsrjb7aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucavaf4N2bkj1x8S/IJ0ljua5Ecob/MCCXDuVK0MTSf2o5RSx1gtR/ATW1wjp7h0hJR+PRjVO+tXXMlqu73Nu40fTEZNLU7NEex36xACuiMx8p5VuNRXFxAv53UUVXmUmYmHcMJh0gGEyfEj54+7L7Fz/EXHwEo5Yf8Ag8DIFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=none smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GBSNh07F; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf3a095ba6so50385031fa.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706635535; x=1707240335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3M0wWn2WcqB5JyFL/iZZPD7cHnf4NTD7VpnGyg3ebus=;
        b=GBSNh07Frpck1RYTdkVQBNLTmctcTsURPH4nrLKBcWFMfceCYJBTlxZcwnkPgbnLuz
         5ArV5FDr2ZYqZkmhJ6/AeOqZeFb4rLmYBU1vPiKEQ04lym8UTLIZmZrw8KAgdKkRVYFD
         NZGYMH4MlTomi0iH9nTBpEv+fCVqiCYs05q1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706635535; x=1707240335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3M0wWn2WcqB5JyFL/iZZPD7cHnf4NTD7VpnGyg3ebus=;
        b=i8+HcvTLohggrDBoc0+ZecmlDsc67jJf3SIuMtqiFywVaIRG0Gzo72iL61EiCkqAJg
         kYSAi0hRRho9ooHVfKAcAWP2Uiks3BfdSREpsXiq9VsKOOI7KJhMw6nIgaTG4YDXBdO6
         dV8av5+EqvUHfqCmZMT6cITeVMad08l9F0yN5owiMvbaL7rI9oeVj7nSf1mI80xFieM/
         dfT1ijCBkupN22iCXocTHi/F9b3yQDwLKbB850vuAR79WY5hM1yLyECeyFSf/5xR50Vt
         XvcWiyHSkvui4QD8TqK1/Ns5ibylvQG2q/sVV7Uhj5R7AjKsa5euikYYHvd+W+2tDY0r
         wBxA==
X-Gm-Message-State: AOJu0Yy6giKB3GCK7vOYy2//ukhJ0PC4Q4rvmcM0mORyFYPV5GL0nkMD
	SPpTwuWpEALZVVZlxYib+my5A8Imy779jtA1K6cgB2SOO+NBKVslTDSMMUXidREhJ34uT/qkNu5
	QRtY=
X-Google-Smtp-Source: AGHT+IG8bzEgmjg/swcVe1MFty7Xl+NrD4dwVeIDAfSE99FqhZPBnCPpoeLgq2YH9tAqVk7uXV+tKQ==
X-Received: by 2002:a05:651c:1212:b0:2cc:7fd8:197d with SMTP id i18-20020a05651c121200b002cc7fd8197dmr6666746lja.30.1706635535337;
        Tue, 30 Jan 2024 09:25:35 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h2-20020a2eb0e2000000b002cca6703b13sm1586102ljl.99.2024.01.30.09.25.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 09:25:34 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d057003864so15320351fa.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:25:34 -0800 (PST)
X-Received: by 2002:a2e:8417:0:b0:2cf:36b:9abb with SMTP id
 z23-20020a2e8417000000b002cf036b9abbmr5802206ljg.44.1706635533757; Tue, 30
 Jan 2024 09:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-4-tj@kernel.org>
In-Reply-To: <20240130091300.2968534-4-tj@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 09:25:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyr9jtwpiF8=es3j+D3tFF_338nJqdUq3f3oc=oJAPMA@mail.gmail.com>
Message-ID: <CAHk-=whyr9jtwpiF8=es3j+D3tFF_338nJqdUq3f3oc=oJAPMA@mail.gmail.com>
Subject: Re: [PATCH 3/8] workqueue: Implement BH workqueues to eventually
 replace tasklets
To: Tejun Heo <tj@kernel.org>
Cc: mpatocka@redhat.com, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com, 
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com, 
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 01:13, Tejun Heo <tj@kernel.org> wrote:
>
> This patch implements BH workqueues which share the same semantics and
> features of regular workqueues but execute their work items in the softirq
> context.

Thanks for doing this. Honestly, while I felt this was a natural thing
to do and would clean things up, every time I look at the workqueue
code I just shudder and go "I'm sure Tejun can work this out".

Patches look fine to me - I'd love to actually have the dm-crypt
people (and networking people, for that matter) verify that there are
no performance gotchas from the slightly heavier (but more generic)
workqueue interfaces.

                   Linus

