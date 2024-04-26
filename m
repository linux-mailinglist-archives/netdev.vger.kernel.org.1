Return-Path: <netdev+bounces-91581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39348B31CF
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98AA1F215DE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD313C8ED;
	Fri, 26 Apr 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FNChLKxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6A42A99
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118363; cv=none; b=N9nxk8U1EbyG7UcC2KX1WvULhEewj5EmsPmO/H5UCdLrfyWJalT7t88Rwpvu7An1jXLLnBYQbA5NOZZRBX5zOOZh1iwT9URZHCX8c+cszCfxhEmpoMb1I/64lPmsQ1H7o66eK/pt7GPGgivXt6d/4iKi8RbwletVL7jULQ6L+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118363; c=relaxed/simple;
	bh=/Hf+z5bGSV3auzQJaDv8YV65hvUswn87e+gPGsPKFVo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XM8ZztPRFcgczMkg+OIA8MwNnFdDhhdTkkaWZzLIilwAExTp7CGkn53FmcbCv6IiQmBWs/6rFiDak9Tnnx1NZ1urS5sAIhAHzI70lt9oCi55ZEP8YQxrbeUDX5U8ez5px3zfYNanmvNI02vL37C27Qi3TD623Nf2OBl9xubkVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FNChLKxs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572347c2ba8so2019724a12.3
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1714118360; x=1714723160; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Hf+z5bGSV3auzQJaDv8YV65hvUswn87e+gPGsPKFVo=;
        b=FNChLKxsLrxcxG1zso6bFzLiotFK21dXaNg32uGMou9sbFFCMzvi5fxi0hUAAhj0nn
         nvhikPzRm/J0xvBzSQ+QNX+EIW16aPbZowlYzaKEhxR/aK3P738RhA+c8/Av1uEMbv3R
         z8TawFBum2XiOhLIMPa+5lrT2HQfnzF0jc6F5x1oFmhRbsV4XSB5VRYpCDn0evOTJ5zN
         qaQFHuuqfknmWP6eS/G1+qZn78JrNmHPx9CB5f77sAa2u7gy0v/fMrUPcgtTIHsE77JF
         QvtPR5uN/PslCYYkALI4u9gMsdAzUxchsF1HUxJfZSkh2cvD8EQNd98FngcsAkdTBMNI
         DzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714118360; x=1714723160;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Hf+z5bGSV3auzQJaDv8YV65hvUswn87e+gPGsPKFVo=;
        b=F/xn7hOcu9X5P6bYJdPENGIRxpXs/vYwY+1Gc8rLDz9VPA0IEIHKDgqMN2dAH+glhA
         RELIa8kNn63D9Mq/PaYHiGl4RJUxtCRb8VumNvS8WK1HNKx6Vv+iJ8X8KJd3rkRz3ZP7
         iSKBjV0ClvBfCAdqGYyyVTybJIA8N+1J+k41LZ6FbBmUjfv9Z7um2S4xGWC9gGZddPYa
         kdBEWfwUSfS/TIp7mLrZ6tUr/Ucm/pwzv+Ay7NBBbXCFjh5qzO2sx4KjTVOvFXNpsSfo
         NHF0SnBoAU38nLhxYOL5MH9MOCdJKdxHBtErehdBIPBAMujX24PmU7wHFagzT+iI6s3R
         ylVw==
X-Gm-Message-State: AOJu0YxZZzq0eVviV6eTB6iG9hBujaiyhtfUs/7sYWvZPsLS6D9v+BpI
	kQxznfpOBKcT6bw3pJlNWY0IeNApUt5cIBpGRet21WIHC8tQNlVCB11RJrAT7OZQI3IGm2NEu6X
	JuwlLtqFw0xJGwrx0FlT7D5z1bdzklnoi
X-Google-Smtp-Source: AGHT+IGkuaYEgDctb2X/dgBP4QaVbdkDkcwFOWuqePWm7c9tVCkWuvwkmYAYjdQXtTCFj2g6TkAAz4Hl1QQvAxEr95I=
X-Received: by 2002:a50:d516:0:b0:56b:9ef8:f630 with SMTP id
 u22-20020a50d516000000b0056b9ef8f630mr1131171edi.2.1714118359773; Fri, 26 Apr
 2024 00:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hrvoje Horvat <hrvoje.horvat1@googlemail.com>
Date: Fri, 26 Apr 2024 09:59:08 +0200
Message-ID: <CAAWgWPGGHGLV6-PkmwHut-Crbpursj_QSKDd89tVGYQZr3K2yg@mail.gmail.com>
Subject: nstat man page expansion
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear.

Oftenly i am using nstat command (and netstat as well), and it takes
some time to find all the counters explanations time after time.


Proposal
My proposal is to add a detailed explanation of the counters in nstat
command (in man page).
All of the counters are numbered and basically explained here:
https://www.kernel.org/doc/Documentation/networking/snmp_counter.rst

So my question is: is it possible to include those counters
(name+short info) from the above file to the man page of nstat
command?

Explanation
It is a problem when the official man page of the command that
collects and displays many network statistics does not explain any of
them.
For example it take me an minimum hour or so to find at least some
kind of list of statistics (which was mostly not correct), and
additional time to find out that most of the important statistics are
well documented here:
https://www.kernel.org/doc/Documentation/networking/snmp_counter.rst
<-- this document is released at 21-Jan-2024.

So from my point of view (and my colleagues) it is not so important to
have every statistic documented, but some or most of them.
In the above "snmp_counter.rst" file there are around 109 important
counters named and shortly explained.
For me it is good enough to understand and troubleshoot the network issues.

So please involve at least those counters in the man page.
And after time (from my point of view years is fine), the new one may
be added (some time after the "snmp_counter.rst" update is done).


Please consider this as a proposal from "the field of work".


BR,
Hrvoje Horvat.

