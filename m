Return-Path: <netdev+bounces-80229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368687DB61
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 21:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CAE1F21783
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D61BDD0;
	Sat, 16 Mar 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IwhdEErV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB51BDEB
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710619397; cv=none; b=g2IkqPFL9VZRuPzODYXizI0BzgFuKR/idGemGVcSCi1TYBLJFLWsTkijE9IkTlf99yuBbTGYDAbnY5acm3G7YHtapzLYZeMnGFPCbf4/LY0ftTyaf6SRXriJXXc1jF5p+ShXqJy7LZQ4ZnI/n6QgmKUBUwEqfsvlN2x28+iS8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710619397; c=relaxed/simple;
	bh=H7Qm4sfnvXppIxlgsMHU+Yo7iYW5ygWZXqKxd3nZ7qc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=vCDw4AyNomsPHqZbpTaz6RYh4qeHiTTergFj3A5O5RauxDlhFEiQK41WXtjuvj2LBwGj9NmwBDFY4bFV7A4Kntjmbu/cUVdJ1gwv9pBs+ob0pAs+v2lktP6AA4ZYQTaxgOxgBNyWWjwoWqLRilz4I8pQCJzFkAoL8lA5ojXe9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=IwhdEErV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C15FC3F120
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710619000;
	bh=TP2KNC11l4nDmaxHecYL48vE/SAz/Ax5xMdjIwUIOjM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=IwhdEErVEZblDlLNVd6O/bCFWjM0+pYAZKgkz9doQmc72SV7QTwuHmy74Q24OoOth
	 8PpsBkHR+8lkTBL9ZeHj19RV7aUFX5sq8Es8CUp0h9wuvSyVrbr4vV0P7kn8t+NfjG
	 g1lG0UjYEGx7DPKUx3v5mMygkccpFjp8CVcPyKr87N1XE7kwQeng1cJNvUiem8Pm+n
	 AwvkBiPBVvkBT0Xh4aKAczWzpfgOCbvnZIWG3dmWnXYFl+QKie5s/OKkXfdsoRv8Fs
	 7xVcZOWtubFkY9sGWlPC8Cl+yzTTNHLLUOShpsyxiEfCMUsZ5KCJ4TT/i5lM4wXSU8
	 fY8Xsvf+MuO2w==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29df3d9c644so1583915a91.1
        for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 12:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710618999; x=1711223799;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP2KNC11l4nDmaxHecYL48vE/SAz/Ax5xMdjIwUIOjM=;
        b=Ule5OpnwUORBLIAkCvUFlVXe760gtahEaLNq/OwJDpx0QReOAL9xVM3Gqjwecb0twe
         2JNhcRrS02HlOr3ISVPfM8DsSdzUfOBS9zMZxi3bTzmB1pPXJcxFKFjPJ+4eZcCINdtS
         pT6CXKzRASTWh2aXIqxXUT/cFvW4RXkWVx8I985o2/zYXlf2KpeaHZz4ASxfQV2ZwrD6
         RmCjLWZo7P3Of5YBk5UYwfcAhcqouF5C03H2pQMpFCXzMzKKxGN4kCCn4A8myxCxGgeV
         DV/R27mtLWYJWlx/ZJWNw8luiq+9/ImzP/lIDd9I9cemkr71a58I8rSJrAT9pYNhzkLc
         iqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOxhvbe0OkXSf9+myWp4YcrfkwRwHqv4LZ/Iksuaf/JgcidE9Ph7RUJK1KoiXJx4gnbOPdUkTNpto1dEbrXTuGNnquGs5p
X-Gm-Message-State: AOJu0Yz8flILixGd2AMVayTwjSISbdJOuLfygD3yCFxs3IQjEOJQyOCR
	lZCYmnwOadurmTXgD6rioOthfRiBRAe5zJlxJlZfQe21hExsk2ijlbPEhoXAFOhLThBqfXFmamp
	p4v+R9Fto89NyV0RsLfYJVGmYQrFpNuNZanhKKhpy0lfhtZ65CyF1lDj82Uexng/YI6Dt/Z9QRq
	H3WA==
X-Received: by 2002:a17:902:ec8d:b0:1dd:8c28:8a97 with SMTP id x13-20020a170902ec8d00b001dd8c288a97mr8053476plg.6.1710618998874;
        Sat, 16 Mar 2024 12:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQPjSA5VWm1eWEHxYVBfoRACEU/GYpIHLZTucbloG7NzFugpdl/7gfUl05unyEyz6jY+O0jA==
X-Received: by 2002:a17:902:ec8d:b0:1dd:8c28:8a97 with SMTP id x13-20020a170902ec8d00b001dd8c288a97mr8053456plg.6.1710618998181;
        Sat, 16 Mar 2024 12:56:38 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903120e00b001dcfaf4db22sm6161041plh.2.2024.03.16.12.56.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2024 12:56:37 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 23EFA604B6; Sat, 16 Mar 2024 12:56:37 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 1CAA89FA74;
	Sat, 16 Mar 2024 12:56:37 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: Max Gautier <mg@max.gautier.name>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] arpd: create /var/lib/arpd on first use
