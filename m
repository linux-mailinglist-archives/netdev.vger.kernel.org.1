Return-Path: <netdev+bounces-181262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBFA84373
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7703A3BE806
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCA2853E5;
	Thu, 10 Apr 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq4bLORp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4118E2857D1
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288771; cv=none; b=L/IbfYKN8NF8c00WbTahnxyaaU1gqbxVSj8JCnkqKg3sMAvv9tcLMsDKPnfGO2EkmEYbmxi2ixpnxKkzTC2OZu3mVXirE3g6W6+9qUAnYKvHMNLDxBrAST6VHzLmCYsM73RLNpRt/P6tofxg6nfWVbn3OLOmVfKfDovizqCZqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288771; c=relaxed/simple;
	bh=dxsqinKCBDby+aMcRg8hozEEbtmWKqBAKl7vn+kBb+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJzIAiOhDtQRrTCGztcl+2jqzzGnh6xVVyhwyaXkmDCTLwvImVMvmLIH58aLnrIsxmVAy3lsHqR7VSI/HrkracZi3IAWEoJDQj96e2xJItucuwe7fs8AQr42gkswqNpuBis5cp/50dndBPHJv7aCz417gf1t+GR9WJbVbTo8R1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq4bLORp; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72bb97260ceso258845a34.1
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744288769; x=1744893569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHpDfJyfsm5JQxko06+WtFGUMJCaVAWx7r2BKcpshlE=;
        b=Oq4bLORpipbs8D42r/O47XI/HfX3qf8boLwvyotHBc8ZSZ77ZQ8nEc6vQ42oBXiLZv
         K5QMa2kmvF4qhBrXqB3TY2jrhWCn5Sp/X6jnopHtfhgi8a+muR5JzNUiOzCmJ100r15D
         LnL1nSH9VwGpMrhY86RXF5saNjoRakR3TFTTi6fsvEYM8N4q+C24lms+DQByY91mS4QW
         6EaIreOdpMz5pdadeC91jctyoVP8deN4zXc9IK//W6Bn4WBr9Yr5Ximqgz2bEoWbbqOr
         IiQGKIkHkvCDpA5rwyIk3EnbtlB5cnj2M2zDvCt2SkMkDssIREJJxHBuzUoNqMS3qivC
         rOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744288769; x=1744893569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHpDfJyfsm5JQxko06+WtFGUMJCaVAWx7r2BKcpshlE=;
        b=ScXxEzPUgH0ojpFRN/fKqwvjiGly6lhPrQtZx9+ZsM5r5Q7N6H3R1As/SueLX9VIlc
         fEH8L7XUGKh1jlogBl98hg5J7ik3rkTizKobSzCGqx/zFB5vJxMkKi2/EowGBftFSP9K
         cQcPgZOTPhQEFl33vgMxWnALWzYfUGjo69Ysn9LXklTHC5ANSnTiZ//enRFmWrBgmnYC
         VmPA3clRZqj6R798tX4O7Os3AQSicMRTjxJpA5C/K2KkVOYqGJj219XcqkgcvnTg9WYG
         YE3BZ0Ba9Bv6igywQ7a+XG/D8DUu+FSqCVqKM5a38lwkoTbQBbdj3N9oyuP/MEofY8wI
         +XHA==
X-Forwarded-Encrypted: i=1; AJvYcCUxB2P5zso8ISjhuoA3F7x6bERZKGtgcecOpjvGpRP43wXrDWjeLhsxJszYHpphqEuCnvDcVJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWBGf+3bYmNznmUGA27PzKAIsSSc4TW7RukmF/Lf+JZ2Oy+bH
	d0b8L9pxnxSuBmVf44srYsUdqxy9C8rXX7K6p6esijKnzyAiyaAeOC/X8IYRgUdatn8XyZXKdUk
	ne/3R1rk9lN/FfGdoYHuWBWeU+rw=
