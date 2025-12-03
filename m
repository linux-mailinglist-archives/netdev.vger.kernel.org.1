Return-Path: <netdev+bounces-243360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F1C9DCF8
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 06:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387BA4E026F
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 05:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D072765C0;
	Wed,  3 Dec 2025 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy0SKz86"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F863207
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764740502; cv=none; b=O/8jwOSMJxMHCv4qWHqXtrioVzWwG1sOImiPxOcgdnTqxKmJ5ExmhaAn6f1nC4jUSW8HuksZugTrHsfzDciaw9tWGkA742s1zDBSvNnVpED++UCjeC+kKHq2ENYImEsEXQ9WLm48gdXnqVNS38iSu+donqUmnbXN7+3OLOl4qGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764740502; c=relaxed/simple;
	bh=lODd6SPDg82uM/ojCYk58w5xD+1peoKtDFekLLwAJ0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhMBGeObMeB2NcL4zN0RsRDTaRicRMl7cfcq7NR22BMDkqWzztZ5u5PoO3WCjFWDucDZCBD7BYbdGRsDvNWYWtd1u8++credOIklAt27EtAOaSjwPvRfnmfIKqfyGeRDcby4GcM7114/wxANC0EIPwYF3Yzf+L1hkQBGYxKH5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy0SKz86; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b80fed1505so7362751b3a.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 21:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764740501; x=1765345301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXgJ8TpxYNHJJGDVFjS636CK2/HtL1akqVfOdjohTk8=;
        b=Xy0SKz86bSKvA4h+QO4+NC2zMOj87FFIa81IFjHJkuCRGRdVUeEQy0TtB0Jl6Gc2LJ
         Ne0f+H662pniCwOOR3YNGqhWuBV/Bz1mbxPdatdx2F6FojiE0/dXoTIurST9Wl9UPzeO
         MiWtIoQo5TiyF5pgGedQUGRGn1NQN+siRdlfP/YTbP150ZszttMPvo5VsfPIOOryjRXX
         1Nnh7QOuHFhfkp5v00a7/B1ov5Q5HStn/318Pd+uqMAGqZIkaTStf45WG/FwlwIKgdKL
         6XI4hkazE9a/nJ9FTWlb308IlzdIKTwEpCC+yXMeMfLH41Y9WyR8CuJ5+zrMo/ddkqUI
         pcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764740501; x=1765345301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXgJ8TpxYNHJJGDVFjS636CK2/HtL1akqVfOdjohTk8=;
        b=ShJt6rCRXmjctJo6YRmQDeVhNln6p/7gmSML6uG81Sa6ztLFPaRppfuAYEEMavPzs+
         8/nlQrNo6QJZ+PmunE5h/J0nwPtzl3/Odz1YDeXt9t47ZB++/YxiLI7E+2uWKYgMTpQN
         SuRTMY+bYuADh+N1E8oqs+F6Zg4/g3sd3+1QTUMjE+UCNs3lmri49jk63DKgZLsN01BQ
         QfFO8U+22J5AuA0rZ8et2Cioci2okGf2aKmh+lzTg0MynOu+nzQnjcNffRmGUL5/lAqo
         k86nI3rrufmB+5g+aNqcIEXVewi4wpoHGlFeQ3M3gXWjovzOWIGckoar9V9N20Z5512+
         2bZw==
X-Gm-Message-State: AOJu0YxwGe2KEE6a7g/SGyE/+zRSZeVehh2E9vryaSrfne4x74zn50d1
	OzYiT7SjcZM34s6eNJkj6dbTexD7fH2M+ImlCKO7YAJ6KupqO38Srqj0ZwsTLrRf
X-Gm-Gg: ASbGnctXM3D48GjE24ksJbyWEgd6WmS052BH6yR1ZBIySbo5yHibBnl8YxXIKv+KNI/
	0RrntgQnMnvLSOIX9jCS9UcX+io/a8KKLp5bktz28W9AguC+wZcdul6Rw6dZNCX3wfof703wPxT
	HPT97LP5K8qKPTg+HW2YLJVZ6BhMBO7qulmd7CKF5pY9gFViUk5AGJhgI0oelhDZkeW94xqe7m/
	bGqkY6nNCwd6tPAhVcqJxeEYCN5KFJ/DMJ0tySrRK2CXUVhX1DuqSWCCKVfgAxjnxdbfCU65zW5
	u8g3lCZyFpgsOOrR0cSHzvpJluyBcIKK5jBMCy2dvuMDB3LVM+mOH/OgazIvlkyPGIBj2BCgs5P
	ZMGOexnOqC7/ZTPhGjVkVi1T9RSqK9BqmqkdJqUvPrdSUbFeZAHbXiJDP4PDE9y12yH2+Sz208y
	5LQrY12mscV0oRnWBD0A==
X-Google-Smtp-Source: AGHT+IGdsnmmXGhkIatqiSwSVRp8q/ynzlbmd0UfmylC7SKQ5tugjniqH1DTapLX+TyhIFgBNCe2kg==
X-Received: by 2002:a05:7022:2391:b0:11b:f056:a1b3 with SMTP id a92af1059eb24-11df0c5e51dmr1246571c88.11.1764740500594;
        Tue, 02 Dec 2025 21:41:40 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:57e5:a934:7b10:c032])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5fcasm94157671c88.2.2025.12.02.21.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 21:41:40 -0800 (PST)
Date: Tue, 2 Dec 2025 21:41:39 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	Cong Wang <cwang@multikernel.io>
Subject: Re: [Patch net v5 4/9] net_sched: Prevent using netem duplication in
 non-initial user namespace
Message-ID: <aS/Nk8ujLJttzKNo@pop-os.localdomain>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
 <20251126195244.88124-5-xiyou.wangcong@gmail.com>
 <20251201162524.18c919fd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201162524.18c919fd@kernel.org>

On Mon, Dec 01, 2025 at 04:25:24PM -0800, Jakub Kicinski wrote:
> On Wed, 26 Nov 2025 11:52:39 -0800 Cong Wang wrote:
> > The netem qdisc has a known security issue with packet duplication
> > that makes it unsafe to use in unprivileged contexts. While netem
> > typically requires CAP_NET_ADMIN to load, users with "root" privileges
> > inside a user namespace also have CAP_NET_ADMIN within that namespace,
> > allowing them to potentially exploit this feature.
> > 
> > To address this, we need to restrict the netem duplication to only the
> > initial user namespace.
> 
> What gives us the confidence that this won't break existing setups?
> Pretty sure we use user ns at Meta, tho not sure if any of our
> workloads uses both those and netem dup.

All the reports (https://bugzilla.kernel.org/show_bug.cgi?id=220774) we
had so far didn't mention user namespace. This is the only data point I
have.

I can drop this patch, but I am not sure if patch 3/9 is sufficient to
convince Will on user namespace security.

Regards,
Cong

