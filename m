Return-Path: <netdev+bounces-197766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75127AD9D55
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F280189A473
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8A70808;
	Sat, 14 Jun 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4BdxzNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBFBA2D;
	Sat, 14 Jun 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749910538; cv=none; b=TDXtrhYWkVT4FmC9Kqi4IjNj4eRh2O8u25rw/QG+M+k5w98NBUYxchcxOUPpYx+N4Hr1UWpA+6hCq1M6iFB60JVUx7gxGrgYtoZPqmjDLpFpJOr2TXSImB7QcUsRBi8ECdYtprqAy7plT0YsYR22TRWz9iv2lpp6BnppQDy42mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749910538; c=relaxed/simple;
	bh=DCmUzencsMsnMaFx/4U/i7fCe25jewj1ptzTPHuZXrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQrJ47HpAqaHEUHfFtS7FZL5CEaUFrI3UWYiOB2Un0QcvWDxykJAsCqeCQmdRBWjHmNChotsAJGxdpQ+i+gBXfrEmcvtgSdRiuYN8MIrQd4qCf7h13HqjSVrWhDNTECS/dh/0+wQpKGefbAT/5WNj1cBlD+Zepvt0qx09/cZRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4BdxzNZ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40a6692b75cso2162702b6e.1;
        Sat, 14 Jun 2025 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749910536; x=1750515336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V212NBLelySDp+6/CyeJaC/8PZkKsYoStFWQx4jyJv0=;
        b=P4BdxzNZvQYl0LFplGrz7lFcCyH2VDRiV1wAtlTS2LZ4sHh2IZMsfefZkT55swTr1/
         UDL5duafN7cBRAbNFB0v9i4vtluyJO+jxHrbr6DvA2uNQnlRdjhzWBc1cEtjRQaVBWHA
         0Wts33em6zLAFZYqofs5jSaXvaR3802MNc7lN7XHIk350kHVDd1reS64HSy36nm/QFC5
         cNYlHtaSvnSFKdkde7X4G1KZ0ZnqD61jIbggZnelwcxk0dL5gXIKOJp+RuHcf7Hf9TPU
         SUDLUzzDo10MYhYCVzRc31K4EzQlPb4eJqGv9JgZlkciC7oNnb5P3uzU068Vrmg1Emro
         6CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749910536; x=1750515336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V212NBLelySDp+6/CyeJaC/8PZkKsYoStFWQx4jyJv0=;
        b=ol7yqg+J7bit8kA5vebqJQm4XjN0iZygrDZ5w+SGZPILiKdpGieGa/RDVPsc4zcQ0o
         o9qKl67JvFnTxcX29OmC0kq//LDy0gjJ98IEdSR26u3YrKNjf1HTeCTgtK5iNLrKg3Di
         H5etER1dAUUmsbz4zS2J65YSt/SVIx+GUTzjfmPMbvTRImEr5dWjpe1yC4PfFVd7KgYw
         n5efEypfsQiUtmhrm/xTP4WGf8+brTUgRxQbWXgVqDinkcGnw8ZI3uUwt487wAUbXoAq
         FSrmAj6iqPspqOJ2VtKby0runOkOa5QeIVfVHYdpX46IxoaLPmX45kobuhWpZwqj9KnU
         9SUw==
X-Forwarded-Encrypted: i=1; AJvYcCWWpvMQG0WToEXlVpXpvbG79Q/AcUDaxMKgbniz//L4UHUhlM7CKnvEckwbKI+prxNp9shCZkBc+Dy+D0I=@vger.kernel.org, AJvYcCWrFymQ9CLiQ3u2R2+Cg0Ue4PvqizJ/LMl7eL24Jj71a0wgnRvf8SLvXxvD/PAk1u57s6Y8cNhv@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKhnTGQue7mdpehwq9Tuxa30nkb2jBYTomqRSLXGET+WkHKHj
	VX42VsCy8ani3sOYD1Pp3a2HtLfF00ybXDgweZr35ZU9DX5dNW9c79jQyxY+9/wNUkdaVnkaBSn
	N3zQJ8ouPLPH/v0a7Cy8IhkfrHbDCpfw=
X-Gm-Gg: ASbGncsxtgPAwi0dNDtlggoIaTpH97w72EZ5i70WMU8BwRUCQDa9nXSiCwifbsTYA80
	Xu727TUBp/sqV0zHg4XdmcdHwA7KMmxmAIWfHMkTU8ZAAxdKeNoi5s/0r7dcJTZ1sMUTh0bLdA8
	d7gLdO2aKjXmzL9AeUB514MzFMQND8YkhDhuiu+UrgUOnT/rPTMFI2j3yhdWv138xd1KEwFdsFj
	Q32nSNxeWWX
X-Google-Smtp-Source: AGHT+IE7Id5T+q892mpAZrQTdRJVM/iBsvIslk9IkOAbJoYWxBoUYMFvgoYdDkNU0o3h51zEcveta5gNqzJQn1eG0z4=
X-Received: by 2002:a05:6808:211a:b0:404:1898:1a0b with SMTP id
 5614622812f47-40a7c19e067mr2049349b6e.31.1749910536255; Sat, 14 Jun 2025
 07:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749891128.git.mchehab+huawei@kernel.org> <31466ece9905956c2e1a3d3fc744cfc272df5d88.1749891128.git.mchehab+huawei@kernel.org>
In-Reply-To: <31466ece9905956c2e1a3d3fc744cfc272df5d88.1749891128.git.mchehab+huawei@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 14 Jun 2025 15:15:25 +0100
X-Gm-Features: AX0GCFu7jgqlSlj61VjuypZSCCHHVOKVJwT6Cqt0Oc5ACuVVfK8OEx-nZWS3V3c
Message-ID: <CAD4GDZxPTFmKeNqRZBxW1ij6Gy0L3hrbB6q9G6WdFb8h6Zhr=g@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] tools: ynl_gen_rst.py: move index.rst generator
 to the script
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Akira Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Ignacio Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, 
	Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Jun 2025 at 09:56, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The index.rst generator doesn't really belong to the parsing
> function. Move it to the command line tool, as it won't be
> used elsewhere.
>
> While here, make it more generic, allowing it to handle either
> .yaml or .rst as input files.

I think this patch can be dropped from the series, if instead you
remove the index generation code before refactoring into a library.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/lib/netlink_yml_parser.py  | 101 ++++++++---------------------
>  tools/net/ynl/pyynl/ynl_gen_rst.py |  28 +++++++-

