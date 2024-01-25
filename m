Return-Path: <netdev+bounces-65901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA38D83C458
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628671F2494C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27563120;
	Thu, 25 Jan 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg1gds1e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A7629F6
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191724; cv=none; b=EzFjHJ5o0d+tvBu6VgjmNX6ixOMzJMe1/E31ZEAmbS52/jenOzPhz39iIyo8F7CprU6nX6aecMUlDKA1W02yBCLp0rnbFz+zppsMDpDXyKuTlCX/kmrs6+NBWr1F7N7OEvmmKppIg2/3GHk77tiLPEfbrxRPySeQosGSkXnUjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191724; c=relaxed/simple;
	bh=16HvNLHzXwVcYlFkdmkYKIhrnLNn9efgJS6g6BVi8gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiX9TdKEPOdBXPL2MGO1qrdqMBmQu1d+LxRuIHtgJZmy9C1/b5xpSCe/9tHuSzG0115VSxhO+F//zA3IUFbwzZX9mh0lw0OFtZqAJepffJK3PigloQXskibtU3QeF5dZSFGzlss1Hapwkawf6TjbGsCk3PoxRMwZqhOCYZ/G4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg1gds1e; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55790581457so8979623a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706191721; x=1706796521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16HvNLHzXwVcYlFkdmkYKIhrnLNn9efgJS6g6BVi8gU=;
        b=Rg1gds1e0R+8G5wSt95ShAUwN4WvCxwEhbk5llDZlQGu0tDRnfndMLdPwXcI/HYlTN
         vc6SVEyMkzr1IUbFcZ2GpZIDgo6oYmMnJyek0acASP+sG5TEXqegqQ3QHWhGwfznsAjq
         C8fOYQtvgeq1kaTZ+pECYb/Uic0QlGlm2qTHOYzapCkXNeA7aIgZJ9XXymYRT34uAaiz
         0Q8oNT98zSFcSktzgi+xF4VV5qrydwNMALwFhFSsZodAZgNMzg1svK6hE0XNyAtxJTdW
         ObvQNj6LiAwi29r1bKBmkUN6ZHjGLJabeASUigCGZqE7NRs54W3rYOM4XUSXm/VBUoAi
         g+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191721; x=1706796521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16HvNLHzXwVcYlFkdmkYKIhrnLNn9efgJS6g6BVi8gU=;
        b=QEWLUajsSN7YFuvOVsW4zoYvy+9Gxpy8OWuM2Lw0R6kBrGaTgmH3WdkTYG8hXiyhNv
         whRjL6mF+BpFboTi8u4q/nvYkD/+7LGubz78fSRnye8/FzqHr6lpJjfxClPWv/Z3xFeo
         t/omXDVH3U5OqpVNylYxHFSfUDFO9gruJ4nevGKg2uDVXiR9bPuLWHJ8Kx60UVvkDmr6
         fRwt+X7FiDfHYs+F2pih8lTIrjH4NK6tUWiAu71FpeDZb/9iPlJ4/p4AtXsVC0RIkAka
         9NTQYWSIzcf7ieVHXbaFJw8931zB59bHjY9FugdWmsEjcsvx/kvjMSuIItsm47nSTg98
         a57g==
X-Gm-Message-State: AOJu0Yw0rHBBOjYpJOS3srFPUYax+0Tx5TdmqPaVnR35+GvQmtL1MZGj
	9C5tGiSnoTp39tb0c5FSiqg809ejEhiCBOJEnpGcl0Q8hksL5h3b
X-Google-Smtp-Source: AGHT+IHH3MEFv2SQh9mOXercM6VCsaPZVJg6ZRuidQQfc0ZeeaLo/YPU4tQBVxz6CCqsXPnXlOyCMw==
X-Received: by 2002:a05:6402:1:b0:55c:8d9f:997b with SMTP id d1-20020a056402000100b0055c8d9f997bmr729272edu.30.1706191720827;
        Thu, 25 Jan 2024 06:08:40 -0800 (PST)
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id s7-20020a056402014700b005593b14af3csm13818089edu.84.2024.01.25.06.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 06:08:40 -0800 (PST)
Message-ID: <82eb71c1-646c-49c7-8dac-4612a460b7eb@gmail.com>
Date: Thu, 25 Jan 2024 15:09:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Add support for encoding multi-attr to ynl
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, sdf@google.com, chuck.lever@oracle.com,
 lorenzo@kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <cover.1706112189.git.alessandromarcolini99@gmail.com>
 <20240124152520.4be53f65@kernel.org>
Content-Language: en-US
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <20240124152520.4be53f65@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 00:25, Jakub Kicinski wrote:
> On Wed, 24 Jan 2024 17:34:35 +0100 Alessandro Marcolini wrote:
>> This patchset depends on the work done by Donald Hunter:
>> https://lore.kernel.org/netdev/20240123160538.172-1-donald.hunter@gmail.com/T/#t
> You'll have to repost once Donald's changes are in, sorry :(
> Our build bots and CI do not know how to handle series with
> dependencies.

Ok, thanks for the update :)


