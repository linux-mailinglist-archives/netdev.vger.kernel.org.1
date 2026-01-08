Return-Path: <netdev+bounces-248061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBA3D02BFA
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 13:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C503D30D2C38
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF5466629;
	Thu,  8 Jan 2026 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ja+7V8F1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D2C342502
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874751; cv=none; b=RmC5nbndeI1KA5FfjPh5/hSagNRG0V9Q2kaMnvBNmLxd1r9V5R6FP7+c599YFbzJZ9Za+eLEoEWJ49ysapYR5g+EgAP7KChEkbI5Q2EPut3dsoNxcbajqZoB15azCbj+mBGjxtd5Nax5j3f9lDHPgQI6xGdjwOhsEmoje9ZL5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874751; c=relaxed/simple;
	bh=XslR5Skl/tw/Xim8K72eczklMzvlOxARWwVTFZz2hyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmn2/86Gke4HfyReZgdEyWLpAe4D4chobnWWzSw2Fhq0GN6wna5bK4q8hlDqBNYShnXCaZeJFLy8GA0C9dPAOxU1UMSD3D+rwGWvm1tby8OZ70Tk8K36hBJq/1ncJ/JEHZu2dYUBsuz2Dd1V0jFtnDmYxg4O9iS2zfeMCzTJD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ja+7V8F1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4fc42188805so32640961cf.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 04:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767874746; x=1768479546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XslR5Skl/tw/Xim8K72eczklMzvlOxARWwVTFZz2hyo=;
        b=ja+7V8F1ZwjWz5gIR9kXgeJQwqADgKnij+xGhHeSKOkbZ3j0fpqSXJgQwNFDUpSKHu
         BLRlwmWb5dG1rM6Sz97lQd8qG1LLDpxMRxJYaMGnmPnlptG5NZpECNAIr9Tm3qHE5hyY
         piUAzuG5yyotnME9cOrJQl6abmkEoDMJBDTvgWGMzgl/OE0W9gkeHApBotwro/H/ZKDs
         yL/HIYAMRAuDuFSAmVl2ueileIkRxaFoPFTmU+Q9KvU6xmU7xtRbJRglFTI+LTVlwgjV
         Jc3u+GQncx4lvYaL+FriQh4RoBG8qp0tuMoKbeqSCwslizSnn2sb1YoiVqWHZZy60zhk
         JhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767874746; x=1768479546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XslR5Skl/tw/Xim8K72eczklMzvlOxARWwVTFZz2hyo=;
        b=lR9aCeXkD7RVzqQYNVtCooHMqflNSg/Kbsz8Yp4SwqEvE1zpem713eJHW3+l4zcZxr
         q2CFx3UIY4Eyx/ey54O/+V7OBMGtxM4xkHI4EIwN6+hiOHMB8oTaCZZNKx6bbe/o/ViA
         1LoTMKPUrKiCW0Z+Om5On7Dfg0ALENiWHGLpeb3a/htKQJ2+MZDltyluokqLkVIY+kXq
         1ejQCdi0yK5NXlo4laXjbC7Vpd7Px3gLmDLc3rQnV6m9TXhWypbAgsMM8c+/FV5AlqVw
         WBR5wRPPV8oWfIGHvyjagzTd8zU83PlsaOnOlz3bYPtIPNDW4ikJc9vUK/WHGNNv8/Su
         OHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Xv5o8x/dcaDJwzX4m+knHzAOWcz6NT9Zu82LbZmfVjidpJUO8AhsoKvyHtBJUdme4MyxTJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxggf/VIStdnE74fUEc2dQEPADvl4shlLqUVLNV61f5+IW7q7Rn
	PXxvhZ955Yza74oeM1006ob+oV6nzlQza/x3vyBGjxD+GdQ+UfyNviZjjEcLzAoOP5G04d9pgOJ
	SAminxS9jQ+gMYTj3ml3hMomElqsMzwjKZj7aazFm
X-Gm-Gg: AY/fxX4Wpgs42bgfIifc/iFslaVFQfe+yWbOV8RIUHDOfadlI4+tX8D6CvhfZWyIxTY
	vCojEpsFQ3jnD2hFgIkXakSy5Uad4p9Uw6Q19+RcuvSBl+cdm7qRi7R8N7TWR5vE/0ihaMuAnqU
	OQA0mnkF0buNuDX+zSLZOMpS/EDbKhyNyatdOBBKv8LgYDeIUg40QmbvpeWYt6R4ZzTDYR1kkT0
	5+vvzRNZa4Mg5wswV2FjGNYrXX5+LFYeK82b11fBoeu3ptKCLvexP6JFycbK21hRJYnFkeZUl0i
	oW3g
X-Google-Smtp-Source: AGHT+IE6CBzyCrx4IFVvz/0AqM39PV6mvwh7lOn07b9ckEerO+EpyGAL7TIuu+rk4c57j55fgOdIw95rlnzvDdfaED8=
X-Received: by 2002:ac8:7f8c:0:b0:4e8:b2df:fe1f with SMTP id
 d75a77b69052e-4ffb487f955mr83824451cf.28.1767874745665; Thu, 08 Jan 2026
 04:19:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com> <PAXPR07MB798456B62DBAC92A9F5915DAA385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <9d64dd7e-273b-4627-ba0c-a3c8aab2dcb1@redhat.com>
In-Reply-To: <9d64dd7e-273b-4627-ba0c-a3c8aab2dcb1@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 13:18:54 +0100
X-Gm-Features: AQt7F2pGmpHwQwLbaeD-dBc7rrFfr_O4l9u7b9jAwL-yY9Bn1sm999duNbFyyYY
Message-ID: <CANn89iKRAs86PVNAGKMUgE49phgZ2zpZU99rRkJq=cc_kNYf=Q@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
	"parav@nvidia.com" <parav@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 1:05=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/8/26 9:47 AM, Chia-Yu Chang (Nokia) wrote:
> > Regarding the packetdrill cases for AccECN, shall I can include in this=
 patch series (v8) or is it suggested to submit them in a standalone series=
?
>
> IMHO can be in a separate series, mainly because this one is already
> quite big.
>
> /P
>

If possible, please send a packetdrill series _before_ adding more code.

I have been reluctant to review your changes, because there is no test.

