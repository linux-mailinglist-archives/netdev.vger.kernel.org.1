Return-Path: <netdev+bounces-187540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D9AA7C8D
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 00:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0454E3A81DB
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 22:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F0721FF31;
	Fri,  2 May 2025 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="domp1Npp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BD215184
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746226674; cv=none; b=IcOTpVpBve3Aa8aS360GBFd2RbtbT1qqr37t7FaIwJMmAL7uYRLqnJXgWBh+rJjC5JVqQWlqYpfucIC6AGUP8IfZnrtoDQhUuh8IrIivrDak5fDwRKsWJ3uh1Z9MD9fWb8YAu39/SF3YAD8Kol5+QBj//SXGn7CiiY4lgAHDfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746226674; c=relaxed/simple;
	bh=DnWI3nGNx9S5wJ+DsgSv+WFoe6n1Ef7rjuyL2+xSVFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IPHphY/vnGt9zJlvW/8uVKP9O+9r8T+d6w/c49O7RVHSEA2j8Jt4DyxmsJmyAElXzxzulKDVanosN7UYYi7G0EcM+tdmM4eJhCCtn9Chk7MhNJfr2Qet8jOZpqLufclAu23crzcsHyYRl5ryA0UDx1B4ck8bAU3sWeMf0LOi9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=domp1Npp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746226670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=f42lRMHWSGx8j0JK3dHPeukPLQGAFx3kblNJVcHKYX8=;
	b=domp1NppA/6KqNFJ1exl6epbvOCVgWJs1ZCj0mdIEeTXXyf5hflEkU4tkHO9zUqiZMvVun
	4HZAgFT1ewHxRxK8mJ2UhmNGODwNxdU6CJQT8l26EaY0H5DEC5EPeFCsDC5hVxzEurucCr
	1vNfjbcn6u/la1Yds/U+ytAH4fFuH5U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-gBE85iAfOaaSE1OMqKMFmw-1; Fri, 02 May 2025 18:57:49 -0400
X-MC-Unique: gBE85iAfOaaSE1OMqKMFmw-1
X-Mimecast-MFC-AGG-ID: gBE85iAfOaaSE1OMqKMFmw_1746226668
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso996908f8f.2
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 15:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746226668; x=1746831468;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f42lRMHWSGx8j0JK3dHPeukPLQGAFx3kblNJVcHKYX8=;
        b=m/LbULoWK9MGnp2Lzre6goEORQZV3UXDJxcC/J71l0yiscZ1638wptiipRCHOUep2F
         LLAMUhZzuWahKLRGsUyBb4NuVDUMEjEriFSUbzxFTCSO7GHatrTx3GgWlsN5ES5KbkC9
         NkvAceUAJlEHTBv4ODRCJz0jKXhWHFaP6Ny2Xh3XWrnKkwboBosYIW+P7COX+nfTAmY6
         sb9V4HkXgHjL28lGE3ExTufphn2SBPoFDkGJFb8EJlU36PkSeNmBcid4CCxjIpfbkamk
         weWaDZRuT1ul8MusYJj3Wv1p32KgTMLLwRbd1UcbDEq/yXm0aTsehSpQHj4INB7MyFyu
         i5kg==
X-Gm-Message-State: AOJu0YyVKw7ed3lR4GPp/TdI4ty97e0+Dyebzw2itoMymtRdmg7wQnr5
	iiildIeJhvcLXH/hOGwBd3WFFKS5T906GWExUC39UPJ9PngiBf8lkfUK63qiJU2Ahc20a6it5Y4
	KysP3NXqWu/3WvnLo+6AiIkyHWfBgEK8fIB2HI7POV97S2zcpKIqTMw==
X-Gm-Gg: ASbGncsyqwK48iz47qJ95wVhXUuKprf194s4yhN+q08MDiKDcpA8byCGcbm2Od/ne0Q
	wHuMreP4sX3poRIYOeuf7UtGxl4c1We4VxeSqDOsKE0bkLx7VONalwyucU0YuLy8jZfPf6ESwWM
	ZhtFPB+tLHVdoln52S9h+66XarfvX+cRyg26StELbFYyXTvZQNTN511yuoe2LzOREnsKljbv1Xf
	1m2sdYckioq/+9cEMrbrM8ITodAq/ztBNxs7N2elxud5jECU3sqmCbr7L6DH0coiM3Jbq8D6Q9R
	+pIqSyPjFllV8OknlO9Alxn845b1ntmfdoD2Qh6MecxYIZLMqlu+FOuc1457x68Ufw==
X-Received: by 2002:a05:6000:1882:b0:3a0:8c67:508b with SMTP id ffacd0b85a97d-3a09cf4e75bmr597413f8f.54.1746226668519;
        Fri, 02 May 2025 15:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRTF8heH6EvU50HFTlA/lkriRJZ4M//bFaMNZXLJ5WzkNqMwp/gt0K/7CXd2OSVOtywr3Nbw==
X-Received: by 2002:a05:6000:1882:b0:3a0:8c67:508b with SMTP id ffacd0b85a97d-3a09cf4e75bmr597399f8f.54.1746226668209;
        Fri, 02 May 2025 15:57:48 -0700 (PDT)
Received: from debian (2a01cb058918ce003eb206d926357af7.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:3eb2:6d9:2635:7af7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b16f00sm3172849f8f.84.2025.05.02.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 15:57:47 -0700 (PDT)
Date: Sat, 3 May 2025 00:57:45 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net 0/2] gre: Reapply IPv6 link-local address generation fix.
Message-ID: <cover.1746225213.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reintroduce the IPv6 link-local address generation fix for GRE and its
kernel selftest. These patches were introduced by merge commit
b3fc5927de4b ("Merge branch
'gre-fix-regressions-in-ipv6-link-local-address-generation'") but have
been reverted by commit 8417db0be5bb ("Merge branch
'gre-revert-ipv6-link-local-address-fix'"), because it uncovered
another bug in multipath routing. Now that this bug has been
investigated and fixed, we can apply the GRE link-local address fix
and its kernel selftest again.

For convenience, here's the original cover letter:

    IPv6 link-local address generation has some special cases for GRE
    devices. This has led to several regressions in the past, and some of
    them are still not fixed. This series fixes the remaining problems,
    like the ipv6.conf.<dev>.addr_gen_mode sysctl being ignored and the
    router discovery process not being started (see details in patch 1).

    To avoid any further regressions, patch 2 adds selftests covering
    IPv4 and IPv6 gre/gretap devices with all combinations of currently
    supported addr_gen_mode values.


Guillaume Nault (2):
  gre: Fix again IPv6 link-local address generation.
  selftests: Add IPv6 link-local address generation tests for GRE
    devices.

 net/ipv6/addrconf.c                           |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 177 ++++++++++++++++++
 3 files changed, 187 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

-- 
2.39.2


