Return-Path: <netdev+bounces-230149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C6BE478D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA04F9A6F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4E32D0CC;
	Thu, 16 Oct 2025 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="EUBa4sU+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2632D0D7
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630868; cv=none; b=rdnkGxzZvmeVUZVgiSqdpHzDWmSTsULMS/CtN8bZvYR01aTxwI52Kq84siODaYLNVky5UbqDSBN/5b9mCxzmtx0F08jdXZXhO9jNf+kqbqCwcz4/+iJ3g/+NCNWiP8r8uZYmz/K+JQPO9fkoxzJZwS5zuxRt4a71pTujD8uO7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630868; c=relaxed/simple;
	bh=zfeKjgA6iJPt3E2LkiwulJK/Ai9g8+9EALGPZe47a1g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=u0tj5i058JaPOWpOC/9OIIuX5NUSje31r2UId2f8VIg7V9mvgXS/w+rrFPkNybrG/fcJ/z9LvQ2NwfKjYPMVYfQl+TBInDWp+mQB6yimeRSjRzH/UshgEF1hRbHBlOcKVTDiKXv051a0J+os4XrcFztkyorHv84tOGVHVOP9ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=EUBa4sU+; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:To:
	Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zfeKjgA6iJPt3E2LkiwulJK/Ai9g8+9EALGPZe47a1g=; t=1760630866; x=1761494866; 
	b=EUBa4sU+hPDY1zauEknkV1ynrBa58N0/3fCIQI8gj9nUI4qV2jJQMiVRCZZHESbLE2jTH1CQ4tv
	t1CJEXLy5SmWw9X5JWUYn+xHYISr0Fo7dW9+jXj99Nto/vtKsUfIrUGX7X2iFYS4SY1R6of9RfUfa
	PPA7jRVmoLAE6LBO40ct1NfRycGxsLq0JJUICCi2XJXqF550eD3KsIV1fs+0QBC8/fTYLKY/cMJZB
	ufoUa3rHwVqA/jbXqTF1ae4cVhh7dJNBYN7obZ1SqDc+pM18Jh9GmknfxobhRR6ksFb2S1lYoNIN5
	KqXF3PrUsKgStIYTlPzB03gVsKJIF1ONNj6Q==;
Received: from mail-oa1-f49.google.com ([209.85.160.49]:46193)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1v9QW1-0006Ji-0Q
	for netdev@vger.kernel.org; Thu, 16 Oct 2025 09:07:45 -0700
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3c9662c5fb1so344830fac.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:07:44 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx2NsJs/LDB4H0AsEMzNX5WNtPU4cG23wdUFP6Hl5PK9oYpmSKW
	JgsGGBArOhLoSL4pBL2fFu+uUWvtewiRf6CbBCIbZmD2Z0Dl7npdjc391CWTRoPgJTPFJeot2W2
	bh5/Bh8HbWT08q/S8Cs2Qup/wgOFdqXo=
X-Google-Smtp-Source: AGHT+IEQxXjybBRheDRtSCSWwdpq7oleQCZ0nxgFzZmzopnIUMIf+ILNfjpzj0rUYekINdtqlLUVAmYJf8WC0DOjJQ8=
X-Received: by 2002:a05:6871:81f:b0:37e:b2e3:dae4 with SMTP id
 586e51a60fabf-3c98cfa81d3mr140051fac.13.1760630864398; Thu, 16 Oct 2025
 09:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 16 Oct 2025 09:07:09 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwrPr46Ju-ZiLa7prnNFAcGr7Hu-vpk1B6-Q9Ks8fu8wQ@mail.gmail.com>
X-Gm-Features: AS18NWCP3rJXwvvBWrvwvHmzkGRhz3UR1veKXsYpgFHB2AE65Ia8Xra4qrKOquY
Message-ID: <CAGXJAmwrPr46Ju-ZiLa7prnNFAcGr7Hu-vpk1B6-Q9Ks8fu8wQ@mail.gmail.com>
Subject: Build commit for Patchwork?
To: Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Scan-Signature: c34b9e52c8715c7e60548704bd659ba6

Is there a way to tell which commit Patchwork uses for its builds?

Patchwork builds are generating this error:

=E2=80=98struct flowi_common=E2=80=99 has no member named =E2=80=98flowic_t=
os=E2=80=99; did you mean
=E2=80=98flowic_oif=E2=80=99?

(https://netdev.bots.linux.dev/static/nipa/1012035/14269094/build_32bit/std=
err)

but the member flowic_tos seems to be present in all recent commits
that I can find.

-John-

