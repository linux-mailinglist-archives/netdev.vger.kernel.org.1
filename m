Return-Path: <netdev+bounces-225593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3DB95D4C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D92176AB6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0869322DDE;
	Tue, 23 Sep 2025 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BdAscpYe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC03233EF
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630095; cv=none; b=rNA1LC6dmXNuQwZIqDQZgp0U1GZfZ1ZIpfdfIDlY93qA25mTVl9KvqBONCUMjrUe0O27Z+IBkqZDDtjXdyB0Etvo6AAQ4OYn4YmsOuwABmwk+izcG0RAQd0Zb+j31mh79RZ6j6SeJzgNrW58gZYUQjPjL1d6Nq92Qum2oF+9WD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630095; c=relaxed/simple;
	bh=h28U/td2i+Eex65JsNXgGV6RYk56bf9quM6abVx0InI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Adzkv/rF0Mr8579Tn8Zza65rTnkdGGIJ+1aFOyW8q8B0sD56TADFY1cL96wix2l/u3VZwHoA5dqz9boV8aE50OjWS2rkermyvjpOO8IiZDNWARhThN77ZZtf1Si7INFQbk61dD3elyhtVWhzyWQQ/Gy+iY+qk2esUrKn94p4jgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BdAscpYe; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-30cceb749d7so2387981fac.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 05:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758630093; x=1759234893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vur+ZK1ml2aiKHWCYNI/fh/22T/Y2wUFL0AmmTzLg9I=;
        b=mhpCfdkTmU90Xvti2yod6tuRwSvPawQe6SxKF1AVrWrfgWZ6p/P3GBUPJP94xyTs4/
         RJXMNJ+5mA8ERpYA2gAzn1mJDrCFFZz9O5fmmJ3eiHhygn2bhcRiw26jy+Ss0JfeN4Kh
         Fldh5Q8DSRBde1nX5LrLAlHNx5nLn3Pv+3w6NOVMSG4mrmplKhdeDtdK0TQyiI+oCVzH
         23056/xdoWidlyWLygfR2dSBQT5aWW7pnWctfwUQbARrTVDByD8yIwMjRN4wt/UWbeac
         y9iROgiNGGkm9yrUmnMne9TkJk0Fj5wDb4UHFFoHZkhK9DJ5lmyGo+euKxF8bHmdPD/u
         Aviw==
X-Forwarded-Encrypted: i=1; AJvYcCXrowcjNDREYcc/LEJQa8Fa8z9Ga8J6+HZDacbENB09BHsGEIXEvrvHqsFkxuPtNL0JpublNrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycFwP2kZWmoE444JxLNNodDHK6Tz7dbtMqHBLbs05n5XZGMhZu
	OABzUC9QOtrMbICX/q1uQr8WLjcOEGR7Zm93sQQ+k39wpC34tgO6NP5wj0fTO071mjIXzpdy1rT
	kD/GtQDkNghtVZP1DWpjleqOQ3ETzTHkYjIrUZpdcQMIZMD3L7V26cjt+xvaVeO0OPNqhHovMu2
	zXMu7yYS6ZeN6zD1GKggHm6WVZvorhpvPz2b9Owwy5hMAFpyortlKMwvGA5J3Aa53bMN3DNJLTE
	MpzA1HE8Fc=
X-Gm-Gg: ASbGncuwjR3KEfGwZ4lZiklAyeiii3rkSqubGQtRGbJZHnTeXvhKlcZh6eJ5CUmRl1w
	sydvlmF6Sow7AQk+3YJJysS0xdQQkxgXFjW7aeuySIvKV9PhEbCfRJImb/sT3qTK8DRzkVEfC5I
	zPWrYAjTmUJ2FaGicNoXzSBx+2cHFjX7uWUak2l8TS6vlzEvENfPTWOXbdV1eCWomhKs1E6ZDrV
	h39JbJT02hXPhpZcjZJz+oyCB7EVhYlTNmi2iHRQ+MKvL1/3hqmQUYsdb6O8a8R9s9eMtK4g8EK
	/Jp9Xpvp70dh2ntMGnIWCn4gbFWlwJXCuWRRdqO+Afyqa4TFo4xFSHlefwOJaYzpZeqbMuIsRIg
	txvPbVLwXO37mB0gxIp4r4llpgFo2g3XOSvKtwOESoG3+3wcQKRbA3rfjSuhOJ3PtzjTQZzWd4+
	k=
X-Google-Smtp-Source: AGHT+IG0LkfhtYK8H/8CRlBi5VikGTEzY10HaAd89w8GPgVR+dkvtoF01P8Nu6J5c/l2t68BYP7UJOt0Tm5Q
X-Received: by 2002:a05:6870:96a7:b0:321:29a5:4e11 with SMTP id 586e51a60fabf-34c88efe76dmr1166920fac.47.1758630092839;
        Tue, 23 Sep 2025 05:21:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e6aa0264sm1235295fac.23.2025.09.23.05.21.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:21:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4f86568434so4023958a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758630091; x=1759234891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vur+ZK1ml2aiKHWCYNI/fh/22T/Y2wUFL0AmmTzLg9I=;
        b=BdAscpYeMQyioI8I2K+YXkJv7Zuz5hoDj/xECVDlR8bs4tg3N1M5kw6T1jCgVmODVV
         ku9oMhrpTAoCSwY9EZVkR8rMMjynED94IqoBzx4D4ztTDuq1YToo82DaCDKQ4dFLmXeV
         qMbfRNMBJLgOnjSsJnyNwFxSBUmj8Y9/Q/ZGs=
X-Forwarded-Encrypted: i=1; AJvYcCUPOhFCTJuk8T5ZE0sx3Ywe1RqbXSrug/csysiJRK2OrBEK79juPqZcoDb7SRVDZHB/emfXX/M=@vger.kernel.org
X-Received: by 2002:a05:6a20:3944:b0:2b8:5f2d:933b with SMTP id adf61e73a8af0-2cffb0416f6mr3657696637.42.1758630091234;
        Tue, 23 Sep 2025 05:21:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:3944:b0:2b8:5f2d:933b with SMTP id
 adf61e73a8af0-2cffb0416f6mr3657667637.42.1758630090908; Tue, 23 Sep 2025
 05:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-4-pavan.chebbi@broadcom.com> <20250923114935.00001730@huawei.com>
In-Reply-To: <20250923114935.00001730@huawei.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 23 Sep 2025 17:51:19 +0530
X-Gm-Features: AS18NWDv25_kBrD-_aelJMx-O8X9VERaMYkfvCuqq4tvgwcuyrscSRnByWldja8
Message-ID: <CALs4sv2ApzFgkst-bMk1Wx2TVf4r38Em6LsJbFuvY5O6_0wBiw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] bnxt_en: Make a lookup table for
 supported aux bus devices
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com, 
	saeedm@nvidia.com, davem@davemloft.net, corbet@lwn.net, edumazet@google.com, 
	gospo@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, selvin.xavier@broadcom.com, 
	leon@kernel.org, kalesh-anakkur.purayil@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 23, 2025 at 4:19=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Tue, 23 Sep 2025 02:58:22 -0700
> Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
>
> > We could maintain a look up table of aux bus devices supported
> > by bnxt. This way, the aux bus init/add/uninit/del could have
> > generic code to work on any of bnxt's aux devices.
> >
> > Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>
> Ah. Ok. This does make it more generic.  Smash this and patch 2 together
> so we don't have the intermediate state where stuff is partly generic.
>
Hi Jonathan, thanks for the review. Right, I assumed context while
preparing the patches.
I will address this patch break-up and other comments in v3. Thanks again.

