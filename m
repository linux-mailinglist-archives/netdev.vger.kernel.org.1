Return-Path: <netdev+bounces-249928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B308FD20E2D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86492308808B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D7339B5A;
	Wed, 14 Jan 2026 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FQzgnk1L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB33296BB7
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416444; cv=none; b=Z1/eO080ybEQqEuKAVo5kwdrFnGIlTouu/ItqYiPE5bVofwejPBJnKom/cYSSPpgzlHI8XrCDJodAjUuXX2PTJpTXJaWFU3rP10vG6pcN6bVO7cHKrjo8XiVP66/lA4110eqIlpQUBfR4KtOjeV6Ntf0Jqhz93LFksjLnOdLvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416444; c=relaxed/simple;
	bh=w8lUFhX1Q3HbWHh9elcFCgC3saC9ct+577UUZm5WWx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qM51/kmZX//l2HhygKWVlHQgqNxhviL1COpZeaTDEkv8k3qR+0u2K7D4WwRyj5VVfCFysn2ehTQKwQ5bDWBkKq/vANm1lFCgi/bBPcKWJNLo41BPxi4lL74QHn5Rh4LsaiLSIIylMLVy9Jnk6Ku5rU44kFhIIkz2+C9A205ntiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FQzgnk1L; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fb5810d39so119996f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768416441; x=1769021241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ettgCx88xDnNziLn0uYirLEPKkp6YeQeeiz5NOCuBuw=;
        b=FQzgnk1LSH2GKRWQ1NgvfLMbjcwRCHyt8CQO0juz9tYamGryObbWEtdKUmnKBgmSHu
         RE8OxbxRJY5AD4VcJwnkI/g/DGvq2gdhXeRzqJjBSYQQzaKftEZPyBSk9gvUrHI6wtD6
         AyOu3waZ52GTbhCw/Hs8+a3K7IakGxQSPqImjsvqJy9150NyOrBDBpZyOaemkzN26OEH
         Ifzt3lgqduMd5b+/LkFGRwIR/wHWPf0jVmM74SSeO0ZSiFTVBFHA9k5I4gx+qkbJiptN
         QBKZ+lAmwaXR320SxAOVXuuwXF+NmmIGO1GhGtz2d+mkdHCWSpWsb6Qvgqvu8i/tFIzS
         omZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768416441; x=1769021241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ettgCx88xDnNziLn0uYirLEPKkp6YeQeeiz5NOCuBuw=;
        b=vnFstf6oTNP0MW9WO5l51dWzF5hc+Y3AX9EUoUfvMksA3RFVPehTrcUBu47KbIjRxo
         gCrSaj2oK8+Z4JdDeHXSOpM5JQLNhlPJoHt/BtnVkO2sXpVXIPVTtkgSC/7Y/dfp3X9Y
         sPO+HQDsL5/azu6OhewPdu5hCilRJuve7B0UPEDhvZTrBdbtrN8WhG6QStDwWwSILtOG
         6BmMWVS5WsL1dE46P0BtKRbpX5yYaAw5lET9HfcL9kblBXuJ28V+EtUYrqhhRzalD9Ve
         aK/vBRpAl9M7T7cnjX9sssdkkppW8eWz9o7YHSJ1xBPLdLQYUWZG54OBZ25ZDBG2ERHL
         EpeA==
X-Gm-Message-State: AOJu0YzkGJLxCCxW+tZH3LTztzxdXf9K906Twe2iZS75DzgnIRcjdADw
	OZU5qDH2ATwDbZOw3paa9JukrXpUJ/NLgoboqEv8WP3Nb1IfmaPtoP2rru/9KbDiOEw=
