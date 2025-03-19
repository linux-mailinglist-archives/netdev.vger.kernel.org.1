Return-Path: <netdev+bounces-176258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6747DA69877
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C503A9D44
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639620AF62;
	Wed, 19 Mar 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqa6vZWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9D849C;
	Wed, 19 Mar 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410542; cv=none; b=R0fDQ9JwexNQxYxtI+gKYMipmKDg9bGrTt618MH46X1Aa2brPXUygDz8NWWJQYmbnHaJ5pcAFKCr3EFjxiIGTIzbCtXGeogFnEmbXd0LBIyHh/KTIC3eccsn5p1UF2EzcEyua4AiIktvsWDq+pGciyyCzbXz+dEvHFtfr/auBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410542; c=relaxed/simple;
	bh=UNdnEV0xpGkOhgtH9ofYHM2M12o1aR9Yti6daBU62+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUOLEFNP+8sEBKyG3atNylQb+IDJG5mK/NIGopStUf5cr03qs6TdaSMnDlnMb/ewFVZ1vRdAhN1NglXTeXmLoVjyjhfQfQLME7h3dAuf9cTj4mj5gLVjnsbQkf/YpjoS0OYmouLRfyuqw7oriKXyfQyKnu5M2Q34VzwH2Bd68b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqa6vZWY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3014ae35534so6400a91.0;
        Wed, 19 Mar 2025 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742410540; x=1743015340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/ZzHRFe5mhkMgibHOeAMw4Kk8QYHHqmXoFtnRim8CI=;
        b=Gqa6vZWYRDBB/MkUAlQzRe3A2cndqZUej0McWhqL1nUNH1f21u9X4BnUgZYWXsmoKV
         qtDDVFfFJM+KUwaqcW6U5UfUzeMj4ETN9i3NRTn3ISDXRw8MMhVUSX5z5MOuelrdnI31
         1NSCG5I7eKiiL7IYQU3RoHpD8kUOZ//MkuNLvHEVqD8C+sHEO2YpxhsIeQWDT5EsfLnu
         AMbfOA0MSD8QiuR4ugVGRj7W/U8WFbRvEq8CWqeugXy3os1zvQZNSDm3ToicqcS8gihs
         pni+U7MwGQ3wjxfl13VVmLDAVwD1bQ8RQFS/WKlkC3PcZzejGT/zLkM45gFmDMxgE5TD
         67+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742410540; x=1743015340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/ZzHRFe5mhkMgibHOeAMw4Kk8QYHHqmXoFtnRim8CI=;
        b=VftuLNoo0CpiesRfACMeb86vsB/4QAqGXlgvU6Pz/HUhIvvC5gsChMC40MRVLH4arU
         BQ+3RnxLxhOSAGfgtJod/xQNwDl3d9C8wqg9OC/WSsLxazMQ9lRfdNqq2gcgmDKcoVah
         KZfVzGdC2ldTdT6fYml5Jz4mfotiL2Dz1vNea4gUea5Aue09kVgsfelCtQQ4eRoqzzra
         lcButGSLVtR/R4BbaV+32Zy5+D0zMt2H7gKzl7ob4QUPlIqrnRxv5nx33MhFk9N9hqKm
         A3x4aAIvPlKqAotB+LL3LpdbGUD7oi1FzzzqySYYmbtFzKY8mTZx7piXnzp/y5ypFj/O
         QyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV3+rMNng9Tg2LCd7D6YXPGi6nPOOn+t4zgi2ebHrbkUB5QPjX0HKW9wZ66BlyPsJrVuKtBVQf@vger.kernel.org, AJvYcCXrQRGDTVPr6aX1kNrNH4ZYPbjJzrHY2wvDhhQioQhGfg/SM0NKcb9WU1U05roLGNkyDlqFpWVSamj8O1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBf0A+qOCu3DTLmGNBhQcVt6cxtJBo0uj2kjxFwhOK0hQcXGVF
	+ZG2zt2MaqClPlA9B6ZEo9ypGdEkjGRkFsmKYhPczGDPMPGeDSxymtB7
