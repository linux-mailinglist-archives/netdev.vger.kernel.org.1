Return-Path: <netdev+bounces-121642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A889295DD12
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BBEB21BAA
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79F152E12;
	Sat, 24 Aug 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inNO3Ie8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6538FB0
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724489729; cv=none; b=E9M4AiM0W0FuIZLJua0oMIIOwsx+pOs8JHUh05H7CWKqC9Oit6GpV/DhSUyaAfiDe/pa1UEtT0MHvhiDXGBA/d5RkMoGbQdlLBcfrP562+1p2iYiDtvNFiPUqgCX+gvH9kpNoCh1GjhzTv8CRfAiazeyujBi2F8IA9qsISXsZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724489729; c=relaxed/simple;
	bh=gOYIO37ACQYNQDZkx5KGsQM293glOt31TfsPyhtRVLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+wGy1RBPvjL2t4VOemk205BQ/u5BbdZ9yVgbCgoqXBkbKei6OfUzOIJ45yvrv3yEeRN+XESUXQAmP5Evstt0/r53DCHzQWlKSyfX6obrJrq7BH760osVV9d7Pw6WTjTE0gahgLO2RFJsu2ce/Jx5TIFj3OmkLBpHyktRluTWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inNO3Ie8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86b46c4831so59472766b.1
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724489726; x=1725094526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOYIO37ACQYNQDZkx5KGsQM293glOt31TfsPyhtRVLE=;
        b=inNO3Ie8ew9NqgcBqVQNteYqxZBNcjIyQdSsTqzXCWO1/8P1zEyW3HUZXUvBgUbZG6
         IabqVCHgP5zCJbG7EQtJ+py5T8vy2dt1Ce2FBJCQZn4ULwwwNoZWSL3Eb6X81P2JFgLQ
         prXqHyYp/8sqBHOgoNsJqwpsFKr5wqxwwFWC5UVX2T3CQ4/DiYOZhOmDeru/bRGZz3Y+
         PHPvNzrpOEuTfypSwx63dnqXfKko1JYoreeViwSAbzGMeSom3mdzwgZ5ata7zZSJr4sC
         0ICK8ADZ1Ke1yG039kEZtl9nBkLhtYysDpenb+ZEJdgxXZe6etXC9YoNE6JuNqxf9mY6
         7y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724489726; x=1725094526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOYIO37ACQYNQDZkx5KGsQM293glOt31TfsPyhtRVLE=;
        b=iRiw7SMlNAiGvZNby3xGJsD00yEkYZyLvnQIwYUXwTZV1OH2qM6g8W1GaqD9oWKbAD
         79JArUQ4K7AkLe7m/RM1RNa6Q1o8ESjw+zG8mY+mLHyMGqYbUJou0CY4oZN+5/VvZV1a
         FRVemmhdWx/Qh8nZnCHRguSLH1GOqff1PRtdi9F93vA7Vt7jI11vODyeLT1sNzoa9Tjx
         zU97laBQNvc8EVCVhzfMAeS9VTUAR5VI5ibpoiFZU9iWoKnCa+6CyTJy81fkdXsle2Jo
         Ki5pb8NyN8ii+WCIpPl++x4i1J0lx5VDxVLyXa+7VGGaXcgwtHa8SDRfwYXO1VgP8BUy
         bPhw==
X-Gm-Message-State: AOJu0YzITu1FZMdGYzOSjtiQxsRXGJrSVZ3D4ft6yRt4H01C3Vf+Qcjn
	6nC4pn/0+PMXIdVsolUB4qKQLpaWHfJcPo8bvHcJnky1NGgjz+a28PzT09SYUjl7/7ErXkkFqtl
	t5Ic/IMVfSUxSzcWaP6mxCVpZy3WtFNSPWmRy
X-Google-Smtp-Source: AGHT+IEXKYS3mh8V/QCvTHnEuIp2hTfF4pSOwq4qmHfbzHN75ZZT/pLMTw06iM6ESCWMn9myppSvlL2hCh2bIbLrG0M=
X-Received: by 2002:a17:907:94c2:b0:a86:6968:3b93 with SMTP id
 a640c23a62f3a-a86a52cc30bmr283151766b.33.1724489724964; Sat, 24 Aug 2024
 01:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823211902.143210-1-jmaloy@redhat.com> <20240823211902.143210-2-jmaloy@redhat.com>
In-Reply-To: <20240823211902.143210-2-jmaloy@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Aug 2024 10:55:12 +0200
Message-ID: <CANn89iJHPN_DfyMOGUT1OYQWD4S0bz6yjDcyMnDKb-fw_=YkKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:19=E2=80=AFPM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> When we added the SO_PEEK_OFF socket option to TCP we forgot
> to add it even for TCP on IPv6.
>
> We do that here.
>
> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Tested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

