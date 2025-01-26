Return-Path: <netdev+bounces-160987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77403A1C837
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 15:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BC83A6AEB
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986A578F32;
	Sun, 26 Jan 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NOXEi7oE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8A1547C5
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900228; cv=none; b=K4KDF8NwaCKJUYRK67CzS9KbqyyKcK4stwc3tKcuk2AEm651P0juAcKip8/WgFc8Ag6I33SYldjEXniFbQcgblVxQExasiJwKhynvwKzxSQBaq57mQXTRnH0RhisTqKiAAHwR186tifmioomiU1P0tMFdeAGykoludqZQsnHtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900228; c=relaxed/simple;
	bh=J9zlLkMNuptz1MrLYOUQcIFDBpe9clffCABrxF07OvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLtcisPK3GQ1IkrBi3RU5qyBKoRJDLuA2mgfvJWPJukXCCB6pL9URVFOENoO6ycHT6dv0eh+P1vKMWD2n5SJFd20JCLtBbdEagadu5gwhF63uIjKGAQqE0NxchX+qVD7hWB323EjILJz+q4pMwjcT8G8927IUWf1Wl2E83WGzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NOXEi7oE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab633d9582aso638073066b.1
        for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 06:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900225; x=1738505025; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9zlLkMNuptz1MrLYOUQcIFDBpe9clffCABrxF07OvA=;
        b=NOXEi7oEIz1DHEHbZnl0lmKWa5axJwlKmut6toFhcB/MtSjjok3ntn4uOp3eTeIPJp
         HXGf8wEqc7t2DUipWeqENeUXClrx7f4DW7Y//bynu8CRsV4YbPABBy4XmPHak2j53Onj
         d6RgB0wfrSON3QcgzcfQruvvc9ocgssiWVUgaSxn7selra6P5efPRg12vHP3CZR9dSog
         MBxAFIBEAcLoTQSYXtMnHJS8Mr6uGRJfha5u3HiJTPrBXJJd/BOtrlj15YRUTlv0P70V
         4Op2WHuO2dGl4A65BwLsGvZerqN9q5P5L8WACG2YSxWiZuNBCfr3f7ReWjR/H/46kfza
         2uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900225; x=1738505025;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9zlLkMNuptz1MrLYOUQcIFDBpe9clffCABrxF07OvA=;
        b=fnHa45E0+XiwGF++C9epS/HsUgbYDl+ODJ+1k0pm22nX+GhLyikQJ2llwbk1blKp//
         7EH5BEc9u9To+632RPiYsPRExitg9y4fzjjqbzjtpaDa/1oj0iNp01M4Lt5xKPfBij9a
         LxgDdyamLIzDYN6CjSMjkXK6eEhDA347TKuUQUazMlLzUzbFyM5SOyQWNCmhDVWgF0lv
         6eapJZpcXll2Mw2DnEjH90GNn4a+p/v7SUqZY5d8JGsYZtbQftqUxy3fkU6L9t+4MnT2
         SHpWJYiFnOJqSRE9ZFM1cIU2aeTyOuNh1CoO1uFUPFKxopMw93i5YOuCdqbHpLRit4/L
         WToQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNV1OSbdKdD/JMQOV1ypH4Z65RMBSwE0S2o2y+UDwJ5CF1Nxt8JpR30JPczpEf000CKyBoiWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/ypbdFnB3oU/3krDNwWg2Dwry/RaFtfZsH04YFhqonniLU+7
	2F4ZlqCudlTRToFqY7s3/Mh1d4W1BgBHzca/WVB9VPyaGndUVPQKLxf789IV3BY=
X-Gm-Gg: ASbGncuwTbgLP9brD4E5gZsCN0w2Y9vqhMalKNJosnQ6XlPLWUg/RuYYZeONP6P8pPx
	fsA9fb+7xnuCJT0/X/YwOnGuF+MVAQmjDwSFlfLxXSIomArkYakcjotvsOOafCq6o7EWVJq9GSz
	N9hmGPuu8rfCAAiKnyRbrfxd6cAOlT7yTQ0WWufGt7DRRun/QvMky56yy+xTskxSO9wfk2qH7fk
	3eX6ITsoL7DrDLq7q6VJm6bR/kdcdHJ0/KIQzrIUy5Y72YBWbGxoBKttTb08LljsahwmEj1tQ==
X-Google-Smtp-Source: AGHT+IGWs6TCgafm7EZsQWtNb77Wb6bDxT3YATHBRWhxGzfd6txwT/XuznzYq9+S9m2UEGIDSMl2sg==
X-Received: by 2002:a17:907:3606:b0:aab:dc3e:1c84 with SMTP id a640c23a62f3a-ab38b274a03mr3048962066b.17.1737900224947;
        Sun, 26 Jan 2025 06:03:44 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e67836sm430235966b.66.2025.01.26.06.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:03:44 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 1/5] strparser: add read_sock callback
In-Reply-To: <20250122100917.49845-2-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:13 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-2-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:03:43 +0100
Message-ID: <87v7u1d64g.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> Added a new read_sock handler, allowing users to customize read operations
> instead of relying on the native socket's read_sock.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

