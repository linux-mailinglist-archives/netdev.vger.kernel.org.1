Return-Path: <netdev+bounces-152220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D50009F31E6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D876A168433
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AED204F92;
	Mon, 16 Dec 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpYjIonu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12102556E;
	Mon, 16 Dec 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356725; cv=none; b=NLjz+EDlT4jhwSSqzTknM3+MN5e7OumquvId/x8uAZePns0aajORWHARjVUbU9K8GcP2gtfl1ofyjJmNWMbWNaNiAtt/dP7wFEhSAuqcPybX1KdjvNrCg47Q/OAexk2lGC7y4cJnOrVDcB9OSniMyNhQx++4B3qWL6ca1NaTGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356725; c=relaxed/simple;
	bh=cbLYHL24GvRLA2WCmHGegE+NrSzHOisG7JdSVsWLf4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZI1itjyMhJk+WPJkM9IeyudRW1mKIm+mdS1VRm37755odxWjWKgFah4fcG1uQDa4ftRc7oIing9QNqLRWz6xqoDBvsHgX9TParAbeUKHFD8C8/im7ZdSEsbTeP+5q26iaMC8NPaEtypcpN1Ib//W/iuMH/mKHCnzV1DBmhAsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpYjIonu; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29fc424237bso1879655fac.0;
        Mon, 16 Dec 2024 05:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734356723; x=1734961523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbLYHL24GvRLA2WCmHGegE+NrSzHOisG7JdSVsWLf4s=;
        b=FpYjIonuMaGPi9AiXe+O9auuCCX4PE0yF7iyumY/A8a++GXoXV28xTo+/rewHRb+jE
         gKGFUN+yTzhFsr74Zb66QEOsUIgzC9/ZZHRQ0WBQgCnHRK5mD9hZed8kS1wjcm/NZg1L
         qV2m/mVgkAAiHRH3k9cXhYHJM4NuX6DfYt4y5qpsfbF5dWbe+om4id9+TbVsYL+Ssjag
         LDR+n86oBG0hbZpP26TFhCrhWl2IAFpxT+Q0yM+Dta4ZanK0Wwtk/Q+BJOVuaqKx5lVg
         CwGpla+h+XNSc1CSBb0httQzyPZDLu7uuwvPW2aGxLR4Dv+3NvKaFHIcyY/rg2T+pLRi
         Uq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734356723; x=1734961523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbLYHL24GvRLA2WCmHGegE+NrSzHOisG7JdSVsWLf4s=;
        b=NtoqU6XXUOAjKxdXE1OIVpYXhzBBI/ImDBSlyzWVa3XWEmodHGJjk4AllPRcfuhfeX
         b0c7fHPCYxdsJpM8zF09osWUL/6vsyXQrNBupNvDt8kY1evsVcJjJ4SmeycDl32r3rxj
         SOrdqwkyP3nzi8S1BPbarUGrbJhmjk3tI0CqnjO2jc4V+pGvCeJuUkX+nRRO7MAJqCzP
         CcS32HmBdJ24YIaJ6/JI8SvPk0P/Kr1oPDQ/o3ucNX90bU4fdDfOHpQAoN/dO+FqL/BG
         2ezRjh+bqffL7BJ+ZRxU5lT+qJSmAvYrNI09+rmmPKCun+L8FfCB5lQMUASS0E51d8bH
         1BIA==
X-Forwarded-Encrypted: i=1; AJvYcCWqROGg9GIW3ch6tWZOOX93AffYczxS5eavvUJst02AtjI6wzuklt/H8NLO5wtDG7k/OLGO8WPLeVYkBko=@vger.kernel.org, AJvYcCXzhA1etmct8oTx+GKEFTAz3cP1E6LlFjCi+HKVYL7FQqO7Gs7ydQwD+qucukcu2h0q06Em0V2s@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0Yws/ZfqBUAn/xUJlcjMpVMP3z4NeqlxHJ4LyVIa7nIxS0my
	0czrDBX8aaMyeY3ItPfiSvB75ZjR6ZEnaX961927wD8qjxWhBKIx08rQS9FuTSPDsAbOVN+EUdh
	LiqIxOU1VY1EvzuYi1KvHsBdxeuo=
X-Gm-Gg: ASbGncu3ss3pl+sVC+w8ihu7/0c3jxkeyYoLUCultHag90gxHv76gvjiQNPfWmdqkCm
	Bh7JuJu6ZP2w8U3m7A+fdgIH79CSCtoE0L6xRJKcWHzjDu0rrqRCWoTJboxTQFVeYbxa5
X-Google-Smtp-Source: AGHT+IFTIlj/lW2ZyYusgYbNDCULBun4rlAmEJcYGeZMgV2LSWnBWgJ42Lyo1FWjnsWvf0Ow83gjUyadkb5PrhnjK/g=
X-Received: by 2002:a05:6870:1d0:b0:29e:66a1:2236 with SMTP id
 586e51a60fabf-2a3abeeb389mr6567717fac.0.1734356722924; Mon, 16 Dec 2024
 05:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734345017.git.jstancek@redhat.com> <64b1dda576e9502c5d704b3b31fda2337a189e19.1734345017.git.jstancek@redhat.com>
In-Reply-To: <64b1dda576e9502c5d704b3b31fda2337a189e19.1734345017.git.jstancek@redhat.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Mon, 16 Dec 2024 13:45:11 +0000
Message-ID: <CAD4GDZyMUVrzWZsjJs9xXnkBBn+mvnLGaGA7LvWC=d0o8muQMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] tools: ynl: move python code to separate sub-directory
To: Jan Stancek <jstancek@redhat.com>
Cc: stfomichev@gmail.com, kuba@kernel.org, jdamato@fastly.com, 
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 10:42, Jan Stancek <jstancek@redhat.com> wrote:
>
> Move python code to a separate directory so it can be
> packaged as a python module. Updates existing references
> in selftests and docs.
>
> Also rename ynl-gen-[c|rst] to ynl_gen_[c|rst], avoid
> dashes as these prevent easy imports for entrypoints.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

