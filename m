Return-Path: <netdev+bounces-155686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E584FA03575
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFDB1656E2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85F2A1C9;
	Tue,  7 Jan 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwglupfI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F884501A
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218222; cv=none; b=q/xg8379hOxFhwwE7tJlxh5lbHn5CgN70AkaFdUep3V3JNv2STm5r/OKnWJNXh3lLpvyBEZ5pI4kogrjEe3sSomSGw+m3qFVmG0AOgObSUPf3ELPL5TK8j3lzghruryowW/h8AkF4Y3wcPtLnuCmsAFjAXDNPtIKSApOg5TKDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218222; c=relaxed/simple;
	bh=HmgQRPIs4W/bHiI00t+sEvMm5zSkO9SjZhEt2Y4GpvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8dWT/UCEuVN+AGnf6I6GdBRT8zd2hVeg/kGgL3HI4fMKAE/9FCEjDyAcUUmfkuH0RCxDfdWQd4CTVPmi7F0NyE8+VcPWRWoOMzdEm+ekXZkHFFp/zk5Kg2oTgpoIsZzTJSjwiLMct3XXJuJ1RmcQuj3De60yTc3OQ38/qa73lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwglupfI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467abce2ef9so126401cf.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 18:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736218220; x=1736823020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6rJNgfP55GPm9pMRpkUe6PuBQwo5KjpElSNQhBU1Fk=;
        b=IwglupfIeU5Nu5TEPx8UkieUOlosx3IDkPHUWDPsXf+bHbjzQHB8XY+TxxxcZ6t/57
         sAZVm/ZTMo1qiYkoq5B3dqP7pY/uecEXLeZm+161RRFZDpf7jbgwb8zjuuyy+i3FB0BM
         pKcWwD+dhM/uG6pKuCkoxT0Zhtvv3J+xGJgQFOrjoa3KaDGAdqWQoFq1ls+3x1k7G821
         U8mZPZbavUruXyT8ezHFjz9bPqsRjjWOXNOaPyyiakOjjvtVyfOLzMtXOKgkDdHTolzA
         LwdxxgNqgcPRK6bKoAlAHY87C09S9CMlsV9ZZCsMrrX89Y/JSyKAzKGv/BrDtmK9Oywn
         4BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218220; x=1736823020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6rJNgfP55GPm9pMRpkUe6PuBQwo5KjpElSNQhBU1Fk=;
        b=wTsl1ObTzFMOL8qLtg1EYJhvG1KaxeXUNttGM1bIFFw1jPqITp+2ggwhnXEt01sPIY
         2Qy5QLkbYntp5kn5gkquLX1ndAB2ha4IuynO6zDbtFpsKo30/n50apHj6a2H5oE+OhaH
         hibiJg07BZboSM68/8zOzBVGEqRLnRz4zoUX579ntGxkp9KlxmOkx4c3MK/U65X2pORC
         60e5Tzf11OdbrEvD/9HjnDsdWu5pT1iUKN8epQhczevGfidBk5+aVuK4oc4Vu6tR4jHX
         QuvNUFrmp8Tdqh4wlJsDgjYU1OiUpFQH/OnBP9YQCJW49IIqeph4XAJ2vUnmxYwJl2yu
         MjgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5O50aU+PBA+RGvhs49n33+51hx9RHToFlK9GQoIp7O4dSoGHe2ZtadPSub1jphHksSSyURlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvNeGiujtpRwLgspY4x60UCUpXbpMSAVjkS/kzqK16lt5h0Dx
	QqKcsOeYWlqigDU2/0d8qiZDxdAW841knfWH10wZXKJyiUTgFc2wNXPFbuGxjvC8+0KR32qhYw0
	O6qn5eDCRHctEfbCx8LUJUwbMrtM2r6sruSb5UfyiAoNoOufOw/+b/Mw=
X-Gm-Gg: ASbGncvAssZqifUiyvKlZWkTOqBnVMsq4bnf+4U96O4tWW8ADipOBLNaRtZ8x/FiSfj
	IkiHqNIlPZ+m5RY2/71x5rUPrHP3SLkoM0vcUNVjS0RFYMaiF9pjQxEcUAU0DLV8sQzDrWaM=
X-Google-Smtp-Source: AGHT+IGMqbAfPyzHPARuxlCAd7FXApQR40nmkd7vUxDnSToFn/IXXK9kg/WLlOUrQ2wGpmu+hDKgWjJTc8Hf+x56pw0=
X-Received: by 2002:ac8:7dc3:0:b0:466:9003:aae6 with SMTP id
 d75a77b69052e-46b3b75916emr1600051cf.2.1736218218665; Mon, 06 Jan 2025
 18:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e831515a-3756-40f6-a254-0f075e19996f@icdsoft.com>
 <d1f083ee-9ad2-422c-9278-c50a9fbd8be4@icdsoft.com> <20250106132051.262177da@kernel.org>
In-Reply-To: <20250106132051.262177da@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 6 Jan 2025 21:50:02 -0500
Message-ID: <CADVnQynBPVr0qX2pu7FNwk6Y1BaW-pGf=JReJPCAj9RP=6t9_w@mail.gmail.com>
Subject: Re: Download throttling with kernel 6.6 (in KVM guests)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Teodor Milkov <zimage@icdsoft.com>, netdev@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 4:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 6 Jan 2025 22:15:37 +0200 Teodor Milkov wrote:
> > Hello,
> >
> > Following up on my previous email, I=E2=80=99ve found the issue occurs
> > specifically with the |virtio-net| driver in KVM guests. Switching to
> > the |e1000| driver resolves the slowdown entirely, with no throttling i=
n
> > subsequent downloads.
> >
> > The reproducer and observations remain the same, but this detail might
> > help narrow down the issue.
>
> Let's CC the virtio maintainers, then.
>
> The fact that a 300ms sleep between connections makes the problem
> go away is a bit odd from the networking perspective.
>
> You may need to find a way to automate the test and try to bisect
> it down :( This may help: https://github.com/arighi/virtme-ng

IIUC, from Teodor's earlier message in the thread it sounds like he
was able to bisect the issue; he mentioned that git bisect traced the
regression to the commit:

    dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")

best,
neal

