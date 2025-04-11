Return-Path: <netdev+bounces-181615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5A9A85B72
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C819B8C72B6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C5211472;
	Fri, 11 Apr 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2lkDOXj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50B203716
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370394; cv=none; b=jyPyskc8In99s1IHDU/OqKSPWFNHX3sLPQ9rsq6xAY4p3t8HN8q/dPBSBVkNnSAVZFeeDAuPujM27DfQ6FyZGHDk7ekCB0CYbm+JvOtYTnKyW3rRXNkFi/GiGDxIJ58Xjjrcl4DwTjMANezWAYyPYvqycDRifvT7Hay1BDB0Xvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370394; c=relaxed/simple;
	bh=0r0XdZLQZTKCfWrlvdr3kIJq4bXiXhg9OZrf3YuzUpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXWX6mtG/08xVEOjD5MzdqXGUZGlfXqxSxgzXIo64DmiCIRPgJU8vvloKhTHpmJLWEEKdqYTi4K+kvkWd72Oi8H8tLiNA+hEQK6Uxeyk5CkcP7hZ64q/NT1DUNN1pGYxa7cenLqin9pa28sMa5ouYm7B02iW1tD1XZipCkX16z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2lkDOXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744370391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzPWtVMosS8yz6213SvlQbIOghMt7zjrea3KyihzWNI=;
	b=a2lkDOXj0AFt4P9dE18K3g9OlS+7zq1JhtU6ZbWPHIPtcvHMNYxLn2bX7KzrfveOdL+NQp
	HaRZ6F6ftIXcWuBjW5y+Zti90jZXV5nmNq25EFamt/Z+JOvPIqZbHamo+3AerZMVdmt/nP
	IgmiRBZUERwz/1o1QxW0WNNkLA3+lYI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-afkO1osCNiOUWDbyswIf-A-1; Fri,
 11 Apr 2025 07:19:48 -0400
X-MC-Unique: afkO1osCNiOUWDbyswIf-A-1
X-Mimecast-MFC-AGG-ID: afkO1osCNiOUWDbyswIf-A_1744370386
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DC2F1800257;
	Fri, 11 Apr 2025 11:19:46 +0000 (UTC)
Received: from [10.45.225.124] (unknown [10.45.225.124])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68B621801A69;
	Fri, 11 Apr 2025 11:19:40 +0000 (UTC)
Message-ID: <b7e223bd-d43b-4cdd-9d48-4a1f80a482e8@redhat.com>
Date: Fri, 11 Apr 2025 13:19:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
 <CAHp75Ve4LO5rB3HLDV5XXMd4SihOQbPZBEZC8i1VY_Nz0E9tig@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAHp75Ve4LO5rB3HLDV5XXMd4SihOQbPZBEZC8i1VY_Nz0E9tig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 10. 04. 25 7:50 odp., Andy Shevchenko wrote:
> On Wed, Apr 9, 2025 at 5:43 PM Ivan Vecera <ivecera@redhat.com> wrote:
>>
>> Add register definitions for components versions and report them
>> during probe.
> 
> JFYI: disabling regmap lock (independently of having an additional one
> or not) is not recommended. With that you actually disable the useful
> debugging feature of regmap, your device will not be present in the
> (regmap) debugfs after that.
> 

I will follow Andrew's recommendation:

1st regmap for direct registers (pages 0-9) with config like:

regmap_config {
	...
	.lock = mutex_lock,
	.unlock = mutex_unlock,
	.lock_arg = &zl3073x_dev->lock
	...
};

2nd regmap for indirect registers (mailboxes) (pages 10-15) with 
disabled locking:

regmap_config {
	...
	.disable_lock = true,
	...
};

For direct registers the lock will be handled automatically by regmap 1.
For indirect registers the lock will be managed explicitly by the driver 
to ensure atomic access to mailbox.

The range for regmap 1: (registers 0x000-0x4FF)
regmap_range_cfg {
	.range_min = 0,
	.range_max = 10 * 128 - 1, /* 10 pages, 128 registers each */
	.selector_reg = 0x7f,      /* page selector at each page */
	.selector_shift = 0,       /* no shift in page selector */
	.selector_mask = GENMASK(3, 0),	/* 4 bits for page sel */
	.window_start = 0,         /* 128 regs from 0x00-0x7f */
	.window_len = 128,
};

The range for regmap 2: (registers 0x500-0x77F)
regmap_range_cfg {
	.range_min = 10 * 128,
	.range_max = 15 * 128 - 1, /* 5 pages, 128 registers each */
	.selector_reg = 0x7f,      /* page selector at each page */
	.selector_shift = 0,       /* no shift in page selector */
	.selector_mask = GENMASK(3, 0),	/* 4 bits for page sel */
	.window_start = 0,         /* 128 regs from 0x00-0x7f */
	.window_len = 128,
};

Is it now OK?

Thanks,
Ivan


