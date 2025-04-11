Return-Path: <netdev+bounces-181828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84249A86852
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAFD189B7C5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8950829CB28;
	Fri, 11 Apr 2025 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="TqMF6yKQ"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24637293B6E
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407086; cv=none; b=M2O6ZPaIzzLZBEd42z6UtHTNv6tK8pznT3cgGRhabmcbU9udJnJBrYBrkgtuWtfuLUrk1scNDD/RKcS5oaV6eZBRIVPNgVql1hPakGDB2LDknpk026ku20F7TF185T/bH9SVtZSaLvvddxTEMR0xkj/jIs2+2vt+gz5sxRRmDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407086; c=relaxed/simple;
	bh=fbIAzUNZ3TK4HGT1AClmfn49H8txlEyt7S+52oGkJWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSwYpVBa3wX2VdCcEBKInnPlYIkUfvRIJpHDDL4TFXhccD6oHQCKSD+I78A0Z1vLWddLJCEoHo3/AuL+J8PnEIfsJJEPiuRPctIGnRcCB1PZL1VxOCfzkU06Vf+jHNL5bzZbKqBhlzJM3y4+UbH6etIj404U4PZn6i6/ov0bj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=TqMF6yKQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eANgi2y0ed10Jn7+5U/LGgbRCBvTRX/JcwMzCgW3s7I=; b=TqMF6yKQeNkdTOehrK5khooulx
	H0d0gB2Jh5cB6N4J1JoNS/pXG8P0vkshaSQ1ImrlIg/TIS4luV+i2cXqCMM36T14ftNIUcPyWWFBL
	g2jBc6IkZM2ypMkSrjKYeWe82+hMSOlA6p2nBZ7AJ0YX6E1xHwZRLDTbZQDo0ULywwKNcjBHx7M4m
	DPEnnbL9nDa0dMD2Eyjm2CwgdvI3E9iNr3CGuTizFcNn6ySG27fQHNMk1+C42t48QmOJfDfZM0Bhm
	dieACbh7REuxXqm7kwsP5HhPyLomszCElx73o3LZ6Hn9wdEiVwGMlIfDoPz+Z8s/9/CTRpwJk5P2/
	zHYRR9+Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1u3Lxt-000pXm-4l; Fri, 11 Apr 2025 21:31:09 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5908BBE2DE0; Fri, 11 Apr 2025 23:31:08 +0200 (CEST)
Date: Fri, 11 Apr 2025 23:31:08 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org
Cc: asciiwolf@seznam.cz, Petter Reinholdtsen <pere@hungry.com>
Subject: Re: [PATCH ethtool] Set type property to console-application for
 provided AppStream metainfo XML
Message-ID: <Z_mKHHSNscT09VwJ@eldamar.lan>
References: <20250411141023.14356-2-carnil@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411141023.14356-2-carnil@debian.org>
X-Debian-User: carnil

Hi Michal,

On Fri, Apr 11, 2025 at 04:10:24PM +0200, Salvatore Bonaccorso wrote:
> As pointed out in the Debian downstream report, as ethtool is a
> command-line tool the XML root myst have the type property set to
> console-application.
> 
> Additionally with the type propety set to desktop, ethtool is user
> uninstallable via GUI (such as GNOME Software or KDE Discover).
> 
> Fixes: 02d505bba6fe ("Add AppStream metainfo XML with modalias documented supported hardware.")
> Reported-by: asciiwolf@seznam.cz
> Cc: Petter Reinholdtsen <pere@hungry.com>
> Link: https://bugs.debian.org/1102647
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2359069
> Link: https://freedesktop.org/software/appstream/docs/sect-Metadata-ConsoleApplication.html
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  org.kernel.software.network.ethtool.metainfo.xml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/org.kernel.software.network.ethtool.metainfo.xml b/org.kernel.software.network.ethtool.metainfo.xml
> index efe84c17e4cd..c31cae4bede6 100644
> --- a/org.kernel.software.network.ethtool.metainfo.xml
> +++ b/org.kernel.software.network.ethtool.metainfo.xml
> @@ -1,5 +1,5 @@
>  <?xml version="1.0" encoding="UTF-8"?>
> -<component type="desktop">
> +<component type="console-application">
>    <id>org.kernel.software.network.ethtool</id>
>    <metadata_license>MIT</metadata_license>
>    <name>ethtool</name>
> -- 
> 2.49.0

ignore that please as Daniel and Petter have the proper proposal
building up.

Thanks Daniel and Petter.

Petter, once it's commited upstream I will cherry-pick back for
Debian.

Regards,
Salvatore

