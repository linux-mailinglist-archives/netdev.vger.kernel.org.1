Return-Path: <netdev+bounces-157186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AE3A0944B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E762D7A4936
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F67212D82;
	Fri, 10 Jan 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sO5/Qici"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD7212D83
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520497; cv=none; b=VdJ7r4irJnES3913hB76LgRGSAVbgCEix8f4hiXyI5oO2Z9yzwKW2kqoJX3D4929enBX/6M71mv5HGGZW3kVnC8NCjo4GzqiQl1hB6+VDYaZvc8Np/FJoJylCJ09+syzBu6ISTMUOyXVzOAAQJOs6mqsup982yuVeXNj23nk2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520497; c=relaxed/simple;
	bh=Bqpcet7WMI9CpkDWCxsuWJKyvQ/xOt1BTswXzR5yJ7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASMgHtWMENxZC4ZRaNw2zBQspkdU5Oh6zsYA3BxrP5EENsR7fF/ivlw7WKEdNcsEfjRQhCvRJKbt5Wo4rHx9Pm5izQxlntINTz6MMNLy9ayqmwQToTP4JdCEOdKwdqJTbziND3AV3/6K477dMpJ25PcCcC++dhzM0Y1tHOI+hO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=sO5/Qici; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166360285dso36826065ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 06:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736520495; x=1737125295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NxySisB6G/+j7C6wBPx38Ebyi5TgZquoSriIrcXZPA=;
        b=sO5/Qicif/sMkfW2b4+u8D2Z2dSUB2P1gVES3WY0Oq9kAbQEK+bEA48E0e8/7DJfK9
         qchNNCnHgIoLVNhCPdaAZyZUM6YpE0N0ml37VIZvDak2q29UrPsJVGjyjK48+FJAKzlY
         fZ/bv/7iKl1a8bXCS+GF2B2HezvfxB+HZUfPuw4z70prO+uNL7Qrg9JzSOL/eTTxrWMU
         TiX/2Mt0jcYv2VKjbWasUPVgf5WuZqJ9d9Dx2mp6E8LmfvqErycz1gUppLGBpsoH4mAf
         k4P4GlHDSbnuF3dht7hZPFOcJMCWsOHq5yXD7FvO6pAKCfNGA64+k7nPFOWoV2Ec2R6Y
         0+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736520495; x=1737125295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NxySisB6G/+j7C6wBPx38Ebyi5TgZquoSriIrcXZPA=;
        b=ZRdqGNOBLXceeD6MGOEJf+c4asrQxw7haluFXKAaIa2jLiEuIif3HNFxFzyWzDw545
         b/5JP+EtcbopyPcTj80qlGfO1eoEiMt9jTjLSM4n6/SyItIsDXkHmvvIClh8x0V1HPMQ
         JbFcei3orUT0PN1z7K1W/ovznns0vPm2FXWKWgMqa9olWz58zgmUOx4deUK7yZKwJCJq
         j2xPzM2NzUJJXFohoW9UUkIaLY9JWvS2vDHrkklR14vFc1snSss8EXkMmJB8LlD96eX5
         HygElU3UfuuDsBteBCOAK7EO54ysmOxBbykeAvoJ6dtCuO1Yj/m0skNLu4WElvCKcLSw
         OmSw==
X-Gm-Message-State: AOJu0YwaW9wAJbAAiVrmqVApekELlNsUaYYbiDuzXCGvmWZxVdSEf1yd
	zEiBuaKSblllj/2DBq33gD/lrRMmGg07KqopzFrcb1IZ5ekyN5omHhxT7r/2OpmCZkyKYja4NGB
	PpnDjM+oCTsTLcbO8eWirsO3l7knwl3FUHkhj
X-Gm-Gg: ASbGncs7ivh90jacOo0Cl3WfoTXv2ebkVv0ia1IHigBVPAq9mpbOq9Rlpz/A48Bubag
	76RpPiUhEn+CgkJz7z1OeKLqMzrMga8+1cCoj
X-Google-Smtp-Source: AGHT+IF8hC9yT8ft8min+VsLJ0wyx7GnH53pcSnBEYqdacrx/mmyQymMni6YbcAqRzEdaaz2RVIY2mVcuSPwfVA5nS8=
X-Received: by 2002:a05:6a00:21c4:b0:727:64c8:2c44 with SMTP id
 d2e1a72fcca58-72d21fc651amr14442443b3a.19.1736520495307; Fri, 10 Jan 2025
 06:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109143319.26433-1-jhs@mojatatu.com> <20250109102902.3fd9b57d@kernel.org>
In-Reply-To: <20250109102902.3fd9b57d@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 10 Jan 2025 09:48:02 -0500
X-Gm-Features: AbW1kvYNHDz0JSocwGuJ6PsiWb116Lj2OHrtvs3TtGc9H9kOPwA70e5A4O1ZS7M
Message-ID: <CAM0EoMn7uADZkTQkg48VP7K7KD=ZVHPLfZheAwXSumqFWommNg@mail.gmail.com>
Subject: Re: [PATCH net 1/1 v2] net: sched: Disallow replacing of child qdisc
 from one parent to another
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, security@kernel.org, 
	nnamrec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 1:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  9 Jan 2025 09:33:19 -0500 Jamal Hadi Salim wrote:
> > Lion Ackermann was able to create a UAF which can be abused for privile=
ge
> > escalation with the following script
>
> Also looks like this upsets tc-mq-visibility.sh :(

Yes, the patch will stop the "graft some" bits. Some first-coffee
context... Looking at the script, I see this:

# One real one
... replace parent 100:4 handle 204: pfifo_fast
Lets dump:
...qdisc pfifo_fast 204: dev xxx parent 100:4 bands 3 priomap 1 2 2 2
1 2 0 0 1 1 1 1 1 1 1 1
Then, this step:
# Graft some
...replace parent 100:1 handle 204:
dump again:
...qdisc pfifo_fast 204: dev xxx parent 100:4 refcnt 2 bands 3 priomap
1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1

Observe that  1) parent did not change(there can only be one parent
and still pointing to 100:4, not 100:1) and
2) refcount went up

There are two possible intentions/meanings from reading that dump:
a) the pfifo queue with handle 204: is intended to be shared by both
parent 100:1 and 100:4 --> refcount of 2 takes care of that. But then
you can question should the parent have stayed the same or should we
use the new one? We could keep track of both parents but that is
another surgery which seemed unnecessary.
b) We intended "replace" to move the pfifo queue id 204: from 100:4 to
100:1. In which case we would need to do some other surgery which
includes getting things pointed to the new parent only.

While #a may be practical it could be achieved by building the proper
qdisc/class hierarchies. I am not sure of practical use #b. In both
cases it seemed to me prevention is better than the cure.
Question for you for that test: Which of these two were you intending?
 It could be you just wanted to ensure some grafting happened, in
which case we can adjust the test case.

Like 99.99% of bugs being reported on tc, someone found a clever way
to use netlink to put kernel state in an awkward position.  And like
most fixes it just requires more checks against incoming control into
the kernel.

Thoughts?

cheers,
jamal

PS:
Sorry - didnt catch this, i only ran tdc tests which all passed
And the "Fixes" is from the first git entry - i can send an updated version
And to Cong - yes, we'll add a new tdc test case for this..

