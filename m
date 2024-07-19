Return-Path: <netdev+bounces-112207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A29375FE
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BE81C234A4
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F882876;
	Fri, 19 Jul 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="z3aS3/2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA052AF11
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382147; cv=none; b=cHGvyxnpG1MYyCCg4lhFSkrKX71KbP+hlBOcw46oyQ3sKMAfPjKJt3xV048Uomx7FMo6lRA5s81/Ipl1wi5B/k2wIWEAwO/fIbX4KCSz0L1+2mO95MbjWMe0FDMykxdNpb09JotrO5ibdyn6ACGSxvzeaEIOjHHys4XriLebfbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382147; c=relaxed/simple;
	bh=wixLE6ciE9yqhxqd1Ef7pKuRjMJ3iMZSLhvtYQ+cU2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttldtn5MffiS21eSL0w/9fP8z//RRQKxNeBzhKgFPk6tCH+vP9vrPkxeP6+Yj5BL+u3Bct/pOkjwnIaG1pmokqwUrTlU5IjbieA8jK4OcLaa7wByp1N22d2EK5KfsaWsYNdfBPaZlHhojiHGgTCXeF3iGHnU+Nezuunc5+CWiyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=z3aS3/2n; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso759340a12.2
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721382142; x=1721986942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wixLE6ciE9yqhxqd1Ef7pKuRjMJ3iMZSLhvtYQ+cU2c=;
        b=z3aS3/2nmA+upVC5RfLEOZ+QzrVfJgvQ9461slVAvC1Oebca3dR/GEir97CSOdHHAQ
         Hu3Na+9uPXJjtgGqr47iJa+kbmsZoa3kpbI19qPffpVEq/MWOpjPvdYQJwmdsr9RtPq9
         AgzME6JDJ/YoCE3LT6z3uSFnsu7XtTOJ7O8AshGtNstb5F1IyCAMxC9iGFBf7GqEMmXu
         x6dZoY2aDPrb1cAfYRESct3Hmpvxr1A2JM8kFQUihrghGcR66NX1fLrweJksATpQdfuy
         Wd81Je8ZuK90XTKKsH3HcajZ3YVTdIe4lrxGhBAoH7Nv9nrtuDIo7DpwQZaeA6i1rjhD
         lwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721382142; x=1721986942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wixLE6ciE9yqhxqd1Ef7pKuRjMJ3iMZSLhvtYQ+cU2c=;
        b=kRMY2ubF5/PxyQRXNY18p674f4ESwxt/+Tvik/ERPJv3YNGg4F0umxkrgw90IH8qDr
         hRm4KQZjOaKCmpbN0bOfmrLgpAgQpCyvw0jJSDwcpBH7mlaJNDIDt2WYq3C2X59ltlS4
         P7S6wgNmEi96GgRPLXBs0vmtwrgF0qSPhMab96rQcsWeK3D6tRJRX8m61dgb4yIrfLtx
         KSLZa08Pn+csb/5ltCD18iR3opIbUiOmowRNDZH4yOBGcTBabvNKkErJm9QZTR3pylmb
         mIf8Krafp4Bta3tIytEPX3tlGi0nWHwazVuRpVCPKk6sIQ1S03av+YrAYAhQzowNWNiu
         HawQ==
X-Gm-Message-State: AOJu0YztY8enNwklgIjs4Hn6GoJiFySDGu6wfJxotHLF1931prjBrECR
	TQ2ANSKzuxOPzDPdksjCRKADSE5431uQ2CqmSHJ2fDUr8+TkT0rcBCWyKySpqIo=
X-Google-Smtp-Source: AGHT+IHyeuubv0PeXlGnLGIqu45aZD5tfM/EiuJkFk03MaH5GoCWxGEKcqYPfsqkk3qdnjjLahqo6w==
X-Received: by 2002:a05:6402:27cc:b0:586:e6e3:ea18 with SMTP id 4fb4d7f45d1cf-5a05bfaa644mr5438614a12.23.1721382142229;
        Fri, 19 Jul 2024 02:42:22 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a5ccf09sm891080a12.10.2024.07.19.02.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:42:21 -0700 (PDT)
Date: Fri, 19 Jul 2024 11:42:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH 1/2] net: bonding: correctly annotate RCU in
 bond_should_notify_peers()
Message-ID: <Zpo0_CoGmJVoj8E7@nanopsycho.orion>
References: <20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>

Thu, Jul 18, 2024 at 09:20:16PM CEST, johannes@sipsolutions.net wrote:
>From: Johannes Berg <johannes.berg@intel.com>
>
>RCU use in bond_should_notify_peers() looks wrong, since it does
>rcu_dereference(), leaves the critical section, and uses the
>pointer after that.
>
>Luckily, it's called either inside a nested RCU critical section
>or with the RTNL held.
>
>Annotate it with rcu_dereference_rtnl() instead, and remove the
>inner RCU critical section.
>
>Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Fixes 4cb4f97b7e361745281e843499ba58691112d2f8 perhaps?

Patch looks okay.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

