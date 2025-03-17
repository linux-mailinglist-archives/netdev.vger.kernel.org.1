Return-Path: <netdev+bounces-175212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7846A64603
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3AE167334
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363521D5AA;
	Mon, 17 Mar 2025 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMiJ+V9B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071F8634E
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201006; cv=none; b=PUtvOANq1si3RI1lsaqrN0jAs7fEWQtW52FjSMZaAE2UT8j+lmQPT0p/mJLq4uNsQ625TgJ5L6nNG01nqVj/m0OClJMxegsONbVjftWt05xFZ1wJeKYGvol/f5vpLoJl/ZEaEPglxQLwgAqnraSwvaeBSCFzXdELfDcf7cX/x8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201006; c=relaxed/simple;
	bh=jKqD/YoPFN7pfs2ez1ejUc1t58bcyl73PUrMnfn493w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyBZkzwfdZvX/L+6aav+4FtDH/ETT6ZnnSbByb952b/cCgGr4ySrgHn4IQj+z/vVjC8Wkz1mpaRUF2rFemqraN5maYlYitJvfEPTeMaw3xx/2OXCY+n9F6AIlV8WoSyqfU2i6YucDMoYWkoh5cbFskOQilLb1rckiVHVtQccfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMiJ+V9B; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46c8474d8f6so36783801cf.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742201004; x=1742805804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKqD/YoPFN7pfs2ez1ejUc1t58bcyl73PUrMnfn493w=;
        b=LMiJ+V9BfiF+xQhT1tVgprDiIrkE0xVhzHzveWbeVe3qGNscUulxdwwlmS+6H5UdUX
         8U1FOaPlp6hITQxg2gPj0KY8OM49BC1Lati9gDn/lUtwemXmadm/UL0micVkggZ3ag1+
         960o3Meb/ABmsa/S3QBA1U3G2d3OQ6P6kh2Noc/cDv1RqO0HoqK9VwpWp50rFhYDLhDA
         EYeUIken9+6JzdhvSZqm+8xS/LcjYOasj/FsMF1o9H3ABm5obu38K2Qnc9uDMhKTKZXV
         S/DEsenR1Sp5kcXur2zKUKy2P8Lq+Af3F5pHZTDgtclNQitkdXf6lr9cuGDWn+WwI907
         6Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742201004; x=1742805804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKqD/YoPFN7pfs2ez1ejUc1t58bcyl73PUrMnfn493w=;
        b=gg/aSMZk5LVVW+YN1arJ7rRPwzBU6EPSawZxkWnjEmxM29tGx4w38K6qfXiQHGjMX5
         eqbWY6HIM2eKqVNXbzoz1D7RJfgjQYWut7aKIP0yHmDOGa+cOGutSt6MvzpluTHkR8gW
         WfujVtayS8GjpXEg4SN1YEqZrW/hVjh1WPjdpgBJXJFbmabo8cxfyOHimM9KYubL/eDY
         YvW2pmvRLMr6O00HRFjEiwuWtpQ3KdXK3JXYJ22GGViUbWw1TZ6RFLzn9STBZf9EWgcR
         HVblBOnceWK+xywHO2ydKcxWJx/T1oZBLB8F+S8VsZonHtmrh4KM/OGmQv1nf5bFOj2j
         Dv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCULIET1AviLdv7sv6uxNeWDsfSk+sbgTFp8ZGADd/OtMwNQg0ZaCUJ/C5KXc1DZEpnu8pvPvrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09mg/xgP4NJj58kL3OtzLHoM74V4Zt49rzw9aQWf+cAst34Iz
	SsCyQec1oUiDApDKVRvAnPGwk99MTu/kbrk2SR4iAOE8ZYJpnmWeoyDsLwNc699VeGbY4LCCiDq
	rTABczNRd9Gn5SMBt/bGVQ1Uj8JOkQG4g5ReY
X-Gm-Gg: ASbGncvGKvyiOwYJX0yO6/uydL0/MsLfDNr3JbCzTYQYmWFiFRCczR3NR6y/Ral6rwW
	RPk6ApOSQEMBwVqU0JP8YPgPMO6VgCFmZOjqDp/ZYCPxB+SFthBmHDkChqr+fwVwqBEsapl78PQ
	rKlwrZiA8xg0AUI6FZtUU7R5CDedk=
X-Google-Smtp-Source: AGHT+IELIWcr7v0YvKghmV47EVmwpL1woGnSU1s/D7o+trf+q/lCy1WSyqiwVhkDghM+BPGZc+XjIl8t5ZHKV+47LaM=
X-Received: by 2002:ac8:7d50:0:b0:474:e711:3c7f with SMTP id
 d75a77b69052e-476c81de526mr147983521cf.43.1742201003671; Mon, 17 Mar 2025
 01:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741957452.git.pabeni@redhat.com> <19ab1d1a4e222833c407002ba5e6c64018d92b3e.1741957452.git.pabeni@redhat.com>
 <Z9Su1r_EE51ErT3w@krikkit> <df7644e4-bb09-4627-9b73-07aeff6b6cd9@redhat.com>
In-Reply-To: <df7644e4-bb09-4627-9b73-07aeff6b6cd9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Mar 2025 09:43:12 +0100
X-Gm-Features: AQ5f1Jp_YLb5ClEafTrkDK1Qp-YKk4t2LLl4G_a5P3nwNvJXbx30bncK4fMSCvY
Message-ID: <CANn89iJZHok-JHiu3bSZQaNSbu4r+yJkXhZ8eoTtk1EaHsR56w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] net: introduce per netns packet chains
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:40=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
> Thanks Sabrina! I'll try to address the above in the next revision.

Could you use dev_net_rcu() instead of dev_net() ?

Thanks !

