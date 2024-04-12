Return-Path: <netdev+bounces-87340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF0E8A2C1D
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 12:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01307B212C9
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9445339E;
	Fri, 12 Apr 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbjvkM0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD444369
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917082; cv=none; b=szOL8gq2JVVNSHHAfYZG8jv0eNaqB51tnCu1bZH2Se0/hpBZv9UUsv+tEZlJ4h6duG82lQtEa3ZDng9gE1kr3CwLc6A07maczeG9dYIO79PK7YWZUtcJkvnj/dYFDNnNpelfs0jxAr372HTYUZpRTwc3IV71FWai9ISQfzfSmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917082; c=relaxed/simple;
	bh=elC88KHAYs6OlHneMVtPz3fHA/cjHJaENdsIKhzgYic=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=T2dPZ18Ys+n12qewWpuLYviPWkrfVWp8YhHv14KzNmUOh/DccJ4wAHMK2EP65wQNhw+hTCCZsRZ9M3IcomZ7w5h2a6RjHLU/Sd55U8JuYDh0SupOvJ+NXYnZkNX9j8oJveCMwJEvtKX6AvHnlFm0MPbLqA3pQsbWdmt/suzKUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbjvkM0V; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56fe7dc7f58so566588a12.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712917079; x=1713521879; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z2BBwn6SlDQ4S/HPahNdeKASrWcoVdBnMsqhnKIrZU=;
        b=VbjvkM0VK7GGTrnzjnzQSVMb07fexIM/6WR4ubtfJWahelsEzF7HUqoNk09jcGYwmT
         OPA8nZp9t4cL6BOGsF/Pheeo8Q6zhu+pG2flF5F3Cw+JZk/YqKL1Pfrb52qgu+pPm+aw
         Pni9L+WX2Iq9E1ODPr/xAhPO46NyA9DloK2cT5onsdrkFoVUoQONwbMvCK8pt+R7A1yG
         Q+RZKNdv4fn6a6/qgR1Q1oC13FcK9SBIKCv+d1Dl43TfOtqwpp4lbEtJBvwjxoRPqrAi
         NtUtU//3c+Bjau9+PM+Oyd7CH2VjEYZ+B1LNpF5YqGN2HcNwovQOo+tr/6cFGl8vn15H
         hrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712917079; x=1713521879;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z2BBwn6SlDQ4S/HPahNdeKASrWcoVdBnMsqhnKIrZU=;
        b=aWrP3Z+naskS2QLhS/73tnqnMJILUzOu4MsDgo7317ErVTXujrLRcH9cemxsaJCNvs
         zwgg7lbIB/2Vt+541jSvj63APctnNCW+04R+r2rmhHgKYstRx3udO/Zs947A8ecxhaSe
         dZR4BwEf5lLxqp3TyVtH6Ph8nwXuOVXFKouezW+H1JiCgz67jSSm5BCBV8Tf0xpgsJF+
         uQd6JZ22JGS0buRT7JHGnzUm4x2OO4nye193+6O2lVdL7Are8v08K97tpgyLCiZQ4pU8
         fxxVc+d0DJiwO62n7HTNj1DaO12gvW/H45spUs0Il3k0fyxP/RPwCvNt9jAGe6e31SRJ
         sX2w==
X-Gm-Message-State: AOJu0YyZPZiArIUUSOdQNgaWiO7OrBvv3YxJss48sZocLAsYCzRKevTE
	5POSMVYv/TqEqDV9nKudfZ6huUiJDEgSvj/7FPHJsKr3U3OuwgN+
X-Google-Smtp-Source: AGHT+IEBHPVQzXP4EhXD+4xWdQCUCIy/YxukW9+rxsECOau/FFyfDMChLsUULP0ar+80ZANL1tHz6g==
X-Received: by 2002:a50:d716:0:b0:56e:63d3:cb3e with SMTP id t22-20020a50d716000000b0056e63d3cb3emr1514939edi.41.1712917078862;
        Fri, 12 Apr 2024 03:17:58 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a91:3c00:7438:ddfe:2573:311f? (dynamic-2a01-0c22-7a91-3c00-7438-ddfe-2573-311f.c22.pool.telefonica.de. [2a01:c22:7a91:3c00:7438:ddfe:2573:311f])
        by smtp.googlemail.com with ESMTPSA id x7-20020a056402414700b0056feb6315easm1292471eda.1.2024.04.12.03.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 03:17:58 -0700 (PDT)
Message-ID: <1d59986e-8ac0-4b9c-9006-ad1f41784a08@gmail.com>
Date: Fri, 12 Apr 2024 12:17:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: constify net_class
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

AFAICS all users of net_class take a const struct class * argument.
Therefore fully constify net_class.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e3d7a8cfa..427185c24 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -2046,7 +2046,7 @@ static void net_get_ownership(const struct device *d, kuid_t *uid, kgid_t *gid)
 	net_ns_get_ownership(net, uid, gid);
 }
 
-static struct class net_class __ro_after_init = {
+static const struct class net_class = {
 	.name = "net",
 	.dev_release = netdev_release,
 	.dev_groups = net_class_groups,
-- 
2.44.0


