Return-Path: <netdev+bounces-198583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2127ADCC33
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D863189968A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DA32E92C8;
	Tue, 17 Jun 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+NEw9tF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945D2DE1ED;
	Tue, 17 Jun 2025 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165204; cv=none; b=DQedRi9rLOVT05V7AaSenI3EhhNGqcOlHGl0PcEjzAJZuxFQZC42hCCPhow8tnnq6IVVnoLtUcDEqIGYHOjxYoYd1l9ULl0mfZLSeifURRpTh+yOl31YK+YJ2tHf08PiXKmFUsEIFs0K+Y62W/urXQnG6sZftXEznhtGU0QQuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165204; c=relaxed/simple;
	bh=oOGH7JrUTQsVKaPTed6EUUmZzVLb9azQu8wIKI3QOHs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=s7S9VKeplWA76lYFFXK7xsfyHEmxu0oMwc1UCWEXvdn9eHc1G3PzbpbRqdtQR2ZBDCnZXAp8T0xRDBhxDsAvGsViT2I4aR5Em5C+9GdN21ubfgUbhK64xP4QQZNM/TZMguCEaFSCPyxEXtBAALLsUGIYrslVYC1H908J8gYiuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+NEw9tF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d6ade159so47259795e9.1;
        Tue, 17 Jun 2025 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165201; x=1750770001; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOGH7JrUTQsVKaPTed6EUUmZzVLb9azQu8wIKI3QOHs=;
        b=m+NEw9tFIBqIUfQP52Z5fD5NGbLVD8mFN+OwaTIbLNXdwzb5u1t2bmhjW43sQcz7dH
         SbYLlf+9zrzA3vYGXJSPxoD07lFRlXIkp7Ddo7SXh5d8LsM9MfuldIqwiMh/UpTABz92
         zrV2NdBBluZtgO3UuN76vCzwkUzJVwCQsI8rtl9fBusR/fHzY7x597MZL9iqoRSdg2IZ
         kKnAKtX4rIIX1i6amLd/Dk92Ra7cZvrDN6ADewyXZfxO4fU+WZRwK0YnORNs4ePD+A8M
         y9C/oRauvg4BcZeHNNa7uNiodEQIbLHRW5Uxp37bhsLcVlb2k3Rc7P4TnTQWTel7MAhK
         p+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165201; x=1750770001;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOGH7JrUTQsVKaPTed6EUUmZzVLb9azQu8wIKI3QOHs=;
        b=bf9cWQfykwqQVdvE8oZ6dfUj9cnmtvZgqSxTDKGC9AVVwmRlzgUqA2l3aEcklhWiFU
         gNF5a4qMUCTuGjOvkoEnadJVPZ079y7k/hcY447Ih/qBzXJv6lEmtS6Tw7guuIXjyOH1
         hraRmLuDGCv5yy448/d2uup112d4XfLweZDeYRGzVisfJd/ox03ZcbpeATvIbiM7Yizq
         P061UrMQHwCUEABqxH2azmjJCdwec1CK1kid4cJSJUvCPigWIilQ4mJ0LB91I1ZF4C1H
         3OPbBnp7lFNjd9+V5vSKQRTFoFXBhgwtOc64/wtGWUGJ6PrKazLQTXBklaUmkLwgVxD1
         xNpg==
X-Forwarded-Encrypted: i=1; AJvYcCUZO1k7vST8QZ1ztrzBJlHYxuSZMAkAv3TSxtp+7RSsudwTHDMoEw0nx4zoRAtSV+LKIjSVuqI0r/7oXGg=@vger.kernel.org, AJvYcCUcLsvefEieSocp7/PImjOGIqGm5Zw9ZifOpBaqyJcWDOAs4/bZianKT45fc9vv5/wRzeV8oH2k@vger.kernel.org
X-Gm-Message-State: AOJu0YwwK6nBxtvgIvgl76qnLB2zCnUZ7kZtemYZeyIAcFZI4VVNgzQF
	1nNvX6zi3YS8X00+gLW1csU8x78cMU8Pccx1/K0bT5C87AccqB0qCTGd
X-Gm-Gg: ASbGnctnt9MPLEwD7JAuig4iqxycYNVNO78OWdJJq1OWHRTmop/7wpL+fPK/2w7F0de
	je3out0jLlnQ1ZQuE3vcziRbz95ELag/nqwC+DdIaHjjQQr57xoxjZHf5EEJWWtv4Su1vLxSsCd
	G0ClWd1WdsefScqm+jFrHBxDoyROI1qkqZCgok4DcHDGE7yW47Axx5EAw4SwLwS1oBwDM11KSfT
	cU04BRLEht2EiTRpCHBRRM8h7V6wDXOJYLNwXckt7vP2u30Cce5M/Dx90VcKV9kw6PU6+Okkndq
	58ZErZ2LjTkV7n9yw5D8ylNc+IVSQtvf5ifFLqZdpBAJRiHonDVxeDsWjg9Z3HQZ4Fe9A08Fecc
	Jz1MNCGVQ4g==
X-Google-Smtp-Source: AGHT+IETuY2veNgQQqSIB3Ky6YQwB5mMQ2rh+RHx+Fzcqage9RO7z8pdqYCPHjlEHVhLI1hObHSabA==
X-Received: by 2002:a05:600c:4f14:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-4533d05d802mr129289755e9.0.1750165201251;
        Tue, 17 Jun 2025 06:00:01 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e259108sm173519385e9.32.2025.06.17.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:00:00 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v5 08/15] docs: netlink: index.rst: add a netlink index
 file
In-Reply-To: <4d8a16864767c1eb660cb905dbc935a3d0df8d9a.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 11:43:03 +0100
Message-ID: <m2o6umk5s8.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<4d8a16864767c1eb660cb905dbc935a3d0df8d9a.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Instead of generating the index file, use glob to automatically
> include all data from yaml.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

