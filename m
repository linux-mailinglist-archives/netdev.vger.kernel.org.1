Return-Path: <netdev+bounces-68606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02718847600
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BD51F24253
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4B14A4D9;
	Fri,  2 Feb 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUuKhA8A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4AB14901A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894487; cv=none; b=mpuhAMJmj5GgQPpLnf4be6+w/wmoeZA8j9Skj2Wsy4aYfqLxZD8y75RcCsIh9y3uxGb43R8Dq2MfHMVU26twxcwmDH2+EJAdWkez4TU7k+TmtiFz351Skw8dbhAfmZhbk5tFbgvyWnHCgCNQy1fUefqlm7Afk3FQJ3+80qDIlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894487; c=relaxed/simple;
	bh=Le/4NfG5hTPFtMe7eEF2NdriE9OGwuhh2VcUJCCCgaM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s6o2s4zLe8m701j8jwUY6Moa6HgAU7l7psyueCH/TQc8kiPN4Q+ZJrByg3h8eH/ZJPzuODSmGn5SQJtPfEbv7ZZKQ9VigW+NjkfRYN+30F7Kz/VIXzVbk4HM264SQzxBu6MA56jnXTBoPoHXeAql3UftY92d4WmQj2wO7l5CzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUuKhA8A; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2223536a12.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706894485; x=1707499285; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3C0/shqJjGy/YPrgsS4f9rl07h4tCxk54JN6xxbCP4o=;
        b=GUuKhA8AR2cRoFv9a0tGUtCwfytptx6kkWPn6dHb/+rWmgBDaDzAUXkUqpcAlEJqHS
         nKxqgtcx43aCd/1tMDKiahfeRJpbU9z406vXqgZ7URUPhkXujEhd8KdPoY3UpKkvmcgU
         bV8Ou6K/5IMbK0S3JhRfxWivjbSVKK7Lzw03t/atm7s3dDBhnUnohkgrJN3OupQ2LzmQ
         OVfuiNqS1RnZSudckwlpD4Ct+AEtR5ngFPfok9O4hSdwjMeScMxw/4KcsZUK65oYxzIB
         FhC3w4w2maV1hHt//C7sjwjyOiyxDeK//NrlTBNRl9s2vTYIjhwm3/6pfFqGpABXufgS
         HYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894485; x=1707499285;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3C0/shqJjGy/YPrgsS4f9rl07h4tCxk54JN6xxbCP4o=;
        b=CiDzGRJw9Lz+d+VDsDf/eTQa6Cke9pB+4/n5uuHwJctWtS8XHYntiQvxYWjDJDHp2T
         F29MeZ5To4SWk0EOQkgt6iNgplKFLoNuoKRQCdOncQvkZVBBy3X+UmvxrWwRB2Exes3I
         okeInrXZZ4q+knUzb9dDJ+vFaUu8G+heJ8fMAGZzE0nXTATVIwj0PLFlxuHROLPPS6b0
         uRMSpEv/NwOFF5vfj0efibsqzxMZnVeq/+pWTTgcRLi4AmeY/D+Ql52F4mYQt0WMoSVh
         zD8zl+7lUZbWB2zM/fDHBEWvg8yQzdHTUbY5ZcjnQZsZ5SGSdsLv52lNhQyHd9b7PlSS
         dN8A==
X-Gm-Message-State: AOJu0Yzf/cS7msFF2aERKTGqzx3tst52V2rTLnDUvlxTDDAPbWZId3Ph
	gFW9SZ5Thijd8iDQExM7CO6BFzoEeL4/iHey/0eFkLrPMVT/Eq+Z+bZCkGOe
X-Google-Smtp-Source: AGHT+IHG631/2THi87nTZ5cYj9o57inEgI13a14XW/AQnBZ0L+ZpF/fWpDNdAO1TEBkyiP3f393qrQ==
X-Received: by 2002:a05:6a21:2c94:b0:19c:b3f9:2999 with SMTP id ua20-20020a056a212c9400b0019cb3f92999mr2233831pzb.27.1706894484726;
        Fri, 02 Feb 2024 09:21:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwLIuHrZN1AZaDzAztvfODjO/n3tJEro9L2KCyVPV/0JRh7k3/MGdGYsAZk7BQxMN9CL4ohjzgoBJldMWsQdRHhKLJLX+x
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a21-20020aa780d5000000b006ddc75edd55sm1866934pfn.152.2024.02.02.09.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:21:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 09:21:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Subject: Persistent problem with handshake unit tests
Message-ID: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

when running handshake kunit tests in qemu, I always get the following
failure.

    KTAP version 1
    # Subtest: Handshake API tests
    1..11
        KTAP version 1
        # Subtest: req_alloc API fuzzing
        ok 1 handshake_req_alloc NULL proto
        ok 2 handshake_req_alloc CLASS_NONE
        ok 3 handshake_req_alloc CLASS_MAX
        ok 4 handshake_req_alloc no callbacks
        ok 5 handshake_req_alloc no done callback
        ok 6 handshake_req_alloc excessive privsize
        ok 7 handshake_req_alloc all good
    # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
    ok 1 req_alloc API fuzzing
    ok 2 req_submit NULL req arg
    ok 3 req_submit NULL sock arg
    ok 4 req_submit NULL sock->file
    ok 5 req_lookup works
    ok 6 req_submit max pending
    ok 7 req_submit multiple
    ok 8 req_cancel before accept
    ok 9 req_cancel after accept
    ok 10 req_cancel after done
    # req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:478
    Expected handshake_req_destroy_test == req, but
        handshake_req_destroy_test == 00000000
        req == c5080280
    not ok 11 req_destroy works
# Handshake API tests: pass:10 fail:1 skip:0 total:11
# Totals: pass:16 fail:1 skip:0 total:17
not ok 31 Handshake API tests
############## destroy 0xc5080280
...

The line starting with "#######" is from added debug information.

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 16ed7bfd29e4..a2417c56fe15 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -434,6 +434,7 @@ static struct handshake_req *handshake_req_destroy_test;

 static void test_destroy_func(struct handshake_req *req)
 {
+       pr_info("############## destroy 0x%px\n", req);
        handshake_req_destroy_test = req;
 }

It appears that the destroy function works, but is delayed. Unfortunately,
I don't know enough about the network subsystem and/or the handshake
protocol to suggest a fix. I'd be happy to submit a fix if you let me know
how that should look like.

Thanks,
Guenter

