Return-Path: <netdev+bounces-226919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B3BA62E6
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE426189CC84
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC3223DD0;
	Sat, 27 Sep 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiwM8PM/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0A16A956
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759001983; cv=none; b=svMYNhg+gX17Om+8AUxqCMJCX4j4pyWVcLnP5qpzAkt1Zq6jKQJ99CMpVRJz36eZey5NoAVldhJGoi9GKmMQ2g8NXzWeXrorYB03Bbk/zqpqYbtQaIDiudiCKm5y7sPzrffWiDaiVPRmd0bxCHcjzZL2m6rVg67G2PHE2kHs6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759001983; c=relaxed/simple;
	bh=LLIY98sGB/kYe+4IJhm2aZqtG7IIqezTAbwZJPShZg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avMgo2Z13/s5m0aH5daQIH1XnqKLUMQoY1Ik7WKjMXYLp/4HWyAvhot96G1gLD6+nyNl9xkywXlosvPMQ5JHc3fHqV8A7oV36+MEGVlGzgeridbzuUlRg0RDb9kmzdgb8OIxDqFz0GJafr1oVA+c4D7ceaQKlrtWvLxglWm6rII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiwM8PM/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27edcbcd158so30130805ad.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759001981; x=1759606781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLIY98sGB/kYe+4IJhm2aZqtG7IIqezTAbwZJPShZg0=;
        b=DiwM8PM/L/svz8uyZu6tnKw3Mqz3U1s7EiQ/Y05cUa7zr9BIXW72ot7VcY3M+PT46h
         w7h8qQ+cJAyGNB3aPcTjvE2ebpH27VtLOBuVCGxAU3GMKE09PNr1QbOc855Ixjj0gDRh
         mPjt5nx7QkfpalcfKth66B/hhVnlGsPDVh0nMkFBumPnJus8H2nQ+pyTuwc5+pnPkNnf
         a9cQfnUK+Csh+mXpEKUpnL9Yzfxy0xoK34YyDGFYj8KLByCPPhw6jQBkMOGQEJdXEXhU
         QA6Sw3AtlFbzgjDi98wiLSybqAXKAtYts/iV8spQIGzKRi3lxN3/iprwfZNWrzJT2I+i
         6QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759001981; x=1759606781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLIY98sGB/kYe+4IJhm2aZqtG7IIqezTAbwZJPShZg0=;
        b=toUqVr5GpdC1gLofibMa/JRnMuhJZoYrZDFgaTYC9MywxFaMyzLekJ70S6BgTEtAsz
         rQLRH6itjCcnPgk/zIbLn8KsQ+XyikkRsJEniK/m9FrYd7Okqu7UXWe+Oe+AGjZG4zxV
         wn+ZsCtSbKxxOrElu/Du9onKBgP34i8JsiiK4YH+pAbVYjcnANN8CJKSbEGXkokZjTRv
         8dyIVRYq/kBoVZHaFuTbdpO1bixAatXE3B3EBo0C3NWczmHJUALbh9/Gi/le9qQHTLjG
         /G/36f4BAGs6F7OZYVfKFhgcUGGqGOI1CJF+5Qz3QmiJZs0/Hmj4rrQxL3CWMq7NsxeO
         kB5A==
X-Forwarded-Encrypted: i=1; AJvYcCXQVjSV4TwD6Go7ItvZIi+yJOv9TPxLPikcPii6g4ZJX2CNhzU4fgcn5Jhhw0sKktXcNKkkQv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5OB9Ya16L+mvgsTcVPm76EPq1Z8W/qIyvg6tCpkhBOZiSAlV
	SMwgxG39m5XbxrDtepIN0qvNXdYe1v32HCGYIvbt43dfRkF5wOeqwlVWsUTrb3+PiWF5y54sKvD
	nzC05MmA9/w4Tx/7ok89hsW6HvJyPZ+aJL5KVDmAn
X-Gm-Gg: ASbGncv/qcfVRdwZAAP1r/csSkvBqiD2qNIIJ1WE1bGgW8h4Zn7iL8M8Cw4KqTGCqnU
	Mp+HcMUNgr1uYeFt7UEHKwOHxwb2L/0Y9E5LSV/PU113iFpU0J3+oBxyAWaq04pArXrtxVconJo
	pxU4Img1JvRORUbHvATcGRGFFBZxrVHEldLsMJsUQk42qfmARnWgc1sZMnno/xypG5P74x1FP+B
	IxoBrxS6cPxdGpa7gO7HQxAi3x0dr2O+K9PcucAVKoUC2MYzpp+lgOeuQ==
X-Google-Smtp-Source: AGHT+IFOxA6kIwn1ZAWiekkBM86aptaumQv1gV6xI52KCiSlkIAp8N8abYVs360o2gVKb9S4wT95dPm2UKql5Bc7aO8=
X-Received: by 2002:a17:903:b10:b0:262:d081:96c with SMTP id
 d9443c01a7336-27ed49d2c1dmr144147125ad.17.1759001981050; Sat, 27 Sep 2025
 12:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com> <20250926151304.1897276-2-edumazet@google.com>
In-Reply-To: <20250926151304.1897276-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 27 Sep 2025 12:39:29 -0700
X-Gm-Features: AS18NWA3kVv3ddCwZ-wcYPR7EUErocEHIb760uzxWkWjS3QujoNHNqYokLuFsr0
Message-ID: <CAAVpQUAiooGfYcTLgEA=As0gJj1h3YE0o83h88mpwVVov8G_Yw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: make softnet_data.defer_count an atomic
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:13=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This is preparation work to remove the softnet_data.defer_lock,
> as it is contended on hosts with large number of cores.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

