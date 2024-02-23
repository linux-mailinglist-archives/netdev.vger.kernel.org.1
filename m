Return-Path: <netdev+bounces-74415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E527861316
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAA3284227
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2927F46E;
	Fri, 23 Feb 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPTDnU8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A47EF06
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695868; cv=none; b=pJlSl3HfBOkYM0IiZCzgQfbR/78zdSe+XR6Vujwbz8tv1KF05FIFzjArE8t1LrjMMiSu7G14NrgYnDwexjupV1DkXv0he7nZdjHMsp4/b1lNfgkcAE4pVV8mab2G/RaDrvrUKR7GWA9kMk2ze0vyEMlOsfcQrQ5tKocw4uBjtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695868; c=relaxed/simple;
	bh=W3wDt5tNvWBEjhlodcK02yA7yWbk5wYWn+1+mUcYdoQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oElznSDOIXuNa5NUVp9m0exD62rvBNCJTJU9xc/uJjma8Zo2pQVqqLo1LjRO4lOU0VmKkNiCR1hNbdFRWKSbrrtB476kOr7lZbVXxL0neaQQ2y1renKoEltsxbLNgpJCCgYS/LLpCmE7vAkferiKtUhDGAIQmQE4o0CcBeMh0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPTDnU8v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d8739ddd4so661356f8f.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708695864; x=1709300664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3wDt5tNvWBEjhlodcK02yA7yWbk5wYWn+1+mUcYdoQ=;
        b=VPTDnU8vz+XaZpN80zRCxnNDkkG12kYnocuWhA7r7x4cdCwrwLK3Rhk3OfFUb+awcE
         x3a3jS9lk0GmrwPoBhw1gB+caT6o5Gs49x4j3oy7e/WusyVTGSN6KCKWmlK0VCrnShbW
         Q1CKPEFUmv+5H8Mc4NgJPNLF8qkP++3s7ExzHHtOBvsIadPvl21truqX+iMPN1L8K4vi
         yavRFN+NYWZXURZ1hCHZL8JHTEJrI31CyHlg2z0GsFfBPGzWeH33mIH72+mE0DxkmjHw
         2YzFBbQMJ/P1ugKe6Wuy2j9EKYeNZy3+DVN0QmxdUYTMVqfB6bouiP7Xg6qmCZv7Gpzd
         q5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695864; x=1709300664;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3wDt5tNvWBEjhlodcK02yA7yWbk5wYWn+1+mUcYdoQ=;
        b=JY1zm9n7vVtcaeuZAMReV7A5hmU3v/pbIgDmNMxd8TfxtCqnuWeuQYd78jDtl96E7h
         fnvYtZ1pjnNM0E1piaDIc2AztItxR6TVtFRQty3rCwyK8jUqbuxR7Hp/F6mbAXs/bOp9
         sZZ5ri8izt54Y9+k3lf3WWoTjxM/wp0J68A3K5IciEs1ZwgCBtnJbZDKP6ddg9BlW/xx
         is7ulzaxQ/jPhlZRnY7c13Y0HkN4cOEjvnO/EdeOIrv/2I8tq+Ao1C/T3cl7OMeBq2KU
         DW7C2sU2PAponz4bKcjhxoIIeI5EuYXpm405C2T8CKBvRd/n6G7Psfocis8ej1wKeTsV
         e1sw==
X-Forwarded-Encrypted: i=1; AJvYcCWzWA5V4hIeqJ79FkfWqPCdxyRATay9xqTT6D5q2oxHt0mQ7ifozeMeL2qSHeQGkxomGpfl7iNaGwwL4YsWhnmCsECYEFwh
X-Gm-Message-State: AOJu0YxRC/PmUriOfJwvYbsIW2YJP292cXSPKMSB+KggvUhk8LOEeZEl
	EuCaxb05OphRcDCQ8BGuN+7Wue3tpgQS3Rh9hKy9KT0dvWd3E9vf
X-Google-Smtp-Source: AGHT+IHlskQQTmAZxPBJevenuVJVfL+OAUD/lc715UJU4BRJbVFHnA90oW6TvgCSjVyY6PJoprH8Yg==
X-Received: by 2002:adf:f70f:0:b0:33d:d37:485a with SMTP id r15-20020adff70f000000b0033d0d37485amr1502914wrp.58.1708695864433;
        Fri, 23 Feb 2024 05:44:24 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d6943000000b0033d96b4efbasm2842191wrw.21.2024.02.23.05.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 05:44:24 -0800 (PST)
Subject: Re: [RFC]: raw packet filtering via tc-flower
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Ahmed Zaki <ahmed.zaki@intel.com>,
 stephen@networkplumber.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, xiyou.wangcong@gmail.com,
 netdev@vger.kernel.org, "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 amritha.nambiar@intel.com, Jan Sokolowski <jan.sokolowski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
 <20240222184045.478a8986@kernel.org> <ZdhqhKbly60La_4h@nanopsycho>
 <b4ed432e-6e76-8f1b-c5ea-8f19ba610ef3@gmail.com>
 <ZdiOHpbYB3Ebwub5@nanopsycho>
 <375ff6ca-4155-bfd9-24f2-bd6a2171f6bf@gmail.com>
 <CAM0EoMkdsFTuJ-mfqBUKZbvpAzex8ws9jcrPEzTO1iUnaWOPZQ@mail.gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <3c5c69f8-b7c1-6de7-e22a-5bb267f5562d@gmail.com>
Date: Fri, 23 Feb 2024 13:44:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMkdsFTuJ-mfqBUKZbvpAzex8ws9jcrPEzTO1iUnaWOPZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 23/02/2024 13:32, Jamal Hadi Salim wrote:
> u32 has a DSL that deals with parsing as well, which includes dealing
> with variable packet offsets etc. That is a necessary ingredient if
> you want to do pragmatic parsing (example how do you point to TCP
> ports if the IP header has options etc).

My understanding (Ahmed can correct me) is that the proposed raw
 filtering here would not support variable packet offsets at all.
That is precisely why I consider it a narrow hack for specialised
 use-cases and thus oppose its addition to cls_flower.

