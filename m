Return-Path: <netdev+bounces-114822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D923E94452E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD25283381
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 07:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671831581E9;
	Thu,  1 Aug 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HIzUN4PQ"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1318E0E;
	Thu,  1 Aug 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496217; cv=none; b=Hx5d5yEsl38qggpG9EnNsVz6mJvXsHEnI6Cm6+PlJ3q50X0P740JHL5dfKqzcxAxlQ7y763IyFDWFy+aWOPooJNtD5WYFIvd1QcS38MkSpZcG/jG8zVFSGs5m9JIgMQV11vJ4jLC9CPInBXa1HO9tIaPhktQwWkXG9c7vekix0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496217; c=relaxed/simple;
	bh=EqByN6qCkhiy9eydAEw/kNfM2HmA0wKFkMpmPQzBOHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OhKjP/tq4Y8YcCkkPfc39p0tJzv6Wb3UxqFhipflPWDfnZ4vUfWSPh5Lgxv6tjeKWNldc9SJKKsraXDEr5coFIzZVniIkhBOqwPMovRw5o1xntvBvEuzzg7Tn3InAoeUtjlM6fnzBwLSiVDA0tjWbTWxKCnzpvDJlfeM9aVF02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HIzUN4PQ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47179vav054261;
	Thu, 1 Aug 2024 02:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722496197;
	bh=E4vu66DMs+gbUx27j2GWJkHnjdcHGXqRKM7N6f2Q11U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HIzUN4PQk2j8hYzjU4HsZ8cqPS8XuVUVuiVJul9D5ZZyg3NOq2egIFyRticrlwTmD
	 0jw583PNDRLyz4THZdYTQ3fYmee8sowP7iCXfndVZJvzFBvn86x6nBDvtvFt0CjgeX
	 XnveNL2RWQH1zEEQc+piPjMEd6A7peQZ+dq2eX4Q=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47179vwm044138
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 02:09:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 02:09:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 02:09:56 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47179qCl061988;
	Thu, 1 Aug 2024 02:09:53 -0500
Message-ID: <bcf0cbee-a001-4922-b0d5-c2f88b8c9724@ti.com>
Date: Thu, 1 Aug 2024 12:39:51 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Use of_property_read_bool()
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Madalin Bucur
	<madalin.bucur@nxp.com>,
        Sean Anderson <sean.anderson@seco.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar
	<danishanwar@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>,
        Michal Simek <michal.simek@amd.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240731191601.1714639-2-robh@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20240731191601.1714639-2-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/1/2024 12:46 AM, Rob Herring (Arm) wrote:
> Use of_property_read_bool() to read boolean properties rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Md Danish Anwar

