Return-Path: <netdev+bounces-181872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74705A86B12
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 07:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26194406BF
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 05:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE31484037;
	Sat, 12 Apr 2025 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BktTl2I3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0085103F
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744436118; cv=none; b=kG2lrgGM5i5kBsROeVc8JT19qPo18MdEp/Oz3/3ICHA37meDa/4Z52IsIdouQfDJ7limAYpti34UaOs8wEHNHNct+/r5KnWnaZjTzt4p6hMzXBhYgxpovuI0SuVUW8zONajyEuev6a5+jlgrB3RG938KLQxk0pf4oFK+/f8wdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744436118; c=relaxed/simple;
	bh=gqOCtDlCcc0aN2/kGT8R3+KbOItSMEsKq/BN0dRGfH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkE3S1JXU+xfCFK3xCrJaVd1O4DrTwDb/Tjp0Pf0vd9iqIEZCkchnId9Rno8FiC4r96OqePhqlMFXCZt9T5ZlRRzp3JEu6KalmsodL710aU7Kyt2m5KZO/6B0ZzJ+6hae78G4mdT9tvUGNm4FfOCunRzSEROA1h6inU0cR5DP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BktTl2I3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acacb8743a7so315657366b.1
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 22:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744436113; x=1745040913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOuWUc4fSxgFqcaCt8pH7EfVzHYKasNyVGhhKKzfpro=;
        b=BktTl2I3f9ZetTpXLqARczQ4zJSFMqo3lOggkhHrkAM4D8c0QwN07VUtWowg6AqxA0
         8UQF23IsIlSPEyEV5h4x5Hr74yH44RqL9RWl+S/pIkiaqHcc8Gu+RXkC0MdT8A75WDqo
         h9VxdnRmS0bYBgMWZYU3ZasuEGkgivwWxaO1BP09TvzPJqN+t1cWPPxSztW1q/bHDkdI
         v7arl9Am3pwgYBgLt5W/dqoJ/qy+9JYOPxiREXrQ9hVkGTFNikxLcH9DxzWeWGIrKPPW
         dTrNd0OIlpAE8UPWZR1REKRFbtdWQ1NZnJ0+XWU8eiiZQjnplOWWF4Kb9sAirsWS6Kyw
         nHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744436113; x=1745040913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOuWUc4fSxgFqcaCt8pH7EfVzHYKasNyVGhhKKzfpro=;
        b=F+RtnCDhMzaeiNMN0ZAvbdmPGFPXLDmfNZv5G6nW+38AB4Zf4hmqK93ehdgfrOFMCN
         DlucvhmWreeuArICTif/pgsF1TdKFAY+TO9nPKFc4VUmO7yT1YkuS+ec9tiJVA37W+iS
         GQvOJtV7FlaJcrMwHwEZ8M4xhiTDGXI12sEHQLp4Bx/VFvamilpS/H0Ri6505tk3+d3j
         jtS1rpGIpgfiyCOZ2G1GOLmJ1sGMyUQbZN9RTZujcqFWGIYcYv9Uu81tqT6Zz9iBL1kW
         FVhdOc25iAWvKOJdpf9/whsC20J/hmyEp6JZ5pUuQ8UGNzE7zj0zSTmdIiKA9P//amo1
         OAQw==
X-Gm-Message-State: AOJu0YxP5ejSCzryhGtwcbH/Mowet77n9pjC0Bsnh/pCVANnJ6E0pbZ+
	l6sPnyYAT6Ifbcsfk9+zwhnRLrgy5WVc9itTs4WAgKNdq9542f23
