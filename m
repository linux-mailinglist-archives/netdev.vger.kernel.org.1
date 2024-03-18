Return-Path: <netdev+bounces-80291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F394B87E258
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 03:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CDE2835D8
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 02:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619EE1DDF4;
	Mon, 18 Mar 2024 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E93OfZT9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F901EB21
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710730583; cv=none; b=nZMBYYPyk4cq6GjptFrQs4tjfNObGLtvFkPGlMwfw6Q9xCybooGl5HFp3Gm1vFwD/l+GR1IY+b38y6wrDBKOSWXAQgmDyWnWVbFTv29LJRInQpJuZFMNI4osOslYUkRWlUWSaziNCTod8FjpkfFdLY+8oDYZVafqeaseSQnszk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710730583; c=relaxed/simple;
	bh=xDtOBSCo1AW4owJ6yTowJ4HrW7+pVZ7Gf0Xn8rAMDK8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo1NBQ2YP//HJpMfeqtlFp84SHF8wG6JE6IFtu2MfxQFwEtqAaw58zBZvj+4HGWHzzl5HfJecQtsbk90iWbBQiHOuzyk2wjGtjUqt8iUWhICT+ADoIhM/eENp6+TmGakshwmpY1Ma0eUvCgtJ68vFoGFvOj4c1OX3oh5LvFYOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E93OfZT9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HMrEnF013484;
	Sun, 17 Mar 2024 19:56:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=1DGL69Gu9TbyyIxekG7zca
	qzE4C/3dP12eQgD4VaxSM=; b=E93OfZT96PXmUpcc2EZTyeaiPPVWmrrnNbFc3o
	phh9Ao4k+GGnzLY8hKn8sB0NSsD4lX//UG/UcMOpF/d6bEj0Hlb8Gb48AJYQaYs2
	GX9DqwqAGqvIkWZGOjmEykpCfyMrVR/QNycXdtPKIDHGo4DZdNE8lTB4YA3niOd+
	khJcs4Mm4LlPnO3ug8Q9qTONFYB7bGdVAtPOCffsqGRFo7Vod74p3R0WJUUzPplZ
	/PaiPbwYFqPLn4ECFYkt0gmlfyFTTYEX+oLxpMHKwJS+Eu4Eyw/FskLC+5ykFRS8
	nv1dDy1WwY5VV2NtYJnipPJYuWSKVDWUoJAQvhtB+fTkGXUA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ww8skkpxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 19:56:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 17 Mar 2024 19:56:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 17 Mar 2024 19:56:15 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 76BB33F7050;
	Sun, 17 Mar 2024 19:56:14 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:26:13 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Max Gautier <mg@max.gautier.name>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH iproute2-next v2] arpd: create /var/lib/arpd on first use
Message-ID: <20240318025613.GA1312561@maili.marvell.com>
References: <20240316091026.11164-1-mg@max.gautier.name>
 <20240317090134.4219-1-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240317090134.4219-1-mg@max.gautier.name>
X-Proofpoint-ORIG-GUID: 1o_fWQIH9s9VsCrJapfQPTDvgLQAR8lz
X-Proofpoint-GUID: 1o_fWQIH9s9VsCrJapfQPTDvgLQAR8lz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

On 2024-03-17 at 14:31:24, Max Gautier (mg@max.gautier.name) wrote:
> The motivation is to build distributions packages without /var to go
> towards stateless systems, see link below (TL;DR: provisionning anything
> outside of /usr on boot).
>
> We only try do create the database directory when it's in the default
> location, and assume its parent (/var/lib in the usual case) exists.
>
> Links: https://0pointer.net/blog/projects/stateless.html
> Signed-off-by: Max Gautier <mg@max.gautier.name>
> ---
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
> index 1ef837c6..a64888aa 100644
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
> +char const	default_dbname[] = ARPDDIR "/arpd.db";
> +char const	*dbname = default_dbname;
>
>  int	ifnum;
>  int	*ifvec;
> @@ -668,6 +670,14 @@ int main(int argc, char **argv)
>  		}
>  	}
>
> +	if (strcmp(default_dbname, dbname) == 0
> +			&& mkdir(ARPDDIR, 0755) != 0
> +			&& errno != EEXIST
why do you need errno != EEXIST case ? mkdir() will return error in this case as well.
> +			) {
> +		perror("create_db_dir");
> +		exit(-1);
> +	}
> +
>  	dbase = dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
>  	if (dbase == NULL) {
>  		perror("db_open");
> --
> 2.44.0
>

