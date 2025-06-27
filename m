Return-Path: <netdev+bounces-201893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08901AEB5EB
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE4C16AC4B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8F2DBF79;
	Fri, 27 Jun 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4qRKEYA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15842BEC4A;
	Fri, 27 Jun 2025 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022304; cv=none; b=G1WFl3uu6/4PfBbj2MT0EUPbE9QHGIzymbCygrXmCvTPWSgfojzOSOoO552GSBkNUi7TJ1i91HvpssnL7SmiH9UW1DcPHVkOyb/hKncUUC82ZzFOW3n7hKazo/JTIZ+chZ6RD4UoxMZkxXmx7DwevLTi2T4ANPwLR+6zYIQwyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022304; c=relaxed/simple;
	bh=4hfOjU+Xu/htgbnrO/6j06ZqG2i0jYGSE9EvifTKQ48=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=n/Dg1zWkkVA5Xd6j5LDOlCTZ3kypYGoYV+93xESzpXfRzvzPw5A75cswQzzPFBESKM0QACIYSC1jtrCUMj1htQ8uVqDBDFSuvlnuy/+G+0opCxfS1hEu7tKLkz1v1RBigyvSDiPV1TWLFFeoaKaOmdPHS5KaCPRKfXud24VrWkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4qRKEYA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-453643020bdso17887795e9.1;
        Fri, 27 Jun 2025 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751022301; x=1751627101; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hfOjU+Xu/htgbnrO/6j06ZqG2i0jYGSE9EvifTKQ48=;
        b=V4qRKEYAJxsRWPq77zyZiGtMMORDXxOqgzneCOHEoBrTgwqh8nquoH2GMlSamoX+Nb
         jQIIi0iyYLBkHzU9M3dQEk6lKs00CVq5JSikmApKzWrsqPOBTyalXAzcTyfodEdkreoi
         6tdQWXNUpvRnj6B/3RXCYXe4SLQyapBN5BtKDsRls66XHPdrW5KKmdUv4vjYpExVQtf/
         z0lTarhtpzT5ifMpk9dp9YxIxMlwYxWMLnczpLtp/xmf4oUtefulA0AMdW2A1QlRoqeD
         I5aiidpYweXqgGapA18j14zE1hHki8dvdfzu55wVmPFajXXSa7giI1jiAr/ZcS0Z7mxb
         13hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022301; x=1751627101;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hfOjU+Xu/htgbnrO/6j06ZqG2i0jYGSE9EvifTKQ48=;
        b=wk+T4I7KGSJcGlAKZwJECnv54dyCZzESfCDEkzbNf2YmhtO9EPA+Ya61l0pPUtZCsM
         GpM6nXp4MFOBjTKhfitP1WEbIbIwLLUTtY5VogZBp4u4HMK/D4P0i7EmsARf6dQOpbG9
         DFuVqpVotrX3LuPc3WuOv5fEEZ0DaR7eNEJsU4eU/HA8Z4yratmfHPj5WhLRmNXqQMzl
         eLE8U02I/8yTjFvqDQs9KY6lcueIt6Bm6vLsZ2TaoKMYOsH7k1v9FeRnwzU1HI/1rtTT
         y8yN6nV2UxBJcFMdK0WkfrETz4JuMRwO9Z9OqLDMsJyymkY1ScvdactTWN/izcptxPYv
         mDMw==
X-Forwarded-Encrypted: i=1; AJvYcCVncc904w2Eqv4vMDfKMnD3dv+rLXQuGZ0G9Gn5WRuK9CX17pKatnhub1UV0csZSz9F2MIaoWZIWMRJHYo=@vger.kernel.org, AJvYcCWcM9tRxuLhew3ST5iLf8G4KsL8wwu2UYFVFjierWXvCeeg6cicMOT9gMD4L69EJHnGRPNAqgaB@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOwZ5TrNE50vY6qlNVNQ3bDC/JxI6p8rVAjnReXiFo3o6ntLH
	yQwm6c41HIkl7tz/XZyl0GGuDx0ixS4T9+8h70Gar9CONo6PvSdVU7dZ
X-Gm-Gg: ASbGncvY5HZbo+f/sZzHJ95w26KXHz2L58CBkS6q+m1XF8rEjbMMiQ+cjSBHNRSwoVe
	C1gm2ATY5qb4kmGyemKsNuhGtnSUveFe48M3mpDvZvUkXvRvULk8jxOvGqSzsQS670v+LytFtuZ
	Q+x+joAc0ONk4v1ONMAz6aQG6O7YptS+/DmYrJIPWVupLwGOYs7dgda36r4pbSVepywRVHQzQ3v
	aMMP75df+jzM+movCpBq8sTkE7gdksDWBT/hUVZ7VouEbTW9mXpxbFt42reDB+h4xQa3+wzc7JD
	iFyC/QZKlJY89HpDi5Z4kY7S0cMnQLrfgMaNP59shI7wOgmrC7IZP7Mq3ubSGmz/vuCbBeokEg=
	=
X-Google-Smtp-Source: AGHT+IE73758IwYSE3gwQCVr5ocOcoostGM/uXpiZKDoUYwwlxSUMV3h6l1nDvdN1/+koG3pVg3tqA==
X-Received: by 2002:a05:600c:8712:b0:451:e394:8920 with SMTP id 5b1f17b1804b1-4539341e446mr4257555e9.27.1751022300978;
        Fri, 27 Jun 2025 04:05:00 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:40b8:18e0:8ac6:da0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c4acsm75833275e9.1.2025.06.27.04.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:05:00 -0700 (PDT)
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
Subject: Re: [PATCH v8 08/13] tools: ynl_gen_rst.py: drop support for
 generating index files
In-Reply-To: <95d1ed00026acbe425f036f860f7bcd1a18ce98b.1750925410.git.mchehab+huawei@kernel.org>
Date: Fri, 27 Jun 2025 11:49:28 +0100
Message-ID: <m2jz4x8nnr.fsf@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<95d1ed00026acbe425f036f860f7bcd1a18ce98b.1750925410.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As we're now using an index file with a glob, there's no need
> to generate index files anymore.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

