Return-Path: <netdev+bounces-138234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7908F9ACAAA
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D271C20CA4
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DC01AB500;
	Wed, 23 Oct 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZwKgjnpG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E21459F6
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688498; cv=none; b=DSdjdFQUZabVc45ZeCvrcgW1OOdXlOm+beXlnMOGSjlhzVbrDf/jQiAmGu8ey3vX9RK/qpOOdSDpa5DCM8rvlegwF5y/JmRJcwfdZB59e7VRPsgWpSIWzobId4PlvVh9lz9aumam71SaAZJWS9UviU+URZvCMHxQ8mMZYog2Dsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688498; c=relaxed/simple;
	bh=nbmo5aGA7LT0Hgov1qAGwKoPu5C3RFLgaH6+HqPHBBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAwaFoCwamFZArg9QhkITZAo5GySka0aLD1JZGcHgccp946XAjvN7ITnyud/Mdrk5cdyZegJl34dpDpYFUAm/3BRptgVrfYVJQ7yXAyXDdWr7VpJyc3C5EYDPo29vC8npC4Pp5jh1rheDlDUFRL3ImYI5b+FF56oQyJ4J9JK8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZwKgjnpG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso982206566b.1
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729688495; x=1730293295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbmo5aGA7LT0Hgov1qAGwKoPu5C3RFLgaH6+HqPHBBY=;
        b=ZwKgjnpGbffcnVl712PAV41xilwX37reIo0QhMQDjvIgRY0rNjqgy7087dBpAIFgma
         O+R+W+xo2DIV2BrvIagxxx4hupqYp4qRW8P4mB1DxnZ3VjPMXca2oaV0X/eST0QKP7AF
         YZ0XevBOu2wTTN8iV/TjjMXlyMpaW6CuVvOmJ3jzsMII1XDqNah6xq5PndCMWQz9afx7
         b3+Ty30nISli+8AksENZCtG0I/T0O2Puhi+b52T9YPoe3VobrOmBDN2kHmrvimBLWfWZ
         t3ZADQxYl9RrwZ134vG5AdicsGZnRKb7M0DzSxsAJmLBZoLOEeUgixjzlK7hCP1Gj5Ob
         8X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729688495; x=1730293295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbmo5aGA7LT0Hgov1qAGwKoPu5C3RFLgaH6+HqPHBBY=;
        b=OTk24fp9VJUcXCTB+1O1mHc2Tf02cVruUP5Yv0nH8KLSpPn1/7M6CmGZyafJhyeyFl
         yegH1OjbNPXsn6iG5YgrUXqRrD0gi9OHc3yAUAk4yr1+7LO6kOdJXWimog0H5jybgc/G
         KLv+oQS8ROIhyEji+CSw9CinU+NxH6+yasicEfwjqlKBh8W0dGNhlgq9owqcyqCrBpZd
         Iksu9yo4hA/+j9rNbQ+jjz0I8tHmQwOxLCDg0DQKgyaXNnTp77J8Hb7aWuXtX3VXGss/
         fqbohe8nxYkXANAoBq+BtzGXCXwxik8k6J8CLeqjvrgVYffqOHVVx4MuU9ICfmz9Bwxl
         T3iw==
X-Forwarded-Encrypted: i=1; AJvYcCVOoIcfIBL0vXOO+01tf4aFzJsTcZ96A4gn4nvc/41P7BROAnUINDcbQOCMhJ9I2qQraEgfDfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuncKrESo80gd7nnjc02IgDqyOdoFLx19EYlshAhbxMQwC8pZP
	tWSDIMJhzDW5rDq441UD3Wu2HMNkjIWBM3qYquW/igQaXN1CvBVAjeJFy/XqIfV/zzTI8HqPbu1
	kic/cKO7dxLl1XF54n69p1ugGosBE9PXngk7i
X-Google-Smtp-Source: AGHT+IHT805g+LbGy0EqqXtuxcuYkq9Wu1QcCa4o398B7x0nju7lBTF/vbBIneUpiRF9UyUOqDWCaTIvci00Oy8nL28=
X-Received: by 2002:a17:907:2da6:b0:a99:42e7:21f with SMTP id
 a640c23a62f3a-a9abf8ab018mr221805366b.37.1729688494348; Wed, 23 Oct 2024
 06:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023123212.15908-1-laoar.shao@gmail.com>
In-Reply-To: <20241023123212.15908-1-laoar.shao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 15:01:20 +0200
Message-ID: <CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com>
Subject: Re: [PATCH] net: Add tcp_drop_reason tracepoint
To: Yafang Shao <laoar.shao@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> We previously hooked the tcp_drop_reason() function using BPF to monitor
> TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
> 11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
> To address this, it would be beneficial to introduce a dedicated tracepoi=
nt
> for monitoring.

This patch would require changes in user space tracers.
I am surprised no one came up with a noinline variant.

__bpf_kfunc is using

#define __bpf_kfunc __used __retain noinline

I would rather not have include/trace/events/tcp.h becoming the
biggest file in TCP stack...

