Return-Path: <netdev+bounces-215210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBC7B2DA4A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7486C16AE92
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5C21C3F0C;
	Wed, 20 Aug 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Co8OJWgA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50DE17A316
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686766; cv=none; b=KcpIStHbsiFvzI41uvn/30gSbdc95G/9d//NYtOvTdrujYCygC9vogC6jouN+3OL1Eegf6q90EkIOXLzwi22OxtIFJ5pRf+6/bCVAGkNq3jQYcgnupAMKiyYi/4QOg8PfE+FpDhg9gcEgSPs+xBREW1dHWfBtArzXxquNJ3R4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686766; c=relaxed/simple;
	bh=3Me8tP3A/Dq4n2o7fv0IO64KsodsWLaH93wYg8ejh9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS+K6svoTVWIGK05E4LoEdJct+S/30h4uhiaGneWhorEB8ga2YlGQyzarL4iTSb/mdeWtfR0WhP4TjqEtec6h94QSUolfwY8cuaohfmdQlk1DVwh5raOEEGgtOPq5fBwH4kCRMBDBESFl/pWIDzGycKjWCOjyZ4WE+UzpEAaS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Co8OJWgA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1427696a12.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 03:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755686764; x=1756291564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Me8tP3A/Dq4n2o7fv0IO64KsodsWLaH93wYg8ejh9A=;
        b=Co8OJWgAcDrYJ0CyrTpBTa4QFaWJA/UXQ60iKWZvaB+48GWb7YDZkuqYINSGkm0uIh
         ZYXB/1/0Tox4yTgl7PAOB5auKESusYPvX7nPMjjVhmW52s1AVNACCbtT13QaRXH38FhC
         xZYMsIUNP3rnX9lupsBneDOUUij6WTTuNR0vjOk3bTlCFKHfKLLo4Se+Zk0Az2jZPKYZ
         89qwkceSJ63MV0U52UZGugtikzmhBleYxT5X46BJ95PXkC5HrytFkEEuhgi1L6/2wsWk
         8Ax1EW8XLAMY2muWjJvXyU5aW83Oo3g47JQIHVj+U42VncmORoQQi0GFxmFGkSvAvwok
         JpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755686764; x=1756291564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Me8tP3A/Dq4n2o7fv0IO64KsodsWLaH93wYg8ejh9A=;
        b=DWj5OE13MYQV6m9zXYXShaUmcl/CKtjMe4WqE8r0qqSSEH2JBHGc22wZADG0Pb/NH4
         UGnkjmmXhibOoFdU3yBVbrJ89Ms2I/FN8WpxUz+o3lmxQdv0+Kc0SuW4V2R3el7Mfn2x
         M2rlhiYThSjKUunCA8pYBxGyYvcdOZrkh79Lg6KUgrOnjozE/Quixq9kOkjzHUuuZLnM
         a9I45VKawMUKQkdPzt7X2XHknqpUMx+hZYtXP4Bnn5R5Faql34wzGolIE4aDbns3oNi7
         IW6/rZrEp7itfmRRyFm//5ivuot6qHcNbiCfqzAP2CmJIaZxM8wOWsWgHPO/f4IE0jTT
         BwEA==
X-Forwarded-Encrypted: i=1; AJvYcCWz3QfLziNi+opfch15BF92MyEBABpwTCtiy0mZoyFNpddXSdZE8ko9dFFh5AqTfvMD4Wru7p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJidN5b6WAQujJN1AAWznEQ8LuJNCEurgaGPyYlPAidQVusuL
	8kO1rJ2DxkPQ32YaGdFr48GXDSHW1Th9ZUrLHb56y4MU+TqPdnisD4jwcGt7JY0qWxcN5txlO8A
	xXEJHViXE72tU18PFnaz6ZwSrr5ttiMJC7JEB0LV0
X-Gm-Gg: ASbGncvDHJf3SbS0JbpGfTHQBxyPyWIBHt+bQWJaYZuNbuu/EevM9tqf0DbL0L3NFIT
	PW4vqVgBYioqdMBu2xl6hbAy8VNBUB4SJIsfG9tCS35BHgVlZzdcMbwJHJlgrph2WsiLXVw1gzv
	oD5BsOX18kj8iOq5XfNq29Kz/r2r+tOZopRVnEpXF1gXWlyzKFbGQToOIpgXm0Wk5gn+hwgHvdC
	kn9cIPKK5hP7yGoXZgkIwhcSV5/nIK5FnqosxrBodNcEQt8rDm5Q2s=
