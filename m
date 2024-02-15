Return-Path: <netdev+bounces-71916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CF0855911
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7273D2850E3
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5171864;
	Thu, 15 Feb 2024 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Zop/7dNM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47333DD
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966015; cv=none; b=H4bvtF4b3bNRlkGeuAIpTE7GBKTseizZY6UXubgdkSvR/Exk6RYJjf69EsLSEY+Yp/B+fHfOlQoASG3WomUX/8AKvtbYZdy9cM6hFg60IleGsMwoMJwRotl0C3tkJbxQj6LDvALiFa+qcHriq+beVSylmss4pffN2OfExlqmXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966015; c=relaxed/simple;
	bh=+tUQbb7quDhwH2phSN2aigbjVSbEHd2PBcibsJ/Fk8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7lJ6dESvsz1kV12TEP89ZJeiNfVvmRXGV3/ckwdh5eoxJ9uQUtegtumy8na79JYU1ef1ATgo9nIXiYItbtStN0QUEYXpA/RiMq4WqZOz6QftQGJxUQ+en2a3WClhK9Ilt8/FLKyIwx5VCNwSIGRuVyW3rm+10Pm7L9IK9AueJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Zop/7dNM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d51ba18e1bso4263085ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 19:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707966013; x=1708570813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOn7u/0vHplDiuSU6Wz7nbLLAay8sJBNO2KYqSgB+NI=;
        b=Zop/7dNMJpvfx1+yvBOiSahWK9WoLE9tg0Ffb5kf87ARh9e3F8WUgpce3aoe2XYglU
         VTD9vPOk1Faeu58vc77f8E83WyNHUMN3gCwUWId9/dcbZRXpaC+RD0ynTQ6JaAzEl26I
         sD5vEuKLSchcHSbv75c9yEB52KCaI098EciNktow/K6cBReldLGwb75V8et/xEnesypE
         3RJloQvvnaABjZLpOBetx8QvOZ02lGh+JBcj3lIip5GlTb4QmxI6dt6OuWkR7vnwil8b
         CXo+HCfnVnvYpNTU+1Cmeco25Y17FWXe52Fkb0JTCMvlW2+9Ri2uXKFJEQyVJ3Ugc+vp
         gLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707966013; x=1708570813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOn7u/0vHplDiuSU6Wz7nbLLAay8sJBNO2KYqSgB+NI=;
        b=qLodvJLJP4Hj3MX8pgqFJc19kv7o5xxm5SxnGxMRNg2N/V6fFUHCa3mTGFpGbBnI3+
         SrvYlveTySCljmgFICq+dpRWmhA5LkCTva3aBk0moh6hSxxcKapPa27eAOYHWdgJcAwX
         l35Gkh4m15YtWkEyyRIojgfD4cbDoUi9xkzaLk6cXx8HhqdFHwdvubisWOG7+H64QTK6
         e7xCKuyFpZzshSTuRWLHeXI09MhThAJr58pan9vUJ5+dIcrmYbOfRyDQDjW2+gDGNxcq
         1Fg0KVKDD5DYLdD2llJHrRT1OQBQMRu6j6knDWdaKvHTBEj9kqZrdUlS32FAuD2Loq3X
         geCA==
X-Gm-Message-State: AOJu0YzQQQ7ZhCS2UcGjIJ1aU7EtDVQBnK4yCV5l4D6JhVTT9vSRcs6m
	SW8b4ci0YDtUF/L1JtV3SeNdQ6jPV/PUxtRM3o942EtVOwMcZyikpmcQr1D2Ddw=
X-Google-Smtp-Source: AGHT+IG72ALrn1beXr/qUko7rFCSukTQzhBa8I2AwvslO6Cq2HE51fGv47bcHLzLIIFoqDtIX7qdFg==
X-Received: by 2002:a17:90a:43a2:b0:298:f8de:449f with SMTP id r31-20020a17090a43a200b00298f8de449fmr558040pjg.12.1707966012732;
        Wed, 14 Feb 2024 19:00:12 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090ae29600b00296aa266ffesm220787pjz.31.2024.02.14.19.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 19:00:12 -0800 (PST)
Date: Wed, 14 Feb 2024 19:00:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] json_print: Add explicit condition in
 print_color_string()
Message-ID: <20240214190010.2be170ed@hermes.local>
In-Reply-To: <20240213204009.13625-1-maks.mishinFZ@gmail.com>
References: <20240213204009.13625-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 23:40:09 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Added explicit condition for check `key` and `value`
> in print_color_string() to avoid call `jsonw_string_field`
> with key=NULL and value=NULL.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Thanks for the patch, but looks like another potential issue
found by a checker. Anything calling print_color_string and wanting
to print a json string with key and value of NULL is broken.
This change would paper over a real bug.

Do you have a test case where this occurs?

