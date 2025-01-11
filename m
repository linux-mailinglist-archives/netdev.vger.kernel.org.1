Return-Path: <netdev+bounces-157413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFBFA0A408
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF59188BB68
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1B1A4F21;
	Sat, 11 Jan 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxNXuMJ5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE81DDD1
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736604306; cv=none; b=J+t0752HnY27mInUyhuaUb5KCeujRg8J6hIMU3Gel+0XYMp7nCyiczrL1lXCiAMw98oAw4BupePFDc7G3+GUIBxgZyfA3qLSLJ+7pKAZMnlZ/FlUYZKYGSCeJlO1olhGbylcE6eWTcSJaxWd8lbm7b/RKJz6enCSxmCxNv5E8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736604306; c=relaxed/simple;
	bh=sYol7A8k/pFys9eYxfpY7noE4Jt/hUO0dik5egIb4Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttGyt3KEHnaoTwtCHnfmpcmRFxqKCxgIK6i+R2rBzPxZPoU2BjfhpcL7Hz8JiF9nhWqLuupHzD8X+tpQsiGRhDd1jgSlZs1ZkPbk9oCFGtjz468rD6YE09+/YxTHo5yGmo3Or1BEwIYtyeK+FoC59WxownGOC3q0/s93A6m1si8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxNXuMJ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736604303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LlFf4NEiSPp/pO4s6/zlHoBfHd6SVprzNJOhJJLaxQ8=;
	b=bxNXuMJ5dDV7c0VCNbFIoF7ujDDxlByUm9yCh5nl3fGUWjIXvw6FmZc1d8Eq7Md+SvkUd8
	h3dtfYN9iHiVLSCclw4mdO5paoKTLoltw3nwI8U2o4UwMCuRZPt5x0A+tXN7lxCcjpL3SW
	qt2hKIjxoAhGYCaDPNQLK5NkXqrHqcs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Aq9YukfbO5Km3sal0ipFVQ-1; Sat, 11 Jan 2025 09:05:01 -0500
X-MC-Unique: Aq9YukfbO5Km3sal0ipFVQ-1
X-Mimecast-MFC-AGG-ID: Aq9YukfbO5Km3sal0ipFVQ
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e54d9b54500so6377361276.3
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 06:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736604301; x=1737209101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlFf4NEiSPp/pO4s6/zlHoBfHd6SVprzNJOhJJLaxQ8=;
        b=kQyHdxU+npx2Pgoz9SPFIdBYqHS8bnnDfziSs/FOGZqQf5rfiysJpJnURB8GnWh8r7
         RGf949X8Yxbq+qkZejm7IGCBE0CoxaWQneJlwirpnvl3jUIJKqnmnA/jsk5JUJkosLTm
         Vr/i7rI+a+rVb/Y0z3d4Oyby/1vHXKq5eirhusxLnrbl8gDcFl0SiXqCJEgfvTtuYK4F
         8KRGNwKgw+/IYUU5Kz8zVAMs5ddPMFEDhLgRDJimExZxCD9U/JJ3t9wFunEIB4XkGMq8
         JqzF9rKKPIGjJOFGU6QhqOEcdXI5SsVoXmaO4RxqX32srpUUAKHYPZzwTVxkuCrZHQla
         qe/w==
X-Forwarded-Encrypted: i=1; AJvYcCWDR1rRsO6TfIcGo9v8EbNmlRsac/LsTop0Y7XHKhPOE9qZdlK5fa3A0VQE18oleoLmQ4Jd43c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgm8YlTQT1aKqXA6CwYu+McGUTWVc5D6uVIApJYwPp/EV2R3z
	2W0hgv7GSmPpsEXNnSQrJmuE2Zv5Nh5cSrfl+pRTz4aDCZCS82EgqG6QML85gZiOTwOrcgrQLdt
	Q4Qg+j5apl74i9IbThLhMC/th2uw4t+X9HcUfescQj5YuoFHniFtBAOETfsws5R85+5J7bopD18
	oQi2L8a3pOwH+3PWcZyosI98iqF8IQ
