Return-Path: <netdev+bounces-189147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08578AB0A51
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 08:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934709E6895
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB4726A1AF;
	Fri,  9 May 2025 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eIu8tQKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891526A1AB
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771131; cv=none; b=fkOlooPDCI078+qmfy04pmvi1JO4QohGvrNtjQmhqiCDRyfYXCSLBT5htVmRuTz5UP3QPlM+dtrDr3zT9YTuXGqG8xHME14qug0xgufROh5mKe6pockdS/5DJgZZRllOaalCLbHlIL+RNeG2i54hKbH2oOMmNO+kxwucbpvRvTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771131; c=relaxed/simple;
	bh=SgmwctySlGbZE8Y7ECt5BO41p9Wa+WOMQmklCfcn83w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuBlgawPgebDo/w8jWx7YEfBqx1fG4iy/xdYnX/AqYYLYzCZa7Ctzuqh6z5ov25j22KS6IiToQr2rFfg4zrSYa8bqOIR+rPeLvdxULrRpr9v24W/QHO0v2ZVhDr+uP4etqAQ4NVinUt8/J1oPdOKPoNfRwUY9IG9+UVDRbI7Mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eIu8tQKQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb39c45b4eso263237166b.1
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746771128; x=1747375928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsqZgIgkSuMcTrxJQRDgcEGPZOgCfhwflJ33fpoq6jw=;
        b=eIu8tQKQDIDwxtYY3zuBoyq8Y7VVZ87Z+VNUmaQDOeEZGgt5M6Fd1ho8251/+t2Rmh
         Rj+iM8yioRdBwr1WNrWrCyo+skh4ZPt9FV7XnJdTJIBd8iB1Y1iiv2ghX4MGEZC+BiBF
         QvI/xLqHTc4q9rjkDK1WjbnSvRUGCwOXlKrEhCBhezYCHoijI+g2SRQ6hrTU2T3je1lm
         Ap/3CReNGXMzHi2f6CexEFsMYxnxHZWl+R4qGwOepXx3jcx5Bm09gt5ICoPmZwaJHqNE
         OXQs5xLgZAKjLoeLDbaK9mWZDx5krAAqIsq3ybhFErVOM0FU0M4oAg+W5FjYZ6tfKt1Q
         x94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746771128; x=1747375928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsqZgIgkSuMcTrxJQRDgcEGPZOgCfhwflJ33fpoq6jw=;
        b=XY/qcFuFCqcGYvxY96rMjozvNdfXDB6/k+8QkZxkLWRTWRZPm/RoRTDcri4flpVrG5
         G6rkrmSYrRCKo244jnXkdeoYxuIMNltYfP0IiL+1QShB4XKPz2gIvpg+tYbvV4LJUaMw
         xvxC7mAWPdBSCEx1gbXLaUc7x6jOsqyhQCu83dCrt0vhmXIVbPSBn2b2ISwbYKA1B8Bt
         THWBxcaSd+Wh0LZ6TXy4F9AtmvzWvPb0y+ByQfH7Tbk7PIdmRHNztcsDFtSju6TQn2GE
         8LVjIExVjtPvvrogIUbe/RkpKMdJ0d5rbKjfptmYBuIzX4cIifrsSJmr+MjuWmPf80wS
         idhg==
X-Forwarded-Encrypted: i=1; AJvYcCWXGq1BJs1fdP40br3mfEFc6YZ1Id/2KbI2Rc+EwQXdO02abV33qRATHiSNoNcqev8n4a+EUkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWQMlNdOXw4MLziAQALqnkuJIRE700J0lbG+IsSmUECny1oaV
	yeyfEoLNhjgsNF9jjBbVgIWagTI7N2X1dilELYWCQMWCF7f4NztWXQu1gN14MJw=
X-Gm-Gg: ASbGncsxSMhHhu0F9VRFEiMZCkMb1icUaYVIVgUg5Tp8jqd1BE8kOLVEzATdcIEHY0x
	5RDWEVTWd6I5+vTnkgLptpUGccUdzxByFP6GaXmhc4ve2ZmUr2oEKxlVYuRjrOtrOXMUG9biCW0
	iK0XnXWQFvBe3hMRQmB+ZoRA2E6esiAEei8N+xoyxx+wCQQrJjtA3yb26w7U/C4DeBvup/Xccm2
	UDgwQhNFEEfUgqPBe1BYkDpJfnSdXJWz97wxmXqcQXr8dEJY+2Y3Pt2PhST2wJ8hb8dq3R8KVif
	6jlN71SCudAQDQUCfZk1CLGAkzI3rBMw4OMMsLY+4ZOLQQ3g58sj//9VBPDjnCCIpeeKsHp0
