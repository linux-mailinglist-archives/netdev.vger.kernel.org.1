Return-Path: <netdev+bounces-186096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9248A9D201
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8286A9C03F5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F51D21CA05;
	Fri, 25 Apr 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIQt84MD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08C21ADB9
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609896; cv=none; b=Z+jmsQGcCzH6KZLwnKXkOSiB9ONGCYF9UxWAS17v6sjl0KXdFPPpWogfABZolHLHIPTvh3TNO06OzfeyVEniSLCjsROyBckP737NFf9genyWpOpUTalsu1zQGhdKb6FwGCQ3yxBK1PzrFi5S83jVbnhmYAgxHTVQoFa/T4yuJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609896; c=relaxed/simple;
	bh=28o2sV/wyFvUoWaDjcvjEzgtksHLVjkMKCL8ogSMSrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcz2zQuN0i4kZ3A8oX8Cy6+x3xJixfdsdOKjaZWsyS2MZYzFzdmcniAFPLtPhdgYUJcAe8QWbA0CzIDzxOaXIufxzmrIzVxWtMCSJnyvWL3pEpP3IBCrxJnY1m6P8F9RsFPfpEvzpCDjKpF+EbFapYOULuNVW63zSV3dithd6E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIQt84MD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfe574976so19158355e9.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609888; x=1746214688; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BkSRBYFPqQ4IVJKqNFKOBIM1YRhav7ShqS8Cybp0O8=;
        b=UIQt84MDp5lMB0o0fxKmGGRaLrTnn5yxAB8j2hPk3XhnGj9lzftrX+9ipqFJ75Clza
         7ffkxH8Zl7bwnnoSLxWcPG21PRlb0h1FgDwOnFN3448yIGZue+sJaA6i6Cb2555Qbx54
         zXmV68rdpwqghbc2C2MpM+T30fu4keUrkicWf1cGICQvXThQ/g9tElTJtbQv4CGgKVTf
         h1w62Zvfe4xJMyUcMVpnUMQNEbGrMGLwlH+W5zXM0/+fGVt8xSgm/T8buPIgX02GxfjG
         CKpAJkLz9wYwpOHXnJ7IlGY0uOftk9b5sEmuvhtmJyihBA93C0pkCogHsFj2HKsBNsWo
         wlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609888; x=1746214688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BkSRBYFPqQ4IVJKqNFKOBIM1YRhav7ShqS8Cybp0O8=;
        b=TElEGttpOeFzVx5qEL+89nHkciFDyVASL77WZdI4JVEAcp4Zrr7CrCyKhpVY5dzL/X
         aEsWlz96fXwmrrrw7UQRUC9Q+v0HBHxGqe03sNfLjRbRV3d1wK7cfji3MW56l0++lWwH
         AyZkLQ4OVsJcsB7QmQ/TUW2dUvh8UdVEpuVNky2kNHzUsVP+XbE+zt5FbEGyZiZUcUaw
         LyN8yrpMdySFizy3E6Lg6YSoS/3fozAqx4lQL/wQppHgXG7TQGRMQs4RWRulNMpAS4nN
         3OERRc3IR/p2MB6TjQb236oPY3la/1L4Mbavc0Ha4XxAYMH0cm1Nso8RiVGj4o5XU0Gb
         rP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWARUkM0GiI7WFVKERisz9bbonS+JL45AiPcKj42X9QD8FQt8Y/wt8Bc3KaWpxGwJNAbs4CzDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBihQ2CVjj7+oqn6gc9pauK6mX5ebYTumnN1iuQ5sCwmzyza4
	0rzlUvRyjZOJmv6t3LWkDNR2cAJqpcshH1BwhBrrYg2aiu686B9r
X-Gm-Gg: ASbGnct1C5PL5B2KwlcNj7JEstgzNkFj73MPlOF0OsdJy3CsbBEVn9ab9BN2lnW6zxw
	KZ8H7aSbmFGbnt92/x6jujFH/ojoGh2Xqj7DmOhqH2Z/uo+CabkAdKzgRuVPEAb93Owg8SmyGh6
	MNWsB/nBARj+7c8i8NEEBI+9L86BmeFxiwkBmHivc8iBTLdcScKBqLCd+Q4IdUMpaBN9KcNs511
	Wb1Dy+qDV7DW1LR5TT20xYDhrT05FatMRr8EueXUzkHikO0r1KlGjZw+ncHDHUpKcIBL854QuP1
	pEB0T9I9CdqOe5QFrpZ+VRdBVmfQathdsm6w89YjGRyqdxNwcOi5Kiq7Upapr64GO4QWKXgDhA=
	=
X-Google-Smtp-Source: AGHT+IGmvbaocFIwS86jJgsDUPfr0DE039D4IT5wBnyy8hccOWKWWxfSqn5jnKgin/+QlL2kEmy2CA==
X-Received: by 2002:a05:6000:18ab:b0:39f:e50:af8 with SMTP id ffacd0b85a97d-3a074e23351mr2892567f8f.18.1745609888010;
        Fri, 25 Apr 2025 12:38:08 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a07a5ed2e0sm516341f8f.39.2025.04.25.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:38:06 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 7549ABE2DE0; Fri, 25 Apr 2025 21:38:05 +0200 (CEST)
