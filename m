Return-Path: <netdev+bounces-179940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F607A7EF5D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2C3A73C0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C7E19AD89;
	Mon,  7 Apr 2025 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="E66gjG0K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1F212F89
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744058145; cv=none; b=b3gk5GRBbccM4jjjlFE7q2J9DGTtOCPA9gnLeueR8sERb4NgiR+bWDE1yFo9abijIBH8xXwGF1nsLsvf6fM2xIYxUSErdNTkeWVjt4RkxFbxDa1cPPEPK1xjQ+6wr7vZga9ZcMu5IMGPqa8BNK7/k5cG4uIu3BWjRatMAH+R4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744058145; c=relaxed/simple;
	bh=brlCJsbcroy1kU2di+p+fsoXemuFXvZvrP7lfuUmJW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thXDJ3otWR+eNE2KHrvNVkoe04BVwTuTK7a+8QEAWK3eOkuGfdcLo1ymT+H4tKf1No09BnFfVNi/UEBtgbnHeTTJe5flLtIULnkwFTvS1soKi60yfgPNy2Skod75G7th7TIuT54cKDvw32MFZuuwv6byxw81R3pmk77+h5kV6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=E66gjG0K; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227a8cdd241so55495995ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744058142; x=1744662942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brlCJsbcroy1kU2di+p+fsoXemuFXvZvrP7lfuUmJW4=;
        b=E66gjG0KXcRJhl42yskzZ8iZt820JW6qQhwTv1sEt0r2FI2C3rMej8y8/sE9xMSEFB
         r0LixxGxn2HCWcp28XZYOeF9VKMjvgDxwldf3eiwnulxYdByN+pzQy+W0GhdiAEFGL+A
         rF7QuuGZfFER4zgRfbK12JUz8ShazM68boiMFWUun2St6TMLnEge2OG9cfEyu316zaYk
         ZF5vZxdRnG179nNKJMtL4KZBeydv/GyWYyCM9u9GmBJ+62urBHtSe8i0auMMwBM+GJzT
         t2nE7fXVvij3ViUqwX+uTI6EGYJUfTPnR4I7IZUy4xsDFdbWOP+gmj3Le4fONf764PP8
         dCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744058142; x=1744662942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brlCJsbcroy1kU2di+p+fsoXemuFXvZvrP7lfuUmJW4=;
        b=CMf0fmbQnozOHf0GnHaWLyQ4MicOlyAoo94hUTfYAz8eCz9fBTdlxkbbind000+4Dr
         SrqMOpaFYchCfSNds20tTgPvM5yfCUpEqIH1cIQqtLeKcJWWuB7QiGb1whjMsu0byGPx
         8xIkXGejAJ0J4qTYMvuT0BASBydEwJlDOq7Z29jwHFY9DeNH5XrDTROgC8wNmRjATUwQ
         2equVa5qNWD2/hxSsiQevvDwWh2xduwkbdS4A+zCG2mih2JH9qdEKXzbmdTYonJnxP0P
         +jQfUDjbMwplCNZvIudrFox5VLPKjc0HQhuNfloYPCvpl4ZVSAdmdtwHeX/1SKMyK7O9
         m38Q==
X-Gm-Message-State: AOJu0Yx+y9fP/a7iecxukFq/8616gqpe6NEDVCtIVnYKtKLytjSfmNYa
	mOZtkqGl7LjtagYj4mAA3mDKoOF2bKhZBSZUYtdJSFeC6RGfYjn2CWxQy1edBxQWzRfGUyENhMt
	eOt2IPA8m/roDJ7bjptscWuyrcNkxp0VismhyVXSuJDgIma8=
X-Gm-Gg: ASbGncsOIKE22qI5QR9W3URcPQcSHZeqnFr1tHrE3wFiE82a/gzJ1vZurXb1q+aSZ3P
	NEiT1nyo+mNFFa8A6FtEhpOM41TFhSpFMwcE7Kl4ZKq4kWHDW0T0Alz+kP3ItdvelGtZ5mxuzOf
	cACnpPKX3uK46lr+uibpcIQxvNFA==
X-Google-Smtp-Source: AGHT+IG8ea61COcLc6Db1jfdHK+HfBUhmcLGVjDh3Yhp+uoRDahuFWYB+TannGEisYUo/nJhXOFO2UAzbZ/g/t6hKmI=
X-Received: by 2002:a17:902:ebd1:b0:224:8bf:6d81 with SMTP id
 d9443c01a7336-22a9558948emr151798875ad.46.1744058142634; Mon, 07 Apr 2025
 13:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 7 Apr 2025 16:35:29 -0400
X-Gm-Features: ATxdqUEaHfPt8juwD2JVbGKuqEklia8g-loKh_GyR080VD6939q9ZnYScFWHyoU
Message-ID: <CAM0EoMnFXZWhn-c_pLak1FqB=EEBi1-MwsZ_4ka1sPS1C-kFwQ@mail.gmail.com>
Subject: Re: [Patch net v2 00/11] net_sched: make ->qlen_notify() idempotent
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 5:10=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> Gerrard reported a vulnerability exists in fq_codel where manipulating
> the MTU can cause codel_dequeue() to drop all packets. The parent qdisc's
> sch->q.qlen is only updated via ->qlen_notify() if the fq_codel queue
> remains non-empty after the drops. This discrepancy in qlen between
> fq_codel and its parent can lead to a use-after-free condition.
>
> Let's fix this by making all existing ->qlen_notify() idempotent so that
> the sch->q.qlen check will be no longer necessary.
>
> Patch 1~5 make all existing ->qlen_notify() idempotent to prepare for
> patch 6 which removes the sch->q.qlen check. They are followed by 5
> selftests for each type of Qdisc's we touch here.
>
> All existing and new Qdisc selftests pass after this patchset.
>
> Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
>

For the patches:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

