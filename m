Return-Path: <netdev+bounces-214924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A25B2BE84
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588B21888AAC
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056931E104;
	Tue, 19 Aug 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YSM1HVVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5C31CA68
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598082; cv=none; b=Clodn1d2loqAaCs3wsdcl9kFY02BR3czPYBG+irob1mxdhbH7FKP7ltIBk4TZuQ+PcVi5XpAxTt5TT1b0JZugefoRYZodZ+UN77fdXjOVEqIPo1WNQyrAC56hP/tBXhscR/QbFSbrS+Jusgv6mZjwmrxbwu0JG67sPZt4K9hOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598082; c=relaxed/simple;
	bh=lfdDwgwmbdoZPKO2L6guIJGA/JQk9g1JYnAbMgcu9lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oYjuGOQr4l8NvIeMrtbDRYSyXRCWE25IRby5bBTV4Tw7eEijpQ0HIF6rTZpGYZAVz7csGHmK4RbHzWyri1Rp5ZHngtO40LmDVbUPr7C8204fGeRd5bt/sn3thIemY8d7V4Yp9WUONWl0pWNejNKn90yt+eiI1c1pwP4FgZR9OL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YSM1HVVR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso6190965a12.2
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755598079; x=1756202879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfdDwgwmbdoZPKO2L6guIJGA/JQk9g1JYnAbMgcu9lY=;
        b=YSM1HVVR2IwClTvxZhYntK4MlOAr3jtZH16NImleFeFnyeOvwtiX3OXvFZgHdM+K3f
         iOFzXjRm1yxpiq8Ez1LpiJfZ+jsfQUgUaWxYJf+dTlkHww+C47lZTzmmbEuistE7ZO02
         pkuvCN+b4gGyC4oEsB9eWVlmGlmcqM88PNm9S7FQbffNmpR8dBbVNae/NAYPcTWhRa/f
         grce0MJ4Tn0Zkl0Dhh2j07e7ADZrBJnIEZ5ryR7zKY4VY32kqFl7d+YBSBvCP+LV2cA0
         UgZjvFS6Sx5PCCGzOFDlc1J98wk81I45xXc7jd01BhokjjjnpUwpIjWuYqAsuX0n81iO
         Q7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598079; x=1756202879;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfdDwgwmbdoZPKO2L6guIJGA/JQk9g1JYnAbMgcu9lY=;
        b=NxdIaXFcgjpIf9XH/fQ/syBT660+pUKAIAvIDXZ1BF1nIfhaX9BMrqT2/vQbqRWpnc
         SHy7yuYO+gRsFq+p6IpNIH87W1TeZ7Dmyq6VfSutw/tHtFYwV30bjYhvKUrPDDUFAKBI
         JZcAQCl1gQjOodoaCzUz2lFqXhUqIStbyvL0acokz+vvwZN/PkCbc3chkcgHkE7b6TKI
         w9zSMkcXIZqGwATwF4MIcjyU6Wv4HQurOVMtAHI2RjJSUGqz5aLtmDQPhfH0IOeB1/hM
         YdXk50nCW66B1kiTKVDpVrMZb4gCeJM3zUYbBOB+R6uobCYcKrsd4AX6aLc0w27d+/Eg
         yNkw==
X-Forwarded-Encrypted: i=1; AJvYcCUSp7dyCs7Ay6bK1VDxVNqEnoFNZ0DfYYbxjNLh3o7KZF0uyfyDaT9xjjJnYQEpFOrOX3FLpD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfCzY2UQXsM1yEtdfyxa6AtXVJjAp9T2Svql8a4NmIJpXekhE
	mY/9CSoh6WLDbSzAniqg18MgctjcUfnhrU6UJRk9uLlXm9cABh8ncmEbxLt8fwi4SsY=
X-Gm-Gg: ASbGnctMvyQIO44Ib8n1h3XqIQLB83K1uOStyAnPp71F97DvJ4q9MTOjIGTLtYbkHo8
	/TvzWtwk/XFhMhbia9OG4NFBZOJIMawtN4D0gu1NHmqz7dt6DiVPA6NVhrV5eACYpM3kuv1vUwy
	DZJ6ba2nRkNqWv3szSuIPaF0uCGBgvpGNKJNMFnn2GzrAdL+f7MfTLERmfiERpG7xjnQzsRXmlr
	szqnqqOMk881sgj3LZpHOBQPNBrSzXsSZXeffvpduO3qtUCs3ixy1xjDWqV8Qg852sbBbTWfFrY
	b+VVzDTZPk0bAYMLaHgzhyXr8ZN/LGDnGcSusi3bFXTFvegf/1kYKMMQiMA/FmsZn/vngqNH0ih
	uNC84ASMsHvsr3qQ=
X-Google-Smtp-Source: AGHT+IGwCYDOFfKh5eQnDdJl6GKcu+lBoEyCWS/tcJJzvzPXIE34XsK/D5uXtEjIisAOPggDgVEZ2w==
X-Received: by 2002:a05:6402:524d:b0:617:dc54:d808 with SMTP id 4fb4d7f45d1cf-61a7e6d99b2mr1459711a12.3.1755598079463;
        Tue, 19 Aug 2025 03:07:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a758c0e6fsm1503523a12.57.2025.08.19.03.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:07:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,  andrii@kernel.org,  arthur@arthurfabre.com,
  daniel@iogearbox.net,  eddyz87@gmail.com,  edumazet@google.com,
  kuba@kernel.org,  hawk@kernel.org,  jbrandeburg@cloudflare.com,
  joannelkoong@gmail.com,  lorenzo@kernel.org,  martin.lau@linux.dev,
  thoiland@redhat.com,  yan@cloudflare.com,  kernel-team@cloudflare.com,
  netdev@vger.kernel.org,  sdf@fomichev.me
Subject: Re: [PATCH bpf-next v7 0/9] Add a dynptr type for skb metadata for
 TC BPF
In-Reply-To: <175554964898.2904664.15930245053733821413.git-patchwork-notify@kernel.org>
	(patchwork-bot's message of "Mon, 18 Aug 2025 20:40:48 +0000")
References: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
	<175554964898.2904664.15930245053733821413.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 12:07:57 +0200
Message-ID: <87ldnfzksi.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 08:40 PM GMT, patchwork-bot+netdevbpf@kernel.org wr=
ote:
> This series was applied to bpf/bpf-next.git (master)
> by Martin KaFai Lau <martin.lau@kernel.org>:

Now the real work begins =F0=9F=98=85

