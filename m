Return-Path: <netdev+bounces-207406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (unknown [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFEFB0708E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61D81897062
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89D299A8A;
	Wed, 16 Jul 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUoGGzIt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809929B77C;
	Wed, 16 Jul 2025 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654567; cv=none; b=pAO01sA3qOMoxHzmBsF7s+Qx13pdp/Ds+TQpz74WYTLFBXX0xCQs73pPy6y0DUmfpEMSZniTBnY+8Yk+TVcfM4f/qMvgcPWUuqYTG3zxlMY6W1yKlehJ0xwuPWahlf4RCmzrcp32sHcJEmKTFd73ep1KW6PRiL+pvFb0FnB2abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654567; c=relaxed/simple;
	bh=ZzTPxrTjTtBIHf8L+7YFcQilbdSi+0RyWcQVSrkPnNk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Rb7oamGAj6Rd7ojqlZiOPg6vzD4zbaFnwmwdlrOEwgmF8NRykwM3uLRxGmYH4MWqZH7JA7SWTdCyO3mbexJR4xckUTUzpuBSS5YH4QJmQgTyLGlh63Uit7ZBOosXO2Kjz7jYDPvmEpw8IsOQbFQxHW/Ys6EhTaF96m7MqUfyT+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUoGGzIt; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5313eff2649so3036635e0c.0;
        Wed, 16 Jul 2025 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752654565; x=1753259365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZzTPxrTjTtBIHf8L+7YFcQilbdSi+0RyWcQVSrkPnNk=;
        b=mUoGGzItDJYgn3NKG6BKAYz1WsU0kkl3rUdkNP5uitk3tJyF2g5hubJ5+sSBQFG+aG
         Mvb0b87SLbEJiD8I9cnnV8FR3YpnYVZtgJVGzUB5Zg5zUfICjG+1iWQqKU7qLww4tYHx
         JDoPH06JH7/xCBRQsOITYfp58wAJXtBCNyazZcbepzN0QL+938R/3HVGqGNhM1EKgLIt
         zG/AWQD9V4pE/Q5RVPv90xxsu6W/j7M0nn7ChjHYbza6VpabFHOggAEV4YSmQO8eOgwI
         ZfcIiW3vaXeNICzQ+rRLgQeac2/5MS5+4VYCdkl4L6IdnNQrBH8A9Z3ob/rpqZkkbNmg
         CWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654565; x=1753259365;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzTPxrTjTtBIHf8L+7YFcQilbdSi+0RyWcQVSrkPnNk=;
        b=XQTRnxCOxnJ8Fwwnn/xeFioezVafOTtaEmGh3zfuTlGa6VIS4CwBKuN0Rmz+l/7YlP
         nefoxKVJD20/JCWbL4+UGEJOX9u8aCsSBXmpy0czlZDdI9dFiAMjgQPAsLmftAYFDA4M
         oRB6wVX0EbbhZuBrieL5P+ynnEZ18leWeEYzOvAeiD6Hkj65fl9UelQ6Yjv4yJqIKODA
         YgoiHGXDtsd+Kl0p7aVmqMBe/I3QApUWzUC4yfev0QW+OpfIi+kTGe4zwhmbEIRaRju2
         gKqVLk2sdvGqT7efoEHaDeoqYk05A60bZyErN1jwWNu3AHnlj9AOksecTA13OHx7y3oK
         vnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIrL8eb25klliUIlwFig2NLXoAGZB4GuKuHWFu61b7C/FmM+T+N6ud1dkgnG1OFDESNRfRDMgx@vger.kernel.org, AJvYcCUwhBBZxIhiq20VxafY+4TJki7LbQ4P7KfLmdlTOC3iHIRywe6l0jW2H/ARap9WgxQyjtf1PVeGbz1L4sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tcLobIZTUbVeYgZqjC7M3fTtt0wjNkgBH93598ndMGWSBGmc
	6BBIA03lfPQR8AYAU8I/ojpD8KCu5AjWfd9zIQQAzqHEKzmXOtz0p3RzinrbA5K7wmBsKfG1v0g
	duJOXS9qlqZG+dhsSsj8pfaMIIwwSa30=
X-Gm-Gg: ASbGnct+66U+X4qnxt+yYIgSyhTx0i8UtH65l9uEiwHh7cc6WsRqGY0xQZQwEXcsRZt
	EC7a4e0g3xFSjPzF8juHJgVbp/nLaVemujnLTmEq+Pn7Mu+ejgK3aP3NRHOQjPbJDt+9yOhb0vb
	S3bmvUuKHd8biublhnooJ2ZsWfMbKJI9ilnaz36UP9ndWYwn1/1btgzPRAV2mhm/E+M/SHOsB6J
	XLaihY=
X-Google-Smtp-Source: AGHT+IEGo1vyPCYVJ17wL6qZjR3idmkb0poP/0pCwqAO9AniuUm4yL8GABztOwz5TXOfzwdu0zG7CfZHdQSr/6m9aI8=
X-Received: by 2002:a05:6122:2024:b0:534:69b3:a200 with SMTP id
 71dfb90a1353d-5373fa4d002mr584684e0c.0.1752654564869; Wed, 16 Jul 2025
 01:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Wed, 16 Jul 2025 16:29:11 +0800
X-Gm-Features: Ac12FXyI9PsX7ghzeNAGmhjVv0lMdsfIGZUE5ddA1QypxdWfSCdIrhxJkmMCGy0
Message-ID: <CAOU40uD8Ogy=bLf6gOK1dVJRNBcW5zMDLnwjiEuipHN8j2TPPQ@mail.gmail.com>
Subject: [BUG] BUG: unable to handle kernel paging request in napi_skb_cache_get
To: davem@davemloft.net
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I discovered a kernel page fault using the Syzkaller framework,
described as BUG: unable to handle kernel paging request. This issue
was reproduced on kernel version 6.16.0-rc5.

From the dmesg log, the crash occurs directly within the
napi_skb_cache_get function (net/core/skbuff.c:295) during the network
softirq context. The page fault itself (#PF: error_code(0x000b) -
reserved bit violation) indicates that the kernel tried to write to a
memory address with invalid page table entries, strongly suggesting
memory corruption.

Meanwhile, a second stack trace points to the probable source of
corruption, where kfree is called from the iter_file_splice_write
function (fs/splice.c:767) during a sendfile system call.

This crash is likely caused by the interaction between these two
paths. I suspect this is a use-after-free or double-free
vulnerability. The sendfile/splice path appears to incorrectly free an
SKB, corrupting the memory pool (napi_skb_cache). Subsequently, when
the network receive path attempts to allocate from this corrupted
pool, it receives an invalid pointer, leading to the page fault.

Therefore, I recommend reviewing the SKB lifecycle management in the
sendfile/splice implementation, specifically around
iter_file_splice_write, and its interaction with the NAPI SKB cache.

This can be reproduced on:

HEAD commit:

d7b8f8e20813f0179d8ef519541a3527e7661d3a

report: https://pastebin.com/raw/X5w3B46p

console output : https://pastebin.com/raw/aDMVEtzw

kernel config : https://pastebin.com/raw/xAVw5DnH

C reproducer : https://pastebin.com/raw/Gu48eTDw

Let me know if you need more details or testing.

Best regards,

Xianying

