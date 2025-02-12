Return-Path: <netdev+bounces-165572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D4CA3297D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99ED61883BEA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5220B7F0;
	Wed, 12 Feb 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RiwgJU9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0F2066E2
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372709; cv=none; b=d+Xgu3s9OvuUzK2Jyb1uBn2CZWOLj0wXok0yfKc2UB3X2Lh/jwBI3yPSc7m6ZR1i/buWUJDaDXwQ6K2eEBxYsqU627s+t5RbFM46WOpslcucolk747MuRaVMnBWfZJLLLGisssLJs6dojEvWG6ClDcLAsK03rrdxvol8yUoXB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372709; c=relaxed/simple;
	bh=uEgBbu7R39tGn44Uv+G5+df2/9K6EbmaHoqznv75zWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfwdqWleCHludqrn9ysrKIlfLdbVOyrzgtjp3Iv29QDgiBVOm7FCUbMlBwQexZHoapmlO2Q/Jtr78odQ9qqZ6O72k4coDkQur/5cqvRAu0nptLILUgcz/SWfWeOF7rF5PrDYs/k11it75P6PmbVcPdmat3X4KCyVwg1Fug2cctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RiwgJU9w; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dd935a267so3190501f8f.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739372706; x=1739977506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEgBbu7R39tGn44Uv+G5+df2/9K6EbmaHoqznv75zWU=;
        b=RiwgJU9w41NdEAxv4hkagevqg/K71IxWPfPCwK4OSx13DtczeEXYxt7+hzGAt/rAPc
         SW7hHe3Sq2Z3HZcudAz/BwBtNs36QZa8wi4WPevlqo9o5WhmEPMgr8PYJdx1BXu/0B75
         ZXKlSk33QLubChd3s5p5jRnNDS7O9cNwRO5mDV5+Czaqowip95EcZu5yTf2knL9doKdH
         p4wusZWaph43oIytrjMfrQY9bX7JoR0oWE+4wBVcdAuo2Gndhf0VAIAsyb/7oLOfo/KB
         kbgoqXYZLjPrKriMe8i1REzKZTI2jOrj+IlnoY62BZO1f8xt3pn/O31dddDRUaCbTmLq
         mEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739372706; x=1739977506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEgBbu7R39tGn44Uv+G5+df2/9K6EbmaHoqznv75zWU=;
        b=tBlR+TTRRVTL8v0PdfcaM0MOMjHZId50CIfLcQG/E2CSYUt30DXaRFnWgGefeFjAyH
         DDZFYtND0In3sQdO0WsBXvK26PPfUr2DXuyDO6phxVsTPNqLvBrWZd790Vz3q41MKkYx
         R7mqVdqGUTNMkLBwj/tPKqmtMkPTHpE7YtUfwAqU9vPZr9eZmvS/H/rsuQHjRd4WiKGz
         AHTSyDAXwHNmXqhxqRK1ze5FJRd0QvU+a9yKg4T/YyBBQ9Xd/2F+4J0WxUbwN6C2Eujt
         PoVrNf4YZJLcPl5LGe+cKgq+R0xncfY3+AwLdCeJJwLC01j1BBrONWc+4RC2nHxGg556
         1HYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0LiaRyzBXwxIEi8JomuwPkX/R2UHqgKyXdwLhVssVR8QX3Vcn8NfGN8oUrwBMNWu0Z8v0/k4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2CY4hfEv6AJcJWg1hNkvOouoJa1q4OczUt2XGxnh0OudI0sj7
	InHKLuInBDFcQA7RqK1g7C9zJbXY+82ow/Df1gtiIQzBhCKOFNslWp7jZ8dQDheUmTdn6F6PoPz
	OPMM=
X-Gm-Gg: ASbGnctEvuaIZ0oQuu0iKn+W/lTjxdGyVp5QNeYfqRZ33hYj/ZAEN3Glkucyt/w7Qx+
	zXdYiRilXimn5bXSdWHcHTFwaJJsIOZVCpjwbOft9ijNpDFRoUWAoPayF8tVDkNsgNAeRoQIehR
	ZpdkuOtKLnfTA1aAWTfChLWt/NcJDWtaYFHMY2Nklh+bSKnwy0fFXui3Qxcvidg6TppV66RfOxA
	uF6mJ1m3V1dh3SurjFzoK/mGEOnyO6CpaAui1tMMMPTjtOZUyC8sxlUheeZRhBBTzyYBZrH6Dg7
	OOZZYYPaUvTDrXEldE+DqsHJPf6xQxqWSblF33W0FqJ4rRlA9czjTEsdpaw/bg==
X-Google-Smtp-Source: AGHT+IGzKbsKrCgNCVEhSwFx5eAnnx98CSh7rT9yENu6S1whVmV5on9d5MRdPkQtEuutZZiB8OvE6g==
X-Received: by 2002:a05:6000:1f88:b0:38d:ba81:b5c2 with SMTP id ffacd0b85a97d-38dea2f875dmr2961632f8f.47.1739372705508;
        Wed, 12 Feb 2025 07:05:05 -0800 (PST)
Received: from jiri-mlt (194-212-255-194.customers.tmcz.cz. [194.212.255.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd7f039sm18033234f8f.59.2025.02.12.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:05:04 -0800 (PST)
Date: Wed, 12 Feb 2025 16:05:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, horms@kernel.org, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next v3 03/14] ixgbe: add handler for devlink
 .info_get()
Message-ID: <73u3dz34jdnsgoujbjdokzh7tvvdubqmsngaa77a2feedbtulm@v5lnrqvaethe>
References: <20250212131413.91787-1-jedrzej.jagielski@intel.com>
 <20250212131413.91787-4-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212131413.91787-4-jedrzej.jagielski@intel.com>

Wed, Feb 12, 2025 at 02:14:02PM +0100, jedrzej.jagielski@intel.com wrote:
>Provide devlink .info_get() callback implementation to allow the
>driver to report detailed version information. The following info
>is reported:
>
> "serial_number" -> The PCI DSN of the adapter
> "fw.bundle_id" -> Unique identifier for the combined flash image
> "fw.undi" -> Version of the Option ROM containing the UEFI driver
> "board.id" -> The PBA ID string

Do you have some board.serial_number by any chance? This could be handy
in some cases, for example if you have a board with multiple nic asics.


