Return-Path: <netdev+bounces-197390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64FAAD87BC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DCA3A75AA
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434F28135D;
	Fri, 13 Jun 2025 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8I/jcG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A1256C73;
	Fri, 13 Jun 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806817; cv=none; b=sdV7vfde+Qv0RipDZ4WgD0Q+0HYH8XOsd/WbOD2PNZ+Gj6m9/p6JRPhoUFEprCtLu3WZHFDatVoC0bqgymA+VvWxprYvPc5GQN6e5jbkqRkiMrcdo9Uk+71aGr2xmaIqP6SlmtBI4Rsum1FH6F+SMr6YuHpDXD8ExpuJIkXu31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806817; c=relaxed/simple;
	bh=Q5BhcgYpE35Y8AxcdDXKZviSULn7xDLW+iYnDJ09n7Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Cvu2xcf1OwctF/68W21TmGNW5snNkc6q5GKLhZUbPyucXU13pfjqvkd9JrdH+YdYPMhGcAQM4VI54VLb/01UDyKLDaV0Av2A1BfZNM9RxwWEUi8IGmxAhLnU9Oj1l+eP3jtMb3jwbMaGKDaLRGpgcTlLNQ8Zlr2MjuF6s632oS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8I/jcG7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d3f72391so25058495e9.3;
        Fri, 13 Jun 2025 02:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749806814; x=1750411614; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Itja5tG6Qc2KiSi1iAZTXe7H2ni0UGVq2sw+wpmt+pc=;
        b=b8I/jcG7pVixJfDnTkSOJZQMIHjZ0y0rIeieVDjWnYBTBsq98bxy3a6NEdTHzW6BNT
         9onF45FJmkCKtFS2hI+lkQpo+ALf6ooEVhmQ/DY4CNMfdjqORr1HxZKO3rTc9XrCDkbr
         6BIAungUXFlJQqYq2RXsHfU75xSndEUBbZn3aVBSNEVXpLGI9ULNS1qGih8Sg1kkj28e
         kNTm9rZeXOUA4Wwy3BAm7sUxQ7hDGX1t+Dde1CSPQZCZ7HXrlVzfFQhEJ1fLi9HRsCNt
         uXqKjuupN71gCQqjs9+A6mxQsuKPyiscOWbkVTkrxVKDkVdNOzNh62pDVRDINQn+strY
         Uf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806814; x=1750411614;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Itja5tG6Qc2KiSi1iAZTXe7H2ni0UGVq2sw+wpmt+pc=;
        b=IPR5W9ZA0alpdRQJclgU0HluDiBJtxKqLUo/6RKWY52+3O3w311ydy99fVbZKc3qAj
         SuwKUXMF+DYAA+YE4x8FKyhxIJ9fLWyHZq/71B+QgacQMrQj+gfr7S4avceHrZ9sHwiJ
         XyEePYSLWYUkjUE2gVwzBZRU6xPRAt4NrK1MXvVjjEYnIZeJlpaRayu0R+yMdPitgIx4
         7hssZFK0qQpz/c+rry/CWDqkwY9ZIj5lUSgTTN0mIp64lff1Lo0lcHHYqHnCca7s5rRR
         g/bipGvpidXAzNfi3DkWMZeJwnntBR1K+6Aq328lYD3I4q8SExIwU52E637jkjHfmnXW
         L8zA==
X-Forwarded-Encrypted: i=1; AJvYcCWhYAiQaU0W5sGUbpDZfWOWCcbVLz3/WjyhraScX4Q7T+pftr45m11cwebO9AWJ/yvucww3OCp3@vger.kernel.org, AJvYcCXIMke6S966bMhv/jyPPrnP2lMU4Sg2K3KQmofz+0ZMFL+a9vn54WltiFicbyrRjmm9l68NUZa7vVBhSUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOiFDbP49YcpE5MENnVmKmwJbif78i71XLpJrHcHgwcaK66dlv
	8wTikIevzqJddWM2+sym8jnrPizdwPtadVhchu+S7Yv4GEAPOU7lSv1C
X-Gm-Gg: ASbGncsptgGactUSyDibv4fT9rjOQEuAfXIE1NXPMldbf+WKepqPrgbpPCIL59EkqSd
	M6G2Bhtfsgxj8QyW+H4bqzTcudW+BumON/F1LexXRixgPnZ95zTceqNZgySeC7uD1z5a5Ot7FM8
	oymloKQt48eEtBVU/kun/v5QWr2Pb90RXmiCLqp/o9lk/wGsn5VGkBLR8ddtSp7kYj/QpfDqikr
	Xbq13OnfOsU9ZYE9A2ncVGo01vZRA/1MTgLhZHpzEdwkLrlMsug6wZAe/xVHpz1QWXm4mLPRa8p
	7rIJYk/RPPQ0Phtyw2Mc0Qv8porV/xX16D/vvX3+8YFqxtnuxp+4lju++fbR9c5DsBj3wLCqy34
	=
X-Google-Smtp-Source: AGHT+IEBTo7kIZ4DJ8graOHN/KQaV05qSrUjoSPXsongpILB30NWUheQhDMVK1PCPCF5Qi8PHQzzXQ==
X-Received: by 2002:a05:600c:4f16:b0:44d:a244:4983 with SMTP id 5b1f17b1804b1-45335582b9dmr20908865e9.3.1749806814082;
        Fri, 13 Jun 2025 02:26:54 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b2c957sm1747795f8f.76.2025.06.13.02.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 02:26:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  linux-kernel@vger.kernel.org,  Akira Yokosawa
 <akiyks@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  Ignacio
 Encinas Rubio <ignacio@iencinas.com>,  Marco Elver <elver@google.com>,
  Shuah Khan <skhan@linuxfoundation.org>,  Eric Dumazet
 <edumazet@google.com>,  Jan Stancek <jstancek@redhat.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Ruben Wauters <rubenru09@aol.com>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  lkmm@lists.linux.dev,  netdev@vger.kernel.org,  peterz@infradead.org,
  stern@rowland.harvard.edu,  Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v2 0/2] Some extra patches for netlink doc generation
In-Reply-To: <cover.1749735022.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 09:24:43 +0100
Message-ID: <m2ldpwnj5g.fsf@gmail.com>
References: <cover.1749735022.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This patch series comes after:
> 	https://lore.kernel.org/linux-doc/cover.1749723671.git.mchehab+huawei@kernel.org/T/#t

Can you please incorporate this series into a v3 of the other patch set.

