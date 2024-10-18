Return-Path: <netdev+bounces-136986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064079A3DAA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F3C284CD7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB8EE555;
	Fri, 18 Oct 2024 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DYSvTaZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26311CA9
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252713; cv=none; b=Ro36zmkSdN7dWR388TLK20ZZ710jInPheiderkO3AVvTmI79wqqVpHh4GJeVQIDNadJx0gtNNtA94K377fuLUwE/kDRatbpka6JcfR0sN3w98WroY68uGPGE5ye1pO3Mbautt/c/S1SOz/gqzirYB7VOYatKxhjZumcicot9moY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252713; c=relaxed/simple;
	bh=+vjbIs4eUrsAWosx0qvFdARK8Imt93wigE7TQH1ABA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWaSB6hj7m77wmiOqjPpUiF7Ualqs9Eo6NWY8IEpGkbYC1h7VXjKeqQgYgrlKyyJHqTzX9z1UMDLZ2zRbPD9beUipDakwLemcHIVuE7f2wRLTSifW0KDGUZqpIiBI1xd0DOzNoyjk4f4JZH8H//USUH9C6oglA1QF+9AxtKVQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DYSvTaZU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso19244295e9.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729252708; x=1729857508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy90eZiAvZt29hUylZW+yChEJPE6+gkTp9Y9Saq559k=;
        b=DYSvTaZUzUSIRX/8OluJmVS0BFCddWpP0UesGKoxKU4Rv2H4pbA50aIIHYpLpZsFZW
         kfpkp9z2d8DKHd55XcfxvYcESU+7Ena64KoCq8RuSGzXqMh25vVk/Qke0yvhDIloqqpq
         K9NxmAy1U1lnrz3YJ78m2dWzJe/CBlT+u+0DJ/Bt7keBcUn729e+1UzainzMNXuXsECc
         KB/5HEWQ4wzWS6MXwO6jiIDMtZ5F1Sq8KSssk/IkEZk71osfQQzQLuiRkVwH4NNN0/d9
         Tpstk4gyk5wIVZjO92UCal6JvpJFXd2lAzZ/oHSVYADaWHz1h13n7ztxM1Z9hM/XMjeJ
         e+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729252708; x=1729857508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy90eZiAvZt29hUylZW+yChEJPE6+gkTp9Y9Saq559k=;
        b=r7+8tAg2Wh3v6ES+5yOeJzs2c2VG5PwEbMhrMOaoUZHVeDKmR68NNaRfVynT6TqFtP
         YgQXCH5FYgPUQYtQlDhwEpRS+JzFlI16PONXyCcAccP3doDtDT2yuph9UTTQOet0LwHi
         E0ynIn2EwHbc7ZEqePvBB9wK6Gogq+0Bt8ZS3yf+Jp11LlaX9c26eg3SdGLnjqe/6wJ+
         38GpmHWxTNd2YfT70agYVJPem22YdNLr8dZ2ouXNY7JyDuLk1A7CMg5sqHp+yYhmR4Vb
         0VnpKRSi5AKhlRGCcCx4QMot/9arBkNYxWWvzIkKZemJKhoaCLETmgTH5U4ZtQepaMg6
         IUsw==
X-Gm-Message-State: AOJu0YyP7QSHPlzXXM3+e+7x17l6os0S4WbXIVikev5KEtvQq0iOHum7
	AwfjiUgK5ASzzZZg7pNwx1x2ln/ATezP07/+ruZyQKZQjN2GoFvNY6ppLWFuv+I=
X-Google-Smtp-Source: AGHT+IEj+ou8zt1/860IHoy8SlucvYIF8deIccPWE3UFkmd7AXqcvAAOfDFGA5k0b7Cc0+7AjtVE/g==
X-Received: by 2002:a05:600c:3d9b:b0:431:5465:807b with SMTP id 5b1f17b1804b1-431616ad571mr15574965e9.32.1729252708250;
        Fri, 18 Oct 2024 04:58:28 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dbe76bsm22731005e9.10.2024.10.18.04.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 04:58:27 -0700 (PDT)
Date: Fri, 18 Oct 2024 13:58:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH v1 0/7] devlink: minor cleanup
Message-ID: <ZxJNYPQzbiQi4iAk@nanopsycho.orion>
References: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>

Fri, Oct 18, 2024 at 12:18:29PM CEST, przemyslaw.kitszel@intel.com wrote:
>(Patch 1, 2) Add one helper shortcut to put u64 values into skb.
>(Patch 3, 4) Minor cleanup for error codes.
>(Patch 5, 6, 7) Remove some devlink_resource_*() usage and functions
>		itself via replacing devlink_* variants by devl_* ones.

Use get_maintainers script to get the cclist.
put "net-next" into [patch] brackets to indicate what tree you aim at.

Code-wise, looks okay to me:
set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

