Return-Path: <netdev+bounces-90179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12F8AD01E
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B341C21B7D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A43615250C;
	Mon, 22 Apr 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuWd4gh+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A0152184
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798191; cv=none; b=XU+5wXjJqTTqk6idPEcLQfGkTcUnjk6XZlnrwa/Jr8PqEF07oJZ974Aq2fKLKe4hA0KntjgGl8JtdKHQ5KwDgZBEMHqkOSmAwSpBu7KO5Rv+iYoqIgBn6vIH47/3uO9+Jt5Bjs/3Xabugnm2lNErlFKvDNy7/8JZ1Lca6wG3QcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798191; c=relaxed/simple;
	bh=opHmyQIZVxOOADeZVoerlK0O/JczCZYTLh8nmMvSqis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBZKMH2Hobepqy1lvqj4Yq7ZnpAt8VNhAcYcpMNe+MjTsQLm3J6m1DSeV1IHbElmOlkhP+jBuqK0B1UZClqsK6EoClgLQL3BwIVGNtrwOngyYVPge2pzN3Ag6niHkAo1gmEs+uo/Aqxb3M+nWBlLL77i3LGOqq2rc0YLebgr1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuWd4gh+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so18379a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713798188; x=1714402988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opHmyQIZVxOOADeZVoerlK0O/JczCZYTLh8nmMvSqis=;
        b=uuWd4gh+jJ7Xqff6I3+dvVCljG65Wgaa0q7rj6ATqGiYs+jv1ISoyWpTJgcz9a9Wc2
         SaJiNbIPgQGwpCWjLwm5zJk/Q7dJnH4+M0A5H+sINH6Nmqod8CD+07Ef4NpEAvNiGMyt
         oTSJSEXB/D2k18WmTeKc9c2diTyOCpEL/49gkXMlAOzBNy3fL8b9GzfD2LvoIM3rrSm9
         r528fnN5dNBuYfvlHrbJtscm2kzYjutXh1KhhrBu2PARdNXX6BKTQLf1gPV4TV3wsuya
         /dJjMlgk5rhvJ8zO/ImqY84JxTyIYnrixbn/BuQ/gnHQ9pzG6oDVUZynzCyo9y4xGtll
         CKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798188; x=1714402988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opHmyQIZVxOOADeZVoerlK0O/JczCZYTLh8nmMvSqis=;
        b=w7xky067PzkzZTnIWamhtPbeGXdp0agsdtOTrPI6cJZMTjlS/8nz87LTcko0lVp+r6
         x+LiFpl04Is4jvB7CRnaNMGo0JUcW3JeEG6ZgpkzDapm3mjR2V6CPxPQFyA+Joj2V0qT
         PIHf/grx64fi+FrvYxM6tG1+cvqVw8P0sU61tzn1KMG01eIdnPlAuzgrI1jm1pmjkQgh
         JXi0s0C8TkYYuq22sTRvMaQ2FD2qhS+Cm7uvO1GBWen3QNfAeitDGpprvkcAZIatjsKl
         5AbohoBhVdh0a90ccT67DE37JKsqT+iT/8ZqIn4kuExS2rBbqhKnva6cgJWdTaxGcr1I
         XzUw==
X-Forwarded-Encrypted: i=1; AJvYcCUgbiOGaoizRe2fKEdjAFlFbWmdi+vk3H3b+zWCTH67TC7yYRqBtfscd7jGMvc4H37ha+ETIj+VGnUPgFDpH/scpFaJ6Qz2
X-Gm-Message-State: AOJu0YxMHh8j00Mb4K9a7lucEz7lO+VEZNyX+0RK56EeYDBA0dKsjBX2
	lEjXC+qqCtz7/BhyxWkY2GEXfm3/Xz0KP9SHTBDI124KRt789Ub2EbdB6jiZtEJr1c/GvcunCMp
	cLDf3hwX7cAK73PIHKmWeY2oDOdMeoQHZC9Y/
X-Google-Smtp-Source: AGHT+IGX9rDB+qbhFMyYIg42Ne/A/wJsJhw7qq+3UgN0ukHWp/zb3OivY031q1jupJvoDR13aA7ELdapUgRo+/Wwi9w=
X-Received: by 2002:a05:6402:4315:b0:571:b2c2:5c3e with SMTP id
 m21-20020a056402431500b00571b2c25c3emr293628edc.1.1713798188023; Mon, 22 Apr
 2024 08:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420023543.3300306-1-kuba@kernel.org> <20240420023543.3300306-2-kuba@kernel.org>
 <CANn89iK-wnNeH+9-Oe6xi9OjoY5jcZCowJ5wDL7hJz1tRhMfQQ@mail.gmail.com>
 <a1340c70-bbc9-4b23-8e9a-1bc401132721@kernel.org> <20240422064825.18850cc3@kernel.org>
In-Reply-To: <20240422064825.18850cc3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Apr 2024 17:02:53 +0200
Message-ID: <CANn89iJOGunkDHFOHjZHQKm9aDJ1S2PWgiMb_FPfpWfiW7cfyA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] netdev: support dumping a single netdev in qstats
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, sdf@google.com, 
	amritha.nambiar@intel.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 21 Apr 2024 13:32:24 -0600 David Ahern wrote:
> > On 4/21/24 1:17 PM, Eric Dumazet wrote:
> > > I wonder if NLM_F_DUMP_FILTERED should not be reported to user space =
?
> >
> > good point. We do set that flag for other dumps when a filter has been
> > used to limit data returned.
>
> That flag appears to be a, hm, historic workaround?
> If I was to guess what the motivation was I'd say that it's because
> "old school netlink" didn't reject unknown attributes. And you wanted
> to know whether the kernel did the filtering or you have to filter
> again in user space? Am I close? :)
>
> The flag is mostly used in the IP stack, I'd rather try to deprecate
> it than propagate it to new genetlink families which do full input
> validation, rendering the flag 100% unnecessary.

SGTM

Reviewed-by: Eric Dumazet <edumazet@google.com>

