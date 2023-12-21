Return-Path: <netdev+bounces-59727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1608181BDED
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356001C23E8D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B2C634F7;
	Thu, 21 Dec 2023 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NrjvaxYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE8634E4
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso1293442a12.2
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703182203; x=1703787003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bCPDmIkvOqzN7yorvfIASJF9FBAZlqrwDbGblS1upSs=;
        b=NrjvaxYJW+nYRhO4eLwEf2oQAcqmRrCzdTvAYInW47yOUO2LT4gPMb4DXIs4J3ehw/
         HZj3DAg58zOenCBd6V8qA0r7S/DeUKJD6JV0vHzGJRiRcfK4kVfsLhvTRr5HwpbbPWOZ
         DJ6CY8+udW/TmcWIS+YHuwHHpnU8yLi0bfyM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703182203; x=1703787003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCPDmIkvOqzN7yorvfIASJF9FBAZlqrwDbGblS1upSs=;
        b=RpEm85W21x7/Jdg36jmAyRlpZej0YwjjmNn6fZDeMT8GCak0DiWRhGEnm4PbUyG6Vy
         sPLuDbCPPLSSsyc6wM7NHguDSZ7D9eF1rK288PNF0eGmg4rQNglMfhGgeCL4G5K+zYtg
         DvckPghughqNuSR4bU0CBm9C/j07MrRJxhsSrxkx5yEErgTX/jAn0UDJ6JpdotbL+uMb
         2rS6tixzmtlnVerDfcHm3AgWArn3rxLlBnvmGnI6dc/oA+jsS1/obg42Eini31rd2Q3i
         N1NeJfRVnqGhYegeAd+GSj/hFVKFVsFsTmtJUmJn/1wTEh1pZQm7B14qYaF6Ojf6Cfi8
         M4+w==
X-Gm-Message-State: AOJu0YzITVxzQIengkm5qBVd0wyLfn6eYh7I1zf8obtcy9aRwjsFaZYl
	U7LLAJfe8P8cNqu0Svw04hsd3IO/1I7ETJddfeDnOgzl
X-Google-Smtp-Source: AGHT+IGJIY68E5oPT6n0uz62Wbs14RCpqeIZ28QnBFeGceHgOAnov73HddG6hbMmHHPaom8KfSk3eQ==
X-Received: by 2002:a05:6402:230e:b0:54c:b185:2895 with SMTP id l14-20020a056402230e00b0054cb1852895mr11075409eda.27.1703182203266;
        Thu, 21 Dec 2023 10:10:03 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ck28-20020a0564021c1c00b0054ca7afdf35sm1474503edb.86.2023.12.21.10.10.02
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:10:02 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5542ac8b982so856878a12.3
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 10:10:02 -0800 (PST)
X-Received: by 2002:a17:906:74de:b0:a1e:437c:6a6d with SMTP id
 z30-20020a17090674de00b00a1e437c6a6dmr72129ejl.95.1703182202115; Thu, 21 Dec
 2023 10:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205101002.1c09e027@kernel.org>
In-Reply-To: <20231205101002.1c09e027@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Dec 2023 10:09:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whceLbGZwuLnR0S3V_ajedDXj=s86sm89m+VT2YrbG1NA@mail.gmail.com>
Message-ID: <CAHk-=whceLbGZwuLnR0S3V_ajedDXj=s86sm89m+VT2YrbG1NA@mail.gmail.com>
Subject: Re: [ANN] Winter break shutdown plan
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, fw@strlen.de, 
	pablo@netfilter.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 10:10, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hopefully the merge window for v6.8 will open on Jan 7th or 14th,
> giving us at least a week to settle any -next code which is ready
> after the break.

Just FYI - my current plan is that -rc7 will happen this Saturday
(because I still follow the Finnish customs of Christmas _Eve_ being
the important day, so Sunday I'll be off), and then if anything comes
in that week - which it will do, even if networking might be offline -
I'll do an rc8 the week after.

Then, unless anything odd happens, the final 6.7 release will be Jan
7th, and so the merge window for 6.8 will open Jan 8th.

So that's the plan, and it doesn't look like there's anything strange
going on that would cause me to delay any further, so it's pretty
likely to hold. Knock wood.

                   Linus