X-Gm-Gg: ASbGnctVPFwl7N41TqVI1SnbtobZFUCA1Sbqg+E1glka/jgnvOLHeq6+uAEVjT0T857
	g6EowIzq6zZOwslla1ulxNghLseheaqjWjXVc6/HhbAVBV/yUTrVKSa/Jv1hjTedaXNX0lvFTEf
	q6qrIroAJ8xlN4He+u9aV7eDBj2kQ7n3XCn+rUoR36MehtQYyszdg=
X-Google-Smtp-Source: AGHT+IH6gsFYS8VK2ZemAScslG5opdjCmEmPt96ql0j29DuCFkAHUHIxo8hEFxcC1U6uPeFcq3/DVbvo82leVRWHIlo=
X-Received: by 2002:a05:6808:1a05:b0:3f6:6cbc:9326 with SMTP id
 5614622812f47-4007bd4169amr1224486b6e.29.1744288769278; Thu, 10 Apr 2025
 05:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410014658.782120-1-kuba@kernel.org> <20250410014658.782120-2-kuba@kernel.org>
 <495e43ef-ae20-4dda-97c0-cb8ebe97394b@redhat.com>
In-Reply-To: <495e43ef-ae20-4dda-97c0-cb8ebe97394b@redhat.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 10 Apr 2025 13:39:17 +0100
X-Gm-Features: ATxdqUEGVfBp8oKGlq6FQOR1EG92fmrrGVlEIpMkH1XdSAdsjWvAigoBDPW0H9E
Message-ID: <CAD4GDZw+Enkd2dA8f7pNxMadwURFd_tHv1sUwkXqFqxsOquHQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/13] netlink: specs: rename rtnetlink specs
 in accordance with family name
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jacob.e.keller@intel.com, 
	yuyanghuang@google.com, sdf@fomichev.me, gnault@redhat.com, 
	nicolas.dichtel@6wind.com, petrm@nvidia.com, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

Yes, Documentation/Makefile goes the extra mile to only try deleting a
list of .rst files generated from the list of source .yaml files. It
would be easier to just delete
Documentation/networking/netlink_spec/*.rst which would be able to
clean up old generated files in situations like this.

On Thu, 10 Apr 2025 at 09:52, Paolo Abeni <pabeni@redhat.com> wrote:
>
>
>
> On 4/10/25 3:46 AM, Jakub Kicinski wrote:
> > The rtnetlink family names are set to rt-$name within the YAML
> > but the files are called rt_$name. C codegen assumes that the
> > generated file name will match the family. The use of dashes
> > is in line with our general expectation that name properties
> > in the spec use dashes not underscores (even tho, as Donald
> > points out most genl families use underscores in the name).
> >
> > We have 3 un-ideal options to choose from:
> >
> >  - accept the slight inconsistency with old families using _, or
> >  - accept the slight annoyance with all languages having to do s/-/_/
> >    when looking up family ID, or
> >  - accept the inconsistency with all name properties in new YAML spec
> >    being separated with - and just the family name always using _.
> >
> > Pick option 1 and rename the rtnl spec files.
> >
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > v2: extend commit msg
> > ---
> >  Documentation/netlink/specs/{rt_addr.yaml => rt-addr.yaml}   | 0
> >  Documentation/netlink/specs/{rt_link.yaml => rt-link.yaml}   | 0
> >  Documentation/netlink/specs/{rt_neigh.yaml => rt-neigh.yaml} | 0
> >  Documentation/netlink/specs/{rt_route.yaml => rt-route.yaml} | 0
> >  Documentation/netlink/specs/{rt_rule.yaml => rt-rule.yaml}   | 0
> >  Documentation/userspace-api/netlink/netlink-raw.rst          | 2 +-
> >  tools/testing/selftests/net/lib/py/ynl.py                    | 4 ++--
> >  7 files changed, 3 insertions(+), 3 deletions(-)
> >  rename Documentation/netlink/specs/{rt_addr.yaml => rt-addr.yaml} (100%)
> >  rename Documentation/netlink/specs/{rt_link.yaml => rt-link.yaml} (100%)
>
> My understanding is that this rename triggers rebuild of the related
> doc, which in turns leads to quite a large number of htmldoc warning,
> but it's really unharmful/pre-existing issue.
>
> /P
>

