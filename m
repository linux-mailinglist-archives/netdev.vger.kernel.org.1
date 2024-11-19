Return-Path: <netdev+bounces-146241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A479D26A8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DF01F235D5
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521691C3F06;
	Tue, 19 Nov 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMObiytv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE01991D2
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022079; cv=none; b=i0bg53c4QdKGfFIW4ZDcDFfvCZPGK8O66MRsBvnRhjT4TupdhbgWEFZiw+0VN51l68a5qwGI4SfvMpiwlrHoEtzRivu8WDCFB0JMT5vJYWiXtihfK0YdFrYPLjgvYshw2+kMkPrt9AxxpAwuvG84U3miGrPZUdiu75MqiqmTHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022079; c=relaxed/simple;
	bh=rUgGd0wBebVAsrN44iswv8f8ZfG0VqmGCiY5kFlyuks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZVeNb2c4WfjLO9Ow/v67KKja0niFuv/5/Uiq30Nq5bYreMAG+PoZhaLi//47qcSf1kWKvqbbyy3eW9v4yudQRaHBMaXcD5KcBC0PP/1czCKJxBNPyYKM+tXArGi9A8ScubmZgsefIa9Puc4jYFnTT1nu9e9xkbIUygU5w5QEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMObiytv; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e044d4f7so4e87.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 05:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732022074; x=1732626874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iX4H8fbXW3esG7cXg/Rctl6YVlhDYkHZdELut8SIAo=;
        b=FMObiytv84ZMbSX1hhgiWkUId5vcrH7klgW2wjICQCzfbAUBseceudzPKUgOAmeyuP
         5eECTtIZioN9ddZpHhVZwlBDWK49I/XJQHMPanwFt2UBMs9SWmTfI/ocFC7v88Sb9jym
         YXUb2QYlALjGst65O5N07tE9yc5FlmT3pBHRC3YLU36Jeo8GGU1lXUSG3Z2CuBqpsxay
         cX3GXLi0vTYazPZoiwcwNcjkBAMZwzWV7q9VHmoVkCcEM+CsokN8OFbkojR446A06CGG
         avXHr12EQuGAa5nGlIM3Ee5vy1bOqYR1u7FK7sTrkEzrE+sd4BIJTCFqiQFfucNUWHgX
         kysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732022074; x=1732626874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iX4H8fbXW3esG7cXg/Rctl6YVlhDYkHZdELut8SIAo=;
        b=Rr2W7IT69jaYQnT7VURIfNVgRrpZ7Z+0C6AkUJQ92trqG9ntnDYgGirB+k+i9a/wqN
         rB8Ax9ubbjw9lTiIV1NCJlURKp9H+KRB3MZ5gkdjZmg2Vf4eL2yn+M5ypyLuwdMq6Ngb
         eEBGD86kZslW48E6rt+K/CDYVwWu+pUXo0A0p4Yc+yc3zCfGbv9rGmeFXwXy5XogXU58
         cU6T/tlGY+6Kq1UyKXrwU+N3tj7CPzakA1cRDaKneXHujnpcAZN0OS1rD97LQmJ5DoqZ
         oV0DAzGgDUxmu1Fp9oG6GbeGA1Xt61zE24bEU6JezykUCtUYfXryvCzXaFarer42Fu5i
         ZmUw==
X-Forwarded-Encrypted: i=1; AJvYcCUsTYhCPGZosxAGdBJttsj66x8IhoAP/j1YrxoSvSXEy2qwQIzDs+WQVBfyQZBwk3oaTg9LDKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYH54qCXCJtWCgXiSGIuUxiV+KC3oUYER9nD/k8v/v6F6zemC/
	LN733GwYOQToJUwuaBPs6A4yZFF+yH5ZFH0odZQMyKBYSLKdP1w6dOx3bsXXPhcILnGJXifc9b4
	LNQ+SHcI0iScgf14EuCVH3t/3GpQP45iNe2yp
X-Gm-Gg: ASbGncuFwIhtZWmO0Zgjp9mIirTayYCt2V7TZkAid6r3zDvKl/gI8Hg4k6KbsejMDhb
	Pi3UQfEfHPQ58h7XnGsyoKks+FEQdZiORPOTN3/WIGub6iaJjycM5+PF+rTB1mWQ5
X-Google-Smtp-Source: AGHT+IF+Kk3jBwBjvRXF1zmcN+YJYGxA3ltJ8IhvTVgGQ+nbZr1oMQcma3CWSBMfMsJ8ExiZI9USsNT5WKjlAMNgsUI=
X-Received: by 2002:a05:6512:2002:b0:53d:b8c2:cf6b with SMTP id
 2adb3069b0e04-53dc0260654mr254e87.0.1732022072958; Tue, 19 Nov 2024 05:14:32
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117141137.2072899-1-yuyanghuang@google.com>
 <ZzxAqq-TqLts1o4V@fedora> <CADXeF1GEzTO4BuVnci0Vvorah+vCcrTZR9EE3ohQrN_TKnfL0A@mail.gmail.com>
 <1a4af543-d217-4bc4-b411-a0ab84a31dda@redhat.com>
In-Reply-To: <1a4af543-d217-4bc4-b411-a0ab84a31dda@redhat.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 19 Nov 2024 22:13:54 +0900
Message-ID: <CADXeF1EyFzBh5AbE_ieJqh2q9k-Z1E9vmryyTBmekKV3rAkORQ@mail.gmail.com>
Subject: Re: [PATCH net-next, v2] netlink: add IGMP/MLD join/leave notifications
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo

> I think the most important thing is consistency. This patch is
> inconsistent WRT rtm_scope among ipv4 and ipv6, you should ensure
> similar behavior among them.

> Existing ip-related notification always use RT_SCOPE_UNIVERSE with the
> rater suspect exception of mctp. Possibly using RT_SCOPE_UNIVERSE here
> too could be fitting.

Thank you very much for the suggestion. To ensure consistency, I'll
use RT_SCOPE_UNIVERSE for both IPv4 and IPv6 notifications, unless
other reviewers have concerns.

Thanks,
Yuyang

On Tue, Nov 19, 2024 at 9:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/19/24 10:21, Yuyang Huang wrote:
> >> Why the IPv4 scope use RT_SCOPE_LINK,
> >
> > I'm unsure if I'm setting the IPv4 rt scope correctly.
> >
> > I read the following document for rtm_scope:
> >
> > ```
> > /* rtm_scope
> >
> >    Really it is not scope, but sort of distance to the destination.
> >    NOWHERE are reserved for not existing destinations, HOST is our
> >    local addresses, LINK are destinations, located on directly attached
> >    link and UNIVERSE is everywhere in the Universe.
> >
> >    Intermediate values are also possible f.e. interior routes
> >    could be assigned a value between UNIVERSE and LINK.
> > */
> > ```
>
> I think the most important thing is consistency. This patch is
> inconsistent WRT rtm_scope among ipv4 and ipv6, you should ensure
> similar behavior among them.
>
> Existing ip-related notification always use RT_SCOPE_UNIVERSE with the
> rater suspect exception of mctp. Possibly using RT_SCOPE_UNIVERSE here
> too could be fitting.
>
> /P
>

