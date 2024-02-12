Return-Path: <netdev+bounces-70976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC2D85170A
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F377F281422
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21AB1426C;
	Mon, 12 Feb 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="r9U9a1Pw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20B12E52
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748250; cv=none; b=qOtyuc1eOzHXNYdQAAB0ow8M+YXtLDf3FJUBoZ17/okKwrw/hakLpOaos1YpQsl0E5Uz3A81p60KDmhq5o49nDMiGHmJd2YE6eS2QEf5m5tV1sEwylTNGngytOnqLG07at43f6gTaS11GoE4oWZetZDW9VRScunc/fiMmqDc82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748250; c=relaxed/simple;
	bh=p9vOfnePUV1vkqui1jKfajElpdn9UJuYx8Lvstoz6CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6OnI8AZ1/meanaOmAaHh2cYOX2S8l1KwLsRzdi+xA6SCmu+N4fHR9YIlqygt6hMUg4y5EgQefyLu4H2i3c7bOVirx77ZORE5dlFKWTKE492EjgOvaWa2+klV3sDzRzfGFXiOuSHI+Yd7evIIC+wtLlPR73W4gcqNFggqxdxvk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=r9U9a1Pw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60777bcfed2so1558847b3.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707748248; x=1708353048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHfkimgnQqa9pmxY7xUwBKCcRRo2tt3mrL+Jov7rDrk=;
        b=r9U9a1Pw73I69igyrW9NlH78GGf5gDZmZKKgnw6XWrNLiiMNqaSQNDy2QC3h5P4Uxb
         VXqfE21VeNRMcrQHYMqOX5RWlU+3x/z7FJcnusOiRxIu7Bfu/mC4iaNWEqhWgI1Phgzn
         jDFGH0Spl0dfM6R5TN8d24wMLyotgqvfYhJHUqSCk3flNzMrKKA/qyuJGC7YfGcUAqbT
         l29o75QeuEFg7vPZ/amcg+3Pa0gVnoYAcQcCJfpQqclhv0qbTTwTgLHvtdE4UGY2yKcu
         +iW/SXgG2Eu9eLRRX8mWus1wVk84QVuMClHzK6tKVUKyuIDflG5WZp18Z7LXHa69UZ5n
         WCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748248; x=1708353048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHfkimgnQqa9pmxY7xUwBKCcRRo2tt3mrL+Jov7rDrk=;
        b=KkDiWLen6A1wC2/kJihy7dA6ffGMYvFaM6YUD/P4sgA9UWj/GHhUlZyeCEL+oGub+S
         BoS32JBG+BI3chqFBxcX5k/ahRidTHBBXhe95E8NjcquMW+LTjE0IuJekjfr+XYhNTCD
         pxD0qdY93/APSqizdLm/k/x1+mPeRXG2kvXh+Mc5KgZN0al0T7YePgl87hcrYHICfKY1
         jCPsC2lHlrEYGoKwg2pkHdaSZxxdWNJAdkKmb1k24sVD47xeav6XTuBvKzIiAFpvRZna
         V3ju7KHArMt1UZcRXF2StyQVa9nv53WPs8m2b7+53A0LKWHMiDRkr3h/ahsjQO9QVPLm
         dXtw==
X-Gm-Message-State: AOJu0YwuNLeWA5xUsGQg1BeuJe8uGydRkjoeYPSkCQXj5uBUd3shE2HL
	hQhHVlREB6JP19Ft5xP/sJsN1V+7l+vNX+5zA/L3VPsFhbxLC9TMxWjnRKcRzkVIMzYLOxexGXp
	WkRRk7IpjIq8g0LQzcPrtBMthC5OGyKkckIVF
X-Google-Smtp-Source: AGHT+IGgkXOeWFRC0kD8AvUJh5gqRcJZ7vXLyuTDLZrRPmueX7K9FwVydl54BFjd7DYsYX8pFLa/WxHERXEmf4eoHgk=
X-Received: by 2002:a0d:dc07:0:b0:604:92e0:c76f with SMTP id
 f7-20020a0ddc07000000b0060492e0c76fmr6197823ywe.30.1707748248046; Mon, 12 Feb
 2024 06:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-9-jhs@mojatatu.com>
 <CALnP8ZZAjsnp=_NhqV6XZ5EaAO-ZKOc=18aHXnRGJvvZQ_0ePg@mail.gmail.com>
In-Reply-To: <CALnP8ZZAjsnp=_NhqV6XZ5EaAO-ZKOc=18aHXnRGJvvZQ_0ePg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 12 Feb 2024 09:30:36 -0500
Message-ID: <CAM0EoM=CKAGm=qi0pxAvJBOR0aQyHDR4OkBsfyg+DcaQqOUD6g@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 08/15] p4tc: add template pipeline create,
 get, update, delete
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:44=E2=80=AFPM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Mon, Jan 22, 2024 at 02:47:54PM -0500, Jamal Hadi Salim wrote:
> > @@ -39,6 +55,27 @@ struct p4tc_template_ops {
> >  struct p4tc_template_common {
> >       char                     name[P4TC_TMPL_NAMSZ];
> >       struct p4tc_template_ops *ops;
> > +     u32                      p_id;
> > +     u32                      PAD0;
>
> Perhaps __pad0 is more common. But, is it really needed?
>

$ pahole -C p4tc_template_common net/sched/p4tc/p4tc_tmpl_api.o
struct p4tc_template_common {
        char                       name[32];             /*     0    32 */
        struct p4tc_template_ops * ops;                  /*    32     8 */
        u32                        p_id;                 /*    40     4 */
        u32                        PAD0;                 /*    44     4 */

        /* size: 48, cachelines: 1, members: 4 */
        /* last cacheline: 48 bytes */
};

Looks good for 64b alignment. We can change the name.

> > +};
>
> Only nit.
>
> Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Thanks for this and all the other reviews. Much appreciated!

cheers,
jamal

