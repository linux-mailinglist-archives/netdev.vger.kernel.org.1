Return-Path: <netdev+bounces-144856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EAA9C8943
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE89B27A80
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7511F8909;
	Thu, 14 Nov 2024 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzDdfY+o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA31F8934
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584183; cv=none; b=tQGfxEHt5dHT76o1HUdLTlDVLNqSeTJVQpmC8aH6zaVwHw+d0u24bTYRNUO9iNqHJzw8PFfhmPdulLMP5XCSG/boLDFlohPXjWqSV2WZALUVJnu1/wmKlQEnYXxamLymu/KWJNAiFCwgd2WazDMi0/r0VaikgT4gqNW12w7iQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584183; c=relaxed/simple;
	bh=o4UczN6B+k6jQ0nIaM6DaoOgTJ/NdJrplC5O3gC59hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCpZKKq3FStS5QjnvExGmLt8QmU6UWaCAnSOXyq2INbvDArhTNyusjT4+SnvEZPIRGRvL9m//qN6QSmLvq0UqXPUGGfjxo1DS71MnQ7dhlstnZOmzFjVnqhHUyWPBnUrH4+NRXj4UriHYTcaMOLHEICwMo+2E5DrmnEDqIymMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzDdfY+o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731584181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4UczN6B+k6jQ0nIaM6DaoOgTJ/NdJrplC5O3gC59hU=;
	b=OzDdfY+ok5NpvFPNXGK4N6VdEfmVNtvUAMOq/g9xKphdC4noUi3efSt0W9qF+S1V+4zorU
	BzosuEBgD7aduNSpv8ybGm75cO68BDpv8ac8kHhC3OcGGka5iGGLFcHQ2bLoOCdSmEpWtL
	asODZciWH+YbEkZoH0o2tENQpk1pj28=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-sgsr1yrWNbq-XTYX9KB1Rg-1; Thu, 14 Nov 2024 06:36:19 -0500
X-MC-Unique: sgsr1yrWNbq-XTYX9KB1Rg-1
X-Mimecast-MFC-AGG-ID: sgsr1yrWNbq-XTYX9KB1Rg
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e65e09f8bso576216b3a.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 03:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731584178; x=1732188978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4UczN6B+k6jQ0nIaM6DaoOgTJ/NdJrplC5O3gC59hU=;
        b=MCiHGCj4loiEyfhDhV7lG5lJkAg3cWh2lwux3HJSWrqC02cIC9JhRWe7qGv2xSVk6Z
         ooL9mCsImR+XC+nWepGInomAS565Kd5km3q+jycz0yubye5ot71DpTNOLFvaQ3xUBJbo
         T8mRMWd+KAWtezHFDsk+D1ijYcGu4DY/wYc1ZoP8T+aT+JDj1kMSKyEKuM7Re6FjLOAN
         Uy9uY9gEEC9x8e0BycB/9ORp7P8yrQWDDarXYFCbPdSrps60m70Pz+YETOQudjPzID5S
         gYXL67ECMrfDL6DClL5mfQdW3xMcThv16WsDo+jOa+vJ6LQJAy7kScHTRVL+UHDftgou
         9vBg==
X-Forwarded-Encrypted: i=1; AJvYcCVmPqSdXPFPCLEUTKRQ7vn7Qzo9PT3zIijBIKa2vlqEEXC2pL5wYnd6WGHJrpv6zwmiqjha6NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJ26cROHIxnaRDA64HW3ibheZ+WtzwufN9iG1dD3OgCbeQ47S
	CFci+419MXbmEpa8KMic3hY6LR0u93qS4Qrp02FcIQrcV66liA400on/Qpg0X6glorpBsmtmNeu
	9e+42khv1WpXzR7JcTk6MJMi1J3LJr/vn434wisBL5+B3SjzoG2fmxPg+w+ftzX0fmbnISsrp2Z
	KvX1lKENt9x2E9nzigZE2IeeNHkcTK
X-Received: by 2002:a17:90b:3844:b0:2cc:ef14:89e3 with SMTP id 98e67ed59e1d1-2e9b171f673mr31216636a91.15.1731584178545;
        Thu, 14 Nov 2024 03:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExuV+TbL+YmJjDMn/kfycNbr3nby6kVioBRi1E0LoIsnbQXwIyHxbbgHEph7qX0YA7wy8rA6BhJIVhbcG87D0=
X-Received: by 2002:a17:90b:3844:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2e9b171f673mr31216615a91.15.1731584178248; Thu, 14 Nov 2024
 03:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
 <20241113185431.1289708-14-anthony.l.nguyen@intel.com> <5f190ef3-7801-4678-a9e4-7a44f704b6f2@molgen.mpg.de>
In-Reply-To: <5f190ef3-7801-4678-a9e4-7a44f704b6f2@molgen.mpg.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 14 Nov 2024 08:36:07 -0300
Message-ID: <CAAq0SUn4MXKoJUjNv2-HO_2fMThdG5bKFrSzfmpn45u=t=LeTg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 13/14] igbvf: remove unused spinlock
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 5:04=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Wander, dear Linux folks,
>
>
> Thank you for your patch.
>
>
> Am 13.11.24 um 19:54 schrieb Tony Nguyen:
> > From: Wander Lairson Costa <wander@redhat.com>
> >
> > tx_queue_lock and stats_lock are declared and initialized, but never
> > used. Remove them.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>
> Would a Fixes: tag be handy?
>

Hrm, this is not fixing anything, actually. It is just a cleanup.

>
> Kind regards,
>
> Paul
>


