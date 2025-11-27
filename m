Return-Path: <netdev+bounces-242159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A5DC8CCCA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 05:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC4BB3482E4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357572D4B6D;
	Thu, 27 Nov 2025 04:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd7meyas"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E91EE7DC
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764217468; cv=none; b=qy6KjAtXKb4DmhwdzFe/BERZBByJd+ccqwUPiNNKoCBMJ0sLcTY0veZGYWaPhAufx/gu6CRytReYGADH6uLArMs3sfLvSeV+MHIB5kg7G46V5AnUxEsuSyEWs5qIFmYJHVVe1GDqMPSqfRsMrPncCdMir94HLbXCo+R4XGik0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764217468; c=relaxed/simple;
	bh=6JIQEty6lN13sdRl+Un79jR18LBJHrgT4NTp+S4YQwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubQhDdgZfpGt3hsSNn53TEzwIXaKzQQlzGm0H5cIaFWxP2NuV+L/93kgQza9YLKTW0nh9Jh8lU5sGJ1BjhVBS+9YSwzS96yKk1tnUzVBNiZNdtwKyIWNt9XgRZWPq2BNMRBGFED+prQLQ3WnIXL06QtERRYkdgBK804VNg8Fb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd7meyas; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11b6bc976d6so1863526c88.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 20:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764217466; x=1764822266; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rej4Ct83G0kG0S/Iz4aPQq8QIk9WrnsG7dmZ0/8PSRs=;
        b=Bd7meyas8bhoeTRnXCoO5Bt7uqZfZFpS1HVJgNs3HXoU5SUNWs1uAP3WO+2XgAW+jG
         7k2AlVc8gGV0aAXcAvEs6V7+3JZbG2/f2udegos5Er8pOmrBOIwQc8ZKueBS4sFOWwYM
         0oBo39GPZAkr8mYc0/ocRwMACiPE69cL4dlqf4sOGpgdS/Km55yZfRWwz1wxgxQnKcQE
         iaJBscqFwfXi3XqILsdknGZ+whOhXNSCGlYrTsgL30tXhW6awj0oZ4Qvu4wloKZCrSKA
         DglzDq5208+1uWix3LsO3pdPcPieKKY5jK7NgP5hf1xuIHW9CjxR+FqTFKZ/BIaShkTy
         2Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764217466; x=1764822266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rej4Ct83G0kG0S/Iz4aPQq8QIk9WrnsG7dmZ0/8PSRs=;
        b=o0pV9Xcb48fHmd/MH2rPaegAB4x9U6p3aLTl1QVxC1K0fUWcbUcHQs+l8ZD522Tek9
         eB3sJOq3BsI1xQMR71lVE72ZKTZ8rfVXKyVykazjKf1ZV8G0ZO0XORX5pkYPwssf7QLs
         FtMo1oqlpHzmaBUQth/oU71qoyg45oNngmlAtrPIC1naKEYsj01fyQzY8PHADbwNxW5X
         3X/LFCWYhirpayoW3ywpDHK2zrhhHca7+GhMA6eXyLRsoM8W1Szi2uO/ruOLJ48zKJRe
         5mo2kpoSbwtPtq2LsQLKDAslzN+j8U+nc/ppPMdNg6zh3Osz224s+QuWH0qSAbsahohD
         cDgw==
X-Gm-Message-State: AOJu0Yw7QeUR/ByLL5ZXFjUrUbjcfqeNSzVmjVp4W1Kobnz7CNBqobxS
	B8AMe9Lfrv4vvT7Vwp+5Ll7ei2SSZiZ4BSvwhHoc3u05owld/7NaaQD6
X-Gm-Gg: ASbGncvVJqjelcozrwslobXdy82oeinO1kbfBIOJRlbZZBEJCdngX+3xSvJTH2fi8Ec
	FSL8OlanwdQsjlnl2Srb3PEdU0bpc6rp2soj510r8noBwHCP1g0gxA7AlQkhwAbtykGooV7nSzc
	+gRlfRoH3LwcAKIsiGczFpDSEedKL4umTgQX8ew5SKOzpcO+El+sTs3za+ltw0xnO/4ChZkblOL
	ntOlOwkMVaAZrfoIoJ3Ql5CyCqcebytkvO5L8hjW1WO2ATcrbFP05jvvdvIem4DAapSvJ6NlNv5
	rtBJsz/m2iT8PgGBIzQUUbA0viMvYEK3e8K6O+P5OIqfLkUe5HR6/uO99MJi5pbmE33vQie/RSh
	S8gICngLWCf55278KU6XGQrNeYD/DFZrbtXzQgU5VTRw2zRHq211LY6Yf2aE6T9zeXzqKICp+O6
	HJesj59zdW2ssnDTVl
X-Google-Smtp-Source: AGHT+IG7ZYTZ35/F2XwBGp6Cb1I1c/2nML2zX0doJAjCX+TU4+E4rnEBlloBELmXlhb3P7u2hGmh9g==
X-Received: by 2002:a05:7022:e25:b0:11a:515c:e891 with SMTP id a92af1059eb24-11c94a4db03mr15744586c88.0.1764217465650;
        Wed, 26 Nov 2025 20:24:25 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:91b6:79f3:c6c8:a62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm2165160c88.3.2025.11.26.20.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 20:24:24 -0800 (PST)
Date: Wed, 26 Nov 2025 20:24:24 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [ANN] netdev foundation TSC meeting notes - Nov 25th
Message-ID: <aSfSeHUtMuJt6uEV@pop-os.localdomain>
References: <20251126141700.25c097cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251126141700.25c097cb@kernel.org>

Hi Jakub,

On Wed, Nov 26, 2025 at 02:17:00PM -0800, Jakub Kicinski wrote:
> 
> LPC: should we have a “maintainer talk / Q&A”? 30min in the AM?
>  - Will hold before official start at 10am
>  - Paolo will “squash” schedule into remaining time
>

Yes, please. I will bring up the concern of knowingly breaking valid
use case of netem Qdisc recently:
https://lore.kernel.org/netdev/20251110123807.07ff5d89@phoenix/
https://lore.kernel.org/all/aG10rqwjX6elG1Gx@pop-os.localdomain/#t

Looking forward to talking to you in person at LPC.

Thanks!
Cong

