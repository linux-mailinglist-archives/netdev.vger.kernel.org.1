Return-Path: <netdev+bounces-76534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1605386E102
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 13:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C891F2586B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4869E1C;
	Fri,  1 Mar 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txU40ruL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BA6E5E3
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295883; cv=none; b=uOee0Njskm7Up8iaEka7OKO1ZPNAbZT9Xk/70Sbx8f4ow9UnjTHVuQ98QToJ3ky/CIxrVHkT5fdGZ4CcU9ToRvVLklDm1zmv5bvpjXkboa5DEMDPuYUca7l2h/x1EJAKut56/CG9VxeggeBgPECJEZtjQP68GuU2zNEh7DYmZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295883; c=relaxed/simple;
	bh=k9Rkcgum2pozTxkBzlG+M1fZGCMA8hbLFjLcwISl6cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+hR+EBHp9JryAjI4GNQYmjQ5a4az+lZXkmhvPkPwlegp619LrIWK1FxYkSrV96FQSLSlVPRQ+36VI1PgULZqa2qxaielgUwt5HGmUAVbb/C73R6198AJLh9Dlu+emfF24UqMoC+aACH8n38Sn13CK/LCb5YrAqpgMwy1KRrS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=txU40ruL; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-472967264e7so379023137.3
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 04:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709295881; x=1709900681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k9Rkcgum2pozTxkBzlG+M1fZGCMA8hbLFjLcwISl6cg=;
        b=txU40ruLqnbN4V+jPeqJJwaw1yeqnHFfpD8yUj/fcLRgLIAGGITkYcXFK2QUWmy9TE
         KF2Zxce3EIA1H8QTF7vlr5SOB+7UOkUjelIjOjPBKgeK7eNl89NLkKsGnE6KRQmQBLjG
         gnEWSbAfkoI6EMBpb2DtqWwtYyhncyXc8xgkRyarLc4V/6m9ug1U0HIidt6QiOblbaXo
         S/4Iy3FrELxV16zFj5wiWKJBeY9bqy5+BWobxvcOOFS2mKI+QJ69+XFAa7N7HywjK0GB
         6tl4caAas6PKfvG1r756iPT4jELjY9h0qPvvucHIoge0AF6VNdpDFc3NRz39RSE4rDDy
         QZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709295881; x=1709900681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9Rkcgum2pozTxkBzlG+M1fZGCMA8hbLFjLcwISl6cg=;
        b=J5YqbhzTJdTl8Zn9AYDNiwYIUDJn6NnbWLD3o4SZUH99wIoatvwgcD6bW8dAVL8P80
         NOjkSIGqWME2RUM4YfY+Zjb98KTGG5C6Asi4yL4o6PD9NEaxaiTACGxIpnWS2tUwrgEW
         nkSVIn/fwnMMjjRY1N0ShvaoOl0b1xQ732fStBIJYevDnr+11sIbgx1koHVF2Zy5xa7W
         BaoqvTS31m9Rqh2R+wwZsB81AQUeEU1srl/BaG2U3IxIx2qsCW6IY5qXTsqpVH8ClNXn
         J75PC4WhISXnJwFo+eAzAVxrGorJ0GPsRx7IxqNb+bakgyz4GGGgffYJcNAQrHHjN2dQ
         aBfw==
X-Gm-Message-State: AOJu0YwdVqAUiQ1ora4KBY12PF2wh672oDUOUAzTB7WuxW6mlIypOYLq
	M+RMpCTX+y1RQAZDh4tuFLCmXN8H+6BJxLlWk4GvaupQGOfuJLVGyhM6IaroyrsnrWHyPL2bDIA
	3rTaPCCfHLcFnFBDDZ17+l12A7ytllTGqb9CjLA==
X-Google-Smtp-Source: AGHT+IEQPGVNTqruAg8A6mHm1+O7pWnzubd3URRuR4eT0PSAL4oFvoy0OF6M+SO6rvj2bK4eHHipjxBtL+4olti6rVQ=
X-Received: by 2002:a67:e21a:0:b0:472:77b2:f99e with SMTP id
 g26-20020a67e21a000000b0047277b2f99emr1202644vsa.8.1709295881170; Fri, 01 Mar
 2024 04:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229143825.1373550-1-pctammela@mojatatu.com>
In-Reply-To: <20240229143825.1373550-1-pctammela@mojatatu.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 1 Mar 2024 17:54:30 +0530
Message-ID: <CA+G9fYtuQfNTr3fgJ5MeYCXqvc1x17TdBRxJ6-aD76109=Pk9g@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/tc-testing: require an up to date
 iproute2 for blockcast tests
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	victor@mojatatu.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Pedro,

On Thu, 29 Feb 2024 at 20:08, Pedro Tammela <pctammela@mojatatu.com> wrote:
>
> Add the dependsOn test check for all the mirred blockcast tests.
> It will prevent the issue reported by LKFT which happens when an older
> iproute2 is used to run the current tdc.

Thank you for the fix patch.
LKFT tests run on Debian rootfs, Please suggest the packages that are needed
for tc-testing.

>
> Tests are skipped if the dependsOn check fails.

- Naresh

