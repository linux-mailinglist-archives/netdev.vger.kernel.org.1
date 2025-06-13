Return-Path: <netdev+bounces-197464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A52AD8B5D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEB9162C99
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D442E0B56;
	Fri, 13 Jun 2025 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsx6/CLA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3C2D5C94;
	Fri, 13 Jun 2025 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815735; cv=none; b=O6Pt/o77rzYqfQoiBFUT9ORMm88Ppgek7p2hUo9bns1yhYiNGMoBdEalQ8a0AP5rg86sQZVrNP1wdlpbRKUqSOY5KpraLcaMMP5bwwuLRPI35Td7Iny1V2hPiUneLJxQ4EDe2XEyujE3SsO6vWzgUl3ZteqLLj4uETvostullck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815735; c=relaxed/simple;
	bh=39J8B/it+yKmHYIqv06bQIDCskhQbpop8t56XJh97As=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=NRws+Ma73F5zbhtWfq+xj0cpIhQKhsErDnuzkIcH2Dr3MWGSOIg4j2elpXjU4KDh4MbIR0KsLncpWSb0za0yHpnLlcMKNy93f8mMAmKF8sQPtYXAIS/lFtkf+WhBiV3jWigzyNRufN2Xosw/JroFitWx62JXCaQRTJ33HgeQMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsx6/CLA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a3798794d3so1954912f8f.1;
        Fri, 13 Jun 2025 04:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749815731; x=1750420531; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JJXFHi9ldlQPLqupON6xlA5LEI029g70pUzRWZNKyU=;
        b=gsx6/CLA3wUh4qzsSFVoyYoJTzCGcaYqQX7jkLru6VrKrwFuIVBJNgy9wer/weqgjO
         UJSBonkdhKsCiU9qtYmScIKS46+bfoEt1qaai3LU4B+RoWjYzSUguRyr9bshXU0Oh8aK
         +mbzHO+cGbofk4F66W810o/Yy7WMnqAP76yQOiEpDBYofyIqJeQJ96kh+jEZ3LRyI0v4
         gPd/67Q0O4m8opiWNY9oXPQlNOD+AJpiqyzBdoOq+/fFD9yKliTuqLFhMOC9BOAqXbXd
         kZ74f+YfGfQkFY+XBWWqV0JibJlt07tq5RMVkQcdyg5oH9V0FvhtwXqy6+XWcJTdEO5U
         SrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749815731; x=1750420531;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JJXFHi9ldlQPLqupON6xlA5LEI029g70pUzRWZNKyU=;
        b=PLjBvaUolE4Zf+iOXO0Ta2a42h46Vmv9pye5DVpguGrHIzZ6GgmIebFjkhzq28VauC
         gSNHb5zPdUXOuOQPDQVoqxGWzZ0IYMFQbCKsdJexUulx7/17iwkDzLs1F4xvLRoTEYQL
         kfnIrxUMncyTuefKP6tG4nDAYRePelhwgN0wZ0A1EJuXHVrpOyxL0fD3bxaxggmsgFvi
         7T76PsmxLOMubU+woEKqOaBQwBIy3615I3iFF+DRzS8gGNZ9pe8NpUaxb9xl00RVIOvB
         qX6V4ft+vamEp46AvfFLm1VEmY1SQQuDBGwSLDCo1yIJNdouzoGpH8Sml1s/GKFjjKHc
         pSEA==
X-Forwarded-Encrypted: i=1; AJvYcCVvBUuk/VYpRsadhpR6xztnjIJcNmR54PnNUxfFSc59BKbFtmfsCNxvgPWMZZYlpDvsp4cccWovDo/I+Ao=@vger.kernel.org, AJvYcCX19prqCcVQbPbBHB0dAFr71IpJ7JldTr5eFJk8N+6gmpPHo+x4dg37/sOnFKmf4mAFDOfCEKx0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoum3cXWHApPhaik693hZ794tQP6DQp9+l0NRvwBJPeBx84Q24
	OOhWk7HrW3ERnVvZTE5rSKgPJtISKxOn4Lq0Bws3c+tWAXGlQvQbZXrt
X-Gm-Gg: ASbGncus8lTJt4iqjTU9SJx4KnMC4ldrJpaUOpqdmep85JyZs7bQuwBPwYBNNO27a7B
	IOBnwUehis9bJAxdf6o4ybFMwqfcW3JvNRykqMnkC3Y5JX+pqC+Gi8LjdYbzDhKzi368niBiTid
	Je2DuJUxvZBretjvSI1zNa0ULPzc4/gyK6D/Gy54UdafD2cw3aV3wnDI+hMxc5xFBAVSDM5ucHo
	1pgf7GMMHTtSHsFatOxYZ9NHFy/m8RColE1hVcYXWG4GV+IrerAgd6GJ7zyEu7BIDNPd6QWcEX+
	ti5NkLw030cFqsmb4TfpH2ufh7xrnpAdHU/p5fUjxKbRqJHUqpKXyi3n+p5NAUgqFHCvY3/mDLE
	=
X-Google-Smtp-Source: AGHT+IH6ZxOKA+nk3cYFyy4sPdDCDQoX/fjJFz1gR0pdr5Ok5AHJOjXsI4WxV20/dTCer5v7vreBMQ==
X-Received: by 2002:a05:6000:2c0c:b0:3a5:5fa4:a3f7 with SMTP id ffacd0b85a97d-3a5687603d1mr3028691f8f.58.1749815731307;
        Fri, 13 Jun 2025 04:55:31 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087f8sm2176397f8f.53.2025.06.13.04.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:55:30 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v2 05/12] tools: ynl_gen_rst.py: Split library from
 command line tool
In-Reply-To: <440956b08faee14ed22575bea6c7b022666e5402.1749723671.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 12:13:28 +0100
Message-ID: <m234c3opwn.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<440956b08faee14ed22575bea6c7b022666e5402.1749723671.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As we'll be using the Netlink specs parser inside a Sphinx
> extension, move the library part from the command line parser.
>
> No functional changes.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/lib/netlink_yml_parser.py  | 391 +++++++++++++++++++++++++++++
>  tools/net/ynl/pyynl/ynl_gen_rst.py | 374 +--------------------------

I think the library code should be put in tools/net/ynl/pyynl/lib
because it is YNL specific code. Maybe call it rst_generator.py

