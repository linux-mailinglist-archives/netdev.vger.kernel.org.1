Return-Path: <netdev+bounces-115462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0CD9466D0
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 03:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162D4281A7B
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D45C99;
	Sat,  3 Aug 2024 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEFr+d8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580963A9;
	Sat,  3 Aug 2024 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722649022; cv=none; b=jkYDVYM6/LqF5KEIuIWUkFgZidPcCsRqnvRlEEyp6jwP5jCvZxcIrF3QlxEB2difQ9hwJdMp7hyFq41mKCBlgUKKNsnBkWefU4CyrU+WOEaACTLnS95KIoRtaYnyLEyABto93sL66I+pBmuwhhO6mzXNZOAo78PUXV7IUgvu9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722649022; c=relaxed/simple;
	bh=K2HHGi9RoMQ7R0r1f4FxrGm65Blcsn1Lhqfjck0GLVA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dDCYSd6lyvdNkj+Tw1X9P2hx51bZpiWcoKvxU0SKhbSZdWgwWIXqiCIgDEa++bhN3WSUxwXIZIasttyS4k/tk9RwKXpphqMUHfvROIpf84NbWh8UeF88V4WqeQFKyRWPnVJVIofl8OxO+TTkelccL1oPFbGFPDfMHtyrCySY3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEFr+d8W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc611a0f8cso66718835ad.2;
        Fri, 02 Aug 2024 18:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722649020; x=1723253820; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMNBxKV3UA5rVdp9noY4O0CwCdPc44C/wx8pr12McI8=;
        b=SEFr+d8WL6QS0+SMsXaxCAcQCMA3R47b9/BY7Etv8haQHy30ou4q2SJEmEfA3ln6CL
         V4yurYA2HbwDeTdU34Q/I4VgqH3xxDUQ0WaWkJ2lNN22uZXSbu7zAiBzDng0mUlLUW7O
         mvogm1zjourOySyDVtM/CmFiQXubhI1Ski1Neq5Md+ztKC6Cw6XAVfIYIGHRZPMM6fwN
         WFCcgQz87EX6Bf6bcQJSj1boIQNWFKmlvTeaYCTXY5kVY3zpwa9ruHOZn2n0AN+ZemM7
         8NXgrJBZDbv/kjSRnVTFTbkNyOCyMPfmVzKj8tCelsaL7YnJBwCxvBuGMl9sjCpQhmn5
         gL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722649020; x=1723253820;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMNBxKV3UA5rVdp9noY4O0CwCdPc44C/wx8pr12McI8=;
        b=w9I32YguNiQwfzTqOv1OsA3G3dahAft93ZpAaRLPRwO+6ivhX2fGYGgHK0evtM/sUI
         UKyXItGXah3yFZMtnh6Utqz5d0Wnwzga+tzoE24qmAjbc7JDVTWglilu5LYh2czexjx7
         6Kjsy+EMQ0KKkfJzoOipmTqB+dyN5dcReG1G+rrfyuax8lGjC0DySzPCZu9sVSJoLvJC
         pfkIJ4JuoIvGUci+QakJ7wb+Uk92Dtx9DAcI85ddxHTxiyCXvJYS8RGLOgiWgHxgZUa7
         lCwsUJDKwpSynrU6ZD/8wjTsuoWPOzGYRIc0LXPAGLKi1htikF7N60iR0UWchVS+MKBP
         2n5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOtimac2RciPqzok/Z3cdEhTYqkZxzqRujm4pv+ehdn6LHoGAMwEDfPPvbC+g6vpEGsVuq/nAs2lIjz6XhOEMT1M2cefG29bC6q/PVYrREay4Tjf7BjkOdmin5KacNEOLIXVq2
X-Gm-Message-State: AOJu0Yzo7w8w6gfVG7KSP9RvWepf9Fj/tjULWq2U37EfrWSH0MhQCBsf
	0aioYfValzeytCSFNKIR6WIu3JlapGYjsd5FBC5BG0BrDzw2oOFdpfZ+yYlt
X-Google-Smtp-Source: AGHT+IHNGmTVSsGJLio2LdN68UqxKgxWi2kcgVkGmDU9K+iC0+KRFJqFI+H8YHtjSWKAt5+KoVUEZQ==
X-Received: by 2002:a17:903:110f:b0:1fd:9238:40f with SMTP id d9443c01a7336-1ff57292c01mr60147295ad.22.1722649020254;
        Fri, 02 Aug 2024 18:37:00 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a40b:be5c:2934:ccbd:6135:2b1d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929407asm23677355ad.242.2024.08.02.18.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 18:36:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net,v2] team: fix possible deadlock in team_port_change_check
Date: Sat, 3 Aug 2024 10:36:48 +0900
Message-Id: <4E6F3146-AE8D-4C70-A068-A6EE8588F13D@gmail.com>
References: <Zq0akdhiSeoiOLsY@nanopsycho.orion>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
In-Reply-To: <Zq0akdhiSeoiOLsY@nanopsycho.orion>
To: Jiri Pirko <jiri@resnulli.us>
X-Mailer: iPhone Mail (21F90)



> Jiri Pirko wrote:
>=20
> =EF=BB=BFFri, Aug 02, 2024 at 06:25:31PM CEST, aha310510@gmail.com wrote:
>> Eric Dumazet wrote:
>>>=20
>>>> On Fri, Aug 2, 2024 at 5:00=E2=80=AFPM Jeongjun Park <aha310510@gmail.c=
om> wrote:
>>>>>=20
>>=20
>> [..]
>>=20
>> @@ -2501,6 +2470,11 @@ int team_nl_options_get_doit(struct sk_buff *skb, s=
truct genl_info *info)
>>    int err;
>>    LIST_HEAD(sel_opt_inst_list);
>>=20
>> +    if (!rtnl_is_locked()) {
>=20
> This is completely wrong, other thread may hold the lock.
>=20
>=20
>> +        rtnl_lock();
>=20
> NACK! I wrote it in the other thread. Don't take rtnl for get options
> command. It is used for repeated fetch of stats. It's read only. Should
> be converted to RCU.
>=20

I see. But, in the current, when called through the following path:
team_nl_send_event_options_get()->
team_nl_send_options_get()->
team_nl_fill_one_option_get()
, it was protected through rtnl. Does this mean that rcu should be=20
used instead of rtnl in this case as well?

> Why are you so obsessed by this hypothetical syzcaller bug? Are you
> hitting this in real? If not, please let it go. I will fix it myself
> when I find some spare cycles.

Sorry for the inconvenience, but I don't want to give up on this bug=20
so easily since it is a valid bug that we have started analyzing=20
anyway and the direction of how to fix it is clear. I hope you=20
understand and I will send you a patch that uses rcu instead=20
of rtnl soon.

Regards,
Jeongjun Park=

