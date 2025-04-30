Return-Path: <netdev+bounces-187114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD7BAA4FDF
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B405616A424
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64741C07D9;
	Wed, 30 Apr 2025 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GY8trVzz"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9F1C1F13
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025663; cv=none; b=USxLDpEf9ZukzXf8/zfCBBEO/MzXFJd8kixbtoAGLQJIXNyKinJMTPhz3CNZz/PYokc8ynJUz1hhHWdzY+SILrGnteAZhyAvzaD5PiD7aUERZ10kh9rd5T8uKuY4RcXDQaT3n3e09KdtHT1jpfR0q8fwcRm/xpuM9zayE7NK4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025663; c=relaxed/simple;
	bh=JcSIk0Gk88GbM15qjPlsMD7b2UlOmbDf6LzZ3sR3k/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrRFckrLZiNg22I1jqgK8w7mtBM/UsKXfVsJhuURkvhK+yr7bXvSk/hbs7g7c56ZwjIiQxYlzM1J5ljHAuKd203rn/mKgRVQpMFa+OL3DNpNXNWpOhqDMaTT++NkiMcIJMf3uuGZ9H7BFCAj+FJ8BraANTLbpdsGqb9y05Ib3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GY8trVzz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FgH271E5UhHWL7UBf06R1vnRmS6aAfFmCY8z1Ia+CAU=; b=GY8trVzzwn6GlfiFw9Fe2UH2XG
	I0JX9ttNhFnaG+XaEndVIKf067pR9kkFot+hGuJuHBRET8DO4JjvWpDSR1FVDMBWKMkNGlrsL9xBO
	FL7kkld8xWAeOTVHLVOVAYnyQhhTAIeML1O2ox4vkC96MMVq7quTPb/MjVaX1KSHss+6MM12N/iR2
	IZKkwQWZ3AJMq9MwLs1JrkpFGXsP20sRFVf1bmxDJPKtDhnIii10dDfYi30Mhs4xi+rkcOnqQpnCb
	rXrnVKUzMUHjjqr1Dqb6gmCAORIT01n/mBbWZABTyKW1CPQm6HUrpKNXe+XMSqCe6L4vNfCdfqVNt
	PH51YL2g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uA8ew-00GRtq-Bs; Wed, 30 Apr 2025 14:43:38 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 90822BE2DE0; Wed, 30 Apr 2025 16:43:37 +0200 (CEST)
Date: Wed, 30 Apr 2025 16:43:37 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Petter Reinholdtsen <pere@debian.org>, netdev@vger.kernel.org,
	Robert Scheck <fedora@robert-scheck.de>,
	AsciiWolf <mail@asciiwolf.com>
Subject: Re: [mail@asciiwolf.com: Re: ethtool: Incorrect component type in
 AppStream metainfo causes issues and possible breakages]
Message-ID: <aBI3GZ_yLdfkZuTP@eldamar.lan>
References: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu>
 <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
 <CAB-mu-TgZ5ewRzn45Q5LrGtEKWGhrafP39enmV0DAYvTkU5mwQ@mail.gmail.com>
 <CAB-mu-QE0v=eUdvu_23gq4ncUpXu20NErH3wkAz9=hAL+rh0zQ@mail.gmail.com>
 <aAo8q1X882NYUHmk@eldamar.lan>
 <i6bv6u7bepyqueeagzcpkzonicgupqk47wijpynz24mylvumzq@td444peudd2u>
 <aAvknd6dv1haJl3A@eldamar.lan>
 <utlmo4lzclx5u3w3a7kp6jrpsv2zkjobzxnb6meusclp3dxv6j@43t6mqbglfqb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <utlmo4lzclx5u3w3a7kp6jrpsv2zkjobzxnb6meusclp3dxv6j@43t6mqbglfqb>
X-Debian-User: carnil

Hi,

On Tue, Apr 29, 2025 at 10:37:36PM +0200, Michal Kubecek wrote:
> On Fri, Apr 25, 2025 at 09:38:05PM +0200, Salvatore Bonaccorso wrote:
> > From 7daa26e40d0888c13a2346053638408c03376015 Mon Sep 17 00:00:00 2001
> > From: Salvatore Bonaccorso <carnil@debian.org>
> > Date: Fri, 11 Apr 2025 15:58:55 +0200
> > Subject: [PATCH] Set type property to console-application for provided
> >  AppStream metainfo XML
> > 
> > As pointed out in the Debian downstream report, as ethtool is a
> > command-line tool the XML root myst have the type property set to
> > console-application.
> > 
> > Additionally with the type propety set to desktop, ethtool is user
> > uninstallable via GUI (such as GNOME Software or KDE Discover).
> > 
> > console-application AppStream metainfo XML at least one binary provided
> > must be listed in the <binary> tag, thus add the required value along.
> > 
> > Fixes: 02d505bba6fe ("Add AppStream metainfo XML with modalias documented supported hardware.")
> > Reported-by: Daniel Rusek <asciiwolf@seznam.cz>
> > Co-Developed-by: Daniel Rusek <asciiwolf@seznam.cz>
> > Link: https://bugs.debian.org/1102647
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2359069
> > Link: https://freedesktop.org/software/appstream/docs/sect-Metadata-ConsoleApplication.html
> > Tested-by: Petter Reinholdtsen <pere@hungry.com>
> > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > ---
> >  org.kernel.software.network.ethtool.metainfo.xml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/org.kernel.software.network.ethtool.metainfo.xml b/org.kernel.software.network.ethtool.metainfo.xml
> > index efe84c17e4cd..7cfacf223af7 100644
> > --- a/org.kernel.software.network.ethtool.metainfo.xml
> > +++ b/org.kernel.software.network.ethtool.metainfo.xml
> > @@ -1,5 +1,5 @@
> >  <?xml version="1.0" encoding="UTF-8"?>
> > -<component type="desktop">
> > +<component type="console-application">
> >    <id>org.kernel.software.network.ethtool</id>
> >    <metadata_license>MIT</metadata_license>
> >    <name>ethtool</name>
> > @@ -11,6 +11,7 @@
> >    </description>
> >    <url type="homepage">https://www.kernel.org/pub/software/network/ethtool/</url>
> >    <provides>
> > +    <binary>ethtool</binary>
> >      <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
> >    </provides>
> >  </component>
> > -- 
> > 2.49.0
> 
> Applied now, thank you.

Thank you much appreciated. I just noticed a glitch we have in our
metainfo file again, claiming the metadata license is MIT license, but
the rest of upstream files are GPL-2.

If all contributors to the file agree I would like to suggest we
switch consistently to GPL-2.0.

Regards,
Salvatore

