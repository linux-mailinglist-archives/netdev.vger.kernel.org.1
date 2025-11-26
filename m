Return-Path: <netdev+bounces-241825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9EC88D3A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5763B084B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373F315D27;
	Wed, 26 Nov 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOpxJnGv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31C311596
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147850; cv=none; b=Y/J0QOHwxlyGvfcEiYz3aM0jRebnZwqLas9Q9NgVC30nnHv6VTOkLEDRZ5vatPyFghQ+7UZ/BtB/w0sP6CR/+ldsU6USAPeEkQSUQxy9GcGxsc544kk9kB91IfzQ9EcA3YVd+Iba+JAJ+l1o+NzyowxlYHfH7tcmLy8EObveHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147850; c=relaxed/simple;
	bh=msA1Bmidu73lv6UgIPfMu/uKxgKN3WMlHd0YJZqFXso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1Dx9X6yTFMF9Dl+UAoGHnrJOZ+Cl9fkJpfu7kElrajOJG1xpKvTGw3UjzFDJVd4ioeiwf9FlLhQu4IiuKLxVHLiAH2hXrrnFMeAhVbaHLOk/i9Id+YW+S95wkTj+w/AabchlZv2J0G1Onxk8q/1wYHVN1NDkLbHcZ1WimTUzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOpxJnGv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed75832448so87838751cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764147842; x=1764752642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyRh8xXL0L8kVbM1qWyCLwjKZ6UbKVPw2m1+P8OYNlQ=;
        b=sOpxJnGv3ACf/h6aEZtQTVsMLfcSr1mRWlVQTJ09a2bfIw55plRjSMIcfHnZiHVW6s
         b2PtvVfB3gtWUvCQMXd2b6E6Ed94wtJ4sIywer91pv+L+W0adMBP1MgYqu4gCSeNLEek
         KUO1XhdZnbh5/SA/tix+WvQ1HyofMlw2mFpGJBJIo02SPWyHT1AfQdbyJ8AT97LYVVW0
         yYYGH4DI+y6fq7LRGn4gLXubfIt3+BXmNGOXVoMC8vi03Rol9fzaMIaBViclYeOpT843
         qiuJXRQKuzqlZFcSbTheevlOH0bB7Ku5CyNWvKiJQcGe6MPLs2UR13/Uwt7DuaaH6906
         p5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147842; x=1764752642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hyRh8xXL0L8kVbM1qWyCLwjKZ6UbKVPw2m1+P8OYNlQ=;
        b=FLR3F6fs0RwAK+qrJSyRS9xubttmNik1uHT+ZnbN7zYDyxkmM1R0d2Qu01Hn8XHUxJ
         T1ErISIdIz7nuKUcDbf9LOPV30F3oG2AO2oxzLKEmwDeIIpjK/PbnSxiLCb1ax8FfFgG
         L+LFhhcW1+vVAAXfN1BdtQZogqhMCidx8W5MpWcIjL/wrQvhdQ8hL0nRCDuXdrxrZcY8
         fyi5sJZYsFSgScAVkf+UQVMAzITRKaolzKLc1OYlgO46Fc7EDkp+r9qFVwIDFbdCv0KM
         n/V6X4106iS0sQotlkYwzSSRlu8fEDmhGNItp+XQJn8hEWSMu92aO7te9yWC6FQy1AcW
         41wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTCEkJFTSI6UrgWtVc3TNaiYGgrIEnrBL9c3LoTi4aqSvLqso4lGIx3KWavFXM5d1WqMHJDtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPrCPyVQZVXBPYIQTO4eaxdxdqGLMy7p/KAOH1LhAY0bPixhcd
	Q3+lPLIAAojPuA8lHysz0P/N+uEe2dGQ91wM/aaMVBPaL4NztZa3vpMDCbgfJbVxv7aZNzcfokF
	4q0GMrG59F5ZNY2/OYArhF2J5rd1Mz9d6nqNsSig6
X-Gm-Gg: ASbGnctZT96GT8jZsbJ1AM48x1ilN4i/2Zl41RQovhKX4xaUuHyXm2zjXO9lmgrg6MD
	Jv075caf1PQeHKNV9aDj6u8vf5Q8l3f0EJnjgfugQvufTMrNupGYwTe5CY20oDqoUNiog0uIDwq
	4xLYIjO8mVSU11JKqz+oJqlOwxazItQaUtX26ESfhaIHrr3ZLKBB3z+vsq0fNoFWuYVkFDlMgrc
	AGRD5yosr3WWmh8DNL19zaVwfpCHYN3SYaKSa5qz/tU2dLrSQ+KFQ2bBZ+rSdPZg2/Uqw==
X-Google-Smtp-Source: AGHT+IEPVELKVM1cwUwrfGMntJ3piYPimKdkJDSl5UF5isYNXZBNp4wQ/L7Ai4Aqn4fzrw9sl0QMSXAAIJOZ5vJ9tYw=
X-Received: by 2002:ac8:58d4:0:b0:4ee:1db1:a61b with SMTP id
 d75a77b69052e-4ee58b04acbmr253389301cf.75.1764147841940; Wed, 26 Nov 2025
 01:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126085718.50808-1-ssranevjti@gmail.com>
In-Reply-To: <20251126085718.50808-1-ssranevjti@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Nov 2025 01:03:50 -0800
X-Gm-Features: AWmQ_bmE9KDgoqH9fUKEjaUj9BjCwLFusadkTUuVGXRtTtcEL0ewy5b2wK6n-kg
Message-ID: <CANn89iKRYHaYS_wC0CzxsFD6pCHv126xKDbVgozBKvZyK-j7Yw@mail.gmail.com>
Subject: Re: [PATCH v3] net/sched: em_canid: fix uninit-value in em_canid_match
To: ssrane_b23@ee.vjti.ac.in
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Rostislav Lisovy <lisovy@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 12:57=E2=80=AFAM <ssrane_b23@ee.vjti.ac.in> wrote:
>
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>
> Use pskb_may_pull() to ensure a complete CAN frame is present in the
> linear data buffer before reading the CAN ID. A simple skb->len check
> is insufficient because it only verifies the total data length but does
> not guarantee the data is present in skb->data (it could be in
> fragments).
>
> pskb_may_pull() both validates the length and pulls fragmented data
> into the linear buffer if necessary, making it safe to directly
> access skb->data.
>
> Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5d8269a1e099279152bc
> Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames acco=
rding to their identifiers")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
> v3: Use CAN_MTU to validate a complete CAN frame is present
> v2: Use pskb_may_pull() instead of skb->len check to properly
>     handle fragmented skbs
> ---
>  net/sched/em_canid.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> index 5337bc462755..2d27f91d8441 100644
> --- a/net/sched/em_canid.c
> +++ b/net/sched/em_canid.c
> @@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct t=
cf_ematch *m,
>         int i;
>         const struct can_filter *lp;
>
> +       if (!pskb_may_pull(skb, CAN_MTU))
> +               return 0;
> +
>         can_id =3D em_canid_get_id(skb);
>
>         if (can_id & CAN_EFF_FLAG) {

For your next netdev patches, please read
Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Thank you.

