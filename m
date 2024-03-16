Return-Path: <netdev+bounces-80221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79587DA85
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 16:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9C41F21C59
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E1182B5;
	Sat, 16 Mar 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="RaQPaHig"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80460134B6
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710601628; cv=none; b=Th0n8kQD4JiStU/CJP0nZiJJFcKToiAH4PHxGXPH3ZpPu8XNHDQDFLBm6DuyhEeFTfig/trkWCWPQjrsq/YWvVUuRoRD38uMYXScs4KxUqy5zzEa8bgzHXaUGBY1iw7U+nxiszdcu8Ol/4mWa1OxMLU4Vhx9oE/9b2cMnRaLf5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710601628; c=relaxed/simple;
	bh=xc0wOfwHP0tnVCnF8pvuBtJ7+s62XI9CbDQZRBbuKW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOlypRwPBPU4k9qSlJWnT/ZoCkFQAR8zJEJfmg04fxrBdkDBfZ7VKnstfibqXXL7ZcOzoO1jOEotl29GOLZQ7sCHpkbxfh78n7sKh4ShLAshvHI17oyzyWgqjVEe/M3FcPo2/CBIINyTuvR7YBpg/iMYaF6TRxZUnf0sfHbZyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=RaQPaHig; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2345902a12.2
        for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710601625; x=1711206425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBI0lbmrHALdF0W6xX/fVjoMi6UU1SsjJGnSeWgjFqA=;
        b=RaQPaHiggTZBTZStF2N2pDsg4Hr7LRxsRdYTGY0WAsfwp9Eqwbsufs1EUyWS8M8Azx
         nV3ZtTrSmZBZTm2jyMPQOdGXaNUQKqpI6nBR0otGx1aQEdiPE+Y+KhOEklG/vzw3/qoX
         6aHA9SELxmmjNl9go7jBTrk8I/JjTaMadoJtWkPBigfaJUOG46VU5hPXt0pdTJe2dl9c
         bdNAiZtAOAiAiOGxI/wUTvQ1ezM5MEtYw7zzaB7qXzCH1B9BkKOmPX8TUMlks54RLAEv
         xHUnJuu5mO4ANiSlBSSzVEh58l+c2tN5aj2BXvZK/5hhYY4gFrne+Zu4LbnskDEELUZy
         kKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710601625; x=1711206425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBI0lbmrHALdF0W6xX/fVjoMi6UU1SsjJGnSeWgjFqA=;
        b=SKiTANGByWFArVm894/M3Y26ELni96rvmkDql53v9uvT5nxrKN/KfcFNrkrn9SM0dB
         ls54XzQVCOG57t7ULP2JfEvF5o+xPWjJB8Lq0adWLLx20esTeUaKsrgM0T8T9VUQlTb4
         0PvJ898XgB523aKtl46pmqeS0Bhr9LCfWQegNJ4ZIJjJt8kJlC9HyP2iNv1jpDUr4oHa
         0KtpV68a3//I57SCuXAsQ/Q/M2KhC4KbZuNnw974+qWlzuIWGYt5SQHeN9H/Vu5PhPMH
         FmLM16GNa0p3lhG2J8mGsVrEijz9ANWZrOEOsIojBxMaqE5eB/dHeKgqAVCCKyiMKtZB
         GoCA==
X-Gm-Message-State: AOJu0Yxh45knZE676qsw+ioL99rgiscv6E/JTx8YbEGwR2Q3jinW8wHa
	rd5Nzp0T3NqEu3JTNtshygam76oYdpXhzOxFUP1B32MYA1HF00d8kU4AFxyAfnGaw6Suy3xYS1Q
	duIM=
X-Google-Smtp-Source: AGHT+IFUCvm/SGlgIdOZPrtln8XJOwR7ZaHjcphPg2Qum0cMmMObal4iPGBbUI1qCZNMbvIUUNjB/g==
X-Received: by 2002:a17:902:da86:b0:1dd:76e0:a19a with SMTP id j6-20020a170902da8600b001dd76e0a19amr9560635plx.34.1710601625502;
        Sat, 16 Mar 2024 08:07:05 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b001db5bdd5e3asm277916plg.84.2024.03.16.08.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 08:07:04 -0700 (PDT)
Date: Sat, 16 Mar 2024 08:07:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Max Gautier <mg@max.gautier.name>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] arpd: create /var/lib/arpd on first use
Message-ID: <20240316080702.4cb0ed9a@hermes.local>
In-Reply-To: <20240316091026.11164-1-mg@max.gautier.name>
References: <20240313093856.17fc459e@hermes.local>
	<20240316091026.11164-1-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Mar 2024 10:06:44 +0100
Max Gautier <mg@max.gautier.name> wrote:

> The motivation is to build distributions packages without /var to go
> towards stateless systems, see link below (TL;DR: provisionning anything
> outside of /usr on boot).
> 
> We only try do create the database directory when it's in the default
> location, and assume its parent (/var/lib in the usual case) exists.
> 
> Links: https://0pointer.net/blog/projects/stateless.html
> ---
> Instead of modifying the default location, I opted to create it at
> runtime, but only for the default location and assuming that /var/lib
> exists. My thinking is that not changing defaults is somewhat better,
> plus using /var/tmp directly might cause security concerns (I don't know
> that it does, but at least someone could create a db file which the root
> user would then open by default. Not sure what that could cause, so I'd
> rather avoid it).
> 
>  Makefile    |  2 +-
>  misc/arpd.c | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 8024d45e..2b2c3dec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -42,6 +42,7 @@ DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
>           -DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
>           -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
>           -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\" \
> +         -DARPDDIR=\"$(ARPDDIR)\" \
>           -DCONF_COLOR=$(CONF_COLOR)
>  
>  #options for AX.25
> @@ -104,7 +105,6 @@ config.mk:
>  install: all
>  	install -m 0755 -d $(DESTDIR)$(SBINDIR)
>  	install -m 0755 -d $(DESTDIR)$(CONF_USR_DIR)
> -	install -m 0755 -d $(DESTDIR)$(ARPDDIR)
>  	install -m 0755 -d $(DESTDIR)$(HDRDIR)
>  	@for i in $(SUBDIRS);  do $(MAKE) -C $$i install; done
>  	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DESTDIR)$(CONF_USR_DIR)
> diff --git a/misc/arpd.c b/misc/arpd.c
> index 1ef837c6..a133226c 100644
> --- a/misc/arpd.c
> +++ b/misc/arpd.c
> @@ -19,6 +19,7 @@
>  #include <fcntl.h>
>  #include <sys/uio.h>
>  #include <sys/socket.h>
> +#include <sys/stat.h>
>  #include <sys/time.h>
>  #include <time.h>
>  #include <signal.h>
> @@ -35,7 +36,8 @@
>  #include "rt_names.h"
>  
>  DB	*dbase;
> -char	*dbname = "/var/lib/arpd/arpd.db";
> +char const * const	default_dbname = ARPDDIR "/arpd.db";

Make this an array.
const char *default_dbname[] = ARPDDIR "/arpd.db";


> +char const	*dbname = default_dbname;
>  
>  int	ifnum;
>  int	*ifvec;
> @@ -668,6 +670,14 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> +	if (default_dbname == dbname
> +			&& mkdir(ARPDDIR, 0755) != 0
> +			&& errno != EEXIST
> +			) {
> +		perror("create_db_dir");
> +		exit(-1);
> +	}
> +
>  	dbase = dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
>  	if (dbase == NULL) {
>  		perror("db_open");

Missing signed-off-by

