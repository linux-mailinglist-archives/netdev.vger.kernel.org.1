Return-Path: <netdev+bounces-171833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA821A4EED2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 21:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE381165760
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EDE263C91;
	Tue,  4 Mar 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCBaDqRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96C18C03B
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121643; cv=none; b=mEcIhpSaexKa8ve8dQCW3bGYodQpRxaj8UCGKChxQavZVfvbfwAVEjs2oNW+pryWV6d/G5ACOlFKfdGoLv9qW1lGA8pZpeFs4Lq1gpU+ndnb0kVZpa24G+pKd3JYh5lG9zK4w9jNQVP97GjD8cC3iACtp0qoJYN46/zH8YlFYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121643; c=relaxed/simple;
	bh=FzqTVeWp/Cg/RuBj5x4i6EKpXemv9e2dtqr6jX2kxy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNBKj98kAAzUlGbK64vIGTCv1jf7j/JI+1mSeMG7awAXuJZ8H43dsWONYOcdz5tU+hLtnZ2Titkvac9cMVlXt6rt2hvHPG7nxR7VCoD1EvtxFwyylKmp2kizE1PCQ1fOpaWf/fzpNu2JCzSQtXtluP3MrCXuniLcHLLnBp38kpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCBaDqRz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234bec7192so105491615ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 12:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741121640; x=1741726440; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WXf1B40hnslN0suBm9PvssBKUyI4BE+g4R93LCqj69A=;
        b=PCBaDqRzBygq5QaQmb17XVH4F2l3AILWqPoxLxjRDBD4cFWwbiTWCrQk7zQXP4Biip
         97G8Q4jIvEQG6I/ZonD9sxawEJNbadtpMSb0svlJkhM3SM20UKcpY4B71pRlEMeAXjbA
         ZKxfpsYeU2BdCxuPy7JxkMoa618YRPl3DspQ9TZEn9X6dNCO16LambbAg+1qqEwBXHyw
         QGPLFQW7sCw2SXIRqnSCDme1NpSP2JHSWzbQ1hLApDr4b/4+PDl4BJMS5MMNMSzvpWIg
         a93XsvQGOPjWlGJM8rmlq7DLcYAUmJ88HTRWTwBOu8JG4QpLPjVbBGAAO3gMgQZyqrgQ
         mtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121640; x=1741726440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXf1B40hnslN0suBm9PvssBKUyI4BE+g4R93LCqj69A=;
        b=qsF3EDPhV+6At2iSA2r3XhNtnWMZg5w5vhkQSJWdNgLDTtfXI1kYBbDzyasKYrvvpA
         VoV9EBP72ajo9sG/iLWvXXiCL2L7M6Gv78Daoy09M69YytC/WSRifAeRDaLZjvssf2if
         TYJoMxzWBRuZyfGI7G99dACcFOWfpR5yBmeh3RY/B3CCntmYqM3knKcVkhQELNNVAd3V
         gb9EzD0WGg9oWdTQvUTbLgAJ3JbGCoiw9/4hHEYPnZOCYh1DJb+zWu4F7iQa6wwijc4S
         qMgOYbKtJiAusWrb0I+TW42vvXR28sEWmTS0FrfRKgim4j+YW+/8xHloXsbLKJPBKzW0
         /G4g==
X-Forwarded-Encrypted: i=1; AJvYcCVsF2Ybv2WW8vx/hqmaeo+POBdKplOZw+gz6L7RDWZk4Hq1n7T9ZwApTdQie5CKILIgFZYdlzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1x5tZYT0J8kDZ/qiAuwHsvB9njL56LqpclK7UEFpRH8P3GrW
	R9hukd2P1ppL7w45ZXwAtXnUsdyy0xLzEogglaJ5YMQmXRPdqcz1
X-Gm-Gg: ASbGncsp8AZ7pPPdy8sYByb6umrAOtd9c0NP+FMWWf3cH6fhp+tmhHHyzjQadR0RUSF
	Jd7VBW0xEJKYTVfbekrsuj6+cXvSubJC1AKvl3imag5zI94iL+kPZwkgoWO0A7G+r0Jh8CZ7SfZ
	OfAJCljpc/vlp4zj6TBsADpHjhrlCdeavd60H9cjc4XeATNEZvLnR2RZ6hwYJDNvg/gF/uGfFpi
	AY+dwwiosQORZIpfrBEZXJVmrWL65LeUwyAkKG3OqXyqvIqE2arFvdNbPvmXYKxD+FKH4p8gyqS
	EOWndl/RaUwDpld2iO/Mf7Jp21xzXcqTOsuXT4/ZFfizjmDf
