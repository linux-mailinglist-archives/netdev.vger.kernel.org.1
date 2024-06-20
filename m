Return-Path: <netdev+bounces-105134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CCE90FC97
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BEDB21866
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638639AEB;
	Thu, 20 Jun 2024 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZwmi56H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4737E
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864065; cv=none; b=cpk1GzzEJn9Dkc54cqda6Zy1Qb5rutVzlTg+NPlUNAg0F9hddyH0f+BB3CoNdcBoJG8hqkpZy6ppg7rBNBKlDSTPklg6iQCwCdWviClA638Y31/qOpVIsSop5GLhCMxGuEfraHDypCIOORR7bAoZwXenAYRkY/ABOlzWnUXpzY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864065; c=relaxed/simple;
	bh=y7Mjpj/GzFil3EtdPxLv+ZNzPIFYBEdlTDZdRTWo6bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smY9RykRHHHJBhVM+tpQUc56+an/5WeaV5g/6Oj2QZSkerPxvfr1P3pK7eU5385105/Ery+JiBkhV//W3a69nRgMC3ECfL40k4Lf8m7+VxxZlA171MwSe9N0poePPklSsj1ftokeoJHTGjZkIUCfZ1JN4bV4HmSXPHJ1XPxT5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZwmi56H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718864062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiTn9eBnc2xaUqrsy4JPHqQwAM2LMekPATvkB/1t99U=;
	b=EZwmi56H9nIA0DMz7mGl1tLu28EHDlhS3y4IKBmup9KQEtFh1JtTEwo/GUJxZGEeYcH19X
	6M2dEwvtUskkMYWC9N20FmKbtj959mTsWnfbHkW9/P04hUkw6X8WzaY6N79jALjldfypAN
	xf7+0PYG0C+pg6SNzX8SLJmai6HitpU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-APvggWKFOgeeJyX-mYJVWQ-1; Thu, 20 Jun 2024 02:14:20 -0400
X-MC-Unique: APvggWKFOgeeJyX-mYJVWQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36250205842so800671f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 23:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718864059; x=1719468859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiTn9eBnc2xaUqrsy4JPHqQwAM2LMekPATvkB/1t99U=;
        b=MalDRV34v6XURnZhFSfyZNT1b5lMI5/qqgn6JhDqkZW6hOPj1ynlca1a5HyGz1Z4FC
         +xcizx65wXs1gPGQQswVHF5Ll5IiwpHfjBuDcBNxhxKxXrXw30lqmDnCWKaD6MmbnDwW
         c/uzkLwmFYqDqwz+tKC/NzR4R1mkb0WwTzRRUdiM4fGxqD1sZnZBnl8NYBGAkSEqNmGc
         sQ9VA71lPe2eCVAGxxgO2yzMQzK9q+16dizP2oa3f7vKeqW3ggnyGNl7qkKf0I15XdLN
         oU7n5iq3JC0AQN6+wx+nLOyraXGPhwxTUlg3nPBSN+vx40GCk/R56DrMcCrTsB3eI8Wc
         2/XA==
X-Forwarded-Encrypted: i=1; AJvYcCVARJ0ISlePQuD+klSI0Ie9jvr9tIC4/c66hCHA5PEk+/XaG2haMF+rSTqY76+x5SIReLGQvHDlRp1mSzD/ffhMDr42X2Z/
X-Gm-Message-State: AOJu0Yyk/SFGYUu0y0f7YjwrB/V9TUvGo03PEHMrKUNTpcDygf2fdtkE
	HoYRI0swGqQi7p03vfZ5gNu2YKfzjb/dqlP7fhJafsN4rU4E76k3DP6v4MHuabVGMx8ahAwLfiZ
	Caq1rqECMcQ4YQpFjfDoflko3qx/DeGGZXW9aCiJxKPfhQdoRQn7/Wc+4oVhEqqel1+49CO0Vd1
	C14lDRYaevh0oZyomz9YRE+P/2BY0V
X-Received: by 2002:a05:600c:458e:b0:421:347a:f0a6 with SMTP id 5b1f17b1804b1-4246f56d293mr69412435e9.3.1718864059441;
        Wed, 19 Jun 2024 23:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrEIvCnPMZaJwLe3hkoFCWNMEj76Qf3eeg2phFe3gxqIMqjUEOM1rEKZDIA0PorTtHFwQnwb5aZj1dyjKKBn8=
X-Received: by 2002:a05:600c:458e:b0:421:347a:f0a6 with SMTP id
 5b1f17b1804b1-4246f56d293mr69412205e9.3.1718864058794; Wed, 19 Jun 2024
 23:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618131208.6971-1-sergey.temerkhanov@intel.com> <20240618131208.6971-4-sergey.temerkhanov@intel.com>
In-Reply-To: <20240618131208.6971-4-sergey.temerkhanov@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 20 Jun 2024 08:14:07 +0200
Message-ID: <CADEbmW327YjOjkbb5p8KmyL=sXJbD-MaVBS5XT1uHCSg2ZNBLw@mail.gmail.com>
Subject: Re: [RFC PATCH iwl-next v1 3/4] ice: Use ice_adapter for PTP shared
 data instead of auxdev
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:59=E2=80=AFPM Sergey Temerkhanov
<sergey.temerkhanov@intel.com> wrote:
> - Use struct ice_adapter to hold shared PTP data and control PTP
> related actions instead of auxbus. This allows significant code
> simplification and faster access to the container fields used in
> the PTP support code.
>
> - Move the PTP port list to the ice_adapter container to simplify
> the code and avoid race conditions which could occur due to the
> synchronous nature of the initialization/access and
> certain memory saving can be achieved by moving PTP data into
> the ice_adapter itself.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
[...]
>  /**
>   * struct ice_adapter - PCI adapter resources shared across PFs
>   * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
>   *                        register of the PTP clock.
>   * @refcount: Reference count. struct ice_pf objects hold the references=
.
> + * @ctrl_pf: Control PF of the adapter
>   */
>  struct ice_adapter {
>         /* For access to the GLTSYN_TIME register */
>         spinlock_t ptp_gltsyn_time_lock;
> -
>         refcount_t refcount;
> +
> +       struct ice_pf *ctrl_pf;
> +       struct ice_port_list ports;
>  };

A minor nitpick about grouping of the members in this structure:
"refcount" is special. It tracks the lifetime of the ice_adapter
structure itself and it is accessed only from ice_adapter.c. The other
members are the useful payload. So I would suggest keeping "refcount"
as either the last or the first struct member.

Michal


