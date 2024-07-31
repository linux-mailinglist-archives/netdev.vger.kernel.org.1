Return-Path: <netdev+bounces-114696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8027943898
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0486F1C216E5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC58D16D316;
	Wed, 31 Jul 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YbHWtVbP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D716CD0E
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463666; cv=none; b=HRKFhq2Baxa4q8RVOxmi50XrDf/e/Q25wCoDUpRJ12rsFN36lVzdZnhZfqGmqyWVWYRUSkPZsBLwINusFX8jlbGw5FQ/KSbtTDYKAaKjVtZjINGoPlXkUzpA8ED7J+WJRPJWnrO+cYRgzXIkl2kHJmGgmk5pPGQvHiOkZxrzAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463666; c=relaxed/simple;
	bh=5/FzbCoYCYVormMglWnKjh4aEoJ7A7JLI2hhC5fYIWk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LUes+Jd3pqaml1B9PdVTHN/RHXJpHiJ4qtGKoHSuIKtiSCuKvR3Pb7ORR8MORHZP4Nb1+9NJszJ7A9YVtWSDxYgtT1hycZ7usg2Tn0KUQwFOclBhACIUCOlaWKMaI93hDZ5JitcBmNjuNo0uXgtGHbqAj3uDJ/KAjE0HqympuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=YbHWtVbP; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db15b4243dso3854790b6e.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1722463664; x=1723068464; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=So/9QSkze1y4ejM3Y8FPZR3gEKL0InNlYUt0gbOuwac=;
        b=YbHWtVbPJntuKon+IbTPT/vDhjoV2ASN+gJWbIgXucbyWee0Xw1lOim0oVvQgvr/nf
         1qNLXmCEJXTwqPgLgN8NB5PYdbYAdRMRsyjhSjuAg0FQVo4Uloo/+IuqF3AkSDM5hwu8
         xTTpVB4VAC7KRVJNV7ei0yC3QIZ20perSlWxYsvTxlDTNz4yX/eET5tnBTAZWTWxMrSe
         UF+0agmGuEv0yo8/JrXKy8oS6u616NUxMcFJZo0rBK5DKa1ifcG5Rm1TcGaR+HbLMjUr
         t5h6DlHGtcsHKGYYSUjgCKiPf5sK4VGiBxiQCycAwNSWBGj3uOSpbX6b1zRkG2aX3Ity
         Yo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722463664; x=1723068464;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=So/9QSkze1y4ejM3Y8FPZR3gEKL0InNlYUt0gbOuwac=;
        b=WTi9UtXdqfNDX6unO7ZbMYlPg3n0vjqgcSrHYDrR3mHtS1Qfa8+okf03CswHexvn1S
         MZU/YaTzROIW0Ccebh0EnoyxWyQp6L0ApKqZNFjB5zztqCArzzSRE5V/V+Duv7SeolAt
         1dd/tAgIL0GFYrHZPtdpdDemMZ7UCtFluKHQujh/wlUEvekJdPminOT257cmV2Xm98xV
         7067mJcv/0+RYh+fradvq18/m1o4m2iuxHS0HblRsx/DgjiB5dr2RbnZzGXC5WZBSvgj
         EPXnqPx5/bhwRCpSs35fl6vsII+GIRHn+babV3ne/6LPbZ62DrlemGIEzO63/lamjo4L
         Z6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgDk7vP5woDc3Cvd56hhpr7oOs9Ov1byx3mmWH2of02AfgBS0zeVOmv3gQK1zJTi3l8gztYcQvJ/oyE6ciL2vqo35vWvTY
X-Gm-Message-State: AOJu0YyTA4xJxI2eYHC2fyiGdGyMOtFS/bJVKO6eZlsGTvazEkz+RKOk
	bi4CjbzflrVCkjSQiZFPZtzRni8IznvnPzRj5M6KZvYGQyHSibRjOxaoNMn2ixeWSoAgwLn+D73
	Jr/781aIISoZQEU6AEDsUrHGAh/0hbTAYp7QP
X-Google-Smtp-Source: AGHT+IHf/6+JdBOy0saPPGO8DOj4tULdpYpCthc5pvwq0MEaub636v66UIYgIZZHSDY3XUfadWNVZBHASBEOO9hzpPc=
X-Received: by 2002:a05:6870:63ac:b0:261:164d:685e with SMTP id
 586e51a60fabf-2687a756a41mr494529fac.43.1722463664294; Wed, 31 Jul 2024
 15:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 31 Jul 2024 19:07:33 -0300
Message-ID: <CA+NMeC-s6_aZYTMaLn=zsu4fhjVXQeMorPTXABJn41aS4G26qg@mail.gmail.com>
Subject: Re: [PATCH] selftests: tc-testing: Fixed Typo error
To: Karan Sanghavi <karansanghvi98@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 31/07/2024 15:07, Karan Sanghavi wrote:
> Corrected the typographical of the word  "different"
> in the "name" field of the JSON object with ID "4319".
>
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Thank you for the patch.
I'd suggest you transform this patch and the other one you sent, which
has the same subject, into a patch series.
Also please change the subject to target net-next and to specify which
test files your patches are touching.

cheers,
Victor

