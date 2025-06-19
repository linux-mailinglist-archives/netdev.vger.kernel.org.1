Return-Path: <netdev+bounces-199446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CB1AE0579
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5083BD035
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD8248F49;
	Thu, 19 Jun 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfioIJ0r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C42459DC;
	Thu, 19 Jun 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335605; cv=none; b=PApmUIOwxic/ok7O1ov+hWt37QNldKCxJWTbjn/AoJLJrhufmA40DU/oYPk5d303DNxowRTjzAGUpPiUTWG8Plbq92at0aBbjHV1udM4e69PQDVgi/GLNwmB70ulnpC1hLOmSxbsLq3x8RQE970Z8rQBghdS0ZO+ComQJw+y4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335605; c=relaxed/simple;
	bh=SFVUled2DNWsQTvMSa+zPfq1kFUaKNFnt90w8B3bJxA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Q3AWK3D+aYz8sNY7P7QrRGAAda3a1FQ66PapvSgw+evRpNT6nQOQY6D1pKHPnauHi8tLqLFzWRweWF1jDCEJ/oVaUbC386a1iPcv3lErxo9gcmmjGYc8ukj2G0vYPa/N4KT6KYGq8CrB3uTgKhL+d/06KUChAm/Ge4hmilSO7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfioIJ0r; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a52874d593so715588f8f.0;
        Thu, 19 Jun 2025 05:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335602; x=1750940402; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFVUled2DNWsQTvMSa+zPfq1kFUaKNFnt90w8B3bJxA=;
        b=YfioIJ0r4+4GE1SE/H321jJtIVjUxdgdOl4HwzdpUVdBzVJLdRr5zZPtcjiiS2klIx
         4S9svzAjoNrArTj6FSXWF2nTrN3rBxvXOiwpGrNCHIf+3T8r/xr/cZoO9JVV9KJG+K2a
         ppnqj1zKkWlqvMCl/wjAPbFx5xWvT+aBmApUn6tKOv5XXxFK7mUM0y+yxcy372VpzEGQ
         u/pu/NMf9+pwCrvC4AcQcaQ9E+Zl1vyjl7nbUTozxPIfmSJpLqaL5kuIA3vpAdZo0f4i
         gF3RhcH5gxuwC+reh59ylZ6ImCoxKPPQChERhe21tzPhqarv8E+VxfLKmzNA/eSe013m
         1c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335602; x=1750940402;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFVUled2DNWsQTvMSa+zPfq1kFUaKNFnt90w8B3bJxA=;
        b=dTDzKGx1hlQNcz0SIAB/HEkHvhqP+WJYM7HXwecGgmOAvIHZ+S97s/WSqd4LHCgbWj
         wq+K4sgoIApumjcwASGxhSFdANlnpM8jMtE+39BbQ22e3QGPTdjXjr0FciZvyvJCHRvd
         wvn50A/tCOMAQJNM9uH5bTzdzuLICButdxcZsyLss7MWEqqO3rpci1pl0fpeVqp1jFSH
         xQ6kNcapQC3/ZJuB8mYT3B8zhQWquonJqS98ZQl3+h7Mr9TGgcTaDZtd3vsJxOW+wSKU
         7E7d8U/Ory0H9Ppige0uz/I2yMUUVU3SbkZ0G9LTfRwn9HSUAo4hqi0U5DOdBRTWJtFW
         U6yA==
X-Forwarded-Encrypted: i=1; AJvYcCW80gzHJ/ruwHU/kqBDfNYbkrZHkNQ93A0zkFYbBLHzgnz4927DENxsIOg/zh1sFx5SyJU3pRFC@vger.kernel.org, AJvYcCWV1zoei7PDmDjbK1GRDP8Hxw4Ymvq28BjOQCZ8TmZU8Oq/VubqVaMUcFf2vbmdnFVRqF24+qxl8tAJVPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5PcuRc8sfrqLMTAohxQf/bEfD2pXqYSwHIlux+/x6c1vDBAh8
	XSUA41rrtjo8vstJFfW+l1AEwHXOAfUD0SE8Dju+WR8Dk1bwD9sy/Fi6
X-Gm-Gg: ASbGncsnBxhJmV8uGc0leL+44RfKd1X8n4dAN5ak2jvuT0knEqmYfk19OsC86IJTJ3j
	JjdACvLslZy9ZOIUqBXt9HkX+TaEf8inbGObvdDkhv6nNGCtwmYNGhUVe77SSyZUNQwUsYyGLE1
	HZJw85ma5wk8pGq64aMfLhtNRP4uAdm1VeH/Pzjys5KlMkbyrg+siilbgZW/feWk6Yk9V7fT+S9
	kshLN+6lI16dsCHD1iTqswEW96Jz9UrWycCn4/dEXsqB/6Yttke5kV8ur4yGaznhoUwjcdAM5fy
	ulHxcYlGCkoHC+2vSIBiB20gYCVcaXq4E3o3g78M+elZmA5o95mQLI6KnZW8i1ip3RiVSCG/
X-Google-Smtp-Source: AGHT+IHrpm5jxLPfVnVLJ87g+D7u7rNwqCS0PrAflkDvNv7ygn4IyA1hW4bxGY9gJHusIbAXcvODMw==
X-Received: by 2002:a05:6000:25e9:b0:3a4:d994:be4b with SMTP id ffacd0b85a97d-3a572367d55mr15927457f8f.1.1750335602053;
        Thu, 19 Jun 2025 05:20:02 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:ad83:585e:86eb:3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e99cad0sm27567735e9.32.2025.06.19.05.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:20:01 -0700 (PDT)
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
Subject: Re: [PATCH v7 06/17] tools: ynl_gen_rst.py: cleanup coding style
In-Reply-To: <901d329a2d679e05572eb399b39418a48a491844.1750315578.git.mchehab+huawei@kernel.org>
Date: Thu, 19 Jun 2025 13:04:33 +0100
Message-ID: <m2ldpoey3y.fsf@gmail.com>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
	<901d329a2d679e05572eb399b39418a48a491844.1750315578.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Cleanup some coding style issues pointed by pylint and flake8.
>
> No functional changes.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

