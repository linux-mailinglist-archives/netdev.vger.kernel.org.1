Return-Path: <netdev+bounces-112972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145093C107
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3EA1F212D0
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F31991A8;
	Thu, 25 Jul 2024 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5HlzDoD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13716D4C3
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907747; cv=none; b=XtLAnS33BEKw05rz7c/zWzEF+mtZjopaRPOlV8kB3u9oJd0Gnh+707wXVvptAw61phMB4xDdWwu8qYHB9B9EyqrQ36mryG5QFg01YcOA2daZ3IVJ6YUOjrCKOjCiHDY3FtdQDO8Piak54CpMbnucmq/5ao2XzGs3oFgtoUwsIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907747; c=relaxed/simple;
	bh=do3MClTrFLkEOaUJtGQ6PkvAMhyApIKZmBi7frB38iE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZvAE6zZJHMghPgPxCtRWKDGoBUHjyamEHnmCVtuTucavqH7TUFywRST8LwTvbuuf8jynE4Un8bPAGSPEE8SZSQhsoAcgw8IXEiQLlyPoGEF6fVDL+UpD8wtzhDVz8i9QbGW3kkRcW3eojLOdk5Vb/eSgNJH9wEArf/PwphTxA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5HlzDoD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721907744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7dagFSZOLUUvaFqUleUBFj9zRZOZBodVzNBd/VdwrM=;
	b=D5HlzDoDaC/V/ioy3cxTiB3vE7RMvZZtEuY0j7Cb9gCieJLZ5138QtYE1Estpfwde/VvF1
	jD7BNu9B9JTuA4NZoxb++fjr4H3+lAPY0xCZbjbumYhTWdcxdVzLlCRWY+V6T5L45Ghcn5
	ADBfCgmXT6cw0+jdAb1y0ixI8qGAxo4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-3sMtm0U9OmmrmMWQy2PzsA-1; Thu, 25 Jul 2024 07:42:23 -0400
X-MC-Unique: 3sMtm0U9OmmrmMWQy2PzsA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4267378f538so1509405e9.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 04:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721907741; x=1722512541;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7dagFSZOLUUvaFqUleUBFj9zRZOZBodVzNBd/VdwrM=;
        b=hde1zinJQfU67uVp0P7b4K+uOA5o85QNVJ9hnoscvi6kJSW0WLsVVV/PU9kKMbtNkF
         QU9vtXW4HfrQGJQlAUA2aUY+30AZNOoGF3SQ928S4d/xAR17HLX3sfoSEt/IyKIFUzAk
         Af869jg6x+5rGYGIVWtBD598cOuDuWSlZsU1Y7gdt2CLFvnC+q+NxF9XiXdST74Kmhmg
         qgqMkN7gqwqCGI7F1KnbPIfjDM9q7FXyQZCORNfBDwI7g6KqVHSOMCyiRnGVWGl8so99
         j949a1ccttjBR3Vmo6j8RkBIKcQRFjHOI/4/9D/ANseIGFyxpsY4Wke/9bLp8V2Khp4t
         M8ow==
X-Gm-Message-State: AOJu0YwsxnfRxWzEmOB2wekMeqG0zuSvxQiwPkYdQSNAEhruWPP26Sy7
	nEzZemtXwb4Lu78P03Dzv9rU+lNnV/vggGGyt/Xg1UA8Ve7xD90BlD38AH8qYRLIJQYvYd9pVEF
	ZjovOJSQpUjahCUjnArRmKID8FI07CJ5n+t2XkhvrMCwJJq98qAtI7ev9/DweAiZlLmesalp4lT
	wcWLXV+EkZCMIpXfe6R+tUC50Ml3pWvDEAOAE=
X-Received: by 2002:a05:600c:3ba8:b0:426:4920:2846 with SMTP id 5b1f17b1804b1-428054f12e2mr8876795e9.3.1721907740982;
        Thu, 25 Jul 2024 04:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUwr/5r9k2e3uO3VgmmiceFmA4gUw2tH91OKsQ3B+d918WYcuYWMpveP9Vu2u1np5fxc+k/g==
X-Received: by 2002:a05:600c:3ba8:b0:426:4920:2846 with SMTP id 5b1f17b1804b1-428054f12e2mr8876595e9.3.1721907740500;
        Thu, 25 Jul 2024 04:42:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573eb03sm31388235e9.12.2024.07.25.04.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 04:42:19 -0700 (PDT)
Message-ID: <f5c5f6bb-58ae-4d59-8edb-66fc587e3ff8@redhat.com>
Date: Thu, 25 Jul 2024 13:42:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/11] netlink: spec: add shaper YAML spec
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1721851988.git.pabeni@redhat.com>
 <d84e3a8db21f13268c999074b01ee10d61bceb9d.1721851988.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <d84e3a8db21f13268c999074b01ee10d61bceb9d.1721851988.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 22:24, Paolo Abeni wrote:
> Define the user-space visible interface to query, configure and delete
> network shapers via yaml definition.
> 
> Add dummy implementations for the relevant NL callbacks.
> 
> set() and delete() operations touch a single shaper creating/updating or
> deleting it.
> The group() operation creates a shaper's group, nesting multiple input
> shapers under the specified output shaper.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> RFC v1 -> RFC v2:
>   - u64 -> uint
>   - net_shapers -> net-shapers
>   - documented all the attributes
>   - dropped [ admin-perm ] for get() op
>   - group op
>   - set/delete touch a single shaper

FWIW, the CI told me I forgot entirely about the generated user-space 
code, and the naming here is not supported by the current tooling. I'll 
send something alike the following when net-next re-open.
---
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 51529fabd517..717530bc9c52 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2668,13 +2668,15 @@ def main():
          cw.p('#define ' + hdr_prot)
          cw.nl()

+    hdr_file=os.path.basename(args.out_file[:-2]) + ".h"
+
      if args.mode == 'kernel':
          cw.p('#include <net/netlink.h>')
          cw.p('#include <net/genetlink.h>')
          cw.nl()
          if not args.header:
              if args.out_file:
-                cw.p(f'#include 
"{os.path.basename(args.out_file[:-2])}.h"')
+                cw.p(f'#include "{hdr_file}"')
              cw.nl()
          headers = ['uapi/' + parsed.uapi_header]
          headers += parsed.kernel_family.get('headers', [])
@@ -2686,7 +2688,7 @@ def main():
              if family_contains_bitfield32(parsed):
                  cw.p('#include <linux/netlink.h>')
          else:
-            cw.p(f'#include "{parsed.name}-user.h"')
+            cw.p(f'#include "{hdr_file}"')
              cw.p('#include "ynl.h"')
          headers = [parsed.uapi_header]
      for definition in parsed['definitions']:



