Return-Path: <netdev+bounces-197664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9FEAD9887
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026C21BC014A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AFD28ECE3;
	Fri, 13 Jun 2025 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="sXXpAIoK";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="CIHc7w4u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFF28DEE7
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856510; cv=none; b=A66+O/vTL6u/TH1LZN0ZPCd9CL9kqaEkR/OCcLOrVVbqEqJlv/0YcMPt5CKz0ETxU8xshhq42Gx0FS4WmrVFrsCeQX9UfV/K8sGI++eGc15Ff/pAkSpvktk7c4T/XpW0HoV4sX+NrSnxMM1uCL0kL4pMcMf7Mp1jdPthU+S0dag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856510; c=relaxed/simple;
	bh=XdeKZw2oyx+udjG0u5VMVGBoEZZgoahp8VunSNYP/sI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ptJ5PpEP+Sj8bDuBCkcCRu0MEZYEi8N21qbdyb0vHHf+paRljhajdfmtZUuliurJHwt94pfvR7Yp3lIjkPS+D1Iq/2kfCQyH1WmZFWx+v+8DpmZ9kolEcEk8pLD+p2mHWr5LLMt1r8WbrWm1HphUeChms1K9Ju6NCKVZknIn4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=sXXpAIoK; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=CIHc7w4u; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 55DN9HDu032470;
	Sat, 14 Jun 2025 01:09:22 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 4423B120589;
	Sat, 14 Jun 2025 01:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1749856153; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4+m4M05fZkVqQtddxtgrxNL+KHxs9OakD2mRu3imX4=;
	b=sXXpAIoKJIeuuMx5Kk0zvsaJEqU1FOi39LeyVR/hW4LCjaJ/nna+2xpUjV3IagjtegfUSC
	6U75Ns9eRbA7BGDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1749856153; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4+m4M05fZkVqQtddxtgrxNL+KHxs9OakD2mRu3imX4=;
	b=CIHc7w4ug4oirI7twRCMXlIOKg7cpQLQifSaVry2j6rR932w4JLWHkKb5d28uw80Al+u+c
	pzI+kBgcDBC5mqC00pKrDNZSoDrznJCf6XYmp8aCvweUabRHqusHfZoQEbybPsIPZ2liBu
	zXnPRcJgKQDqrjrS5MjlhpFujiNf1Tbd63+LrKTBV41ZqE04nsvKu1YrdDT/mz/wHZGf8J
	YrtwBhnCmWe6nxc0PFzX1sG3PLJNiYZp06PoFMpXjEQ7zxcejVfhJ9i7m7Dpyy56lu59b4
	+8OePHVeiYvASh8+W8xEuTBMsuRBsnPEU3M9W1o1Mu8Rt+9hX5nz6rptCCiQAA==
Date: Sat, 14 Jun 2025 01:09:12 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <edumazet@google.com>, <dsahern@kernel.org>,
        <horms@kernel.org>, <petrm@nvidia.com>,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it
Subject: Re: [PATCH net-next 2/4] seg6: Call seg6_lookup_any_nexthop() from
 End.X behavior
Message-Id: <20250614010912.efc93a4607de8d284fd4f0af@uniroma2.it>
In-Reply-To: <20250612122323.584113-3-idosch@nvidia.com>
References: <20250612122323.584113-1-idosch@nvidia.com>
	<20250612122323.584113-3-idosch@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 12 Jun 2025 15:23:21 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

> seg6_lookup_nexthop() is a wrapper around seg6_lookup_any_nexthop().
> Change End.X behavior to invoke seg6_lookup_any_nexthop() directly so
> that we would not need to expose the new output interface argument
> outside of the seg6local module.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/seg6_local.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
 
Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

