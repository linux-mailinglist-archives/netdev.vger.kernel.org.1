Return-Path: <netdev+bounces-199444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0EDAE0570
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9801179669
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7234223F424;
	Thu, 19 Jun 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtA8fXNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF023B626;
	Thu, 19 Jun 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335602; cv=none; b=pUqJm5qkibbEOcu8/oXL1zmB/GYJfJxqzH/F//16q8AR9Kph8jOwxMxZa9i9nzwzCYQqr1uA7oS26JY9iFbEWk0SpeBnWuBVy34b2Ro1NM/rmTM7+vQ7+AmRV+/UWuVPoiKoQPPAt1t2vSwNByH9iJnMmZcNLUncphAONEEaKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335602; c=relaxed/simple;
	bh=mMpmDwlVnVcBmBvBNhvaIsBGhbhK9i0z1cU1YrEQtbg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fSKySXRol0M6rB5XPv7PP/Plb2+qZKd0Z3mkGztEKnmYfG340inhZskosOpx6A/naP8zR2k3+WM7yhPO5ivcz52UR1OR6ltaxYNyMApZMrUVr4QkbUxrWMED8CYYavsneKf+1+8cwgxmnCAljJ+MP+zDbJs18kydpTVc0F1S210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtA8fXNw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a365a6804eso479817f8f.3;
        Thu, 19 Jun 2025 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335599; x=1750940399; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMpmDwlVnVcBmBvBNhvaIsBGhbhK9i0z1cU1YrEQtbg=;
        b=AtA8fXNwr9C+Cr7uP2eO77AP0xK5/1E4k43Cf5e++6gBltL9E0vUgMaPHjCGEX5ZHd
         EFOkAlev/LC7/zEHJoku1U2qm8SJ7ucRY+sfY4SThUuAKFWkmreTu9JFwCjaSrLy9jSc
         v5cc0OqIOupd+xUkU5vWJIQE02mj2Mk2fp/kbubXDiWJl12E5y+QkeZPMHp7mXhvl+Ou
         zcDWxZTgtw92Ju2egWGK60srdkiwswOJWE6/Mj8v0UXAFec8fbigbS1Vwq7B9cSkrupi
         hl0/BHFm8ZC7G3Zhj1FzZ3JQXjwRSmyk4rWFvN5R4ZuP3LcQgHIXSeyw5URJset0/bM1
         ZGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335599; x=1750940399;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMpmDwlVnVcBmBvBNhvaIsBGhbhK9i0z1cU1YrEQtbg=;
        b=A3YWQNgP3SJxrJ9AsoVa1gxQBo+Nq69F050N2Wy8dMbAMVl9Jh9ZjbSQMBHiF9NxGH
         ny9s9H+8kPDJXUyxcUXpyWxwOFlhdHV28v7kg04dw+jUK0uCF6/zsIpx3rk8Htd/+Cqh
         MaONF5WGZAh/EJIuk10QbXvRMt4aw8DUpIRhyR7vP6Zf/Ao1X1mVDkCcSAnmoSGFrWw0
         V5Dde9mebmO7SDJOgIEhdlJJNzprqp9YhB/Az16/Tfzb2v4TBcEZxPFWlShmzp4hn4o/
         jGFfEyNrpEiWZxLumphPQtxPqqjzqyRr3WT5fLiOadtJn6XL0wD4bRgNEg0Uv8qBtcTG
         f2aw==
X-Forwarded-Encrypted: i=1; AJvYcCUvG0u2XqxP5TW6TuXhjn0YzMo1Rf5tbcQfh44fTw+k8vdhD9QSN6unHqSxIvr+r/aaGrAM0K2Gs7jg0uc=@vger.kernel.org, AJvYcCXsX+Zh6qrkx0ynN8ZHBVEIikBRLa71XGF68Nniv6igWH8EGcA4j8FWv3YIf/NogeYfdO0IOxrV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VExyn+MhTte9/Qs9uMq7+WoMRrgd78hd0tqpxuxRiO7uKMdE
	YOLd56kv2LgkK7D2oZ6Fk9/91dLTTAfV7NiYV/NOzPQ3MNhW3EK6MCyY
X-Gm-Gg: ASbGnctQZXTXdso5M8uq6Gn+2Lnd9T2sUifm5R7qePnPfYj5N+XAeEtd3M0YNWcf0NK
	VeImg/1NrBCa4R+ZzFmhivosPNqJE/cIQPwkKffTdr9CFB1Xkdg49SBHhx49ReF/0Db5QIwfLd5
	mTcvZf3Ww0nx+I1hJFR0t0D2nWgWAjH9ut5dHYt1wDkIsy8neUxQag/pYvICziEMseDRej/CrND
	3GY5dOoEYiIu+mfhn96feQ2z2VYzkEde/GYam/xgltkilh6TEWBCDtLk2TVRARC3nia56lKQyx3
	ZYYl/ldLlOm+1im2ps1nqhWKbWi6vU5HP225N6cRScNvhLuWQImYeEIViG380PyAJ/IjpCIr
X-Google-Smtp-Source: AGHT+IEuKF+bQ5gYYFetxK0YaeITBhBK6iH+oKo+esDonRaTES/WRQtRuQDWIQVznNNZ71YFKx6LZA==
X-Received: by 2002:a05:6000:290a:b0:3a4:f520:8bfc with SMTP id ffacd0b85a97d-3a5723a3b03mr16583899f8f.36.1750335598730;
        Thu, 19 Jun 2025 05:19:58 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:ad83:585e:86eb:3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b5c372sm18955395f8f.89.2025.06.19.05.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:19:58 -0700 (PDT)
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
Subject: Re: [PATCH v7 03/17] docs: netlink: netlink-raw.rst: use :ref:
 instead of :doc:
In-Reply-To: <205e2b0baddabf47ab23ed08fbddd3fdc0cdcc58.1750315578.git.mchehab+huawei@kernel.org>
Date: Thu, 19 Jun 2025 09:57:40 +0100
Message-ID: <m2tt4cf6rf.fsf@gmail.com>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
	<205e2b0baddabf47ab23ed08fbddd3fdc0cdcc58.1750315578.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Currently, rt documents are referred with:
>
> Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt-link<../../networking/netlink_spec/rt-link>`
> Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
> Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
>
> Having :doc: references with relative paths doesn't always work,
> as it may have troubles when O= is used. Also that's hard to
> maintain, and may break if we change the way rst files are
> generated from yaml. Better to use instead a reference for
> the netlink family.
>
> So, replace them by Sphinx cross-reference tag that are
> created by ynl_gen_rst.py.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

