Return-Path: <netdev+bounces-204268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1789AF9CD9
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 02:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6668A1C4773E
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 00:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246A33F9;
	Sat,  5 Jul 2025 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9rajuje"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A010E0;
	Sat,  5 Jul 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751673821; cv=none; b=Pp3tdXpnwbe+iO4zc6dBZkm7o64wJ/8qX5fIwIJc2yGjnogE7YeU3D+eQDn+fFAUufIeGaUp3GQ/Q26ix/HmTcqcIN5lDoddQG9Cp6uIR/U4eNXkK36xoRcun2O+FRJUXeGQrweHuJFctaDno8B/nzsiCJGzIxFtRE0mdvoPt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751673821; c=relaxed/simple;
	bh=fc2HeCj8S7/bC0C27mDYSzPdHbvGJD07pU7oIodB5m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW0Iequ8WDJr3aBtSoD0rs09t4BpYZFLC11sEaezcAFoA8zxH06x2OtsVP83+0cx6BKGwGQwA4rU+GFeZVABiSOPTJ6hcphruTHUo0DMaese7JjTJoxIn/4khQQrK6JU3WCcrEviTqQ8LROYB/g3uUwIOfOSujO3paPh/Jy7T8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9rajuje; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73c17c770a7so1802646b3a.2;
        Fri, 04 Jul 2025 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751673819; x=1752278619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2zJe7UIc4K7hUHwuWT+OfAK+G8q7OIxAC0g78/mEX4=;
        b=Q9rajujeuUQ0j9vCztpzLSi3d6uAArc2phrJflpgJ81trc+0WNOWgfpxlAn+OirTMs
         8n1IH7I8bBwa8Dq2h+ViLZ61PE54M5Pqh2nM5m1Y2h5ybv/Om9flEYKK5LJhryk3/+hw
         uRB2je/oYf7UWrx4c33e4aLdOWwnVPi5rbLk9ZQy8ly2zQT11u8bKWGUjJA6RtuPlZox
         0DcCIA2EVuMAO5HNcNLOLfhvlmvz3osnSG0falu7PtriKmCmgpFBDxgfG5K+q/P+EQ3b
         Kbwt8KzLnVYW5+HQb07ehlUtMUBovqSusJnc0DFFoNp6wvjTP6/lRIT3ncG3BQUFf766
         nXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751673820; x=1752278620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2zJe7UIc4K7hUHwuWT+OfAK+G8q7OIxAC0g78/mEX4=;
        b=BR+Bl5NK1Xblx4m6uCfzm+nDyS31m5Qsdm+Gnbr96lbbxm6kWXp8F0nXbj/hi42XyN
         7utyA4Up/ECn21yUYt7+MrfbDTQ5UjcVlJ7S+mqAhu1LWMMlU95vKBEsX455GAu4yE5/
         DBVdiHJUNbt54V9yDIKdbmQAObidTEtS+hFxvHwLI5zyHZt+9h60IZretYE6rzisHr++
         aPxch9EQWPH31BFe2egbh6e3oUtdXhEU2+apESb16lQcFfOmG3D2sYTi43f7a10M21UJ
         9eJCamqGSpQkhbFWb1oSfRTDXvP5NbZ/7+0sUM0TgDy/KSnAKA+ldC0M1YhBb5pw7P8a
         6NNA==
X-Forwarded-Encrypted: i=1; AJvYcCVI4AO8exFQJTwl4eKK+/0e7I3U43gYz6IJQDy1aDrwmS9wIP5+0lUCFJxqnCGt3BuRvGcj2anu@vger.kernel.org, AJvYcCWwZdPVSIvTE5CIAKqK3Gv6lC6OtJaihiEPQ9kavTIJNrkHbUNcz3B7psXOXcXDlKHNoI3ba1n6BLvoaBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9i2X3yXFA/PI74wZEA5CL5QlXtoj6ffFOlR8gdXmuTsUgkGgn
	P5YO1doa3soC6/9CK0urbN4SWLYkcS3iaXTeSVc5gzQ1VAI3lLIAZc9YzxAGGA==
X-Gm-Gg: ASbGncuuGRUNuW3ajlFhBmPgUeMplEBUous2obG9qYGzvZTA7xdbpC0EH4L/rPzyIIJ
	O/8RV3KtxPRakLV01B6ECBm30TFGU990OK3n9qFGuaYS92jQfxMgnsThejwqtlUxWZi4n17yx3y
	BHunEoJQFX5E1vdn2r6rpTC6YxWfxLjINqGBrXJqcrYTwCgJW0Ld9kmA3qsm6X5Y+d75WovNoOH
	UNTVCuGrw1Q4Z7RLaFYFvavn2TiCTYIYG1UBhmKnGSQCuKa/Yb0JWWn7CYOehFrBug2rXINKZ8X
	XBM9hVgjlKtjuq+KewhyYzjJXgCiNh79ouuObuor93wpYlERtVEEvv7+bJndCOjsEFSq
X-Google-Smtp-Source: AGHT+IEcbea5ZBSpxUSiZjb3AiPzERqxr4jb3dBYe9axwVAfIlOYvEulZyGw5jRZDcdF2I6M9WhhFQ==
X-Received: by 2002:a05:6a00:6f11:b0:74c:efae:ff6b with SMTP id d2e1a72fcca58-74cefaeffc7mr3211137b3a.7.1751673819578;
        Fri, 04 Jul 2025 17:03:39 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:4a21:dfa9:264b:9578])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42b8044sm3075291b3a.143.2025.07.04.17.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 17:03:38 -0700 (PDT)
Date: Fri, 4 Jul 2025 17:03:37 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
	Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH] net/sched: Prevent notify to parent who unsupport class
 ops
Message-ID: <aGhr2R3vkwBT/uiv@pop-os.localdomain>
References: <686764a5.a00a0220.c7b3.0013.GAE@google.com>
 <20250704080421.4046239-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704080421.4046239-1-lizhi.xu@windriver.com>

(Cc Victor)

On Fri, Jul 04, 2025 at 04:04:21PM +0800, Lizhi Xu wrote:
> If the parent qdisc does not support class operations then exit notify.
> 
> In addition, the validity of the cl value is judged before executing the
> notify. Similarly, the notify is exited when the address represented by
> its value is invalid.
> 
> Reported-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1261670bbdefc5485a06
> Tested-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Victor also posted a fix here:
https://lore.kernel.org/netdev/20250704163422.160424-1-victor@mojatatu.com/

I asked Victor there if we still need to patch
qdisc_tree_reduce_backlog().

> ---
>  net/sched/sch_api.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index d8a33486c51..53fd63af14d 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -803,12 +803,13 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>  			break;
>  		}
>  		cops = sch->ops->cl_ops;
> -		if (notify && cops->qlen_notify) {
> +		if (cops && notify && cops->qlen_notify) {

I think 'notify' should be tested first, as it was.

>  			/* Note that qlen_notify must be idempotent as it may get called
>  			 * multiple times.
>  			 */
>  			cl = cops->find(sch, parentid);
> -			cops->qlen_notify(sch, cl);
> +			if (virt_addr_valid(cl))

This is not how we test NULL or error pointers. Just "if (cl)" should
be sufficient for NULL case.

Thanks.

