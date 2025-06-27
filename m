Return-Path: <netdev+bounces-201999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B61AEBE8D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597BF4A7C12
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BB82EACEE;
	Fri, 27 Jun 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CQLUKHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4905D12E5D
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046297; cv=none; b=PV2zDt9dlUykUSvrk3KVoIw5ksUTd665W/I9P9NRUTwGwnrWIrRAnEsjsefyZYaNTvlHdg8r9b2uJMncR4XQMhIhxwGCfbeHBS21gNbubcgDuJjmRb928ZA502sDDx6XQ+dppqiJlGzEhW6dJXWDkYG55GLZCwsdE+HChI4vCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046297; c=relaxed/simple;
	bh=kWzRDHISl2n7u7+N9xyprVUwMv2G8vCjAyGGCmB1wBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etMDk0/pUL4a57u9BBWnsb7cSZ6ZvkQ15lYBE5A3tgRUGOUqaFSxt6J+Kyu2ffusp5tnMkbiA2frCS4ey8BfWkxjeg7T5BBSrE7J2ReWWN3A6kr1nMRUj/MhfRRZMKpa6K84VelKMqJdZDFnEYrcyRFSLCNp7inE7iaCxEqB0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CQLUKHd; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31c84b8052so3168053a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751046295; x=1751651095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWzRDHISl2n7u7+N9xyprVUwMv2G8vCjAyGGCmB1wBM=;
        b=1CQLUKHdr+Zk6v3bbvqA9zKvsn2waHbY77ywCnpEtriDIQOdyxChXWe+3KWDMuN3l3
         VBn5Uoifz31mNWEOUB7fM3gL/YFjilbUS1j8zgtrRvRU/F9T+3Zpzy8TBwh+HtSxI4eD
         QQOsMtCiVlXOUe8VURgmdMRFuK9yVcPqfV5KUhM15N2kpTV5VI6x4Jr0juWz71wlgo+8
         1mIGp7FKuVUWfROQAFzPNDDqosd+G9wfXBK2iz/4mrioiB4lmPMTnbnc5bO/zvKP05BB
         CvxiPOZYS3ON3qeVyF2C2/5XA7k1GN4AUd3hhaIFAjmTgcNPCvsXZv6Sy78bNblFmNsn
         n9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046295; x=1751651095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWzRDHISl2n7u7+N9xyprVUwMv2G8vCjAyGGCmB1wBM=;
        b=dnWOwqo7tCUm/9g/ja1cNHbiCJno/qkbWE86m2vX2bFP/xU8nZ2iE29wzfUQlKRHB0
         vU6kzkJe5OkSaDvBOiYLEJKp0+9LmpgN/OmcNDV14BeMjsy43cJL25a7+5bj3fa9oO6b
         d7i/eHvR4uz+Q530Um4ukciax9gti+WClebognfleModaVI6c/yZtSng8dektXKv9ffS
         cqRKHWExmZ8CIQzrGtaMzb2+FOqMu+X//1e/KhVy0CFSK59LZc/0HROO5+FA8R0onUoH
         CunWZxXUVZbSL2P2nd4fZh3VYjHM7zEulIiWv8cXStayKQG9t+4TmOC4Q932OW08XCr+
         zE8w==
X-Forwarded-Encrypted: i=1; AJvYcCUxwkzsVcYkM/vHfNWoBVcs7wkeyZzs2ihnjH7HqSVXB2+5riFyPdMYcHXRxhvNJ4Ux37W6J+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKs0V1fchwpjZFQYz/teD3I62OOe+TJQlCnVjw6FVxesllU8b
	to94M35eUMpF1Q12Z78ifam7WLL7vGoo6aNkmj3x7LEZA19rGmRr6meWSbnCXzKb4+ON6C+7GaU
	NWLH4DueRtYBw+SpYxWLKFIm2BHG52JVBRHJet/nw
X-Gm-Gg: ASbGncvh6bANdh3aGFaW8es3+OwVEXz7+QzU9JEd1Ed5Km6q72N8tDbzPlSB0Ye9133
	OYddykHUyf/g2d9QmepUyZWzYZphL5W7gcZ8XKfl9XoDrxt03UQZDwhZgZ6IHtxNh5JQHYvsIvM
	0oMuipZEVkyZ7u9XfYGLxvEuWqvcP8U4su3tm4ux3JFWf1RW8gsurf//XnhzDQxUm3DYNSPbiJ5
	A==
X-Google-Smtp-Source: AGHT+IF19bEy0XSe+Y+SHUWfSds9G1HwJFQ9cnY4hAWR0U6fC0yvK6FLKnZtcJ6tnUlKURIpw0ajvJQNG0moQpDgJ68=
X-Received: by 2002:a17:90b:5708:b0:312:db8f:9a09 with SMTP id
 98e67ed59e1d1-318c8fef4ffmr6349580a91.14.1751046294764; Fri, 27 Jun 2025
 10:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-4-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 10:44:43 -0700
X-Gm-Features: Ac12FXwibw9hW58F30oC8jkzdO48vA_ZiBtESezWjGFk-40hI7dM-Mw3y-ukqdc
Message-ID: <CAAVpQUCF51TywfACHKFRhg7Y_r9piiX02=hM7m-cf-=0ieW2rQ@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] net: dst: annotate data-races around dst->lastuse
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> (dst_entry)->lastuse is read and written locklessly,
> add corresponding annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