X-Google-Smtp-Source: AGHT+IEKtl2lrK5/2y4ZHW8BdiMqTimWqMJrLgdgwZdhWnnQOIhxftCfwBi0pC/VAlu+Wj78IDSFaxfyMArkbO0q10c=
X-Received: by 2002:a17:902:cecc:b0:23f:e2e0:f89b with SMTP id
 d9443c01a7336-245ef0bf919mr29929205ad.3.1755686763672; Wed, 20 Aug 2025
 03:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818154032.3173645-1-sdf@fomichev.me> <68a49b30.050a0220.e29e5.00c8.GAE@google.com>
 <20250819175842.7edaf8a5@kernel.org>
In-Reply-To: <20250819175842.7edaf8a5@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 20 Aug 2025 12:45:52 +0200
X-Gm-Features: Ac12FXzOW9XPurRHcsWYD8YIbcfeKfyX5uwi588A3HEp9L6p1uEzyk061ngsuoE
Message-ID: <CANp29Y4g6kzpsjis4=rUjhfg=BPMiR9Jk68z=NT0MeDyJS7CaQ@mail.gmail.com>
Subject: Re: [syzbot ci] Re: net: Convert to skb_dstref_steal and skb_dstref_restore
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot ci <syzbot+ci77a5caa9fce14315@syzkaller.appspotmail.com>, 
	abhishektamboli9@gmail.com, andrew@lunn.ch, ayush.sawal@chelsio.com, 
	coreteam@netfilter.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, fw@strlen.de, gregkh@linuxfoundation.org, 
	herbert@gondor.apana.org.au, horms@kernel.org, kadlec@netfilter.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, mhal@rbox.co, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, sdf@fomichev.me, steffen.klassert@secunet.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Thanks for the heads-up!
I didn't even think that this tag could pose problems for other
automatic tools :)

On Wed, Aug 20, 2025 at 2:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 19 Aug 2025 08:41:36 -0700 syzbot ci wrote:
> > syzbot ci has tested the following series
> >
> > [v2] net: Convert to skb_dstref_steal and skb_dstref_restore
> > https://lore.kernel.org/all/20250818154032.3173645-1-sdf@fomichev.me
> > * [PATCH net-next v2 1/7] net: Add skb_dstref_steal and skb_dstref_rest=
ore
> > * [PATCH net-next v2 2/7] xfrm: Switch to skb_dstref_steal to clear dst=
_entry
> > * [PATCH net-next v2 3/7] netfilter: Switch to skb_dstref_steal to clea=
r dst_entry
> > * [PATCH net-next v2 4/7] net: Switch to skb_dstref_steal/skb_dstref_re=
store for ip_route_input callers
> > * [PATCH net-next v2 5/7] staging: octeon: Convert to skb_dst_drop
> > * [PATCH net-next v2 6/7] chtls: Convert to skb_dst_reset
> > * [PATCH net-next v2 7/7] net: Add skb_dst_check_unset
>
> > ***
> >
> > If these findings have caused you to resend the series or submit a
> > separate fix, please add the following tag to your commit message:
> > Tested-by: syzbot@syzkaller.appspotmail.com
>
> Hi Aleksandr!
>
> Could we do something about this Tested-by: tag?
> Since the syzbot CI reports are sent in reply to a series patchwork and
> other tooling will think that syzbot is sending it's Tested-by tag for
> this series.
>
> In some cases we know that the issues found are unrelated, or rather
> expect them to be fixed separately.

FWIW if you notice the reported issues that are completely unrelated,
please let me know.

>
> Could we perhaps indent the tag with a couple of spaces? Not 100% sure
> but I _think_ most tools will match the tags only from start of line.

Sure, that sounds like a very simple solution.
I've adjusted the email template - now there are several leading
whitespaces on the tag line. I hope it will help (otherwise we'll see
what else can be done).

--=20
Aleksandr

