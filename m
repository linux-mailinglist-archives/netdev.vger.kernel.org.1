Return-Path: <netdev+bounces-104719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDB690E1B2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 04:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F02C1C21067
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791333086;
	Wed, 19 Jun 2024 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CsRz3pJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3EA38
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765196; cv=none; b=ilDTe8jEkVLen3zWBs7eb8J91hRn4Ra1fJu3+ValNM5HnTO/E4VWGblT7nsgmrjs7Hez2n+esjeWwg/iCdcWdnDkMFG8wxFOh4VhwtIYgQYpWvAGombYuth3/gwlXVMHMnzlYxr/+RRaZz2auMIpsepK2usEgV1Xx+vMtdxEuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765196; c=relaxed/simple;
	bh=iMqmSwwJKEk86rH/nKD7XdDRMQTkghhI6+HKIoELBsA=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BfeDLicUs9uCxtbY7wy0kXH3G2BrHtI7fBKBr6sOyOR4u1mGDI8yQemEon8OXqFlv71+mC2SCJPzlIWEBCXDURlOwuZwJIwIN9CSNlIqy+Iy0zQIa7wyEt389tPLt3x0PMS2/v2wXZyQ+d3cXCiii/P7lSTDiru+sToK6F+MLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CsRz3pJ3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44051a577easo32567811cf.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718765194; x=1719369994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOFT5Zwvyu19iw955jyfAWgJsnYFPO3amcmBRSozpvA=;
        b=CsRz3pJ3xImIhQoOfhfXxvaAbTsb5CB1oAVavUivdwMQujI3cHbTBkpZXrbjSA9APW
         H3VNpx4754fWzm7P7nTaMcb+VshSGnqhYHgd2fxDJQybidmXvKTq2ljE523Bzruvv1gE
         S3kCV+n5jMPUUZN6onwqp18ijyy1KsCtoJdHjNmOojYFN+ajsKFB9DK9IAs6E6KOcIMM
         wJOE70uvWgctcsUSVYv6R0U4Swahr7K1usroRKS2nRP3ooDvfmko9T0ff7kjo1lhNmEq
         BXgYW41ORlsWonAuW9nDkIvBCXDeemjsfjNt/Jq+i04KfwFVgHhw/UfVNmIhzIVwX3vM
         ngrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718765194; x=1719369994;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOFT5Zwvyu19iw955jyfAWgJsnYFPO3amcmBRSozpvA=;
        b=j4MdRzqC6nsoB8Vnr9K/IOAAMCP66bJO3qv0FKbs1uuBwtjVo6QfBuB3CTZJ6d/1ts
         fMZzZ6cxMEz9erqwgUl/5Urmog4nxza4I8AB1DUXGe9ihWnrxz18m4Z3avtMRL5KHhh9
         kWe5i0O+C3CIDiu2Pv4DhpgMo6csoVackLjYAJ+W3vYeZgRp5lPmFH4Z5Zaf0HPFecyJ
         8eQYcSDXtV68VfHCJ1h8M096v3DtxI8ZJ4F7lIwP6awiErIBe7XkqegrrqsSovQHzfwl
         CG9jOGOMtoWw5cl1nkrPlWjwMrp9tX6Al4oyxLysdmB4EgmAIXf4cdhjkMqfS40s1peN
         5hdw==
X-Gm-Message-State: AOJu0YzHQefUoXMq3G/fFk//sHqRkVIYbRVBvKYjK4WvR6mzLCWgHEgz
	hFCWru5r+4GY/PmM9l5H5slobVX3BTe5BAUxqSmPlkYrQjQg/GDbcHvTRQYNIQ==
X-Google-Smtp-Source: AGHT+IE2jwk6bvRRgostpbMkXKHwU5guw8GnpUTmXKlOvUwiGuAXFmUKOq0lMVNtnsIJnkTJzMtKhA==
X-Received: by 2002:a05:622a:85:b0:43f:9ff5:1d6d with SMTP id d75a77b69052e-444a7a5694amr18154061cf.46.1718765194291;
        Tue, 18 Jun 2024 19:46:34 -0700 (PDT)
Received: from [192.168.7.16] ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441fc0deb1dsm61102671cf.50.2024.06.18.19.46.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2024 19:46:33 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <patchwork-bot+netdevbpf@kernel.org>
Date: Tue, 18 Jun 2024 22:46:33 -0400
Message-ID: <1902e638728.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com>
References: <20240607160753.1787105-1-omosnace@redhat.com>
 <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
 <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com>
User-Agent: AquaMail/1.51.3 (build: 105103473)
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 14, 2024 11:08:41 AM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jun 14, 2024 at 3:20 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>
>> Hello:
>>
>> This series was applied to netdev/net.git (main)
>> by David S. Miller <davem@davemloft.net>:
>
> Welp, that was premature based on the testing requests in the other
> thread, but what's done is done.
>
> Ondrej, please accelerate the testing if possible as this patchset now
> in the netdev tree and it would be good to know if it need a fix or
> reverting before the next merge window.

Ondrej, can you confirm that you are currently working on testing this 
patchset as requested?

--
paul-moore.com



