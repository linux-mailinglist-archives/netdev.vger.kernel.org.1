Return-Path: <netdev+bounces-68474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A294D846FC1
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D651C2508B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCEB13E223;
	Fri,  2 Feb 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="th3orebV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291ED17C60
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875587; cv=none; b=jVtn/Ze1L0jFeqYjSI+JizHfFoVFwhZNOlEUSJVwLpfQcTCb/EfTuIrjikjlO/Jx5qsCdHqAaDEycpAU9mCgE4dnKX8fve+KAatIUkssJEklxXKqzCTwm85TAjWhhtbdxS4zarA9idUFjY4efPniRReuXtxntKaw0B/WfPuG0a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875587; c=relaxed/simple;
	bh=+jjYu1KPV2gY+aOmDkkFqJkHQcKgDotXU1Yp+JBmiJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmexI9U+74plsDFRinUfLtgFoH4JAQER11RCgPKAg01S10EMk5TflCyPHQ/dt7K0uI3VxYGAOLO7kKk3PE435zwcNPDY9l9S/Rtn7n//iIVce3yKoCU6kcpcdklE0rexL/vCg9BeeTwStrJNl/s+TR1gbMG+ItK/4x5bs+rG4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=th3orebV; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso1804487276.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706875585; x=1707480385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOcxIZqO4IqfJmSqGEdIgtFtjChFjymuVUxS/lQec88=;
        b=th3orebV9j9L30r/wQD/kRJ+T8uz97z/zLPh33nnqPdfGWzS1fym3CyxRNtrRKaARE
         ZWQ+9/WNECuwDiDAuEvMgD3azazFGUciDPgj1K3DYr8ar8BkJi+kAYv0zAOs2Cb8WO7h
         P1yVMfV0Fbs4LZyJlShqXMEbIbtIPHAGVADvA+Ynd5yKEwT+BPlbHsQ+HXNE6MxsVOxl
         ldznLMLRG8d+pASLOrQCWsJ3FBmB25eG1/Eu6hn6iehZxqobc3J8AekeYG999eAvN7sq
         jX+7dklzkN/GOxWTpm1AifYshnu6Rj9PASbuhkyga143F0YKGbp1n6E/L+CyWkX0T30B
         K8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875585; x=1707480385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOcxIZqO4IqfJmSqGEdIgtFtjChFjymuVUxS/lQec88=;
        b=PAF0XWTMWUVY9o01EUvHZtl4l0dMBfSKjFFc8SQchHYxZupfpz0A1Ubnd6DTLhoL4E
         HVHX3OI8fzVQSQvLYbEho8JIW4UjxCxL/51tCX0YcPm2HC34H+biv6IosInNCX16A/50
         5Ub4N1EMpGr3BYM8dJpbU8BUm1jyUPp484bGzZFqB1Obkcg1oVJBixaR6l2gF50svjdM
         pppNtHHI7XdNIVLQS/iLy3/B6czn/KPnRQq3ntwSeFpIEjNeuEAG05xxTkrAFQAD8xF+
         9eo/7sQBPgpXev2p1D39cxUn6WekZJyJG2w2RI8MHsI+k/qWjN0JZyJLekTVx+UlxpEv
         UbUA==
X-Gm-Message-State: AOJu0YzVJTQNpfhioMKeuH147Eez/aAeVAO8XdNukxczZ0iqnzOuRzkx
	iQmX5Dm9jmqVP/6gp8QG8fwGO0ZPsRKYSBYSx5ZSp1XaRtNnSpq5PPfOoxN4AMRazUQJcxyM2cg
	OFY0hagcYFGbMwXQfRbNV5xmTQzI9LrlCl9MqIAydc0FcLdA=
X-Google-Smtp-Source: AGHT+IHoWeN3jttcPjwh+OPSpjvodC6/9rP2EWpkqV7rIlLo6L3yt+/be0CLaH/oMoxdru8C9iqcyf1oeiLpRcBoEdw=
X-Received: by 2002:a25:b602:0:b0:dbe:9e31:35f6 with SMTP id
 r2-20020a25b602000000b00dbe9e3135f6mr7176994ybj.59.1706875585221; Fri, 02 Feb
 2024 04:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-6-jhs@mojatatu.com>
 <CALnP8ZYtVXHbnvESkZpcVwpJAVJWe9NP1EtPQOzTKD3WUnqO3g@mail.gmail.com>
In-Reply-To: <CALnP8ZYtVXHbnvESkZpcVwpJAVJWe9NP1EtPQOzTKD3WUnqO3g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 2 Feb 2024 07:06:14 -0500
Message-ID: <CAM0EoM=OMO8O_4ge2gmQ5kMDnr9kWOHxm-tWtrKqksFMA=E61A@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 05/15] net: sched: act_api: Add support for
 preallocated P4 action instances
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:07=E2=80=AFPM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Mon, Jan 22, 2024 at 02:47:51PM -0500, Jamal Hadi Salim wrote:
> > $ tc -j actions ls action myprog/send_nh | jq .
> >
> > [
> >   {
> >     "total acts": 1
> ...
> >         "not_in_hw": true
>
> For a moment I was like "hmm, this is going to get tricky. Some times
> space, sometimes _", but this is not introduced by this patch.

Yes, unfortunately that is baked in into the actions code in iproute2.
Would have been nice to say
"in h/w": false

cheers,
jamal
>
> Reviewd-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>