X-Gm-Gg: ASbGncsb0lvhPV13cju+UbhRb9tVKFBCP4tZk/SSRLbPDmknx6UAYHUSU/FMb1Oh2iv
	Km984Jjr19ykqNPijimJpVz4JHT7ssCGnveXjaWsZBSb9k6FbpVgm1/skdD2kpW8+WUU=
X-Received: by 2002:a05:6902:1b8c:b0:e4e:723f:caca with SMTP id 3f1490d57ef6-e54edf41883mr11882738276.5.1736604301299;
        Sat, 11 Jan 2025 06:05:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/DZbwpddKlcSWRAfZFle6MdUL9L6aJFs0FV2I7Vaar9m8a1tzt6ROb+GQLg7pGjvUsqJ6M5OXEkdlbvTn6cY=
X-Received: by 2002:a05:6902:1b8c:b0:e4e:723f:caca with SMTP id
 3f1490d57ef6-e54edf41883mr11882716276.5.1736604301006; Sat, 11 Jan 2025
 06:05:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110144145.3493-1-donald.hunter@gmail.com> <20250110170840.0990f829@kernel.org>
In-Reply-To: <20250110170840.0990f829@kernel.org>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Sat, 11 Jan 2025 14:04:50 +0000
X-Gm-Features: AbW1kvY55tTYp2lgCZm6SmMZmOoQzkLlaACVD2hBZztHa8FRGdgoLJxcWPypgW0
Message-ID: <CAAf2yc=PjJTrrbOY7SM-TEqqLyduaeMjRsdSHNXWV1bFfkU6Fg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] tools/net/ynl: add support for --family
 and --list-families
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jan 2025 at 01:08, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 10 Jan 2025 14:41:44 +0000 Donald Hunter wrote:
> > Add a --family option to ynl to specify the spec by family name instead
> > of file path, with support for searching in-tree and system install
> > location and a --list-families option to show the available families.
>
> Neat!
>
> >  class YnlEncoder(json.JSONEncoder):
> >      def default(self, obj):
> > @@ -32,7 +50,14 @@ def main():
> >
> >      parser = argparse.ArgumentParser(description=description,
> >                                       epilog=epilog)
> > -    parser.add_argument('--spec', dest='spec', type=str, required=True)
> > +    spec_group = parser.add_mutually_exclusive_group(required=True)
> > +    spec_group.add_argument('--family', dest='family', type=str,
> > +                            help='name of the netlink FAMILY')
> > +    spec_group.add_argument('--list-families', action='store_true',
> > +                            help='list all available netlink families')
>
> Do we need to indicate that the list families lists the families for
> which we found specs in the filesystem? As opposed to listing all
> families currently loaded in the kernel?

That's a good suggestion. I'll update the help to say families that we
have specs for. Will also try to add something to the help about
loaded families.

> Some users may be surprised if they run --list-families, see a family,
> issue a request and get an exception that family is not found..
>
> I guess OTOH we also list spec ops in --list-ops, so there's precedent.
>
> Up to you.
>
> > +    if args.family:
> > +        spec = f"{spec_dir()}/{args.family}.yaml"
> > +        if args.schema is None:
>
> Could we only do this if spec_dir() startswith sys_schema_dir ?
>
> We want to make sure schema is always validated during development.

Yep, makes sense.

> > +            args.schema = ''
> > +    else:
> > +        spec = args.spec
> > +    if not os.path.isfile(spec):
> > +        raise Exception(f"Spec file {spec} does not exist")
> > +
> > +    ynl = YnlFamily(spec, args.schema, args.process_unknown,
> >                      recv_size=args.dbg_small_recv)
> >      if args.dbg_small_recv:
> >          ynl.set_recv_dbg(True)
>


