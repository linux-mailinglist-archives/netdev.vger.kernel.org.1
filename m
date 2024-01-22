Return-Path: <netdev+bounces-64887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4016837593
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511B8285592
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0AB481CC;
	Mon, 22 Jan 2024 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhQJ8lHr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC653EA95
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959827; cv=none; b=g3BgO8Hnt2tRypE185/fQWP4wJraRz1juDss7An8Sbyt6ocqjILd/f28t6f/nqkHxkKlE8ZBc8ARhRlSToqEsI/fl5VRH3jZqlrPLKyxA5V2KI/HN76p+idICprOKEH986N8QHVPQ0MUGK7z3/gRgApz20sOwU2zeOsGx4WwQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959827; c=relaxed/simple;
	bh=I9C5xqxnnAgemuRHcSKUW5jBZMLUxmiyTLrOEGNYQD8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=pqZua4+zdfHQ07hxJ2SEBsBtI3/QVucYgsjcgdDE0rEKniCmeLu7m/5a4yVhjUxPnXcW23s0KPwTnkdpwmXt88pTu4z1umO1RAkhAcd4gE041mTDoWSlWYFt3UueiMmRasi0i1GBDFxTLfQyIVm+pYlojhIQ6ybP9uRAA9WgU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhQJ8lHr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so16078245e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705959824; x=1706564624; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtmwS9uSICuxVGkdR63++2qh5ZjV4LyrYBIrO67aycg=;
        b=NhQJ8lHrIvcqlmR7QKgI3twgL+ALZCX+Bxh14dt7TqUPEY4MsrHd/oNjLr/HHzj99T
         obGoW541mNMRKQo8fLjkKnkOGpNzR5oFteeIv4sCjHpFAK1p4GUhA+Nzk+GEjhZzjnze
         6NwodU+vssW3eGWgYgPpBPtgKIMjxEBbNC8uh+UZe3eCpgmwPz8hs5NRmJ8ZyNgVI+82
         M9BDEVASQgqM3asgbrl+1v9nE/DJ5eGFOmGzssQAfcklZQ5i8cqfzefs8bL3PS+1VM3A
         IwYYS06ixzZ3DjROmucP/4kyTdVoAY18O1HiFBYIQ3ODL5g86Wgl1jQkyP8ldCTW9b3O
         y/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959824; x=1706564624;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtmwS9uSICuxVGkdR63++2qh5ZjV4LyrYBIrO67aycg=;
        b=F0M0YUZMxPePHTy4fOLhx7jMjjBrjPwIewfG2cNBvtr3jumRd+Ap55GqwbahE7kYW9
         rZG0DBSNKJZ439BJZ53Ez/3ueSnunL/h51F3NM1bVbEmq1hIwhlOxlgTEs94TPRDTIiM
         nqe6/QoRrnyTHqzLIAd+iRY7+I/WpTIGVxRIk+gk/gSR3yp2g0c0B1LTwJcgqMM+eIIa
         qSDbq5PVktiAvWYUVD8F7rxtMD5SsUn2g/wCISe0r9XTea0pAWnZh77OVyedLS8AJBfg
         +nvGy2qjQfvbSE9zWN8I6bJqpTPi+Ujv2OXHDMn+2shrLdA+GET2aBYZfaIG9Y1fYV3Z
         qOLA==
X-Gm-Message-State: AOJu0YzUYhUmyd7TyL084WYcFI0zXAnXdKm43ddmDrkHKsXRy1y64Je9
	TbQIeBxczcuGqj111CXgRIFYeHQyhUXKnflrwMJvJza08Zwp5+E+
X-Google-Smtp-Source: AGHT+IHepKC6skw0NNlmf6JVLFoDIgFxTIf/8bZ0xSEB6YnimOPVk9ToyuZmoM6HLa3tdgc4XiZ0jg==
X-Received: by 2002:a7b:cb93:0:b0:40e:431c:76d9 with SMTP id m19-20020a7bcb93000000b0040e431c76d9mr2488324wmi.148.1705959823742;
        Mon, 22 Jan 2024 13:43:43 -0800 (PST)
Received: from smtpclient.apple ([89.150.15.164])
        by smtp.gmail.com with ESMTPSA id fl21-20020a05600c0b9500b0040e9d507424sm14010247wmb.5.2024.01.22.13.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 13:43:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Donald Hunter <donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next 0/3] tools: ynl: Add sub-message and multi-attr encoding support
Date: Mon, 22 Jan 2024 22:43:31 +0100
Message-Id: <88580D1A-7F70-4598-8E2B-18A85174EEF8@gmail.com>
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sdf@google.com, chuck.lever@oracle.com, lorenzo@kernel.org,
 jacob.e.keller@intel.com, jiri@resnulli.us, netdev@vger.kernel.org
In-Reply-To: <cover.1705950652.git.alessandromarcolini99@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
X-Mailer: iPhone Mail (21D50)



> On 22 Jan 2024, at 20:19, Alessandro Marcolini <alessandromarcolini99@gmai=
l.com> wrote:
>=20
> =EF=BB=BFThis patchset adds the encoding support for sub-message attribute=
s and
> multi-attr objects.

I have a longer patchset that covers this plus some refactoring for nested s=
truct definitions and a lot of addtions to the tc spec. Do you mind if I pos=
t it and we review to see if there is anything from your patchset that is mi=
ssing from mine?

Thanks,
Donald

> Patch 1 corrects a typo and the docstring for SpecSubMessageFormat
> Patch 2 adds the multi-attr attribute to the entry object for taprio
> Patch 3 updates the _add_attr method to support sub-message encoding
>=20
> It is now possible to add a taprio qdisc using ynl:
> # /tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml --do ne=
wqdisc --create --json '{"family":1, "ifindex":4, "handle":65536, "parent":4=
294967295, "info":0, "kind":"taprio", "stab":{"base":"000000000000001f000000=
00000000000000000000000000"}, "options":{"priomap":"030101010101010101010101=
0101010101000100010002000000000000000000000000000000000000000000000000000000=
0100020003000000000000000000000000000000000000000000000000000000", "sched-cl=
ockid":11, "sched-entry-list":[{"entry":{"index":0, "cmd":0, "gate-mask":1, "=
interval":300000}}, {"entry":{"index":1, "cmd":0, "gate-mask":2, "interval":=
300000}}, {"entry":{"index":2, "cmd":0, "gate-mask":4, "interval":400000}}],=
 "sched-base-time":1528743495910289987, "flags": 1}}'
>=20
> Alessandro Marcolini (3):
>  tools: ynl: correct typo and docstring
>  doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
>  tools: ynl: add encoding support for 'sub-message' to ynl
>=20
> Documentation/netlink/specs/tc.yaml |  3 +-
> tools/net/ynl/lib/nlspec.py         |  7 ++--
> tools/net/ynl/lib/ynl.py            | 54 +++++++++++++++++++++++++----
> 3 files changed, 53 insertions(+), 11 deletions(-)
>=20
> --
> 2.43.0
>=20

