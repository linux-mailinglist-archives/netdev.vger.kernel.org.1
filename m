Return-Path: <netdev+bounces-184126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1EA93641
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C387B35B9
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA331274646;
	Fri, 18 Apr 2025 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0JAdx3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AF274FD7
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974009; cv=none; b=L6tel+GvCXxIWVyNBI/8FmI8VqoT2RabMLX3SG8n+dQdOUpkEHx94xA49DB+keqaGN12oRwwXK/r0ZUWx1LxiXvf+Oqg3bFDpLzno/0fAjsgw91PjBcmRR4aST/V7a2GXWs42m7S3HyoWNWgXgnFgzhrzp3J9GZDxPm1pxMf9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974009; c=relaxed/simple;
	bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=WnZd/eZ5nuQ6xCzX81AG2R+oleDFGnWfuof380RyEvy4uX6oOBxTmqhBlK4WI9lqOkQsVg+gOTxBLowOotkLbROVbnMRiFn3N5AuQUdDIiHPgicMQvbEMy4TKl/daZPGqbI6sZJwKnoi+irV6H9iWDqJyMBkE15a8bFAP7BWlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0JAdx3p; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso14407225e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744974006; x=1745578806; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=J0JAdx3poTxS8B/iHgpqmuIKeATYKAvmAQn48up2ojnZ5MwccMwvgbMENs8Mrbzi2M
         JgYkzWVRKSOIm9PNMNfOEA11FNB3vxWtAtP+XLL+QQVMasGJpy4OxjmFkBGtEZ337Kng
         kKp6kHV51CsqS05tlzNBAEmjxQ4gplMwgj5dDK9j05+/daZy2fMN+t9CZ0/gzNacWk9B
         4IADVy2TJCC5JnhM+e70rRTdgF/6HsEM3mB6KI1CYAYZze6Ja/DC238WmBx3IhyxKXXd
         Wh9ZpuMEL1JpnfdFJLTjEy+iobk68+4xy7agD5D/LpSvvNf201LYxy2xPnSEXdEsO8S9
         9jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974006; x=1745578806;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=PdOGLwGCC7lDaAjeiMe1Jl8tC9yrmPw+xocxE7/uXo1ECgJcbzVKU9KxlG9i7n8wCQ
         U7Hb7HMMLXDXginXNtCcOMnkM0a6ApCXPZM+r5YSiLzUKGZ4blqD6bxBhi6lYNqMKfs8
         Rj3GAnZwRzuyuVsweXlDjXTacaNGPdj4w7LjbnIn/YfUNjsgbtDSPnRb4d0OXq2lftcy
         6zwZD6Bq3vcUb1amX+/zpepvxDPGTh5fhq+dRFRzQVhd+jspABrOcg3uTNoGAlwiC64B
         ghVcSB/M0OMNjjotln02gmVj2YSHFm4/oR8CyaGAECseAoadFzu260bicbZD3f7KAs5S
         SsTg==
X-Forwarded-Encrypted: i=1; AJvYcCUmhu1ZkBg1kuvw0C5lQ7a8cAaqg5iNFS6GZmRD1KYjaqLqZ1TLMjiv3YEzySqW0td4OHQKoK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPWYnk0RvPsdnzC13vTu6PGvW10RQQHy/GjH8xpvyDvLJwu1q
	r7yu9Pay/m6IGCNw4ylyiWhVEJx+Hmh+Ufpm1Z2HLXwDIPNyoCqc
X-Gm-Gg: ASbGncsNyNJrbriJPXV9EH+vE4Uv4DnV4drefqSGdVNv9RFOHL2eRLnpMTpJPiArGYx
	7gaLhYseZG0jVj8zoCqquziDIS465AR4BYi+3CBZXcB8dE54jYCdXS4Wa28qD7aGKNoKxTLBACJ
	Ua6Z1BEqmaO9Nxi1EJcrbgM6L2AwrozMuh6dEYLt14delqfCQHUtpoUH+cwjnZeJ+S2tLMyKYQQ
	NI74AoULbfvikeR4PZNex4ovP7IQFWANrR7glOUM5m2riIBr+x3uyd6RwVIxZh6S9QLu+XrstDz
	wpX29DLVLDgW64txU8jnoIztzZ+YE+9kqo6jfisG5UX2RtiW0fGaCkyLwCddFqUK0qHRv9PXPPi
	um6X/OZ0HnCyU
X-Google-Smtp-Source: AGHT+IGujPx6eczG3q1kNzRSUkPCTwzclwIUTgr4vmBCNdJOVX5azEDc0Z9YD0GXccnloIGIR4m5kg==
X-Received: by 2002:a05:600c:1c9d:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-4406ab93b95mr17915285e9.11.1744974006127;
        Fri, 18 Apr 2025 04:00:06 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9ecesm18222305e9.2.2025.04.18.04.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:00:05 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 09/12] netlink: specs: rt-neigh: add C naming info
In-Reply-To: <20250418021706.1967583-10-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:17:03 -0700")
Date: Fri, 18 Apr 2025 11:42:56 +0100
Message-ID: <m2bjstiwcv.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-10-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add properties needed for C codegen to match names with uAPI headers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

