Return-Path: <netdev+bounces-80313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2B687E50B
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA16B207F4
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D11E511;
	Mon, 18 Mar 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="R/khW/jc"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074028DA5
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751050; cv=none; b=hrZGjLr4jH5/NUmp0h5sbecxmaETHl0uydBK28vycWawl7j3BI8o6Hwhev6zuUhAfpv/a8BZbZ/FWcfqGFsLZBHAoFg1LWgiPCuzhkIMpKG9qiZu36645IwV5/0xfHlyFpjZMHoPyjLEpWgls7RZnHX3TYD+H71WmLbiUqsl+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751050; c=relaxed/simple;
	bh=K4WhvKO59CcL3GuCM+MANtqV6Pdk63mSqlKJ4RB04uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQaCX9B0Pjnn2Fa5tKoWLBjCvwCEaBY6VZ0+HIDcQA/BdMJOLzg0NgLNF2Kz2yMkuQbThJC6Md+jWoVV2fb5P3BVN2ugzhxzz8eMktuwvlzp1J7OgFKlZ4ZJSOfg/mdUVKdoMIaHqH2NWb4cB20U2NfWOFv0dUJAWngCVgFX0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=R/khW/jc; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 9E991602BD;
	Mon, 18 Mar 2024 09:37:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710751036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hU3XBlqD6rKxG/7AY3EPY7SirDlljNgW7LcoyoKnFws=;
	b=R/khW/jckgzRX2MTQzv7FsZ+UtmnILg9ZoNTaJRS6yWDjIMF6iuEZO30yS9CwdypX/EfN4
	l9nPit627y+QPpZjgPXprENzwCEWwB5msdCA0905jNhiK2gdPHNSsUN9fN3mbzksr50DWd
	KejLM2kJXgp7oi+M+VcV2YIXaLAYZ5wu/U7/unVYUk/YHPzyq8MaynDzPVNiDB3SP/vY5s
	lEe482Nvzk1NEXYDlrYN6wh9+XOtV8bVEGjcm6DOj1pWlok3saIq17tgrkULT52L/YL5rP
	yZ4pKw5oiG03y9G4am063opb0hulhzx0eAjmpNaURH3E/rpLeeySk++pfsPsOg==
Date: Mon, 18 Mar 2024 09:37:25 +0100
From: Max Gautier <mg@max.gautier.name>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next v2] arpd: create /var/lib/arpd on first use
Message-ID: <Zff9ReznTN4h-Jrh@framework>
References: <20240316091026.11164-1-mg@max.gautier.name>
 <20240317090134.4219-1-mg@max.gautier.name>
 <20240318025613.GA1312561@maili.marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318025613.GA1312561@maili.marvell.com>

On Mon, Mar 18, 2024 at 08:26:13AM +0530, Ratheesh Kannoth wrote:
> On 2024-03-17 at 14:31:24, Max Gautier (mg@max.gautier.name) wrote:
> > The motivation is to build distributions packages without /var to go
> > towards stateless systems, see link below (TL;DR: provisionning anything
> > outside of /usr on boot).
> >
> > We only try do create the database directory when it's in the default
> > location, and assume its parent (/var/lib in the usual case) exists.
> >
> > Links: https://0pointer.net/blog/projects/stateless.html
> > Signed-off-by: Max Gautier <mg@max.gautier.name>
> > ---
> >  Makefile    |  2 +-
> >  misc/arpd.c | 12 +++++++++++-
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 8024d45e..2b2c3dec 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -42,6 +42,7 @@ DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
> >           -DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
> >           -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
> >           -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\" \
> > +         -DARPDDIR=\"$(ARPDDIR)\" \
> >           -DCONF_COLOR=$(CONF_COLOR)
> >
> >  #options for AX.25
> > @@ -104,7 +105,6 @@ config.mk:
> >  install: all
> >  	install -m 0755 -d $(DESTDIR)$(SBINDIR)
> >  	install -m 0755 -d $(DESTDIR)$(CONF_USR_DIR)
> > -	install -m 0755 -d $(DESTDIR)$(ARPDDIR)
> >  	install -m 0755 -d $(DESTDIR)$(HDRDIR)
> >  	@for i in $(SUBDIRS);  do $(MAKE) -C $$i install; done
> >  	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DESTDIR)$(CONF_USR_DIR)
> > diff --git a/misc/arpd.c b/misc/arpd.c
> > index 1ef837c6..a64888aa 100644
> > --- a/misc/arpd.c
> > +++ b/misc/arpd.c
> > @@ -19,6 +19,7 @@
> >  #include <fcntl.h>
> >  #include <sys/uio.h>
> >  #include <sys/socket.h>
> > +#include <sys/stat.h>
> >  #include <sys/time.h>
> >  #include <time.h>
> >  #include <signal.h>
> > @@ -35,7 +36,8 @@
> >  #include "rt_names.h"
> >
> >  DB	*dbase;
> > -char	*dbname = "/var/lib/arpd/arpd.db";
> > +char const	default_dbname[] = ARPDDIR "/arpd.db";
> > +char const	*dbname = default_dbname;
> >
> >  int	ifnum;
> >  int	*ifvec;
> > @@ -668,6 +670,14 @@ int main(int argc, char **argv)
> >  		}
> >  	}
> >
> > +	if (strcmp(default_dbname, dbname) == 0
> > +			&& mkdir(ARPDDIR, 0755) != 0
> > +			&& errno != EEXIST
> why do you need errno != EEXIST case ? mkdir() will return error in this case as well.

EEXIST is not an error in this case: if the default location already
exist, all is good. mkdir would still return -1 in this case, so we need
to exclude it manually.

> > +			) {
> > +		perror("create_db_dir");
> > +		exit(-1);
> > +	}
> > +
> >  	dbase = dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
> >  	if (dbase == NULL) {
> >  		perror("db_open");
> > --
> > 2.44.0
> >

-- 
Max Gautier