In-reply-to: <20240316080702.4cb0ed9a@hermes.local>
References: <20240313093856.17fc459e@hermes.local> <20240316091026.11164-1-mg@max.gautier.name> <20240316080702.4cb0ed9a@hermes.local>
Comments: In-reply-to Stephen Hemminger <stephen@networkplumber.org>
   message dated "Sat, 16 Mar 2024 08:07:02 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3015.1710618997.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Mar 2024 12:56:37 -0700
Message-ID: <3016.1710618997@famine>

Stephen Hemminger <stephen@networkplumber.org> wrote:

>On Sat, 16 Mar 2024 10:06:44 +0100
>Max Gautier <mg@max.gautier.name> wrote:
>
>> The motivation is to build distributions packages without /var to go
>> towards stateless systems, see link below (TL;DR: provisionning anythin=
g
>> outside of /usr on boot).
>> =

>> We only try do create the database directory when it's in the default
>> location, and assume its parent (/var/lib in the usual case) exists.
>> =

>> Links: https://0pointer.net/blog/projects/stateless.html
>> ---
>> Instead of modifying the default location, I opted to create it at
>> runtime, but only for the default location and assuming that /var/lib
>> exists. My thinking is that not changing defaults is somewhat better,
>> plus using /var/tmp directly might cause security concerns (I don't kno=
w
>> that it does, but at least someone could create a db file which the roo=
t
>> user would then open by default. Not sure what that could cause, so I'd
>> rather avoid it).
>> =

>>  Makefile    |  2 +-
>>  misc/arpd.c | 12 +++++++++++-
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>> =

>> diff --git a/Makefile b/Makefile
>> index 8024d45e..2b2c3dec 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -42,6 +42,7 @@ DEFINES+=3D-DCONF_USR_DIR=3D\"$(CONF_USR_DIR)\" \
>>           -DCONF_ETC_DIR=3D\"$(CONF_ETC_DIR)\" \
>>           -DNETNS_RUN_DIR=3D\"$(NETNS_RUN_DIR)\" \
>>           -DNETNS_ETC_DIR=3D\"$(NETNS_ETC_DIR)\" \
>> +         -DARPDDIR=3D\"$(ARPDDIR)\" \
>>           -DCONF_COLOR=3D$(CONF_COLOR)
>>  =

>>  #options for AX.25
>> @@ -104,7 +105,6 @@ config.mk:
>>  install: all
>>  	install -m 0755 -d $(DESTDIR)$(SBINDIR)
>>  	install -m 0755 -d $(DESTDIR)$(CONF_USR_DIR)
>> -	install -m 0755 -d $(DESTDIR)$(ARPDDIR)
>>  	install -m 0755 -d $(DESTDIR)$(HDRDIR)
>>  	@for i in $(SUBDIRS);  do $(MAKE) -C $$i install; done
>>  	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DEST=
DIR)$(CONF_USR_DIR)
>> diff --git a/misc/arpd.c b/misc/arpd.c
>> index 1ef837c6..a133226c 100644
>> --- a/misc/arpd.c
>> +++ b/misc/arpd.c
>> @@ -19,6 +19,7 @@
>>  #include <fcntl.h>
>>  #include <sys/uio.h>
>>  #include <sys/socket.h>
>> +#include <sys/stat.h>
>>  #include <sys/time.h>
>>  #include <time.h>
>>  #include <signal.h>
>> @@ -35,7 +36,8 @@
>>  #include "rt_names.h"
>>  =

>>  DB	*dbase;
>> -char	*dbname =3D "/var/lib/arpd/arpd.db";
>> +char const * const	default_dbname =3D ARPDDIR "/arpd.db";
>
>Make this an array.
>const char *default_dbname[] =3D ARPDDIR "/arpd.db";

	I suspect this should be

const char default_dbname[] =3D ARPDDIR "/arpd.db";

	i.e., no "*" before "default_dbname", to match the type of
dbname (below).

>> +char const	*dbname =3D default_dbname;
>>  =

>>  int	ifnum;
>>  int	*ifvec;
>> @@ -668,6 +670,14 @@ int main(int argc, char **argv)
>>  		}
>>  	}
>>  =

>> +	if (default_dbname =3D=3D dbname
>> +			&& mkdir(ARPDDIR, 0755) !=3D 0
>> +			&& errno !=3D EEXIST
>> +			) {
>> +		perror("create_db_dir");
>> +		exit(-1);
>> +	}
>> +

	Should this be a string comparison?  I don't think the pointer
comparison "default_dbname =3D=3D dbname" will do what you expect if a use=
r
specifies "-b" with the default value of ARPDIR "/arpd.db" as its
argument (i.e., the pointers won't match, but the actual text is the
same).

	-J

>>  	dbase =3D dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
>>  	if (dbase =3D=3D NULL) {
>>  		perror("db_open");
>
>Missing signed-off-by
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

