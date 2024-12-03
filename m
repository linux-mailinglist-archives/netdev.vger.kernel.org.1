Return-Path: <netdev+bounces-148596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C69E2B81
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC801B2779F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2501F8AD8;
	Tue,  3 Dec 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFulI6l3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF821F756E;
	Tue,  3 Dec 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244772; cv=none; b=kewhMoHAbaAvAHMsB22zT6/R4glVtC7vMSk9CkcpwuBiEN6tZZ9d1/KJs1fH2paFlZUGIKdpY7fCJq9/2W8bRsN+hqIhirB6r9ojEfV30PnD8XVjHFEKY2OfT2FyOq4bThkS71cLRkFOjvTJ0vZwfTbHTyN8Jq+wfLANSWXTbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244772; c=relaxed/simple;
	bh=KMoQysWKuRuCQztw6raSWjQ+IF192GVyXNDygjqp45k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+GoT6bf9o4CMO/L9tsVhjspA3Qv2owd/0vsqqHnMowTF1FGBjDqJXBQ3XicAEbQCC4PVJGQbNj35r9Wliynqb2hjSd3cHfkVmzJmPbwsl5NpmnLwQQdDN81lFZ5R4p4D497Pl01fYU1gKM3PqbycIUfpjixESTgRSi+VVrIe+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFulI6l3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso3891813b3a.0;
        Tue, 03 Dec 2024 08:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733244770; x=1733849570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zV785WNUhq1gA/Wn6AqbiBGMdzVMW4esqYjkrkDGUc4=;
        b=ZFulI6l37pigAxh596FkMuqk2PWpI2k0IcBXyUjWlR89R2CvKhUBqIohai99ElL75U
         wIiwu0kd7ao+R6SKIpj/pgPI6bsvjllQF/negBmXWoNx223rWl0fAAZdPloLKGZp/Z+W
         EUlg5iS4h19gHKE4uaKi5gvgbDBKlXWITWl/lK6mcsZ8x6cCurAXZWwQsz9nW5nfq4DZ
         1qtfnZ7DOSxCKp2q1ipAg20552VsBjxAGtaAf5oTxIlQe2B3iGXfNX/wSWPum+pJXpJt
         OZtKQCObfHKj+Tj6tSLWxq8h3U8ZodIsN0yvACPE5Fbk0mlB7HPJ4fne9lwJbyCdR+rn
         jJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733244770; x=1733849570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV785WNUhq1gA/Wn6AqbiBGMdzVMW4esqYjkrkDGUc4=;
        b=cMO79I640XH39qdVeQEl5+xtnywfOjQiMNLNB2qQfdCyCpMdDlQXPjZ+t6GxQPysnL
         tx5mqwJ69BO1uxaKXEVEkHcmMNCydTziWu+n8r4xrNr4lSPMczbhLN4fR9NtagUodKeT
         Lf6xOtzWEGEe0OwXDMu/SyuWfGIIfI5WrIG7M6uZhOVVgNAx7tdG1RIwAED0enA4EdXb
         L+0wG93QuvwUQzOlWd8AR0lBGzzMwpE1+/xn2ReOvZvBrr/9OnJz+NnY4irsxClt35zM
         d/cCs93jbRZwegLTs6viRPDx2y1H2NVTSBTDamtIlhFtlHv0Qjb8rAKDduFZqGsHF6cN
         TrBA==
X-Forwarded-Encrypted: i=1; AJvYcCUystuy9RZ5HzAzhg4sVnYCxzXBOMO0SL4l2NC5AbB4D0N0a5iJ3wic1W3tcnD0i2vuo8CNfA2mc6XXaeA=@vger.kernel.org, AJvYcCXEH6ltGqXpSDyR2frZYTfBO9TMoNDUjdBEeXVw3B+uWp9G7YJ0XuKoBF3l0GQeu95E9HXImjDD@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWN2xy5nEW55n/WGLfOeT6bEW59WA2p6frStPuTugyD34Fe1X
	d8DDR/fNJDB3/+8n/5OV4cFTyLXQyexdp6q1Lbo2//sDI/j1igQ=
X-Gm-Gg: ASbGncuYQPgTY6B+Ho86s4L585sf6fPLroHKexeJPKzxEQWQ75cwnJ+6B9orKTq6Vel
	PfvilxF5d5XP1sodb1JOk/fVIhf3t109PZsXcTOlmQL8pJoKWu2geSWLGbIDwPWFhvisRqSpW7x
	eQ3RO3XEOPWHupfnaYkXOx1Q6uhcY7l8wUErNvQhDTURDKa87DKVMb2w181FIO9p1GVD3uSFpkD
	kl1JSx+f/Qgujc8T4E2jaZ5zxx3NX4FCvRKNtfJe4KHQB5aww==
X-Google-Smtp-Source: AGHT+IGuAh/HD5NoVevDHBywonmxKblpUpfCSIwU15PIfQGiZ/NQeI+/BOrCPWeRdL/ZNbgaf2qL/g==
X-Received: by 2002:a05:6a00:3bd2:b0:725:4518:9906 with SMTP id d2e1a72fcca58-7254518992dmr27567479b3a.8.1733244770237;
        Tue, 03 Dec 2024 08:52:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541813aeasm10994775b3a.140.2024.12.03.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:52:49 -0800 (PST)
Date: Tue, 3 Dec 2024 08:52:49 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tools: ynl: move python code to separate
 sub-directory
Message-ID: <Z083YZoAQEn9zrjM@mini-arch>
References: <cover.1733216767.git.jstancek@redhat.com>
 <20b2bdfe94fed5b9694e22c79c79858502f5e014.1733216767.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20b2bdfe94fed5b9694e22c79c79858502f5e014.1733216767.git.jstancek@redhat.com>

On 12/03, Jan Stancek wrote:
> Move python code to a separate directory so it can be
> packaged as a python module.

There is a bunch of selftests that depend on this location:

make -C tools/testing/selftests TARGETS="drivers/net" TEST_PROGS=ping.py TTEST_GEN_PROGS="" run_tests
make: Entering directory '/home/virtme/testing-18/tools/testing/selftests'
make[1]: Entering directory '/home/virtme/testing-18/tools/testing/selftests/drivers/net'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/virtme/testing-18/tools/testing/selftests/drivers/net'
make[1]: Entering directory '/home/virtme/testing-18/tools/testing/selftests/drivers/net'
TAP version 13
1..1
# overriding timeout to 90
# selftests: drivers/net: ping.py
# Traceback (most recent call last):
#   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./ping.py", line 4, in <module>
#     from lib.py import ksft_run, ksft_exit
#   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/lib/py/__init__.py", line 10, in <module>
#     from net.lib.py import *
#   File "/home/virtme/testing-18/tools/testing/selftests/net/lib/py/__init__.py", line 8, in <module>
#     from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
#   File "/home/virtme/testing-18/tools/testing/selftests/net/lib/py/ynl.py", line 23, in <module>
#     from net.ynl.lib import YnlFamily, NlError
# ImportError: cannot import name 'YnlFamily' from 'net.ynl.lib' (unknown location)
not ok 1 selftests: drivers/net: ping.py # exit=1
make[1]: Leaving directory '/home/virtme/testing-18/tools/testing/selftests/drivers/net'
make: Leaving directory '/home/virtme/testing-18/tools/testing/selftests'
xx__-> echo $?
0
xx__-> echo scan > /sys/kernel/debug/kmemleak && cat /sys/kernel/debug/kmemleak
xx__-> 

---
pw-bot: cr

