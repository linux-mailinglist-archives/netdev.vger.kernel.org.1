Return-Path: <netdev+bounces-152881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C755B9F639D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EEB169968
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5511199EB2;
	Wed, 18 Dec 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWnAcl99"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB604198A07
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518675; cv=none; b=iSE9gmeJUz9biWYJrGm0TcJ2hSZleatPdKAn8X0mTnIxIUJi8eH52Q77zjnjDOWQd8GACkeWR7G4UEFAR9pN/SiLVd1kR6cVh94KRVqxIOymh4sZOkQnZRrpl1BrSAZzfoGIaW6l2qozB+Ux3S8QP+5R3rpORaUqwzWe5O2hpjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518675; c=relaxed/simple;
	bh=dY3melZEzs5uk4TJEI+ZXsxwSDUPYgXVEMJV4rgi6pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3cvgLsICnrdFKBb3cZgbtWEO+i8v4gdpA23DRr+hs4jvWNH3LIK106t1yGW0wEhzOGyLTzOja+f1WYsIVBi5F5wpZ9kgPmvu6Ey+GQIsWlyc9czAykpb7L7KtKjhwGP873w/rrAz8roVrXCdykM8g/PYK2SvqS2xYM5xEB4Hw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWnAcl99; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso10943595a12.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734518672; x=1735123472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyxYWiLsLJosyQgqhuFbCYST6vChO+RolCv5LvpJWpQ=;
        b=HWnAcl99mqErhAUZhQsMMq6v5tsmIih0wVtK4ETzEBqSrVOsHS/QIuzmQ2vqtDeEU1
         htZevrROqLH5qFdIn2TLF3UCFJQvHRVQxEZA25TfF62W8E9lhLqj3JXamvODgL0zp526
         M8pZ1Xah1rMdp5PXr5th3ufunul5NAgU/xbXaebEZz1CK8EsGWxRfEN8asMWtzG1TW3z
         Ra7JSX5tVaWJdp8ZzqdNppPGIVwsb4uPUvdasDK448ENPKrW2Sm/2a57fDcdFfGRqyjI
         XpqDLW78gUJiGHCW0abbwkfsrj96k+jzUwM4erwkPVnVEvVEiY3C0sGoCrOa6+07IKp6
         oOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734518672; x=1735123472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyxYWiLsLJosyQgqhuFbCYST6vChO+RolCv5LvpJWpQ=;
        b=s3O97gstaDVMxCGGEAoqp0jXfy0urywi6C9F2ZvoChIaOWo8I2f14X36WsLbN2ZjFm
         KIxr+wnVmYyGbcIG88OPu90LD/7CRRmfiM5fcMul+4L/z/32hM/wIV0zVHQFVznFKavH
         mlQHeIphZIZe0y0TkaAYg14X7PFq9zZ4aP9yuAqYDAKSdnQPPbzFPGnoCpFmmGnw2G6P
         MueTZv3mdazN7cCBvxxHUWaESRlPVhNhn+XeLRbKNuaL/vra/tz4RajAe5bU6vTzR0Qz
         CzzNe6iVT3V9Mu7MwND5xgW5RSA5Pudho3RC84Jst8A+DjaS6qN8rm9jyp8W2MNA9zul
         9V9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuHbrXNQSNCdjLAC4X7sIRb3frHhyKbD2JaHPJIjiFT+wuiNi9ah4c7GcCQ/GErlUP0yUpOGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLMZC838oAx+PcItUPzwVXkiN7SWR9keUiH7WSDjcomgMUA/V
	CJm71kwX8X8Te+DxlmEPmNHc4mctT5/7vslkGLd7pa1PHLsDsItgVzBJtBNrVwqJl5ah+N6IOk0
	7E97lleLLEL7Ab2U3uB7aXT+1T8K53Qw3n9pp
X-Gm-Gg: ASbGnctYZJ9vZ52C0gq/Vn6hUR6uVbo+VLgtw6iFXPwKdK2Dj3buoPflejVPMLI7rs2
	bhKNxxuKucpsPFDydibGxUe0JkFsjUMdyvykzd/G2CT2C19Geycdv7N+faClEJlD1TBxJiVA=
X-Google-Smtp-Source: AGHT+IEQW87qJlXu8rFaphnGSVjOGLfS/OhdFI+ZixQg699mQU0u7qNiZhcsrd1T719tjbMO48w1PTH+bmOPCoAJB5M=
X-Received: by 2002:a05:6402:360e:b0:5d0:c9e6:309d with SMTP id
 4fb4d7f45d1cf-5d7ee37728dmr2043035a12.1.1734518671981; Wed, 18 Dec 2024
 02:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218024305.823683-1-kuba@kernel.org>
In-Reply-To: <20241218024305.823683-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 11:44:21 +0100
Message-ID: <CANn89i+yvyPMU1SE=p3Mm1S=UexsXSa4gzH3heUg17sa+iFK9w@mail.gmail.com>
Subject: Re: [PATCH net] netdev-genl: avoid empty messages in napi get
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	jdamato@fastly.com, almasrymina@google.com, sridhar.samudrala@intel.com, 
	amritha.nambiar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 3:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Empty netlink responses from do() are not correct (as opposed to
> dump() where not dumping anything is perfectly fine).
> We should return an error if the target object does not exist,
> in this case if the netdev is down we "hide" the NAPI instances.
>
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for na=
pi")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> CC: sridhar.samudrala@intel.com
> CC: amritha.nambiar@intel.com
> ---
>  net/core/netdev-genl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b4becd4065d9..dfb2430a0fe3 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -238,6 +238,10 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, str=
uct genl_info *info)
>         napi =3D napi_by_id(napi_id);
>         if (napi) {
>                 err =3D netdev_nl_napi_fill_one(rsp, napi, info);
> +               if (!rsp->len) {
> +                       err =3D -ENOENT;
> +                       goto err_free_msg;

Well, rtnl and rcu are held at this point.

What about instead :

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9527dd46e4dc39a43e965b833df306a5cc44c94d..f86cfb0b33616722ec40874e8bc=
90cece57df869
100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -246,6 +246,8 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb,
struct genl_info *info)
        rcu_read_unlock();
        rtnl_unlock();

+       if (!err && !rsp->len)
+               err =3D -ENOENT;
        if (err)
                goto err_free_msg;

