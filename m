Return-Path: <netdev+bounces-104873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF3D90EC86
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3173628175B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87A143C43;
	Wed, 19 Jun 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBm4NBmT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135212FB31
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802508; cv=none; b=BcesH9844yA9j99k3f9StfZ+JeuIKZNKPK5EIulOu50OwfWv2vxqc9ZOEE6qZ0IOJEX4scAdb2mxTBKTVjif5NXov1s7iEG/aYtDJjsofwRwvp+mMTALf9CRtvYE2YOAvE/LDwToKXoacUt6sPdVMC4z37rSmJNV3ZkVX/qyljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802508; c=relaxed/simple;
	bh=+gZCcqsDQDRx7Q8Z2cb6w3GgVEQ1NTutyctAP7xjT8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGTNuDheagVhy7t6cKjVVBdR/KVfi1No/NLdOUUKtmH6vF+4u2bjnepzRbHCsHxS6yDX9cXnhnEkyd8P8zHJnxDVKOSQZEmMjK+0P56ySr/SvUSKiS7PjMwvBGsl3J8FSeCmX2PCyIH7r8Q7yZ1wFelJtJcou4dsUbdD6hWh2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBm4NBmT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718802505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCOqrOS4imJ0LjN0ycyHRRPK8jMu2acllzHn7lRDVZk=;
	b=cBm4NBmTw6qXzpdYBNhHDA3a+k9tTF2t0blEm1Xuca3gYjzImjEkIs/O1GzsIE2QBH0E7q
	PMJ3WTWoMGEmRSPwzsn5itV0shPfa51v9/cSz22XhN2lxb10nrgl0vWQYizyhmogAnXKST
	xyJzMhbX/CDqww+ImZG1VuyAF9esRVw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-v8DoxNU6NK-KbWkmB6X4hw-1; Wed, 19 Jun 2024 09:08:24 -0400
X-MC-Unique: v8DoxNU6NK-KbWkmB6X4hw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42135f60020so48160875e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802503; x=1719407303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCOqrOS4imJ0LjN0ycyHRRPK8jMu2acllzHn7lRDVZk=;
        b=ta9gZMqAihuQoyjqVvaYn0RhRGYBrRAlzGO0Z9TwvTzLSZY1d9k4VTrdiW2sTo0qs9
         hzXYekqk8cx2EaC4XMkePG7lVKuFtKRK6kCDnHMBv2ULTW8CNICHlPe4EcBhnZxW5N00
         m9FceUfIMiW1xovTng9NAFMQZcsWqbMMf8PqSkgP9f3L9yXzNMukPOuTyaTTW8rygBI9
         VPqiAjQuKfz5DOHPTbtF25wPZjMX0/1aobEMeDwGfJLzSeujlZ8XpSr/Hn8ynx2yj+Ej
         jMeHBs/Z503u8yCA2cz75zUwT4t59g6coJssa8tnCbjp6Dragj/aNXqwmIUe5MUklNqX
         OzJA==
X-Forwarded-Encrypted: i=1; AJvYcCX6iTGuqP0mG8prjcls2Q51nhBBy7T0GPO8cG9vSv2Leu7eKjS1O0B5scLoBrs1+ah7VFY6cEBh5ZdEJca0WJB/D8oWDvS3
X-Gm-Message-State: AOJu0Yy/QITgxbmP2vwG/1xqg1F1/pwcTFIGuKRv7Q6tS+kMAP0kjdWy
	teNTagVAP4HdkrdE02C9/f7Jyr7oq7EeNSW6cz2WjcxWaG8BZZUmbbwwkWtPiAbDvcLD5dTDmsr
	Zy7uNVEV79iy69h4zvHH7b20IsNzupRlxDCBirZpZbl/E1eQ0pKYFLwVX66XQOBNOoAGtba8ix8
	EdrO3M/VGgYNeLjkkFqVc9hzMvjj3R
X-Received: by 2002:a05:600c:310a:b0:41a:b30e:42a3 with SMTP id 5b1f17b1804b1-4247529bd84mr15375985e9.37.1718802503450;
        Wed, 19 Jun 2024 06:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+opgIrhhBzA7aYeOz5Wfzv43XF+oPVwVpctiPOYKq2iAYR3mbsnBbeo7MyBqqO61zsVIS7LonV3gLETZ1Zn8=
X-Received: by 2002:a05:600c:310a:b0:41a:b30e:42a3 with SMTP id
 5b1f17b1804b1-4247529bd84mr15375875e9.37.1718802502984; Wed, 19 Jun 2024
 06:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617132407.107292-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20240617132407.107292-1-przemyslaw.kitszel@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 19 Jun 2024 15:08:11 +0200
Message-ID: <CADEbmW2D31pS16hegetagxSw+2ERs1Ze5P7WSnsaOGWegwku6A@mail.gmail.com>
Subject: Re: [PATCH iwl-next v1] ice: do not init struct ice_adapter more
 times than needed
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>, 
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
	Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:25=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
> Allocate and initialize struct ice_adapter object only once per physical
> card instead of once per port. This is not a big deal by now, but we want
> to extend this struct more and more in the near future. Our plans include
> PTP stuff and a devlink instance representing whole-device/physical card.
>
> Transactions requiring to be sleep-able (like those doing user (here ice)
> memory allocation) must be performed with an additional (on top of xarray=
)
> mutex. Adding it here removes need to xa_lock() manually.
>
> Since this commit is a reimplementation of ice_adapter_get(), a rather ne=
w
> scoped_guard() wrapper for locking is used to simplify the logic.
>
> It's worth to mention that xa_insert() use gives us both slot reservation
> and checks if it is already filled, what simplifies code a tiny bit.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.c | 60 +++++++++-----------
>  1 file changed, 28 insertions(+), 32 deletions(-)

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>


