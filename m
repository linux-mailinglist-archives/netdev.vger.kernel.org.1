Return-Path: <netdev+bounces-197765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15531AD9D52
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352CC1899FAD
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B463D2D8799;
	Sat, 14 Jun 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8KVy+wB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2722F774;
	Sat, 14 Jun 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749910286; cv=none; b=LaqtnmcsumGxqQGd3BtdrtXL3yGq+D4b4nnKAZ4LRNY0hE7Pyymfu3c/c/tK84JTQyHHQOVRmGbwSkmJUGaL60L1CTdEV2REY6bEXEmBeNTaEhzrcsKtZ1ZMoXpC8SgsVQqf0v9bxXi6vsPplDYXobQk/JcO+mVsUIDV2DGlT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749910286; c=relaxed/simple;
	bh=POxwkq0O0GbjEOLATg9Cms4ibuGIWc/rbmDVdyXvrOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6vlC9Se6sOAw2anJNKTqG3iqueCBCe/DzU7NZIAaqvDgWbz/6GD8ACFAcUuG6tQ+ch2GG77bAoOuEs4tN8L/2bYHnwEmNB2TjbHWeMA4G1ffXCRSwrhuIKUQjI8XuSaGY+sVC8/pXxqkbJn3xv0AIi9FS62HZtjNLUlQPV2NlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8KVy+wB; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-610cbca60cdso2211518eaf.0;
        Sat, 14 Jun 2025 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749910284; x=1750515084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiB96bAhSJ6/e3F5OHXMtztFQ+Tpw8+eBOtaWFUgd08=;
        b=X8KVy+wBzSEkmRHrr1aq9eYs22hJGdfGV9lNXVhSOxofqvF7dOUhTxVlO54bAKIGc3
         6KkQGDFKoukXOsFjFvFHJXcfvxduPy6651mjZATfyBkm5Qo9OKk5wd1YMlScJZnPlaGR
         8xWkPqvMVAa+2dcRzkuAGZNzrvhe8alQofHy/AtEU4+5Kc6rbozqgesrox9bG0+kVkRK
         JgbZN7Fsq0Ue+HA8/wxdKPJCGxUS/j3l0YHIFg2HTO8QFMI+HVbmlTXqEg6f7MZdGsFw
         7/ijywAcGoZ6J3rqt9dHHAVEuRxfRf93dk3jDNiRxGKIM2i4PjJZNPbINr6Of5ToNlcD
         g8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749910284; x=1750515084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiB96bAhSJ6/e3F5OHXMtztFQ+Tpw8+eBOtaWFUgd08=;
        b=Jc/AjEppAtpDCa3ehj0GXU/qZ9t+3rTY8fxQT5Er8nom/O1XxjQIVt2qk/9FgfGwMs
         imrPc5SE5+9wpymdGyTWV5y/B+qGM4cdPBuRBCvInjpCLrXnPLSuOXtmzJSuQeRsP3fd
         /NeXtiHO9zPUsvrPZ8xKZFDexxgJHKlgg4C2fJh++zIRabLHvvZhpGcgLE5fw1r83aM7
         5EUAH3+rrDbzCHerRern1QOpX7mNE7wYEReFq/uKguvjin4T4dlCGygxA61CzpOoJpg/
         +PpBK9HNFIbzT0hluYOVFZx2lMOvF+6nHJFjZEuo4Bl1nYorCwSNvVT49yFYWui8sSIP
         ygcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDVzj7tGeVS/shEjCUSI01XzVlhRGcKl/JsPTN+xZSO5TSp4Dru2BZ1dUu0/07jtPDCtD8BPbk3vkoAQw=@vger.kernel.org, AJvYcCWFWjQKp+PTsLQDpX4N561ZxWSw2OFgI/fZInTqjsaoaPEhKvEyUb5X5a62ewBdhZz0bq1mIQDy@vger.kernel.org
X-Gm-Message-State: AOJu0YzOirqL+CgIUeKiXeJtQshQf2M5PkitXJ/oJG1k//JuPxi774y/
	uZHBwX/HWKW9lVy9ea8I9mUAdAZBGos7JmbH8SO4RKXUAJY2vi4Hwydt4bGwjGMip2xMt78Q6k1
	YJsa0CXrStHaE+bSCQg6VhZHBRJ4RjwU=
X-Gm-Gg: ASbGncu0KxNM2AspCDTnWVAk/C8zeFxsRCAH1ghKhadkgdU+R1JHRoO/xs6Zw9C0E0W
	iXS+PqmPR4F5sHc/4fc5gnTQhC3SbjVn3h1+NToMoYH0kFOi7NWc55qB6xNkERHc0oUKQrxKYXJ
	RS2yphUi1eBHsRA2XEB7JxLuRNf9P2puU9HtMmVPo2zw//QHGWdo+btgyciJ4fEPIrjFLGARJpW
	MXDPO8rqyZ3
X-Google-Smtp-Source: AGHT+IHL7vBY1W2DXQlT9x8BW0qpd0hTAvVSmZdjIqU45TpVWU75wLX2Cpkv4JMTdfmuBXHS0Fns4/kCOE/Hp9HqVZY=
X-Received: by 2002:a05:6871:4318:b0:2c2:260:d77b with SMTP id
 586e51a60fabf-2eaf07f4bfdmr2374938fac.5.1749910284303; Sat, 14 Jun 2025
 07:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749891128.git.mchehab+huawei@kernel.org> <9b22975b17bf42210f8432cf0832323c03b1c567.1749891128.git.mchehab+huawei@kernel.org>
In-Reply-To: <9b22975b17bf42210f8432cf0832323c03b1c567.1749891128.git.mchehab+huawei@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 14 Jun 2025 15:11:13 +0100
X-Gm-Features: AX0GCFsfuit4DJaOo6O24z_9KMPmudpwemZmcUivmVYluqb8vmkzFkeOZF2nLLs
Message-ID: <CAD4GDZxj0YXKdmZiWiLhn==Krg8_EjoUWjLn5Mz5Q=JHNC86_Q@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] scripts: lib: netlink_yml_parser.py: use classes
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Akira Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Ignacio Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, 
	Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Jun 2025 at 09:56, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> As we'll be importing netlink parser into a Sphinx extension,
> move all functions and global variables inside two classes:
>
> - RstFormatters, containing ReST formatter logic, which are
>   YAML independent;
> - NetlinkYamlParser: contains the actual parser classes. That's

Please update the commit description to match the code.

>   the only class that needs to be imported by the script or by
>   a Sphinx extension.
>
> With that, we won't pollute Sphinx namespace, avoiding any
> potential clashes.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

