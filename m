Return-Path: <netdev+bounces-199448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB33AE0584
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5443BB898
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA572522A4;
	Thu, 19 Jun 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSDAlQcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011124E019;
	Thu, 19 Jun 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335609; cv=none; b=H10zo9oZxMxDOHGf2gMFu7elSGGn3lU9tTFNU+8tKF5RV+oBnO/TX3N350LnOuZoFLuQaXvyvxbD9JADSkloCmgvZA7PQRdxSu2thdS1eKD8bvr7wlEymqG/ZBxjXDbFfTS9ZlyNRhXOSL+wwbsVV+3ojAFkxEKoERJ114zyOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335609; c=relaxed/simple;
	bh=mhfIBh/bFaJ/GFxVs2Ar3YirycGFXc5ADMl6GKVDQYk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=V61fFlNcHSln090RK2zM7lHSxpF1lke5D5dRaduIQ9o4+zYUaOzwdKCyhlUHjRtaFOJMZh4KwvoCY0cyuLSJgo1SPLsg+YqI3UWrvcvXtEP8LxrpGU7D8w59FQRXLIcuwdgJfYYBaKn0SRYhq4pNncEeABBTA6NoWHxeEq5Ryqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSDAlQcx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4f379662cso679886f8f.0;
        Thu, 19 Jun 2025 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335605; x=1750940405; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nygRZhXsxMlH28nxkhtm4NH4pDec5lLwDc7T4mx9LAQ=;
        b=iSDAlQcxa16kTKZdEF4DD0RlM1MZXzGc9XhkM1SmNxhlRxx1WRrm8z4D8wysImR11b
         LIHuqfP38LySZp0K7bRzRXRNT4A5cLeQH8gUY0XQd8Ci61CTEIcL0zaLhG3pQ/nZ+MyY
         HxPaU7/XChTTZ8nmyWFURpTzfVl/xSAsqwPH1ukMy+AGwjoG/Sbgw9CUKfslftN04H1i
         81vN6ztCDL2P3e4rNFuK8YRGDk/FXfvSEJEHCuco8NSknNvc+RaDkVUAdxG76gd3xbh3
         YeJ3I4+nuBg/GdzV9yQ6m/vls154rbmPAwAzs18eOAp19IbvchYGzV2AyUTZCd5meu5j
         Bx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335605; x=1750940405;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nygRZhXsxMlH28nxkhtm4NH4pDec5lLwDc7T4mx9LAQ=;
        b=K7MQCuJDs05UPDp+Hayx4nJyHfPf0Wfspsb0ZDmY7DvimTaj8jGK/ZLvSP5JMWRU7q
         GmHjDvu7NDxII6eP9UzqDGkEt8aSse5S1yU4WkAb92kWhMBKpauKqO8uZ3AnUTEY/+Go
         Gx/QtqtdBHohTJ13wEuIU/FVyGptyDS6nA9CSo4lqoOss09wdDMEzG2IKSZiq+duLJ1f
         1DIEHkS9Cw7sKnQZrmf1ryLu8nAPzgtvQtybdZh4PDk7p3g6BwrKVn+BzjRuYOAFNQOL
         fkI/+s8l10WN3k32vPHORKv1aBpEvxThM2JT3Sehxxa5rLu14f2EXIEOIs6sWKLdFbH5
         iwag==
X-Forwarded-Encrypted: i=1; AJvYcCU1jYyZLXFy6el+M+gL/q+wWUF35iN/XtpaYnL+9LGnBv3BwtWnKLL5Cm+sfpiXThrJucPOAusAxcZMf9g=@vger.kernel.org, AJvYcCVrpV/XqTQ6Ndq6hEYzdC4cIkOf3lcuY/X2+89cp15R9p+n70PD7gCArCi4LIUur2bJUzwMWFrL@vger.kernel.org
X-Gm-Message-State: AOJu0YyJqSsQ6rgDqA50F4PYEc4MXeWeIPVXPHHbwJrQnEgBG2DkJUt8
	CU0TQMdFSai8bHL2S9OkzlYq2MHt3wklaa5KvyQ8m8PmohuZiEu35mxw
X-Gm-Gg: ASbGncs16yM+S+Vdx6XHc07SCDwiCNTi02YCufs5oasJ0SBhC0I3CMKAPL+4LW99hRR
	p2p1uSupSlMlF7KHFM/GkHu9M0k8EIGvn2DlG1pYO9yzwxI+G+R0c5nBf2ZB4jTLG4mgaCxdInp
	+Ei9EWsSQ1hsr9nN36pQUZxk973T3yNBpPLgg6LBvelbptx/n4tubEqh9tRxoqwaXVwWdv5SZcj
	9M3nVFYi1f6AjC9T7AGm+dSA05p7cSDMGX78NP7VY+YkleTqNF5etAbuV7woVcaYa3SxhtdrHP8
	YPb1x8J/iA5HmfHRORoPLvbFuLF1GB4vsiMDdzpNR+rI1teKWdRvlKRlbUFmdzSdeNDF1Uv5
X-Google-Smtp-Source: AGHT+IGe/eW8uV97j+Ytu4ZG/Iy5t6+Hp3owg5exZAVJPvvkIYpSPp5SobusIEtfHV7zrOM0RAnADw==
X-Received: by 2002:a05:6000:40df:b0:3a4:eb92:39b6 with SMTP id ffacd0b85a97d-3a572e58768mr15357688f8f.54.1750335605284;
        Thu, 19 Jun 2025 05:20:05 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:ad83:585e:86eb:3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a589092d1asm7161585f8f.24.2025.06.19.05.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:20:04 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v7 12/17] MAINTAINERS: add netlink_yml_parser.py to
 linux-doc
In-Reply-To: <4077605f84d7ba6423dcb5fda4e96ac950856f1d.1750315578.git.mchehab+huawei@kernel.org>
Date: Thu, 19 Jun 2025 13:10:38 +0100
Message-ID: <m2cyb0extt.fsf@gmail.com>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
	<4077605f84d7ba6423dcb5fda4e96ac950856f1d.1750315578.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The documentation build depends on the parsing code
> at ynl_gen_rst.py. Ensure that changes to it will be c/c
> to linux-doc ML and maintainers by adding an entry for
> it. This way, if a change there would affect the build,
> or the minimal version required for Python, doc developers
> may know in advance.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa16..caa3425e5755 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7202,6 +7202,7 @@ F:	scripts/get_abi.py
>  F:	scripts/kernel-doc*
>  F:	scripts/lib/abi/*
>  F:	scripts/lib/kdoc/*
> +F:	tools/net/ynl/pyynl/netlink_yml_parser.py

Wrong path now, right?

>  F:	scripts/sphinx-pre-install
>  X:	Documentation/ABI/
>  X:	Documentation/admin-guide/media/