X-Gm-Gg: ASbGncv6zRh3epBNOGSRd1TBShy7GOz/TGXiCOOnVKvao9vi5x5xO5cVYpKtN4mD7rN
	3ZTXMTS266W31mdxSeZRhYL1S86cnjyGZ7ngWfg7OHsWx17tWNbmFwYmHcuE+mL/jE6XYUtXXvi
	Kxi07/boikyUm8U+h2oD8v8SvuPiOW1JCkHwuT8r8r6TVXQ4UZl37K9sERh0xr2t1MsDnJIbota
	DujnF7cRwEdB3swGrrbmkgVdX8xs+XO28eryFX1LzgO3cp/nJyJUeCZF1cXBzfpy9F9vsBiaHFS
	KDEf7JHhNwwWLplpj3SA+Nb15tN1p5HcZLnd3S2S6dN7Xnny4ic2a+RO2j1rw5jgo1ky/Mn9gQ=
	=
X-Google-Smtp-Source: AGHT+IG9czI8QRm1bJkF3qzEb3UaowsOEzowkswL1vispEjdwpq2VspEr09Oz4Xi16SmNKbAXbgJQg==
X-Received: by 2002:a17:907:9805:b0:ac2:26a6:febf with SMTP id a640c23a62f3a-acabc48f077mr684268966b.20.1744436112624;
        Fri, 11 Apr 2025 22:35:12 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd262sm551213566b.136.2025.04.11.22.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 22:35:11 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E97DDBE2DE0; Sat, 12 Apr 2025 07:35:10 +0200 (CEST)
Date: Sat, 12 Apr 2025 07:35:10 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Petter Reinholdtsen <pere@hungry.com>,
	Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org, Daniel Rusek <asciiwolf@seznam.cz>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH ethtool] Set type property to console-application for
 provided AppStream metainfo XML
Message-ID: <Z_n7jpRVr_Sv-gxC@eldamar.lan>
References: <20250411141023.14356-2-carnil@debian.org>
 <Z_mKHHSNscT09VwJ@eldamar.lan>
 <sa65xjaromx.fsf@hjemme.reinholdtsen.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sa65xjaromx.fsf@hjemme.reinholdtsen.name>

Hi,

On Sat, Apr 12, 2025 at 06:26:46AM +0200, Petter Reinholdtsen wrote:
> 
> You are definitely on the right track, but the proposal from Daniel is
> to include a binary provides too to fill a field wanted for
> console-application components, ie:
> 
> diff --git a/org.kernel.software.network.ethtool.metainfo.xml b/org.kernel.software.network.ethtool.metainfo.xml
> index efe84c1..7cfacf2 100644
> --- a/org.kernel.software.network.ethtool.metainfo.xml
> +++ b/org.kernel.software.network.ethtool.metainfo.xml
> @@ -1,5 +1,5 @@
>  <?xml version="1.0" encoding="UTF-8"?>
> -<component type="desktop">
> +<component type="console-application">
>    <id>org.kernel.software.network.ethtool</id>
>    <metadata_license>MIT</metadata_license>
>    <name>ethtool</name>
> @@ -11,6 +11,7 @@
>    </description>
>    <url type="homepage">https://www.kernel.org/pub/software/network/ethtool/</url>
>    <provides>
> +    <binary>ethtool</binary>
>      <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
>    </provides>
>  </component>
> 
> This look like a great proposal to me, and I have already tested the
> change using 'appstreamcli validate-tree debian/ethtool' to check if
> there are any issues with it.

Yes sorry I realized Daniel did as well started to provide the
required changes.

If you want to submit the patch just ignore my submission.

Can we add a Tested-by: Petter Reinholdtsen <pere@hungry.com> ?

> The only minor information messages shown are these, which are not fatal
> as far as I know:
> 
>   I: org.kernel.software.network.ethtool:6: summary-first-word-not-capitalized
>   I: org.kernel.software.network.ethtool:~: content-rating-missing
>   I: org.kernel.software.network.ethtool:~: developer-info-missing

I think at least the summary-first-word-not-capitalized should be done
in a seprate commit? Not sure about the other two reported info level
issues.

The updated patch is below, changes v1->v2 is adding the binary
provides tag.

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


