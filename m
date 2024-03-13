Return-Path: <netdev+bounces-79635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07D87A50B
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C57D1F21D4C
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2826921109;
	Wed, 13 Mar 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="E1iU/Dpt"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909820310;
	Wed, 13 Mar 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322340; cv=none; b=iw7zNx+vCK+8uO6syOQh9XjRptLlcRXrCyZZK/fDh0iC+SdOqa22hsS0TwcUsGm3oK1s8aWvRX4RVF4GSuEoUAF+aJ43drCsMHkA4kft6/BanqiZ3twhYudB6XuTh+3gFEJjmz8z9TgBLtNJxUt2iYXvfz2xi2GU2IrXNWyEquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322340; c=relaxed/simple;
	bh=pxsfn3X2dv+wtb5iB0DZ5emW7Z/c7eqDlhbff7fHigU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0t7saRofx/RybzeML2etr1JA5V3TFpgEXb0OIIAK/HTl89V+p45jiElvrmhtGYDNtVx0vKaTKxJAe3ctNJZrimWLXZCRxc3pW+hIycM0wz0kW8OgEQ3eyzMG6flkRAsFogqCoDdYlooTpIw/j5h7zkhAGG8liyxZpNtfeegjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=E1iU/Dpt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 45408419F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1710322332; bh=cZgbTV9MycaK7GrJx4QpCuYOzknIjCJFxtdFc2sEWdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=E1iU/DptPhdDKkqr17ammTNbqZkLssVAJ5PAQI2ZVxaveb/QtXQxkdQlYAv8B+G4l
	 gcI7dzATP8FriMHsNZYnuMfWY5lOz5bmv4bC1Nhfn7zaGqNC1vh6bHN9pNLGtza28G
	 oSjcgAuzxAjICwHqGLWONjG0I4W4+WIIDPKKr5v3rE+LHD4zCU5nBg+nY9FZKH+o4W
	 ipwqGwLVD6/zJtU4CwGGEephr2lsuUKkuQwPOKm43W/nk7Q5o4ps6Yx0AbPZo0S73W
	 MF3lh10TJTjp3NT5iVjN/AIPN+yCXGlZufOEnQlSoH5h1bHL8MlflvC0ZBPBeG9Yvv
	 CmrRQozklsZ8Q==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 45408419F5;
	Wed, 13 Mar 2024 09:32:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, Stephen
 Rothwell <sfr@canb.auug.org.au>, przemyslaw.kitszel@intel.com,
 tariqt@nvidia.com, saeedm@nvidia.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: networking: fix indentation errors in
 multi-pf-netdev
In-Reply-To: <85582a98-6579-84f3-cd93-c769cf1043f9@huawei.com>
References: <20240313032329.3919036-1-kuba@kernel.org>
 <85582a98-6579-84f3-cd93-c769cf1043f9@huawei.com>
Date: Wed, 13 Mar 2024 03:32:04 -0600
Message-ID: <87r0geeauj.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2024/3/13 11:23, Jakub Kicinski wrote:
>
> ...
>
>>  
>> -Here you can clearly observe our channels distribution policy:
>> +Here you can clearly observe our channels distribution policy::
>
> If the double ':' above is intended?

That is RST markup indicating a literal block, so yes, it is intended.

jon