X-Google-Smtp-Source: AGHT+IG/HxjkvY/G8v4dXpccED2Oqcxxt+qgO7EA2/KqNXyRjWvFRi5Hosj2h2cRRi/AKdj6jcPPtQ==
X-Received: by 2002:a17:903:3b47:b0:223:58ea:6fdf with SMTP id d9443c01a7336-223f1c9825amr8487705ad.28.1741121640467;
        Tue, 04 Mar 2025 12:54:00 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504db7b1sm99963925ad.165.2025.03.04.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:53:59 -0800 (PST)
Date: Tue, 4 Mar 2025 12:53:58 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Jiri Pirko <jiri@resnulli.us>,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v10 03/14] net: sched: wrap doit/dumpit methods
Message-ID: <Z8doZoKNLQQYXYuf@pop-os.localdomain>
References: <20250302000901.2729164-1-sdf@fomichev.me>
 <20250302000901.2729164-4-sdf@fomichev.me>
 <CAM0EoM=jOWv+xmDx_+=_Cq2t5S731b3uny=DWrVX4nba3yjv7w@mail.gmail.com>
 <Z8XL3T8sOM43BnEc@mini-arch>
 <CAM0EoMkw=3SvEDyzyjM3zY60nGTDMdfXYp0Hz43YfVThfmqyTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkw=3SvEDyzyjM3zY60nGTDMdfXYp0Hz43YfVThfmqyTw@mail.gmail.com>

On Tue, Mar 04, 2025 at 11:43:17AM -0500, Jamal Hadi Salim wrote:
> On Mon, Mar 3, 2025 at 10:33 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 03/02, Jamal Hadi Salim wrote:
> > > On Sat, Mar 1, 2025 at 7:09 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > In preparation for grabbing netdev instance lock around qdisc
> > > > operations, introduce tc_xxx wrappers that lookup netdev
> > > > and call respective __tc_xxx helper to do the actual work.
> > > > No functional changes.
> > > >
> > > > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > > > Cc: Jiri Pirko <jiri@resnulli.us>
> > > > Cc: Saeed Mahameed <saeed@kernel.org>
> > > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > ---
> > > >  net/sched/sch_api.c | 190 ++++++++++++++++++++++++++++----------------
> > > >  1 file changed, 122 insertions(+), 68 deletions(-)
> > > >
> > > > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > > > index e3e91cf867eb..e0be3af4daa9 100644
> > > > --- a/net/sched/sch_api.c
> > > > +++ b/net/sched/sch_api.c
> > > > @@ -1505,27 +1505,18 @@ const struct nla_policy rtm_tca_policy[TCA_MAX + 1] = {
> > > >   * Delete/get qdisc.
> > > >   */
> > > >
> > > [..]
> > > > +static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
> > > > +                          struct netlink_ext_ack *extack)
> > > > +{
> > > > +       struct net *net = sock_net(skb->sk);
> > > > +       struct tcmsg *tcm = nlmsg_data(n);
> > > > +       struct nlattr *tca[TCA_MAX + 1];
> > > > +       struct net_device *dev;
> > > > +       bool replay;
> > > > +       int err;
> > > > +
> > > > +replay:
> > >
> > > For 1-1 mapping to original code, the line:
> > > struct tcmsg *tcm = nlmsg_data(n);
> > >
> > > Should move below the replay goto..
> >
> > Since nlmsg_data is just doing pointer arithmetics and the (pointer) argument
> > doesn't change I was assuming it's ok to reshuffle to make
> > tc_get_qdisc and tc_modify_qdisc look more consistent. LMK if you
> > disagree, happy to move them back.
> >
> 
> TBH, I never understood why we had to reinit for the netlink messaging
> per that comment: /* Reinit, just in case something touches this. */
> I dont think anything will change that netlink message, but who knows
> there could be some niche case.

As long as all TDC tests pass, we can keep the patch as it is. Now you
can see why I have been pushing people to add TDC tests, they are a
warranty of safety for code refactoring like this one. :)

Thanks.

