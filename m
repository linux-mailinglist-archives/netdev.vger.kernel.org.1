Return-Path: <netdev+bounces-152229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2FB9F3266
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504717A224B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903862066DC;
	Mon, 16 Dec 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSRUP7dc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6A206284;
	Mon, 16 Dec 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358234; cv=none; b=ijPa7oEWWpKUWZ+hPx2JUxY2We0surQPwa0JfTaQCk0E2JfhT87evLqHqhxYOcEdINIdOJFFa2ee6saDH97TGP471BbNN0kuSdlqCgyIclhy76yjfZXNmuWYDxSLmzMi/Eunst7GMkeKxQHfV4YZP947aNY2gbc//RNT9mRgU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358234; c=relaxed/simple;
	bh=IDxhcv0YrqyvrNkAnxSC+WSCaccxp8oEIkrJ4llFEAg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=aZyVMSpmLvqfu1NPVebUAMaZd2ACVrnIgCbzqXW0NxGe/WPQa+aPDC2iV/L/B/+G2Bk2B6OyCChVl+at2UNlN5tqT8rcyZHoRScy05Ovr4/9xknD/z07a+DcrGRqhdLcBRoFgEkPBuTxgw++Go59rwe4madOEBPz5vmvQbxlH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSRUP7dc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so2147848f8f.1;
        Mon, 16 Dec 2024 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734358230; x=1734963030; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHGUggi4KWk7b9dNu2KvnRj9xlQayHW6VmghHC4yAKQ=;
        b=TSRUP7dcykZQFdJ/hxU36nubZnH1A6Mxy5DUOgX0yijp9d9QRQB8WsI0Mku3RYBa5o
         y02kpPOFxqj5A2buYPISqAfr8Bz/OXzRL9Nb108GiBenqSPRmkc/N6Uq4y6FmdTZf2XZ
         Nz+im13BptvnVwMx85Km4L3lPTy93rY1TwPMUYF0ZLkxGPko58MvOtkH7SiHuEi+kj5z
         KR8IEjBiv/dFQ+4bYjGuIJK1C2NETy7++LtSnfj+KbCUoQzvC/7Gn/OmifoJswszIOvb
         ceGKQWd/DSmWV911fi1P33zcGDuDhKxfMgsfLHKfaWD1h77qNY+srxD8msZLNpmmQO5G
         m/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358230; x=1734963030;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHGUggi4KWk7b9dNu2KvnRj9xlQayHW6VmghHC4yAKQ=;
        b=qSCuZ0QhZzmG5OPtlQKuCH18AHLZXZu4c3AFle2LfKvysrh31rC/anhSFinbZC7Y6f
         0LRet0MFzS11AxKn+NNPoBxjviG0hjWHHUWetMtsDU88MiGETF+ycC9ppqJbYjlmWiz8
         5ZvYhhBkI7602lHWPfhNF6bWYTi9uC6cIf7gz+rk6y4yT55/YAXxP/DddYoCaq3cHztn
         RvuuAJ8doPJLZeGV+ywU1hKqyamVC/LLu7ycgrCYO6h89AmnDhG43irVBVFlWSvlIrrt
         aRwIK575rUU3XvvV4TYdGWqu7v3uo0R5ci/Be9i3tB/rz6g3tE+z8xtlzVknBpUQWjvB
         QObw==
X-Forwarded-Encrypted: i=1; AJvYcCX8FhNr3DYLNrB9jtHCVshTVR4WjGyyGONbAJkqeiR5AUsP2NcsNXlDMJIezhkKE3DYg/fS7/nW@vger.kernel.org, AJvYcCXlxCHfSfzx1piyevkjmsY9BM1cUT0Gd3WxgFQIRjABzUuEAcCjvsiU2+rgxUt/as8sshPfHIdDRgzvQt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypcIdS21Zz2cE8d2LWjdaRb9ffhbdoB8fEqD5/zSIeSwJYEpJf
	pN1/1vbd5lsrOe+88FqWBPkv168ERarg+TgZaJlAs428qveODMx+bJVUqA==
X-Gm-Gg: ASbGnct1DIEzfob7gVVdOEx5MJpjxxYmeI8LsZmWhbLLYxfXqNasobMmujQRWK5z0JG
	FuQM6VpsqwT0rb6FIn3g7T+uvUne0ka4/oJkTR4vohqgDUscDbJOJa705oHN1DzPMjpy0obwaRe
	2iMO+B123613Rhzet4G4rvB7rlrKuNOE/XtbtpostnwvPKS2773jj43h4UV7QBsKjTEAJbVsY/P
	Gr61N+vER1/fAI71idBEwmhnAsFgNaii9YETfFr+2JFap4+foR1U0keS5/R3C2Jd34O6g==
X-Google-Smtp-Source: AGHT+IGtJ4fxS2nw2pH+7WL2/DgrrFUnSjqVji7IeZa5963Kda96Q5zkGx7RLV7LUDhgMfLKtnSI3g==
X-Received: by 2002:a05:6000:1864:b0:385:df73:2f24 with SMTP id ffacd0b85a97d-3888e0f2d5bmr11187182f8f.39.1734358230282;
        Mon, 16 Dec 2024 06:10:30 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:3011:496e:7793:8f4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559eb20sm143381465e9.21.2024.12.16.06.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:10:29 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: stfomichev@gmail.com,  kuba@kernel.org,  jdamato@fastly.com,
  pabeni@redhat.com,  davem@davemloft.net,  edumazet@google.com,
  horms@kernel.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] tools: ynl: add install target for generated
 content
