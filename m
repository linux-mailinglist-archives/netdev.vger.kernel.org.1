Return-Path: <netdev+bounces-278959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jf7MaKX4GlMkAAAu9opvQ
	(envelope-from <netdev+bounces-278959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:02:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F040B466
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7ED030D76C8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849638AC9D;
	Thu, 16 Apr 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2E4FVla";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZN6sfC1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CF353EDF
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326500; cv=none; b=fwavVfPDypT7YX4E3QHxVfqVuzCTEZJFF2lbBCFNhZkR57SM75SItGaYcPBR7qppViJHdR/unwHRS60upYXEu33FDTEx8GwbW7OEblvsMnw8Q4PYP/u9ZTJzqNpt+qCz1BvNJDjIhsXut9GaRjGLPH9pJk90ZkTiIxIui3miFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326500; c=relaxed/simple;
	bh=5yvnpLTxHCKJVtz8CQefSzlZnNjWR14hwtHDqTEvQUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/wZ7e48uEEoa84GUc1ghNtGvXNhgE3ez3LE92e2BoFSNwnyFj8bFRHMRtJuLWq9rl9jy8n4qIsDhBfanTl+lCmG94HXT9U/qLqsF43TlFohdHmQ285cESIBGvFeR7PZG2SeoWGfLB5IhfUb/w3YGhDAELW3pyi4PcaMxvpKsgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2E4FVla; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZN6sfC1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776326497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9O/Vxwir5fKfF5VwzqgOOmsR7+bDzw+TUfOwKU+jYcM=;
	b=Q2E4FVla+MR3ubGlYQec72KIKlGriJ6zspltrsW4JPO7MYyIb/2jsMVXNvsu1nC4f2crKR
	eTk5+lhiHHRzf1oe4g0WOjlOJoRHGxs2T+3YurImjYlpuPOUudIW4camogcOZrdUVT2mcu
	4uM15454k4p6DV6Gq7NYYpihfC2xVQU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-p-KSgL7XOISRTTC9-rXqXQ-1; Thu, 16 Apr 2026 04:01:35 -0400
X-MC-Unique: p-KSgL7XOISRTTC9-rXqXQ-1
X-Mimecast-MFC-AGG-ID: p-KSgL7XOISRTTC9-rXqXQ_1776326495
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so3244515e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776326494; x=1776931294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9O/Vxwir5fKfF5VwzqgOOmsR7+bDzw+TUfOwKU+jYcM=;
        b=DZN6sfC1QKa2tkLfVht4kzy3YPBQdzlOLs2F13ErO3KFIIqZQhBsrA4s6uR0/FCip+
         6Dz1XPEI+9eWpXDZ63K1GvTPhrcS0puK1NYguiSMrfqQQNAY/1HxQW9ldBSSjsdBpvB0
         f1v9F4OxwZ92BkgboV+YAVPjEGKAr94VYgsZZaCFeJTjCvGYCHbiWTZv61FhpKrFdLuY
         dzqk8UXd3Ku8N7bNozJosc++w558CzZTzPcofxN2x7yqDd3MsPC2DwWlq3rfwAtRMztX
         cgkphJsIQ7ESBRGqyZUTeT0PTsFBbeUzMBc8qe+kSFGT8BMgAfp92T2sGcUh3HNoFoED
         0S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776326494; x=1776931294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9O/Vxwir5fKfF5VwzqgOOmsR7+bDzw+TUfOwKU+jYcM=;
        b=AWi6ZdA0djrSm6bG27lYWEWon0yLlaghkXNxJm0ecPSTaSzg5UXx97q+fRnCSNOWPz
         tOfEw25fCC8BZ7/+g+CDK9FBXEnBsQXI/7ag1QbWEq9PMLsfmVTaENgOuLwwiFmzdTm9
         0vZcoq/+liNJtL+kcXGnd/b9+QQN+s4jgoETd0UreQD+LiQSJ+vKqSRAOXJv/8LEvWjH
         HK1hYYkD5qvzJqG5m6u7RSmSmN51VmXQ6lPcvJQP+iCqW+L5OPmqrVNKHG7J0gCQw4LQ
         dl5WuuWL3/xGsVwzgjKotxrKRTC2a7YzE7d2H7uqTDcUGjLoVq1x1guKOfnjlV/Sxzx0
         q3dw==
X-Forwarded-Encrypted: i=1; AFNElJ+F8D+FP5Yw4QDiHTuHCF71LAzfmLzvQSExkKUL7zCCxKmbT1cwO+9q5olKEO1ZgaVIyEpsOEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CfmT0AOHSf9iWKVOjZueAN/L7buFWnOv7u/jfmX+CBzcvD9r
	HrZORwmV54CACNtz1DOl1xbFN3WItp/NX+DYOWx+Qr/BFsvdOemBkgOjKzVXxE1b0N820WXvlc4
	Ud6mBjjQ6UVbMP90q1Ae3dXMabHDSx7rNsxJ3Gpl5/1tZxZJXI9YgR70Yig==
X-Gm-Gg: AeBDietEleECnw2p/trc7VY7DR2diyKx+geyI2Pt1seCCrvz2bFZjo7Dq3KVaw1ZePs
	Ru1UOky+fKn2L0Cq5lO21xfEZ9dkkagBuWk+gxJ12Eevg8ilStTzN6m3nV5yyEWCf4/UqAc+pF7
	N3sWeqZlganMd9KxkgAWFGk4OMiPsWin6ssv/Dd/xkOp8X7v+VYhO81eEpDrWnudzkj/lB/ov/P
	mFSzeAuImghDrufY+D1Zl1GemHcDDU4RMhrPF+gcSVxJ7w2YVtQezkhzxBiGxSBAsGWbt2ZsOox
	XPYSez4aBO3lMCp+dZd3aYF0NC7rlDFcQQTq/rNQBIEMZvqg0aFJ71skr+Yqss+9MRh6Zw60RB1
	uioQcCLKciJR18/z/zY6/UZj3Q8IDo6AivpH7qXUrVln6b3G032D9EMd+K91fD1jMhqs=
X-Received: by 2002:a05:600c:a40e:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-488f480c2c5mr28631285e9.11.1776326494310;
        Thu, 16 Apr 2026 01:01:34 -0700 (PDT)
X-Received: by 2002:a05:600c:a40e:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-488f480c2c5mr28630685e9.11.1776326493617;
        Thu, 16 Apr 2026 01:01:33 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813970sm32612855e9.1.2026.04.16.01.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 01:01:33 -0700 (PDT)
Message-ID: <4bce5b04-1871-4e2a-8030-11d674b6b299@redhat.com>
Date: Thu, 16 Apr 2026 10:01:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 00/11] nbl driver for Nebulamatrix NICs
To: "illusion.wang" <illusion.wang@nebula-matrix.com>, netdev@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>
References: <20260415033608.2438-1-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260415033608.2438-1-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278959-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[2.ai:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:query timed out];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[2.ai:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Queue-Id: 643F040B466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 10:29 AM, illusion.wang wrote:
> This patch series represents the first phase. We plan to integrate it in
> two phases: the first phase covers mailbox and chip configuration,
> while the second phase involves net dev configuration.
> Together, they will provide basic PF-based Ethernet port transmission and
> reception capabilities.
> 
> After that, we will consider other features, such as ethtool support,
> flow management, adminq messaging, VF support, debugfs support, etc.
> 
> changes v11->v12
> Link to v10:https://lore.kernel.org/netdev/20260408093739.56001-1-illusion.wang@nebula-matrix.com/
> AI review issues
> changes v10->v11
> Link to v10:https://lore.kernel.org/netdev/20260401022318.28550-1-illusion.wang@nebula-matrix.com/
> 1.Issues found by Mohsin
> 2.AI review issues
> changes v9->v10
> Link to v9:https://lore.kernel.org/netdev/20260325040048.2313-1-illusion.wang@nebula-matrix.com/
> 1.Issues found by Jakub
> 2.AI review issue
> changes v8->v9
> Link to v8:https://lore.kernel.org/netdev/20260317034533.5600-1-illusion.wang@nebula-matrix.com/
> 1.Issues found by Jakub
> 2.AI review issue
> Changes v7→v8
> Link to v7:https://lore.kernel.org/netdev/20260310120959.22015-1-illusion.wang@nebula-matrix.com/
> 1.Issues found by Paolo
> Changes v6->v7
> Link to v6:https://lore.kernel.org/netdev/20260306033451.5196-1-illusion.wang@nebula-matrix.com/
> 1.Issue found by Jakub
> 2.AI review issue
> Changes v5->v6
> Link to V5:https://lore.kernel.org/netdev/20260226073840.3222-1-illusion.wang@nebula-matrix.com/
> 1.put all standard linux includes files the .c file which needs it & others
> --Andrew
> 2.AI review issue
> Changes v4->v5
> Link to V4:https://lore.kernel.org/netdev/20260206021608.85381-1-illusion.wang@nebula-matrix.com/
> 1.change nbl_core to nbl & change ** pointers to *pointers & others
> --Andrew
> 2.AI review issue
> Changes v3->v4
> Link to v3: https://lore.kernel.org/netdev/20260123011804.31263-1-illusion.wang@nebula-matrix.com
> 1.cut down to part of a mini driver(mailbox and chip init)
> --Jakub Kicinski Simon Horman(some sort of staged approached)
> 2.modify issues found by ai.
> 3. Reverse Christmas tree/nbl_err/devm_kfree/remove some macros/
> void type to real type/others
> --Andrew Lunn
> 4.change deprecated pci_enable_msix_range to pci_alloc_irq_vectors
> 5.delete service layer
> 6.the style of kconfig---Randy Dunlap
> 7.add to Documentation/networking/device_drivers/ethernet/index.rst
> --Simon Horman
> Changes v2 →v3
> Link to v2: https://lore.kernel.org/netdev/20260109100146.63569-1-illusion.wang@nebula-matrix.com/
> 1.cut down to a mini driver:
>     delete vf support
>     use promisc mode to cut down flow management
>     drop patch15 in v2
>     delete adminq msg
>     delete abnormal handling
>     delete some unimportant interfaces
> 2.modify issues found by ai review
> Changes v1->v2
> Link to v1: https://lore.kernel.org/netdev/20251223035113.31122-1-illusion.wang@nebula-matrix.com/
> 1.Format Issues and Compilation Issues
> - Paolo Abeni
> 2.add sysfs patch and drop coexisting patch
> - Andrew Lunn
> 3.delete some unimportant ndo operations
> 4.add machine generated headers patch
> 5.Modify the issues found in patch1-2 and apply the same fixes to other
> patches
> 6.modify issues found by nipa

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for
v7.1, and therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 26th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


