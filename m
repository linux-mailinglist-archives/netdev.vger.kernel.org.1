Return-Path: <netdev+bounces-234134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FFC1D000
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4AE94E0636
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56B7355045;
	Wed, 29 Oct 2025 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Awzjat0C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B3E350D43
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766112; cv=none; b=p+3MVOjpM54xK/kG4IVI0xB68fRaXTKOR/75TMx76/z72QspG1bCbKjdZexelWTGvVsL+BtH56+DTHhEz9DZxQOrkpKavxGvNSRic4i03732iXaygwPaMvqECArg0YN18pwp95MhesygT0Gi/QALAUR0T0YHZFMqKqqMOHgFfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766112; c=relaxed/simple;
	bh=AL3CYfS00Fx70rXPXM7Mc2e3aX6xvwJdgxjXdI9oKpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb3d9e7m3F57tauYYY9ZYET28pFa/RfAnkaSl2icR141+YkNLM1mtjWHmEAAwrq8CckgL1Y2bawBF06bMcVSVvV9UZsZjBClmGJ4V7eDJNu8fud9MiHiZbxZTThQNw5fRLY963gMWaR/9fsrcC0IA6hzjGOYust6ZJltQiShWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Awzjat0C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761766110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KjuTIbx/sydMV7SyTNbfOcalUdqFKvl5PeumzE5gB4c=;
	b=Awzjat0Cw4xyKlu4ZaaEvRphKSsWtCv1F3F+EFRKJoG1/LFHk8tDO6tUgrB1UO+HEkY5Q9
	iOp+jR1S3VSgl4dLGYdfryzuiGfakPEp+uGFk8pO0dKX1vBr8lFB7pY+/maUUlLIMvbkoC
	F+Tvnr+QxlkYibxGdWvW2ocKZ/LCHH8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-8Z0nYaR8MgKR5ZK83jY5-g-1; Wed, 29 Oct 2025 15:28:28 -0400
X-MC-Unique: 8Z0nYaR8MgKR5ZK83jY5-g-1
X-Mimecast-MFC-AGG-ID: 8Z0nYaR8MgKR5ZK83jY5-g_1761766107
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471001b980eso1173635e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 12:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766107; x=1762370907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjuTIbx/sydMV7SyTNbfOcalUdqFKvl5PeumzE5gB4c=;
        b=t/hdJZnZSw+/af1TKQ7IMZwM+VunHi82gqIWMRVCIPPqrjYdeQEnEPRx1oxCkYIdfe
         ub0JyUBInfeV3o8g3J42y6hyqJh4X4Nhc//4xL9fyoJw+vkMsephAbc2O/qT7VUOp732
         ZMzILjj4Mg+y8B+pWgEjM+sGGHOIaPS3eourKtQFItyBvOFm6WgehwgajNR61YAzR+Zz
         vLEe2Cf8l1IMQbkKmCQenGGvd5uRc1uYBmd/NqEc7TxoCxp7Gf8IS3rH5bQ1QVv4tMqw
         rtPfWskStpKI0Zl9gPxxRb64XFE/Vr/yTHqKgIifbjBo8K5Qumi9WE4uaaSvWjUQS+vs
         coJA==
X-Forwarded-Encrypted: i=1; AJvYcCUXe2x0qPH1vJ+cbCzf8jeHfn5QFJBXVh9qLJjkJEfvLkjLMJBwLLiZBVcMvkyRgyrqmgXo/Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEUYe6WWWIztKI02mMvWE/sqfccD/2Fa9V3h/gCXR0hYNCvx6
	8jRNtGLqD6ZhqJqJ4JslbDNcygdM32PwguFLKChXRTyMWMMBVlBqPkUWAEEyidSACEqkRUxlnQP
	u9qNS2iwSI8xrvYU2uAg2CQFbbyleJZTgGUiIXjAfQISmGu7L/3p/V9hXMA==
X-Gm-Gg: ASbGncv9SYywwv67wLKDNyBV7LpCV5+nuR7/klNSd06ptCY64jmkIPYnk2FI9OZZHCR
	JdkD5oDi1bp2+zqien4gVVQO70eoAUQBQgQdGzrP5b8ZlNDYvvOsq7EOHCm03wPZVSiIbnk/mZr
	5Pe+XQzJ4woQO7mkiO2lM6+b0GwdJhnz5nLcurB9J5h/JOhhCq1ofzgrDPL/PaSHJvfZbHi0wCp
	rILTy4B4cyWfQRPb2xxslsBULnmakcyBJCLu1CBXetRH0ystF6BaTvhmRUuxTjUylavth+U5Igb
	yzGoUKTsw/YMxVQAeTz739KeerRuHpFgcAVgcyaJn5gK6NSyWlQGwjrpnPjGhkCTignz+ZbNG+F
	vDQ+PCOAiR66swcPhVRnLOM8+Uk+3S/TgedMcxnmRSKglMbZv6WMP1Q==
X-Received: by 2002:a05:600c:1f93:b0:46e:3709:d88a with SMTP id 5b1f17b1804b1-4771e3aca44mr36065865e9.33.1761766107370;
        Wed, 29 Oct 2025 12:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1k7S4qdaGiBa4JG+XTAQOcLSBUd3bZbgqjy30Gbd+dEMwjTXcI1NGa39yuY6Ip/UbVfQSwQ==
X-Received: by 2002:a05:600c:1f93:b0:46e:3709:d88a with SMTP id 5b1f17b1804b1-4771e3aca44mr36065715e9.33.1761766107027;
        Wed, 29 Oct 2025 12:28:27 -0700 (PDT)
Received: from debian (2a01cb05864af60085048cf99697d462.ipv6.abo.wanadoo.fr. [2a01:cb05:864a:f600:8504:8cf9:9697:d462])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771843eabfsm50418425e9.2.2025.10.29.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:28:25 -0700 (PDT)
Date: Wed, 29 Oct 2025 20:28:22 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 00/13] mpls: Remove RTNL dependency.
Message-ID: <aQJq1pOnbOLiBXFW@debian>
References: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>

On Wed, Oct 29, 2025 at 05:32:52PM +0000, Kuniyuki Iwashima wrote:
> 
> The series removes RTNL from net/mpls/.
> 
For the series,

Reviewed-by: Guillaume Nault <gnault@redhat.com>


