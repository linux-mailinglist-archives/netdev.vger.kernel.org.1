Return-Path: <netdev+bounces-201894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FAAEB5EC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00883BDD9D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9262DD5F5;
	Fri, 27 Jun 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEI97BOK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B42DBF65;
	Fri, 27 Jun 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022306; cv=none; b=ApuS4t0GWhzWnjJTcd3VakdHxXDe8NxzXyCn1wXxSRDB8piqfuOvohRyE5xQorypEG4HSeChcqVfFETklE+nZn6t0TQ59TIYX9fFyyci2TNzEoMRpdGXU0WfZoVu7j1tYpW1+16otC4xjsj8fHQLp+YHELaO81j9bWttKPGqjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022306; c=relaxed/simple;
	bh=B06vqLsvetg1jFxGBYXyf+6nQe601dcV30vu83BMpw4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qlCekw3K81aslsH+3mY5IZXgFLnZ2HLPjvQFW9VQaPQ+uAa79KHe915gsVCcIKz+nf3AJd6a+6iFWBs0/CHBR70vIRfBDiLbrejyj/nMXN0dBEjGIYOlp5hJnuu3G6gwzuBIbNb3HZo6ZM+QgtVaP+IRc1HzO008cuRxWrJmHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEI97BOK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537deebb01so10696165e9.0;
        Fri, 27 Jun 2025 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751022303; x=1751627103; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B06vqLsvetg1jFxGBYXyf+6nQe601dcV30vu83BMpw4=;
        b=TEI97BOKbaCHNyc8Q68TFIgi0Yh0TDvgdHvtyVszvVDZysangSrhIif0icgg8FrHSz
         ozPDkSJopuhwZjSVaOVeW8os3v0xW6m+wfCMss9uq0xjV2lAEqu59qsSac6KRdUm11yV
         Vo+TpdjebXz7/Pd7EmXlp3lJklcZTiPs5yqMECYuJaBb12Gu4WedxXsqddVt+VLhcsAO
         L8jcF12Pr4M79Dh9ZOgrCD6BuMZVyO5XJhiknVew3Pqb1MmPIbtCmpsUpUk0gd/dBi1r
         i8nCrfDld16wtHd87v0IaFv0WUSChZWjzc5X1VwUmpcMiV2X30G7FZORK2Jf8ydbDt+z
         Wr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022303; x=1751627103;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B06vqLsvetg1jFxGBYXyf+6nQe601dcV30vu83BMpw4=;
        b=H8cB03UGprc5nmEXvO6th11U5twIwGUEsedTgx+whOptMYUSRla4IsTbQKWAHfmXtB
         nTrPYFU0WEkk+EEWblAM6OpitCveYJuEUrUOFrT9hCoFEt/Oc9QyLxPZnggFGZSKNSsf
         7S6waGcBkgNT8xBmUZO7/uz0cEv6j0tWqvj2X4S6csW4lF4j+B60bkeW77AgYFz1YWyb
         3mrtCA5+gAlcB9ckI0QNHcoW0yvJsHOK6+BSmEq7EBKia47K8aYXFOmN+ihg0NN6HUpN
         +V4AQR9sOrN3WUcIk/9OkvypYgwQihAAdWlM08XM2syWD8e71PXT0/kPBICCuj8+R9ZX
         x/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Y59V1Z6PT183VamKk9V5Cqxqg2C3CzgVm0UFceSyLMOzsg9nE9hpkPezbMsej9nMfSaFM6dulK1ixK0=@vger.kernel.org, AJvYcCXGJNAF0De8bUXRMtKbFsyoqsrRJ+qSbLgo/Hc6hFR/AmGluM543q7f5sydSFCrYUsSKgpKd2xm@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+gxpx9P/N8ifU4JysFUGsPfMaEIq8V9TGoJa4WVDoh520eLs
	jVa1KM7lgJ5CjJs2cp05RcaiUq3j4NWwfmiJql9BYboY+S9A382g6gn4
X-Gm-Gg: ASbGncul3YmQKG81Ane71cLCJ+TyufmCzXWZJrcVqrEXDHDDkFk7qTEcKZQ21I3dS2E
	ufYIyZXp96Uxxn7omu7dhY0QBGo6iLA7SONb+J0zLjROj5akWovWREukxYkJaWXWKaMVztA3Une
	BszhOG/goF4PPmSQwBr2+Zm/Appa6sm1uFe6GtVH0mCleTbgwVZpK3xhDDg4TUz0sTQqeRgih4e
	OlQJgkMnU8dWoFikPn4bFmuWV4g/pVbMhZ+QzYYOcqeyEiWi0eul76mLK22OxgY8xNUaNDZheK2
	uuMF0a923CiSR/IfQCX2E3N0BUKNI27FXDnN/+wsBLnO1cAO/pQixY5V8SVxTH880zDtylBwFQ=
	=
X-Google-Smtp-Source: AGHT+IFFLTapbpq9yfN5NyUmLLfh7yHtwG+Kidt1zCbPWpTZBl7MH09mVCDDdVXETaSXAjZye1DAKQ==
X-Received: by 2002:a05:600c:c172:b0:453:6183:c443 with SMTP id 5b1f17b1804b1-4538ee33209mr27999405e9.5.1751022302697;
        Fri, 27 Jun 2025 04:05:02 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:40b8:18e0:8ac6:da0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe587sm48410295e9.19.2025.06.27.04.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:05:02 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Randy
 Dunlap" <rdunlap@infradead.org>,  "Ruben Wauters" <rubenru09@aol.com>,
  "Shuah Khan" <skhan@linuxfoundation.org>,  joel@joelfernandes.org,
  linux-kernel-mentees@lists.linux.dev,  linux-kernel@vger.kernel.org,
  lkmm@lists.linux.dev,  netdev@vger.kernel.org,  peterz@infradead.org,
  stern@rowland.harvard.edu
Subject: Re: [PATCH v8 10/13] MAINTAINERS: add netlink_yml_parser.py to
 linux-doc
In-Reply-To: <a8688cae5edb21b9ebbc508d628c62989a786fb7.1750925410.git.mchehab+huawei@kernel.org>
Date: Fri, 27 Jun 2025 11:50:39 +0100
Message-ID: <m2frfl8nls.fsf@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<a8688cae5edb21b9ebbc508d628c62989a786fb7.1750925410.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The documentation build depends on the parsing code
> at ynl_gen_rst.py. Ensure that changes to it will be c/c
> to linux-doc ML and maintainers by adding an entry for
> it. This way, if a change there would affect the build,
> or the minimal version required for Python, doc developers
> may know in advance.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

