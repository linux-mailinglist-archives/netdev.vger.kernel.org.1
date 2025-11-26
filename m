Return-Path: <netdev+bounces-241769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0E7C88099
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C41C94EBC5C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF1312828;
	Wed, 26 Nov 2025 04:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="13IL3DdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A031283F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130599; cv=none; b=qA2EKnWR97yTocZkFGxDDsp6WTXNYGYqROu0Em9dn1/Cv9qpSuQ6hOiM8r0Sq9yTh53J09xNhE/jgruRfMGRbVXUaDVuCPwKcxClploFq0STHG/b8pYU4f4d4YZ4t9z3MnWdrp5m4GSRIUhGA6XFvoj49I10a48H/bE7S/lGq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130599; c=relaxed/simple;
	bh=CHLkD+aCMnLB3JeuX6yr5VK6fKzG/6EU7wOFsVdfWiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjEzNbpfM/AkwwavUCSQGsGoZ8zt6mbkh85yOAITzGW5mvEzpi/zNdNw1XWUS0lX4XywoaXlLULQq1wZE+3WoKlWJPotKDtc6k0QXkmfB/opcPb5VnRooYOORgvbtGQe76wjHchFLJ9VCtMWc1jlH/+D8+Sprjq2TOA5BkbrraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=13IL3DdN; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed7024c8c5so49326411cf.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764130596; x=1764735396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdoEAjvZ4ZMhSlfgYvRSVu1/48BFEzmIWIiWiBCSYaA=;
        b=13IL3DdNgVtXOds8ao7OwVouWtJpvzG8kg7vhgTJcsn0GXxDT4QAxkkXe0s78xPs+9
         Ug/TjuYx9srH4ONzIKIBEXyaKakgkNhq0zWk+DqQNPxyWybscHRwkHmHX8drGhANXbPW
         FXqjP5zrLdR2PtUETKKUjo/9fNF6YgCFEaFSDmjjhVr0ccKv5EU3Lwvwpst1wo6ZBuk3
         jxkCgTivU+CBPgTQOX9q8whifbu8leCQIlVt6ujOpY6X4Yd3TlHvxQNAcVu5Hl+vsdBM
         Dc1xB5qEfjbTa9BCkEQxDEXqJ1yTi4npM5iyV8FYut5eSmBDUdj8FxEqqywqfqcS2C3x
         O9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764130596; x=1764735396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DdoEAjvZ4ZMhSlfgYvRSVu1/48BFEzmIWIiWiBCSYaA=;
        b=MYwhYNgzIW54MAmnH2TtV7QUXzRsTy7dKkb7BlingOqmtXE5BJT7KuklHSbqz9JIsi
         /kAjrKQzScl5HZBME789wVTd1KMsh4OgP1mU9+pOHj6+vSB8fKfvi87fu1RtoY9skBN7
         Y1CvZgmzpAicujOY4EiteXJkyX5H1omG2QYXaHEpt8ktcf4y+9elvNjvoEaePFlQpSZu
         teeEZ/jCq4koCVjRWVnOQVJHsxvJpD+2tNMGrHOqj14vq4Khxes/ueSLjvk0T3EEnqcq
         vK1c2YIKIr+AU00zBQDmzsb+RD9xliSbfYet6iJY/Wg5XAeRGj/+71twjQwjgdVDehTx
         d3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF1M6LYbNSfpNe14c9k9ESJQpxZ9touaMXaIpbng1+7Vec+28sK2Lej5E3uS+nmDhvK4okmqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlvgW71gMZyoYwLJu/TDmo08cULwyvUfjDj/gGASIDxv+uN3W
	6rIs2NXfTHTHO3y/uRzOwJHdig5+vB8ZDWbxqUsQ+O4A2CTKnZuzt3umAyNSJXDE/h7g0l+/f05
	vz2XWN1HIOs3ioO/YfGGfEmzSxFYNY3YIk+EhjkOzCnAqC/Xf40BkttFU
X-Gm-Gg: ASbGnctoVWj/ZB7UmsQypyK59uxU7tgJK1WdZkDkQvXv5ETNgpVqNmzV5vay8+ZKD1Y
	wGmrLcAxI5JH+54u7K6Wzp9dbDwd6Nwo+/snwtFuFDb9Vev1xtS+yDTJvZkP7qYV/cn+x19YHLG
	GwujvT8Pkf+lORSEe2qRc8EfNWp2o68DuxLlQiXfc7TCqyzjGPK4O2YrJcs1mwurYw3IpgrfBGS
	Y2GGNCX7iK2vaWPynD6bKm7qRtSvn3vk4bInT09XxZ5QqUjsYoxX45tDwJLJ7KBPY2WdTUssShB
	1z4s
X-Google-Smtp-Source: AGHT+IE9gYYzPKMq/O39jU326Si2Akb33AeMLL8cubDSQ+2vBeBEBeXGI8bDW2mpHwgpdpq/zpV+YJvvgAelV0Pwp60=
X-Received: by 2002:ac8:7d86:0:b0:4ee:1d76:7341 with SMTP id
 d75a77b69052e-4ee5877ff3dmr253456321cf.0.1764130595900; Tue, 25 Nov 2025
 20:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126034601.236922-1-ssranevjti@gmail.com>
In-Reply-To: <20251126034601.236922-1-ssranevjti@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Nov 2025 20:16:25 -0800
X-Gm-Features: AWmQ_bmXarSOp81Ve-cbGptK6TBCaEvFMNlJhTrWzIKShnh1fEGLw1ykQvp60is
Message-ID: <CANn89iLiCh85_1Ah6O_rTOCGwLet97f7DyfyZMDgfTV==iUVUw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: em_canid: add length check before reading
 CAN ID
To: ssrane_b23@ee.vjti.ac.in
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 7:46=E2=80=AFPM <ssrane_b23@ee.vjti.ac.in> wrote:
>
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>
> Add a check to verify that the skb has at least sizeof(canid_t) bytes
> before reading the CAN ID from skb->data. This prevents reading
> uninitialized memory when processing malformed packets that don't
> contain a valid CAN frame.
>
> Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5d8269a1e099279152bc
> Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames acco=
rding to their identifiers")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
>  net/sched/em_canid.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> index 5337bc462755..a9b6cab70ff1 100644
> --- a/net/sched/em_canid.c
> +++ b/net/sched/em_canid.c
> @@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct t=
cf_ematch *m,
>         int i;
>         const struct can_filter *lp;
>
> +       if (skb->len < sizeof(canid_t))
> +               return 0;
> +

Please keep in mind that this test is not enough, even if it may
prevent a particular syzbot repro from triggering a bug.

Take a look at pskb_may_pull() for details.

