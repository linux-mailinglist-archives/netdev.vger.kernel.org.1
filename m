Return-Path: <netdev+bounces-198579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7BAADCC2A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2611897DA5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0F2C08C7;
	Tue, 17 Jun 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ8e+JbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDC28C2D2;
	Tue, 17 Jun 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165199; cv=none; b=XsGNs2uZfu5SpkBm8BrmIeoQqozKyWMVGhPVhLD6BcdsCgR0o2pC2wVR1G5hlJCqmZ9p5PVArI+xgPyfoM6U8GvzVNP14q/8CdQdNE/5gQuF1cwb7cev7nYoLxhCaBhytDief2LqLBsPuRyY5YnZefMrJ3DRb7OblLb/xas8PVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165199; c=relaxed/simple;
	bh=bQYR6efMPCgHSXc5WbPc2ysqUPrzj3om34G9i+1jBvg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=eWAHxV2coJmFYOnZw3pwttMEM2vBKvfQJ1qIyleyGo2+x3PPTZ5R3eQoLEoCMBo6ot9GTWvTZAmSPWCfx2OtX/DQ7AgDUA042w/gqfGPncjfOMlsWkuICBiIrbeFBn8YQCqAp8UAnXT4ypqLxR88InszChn6b+AFqXhVMvaWzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ8e+JbD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54690d369so5808568f8f.3;
        Tue, 17 Jun 2025 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165196; x=1750769996; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfUao9xL+Nf+9UmRpe2eBeY78KoI4cSH6kfRJvoG+2g=;
        b=IZ8e+JbDU247dvRSngS3trxMbzdKl+s2XrnSdnt7Lz8OPmGANcs0jJFzXY4ViWb6LL
         0hVt6UeiVU1Q+nTy+QJN9adokASpxZ4jnx1TrpMR9k+RjxufVPIT5rMz5R84GpWiLPPj
         BqH9Ih237hqNmGXNG1k0yJ7qoAI0pLgouyNGJYR+nsPan0UWLbAZ4cyuvX7L+3UyJRR5
         FOUPKO0yJoIaYUd5D4e9NZ7vMLh4R0WH4+28LDBqn95HEpuxHYwH/cbzxJSrdOSte3xg
         gDbObEzMA3nN/Kh39VmoIwjav2MQ4MvGMrbBLo5zIEqlzlfphEXj7QqBEZvCzobfFji3
         24tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165196; x=1750769996;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfUao9xL+Nf+9UmRpe2eBeY78KoI4cSH6kfRJvoG+2g=;
        b=gmGzOcUOsAVZDUtxHzgQqnJtFaUKed8DHkZx/8RhRA2VMgIgnU79UKHp6MY0sDmmZ9
         9ZO5AzREc55eWVBdzaxjJmPDRl6HhWjMl1XZzNEt+jngvaFLP33YrPjxn9EIYsA5daMP
         POizl5YnGrcDqyBPi6XwO8TkfDm4RcC6zoRwC7x5Jbm0evWDidp02QJ7Zss2PjvpyV+j
         XAHjJvtVRKFMXLsTu+7fTXkFTjSzIWyRaJs/imI5RbWebbS1jHqz1p4M6YfMHXLINzEq
         xa6XeGbovBF4nkGuxp2CP6YAZj7fIrdf2OrKdfMmMWlrvXUi3NfpGcLt7fhpXiPg3j+E
         MFQg==
X-Forwarded-Encrypted: i=1; AJvYcCVq2/ST2mpuRiwLSHKDmvBWC3qJQ3aejRIn0Rs5/TQM1XKOlSRORSUTBG6vGvuVWbELIcIMFwr+pn1q3iI=@vger.kernel.org, AJvYcCWSVrBj3kzkcg66IbvSRwj8i/lqViPzVFIpfsYXjYkKzp5P00+x/ifl/ALviVEcEMPWMS/eZ+R/@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzjsf6Ed2l7cSU++tHAgQPwkafW5xtNil6FP5f//FxKZHOxrw
	UL6LM9UXLl/nPgu3FBE5QOa3KWtTqjK9En1bxXUXq+GNJkjGq3ks9FNG
X-Gm-Gg: ASbGncvasTM5q3phYAiWfgDUtDWFSf/g80JBwAZCjNOQYwCsT6b1CA4RKL3EpWQQM/7
	RKjbpoEyGYl9oIotfotjkd37PwkMCsWYv8psptU4xiyiWF9nvpkcQMD7uPuE6td2BGcIErjfXtm
	31lrOHdxNsDjDGPTOYESyK0EMJzjwXD0ZeP+wUfTJC9CsiBONfR1ugpe6Pgp5DmavmHYOYL21OB
	/lSNdAVdYze0/Z+zFIQoeYWag0/ptzpjVu/lOTd7PqulydGKXI0BhjTLnDl1B2GzCN75NEefEAs
	THAnoxlh4C3F8hHXGQWDqv1Ws/6UxWM+lNajmM+U7T5qXcB3BU3C+ZMn6WU7+r5567j5hU+Ly7c
	=
X-Google-Smtp-Source: AGHT+IF61fOL3eHzYcgqTc6vlyac0Gb7tm3KYDOskETixTUcfYre70Gc0Oij3ykKtyQjrqCRI7YAKw==
X-Received: by 2002:a05:6000:2884:b0:3a4:cb4f:ac2a with SMTP id ffacd0b85a97d-3a572374884mr11851638f8f.21.1750165195752;
        Tue, 17 Jun 2025 05:59:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2449f1sm180628625e9.23.2025.06.17.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:59:55 -0700 (PDT)
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
Subject: Re: [PATCH v5 01/15] docs: conf.py: properly handle include and
 exclude patterns
In-Reply-To: <cca10f879998c8f0ea78658bf9eabf94beb0af2b.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 11:38:06 +0100
Message-ID: <m21prilkkx.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<cca10f879998c8f0ea78658bf9eabf94beb0af2b.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> When one does:
> 	make SPHINXDIRS="foo" htmldocs
>
> All patterns would be relative to Documentation/foo, which
> causes the include/exclude patterns like:
>
> 	include_patterns = [
> 		...
> 		f'foo/*.{ext}',
> 	]
>
> to break. This is not what it is expected. Address it by
> adding a logic to dynamically adjust the pattern when
> SPHINXDIRS is used.
>
> That allows adding parsers for other file types.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

