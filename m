Return-Path: <netdev+bounces-81234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F03886B5B
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0810B20ED2
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1389F3F8E2;
	Fri, 22 Mar 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TK3UIy5D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FA32C8B
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107344; cv=none; b=KVLDzG3lvjJpPdkljxAHsB9SEBEYOPdBR+1DEgr9g6e71gQTCCxQQ86T0Pn7zMoFkGeTZ/M5UOGY+Qe4BUguRyMyg+bRtQqlYcKDnwDUOK6OB2Y5UghtsVV+6Ca6Q9+CzW7Llk4t/ExRZHm3wqUGgYZC0CUPePM9yt6gxFK5/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107344; c=relaxed/simple;
	bh=L2tcD/ITaEi1f7z6Yx7tsCOvAl3WhFZ+ww67B9HVaCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAMNFeIhdLVWh6n5yGVk72xOeWehhR9d7R+j9Zw4LVxVowo4S4YFWfSKb+IJOS/5Zh/HCD0ns3zsK9dOhFIAtrVhkUW+b5mkbAZSXSEpO587cFAkCduwBUiCUqZz7zcCmAVznzvhAo+3oLswIhU1JyK0NinVSQZOQTcgAVB1av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TK3UIy5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711107341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zevwRV4TCMqnBUOvIEIlVBEfqDOkrU5pfeKQZoCSLfA=;
	b=TK3UIy5Dg01uVvrWnLIyWdETqTHSy4EDcrEvcSA+1IegTePstGoymD8cutvCs6FNDZ6cm7
	BXN2/Yb74X7HgV73Em93UV/51AjVmaTbCxmRK3x/l+UArg8VGSyxOc7GTI8Q1XcKK2vny/
	dKRNv5h3YvTikLDt4XLnHtOhBailPfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-LLxItXyUOrurRpgQxVTXRw-1; Fri, 22 Mar 2024 07:35:39 -0400
X-MC-Unique: LLxItXyUOrurRpgQxVTXRw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4140edcb197so12198715e9.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 04:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711107338; x=1711712138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zevwRV4TCMqnBUOvIEIlVBEfqDOkrU5pfeKQZoCSLfA=;
        b=LS4+/pItDAYm7K1jAzMrDsnVrVCaYTq38ZJ7/FbCFqKugQ9IOBODiLoNM603b7CJ5p
         wVx97MeJMjswq/laHw1rcpNgyI2e+eXxSO70F/w8QcEx7/4hB0hVcaNVosR2bwhvcZDr
         jyLPs/JQfLPzI/KmNACuey3YQyXeyPEtu6e1MTBuG7yLgd4Mb71AUQU5BRNVWG1HhD1V
         U9yVGH4ypQTbOz9b84xIL08wQ5DOHHw9U/o2zykT8r2oCB8OIJKVUDtgsnC1Dtdna6gf
         cudBxQsLj8JeWuEecEYVLyZ1IeLHxMfBB9yiexaY0c9AHWr75Us2WLb5iNSgToBHbGvI
         Ks2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfB1gPLIIV9q2ULA4vmWxHGs8t+gJizIcGKqedEJUt8V1DXSB/FPWLruhh4HvBDjfqweaDsriNf4e+vjIsfXGHlquqnFrM
X-Gm-Message-State: AOJu0YxKvDg/nT37MJxYgJhSGv0AWMsltBvQJcW0iuGOH+GCXlsOriYT
	e+J7fZUG2CiD1CM9IFdH9hQKABcO5HKJ7Rs6CYYFFbENU3VXdlngB9hoHfBYQJzjzxqB6SCiFmd
	l3QNnvC0yMDq9J2tUcnkfJbfsYoJKAFPENF1nACOhW2GB9sxst1Iobp6HKlykpkzXo+idFSIOyJ
	PARi3i9BqqlMh0FJE9xf0z+X5alanz
X-Received: by 2002:a05:600c:4f47:b0:414:a76:3d5e with SMTP id m7-20020a05600c4f4700b004140a763d5emr1522508wmq.28.1711107338570;
        Fri, 22 Mar 2024 04:35:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKkoIWoWtcH9SekIKpNtaHwKbcz3/H0cucmTNlHjaLi13hJ8nrNNRir/Dk7yurPgF54pFLkc9IiFMpfh+faQA=
X-Received: by 2002:a05:600c:4f47:b0:414:a76:3d5e with SMTP id
 m7-20020a05600c4f4700b004140a763d5emr1522498wmq.28.1711107338218; Fri, 22 Mar
 2024 04:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322105649.1798057-1-ppandit@redhat.com> <Zf1nSa1F8Nj1oAi9@nanopsycho>
In-Reply-To: <Zf1nSa1F8Nj1oAi9@nanopsycho>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 22 Mar 2024 17:05:21 +0530
Message-ID: <CAE8KmOx9-BgbOxV6-wDRz2XUasEzp2krqMPbVYYZbav+8dCtBw@mail.gmail.com>
Subject: Re: [PATCH] dpll: indent DPLL option type by a tab
To: jiri@resnulli.us
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, netdev@vger.kernel.org, 
	Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Thank you for a quick response.

On Fri, 22 Mar 2024 at 16:41, Jiri Pirko <jiri@resnulli.us> wrote:
> You should indicate the target tree:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr

* It is for the -net tree IIUC, not net-next.

> Also, please include "Fixes" tag.

* Last time they said not to include "Fixes" tag ->
https://lists.infradead.org/pipermail/linux-arm-kernel/2024-March/911714.html

Will send a revised patch. Thank you.
---
  - Prasad


