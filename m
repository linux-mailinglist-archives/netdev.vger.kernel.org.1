Return-Path: <netdev+bounces-121277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC5F95C83E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0521F1F22617
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B437145A0B;
	Fri, 23 Aug 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pgQv9t36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99531144D21
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402418; cv=none; b=KhQSeLl9KTYKA5LhvsovhuH6xagNpOPF3iTyu3FPbXuXZlhOAU6R9vd1yXPpaNbatuA7MprlWaje4UtZxyZunNfZ/DuI5cd0g5lJ7EcpNDe4L8uO5AplyKpQSd38+GPnUzOj7ZwZ8CGeju4WwC7QEpZZosdgEzJOgEshfj+Gf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402418; c=relaxed/simple;
	bh=/gkKdkn1kch9YHgvbfB4pJh7hu8uTpCucVk4jPgCW2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5XG3fsEJ7b1C+fyWQqWZlFuOYAJBX5SkBhpzhYKVJQjxgxd+xA3Qm162ntqRtPHIhPVjkJatIElp5GfQhBErTJe17YRd1X1Lk8Nm3IFidHN7ZN1od3rZ6lVU/nr/ah2ycaZbxQGTabSaRXrudltEmpOzMXxoTtTz/Dhl+uNo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pgQv9t36; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed83487aeso1954143a12.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724402415; x=1725007215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gkKdkn1kch9YHgvbfB4pJh7hu8uTpCucVk4jPgCW2M=;
        b=pgQv9t36FhrDOoXSd3BMXJ756sNDTzu3RHAkuG+hrV4EQCc9z5mglilHHvBzDHRvf1
         Q3oiN8RIWYuSmS6w+Ji/ntWe6AYVlWHU+oM5z2rOWixjV/1PhylKbD7eSwU1acbfxtuJ
         SHLsaNYUqe46Id/A4TLcKp8gpL9ET6Kg08NzFs0o8jDQzTd4zU/fIjdiOWG0G2Fapi+b
         q59NnLQEYbKCLCjoHmN8HU/lLRXUg9ckjdqW5Gx0ZPhJkYAQXcRwJfQyh0C136TyLu70
         6XbsA21pe5aLWcrOdm+C74skr9bu1gz61ro1ypkYhqyiBvlJq8+lxOXv+GktIMOwExDd
         6b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402415; x=1725007215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gkKdkn1kch9YHgvbfB4pJh7hu8uTpCucVk4jPgCW2M=;
        b=jmdj1ZZr3Bk3TMx68eMjn18Lx4clgeElA3hgKaQSyBkQ29ihwziC3dY67VxDJa5E35
         UBe0xV4ODKHMZxvI53gLb7ZD0SNzwbT9I3lDsFTf1L/xqzEkXVz2LmWSdRbfoksMRPsZ
         SmaZT+nODZ1upYYN9tbpJFBnBWr+PDPXOfpHF81+E+yOV1Hmi8ycs212WbCkfafHARfw
         +TtpL8cRZeLjhi8nV9idvBCxa05X0i1RJmTZSJV07gIazAn2gsDESksvgYfcHYi9qa1G
         RLRshMD0aaFG83fP09hLaUv+KWSQcAtuwEqtzYknhR883hvv7b9Gcyngn6aX+cklm6ee
         1www==
X-Gm-Message-State: AOJu0YzXUROSokqIRYCitbowF6OSvF0o9yr5S0uaoFLGLzpBzTaKRls0
	B1RP5+IkeJ74SwNR8MlWCgSJypUeMxta2IvJIr1ofiOAc0cxP9nNP5MfQujK3MZ0ff+6sKjcKJL
	6
X-Google-Smtp-Source: AGHT+IGaPZGfsEcdpD0z2HooWb5CW/e+RVLq6gXdB73IpyHPSTkCKbWsNG2C5VF/YTe9NZwWRUVqtg==
X-Received: by 2002:a17:907:7e95:b0:a86:668d:c0b2 with SMTP id a640c23a62f3a-a86a5189298mr133154366b.7.1724402414734;
        Fri, 23 Aug 2024 01:40:14 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220324sm229420666b.44.2024.08.23.01.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:40:14 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:40:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 2/2] ice: add callbacks for Embedded SYNC
 enablement on dpll pins
Message-ID: <ZshK7RwzHO_vZtdN@nanopsycho.orion>
References: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
 <20240822222513.255179-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822222513.255179-3-arkadiusz.kubalewski@intel.com>

Fri, Aug 23, 2024 at 12:25:13AM CEST, arkadiusz.kubalewski@intel.com wrote:
>Allow the user to get and set configuration of Embedded SYNC feature
>on the ice driver dpll pins.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