In-Reply-To: <a2e4ffb9cbd4a9c2fd0d7944b603794bff66e593.1734345017.git.jstancek@redhat.com>
	(Jan Stancek's message of "Mon, 16 Dec 2024 11:41:43 +0100")
Date: Mon, 16 Dec 2024 14:01:06 +0000
Message-ID: <m2a5cv917h.fsf@gmail.com>
References: <cover.1734345017.git.jstancek@redhat.com>
	<a2e4ffb9cbd4a9c2fd0d7944b603794bff66e593.1734345017.git.jstancek@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Stancek <jstancek@redhat.com> writes:

> Generate docs using ynl_gen_rst and add install target for
> headers, specs and generates rst files.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tools/net/ynl/generated/.gitignore |  1 +
>  tools/net/ynl/generated/Makefile   | 40 +++++++++++++++++++++++++++---
>  2 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/tools/net/ynl/generated/.gitignore b/tools/net/ynl/generated/.gitignore
> index ade488626d26..859a6fb446e1 100644
> --- a/tools/net/ynl/generated/.gitignore
> +++ b/tools/net/ynl/generated/.gitignore
> @@ -1,2 +1,3 @@
>  *-user.c
>  *-user.h
> +*.rst
> diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
> index 00af721b1571..208f7fead784 100644
> --- a/tools/net/ynl/generated/Makefile
> +++ b/tools/net/ynl/generated/Makefile
> @@ -7,12 +7,19 @@ ifeq ("$(DEBUG)","1")
>    CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
>  endif
>  
> +INSTALL	    ?= install

nit: mix of tabs and spaces here

> +prefix      ?= /usr
> +datarootdir ?= $(prefix)/share
> +docdir      ?= $(datarootdir)/doc
> +includedir  ?= $(prefix)/include
> +
>  include ../Makefile.deps
>  
>  YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
>  	--exclude-op stats-get
>  
>  TOOL:=../pyynl/ynl_gen_c.py
> +TOOL_RST:=../pyynl/ynl_gen_rst.py
>  
>  GENS_PATHS=$(shell grep -nrI --files-without-match \
>  		'protocol: netlink' \
> @@ -22,7 +29,11 @@ SRCS=$(patsubst %,%-user.c,${GENS})
>  HDRS=$(patsubst %,%-user.h,${GENS})
>  OBJS=$(patsubst %,%-user.o,${GENS})
>  
> -all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI)
> +SPECS_PATHS=$(wildcard ../../../../Documentation/netlink/specs/*.yaml)

You missed Jakub's request to factor out SPECS_DIR:

  Maybe factor out:

  SPECS_DIR := ../../../../Documentation/netlink/specs

  ? It's pretty long and we repeat it all over the place.

> +SPECS=$(patsubst ../../../../Documentation/netlink/specs/%.yaml,%,${SPECS_PATHS})
> +RSTS=$(patsubst %,%.rst,${SPECS})
> +
> +all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) $(RSTS)
>  
>  protos.a: $(OBJS)
>  	@echo -e "\tAR $@"
> @@ -40,8 +51,12 @@ protos.a: $(OBJS)
>  	@echo -e "\tCC $@"
>  	@$(COMPILE.c) $(CFLAGS_$*) -o $@ $<
>  
> +%.rst: ../../../../Documentation/netlink/specs/%.yaml $(TOOL2)

Did you miss Jakub's review comment: TOOL2 -> TOOL_RST ?

> +	@echo -e "\tGEN_RST $@"
> +	@$(TOOL_RST) -o $@ -i $<
> +
>  clean:
> -	rm -f *.o
> +	rm -f *.o *.rst

Also Jakub's comment:

  No strong preference but I'd count .rst as final artifacts so I'd clean
  them up in distclean target only, not the clean target. The distinction
  itself may be a local custom..

>  distclean: clean
>  	rm -f *.c *.h *.a
> @@ -49,5 +64,24 @@ distclean: clean
>  regen:
>  	@../ynl-regen.sh
>  
> -.PHONY: all clean distclean regen
> +install-headers: $(HDRS)
> +	@echo -e "\tINSTALL generated headers"
> +	@$(INSTALL) -d $(DESTDIR)$(includedir)/ynl
> +	@$(INSTALL) -m 0644 *.h $(DESTDIR)$(includedir)/ynl/
> +
> +install-rsts: $(RSTS)
> +	@echo -e "\tINSTALL generated docs"
> +	@$(INSTALL) -d $(DESTDIR)$(docdir)/ynl
> +	@$(INSTALL) -m 0644 $(RSTS) $(DESTDIR)$(docdir)/ynl/
> +
> +install-specs:
> +	@echo -e "\tINSTALL specs"
> +	@$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl
> +	@$(INSTALL) -m 0644 ../../../../Documentation/netlink/*.yaml $(DESTDIR)$(datarootdir)/ynl/
> +	@$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl/specs
> +	@$(INSTALL) -m 0644 ../../../../Documentation/netlink/specs/*.yaml $(DESTDIR)$(datarootdir)/ynl/specs/
> +
> +install: install-headers install-rsts install-specs
> +
> +.PHONY: all clean distclean regen install install-headers install-rsts install-specs
>  .DEFAULT_GOAL: all

