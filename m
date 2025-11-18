Return-Path: <netdev+bounces-239362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08465C6734E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B61FE4E154E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9B212D7C;
	Tue, 18 Nov 2025 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVxYJQwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37519ABD8
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438565; cv=none; b=XPgQl/oag3ivThKkLhNH0ZB1DgBZE9UDrffaLwNeAcxU+fpzEllYqx2VXOmxJUoC2O1Res6t100SRe1JsRlcMzCjSXQ41d+Xi92WNN/obZgoUzqAnj2ASSZVqL0IVqB8imjLszRIsj1HyWkZIF2EW2zR2Ek83MoeSJi7qENtdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438565; c=relaxed/simple;
	bh=RFsW/ISvJmEe3vrsgz0yt876aDCO02L1imxedp/3SjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EC+/l0y0UlWRazSrb5vF4pqrffoyc1BtLjSeguuTvXbVlzw/lpKnZDJCb5w/281eq+JhyODfYaJP82jsDuVSe5usG7KpbPC6GwMf0GMSfEvxL+CJbkEBNR7AVka+KoGJXmtwRxqTA+vIRQ/8bQbEpqFUVRPSszId+UmXted2SEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVxYJQwD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29844c68068so50617275ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 20:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763438563; x=1764043363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFsW/ISvJmEe3vrsgz0yt876aDCO02L1imxedp/3SjM=;
        b=pVxYJQwDh4br75TI4wyXhrLXYY6so85n8V7liVCN5QA0jd3+Zu1oo7OlKEX78tgdBl
         rfF+KhKJ+X3Dn+ihp9RZMJVyo///Gc5lf/EZic5lf3vvUqhj/WO1jTMfU9eRAl2YBGa9
         jUVjgb6D7UDtf8v1zHcCDWz/aP1+h3Udb30x6eVs5vX7v10xfQskhNAmY5j0YzKTC+QA
         L/1YoFsC43Eb5ZVWZ8poSeQJhscLNzpKe1HYnbaC11DtFd1D4bZQgZCuC0KOFWhAz0xu
         1E43EIjsZm7ZOh9uSnA6qeylQLNxQ3Uec6nHlG7q1W+DVrBDO6lYXP/I8Egpel8xyoz7
         kG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763438563; x=1764043363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFsW/ISvJmEe3vrsgz0yt876aDCO02L1imxedp/3SjM=;
        b=dAx5YZDgCF2rHsu4WS1CgWNsQyVm6R5pVIUN+NiHCaevnoQTg65q1wkJHMNFGEOTbh
         PDFJRJZQGVvrNTbeRVIFrLDi4n5a3/wbaGKhDkf3cw+tz39s8I817IBwBPYG2vLatXL8
         0kKGetiC3d0QxvoTi/VAOSVNEsmM/faZ64p/hSbpWUcnTD+vP97hdEpT25JK2C3+w1Jh
         PnADBbq9WSgJkXcBxgyr94/37F1GnD1qpihtbxc1rOIB1ABkGM3/P1/qI2rXzfrFfLMx
         hkJ+1j4D5doPlZDfHuAbRTU4zxeuyJD35YxUZSE2gm8Dgmj1Jm8XpWC49ZSah+z76tYx
         hafw==
X-Forwarded-Encrypted: i=1; AJvYcCWAnKZdwQfswrNcrT69cbsOA5CXUwXKPcX76D7HXSIaJcHDm8/s0dwM4mqGZ+vvRTHed7mtgpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tLnhN12gyTAZ1l3/2lm1xozO1gCqiTEKnzqRhNzfJR8GRCGh
	iTnw1oNAzMutHMTzfxvBO8tORQrdqQZrgq9ZidSzRiogRM24VwESgJ5zTyFqmgxcafseDIJ9VHh
	gZQpZVFm1CL9iDoBp5H168avkyU9sAwnRo0NXzS0Z
X-Gm-Gg: ASbGncskcEAeT3l29OBaRwv1as+G5a+xwruuSoYbVJiGB8qhu0c+Yp7RZ1YUcORXfy9
	IYUL7TAOc3c1I0YgCKXjhRZ0MNC6w6bs1Pl6wLJt76wtryj38V25No+By+nXEmlAuchOSix3Xcd
	pjZJ1QGZn7TO4pSBuSjsAWijW4ySiiMwKmpztSK6aNJhM9bJMWl3eh2UERGzOCGafiHzewy09Tg
	WwBAw5D5ch2HTSNg/jR6TckkZN4a/zyqndeeVPQsC6oZOMdZGvFTw1BLR0UNo0sikKUXfDuHTVU
	0jflzpugUyjiDWSlfpgAV6fu2AAUnu2XNzESpg==
X-Google-Smtp-Source: AGHT+IGn3dvn9ZYnx1dOpbGASnBPqp/vwu0T+Hlgw8PGmzGYlPMUeqTzwcil8nMhJApqhhaay8XIDDRDWOGVtV3qtXQ=
X-Received: by 2002:a05:7022:ec0b:b0:119:e56b:9590 with SMTP id
 a92af1059eb24-11b410f578fmr8937165c88.21.1763438562719; Mon, 17 Nov 2025
 20:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-2-edumazet@google.com>
In-Reply-To: <20251116202717.1542829-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 17 Nov 2025 20:02:31 -0800
X-Gm-Features: AWmQ_bnYqlN97XdOCc5JZDFpAgbCrOX8LgM-KRignLp6wfGA2bx92iSjRyuHa2g
Message-ID: <CAAVpQUAr7WBfN3QbFkKt_D_jK3CypWU1LCqNrGvXOT7yMqdoFg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] net: add a new @alloc parameter to napi_skb_cache_get()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 12:27=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> We want to be able in the series last patch to get an skb from
> napi_skb_cache from process context, if there is one available.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

