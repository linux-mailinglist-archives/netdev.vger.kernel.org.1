Return-Path: <netdev+bounces-134383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BC9991A8
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 21:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCBC1F251D8
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF21CF29E;
	Thu, 10 Oct 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJpaevFz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EF1CDA31;
	Thu, 10 Oct 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586546; cv=none; b=PbgihSI6p9YQ9DwF+RCmrunSG/wsaFLu88h4WPINW1zWf67jdASZGl+S8xhYtmmI2cDuphMHhCMwmp9s+Pc8bCTKus5AVio3gBTCHhPmYhuspJm3bKOwwWf6hPu9xtp+4tV+AdckVwBiGjDxYyQ0QWLss4t49D2US5xwg4xTut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586546; c=relaxed/simple;
	bh=UldKGOQlJgc5JpTda8QVQITQpLv32p2udlmVvMX9OvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mfawkwe/WgD3Ce0rhRdQ0JtS/72n2h47+3KqDnh999IIPvfRQ8Rxcpovhd8npHSlAbs8EGWpt9CjDMdRTR+Q6PUXmOPzAoNCpdQBCjO+sBMi9Ps4PU2j+QHrewz78sj4B6M1ZYwDMmZt1+qEuThsrkOh4fcOfDHxIr3k869SzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJpaevFz; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e988c5813aso688349eaf.1;
        Thu, 10 Oct 2024 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728586544; x=1729191344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UldKGOQlJgc5JpTda8QVQITQpLv32p2udlmVvMX9OvM=;
        b=nJpaevFzRIlxkrADD4tq0/rupnokJQuPC8nK16gS+3sljlZUT9qV0B6j/5BK9Qtlho
         VTnDbeL5LQEXLrQAVrxs9vEYtIo2f7Qefb3A9736prNl/udTOvNHdg/Yygp2s9rBeR05
         t/oTLaMCCOp5tlpbK0EQGLosxSMVoNmcgvcxTfa1r/i1vyedpf6+uAMXcLCVlO8FGKsL
         cpTyGYrbVNcYpEPa9w1Ygey1N/X/EQYOHDcmPWONNBI66IYx4OwREVV60OHxo6w5k8HL
         2H5DcGCYNU9lNfv0d1Uqs44yI1Mbs0x1REIsf8lKOMQzNIrGsAg0aHvUHH2ML7VW5OLz
         Vc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728586544; x=1729191344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UldKGOQlJgc5JpTda8QVQITQpLv32p2udlmVvMX9OvM=;
        b=syL3CLJzXMnsqziqJl8FyHw5Gx9BZ6a7kB+SlyJ00tCuBGtYfF7MjuBBuMKySDoPm+
         hLrqCuAqlZvCG5qH4YVQQFsNfQk56fYvYREzujYgb/rUn6MzaZzGmH/5ABKk+UyYws02
         iJkxYucitJioh8V94joqVIAJzmNdwmIxr2QeG5mBqXl9i1Qfaf1MLM74KDfaLvPOBFxK
         Z3Bmc1wmjDP++BSQj47kLi49A2ca0xkcznDjs7vRI4v78dTAx5nBl+/DMWFmyY/IR9qc
         WB+zCcTS6FcZSn4VyU6DIMjvYHkNX1YQgSFbBEh96Aypjfv3jDLi7XgqCCO9av7l8JoA
         cFWA==
X-Forwarded-Encrypted: i=1; AJvYcCWIwD/zOQiC/TcsfAzN1P4NafCmAkuvQ5HvXbjfRJZskr1m2K2MLEvkMCrvwyht8e8HGnAu41hMmhy43w==@vger.kernel.org, AJvYcCWOvWvTy7nNIS/yr+FCWA4qiHV0Tdzkm4jNFESfv7U8rU8pBpZZlWAvI34NLsVBR5HMJFWNvxd90JCkl+9M@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqy2QmijXskezmXq/PxWt0QNA1XC6GK7mysF8A+FMzMRfFH/DO
	+OAsqc46bs3QJkAesknHbr3iQ5EzTqAPkgabXBCVi0f3klWckxqx+ilAxjbf0E/Xt2s2QfKTNry
	f/wTIiIlfHI4qwbk3hkMcX4+cfFk=
X-Google-Smtp-Source: AGHT+IF6biomH6a4LvexS3S/veBt2whsIMELiYRvLT12nayRNfgF23k+3Avp6X1fKrG0hlpfE3qnq8AdLdcmxbZW060=
X-Received: by 2002:a05:6870:468d:b0:287:b2b:c343 with SMTP id
 586e51a60fabf-2886dd50b90mr118959fac.6.1728586544239; Thu, 10 Oct 2024
 11:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009192018.2683416-1-sanman.p211993@gmail.com> <20241010100942.GF1098236@kernel.org>
In-Reply-To: <20241010100942.GF1098236@kernel.org>
From: Sanman Pradhan <sanman.p211993@gmail.com>
Date: Thu, 10 Oct 2024 11:55:08 -0700
Message-ID: <CAG4C-Okn2k6vx3Zr9=D_TiGg_-2BDnDYHWRUKobYNp5fvdV4BQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5] eth: fbnic: Add hardware monitoring support
 via HWMON interface
To: Simon Horman <horms@kernel.org>, kuba@kernel.org
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kernel-team@meta.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jdelvare@suse.com, linux@roeck-us.net, mohsin.bashr@gmail.com, 
	sanmanpradhan@meta.com, andrew@lunn.ch, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 03:09, Simon Horman <horms@kernel.org> wrote:
>
> On Wed, Oct 09, 2024 at 12:20:18PM -0700, Sanman Pradhan wrote:
> > From: Sanman Pradhan <sanmanpradhan@meta.com>
> >
> > This patch adds support for hardware monitoring to the fbnic driver,
> > allowing for temperature and voltage sensor data to be exposed to
> > userspace via the HWMON interface. The driver registers a HWMON device
> > and provides callbacks for reading sensor data, enabling system
> > admins to monitor the health and operating conditions of fbnic.
> >
> > Signed-off-by: Sanman Pradhan <sanmanpradhan@meta.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>

Thank you Simon and Kuba for reviewing my patch.

Thank you.

Regards,
Sanman Pradhan

