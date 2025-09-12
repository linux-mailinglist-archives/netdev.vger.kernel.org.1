Return-Path: <netdev+bounces-222402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B9B541A6
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 06:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CE6486C30
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6622D4F1;
	Fri, 12 Sep 2025 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQeubunF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991179CD
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650788; cv=none; b=n0MW3Zst33IGB4k40fKgExBEtttlYUOMtfzbRdJXWBjbNZU9Q43RIHeZV6UTrMMe6C2fs0IeZvD/qY0jry7fxorcVfopIGJwtoSY9ADWdqJWzMV2vglmQLUXWthm8EYtujw6y0I/RWut/ZlwBXzwzI6m0zHpzxsbM+Pvew2ygaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650788; c=relaxed/simple;
	bh=+JSxQ+gaH1zt0MkLtqDcrldmuerhcNAt6ZV7U/9yqY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM9ZTXHmGXvSXvcFj5C+lWQIOT370wCIZrIHZq7eqfhFR+ARbdywqeq58fc8uTEqN+ouDRt2kzquLZGq1EvoXAa7RcBqCzUdePSi2Q+NOFFIjrB+ptVeSDyjuHmUItZk38IHyhE2CMetuHJl6zOZCpO+UmsTzd7Sr6LxCcJj4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQeubunF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-251ace3e7caso19094235ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757650787; x=1758255587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6nKvu5cfJ180DRAKFjFgHBVhF1AV98rGP3oTY8bGprQ=;
        b=TQeubunFiZqZDah35xyrbJzMHyCGufiq99Ofn3iYvwDXiL5YfJU37kd51LGaHyCqIa
         8xkJQeyGuROUhIVw5ysh16DZwlJzevmLYIOyUhZ+2f5jlP/N4p4uxwP+hjhLiU6glA31
         lEuTOtaHJ3ATn3gn4jQa/zVCo2HX2JwWTdqA+pub68z8Pnwq80e29H9JPVAW6QUVGtbC
         99kYM1gXLaC6DsV2YEKBWAY5RWPbwMQ47E7i3av0D3JSCVS+cxLlxZir7uDioT4YcgjZ
         hOoRB7fJrpo1N+LND1+a58IXEAxomPx4qp2N8pbVOtO5tzoiFifs3PHnkmFbrHLFEVb0
         /NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650787; x=1758255587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nKvu5cfJ180DRAKFjFgHBVhF1AV98rGP3oTY8bGprQ=;
        b=n/CuAy37E2LDtPDeE3yPxW/3+nasKVjH2eKzr7RPXVmuQi7TU4RhMfvjw4p5xsjPVh
         4P6ucbFCZCx0bo/NBYaS58VNHLZxhqYOT+H/oQzL+VAys+UhxLI1jJ/U8t2q0hmzjRzw
         XEQ7t85mCN9Tz7WATAoBsMjQy3hn32lbe5hmfD8fNRHB4bTL1k1TeV+Yz3KXIrd1Htpy
         6XXIw4neqvMI6JysxmqqKuNAiqq9aJDq29CLZcSexBR2Ux8f7kxgMlUj2tWREEh7hcAc
         9teLn68/2xZ/LgVGD67E2j7376WmxfWdb8Diqin8owFcbR+ZdaiVnQrrP3YBcNGYgDr3
         m03g==
X-Forwarded-Encrypted: i=1; AJvYcCUn9iPVNbBr2L8Ac2GjU4BnRs3YmDWidtXsPlrVcTVktHv5gYq1j/a3BJMZeY55XuRFK8WUhQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gAx1yD+zTS1uRkIQndBQiMN2CfnOgXyf408LacVZNYErHQL7
	jlMpH3+r6A7BRMeOsTFAsYSpBKcxV0Tk5J+g0JCgoyzSzWqMIrK7p1VF
X-Gm-Gg: ASbGncu9Y8dFMNi2A82+ICVw+T2gSIpYc+MP6d1E0QAZD5thbsgO6N0sfvJFJALoR1g
	2popm0nfUWiQNaRyeBaRd2cq/FlFWrrfNLbVkTFjrsnSadOAgXTXRVA2WmLNVNZWMY/YLd3n5BC
	aSHTXPycq423Wvbo1wjHEn63i+q+cyy/OKfmvr6Sro4dbmkHrmjtVlDR1kqOFkSSaj+ZmJfvQiM
	+NxqajexAvxGGr/HNMbp/dzH97ZkbfqWKAi35RkgebyDZi/B+1Fo8M14lQEO2jvD6t/aztsrC7Q
	hfRYKoMJcFYJzZDSfiFnAP0NU5tNLy+NjjPRKFkqWg5sVu3cZ5o/qbH84CytSoeV9zsVGsOVxny
	bUtSyf/ejrFDkQc8XjKZR+sNC2/fx/RMTUXuV
X-Google-Smtp-Source: AGHT+IEm8DAmJ1SQii6dr3UbWWd9Pal3Of9tFu8U2LJtG2TZhT5L7kA+tBte6WgeHm26m9BBmQd6nQ==
X-Received: by 2002:a17:903:1ab0:b0:24c:d08e:309b with SMTP id d9443c01a7336-25d24cac50fmr21771995ad.15.1757650786678;
        Thu, 11 Sep 2025 21:19:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84957bsm34884335ad.80.2025.09.11.21.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:19:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 41FA141FA3A4; Fri, 12 Sep 2025 11:19:44 +0700 (WIB)
Date: Fri, 12 Sep 2025 11:19:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kenel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH net-next] Documentation: ARCnet: Update obsolete contact
 info
Message-ID: <aMOfYJgE-pKSAbWc@archie.me>
References: <20250912040933.19036-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250912040933.19036-1-bagasdotme@gmail.com>

On Fri, Sep 12, 2025 at 11:09:33AM +0700, Bagas Sanjaya wrote:
> ARCnet docs states that inquiries on the subsystem should be emailed to
> Avery Pennarun <apenwarr@worldvisions.ca>, for whom has been in CREDITS
> since the beginning of kernel git history and the subsystem is now
> maintained by Michael Grzeschik since c38f6ac74c9980 ("MAINTAINERS: add
> arcnet and take maintainership"). In addition, there used to be a
> dedicated ARCnet mailing list but its archive at epistolary.org has been
> shut down. ARCnet discussion nowadays take place in netdev list.

Please ignore this patch. I will resend with correct LKML address shortly.

Thanks.

-- 
pw-bot: changes-requested