Date: Fri, 25 Apr 2025 21:38:05 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Petter Reinholdtsen <pere@debian.org>, netdev@vger.kernel.org,
	Robert Scheck <fedora@robert-scheck.de>,
	AsciiWolf <mail@asciiwolf.com>
Subject: Re: [mail@asciiwolf.com: Re: ethtool: Incorrect component type in
 AppStream metainfo causes issues and possible breakages]
Message-ID: <aAvknd6dv1haJl3A@eldamar.lan>
References: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu>
 <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
 <CAB-mu-TgZ5ewRzn45Q5LrGtEKWGhrafP39enmV0DAYvTkU5mwQ@mail.gmail.com>
 <CAB-mu-QE0v=eUdvu_23gq4ncUpXu20NErH3wkAz9=hAL+rh0zQ@mail.gmail.com>
 <aAo8q1X882NYUHmk@eldamar.lan>
 <i6bv6u7bepyqueeagzcpkzonicgupqk47wijpynz24mylvumzq@td444peudd2u>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <i6bv6u7bepyqueeagzcpkzonicgupqk47wijpynz24mylvumzq@td444peudd2u>

Hi Michal,

On Fri, Apr 25, 2025 at 06:46:31PM +0200, Michal Kubecek wrote:
> On Thu, Apr 24, 2025 at 03:29:15PM +0200, Salvatore Bonaccorso wrote:
> > Hi Michal,
> > 
> > On Fri, Apr 11, 2025 at 10:48:44PM +0200, AsciiWolf wrote:
> > > Please note that as pointed out in my previous emails, the binary
> > > provides seems to be required for console-application component type.
> > > 
> > > Daniel
> > > 
> > > pá 11. 4. 2025 v 22:18 odesílatel AsciiWolf <mail@asciiwolf.com> napsal:
> > > 
> > > >
> > > > Here is the proposed fix. It is validated using appstreamcli validate
> > > > and should work without issues.
> > > >
> > > > --- org.kernel.software.network.ethtool.metainfo.xml_orig
> > > > 2025-03-31 00:46:03.000000000 +0200
> > > > +++ org.kernel.software.network.ethtool.metainfo.xml    2025-04-11
> > > > 22:14:11.634355310 +0200
> > > > @@ -1,5 +1,5 @@
> > > >  <?xml version="1.0" encoding="UTF-8"?>
> > > > -<component type="desktop">
> > > > +<component type="console-application">
> > > >    <id>org.kernel.software.network.ethtool</id>
> > > >    <metadata_license>MIT</metadata_license>
> > > >    <name>ethtool</name>
> > > > @@ -11,6 +11,7 @@
> > > >    </description>
> > > >    <url type="homepage">https://www.kernel.org/pub/software/network/ethtool/</url>
> > > >    <provides>
> > > > +    <binary>ethtool</binary>
> > > >      <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
> > > >    </provides>
> > > >  </component>
> > > >
> > > > Regards,
> > > > Daniel Rusek
> > 
> > Is there anything else you need from us here? Or are you waiting for
> > us for a git am'able patch? If Daniel Rusek prefers to not submit one,
> > I can re-iterate with the required changes my proposal 
> > https://lore.kernel.org/netdev/20250411141023.14356-2-carnil@debian.org/
> > with the needed changes.
> 
> Yes, please. I'll need a formally submitted patch.

Here is the respective patch to apply to the git three with the
credits hopefully all on the correct spot.

if you want something changed let me please know.

Regards,
Salvatore

From 7daa26e40d0888c13a2346053638408c03376015 Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Fri, 11 Apr 2025 15:58:55 +0200
Subject: [PATCH] Set type property to console-application for provided
 AppStream metainfo XML

As pointed out in the Debian downstream report, as ethtool is a
command-line tool the XML root myst have the type property set to
console-application.

Additionally with the type propety set to desktop, ethtool is user
uninstallable via GUI (such as GNOME Software or KDE Discover).

console-application AppStream metainfo XML at least one binary provided
must be listed in the <binary> tag, thus add the required value along.

Fixes: 02d505bba6fe ("Add AppStream metainfo XML with modalias documented supported hardware.")
Reported-by: Daniel Rusek <asciiwolf@seznam.cz>
Co-Developed-by: Daniel Rusek <asciiwolf@seznam.cz>
Link: https://bugs.debian.org/1102647
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2359069
Link: https://freedesktop.org/software/appstream/docs/sect-Metadata-ConsoleApplication.html
Tested-by: Petter Reinholdtsen <pere@hungry.com>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 org.kernel.software.network.ethtool.metainfo.xml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/org.kernel.software.network.ethtool.metainfo.xml b/org.kernel.software.network.ethtool.metainfo.xml
index efe84c17e4cd..7cfacf223af7 100644
--- a/org.kernel.software.network.ethtool.metainfo.xml
+++ b/org.kernel.software.network.ethtool.metainfo.xml
@@ -1,5 +1,5 @@
 <?xml version="1.0" encoding="UTF-8"?>
-<component type="desktop">
+<component type="console-application">
   <id>org.kernel.software.network.ethtool</id>
   <metadata_license>MIT</metadata_license>
   <name>ethtool</name>
@@ -11,6 +11,7 @@
   </description>
   <url type="homepage">https://www.kernel.org/pub/software/network/ethtool/</url>
   <provides>
+    <binary>ethtool</binary>
     <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
   </provides>
 </component>
-- 
2.49.0


