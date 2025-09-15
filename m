Return-Path: <netdev+bounces-222976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4DB575FA
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0D63B29D0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2292FB98F;
	Mon, 15 Sep 2025 10:14:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052A2FB989
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931268; cv=none; b=D1dAIQSi47Hkr3gpg6beXYMyWWn33SZwNslGOQS6Nj7NuHuicP35x8KXJEILWYga2zILryhiW6vBRITtGL5oK20UeDcxgi3yiJF2gsUv+tClh8e3YU34N2ofEsR617mc/J1UfzL/UhaSEuSn1Yzp8rJ+fXmjZXLR3F+paJ4tCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931268; c=relaxed/simple;
	bh=BFkYAVnkH2G3tHQvvwVQ1V5rL6JuL+NPjw8B1yOjfng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJXjzHvNOoW0kpHTn0YX5tCblSgRCHJGcUiA4N9zpfTXve8v8xFQxKohWEQgNHmj0nXPb2nv+HmsUYpQK88EJjavbAaSJWkRu3IUz59dvdBV/aPqKUDa1fJV6Tm0Z/VE3IK9qzv3vdfFbeKNp/Um+kbf/B7gV9H0ZD6zflrncXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso4980344a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931265; x=1758536065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAygs02+g0MbJDsAinwMyJxPXjZQb+F5N8Jalspkf7k=;
        b=ul4bYaKxXpgfEyzRDVD1jO9E0WJNAJohDtqoyfEOLOfBtDaY6dI+lOkB41+A2bCYMy
         kxdnSCXXMZ87G9yREPkxU+Q1FZm1IxB7ZbBpRl0H8jhp2ucn6jYG/ItnhGa1jL+CLNND
         jad2qDnYqzSio2vMiK4CJaLC9izqxJiYWz2rv1QL2qM6cMmm7SRmVG/fDRfy+4xcSnm2
         LkNDyp1mXJPH/qlTcuk8gSBYBEMGzRo+pjOAGadS9tmcwuu8MFGtx3YJSNpOPaev81sb
         u3gqSQ25C06WBd/q4vBculObezGoH4WZfXTKf05F/ZoyQtBOibq1Kc8FqbZzENk+qk/i
         WEoA==
X-Forwarded-Encrypted: i=1; AJvYcCXuaPCnffOkc95t66obND6Tp9CUWs0STZNtbpYVmaJZipucXiaOGrnG2kaN9qxcsBDiRiyy3K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tYACQRYTTtqWUL/dLpnppba66hWM4jaueK7NoDs68G8hF8xc
	VMQY2i9/e83sVD8kNMJVelZ1oadV6nRMMq1cfeH4ErB2L5a8w7k/3aIp
X-Gm-Gg: ASbGncs3coeHIH4u1M43LM684owDMyNmPGuNZNP3P5hHDBzTM+QTjekXpGbh7YBqAHe
	SNFhw7nyKcIjpRs6XwEKJARWzh11nfaFNixaaYmIg7/a6nQjtnatEqYgNLUXeClNZoU59OAqgPQ
	D4wICkiUYq/dLP8bgiFX4c6nidyGIKOsnvZ38w+P2Ehq5XJD8kPjD1u39hbnyb/QlSyDb9q2mU0
	qWbXTBPY6QRfEpGdhN6VszdgZ5tQGDR6fJDMJWVnQmDYAFlUGOknDj4oLlEhiOLgRSvBYCfdalG
	icPseXXrMk1jzpR4M7IRC1L/xe2K1dAUN1S5wmq3wWE5B1Z5oDChII2pPgz3Fr7RfpaGpbPKv1N
	EbTSE9AZq/KIS5BaEUcexrupo
X-Google-Smtp-Source: AGHT+IEoBsVRHvl1p4Zrqcs2rmBL9VAocz0nQOrX2z7rXzNaRyuk3E8aAvo7oAfIKkCJMF0C0LG8DQ==
X-Received: by 2002:a05:6402:454e:b0:62a:a4f0:7e5f with SMTP id 4fb4d7f45d1cf-62ed840792cmr10145278a12.34.1757931265011;
        Mon, 15 Sep 2025 03:14:25 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f31fa406esm2498318a12.11.2025.09.15.03.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:14:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:14:22 -0700
From: Breno Leitao <leitao@debian.org>
To: kernel test robot <lkp@intel.com>, anthony.l.nguyen@intel.com
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 a6c7254e995a80be8c3239fb631d9d65c9e75248
Message-ID: <mpxxgmukbabs7hkasdph24vg2pt3myjojab3vocpgerm77so4m@n3dwy7mypowe>
References: <202509140606.j8z3rE73-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509140606.j8z3rE73-lkp@intel.com>

On Sun, Sep 14, 2025 at 06:05:17AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
> branch HEAD: a6c7254e995a80be8c3239fb631d9d65c9e75248  idpf: enable XSk features and ndo_xsk_wakeup
> 
> Error/Warning ids grouped by kconfigs:
> 
> recent_errors
> `-- loongarch-loongson3_defconfig
>     |-- ld.lld:error:undefined-symbol:libie_fwlog_deinit
>     |-- ld.lld:error:undefined-symbol:libie_fwlog_init
>     `-- ld.lld:error:undefined-symbol:libie_get_fwlog_data

I am having a similar issue on net-next, where the kernel is failing to
compile due to the undefined symbols above.

This happens when CONFIG_ICE is set.