X-Gm-Gg: AY/fxX4QAHFr9CzEa+xwu1hPOhc2McwOKxa+B/6o/aYZiDoGr0Kx9wQzrEbocrUdEiQ
	//u9n7Dco/4lcuC+gYfgrTW2He4w9rZ6r4w3A/o0sW8JtqxA9tfwINKAi3gmo1f5NBgR4GiJpHB
	Whs7t2mMu9o3HnoVB+LuOoaNLCAgEef0gsoOFnI4uXFQh8F+nCCsrT6RDmNuH2POoJt0r7NDMf8
	2QJ2z+GPjJVjSVqBoOLHU87jKPSO1ohNXjYGLl+3JxQppRj52D8Xvcfmwzt6/xEz/PR+PRKV+ma
	x5zVV9YLDZBfWCNdB88cpoPqSZGO3EDbbLuLVYrW/Bh/l8np4DF0xH0TcSG9Bb6JQKz6W9Ry2sN
	XZ8Tga+Qvd71+T8/j+ynpTgVAwJImGPlpCSdh2dCyh2kt1O9Rf7nsLJwBYK6fk/0U5txwXJJ0SM
	y0awH5RsAriM6LZoTwdF9eo8hNLxJpk568BPM7UJQ4MhpoC8VxcoTo
X-Received: by 2002:a05:6000:1887:b0:430:f704:4ef with SMTP id ffacd0b85a97d-4342c571c91mr4185698f8f.61.1768416441067;
        Wed, 14 Jan 2026 10:47:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d90aasm774952f8f.29.2026.01.14.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:47:20 -0800 (PST)
Date: Wed, 14 Jan 2026 10:47:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: netdev@vger.kernel.org, Gris Ge <fge@redhat.com>
Subject: Re: [PATCH iproute2] ip/iplink: fix off-by-one KIND length in
 modify()
Message-ID: <20260114104714.78a060b9@phoenix.local>
In-Reply-To: <20260113114127.36386-1-jvaclav@redhat.com>
References: <20260113114127.36386-1-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 12:41:27 +0100
Jan Vaclav <jvaclav@redhat.com> wrote:

> The expected size for IFLA_INFO_KIND in kernel is strlen(kind) + 1.
> See `size` in rtnl_link_get_size() in net/core/rtnetlink.c.
> 
> Fixes: 1d93483985f0 ("iplink: use netlink for link configuration")
> Reported-by: Gris Ge <fge@redhat.com>
> Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
> ---

Good catch.
It does raise the issue why IFLA_ALIAS is a binary attribute.

FYI - AI code review agrees.

I'll review this patch by examining all three files you've provided.Now let me provide my review based on the analysis.

---

## Patch Review: `[PATCH iproute2] ip/iplink: fix off-by-one KIND length in modify()`

**Verdict: Patch is correct and should be applied.**

### Analysis

The patch changes:
```c
addattr_l(&req.n, sizeof(req), IFLA_INFO_KIND, type,
-         strlen(type));
+         strlen(type) + 1);
```

This is the right fix. Here's why:

**1. Kernel Policy Requires NLA_STRING**

In `rtnetlink.c:2264`:
```c
[IFLA_INFO_KIND]	= { .type = NLA_STRING },
```

The `NLA_STRING` type expects a null-terminated string. The netlink validation layer checks that the last byte is `'\0'`.

**2. Kernel Size Calculation Includes Null Terminator**

In `rtnetlink.c:730` (`rtnl_link_get_size()`):
```c
nla_total_size(strlen(ops->kind) + 1);  /* IFLA_INFO_KIND */
```

The kernel explicitly accounts for `strlen + 1` when calculating buffer sizes for outbound messages.

**3. Kernel Uses `nla_put_string()` for Outbound**

In `rtnetlink.c:889`:
```c
nla_put_string(skb, IFLA_INFO_KIND, ops->kind)
```

`nla_put_string()` includes the null terminator, so kernel-to-userspace messages include it.

**4. Why It Worked Before (Probably)**

The current code likely "works" by accident due to netlink's 4-byte alignment requirements. When `addattr_l()` adds an attribute, padding bytes are typically zeroed. For most type strings, the padding happens to provide the null terminator. But this is unreliable:
- If `strlen(type) % 4 == 0`, no padding is added
- Different `addattr_l` implementations may not zero padding

**5. Contrast with IFLA_IFALIAS**

Interestingly, `IFLA_IFALIAS` at line 796-797 also uses `strlen()` without `+1`, but that's actually correct because the kernel explicitly treats it as `NLA_BINARY` (see `rtnetlink.c:2218-2221`) and uses `nla_len()` directly rather than relying on null termination.

### Minor Comment

The commit message is good - it correctly references the kernel source and includes proper tags. One small enhancement might be to note that this has worked by luck due to alignment padding, but that's optional.

**Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>**