X-Google-Smtp-Source: AGHT+IFwTIvZ/JDXp63lVD7yCHCYF/5x6H0kXJQDeAXO5fUwzIWcY8Yr2zXT/J8iEsgfDbopaGw9rw==
X-Received: by 2002:a17:906:bf46:b0:ac7:ec31:deb0 with SMTP id a640c23a62f3a-ad218e91c5fmr193282666b.9.1746771127738;
        Thu, 08 May 2025 23:12:07 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197c5b9csm98887566b.159.2025.05.08.23.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 23:12:07 -0700 (PDT)
Date: Fri, 9 May 2025 08:11:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>, 
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>, 
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "richardcochran@gmail.com" <richardcochran@gmail.com>, 
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Olech, Milena" <milena.olech@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/3] dpll: add phase-offset-monitor feature
 to netlink spec
Message-ID: <zosr5eqz5sh2z5uqxghdko2fug2zlzr6dbwbmavesiysabvvgj@zr6pxggacpwg>
References: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
 <20250508122128.1216231-2-arkadiusz.kubalewski@intel.com>
 <timzeiuivkgvdzmyafp752acgfkieuqhivcab55x24ow7apovp@4lsq6esrrusg>
 <SJ2PR11MB845211DED1A8ECD92116E0019B8BA@SJ2PR11MB8452.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR11MB845211DED1A8ECD92116E0019B8BA@SJ2PR11MB8452.namprd11.prod.outlook.com>

Thu, May 08, 2025 at 05:29:07PM +0200, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Thursday, May 8, 2025 4:26 PM
>>
>>Thu, May 08, 2025 at 02:21:26PM +0200, arkadiusz.kubalewski@intel.com
>>wrote:
>>>Add enum dpll_feature_state for control over features.
>>>
>>>Add dpll device level attribute:
>>>DPLL_A_PHASE_OFFSET_MONITOR - to allow control over a phase offset monitor
>>>feature. Attribute is present and shall return current state of a feature
>>>(enum dpll_feature_state), if the device driver provides such capability,
>>>otherwie attribute shall not be present.
>>>
>>>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>Reviewed-by: Milena Olech <milena.olech@intel.com>
>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>---
>>>v3:
>>>- replace feature flags and capabilities with per feature attribute
>>>  approach,
>>>- add dpll documentation for phase-offset-monitor feature.
>>>---
>>> Documentation/driver-api/dpll.rst     | 16 ++++++++++++++++
>>> Documentation/netlink/specs/dpll.yaml | 24 ++++++++++++++++++++++++
>>> drivers/dpll/dpll_nl.c                |  5 +++--
>>> include/uapi/linux/dpll.h             | 12 ++++++++++++
>>> 4 files changed, 55 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-
>>>api/dpll.rst
>>>index e6855cd37e85..04efb425b411 100644
>>>--- a/Documentation/driver-api/dpll.rst
>>>+++ b/Documentation/driver-api/dpll.rst
>>>@@ -214,6 +214,22 @@ offset values are fractional with 3-digit decimal
>>>places and shell be
>>> divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
>>> modulo divided to get fractional part.
>>>
>>>+Phase offset monitor
>>>+====================
>>>+
>>>+Phase offset measurement is typically performed against the current
>>>active
>>>+source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
>>>+the capability to monitor phase offsets across all available inputs.
>>>+The attribute and current feature state shall be included in the response
>>>+message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL
>>devices.
>>>+In such cases, users can also control the feature using the
>>>+``DPLL_CMD_DEVICE_SET`` command by setting the ``enum
>>>dpll_feature_state``
>>>+values for the attribute.
>>>+
>>>+  =============================== ========================
>>>+  ``DPLL_A_PHASE_OFFSET_MONITOR`` attr state of a feature
>>>+  =============================== ========================
>>>+
>>> Embedded SYNC
>>> =============
>>>
>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>b/Documentation/netlink/specs/dpll.yaml
>>>index 8feefeae5376..e9774678b3f3 100644
>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>@@ -240,6 +240,20 @@ definitions:
>>>       integer part of a measured phase offset value.
>>>       Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
>>>       fractional part of a measured phase offset value.
>>>+  -
>>>+    type: enum
>>>+    name: feature-state
>>>+    doc: |
>>>+      Allow control (enable/disable) and status checking over features.
>>>+    entries:
>>>+      -
>>>+        name: disable
>>>+        doc: |
>>>+          feature shall be disabled
>>>+      -
>>>+        name: enable
>>>+        doc: |
>>>+          feature shall be enabled
>>
>>Is it necessary to introduce an enum for simple bool?
>>I mean, we used to handle this by U8 attr with 0/1 value. Idk what's the
>>usual way carry boolean values to do this these days, but enum looks
>>like overkill.
>>
>
>Well, yeah.. tricky.. There is no bool type in the attribute types?
>Input/output pin direction or eec/pps dpll types are also 2-value-enums
>we use same way..
>
>Had to use something as it is better then plain 0/1, also those values
>could be reused for any other feature.

Okay, I don't mind.

>
>Thank you!
>Arkadiusz
> 
>[...]

