Return-Path: <netdev+bounces-174482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0B4A5EF3B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5615F7A48A0
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C4262D27;
	Thu, 13 Mar 2025 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVMfEwgR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852E262D35
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857071; cv=none; b=q0l8Ewx0AxCSgswg1Ui0NeqntgZ3hiKqXyY/uhZba1Onul3wK2MVLV5jQuH9/DW7WGNJQ4wgZg5wDJ+3h7hewhKmcK5s0VsJQypHSGJaC5ww38ECI6IL5mcfN7YBB1RFa8zw1JAyrZe4J58HQcSgUYdX+bVpD+m8PdcY6bdd/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857071; c=relaxed/simple;
	bh=hHTtVVVjlDwnTveF9sKgN1N1gZvwhPSWdzApIm+Lqjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Prcycw7aeVX8qwoemyu8YTDNRaOFfhJYKK8JxhkJS3IRmi34Cmx4WUymlIlVunMBNdwxuUcICuTwREIDDWV0hWRPXA7hHkFEQk3s6q85uXcQIuHKAdCB6XjxvRxv5YjWYiYaOe6TT1zmoH+Ot9dNmQL9cqVhEbJxqgrRZsEkHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVMfEwgR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22355618fd9so13308915ad.3
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741857069; x=1742461869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RMkutBc6FSdgj2PKXJt1fdPy1T4qLZY307/RaQTLyPY=;
        b=OVMfEwgR7EKyU9dOsBECn/IDZTC+Vmt6nMxS8mHwyZ0t+CQRetnl/oQF43wQzE3US/
         2qXllGVpbygrbmBjklvjZQXZyWU+ZcLknQXVg0wRNJ9Zs/JdnO5AFRLn14Kb2cEj9Mub
         JP5bJXDsiSnwPay1pdz3P9HGvbtMJbI+XvKDrrRbr/KxM8RUp6WmXclOT4dsIwaXxsaA
         RyoxU2lKvNdoEoH0B1guv1jbQxrY6r/DkEfcCWSAc26AKhYi8EwET1O422LgIk4FVTbr
         IMCzfbOd6YX67/hbqEqRBviVcDH4iE/RL+Laf5QD4wLd/bNdqbT+c41XQPcIpbP2NKwR
         2NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857069; x=1742461869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMkutBc6FSdgj2PKXJt1fdPy1T4qLZY307/RaQTLyPY=;
        b=n3afoszWO63DSAOfJi9/DZBOtxTFjP9hgPcTfJtbvsCL10uZp/f84LovjjXtKMF9D0
         PW4owjFpxfdrqKura3PhGnXUgH9zGyF32Sm0fyncSy8Kf938E6LKB8b4+g5wQ8J2G/X5
         OFJHcTYmce6BLUZ4A7GMqhvJBzLpmeffGjT8aeNLtW3QLg5Hxv9bGQpkl5JrISu85VYA
         rXVHnsBtK2TtBVaDVYxcbDWUUTDkef/6d7+TimQ23hb+v3xSjcHfgVHFsGsjx1h0dQBV
         P83yQO73+TsYbJIG2WM0K4YJqW5Bij9XpBnbGVIiCFlmZuKCnlRX2oYQ1CClByUCWTA8
         pmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHB06UmI/oIFDBKllgmywgBGF4kLl7JOOw32MRxSJ5Qdy8ykby5RT4XfI38k9gaZ+G3mU3uGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1xPjjpIknPk9MttzlEIsQqC+Ili6JcPaB3LnWWvfelCudhZp
	y7gcLHP/sle1cxqnoINlAoKHt+2jL+IGAexYZeBPimKWVQmE7Pk=
X-Gm-Gg: ASbGncsF1GRz4vuTc7OkGq23X28ZQqpS5cKsc+4nYdFOFe7WULh+SDAeUQdC3D8IujK
	DepL2RfNVQlpmSW0h7IUO+Jvsk6AqLltP5yENh1jBjajZETVmUOGPtHHMVc5OV2mTkOi7Fh8qnA
	9kaaNeX3J6drEKNBoUxrA+Z33sXujMJaXnxjDe23E7lrwEi9/CBn+udOLeL71umBzkfL7h2pyFL
	3WZxxOJVQaNwqnpOyLE9b3CfQDGAXqgAaPRxVQKSDMMrtk3JQGY7kpA1O+QQmEgyxJ7AQtj6sTO
	LthuVV7Nc7chWCPrKzeMz6zZT+8QLH8R6Kcx11WvcgRa
X-Google-Smtp-Source: AGHT+IGR50tIbHw7zXUWYOQ82ZtkTlSuQxHCfVHudLOpl6J0i7zlCUp20nAvz30r92D7TM8/U96IIA==
X-Received: by 2002:a17:903:244c:b0:223:2630:6b82 with SMTP id d9443c01a7336-22592e207e9mr161094945ad.10.1741857068873;
        Thu, 13 Mar 2025 02:11:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68883f2sm8867695ad.7.2025.03.13.02.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:11:08 -0700 (PDT)
Date: Thu, 13 Mar 2025 02:11:07 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
Message-ID: <Z9KhK_M7IinJu8Ih@mini-arch>
References: <20250305163732.2766420-1-sdf@fomichev.me>
 <20250305163732.2766420-5-sdf@fomichev.me>
 <CANn89i+4F1f2FSUxmxP=qqir0z_3ZDNpQoqkE3X7bwp81U3sCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+4F1f2FSUxmxP=qqir0z_3ZDNpQoqkE3X7bwp81U3sCw@mail.gmail.com>

On 03/13, Eric Dumazet wrote:
> On Wed, Mar 5, 2025 at 5:37 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Qdisc operations that can lead to ndo_setup_tc might need
> > to have an instance lock. Add netdev_lock_ops/netdev_unlock_ops
> > invocations for all psched_rtnl_msg_handlers operations.
> >
> > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > Cc: Jiri Pirko <jiri@resnulli.us>
> > Cc: Saeed Mahameed <saeed@kernel.org>
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  net/sched/sch_api.c | 28 ++++++++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index 21940f3ae66f..f5101c2ffc66 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1279,9 +1279,11 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
> >                          * We replay the request because the device may
> >                          * go away in the mean time.
> >                          */
> > +                       netdev_unlock_ops(dev);
> >                         rtnl_unlock();
> >                         request_module(NET_SCH_ALIAS_PREFIX "%s", name);
> >                         rtnl_lock();
> 
> Oops, dev might have disappeared.
> 
> As explained a few lines above in the comment :
> 
> /* We dropped the RTNL semaphore in order to
> * perform the module load.  So, even if we
> * succeeded in loading the module we have to
> * tell the caller to replay the request.  We
> * indicate this using -EAGAIN.
> * We replay the request because the device may
> * go away in the mean time.
> */
> 
> 
> 
> > +                       netdev_lock_ops(dev);
> 
> So this might trigger an UAF.

Oh, good catch, let me try to add more logic here to be more careful
on the replay path. We can make the caller not unlock the instance lock
in this case I think..

