Return-Path: <netdev+bounces-199129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F5EADF1A9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3F37ADC19
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BCD18DB03;
	Wed, 18 Jun 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuEFOF+J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088628E7;
	Wed, 18 Jun 2025 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261582; cv=none; b=IwswSpJDPsOn2fnmHIgkDe87KZQuP75jqjCe+iNZaNRkwavC9KYcHLNBSo1Z61pmzawYxNrLDmQI5Ob9FA57tvVkorJQxuN9AqMKViNPGIhudOw/qLVuhWHjRJ8z0XjrSxSFKERBaNUAAY3qC07uWG8OpAjOQmkIkTch2tB9H58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261582; c=relaxed/simple;
	bh=RkhAhy7cJp7ZZXWeYy/4iE+8/T6IKGFMwCV6ga9hQfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi66Uw4W6XVNqzP/rvYNvXcYqMf0IxZ3O/GA7GVv3RPPaHATu/cDtnIdEBePjgxjwIxcbLOcruru0CYqOSXylY2QuHA0q4r1gcE1znCgJBqnoHszA4BCd8O+A5okwHdHoTmU/LHSdibFJQSPt/yiFH63rMOXQKrfS/WeM2kJ8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuEFOF+J; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742caef5896so5935362b3a.3;
        Wed, 18 Jun 2025 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750261580; x=1750866380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egqntrQT0mcTNXSQUXdoAiXmKkzBs77HbRV6QGmeUAk=;
        b=UuEFOF+JdyiAj3Nd86ECLudy3nFgZviRj9XMGM1HgtNHFgSSuIRZm44OY1ANjGlvbB
         Qv5i2mPINBbQQHAr2CMzd4v26XIjUnDp4SrIUmySMz7DO7fzEq1sF/i6oFfxZOhj56zA
         Bdgqe4C0c/sNX5SZuI+T97D/PFvJZcekWt37jIxPJqkaZv60khEK3sjJorfapBZG/gyI
         EqXtusq7O4EurM5ERY6GTTyA7+p3qYyrts8nRTkjLto1I4p6Ydn+nGcSf2ELVFn2QzkI
         Qr2XE/Sjk+pIHm2nDEcO1v6spMiytoFH7i5F6QZZggFcuRSc2kNOGfKzSoR5wFzdeHu5
         Ym7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750261580; x=1750866380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egqntrQT0mcTNXSQUXdoAiXmKkzBs77HbRV6QGmeUAk=;
        b=kwccK/DSq+6/9r5GePcwlB951hD+XeP+EisCDzXlKC4ZLoP6dyUIDqWya7CThRBPAs
         X9xhbHh1Tlc0tAvfRnZrgYe0ukxhnLu3+eVARzkwPAHZwIv6c9B0q1azeK0ABvDFQoIU
         nuaP3GsfYOnvkdL5IoygiKiRwFCYRjbC6Kv9cAkxKiRInZmTcyUWRibnj/nM0Bzb9wfE
         dfjo4kE8z8RV2njLjscCLu3ltMH9lzxHdi9tqVneV2LxbgwZJoZHUBdhYy0dtF4NFqOJ
         kGbUcJpYEAumFL2AjaGjxYB5rg5eqxev/kGzLs4eUXQuiMMlBKbc06+uOMqtRCE1XoR4
         aE0w==
X-Forwarded-Encrypted: i=1; AJvYcCVmkqAnpClrAH/4NKg3+1w1ePYclrjOA2ENWr+85KmHK2cMBiB0fjmfqHHwZihJfID6LJVd3zdU7kE=@vger.kernel.org, AJvYcCWnXKf4Ro1La0rxdfVg+7n+/ThnozhTTf5rfUIZEVHvICLSIZJJEBgnSB26/HNeZery9E8mzB48@vger.kernel.org
X-Gm-Message-State: AOJu0YwRByMoQSrfNWEnhwwFFKFsxOw1jgdpy9qbeIG1INjTzkASwXn6
	ODWUOGm+y1Lgy+rsrc81wRYZqgoK+ka8Q44OnNyYVINY0/kWwHZIutTW