X-Gm-Gg: ASbGnct0UQhlbOQEABNxEM8BSU5NJAp4/5yb4mVoe8jPR6QpDBQv32UFSFsyEJtQgws
	hlcivoS8XHv7Qk84i99i/aYNfk4d9ktjH6zQwS3CTGoRRr9GnN3okXpcg6wQ1nETZx7KZl/DIdy
	Jw8ku2RmjAmbWiP3FEdqL2bkSFaxYH5+jC0YjeUzYzh+JWpUvsBRbAQKYM8uKWs1TQIatiiqYTx
	4cXvoSlK4dPuEArSVgh85qZLluZCZ5yXDxIpeJjA1Oy/BRFo+K5Wydg68dNcuUB65gvUp8rvZHM
	SRQt+vSXAc3TaR7ulHamw8U94CqeR1WnAye9oWMJJLFm
X-Google-Smtp-Source: AGHT+IEk5rKiOVsrCKR6nFXBjRfntM7wDYy2IKaoeTley+sia16+/Yu7OKzs0zyxPISH6J504cUCUA==
X-Received: by 2002:a17:90b:2f44:b0:2f9:d9fe:e72e with SMTP id 98e67ed59e1d1-301bdf91cc2mr6802113a91.16.1742410539963;
        Wed, 19 Mar 2025 11:55:39 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301bf61a48fsm2006625a91.33.2025.03.19.11.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:55:39 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:55:38 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH net-next] net: don't relock netdev when on qdisc_create
 replay
Message-ID: <Z9sTKsiDkpqt-jjo@mini-arch>
References: <20250313100407.2285897-1-sdf@fomichev.me>
 <20250318151624.GC688833@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318151624.GC688833@kernel.org>

On 03/18, Simon Horman wrote:
> On Thu, Mar 13, 2025 at 03:04:07AM -0700, Stanislav Fomichev wrote:
> > Eric reports that by the time we call netdev_lock_ops after
> > rtnl_unlock/rtnl_lock, the dev might point to an invalid device.
> > Don't relock the device after request_module and don't try
> > to unlock it in the caller (tc_modify_qdisc) in case of replay.
> > 
> > Fixes: a0527ee2df3f ("net: hold netdev instance lock during qdisc ndo_setup_tc")
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Link: https://lore.kernel.org/netdev/20250305163732.2766420-1-sdf@fomichev.me/T/#me8dfd778ea4c4463acab55644e3f9836bc608771
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  net/sched/sch_api.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index abace7665cfe..f1ec6ec0cf05 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1278,13 +1278,14 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
> >  			 * tell the caller to replay the request.  We
> >  			 * indicate this using -EAGAIN.
> >  			 * We replay the request because the device may
> > -			 * go away in the mean time.
> > +			 * go away in the mean time. Note that we also
> > +			 * don't relock the device because it might
> > +			 * be gone at this point.
> >  			 */
> >  			netdev_unlock_ops(dev);
> >  			rtnl_unlock();
> >  			request_module(NET_SCH_ALIAS_PREFIX "%s", name);
> >  			rtnl_lock();
> > -			netdev_lock_ops(dev);
> >  			ops = qdisc_lookup_ops(kind);
> >  			if (ops != NULL) {
> 
> Hi Stan,
> 
> I see that if this condition is met then the replay logic
> in the next hunk works as intended by this patch.
> 
> But what if this condition is not met?
> It seems to me that qdisc_create(), and thus __tc_modify_qdisc()
> will return with an unlocked device, but the replay logic
> won't take effect in tc_modify_qdisc().
> 
> Am I missing something?

Oh, yes, thanks for catching this. Let me think on how to handle the
-ENOENT as well..

---
pw-bot: cr

