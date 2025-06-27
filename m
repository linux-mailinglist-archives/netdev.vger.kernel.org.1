Return-Path: <netdev+bounces-201892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D786AEB5E6
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB101561DED
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254E2DA745;
	Fri, 27 Jun 2025 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9igoHln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC92D9799;
	Fri, 27 Jun 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022302; cv=none; b=Ho9pIOLpo59d+UPErxy7MWTXu8beSchpVcmThPkErnS7VYb3PmGBQG4dQQbMvwKp+BwCW6lF9IHQlsUDD0tfSMusX/9oiG3iUHJi44e6yT0JBTAhs2aUqoIjbaGAP1kBaP9FACogWoH1jrKu7ZFkMFhiIv98TSK5swmv9k0cYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022302; c=relaxed/simple;
	bh=IzhzSlg+a6MNT6mp9a166nnlPRXDawCSwrvw2zas3ys=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=T9bzJ3NrUYwhXNEuqu1Dt+xlbJQnnDHTjvRpueiRjtu7FNTDyf1ozlzOje4vc1HpTF/LtysmoDi4FEcVHdU3H2mgjHqSYd/B3ZiALCKdZCFschrYjl5sPDt/bnXopoqyderEhkd2GAvwlH14o+n4RWonL9eb4V/DMWT484GKk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9igoHln; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cfb79177so11140925e9.0;
        Fri, 27 Jun 2025 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751022299; x=1751627099; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ArfsTLmwxi9yd3k6+gxg662TPkYeEIsTSNfN2sfzizY=;
        b=m9igoHlnC3DeQm0fJcgStJMw6WFV/TdDzfaBKetGLUqefEFDJUfGm9juQjIu8a0hFY
         01QO/HlwqamQT5OGJq3ualPFxzkj1rg/QNhnHCZRofwD8h9z2T7xbJNTqveI6p3AISoi
         MQQWK0Ed175+x6BNWPmreuz9Ljadn8PXHN+hu7baIOZg31QFqalvZVf8OsO2FKFKUxky
         z3T1tYIOe3sHo70gsF0w9EnTcMNqC5Jio1gUF1x+0DrjOSGFsYZVHmsBgwDyzf4mb+vV
         yrj4zXVTI3DpI3zeJxys7hLK4AcrhRHihXpN9gjSD0GNk3/wLnxiQdiZwWfW7Qj2kFB8
         iQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022299; x=1751627099;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArfsTLmwxi9yd3k6+gxg662TPkYeEIsTSNfN2sfzizY=;
        b=Y30vZxKYOwbrOubIxFiVb72JxItcwefENBM3ZHBuSlxwb4C/4EI0rr3+EhV84XCYpx
         zgbXCTg5ssRNZq+x2EZ4DG6+K1VOZlPFvXIiJmST7IrnGK3ktnIsqa7CaLDV7gljCp45
         PfVtR7QBR73Wt8699RDtY8XckZORyodEPhKbwN8vLiMfmzoP6ySU8s7FdqimeHj1rCbw
         Fb34VhKqxU6SslBC3oyKTyMs82N9ICLzl10rIrxEBRX4ORM6YdAfpW2S69nybYrE+8PK
         0Qm7FKqLQJlK0Y0DZfO/9Yed4/N8BSx4hHd+Bh6jzpuNPenqdNQ7mRNXlFUroddataLl
         AQzw==
X-Forwarded-Encrypted: i=1; AJvYcCU7slV42fkt2hjEws0kdN0uLSg1c04FTLTJzpkAbHNaPq7d7INwof5iT96GRw5Cm5JJgr6eZwfpqc3B7sw=@vger.kernel.org, AJvYcCWGqqpJZ32wXuiIayxYvkzS5DB1/xx/dXH2AKljbaNRvCd442K/GyXMPxSgSQrxaL8F4YXVAAM5@vger.kernel.org
X-Gm-Message-State: AOJu0YwM49QAD3533nVYrhBn9fweiZOMvegj7pYWw9V5zhYQshfrLPUo
	1NJYQwujQxA22TJ1i62iSzjmQTWntha/TUqffmNahOSUe2LknXMvZlIQ
X-Gm-Gg: ASbGncs/FfB6y+sBPHGwZAQlF8p3Rh644dv3MKu6phipjeJIFg8kDlFUBPMVoFK7fRl
	nVEUFopdTUTiUU9PlSNukx1sp6OlZos8KQB3m1iLppoTsraVUSFOb/Y/ak++T5fjPX9UW2TskA7
	7+7m3Au50LT6edLrm21b7n+o5LZT5cjgG3rpUGIaCL3bPZ8Jxc/y9dV9z6aFzVrjik+fcpyY4s1
	h5b4/bfaK4fx2TxHoGjQMz5O8tsO3xdoU8GMqWtBTHepyKSq0GVCy/wd3I2nsv4gbsb2IMIdv0b
	lsgWlDEspFjliIKjQo9GDDyUig/g2KeqoHG2VqI8ayPh1W9QAobvqhRPv3ktTtGAosseEuoRwg=
	=
X-Google-Smtp-Source: AGHT+IEpM1ETIrENyCAnUIBLSlkPLHo3rmCFmpZ0/Rq7Eqh8Z5kuTci5QCowTov1lw+939ExHok2Bw==
X-Received: by 2002:a05:600c:8118:b0:450:cd50:3c66 with SMTP id 5b1f17b1804b1-4538ee62b0dmr27939015e9.29.1751022299269;
        Fri, 27 Jun 2025 04:04:59 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:40b8:18e0:8ac6:da0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c57d7sm81053325e9.40.2025.06.27.04.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:04:58 -0700 (PDT)
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
Subject: Re: [PATCH v8 04/13] tools: ynl_gen_rst.py: cleanup coding style
In-Reply-To: <398c4d179f07bc0558c8f6ce196e3620bf2efdaf.1750925410.git.mchehab+huawei@kernel.org>
Date: Fri, 27 Jun 2025 11:41:38 +0100
Message-ID: <m2o6u98o0t.fsf@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<398c4d179f07bc0558c8f6ce196e3620bf2efdaf.1750925410.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>      @staticmethod
>      def rst_ref(namespace: str, prefix: str, name: str) -> str:
>          """Add a hyperlink to the document"""
> @@ -119,10 +100,9 @@ class RstFormatters:
>                      'nested-attributes': 'attribute-set',
>                      'struct': 'definition'}
>          if prefix in mappings:
> -            prefix = mappings[prefix]
> +            prefix = mappings.get(prefix, "")

This gives me a sad face because fixing the erroneous pylint warning
makes the code look worse. I'd prefer to either suppress the warning
or to change this:

        if prefix in mappings:
            prefix = mappings[prefix]

to this:

        prefix = mappings.get(prefix, prefix)

But IMHO the intent of the original is clearer.