X-Gm-Gg: ASbGncvM7ac1u9QRCjEeq2L1dalPE8zeENbgGmt7RpCEOtQECLSdTcy5zszdXcxsWwi
	QYQF8Wdpt61iKedRp0wtgFvt4/mzjwvbQBoDUn48paQe2bNKF2QBpYBk92mC1vhNeXlvCp+J7Kr
	tR5duHifQB4z9w1nWkyyvryEorJfFh5h1hC2Q1vTtIoxunecdLTDHQmBMEBqcTlALLuIb2SMk8B
	590pnyLkrn51RM2UfwCk15iXJFRDNBbAzctGajY66v4tSfiJCKvm8ZMoeg5vnZ7/W3dbrIaXQao
	UdlLzIKucz66PPjeWhDHa61ta2RXalGM9Ke3hNMIHakhioeePpjVE7J5oojP83Q22GBzGDmMqQ/
	hAA6DdfJ3xRh/RtFj4WhT/G0WTsVoOm8E
X-Google-Smtp-Source: AGHT+IGojw9TogQCLzzrFvTji884jdeSs6pD+joQuFZ1XOjZry8dO66lcKyVpPr1hvTndaJFUZbB5g==
X-Received: by 2002:a05:6a00:895:b0:73e:2dc5:a93c with SMTP id d2e1a72fcca58-7489cf9a3bbmr21984258b3a.11.1750261580264;
        Wed, 18 Jun 2025 08:46:20 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890082e71sm11574559b3a.107.2025.06.18.08.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 08:46:19 -0700 (PDT)
Message-ID: <17f2a9ce-85ac-414a-b872-fbcd30354473@gmail.com>
Date: Thu, 19 Jun 2025 00:46:15 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/15] Don't generate netlink .rst files inside
 $(srctree)
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco Elver
 <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jan Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Ruben Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, lkmm@lists.linux.dev,
 netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
 Breno Leitao <leitao@debian.org>, Randy Dunlap <rdunlap@infradead.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <cover.1750246291.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

On 2025/06/18 20:46, Mauro Carvalho Chehab wrote:
> As discussed at:
>    https://lore.kernel.org/all/20250610101331.62ba466f@foz.lan/
> 
> changeset f061c9f7d058 ("Documentation: Document each netlink family")
> added a logic which generates *.rst files inside $(srctree). This is bad
> when O=<BUILDDIR> is used.
> 
> A recent change renamed the yaml files used by Netlink, revealing a bad
> side effect: as "make cleandocs" don't clean the produced files and symbols
> appear duplicated for people that don't build the kernel from scratch.
> 
> This series adds an yaml parser extension and uses an index file with glob for
> *. We opted to write such extension in a way that no actual yaml conversion
> code is inside it. This makes it flexible enough to handle other types of yaml
> files in the future. The actual yaml conversion logic were placed at 
> netlink_yml_parser.py. 
> 
> As requested by YNL maintainers, this version has netlink_yml_parser.py
> inside tools/net/ynl/pyynl/ directory. I don't like mixing libraries with
> binaries, nor to have Python libraries spread all over the Kernel. IMO,
> the best is to put all of them on a common place (scripts/lib, python/lib,
> lib/python, ...) but, as this can be solved later, for now let's keep it this
> way.
> 
> ---
> 
> v6:
> - YNL doc parser is now at tools/net/ynl/pyynl/lib/doc_generator.py;
> - two patches got merged;
> - added instructions to test docs with Sphinx 3.4.3 (minimal supported
>   version);
> - minor fixes.

Quick tests against Sphinx 3.4.3 using container images based on
debian:bullseye and almalinux:9, both of which have 3.4.3 as their distro
packages, emits a *bunch* of warnings like the following:

/<srcdir>/Documentation/netlink/specs/conntrack.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
/<srcdir>/Documentation/netlink/specs/devlink.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
/<srcdir>/Documentation/netlink/specs/dpll.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
/<srcdir>/Documentation/netlink/specs/ethtool.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
/<srcdir>/Documentation/netlink/specs/fou.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
[...]

I suspect there should be a minimal required minimal version of PyYAML.

"pip freeze" based on almalinux:9 says:

    PyYAML==5.4.1

"pip freeze" based on debian:bullseye says:

    PyYAML==5.3.1

What is the minimal required version here?

And if users of those old distros need to manually upgrade PyYAML,
why don't you suggest them to upgrade Sphinx as well?

        Thanks, Akira

>
> v5:
> - some patch reorg;
> - netlink_yml_parser.py is now together with ynl tools;
> - minor fixes.
[...]


