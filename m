Return-Path: <netdev+bounces-181414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475BBA84DA0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 21:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A069174CCD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0428F927;
	Thu, 10 Apr 2025 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z38pf3p3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C61C3BEB;
	Thu, 10 Apr 2025 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315183; cv=none; b=OkvEBJFC6KF2NmKNeUywPoiKamNMXZRfNZgZjUcIIp/RNu3cOIbUgOlJ8ZLhcJvlXP+zmboYVFznb1rJkxCZ7kv8H/DkvShufSJbN2tJIdXBHWz6JPXPVWzRZqK4NGx9oe5hZiXJMrbB8ck3YrMigltJDoxDd5eHG9Htu2EWvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315183; c=relaxed/simple;
	bh=NW63uHkLkcM39Qc6iSVYuH58ir45xfXAXIeZclP1MP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCePYWpPZgSuHwq2yj922O3OTvKyAqTtK1b0FUfL5JIeP3QFjBUdKK2Jc++C57mi5Ilw2JB8bABDuiwTE5ZabFhTpY9q2Vlvca3W+3jYkCBIyV8bNooSkMOHAgj+tC0qvXnthbqeE+Mqu9tJ2sBcWRWb6qlxwPCm65mfV3HL0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z38pf3p3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so1292747e87.1;
        Thu, 10 Apr 2025 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744315179; x=1744919979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwHmA378W6NLdb94l0kIXEG6dN9f+MTetUXmPGeF77o=;
        b=Z38pf3p3qkoX0yngrrmC3ZyI5AvuzXBnwGputwF/DgSmAdWufmeNQ/iejfsq4CrKH6
         3qu3r9eVrpzO20/EWTx94Go9tzFVGeiHVjkUWPlkYbVxqZqxSP3AyLPk85NU9InUyrAV
         Nv+oWjgdXWBb+7aYfcNnZFmQu4zqxPLn2qHm1nkFo2vikwxVwMNI4SJxfQbrR8XFyhUC
         +tzt20L9S+mZvlrtPNbbsGc0i1nLdQh6tAG+lqnlA/lERKvvrOXwQPWxlOEA7+SBckkH
         zNlWV0fonXrJt27yU0FIjgdsD9gvPW4WIKNqMlN+30SXuehg432uZNU7ruVv5vHaGR/F
         jjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744315179; x=1744919979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwHmA378W6NLdb94l0kIXEG6dN9f+MTetUXmPGeF77o=;
        b=XnuFlf6rpuPXUs1vkq953TphjhGDXvnzd81DDvhzoDKJrf2IJdtwiYfRpM/bKM4Vou
         1LkTkEJPrptUbHNJn98ITVxDyxyHRpJsA1wPVTcfzxV0RkCZXrppJNNz99y4zLbMTJR6
         sY6NkQP3iy1bKFKn/hwErNMgmuv6pYSj+B0A2q41iXfqECXhRWpgPSB7wlfzr2l2no1h
         Uy8N0rYOTIHHlxed9ZfJr2bnX+ZokURISPV1ARdwKENomOQ7w/m6hN/TiKCkLqk519px
         tWCI8ns9zJKym7bJ4kWHd2zoF4d8mA/zAEN/xzM5RaO3j2GzGNmQATrZ7li3obLlmSGG
         6ueA==
X-Forwarded-Encrypted: i=1; AJvYcCVlXkmTmVh8AawJp9z39NZFQSyfzsXgB9O9Ld0O+z6hOtMysaFsy9cJgX4qe9sAK7bbwWC/HDsT@vger.kernel.org, AJvYcCXjxmIUQdmh8Sxv/ePRyrEgc8CrU8/34y9aY1hOM91ppUtjqDA+5L6RD27UK6ODV2UCh3gUoAqLnEIiPZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycGF3KIN+UawGlQ0QU2GZOOeZlUUKW0UfjWZMnfj1FoOT1l6W+
	8DbMHht2bl8Lcl5hrlfWFfJyygpq+BaKcd0jWJJMpjucr68qpQqUeiQTdnR83Xrb94j4QS6AlkY
	nnGmCbROHsoJ+cNBlWk2BZimGKyI=
X-Gm-Gg: ASbGncseuc51C+93dFJ0am4k1o7g9Z84Xx57yiqRXNd2XJWa83qIraaYmfiC+f3Euba
	7FyxJgYccdRIcK9Yn+Y44iXNi1OSg/V6lWVd1s8T/hAmU+uV/5MI44eSCetGl97SBUWeMlTwNPQ
	wBhXPCc2dz6qwyzROSBSr88KXQAIluUQJ9w6u3sseYZo5klSscaI8UxDs=
X-Google-Smtp-Source: AGHT+IGY4oluoFyz6GVB34MFhj5G3ks9xo2ahSRLku9GIJQXukB383ULsfDKfh+ZtOCcwWEADCve3h2EUoyMATCSseg=
X-Received: by 2002:a05:6512:3ba4:b0:54b:1095:6190 with SMTP id
 2adb3069b0e04-54d452d7ec2mr10657e87.49.1744315179118; Thu, 10 Apr 2025
 12:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408185759.5088-1-pranav.tyagi03@gmail.com> <1168af15-14dd-4eef-b1d7-c04de4781ea7@amd.com>
In-Reply-To: <1168af15-14dd-4eef-b1d7-c04de4781ea7@amd.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Fri, 11 Apr 2025 01:29:29 +0530
X-Gm-Features: ATxdqUGWkHq07QDYT837wHsiO-ekWuaZwFRrPK3PdsygZOVdXNU2Ad9m_XoQj00
Message-ID: <CAH4c4jKm9ewfL3G7SAGokzGT3VpLaKWQrbrxcLAnb-G8_MUjSA@mail.gmail.com>
Subject: Re: [PATCH] net: ipconfig: replace strncpy with strscpy_pad
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	skhan@linuxfoundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 3:14=E2=80=AFAM Nelson, Shannon <shannon.nelson@amd.=
com> wrote:
>
> On 4/8/2025 11:57 AM, Pranav Tyagi wrote:
> >
> > Replace the deprecated strncpy() function with strscpy_pad() as the
> > destination buffer is NUL-terminated and requires
> > trailing NUL-padding
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
>
> There should be a Fixes tag here, and usually we put the 'net' tree
> indicator inside the tag, like this: [PATCH net]
>
>
> > ---
> >   net/ipv4/ipconfig.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> > index c56b6fe6f0d7..7c238d19328f 100644
> > --- a/net/ipv4/ipconfig.c
> > +++ b/net/ipv4/ipconfig.c
> > @@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
> >                          *v =3D 0;
> >                          if (kstrtou8(client_id, 0, dhcp_client_identif=
ier))
> >                                  pr_debug("DHCP: Invalid client identif=
ier type\n");
> > -                       strncpy(dhcp_client_identifier + 1, v + 1, 251)=
;
> > +                       strscpy_pad(dhcp_client_identifier + 1, v + 1, =
251);
>
> The strncpy() action, as well as the memcpy() into
> dhcp_client_identifier elsewhere, are not padding to the end, so I think
> this only needs to be null-terminated, not fully padded.  If full
> padding is needed, please let us know why.
>
> sln
>
> >                          *v =3D ',';
> >                  }
> >                  return 1;
> > --
> > 2.49.0
> >
> >
>

My initial assumption was on the fact that dhcp_client_identifier
is directly used in DHCP packet construction
and may be parsed byte-wise. But on going through the code again
I see that it does not require to be fully padded.
Would strscpy() suffice? as it ensures null-termination and
does not fully pad the buffer.

Regards
Pranav Tyagi

