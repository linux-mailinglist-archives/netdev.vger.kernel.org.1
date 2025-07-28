Return-Path: <netdev+bounces-210522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C05B13CD1
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48B73A5613
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBFF267B07;
	Mon, 28 Jul 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Is53yAeK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE81865EE;
	Mon, 28 Jul 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711945; cv=none; b=uKb2ihiyIAfm83fdVGHRrwP+x3k1m+qRgwKwdd2ZNckI9F9uANNuUlhTpouXNY1xonLRsC8Yv0rQxT3DIPqjEjWFHMZQceApkm39dZorCdAtM6JehtmSVaJzxggDmBmf+23ivweIAkMmVuo//8IfpAugAFM507kJ+YJ/3aWcx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711945; c=relaxed/simple;
	bh=yljNVk8tKwQnTxCDi+S/sYjfINxPDX1oiaaMa/8E79o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3VyfkP/Kj7NIXmRrasN810KQtS/6dEVr63fTCA4UCEkWq7N0d2HaZDXnv7MOUogFYmoaP1yapKISiUp4k0ydsJCsqtarIVEe1+JrT4dbl3FqUOepFxEpTWZKMPiymW8/AGGMTKC+G0woRJDfWD2TvzjFj0FZ5i9cOFYxYxMq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Is53yAeK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753711944; x=1785247944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yljNVk8tKwQnTxCDi+S/sYjfINxPDX1oiaaMa/8E79o=;
  b=Is53yAeKFxHetofWoO8Y4FdW/yzGPSXijeVa6bgKpryKcTQzIQ82E4W8
   e04x1G6SXW1QBgxqrCWqLpf7QXZL0c223/N0wIwVvlKGlfwBrflJyFGj+
   EKvcG1lC/POARV3WTdPO9bBajQK8XZ4zhYUvJHJpwf/LZKyh1wMgnVTMK
   E7kvz7arTJBaJ1vfa1bjpgGWBRed0oNHGCYUBFmH1rr41nHimbqsQ9z7z
   yJNX7s4n+ZrxqXcJ5G8gEfcpBWA9ldZENsRtNgWQYSAsix2IPRZcBvLun
   JuJ54MKmNb1YhIRqXVeKa3zF+9+hObLw/KhwFM/0inaWXNwYZ/nXTog48
   A==;
X-CSE-ConnectionGUID: X3h/WkQtTbKGZntHFnR6YQ==
X-CSE-MsgGUID: 9bOQEkhoSXGidl/AqimY7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55843584"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55843584"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 07:12:24 -0700
X-CSE-ConnectionGUID: aczXzlIbT5Gxm7K0Z7CtyA==
X-CSE-MsgGUID: BH1m9tWeTK+NEDm812SeoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166618830"
Received: from hlagrand-mobl1.ger.corp.intel.com (HELO [10.245.102.40]) ([10.245.102.40])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 07:12:21 -0700
Message-ID: <f7bf8311-9334-4e62-8235-6349aa8bc524@linux.intel.com>
Date: Mon, 28 Jul 2025 16:11:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-28 10:35 AM, Luca Weiss wrote:
> Handle the case for v5.1 and v5.5 instead of returning "0.0".
> 
> Also reword the comment below since I don't see any evidence of such a
> check happening, and - since 5.5 has been missing - can happen.
> 
> Fixes: 3aac8ec1c028 ("net: ipa: add some new IPA versions")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

